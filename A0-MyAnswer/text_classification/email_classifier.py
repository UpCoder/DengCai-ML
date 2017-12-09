# -*- coding=utf-8 -*-
from word_statistics import *

def cal_p_x(vec, p_cx, positive_prob):
    '''
    p(c|x) 计算给定一个词汇特征向量（x）下，他是c类别的概率
    利用贝叶斯公司，我们可以将其转化为p(x|c)p(c) / p(x),
    由于我们假设各个单词是独立出现的，所以p(x|c) = p(x0,x1,x2...,xn|c) = p(x0|c)p(x1|c)...p(xn|c)
    上述的p(xi|c)就是给定类别c的条件下，单词i出现的概率
    对于我们的类别判断来说，我们不需要知道p(x),以二分类为例，p(c=0|x) 和 p(c=1|x) 他们的不同只在于p(x|c=0)p(c=0)与p(x|c=1)p(c=1)之间
    由于我们的x
    :param vec 需要判断类别的特征向量
    :param p_cx 先验条件概率
    :param positive_prob 垃圾邮件的概率
    :return:
    '''
    # 由于至今进行乘法，可能会导致下溢出，所以我们进行log操作
    p_cx = np.array(p_cx)
    p1 = np.sum(np.log(p_cx[1]) * vec) + math.log(positive_prob)
    p0 = np.sum(np.log(p_cx[0]) * vec) + math.log(1 - positive_prob)
    if p1 > p0:
        return 1
    else:
        return 0

def cal_accuracy(ham_dir, spam_dir):
    '''
    计算准确率
    :param spam_dir: 垃圾邮件的文件夹
    :param ham_dir: 正常邮件的文件夹
    :return: 准确率
    '''
    error_count = 0
    word_dict_txt = './word_dict.txt'
    word_dict = generate_word_dict(word_dict_txt)
    p_cx = cal_p_cx(word_dict)
    positive_prob = cal_positive_prob()
    true_labels = []
    predict_labels = []
    ham_distribution = get_word_distribution_one_dir(dir_name=ham_dir, word_dict=word_dict)
    for vec in ham_distribution:
        predict_label = cal_p_x(vec, p_cx, positive_prob)
        predict_labels.append(predict_label)
        if predict_label != 0:
            error_count += 1
    true_labels.extend([0] * len(ham_distribution))
    spam_distribution = get_word_distribution_one_dir(dir_name=spam_dir, word_dict=word_dict)
    for vec in spam_distribution:
        predict_label = cal_p_x(vec, p_cx, positive_prob)
        predict_labels.append(predict_label)
        if predict_label != 1:
            error_count += 1
    true_labels.extend([1] * len(spam_distribution))
    accuracy = (1 - (1.0 * error_count) / (len(ham_distribution) + len(spam_distribution)))
    print 'Accuracy: ', accuracy
    return accuracy, np.array(true_labels), np.array(predict_labels)

def cal_precision(label, predict):
    tp = np.sum(np.logical_and(label == 1, predict == 1)) * 1.0
    fp = np.sum(np.logical_and(label == 1, predict == 0)) * 1.0
    print 'tp: ', tp
    print 'fp: ', fp
    return tp / (tp + fp)

def cal_recall(label, predict):
    tp = np.sum(np.logical_and(label == 1, predict == 1)) * 1.0
    fn = np.sum(np.logical_and(label == 0, predict == 1)) * 1.0
    print 'tp: ', tp
    print 'fn: ', fn
    return tp / (tp + fn)

acc, true_label, predict_label = cal_accuracy(
    ham_dir=document_dirs[2],
    spam_dir=document_dirs[3]
)
precision = cal_precision(true_label, predict_label)
recall = cal_recall(true_label, predict_label)
print 'Precision: ', precision
print 'Recall: ', recall
# cal_first_answer(p_cx, word_dict)