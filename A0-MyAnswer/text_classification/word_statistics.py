# -*- coding=utf-8 -*-
import os
import numpy as np
import math
# ham is 0
# spam is 1
document_dirs = [
    '/资料/课件/机器学习/作业/homework1/hw1_data/train/ham',
    '/资料/课件/机器学习/作业/homework1/hw1_data/train/spam',
    '/资料/课件/机器学习/作业/homework1/hw1_data/test/ham',
    '/资料/课件/机器学习/作业/homework1/hw1_data/test/spam'
]
def get_one_file_word_set(txt_path):
    filed = open(txt_path)
    # filter(func, arr) 从数组中选出满足条件的值
    txt_arr = set(filter(lambda x: x.isalpha() and len(x) > 1, filed.read().lower().split()))
    return txt_arr

def get_files_word_set(txt_paths):
    words = set()
    for txt_path in txt_paths:
        cur_words = get_one_file_word_set(txt_path)
        words = words.union(cur_words)  # 集合之间做交集
        # print len(words)
    print words
    return words

def save_word_set(save_path):
    '''
    将得到的字典的集合保存下来，节省时间
    :param save_path: 保存的路径
    :return: None
    '''
    paths = []
    for document_dir in document_dirs:
        names = os.listdir(document_dir)
        paths.extend(
            [os.path.join(document_dir, name) for name in names]
        )
    print paths
    words = get_files_word_set(paths)
    lines = []
    for item in zip(list(words), range(len(words))):
        line = item[0] + ' ' + str(item[1]) + '\n'
        lines.append(line)
    filed = open(save_path, 'w')
    filed.writelines(lines)
    filed.close()

def get_word_distribution_one_file(txt_file, word_dict):
    '''
    统计一个文件中所有单词出现的次数
    :param txt_file: 文件的路径
    :param word_dict: 词汇表
    :return: 一个特征向量，代表该文件中出现的所有单词的次数
    '''
    word_vec = np.zeros(len(word_dict))
    # word_vec = np.ones(len(word_dict))  # 为了防止出现过多的0，这里我们默认起始值是1
    filed = open(txt_file)
    txt_arr = set(filter(lambda x: x.isalpha() and len(x) > 1, filed.read().lower().split()))
    for word in txt_arr:
        word_vec[word_dict[word]] += 1
    return word_vec

def get_word_distribution_one_dir(dir_name, word_dict):
    '''
    统计一个文件夹中所有文件中所有单词出现的次数
    :param dir_name: 文件夹的路径
    :param word_dict: 词汇表
    :return: 二维向量，n*m n代表的是样本的个数（文件的个数）m代表的是特征向量的纬度
    '''
    names = os.listdir(dir_name)
    paths = [os.path.join(dir_name, name) for name in names]
    word_vecs = np.zeros([len(paths), len(word_dict)])
    for index, path in enumerate(paths):
        word_vecs[index, :] = get_word_distribution_one_file(path, word_dict)
    return word_vecs

def generate_word_dict(path):
    '''
    根据txt文件返回word dict
    :param path: txt path
    :return: word_dict
    '''
    filed = open(path)
    lines = filed.readlines()
    filed.close()
    word_dict = {}
    for line in lines:
        splited_arr = line.split(' ')
        word = splited_arr[0]
        index = int(splited_arr[1])
        word_dict[word] = index
    return word_dict

def cal_positive_prob():
    '''
    计算垃圾邮件出现的概率
    :return: 概率
    '''
    ham_dir = document_dirs[0]
    spam_dir = document_dirs[1]
    return (1.0 * len(os.listdir(spam_dir))) / (1.0 * (len(os.listdir(spam_dir)) + len(os.listdir(ham_dir))))

def cal_p_cx(word_dict):
    '''
    计算给定类别情况下，每个单词的出现概率
    :param word_dict: 词典
    :return: 2*len(word_dict)的数组，第一行代表的是正常邮件中词汇出现的概率，第二行代表的是侮辱性邮件
    '''
    ham_dir = document_dirs[0]
    spam_dir = document_dirs[1]
    word_vec0 = get_word_distribution_one_dir(ham_dir, word_dict)   # 训练集-正常邮件的词汇分布统计
    word_vec0 = np.sum(word_vec0, axis=0)
    print np.shape(word_vec0)
    word_vec1 = get_word_distribution_one_dir(spam_dir, word_dict)  # 训练集-侮辱性邮件的词汇分布统计
    word_vec1 = np.sum(word_vec1, axis=0)
    print np.shape(word_vec0)
    word_vecs = np.array([word_vec0, word_vec1])
    print 'word vecs shape: ',np.shape(word_vecs)
    propability_cx = np.zeros([2, len(word_dict)], np.float32)  # 给定样本类别的情况下 词汇出现的概率
    for i in range(2):
        # 在这里之所以加1，是为了防止出现0的情况
        propability_cx[i] = (1.0 * (word_vecs[i] + 1)) / (2 + np.sum(word_vecs[i]))
    return propability_cx

def cal_first_answer():
    word_dict = generate_word_dict('/资料/课件/机器学习/作业/homework1/text_classification/word_dict.txt')
    p_cx = cal_p_cx(word_dict)
    import heapq
    rate = []
    for i in range(np.shape(p_cx)[1]):
        rate.append(p_cx[1, i] / p_cx[0, i])
    indexs = heapq.nlargest(10, range(len(rate)), rate.__getitem__)
    indexs_dict = {}
    for key, value in word_dict.iteritems():
        if value in indexs:
            indexs_dict[value] = key
    top_words = []
    for index in indexs:
        top_words.append(indexs_dict[index])
    print 'top 10 words are: ', top_words
cal_first_answer()