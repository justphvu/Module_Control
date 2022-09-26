### Tóm tắt

Ngày nay khái niệm Drone đã không còn xa lạ với bất cứ ai có nhu cầu tìm hiểu về thiết bị bay điểu khiển từ xa.

Dự án được tạo ra với mục đích mô phỏng bộ điều khiển Drone dựa trên những thông số, đại lượng của Drone và những phương pháp toán học tính toán cũng như là cải thiện những sai số động cơ trong thực tế.

Dự án được khởi tạo, và thử nghiệm trên trình Octave (mini Matlab) và Clion (nền tảng C++)

Lời khuyên dành cho người đọc:
      
      Hãy bắt đàu với những thư mục МАТ МОДЕЛЬ КВАДРОКОПТЕРА từ 1 đến n, đọc, hiểu code và tài liệu đính kèm bên trong (dựa trên chúng, code được viết ra)
      
      Bên cạnh đó những tài liệu bên ngoài cũng giúp ích cho việc khái quát dự án tổng


Tại 3 МАТ МОДЕЛЬ КВАДРОКОПТЕРА (và МАТ МОДЕЛЬ КВАДРОКОПТЕРА_3++) đầu, chúng ta bắt đầu với bộ điều khiển đơn giản, nơi mà bước đầu là nhận gía trị U (tại MAT_1 + 2 cố định và sau là thay đổi theo từng đợt đo), cũng như khởi tạo I0, w0, dw0. Đặt chúng vào bộ điều khiển PID, thu được các gía trị U, I, w ,dw mới, và lại quay lại đặt lại vào PID. Vậy ta thu được một lòng lặp đo cho tới khi thời gian t chạy hết một cơ số lầ dt đã đặt gia từ đầu. Sự thay đổi U,I,w được biểu thị theo dạng đồ thị. Ta thấy được đồ thị có dạng sóng, dao động hẹp dần về một gía trị mong muốn (đặt tại Xd[] tại funtion MODELING)

##### Việc đặt những gía trị mốc cho I, w, dw cũng như là t đầu, cuối là vô cùng quan trọng, nó giups ta cải thiện tốc độ hoàn thành của bộ điều khiển. Hãy thực hành đo lường nhiều để có được quy chuẩn của bản thân.
