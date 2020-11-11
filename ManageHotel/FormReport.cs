﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Windows.Forms;

namespace ManageHotel
{
    public partial class FormReport : Form
    {
        private ManageHotelEntities entities = fRoomCategories.entities;
        public FormReport()
        {
            InitializeComponent();
            //truy vấn lấy danh sách tất cả các tháng (có thể trùng lặp)
            List<int> rawMonth = entities.RoomHistories.Select(p => p.rentedDay.Value.Month).ToList();
            List<int> month = new List<int>();
            foreach (int element in rawMonth)   //dùng vòng foreach để chọn lại các tháng (không trùng)
                if (!month.Contains(element))
                    month.Add(element);
            month.Sort();   //sắp xếp lại các tháng theo thứ tự tăng dần
            cbMonthRevenue.DataSource = month;  //đổ danh sách tháng vào comboBox
            cbMonthDensity.DataSource = month;
        }

        #region Functions for event
        private void RefreshRevenueTab(string month)    //làm mới dữ liệu bảng báo cáo doanh thu theo loại phòng
        {
            List<ReportRevenue> sources = new List<ReportRevenue>();
            List<string> category = fRoomCategories.kindAndPrice.Keys.ToList(); //lấy danh sách các loại phòng
            float total = 0;    //tổng doanh thu

            for (int i = 0; i < category.Count; i++)    //traverse hết danh mục phần
            {
                string kind = category[i];  //danh mục hiện tại
                List<RoomHistory> histories = (from p in entities.RoomHistories
                                              where p.kind == kind && p.rentedDay.Value.Month.ToString() == month
                                              select p).ToList();   //truy vấn đúng danh mục hiện tại

                ReportRevenue currentRoom = new ReportRevenue();
                currentRoom.Id = i + 1; //tạo cột số thứ tự
                currentRoom.Kind = kind;
                foreach (RoomHistory room in histories) //tính tổng doanh thu của danh sách phòng hiện tại
                    currentRoom.Revenue += (float)room.total;
                total += currentRoom.Revenue;

                sources.Add(currentRoom);
            }
            foreach  (ReportRevenue item in sources)    //tính tỷ lệ bằng cách chia doanh thu theo loại phòng cho tổng doanh thu
                item.Ratio = (float)Math.Round(item.Revenue / total * 100, 2);

            //đổ dữ liệu vào DataGridView, đặt tên cho tiêu đề của các cột
            dgvRevenue.DataSource = sources;
            dgvRevenue.Columns[0].HeaderText = "Số thứ tự";
            dgvRevenue.Columns[1].HeaderText = "Loại phòng";
            dgvRevenue.Columns[2].HeaderText = "Doanh thu";
            dgvRevenue.Columns[3].HeaderText = "Tỷ lệ";
        }

        private void RefreshDensityTab(string month)    //làm mới dữ liệu bảng báo cáo số ngày thuê theo phòng
        {
            List<ReportDensity> sources = new List<ReportDensity>();
            List<string> tempRoomName = entities.RoomHistories.Select(p => p.name).ToList(); //lấy danh sách tên phòng (có thể trùng)
            List<string> roomName = new List<string>();

            foreach (string name in tempRoomName)   //lọc lại các tên phòng (duy nhất)
                if (!roomName.Contains(name))
                    roomName.Add(name);

            int total = 0;  //tổng số ngày thuê phòng
            for (int i = 0; i < roomName.Count; i++)    //traverse hết danh sách tên phòng
            {
                string name = roomName[i];  //tên hiện tại
                List<RoomHistory> histories = (from p in entities.RoomHistories
                                               where p.name == name && p.rentedDay.Value.Month.ToString() == month
                                               select p).ToList();  //truy vấn đúng phòng hiện tại

                ReportDensity currentRoom = new ReportDensity();
                currentRoom.Id = i + 1; //tạo cột số thứ tự
                currentRoom.Name = name;
                foreach (RoomHistory room in histories) //tính tổng số ngày thuê của phòng hiện tại
                    currentRoom.CountRented += (int)room.countRented;
                total += currentRoom.CountRented;   //tính tổng số ngày thuê của tất cả các phòng

                sources.Add(currentRoom);
            }
            foreach (ReportDensity item in sources) //tính tỷ lệ của từng phòng
                item.Ratio = (float)Math.Round((float)item.CountRented / total * 100, 2);

            //đổ dữ liệu vào DataGridView, đặt tên cho tiêu đề của các cột
            dgvDensity.DataSource = sources;
            dgvDensity.Columns[0].HeaderText = "Số thứ tự";
            dgvDensity.Columns[1].HeaderText = "Phòng";
            dgvDensity.Columns[2].HeaderText = "Số ngày thuê";
            dgvDensity.Columns[3].HeaderText = "Tỷ lệ";
        }
        #endregion

        #region Events
        private void cbMonth_SelectedValueChanged(object sender, EventArgs e)   //sự kiện thay đổi giá trị của cbMonth của tab Doanh thu
        {
            RefreshRevenueTab(cbMonthRevenue.SelectedValue.ToString());
        }

        private void cbMonthDensity_SelectedValueChanged(object sender, EventArgs e)    //sự kiện thay đổi giá trị của cbMonth của tab Mật độ
        {
            RefreshDensityTab(cbMonthDensity.SelectedValue.ToString());
        }
        #endregion
    }

    #region Supportive classes definitions
    public class ReportRevenue  //lớp báo cáo doanh thu theo loại phòng
    {
        private int id;
        private string kind;
        private float revenue;
        private float ratio;

        public ReportRevenue(int id = 0, string kind = "", float revenue = 0, float ratio = 0)
        {
            this.id = id;
            this.kind = kind;
            this.revenue = revenue;
            this.ratio = ratio;
        }

        public ReportRevenue(ReportRevenue report)
        {
            id = report.id;
            kind = report.kind;
            revenue = report.revenue;
            ratio = report.ratio;
        }

        public int Id { get => id; set => id = value; }
        public string Kind { get => kind; set => kind = value; }
        public float Revenue { get => revenue; set => revenue = value; }
        public float Ratio { get => ratio; set => ratio = value; }
    }

    public class ReportDensity  // lớp báo cáo số ngày thuê theo phòng
    {
        private int id;
        private string name;
        private int countRented;
        private float ratio;

        public ReportDensity(int id = 0, string name = "", int countRented = 0, float ratio = 0)
        {
            this.id = id;
            this.name = name;
            this.countRented = countRented;
            this.ratio = ratio;
        }

        public ReportDensity(ReportDensity report)
        {
            id = report.id;
            name = report.name;
            countRented = report.countRented;
            ratio = report.ratio;
        }

        public int Id { get => id; set => id = value; }
        public string Name { get => name; set => name = value; }
        public int CountRented { get => countRented; set => countRented = value; }
        public float Ratio { get => ratio; set => ratio = value; }
    }
    #endregion
}