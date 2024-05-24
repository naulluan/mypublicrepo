#!/bin/bash

# Get a list of all SQS queues
queues=$(aws sqs list-queues --query 'QueueUrls' --output text)

# Check if there are any queues
if [ -z "$queues" ]; then
  echo "No SQS queues found."
  exit 1
fi

# Iterate over each queue and get its access policy
for queue_url in $queues; do
  echo "Queue URL: $queue_url"

  # Get the access policy for the queue
  policy=$(aws sqs get-queue-attributes --queue-url "$queue_url" --attribute-names Policy --query 'Attributes.Policy' --output text)

  if [ -z "$policy" ]; then
    echo "No access policy found for this queue."
  else
    echo "Access Policy: $policy"
  fi

  echo "---------------------------------------"
done
