

-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 11, 2024 at 04:04 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bookstore`
--
CREATE DATABASE IF NOT EXISTS `bookstore` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `bookstore`;
CREATE TABLE TAI_KHOAN (
    ma_tk VARCHAR(20) PRIMARY KEY,
    ten_dang_nhap VARCHAR(50) UNIQUE,
    mat_khau VARCHAR(255),
    ngay_tao DATE,
    lan_dang_nhap_cuoi DATE,
    trang_thai VARCHAR(20),
    ma_KH VARCHAR(20),
);
CREATE TABLE KHACH_HANG (
    ma_KH VARCHAR(20) PRIMARY KEY,
    ten_kh VARCHAR(100),
    email VARCHAR(100),
    so_dien_thoai VARCHAR(15),
    dia_chi TEXT,
    CCCD VARCHAR(20),
    ngay_sinh DATE,
    gioi_tinh VARCHAR(10),
    ma_tk VARCHAR(20) ,
    FOREIGN KEY (ma_tk) REFERENCES TAI_KHOAN(ma_tk)
);

CREATE TABLE TAU (
    ma_tau VARCHAR(20) PRIMARY KEY,
    ten_tau VARCHAR(100),
    loai_tau VARCHAR(50),
    so_toa INT,
    suc_chua INT,
    trang_thai VARCHAR(20) -- đang hoạt động, bảo trì, ngưng hoạt động
);
CREATE TABLE QUAN_TRI (
    ma_admin VARCHAR(20) PRIMARY KEY,
    ten_admin VARCHAR(100),
    vai_tro VARCHAR(50),
    email VARCHAR(100),
    so_dien_thoai VARCHAR(15),
    ma_tk VARCHAR(20) UNIQUE,
    FOREIGN KEY (ma_tk) REFERENCES TAI_KHOAN(ma_tk)
);
CREATE TABLE TUYEN_DUONG (
    ma_tuyen VARCHAR(20) PRIMARY KEY,
    diem_di VARCHAR(100),
    diem_den VARCHAR(100),
    nha_ga VARCHAR(100),
    quang_duong INT,
    thoi_gian_du_kien TIME
);
CREATE TABLE LICH_TRINH (
    ma_lich_trinh VARCHAR(20) PRIMARY KEY,
    gio_di TIME,
    gio_den TIME,
    ngay_di DATE,
    ngay_den DATE,
    loai_lich_trinh VARCHAR(50),
    trang_thai VARCHAR(50),
    ma_tau VARCHAR(20),
    FOREIGN KEY (ma_tau) REFERENCES TAU(ma_tau)
);
CREATE TABLE CHO_NGOI (
    ma_cho_ngoi VARCHAR(20) PRIMARY KEY,
    ma_lich_trinh VARCHAR(20),
    ma_tuyen VARCHAR(20),
    ma_ghe VARCHAR(10),
    toa_so INT,
    loai_cho VARCHAR(50), -- ghế mềm, ghế cứng, giường nằm
    gia_ve DECIMAL(10,2),
    trang_thai VARCHAR(20),
    FOREIGN KEY (ma_lich_trinh) REFERENCES LICH_TRINH(ma_lich_trinh),
    FOREIGN KEY (ma_tuyen) REFERENCES TUYEN_DUONG(ma_tuyen)
);
CREATE TABLE VE (
    ma_ve VARCHAR(20) PRIMARY KEY,
    ngay_dat DATE,
    so_ghe INT,
    hinh_thuc_dat VARCHAR(50), -- online, tại quầy
    trang_thai VARCHAR(20),
    ma_KH VARCHAR(20),
    ma_cho_ngoi VARCHAR(20),
    FOREIGN KEY (ma_KH) REFERENCES KHACH_HANG(ma_KH),
    FOREIGN KEY (ma_cho_ngoi) REFERENCES CHO_NGOI(ma_cho_ngoi)
);
CREATE TABLE THANH_TOAN (
    ma_thanh_toan VARCHAR(20) PRIMARY KEY,
    so_tien DECIMAL(10,2),
    ngay_thanh_toan DATE,
    phuong_thuc VARCHAR(50), -- chuyển khoản, ví điện tử, thẻ tín dụng
    trang_thai VARCHAR(50), -- đã thanh toán, đang xử lý, thất bại
    ma_ve VARCHAR(20),
    FOREIGN KEY (ma_ve) REFERENCES VE(ma_ve)
);
CREATE TABLE HOA_DON (
    ma_hoa_don VARCHAR(20) PRIMARY KEY,
    ngay_lap DATE,
    tong_tien DECIMAL(10,2),
    ngay_tao DATE,
    hinh_thuc VARCHAR(50), -- cá nhân/doanh nghiệp
    ma_KH VARCHAR(20),
    ma_ve VARCHAR(20),
    FOREIGN KEY (ma_KH) REFERENCES KHACH_HANG(ma_KH),
    FOREIGN KEY (ma_ve) REFERENCES VE(ma_ve)
);
CREATE TABLE QUAN_LY_LICH_TRINH (
    ma_admin VARCHAR(20),
    ma_lich_trinh VARCHAR(20),
    ngay_phan_cong DATE,
    PRIMARY KEY (ma_admin, ma_lich_trinh),
    FOREIGN KEY (ma_admin) REFERENCES QUAN_TRI(ma_admin),
    FOREIGN KEY (ma_lich_trinh) REFERENCES LICH_TRINH(ma_lich_trinh)
);
