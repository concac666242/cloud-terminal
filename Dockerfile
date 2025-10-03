# Dockerfile
FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive
# Cài shellinabox và dọn cache apt
RUN apt-get update \
 && apt-get install -y --no-install-recommends shellinabox \
 && rm -rf /var/lib/apt/lists/*

# Port nội bộ mà container sẽ lắng nghe (mặc định Render cung cấp $PORT)
EXPOSE 8080
ENV PORT=8080

# Chạy shellinaboxd ở foreground (--background=0) và tắt SSL (Render sẽ terminate TLS ở edge)
# --no-beep : tắt âm bíp
# --disable-ssl : vô hiệu hóa SSL bên trong container (Render xử lý TLS)
# --port ${PORT} : lắng nghe cổng được Render chỉ định
# -s /:LOGIN : publish dịch vụ login mặc định (hiển thị form login)
CMD ["sh", "-c", "exec shellinaboxd --no-beep --disable-ssl --port ${PORT} --background=0 -s /:LOGIN"]
