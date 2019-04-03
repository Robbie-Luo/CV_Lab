close all;clear all;clc;
addpath 'tSNE_matlab'
% [net, info, expdir] = finetune_cnn();
load('data/pre_trained_model.mat');
layers=net.layers

