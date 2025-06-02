FROM python:3.11

# Prevent Python from buffering stdout and stderr
ENV PYTHONUNBUFFERED=1

COPY . /app
WORKDIR /app

RUN pip install --no-cache-dir -r requirements.txt

CMD ["python", "-m", "starter.program"]
