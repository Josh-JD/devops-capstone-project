#Use Python as the run image
FROM python:3.9-slim

#Create a directory where the code will be placed
WORKDIR /app 

#Copy the requirement file from local machine to docker directory
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY service/ ./service/

#Add user theia and change /app ownership
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

#Expose port and create CMD statement
EXPOSE 8080
CMD ["gunicorn", "--bind-0.0.0.0:8080", "--log-level-info", "service:app"]
