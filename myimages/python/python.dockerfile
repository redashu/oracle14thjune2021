FROM python
# starndard python image 
MAINTAINER  ashutoshh
RUN  mkdir  /code
COPY hello.py  /code/
WORKDIR /code
CMD ["python","hello.py"]
# here python is default python 3
