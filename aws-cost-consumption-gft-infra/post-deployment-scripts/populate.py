import os
import boto3
import psycopg2
import logging
import logging.handlers
import sys
import boto3
import os

logging.basicConfig(filename="logname",
                    filemode='a',
                    format='%(asctime)s,%(msecs)d %(name)s %(levelname)s %(message)s',
                    datefmt='%H:%M:%S',
                    level=logging.DEBUG)

ENDPOINT=""
PORT=""
USER=""
REGION=""
DBNAME="" 
PASS=""
              
            

def create_table():
    ssm_client = boto3.client('ssm')

    logger = logging.getLogger('INIT-DB')
    logger.setLevel(logging.INFO)
    with psycopg2.connect(f"host={ENDPOINT} dbname={DBNAME} user={USER} password={PASS} ") as conn:
            with conn.cursor() as cur:        
                cur.execute("""CREATE TABLE public.customer (
                            client_id SERIAL UNIQUE,
                            client_name varchar NOT NULL,
                            project varchar NOT NULL,
                            environment varchar NOT NULL,
                            total_aws_accounts int4 NOT NULL,
                            description varchar NULL,
                            CONSTRAINT customer_un UNIQUE (client_name, project)
                        );

                        CREATE TABLE public.services (
                            service_id SERIAL UNIQUE,
                            client_id int8 not NULL,
                            aws_services varchar NULL,
                            time_period_start date NOT NULL,
                            time_period_end date NOT NULL,
                            value numeric NOT NULL,
                            additional_comments varchar NULL,
                            CONSTRAINT customer_service_fk foreign key (client_id) references public.customer(client_id)
                        );

                        CREATE TABLE public.forecast (
                            forecast_id SERIAL UNIQUE,
                            client_id int8 not NULL,
                            time_period_start date NOT NULL,
                            time_period_end date NOT NULL,
                            amount numeric NOT NULL,
                            additional_comments varchar NULL,
                            CONSTRAINT customer_forecast_fk foreign key (client_id) references public.customer(client_id),
                            CONSTRAINT forecast_un UNIQUE (client_id, time_period_start,time_period_end)

                        );
                        
                        """)
                        


    # sql_insert_values = """
    #     INSERT INTO customers (client_name) VALUES ("Hello World");
    # """
        
#gets the credentials from .aws/credentials
session = boto3.Session()
client = session.client('rds')

try:
    conn = psycopg2.connect(host=ENDPOINT, port=PORT, database=DBNAME, user=USER, password=PASS, sslrootcert="SSLCERTIFICATE")
    cur = conn.cursor()
    cur.execute("""SELECT now()""")
    create_table()
    query_results = cur.fetchall()
    print(query_results)
except Exception as e:
    print("Database connection failed due to {}".format(e))  
finally:
        # closing database connection.
        if conn:
            conn.commit()
            cur.close()
            conn.close()
            print("PostgreSQL connection is closed")