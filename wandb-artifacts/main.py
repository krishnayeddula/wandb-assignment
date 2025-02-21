import random
import math
import wandb

# Launch 10p simulated experiments
total_runs = 10
for run in range(total_runs):
  # 1️. Start a new run to track this script
  wandb.init(
      # Set the project where this run will be logged
      project="wandb-assignment",
      name=f"run_{run}",
      config={
      "learning_rate": 0.02,
      "architecture": "CNN",
      "dataset": "CIFAR-100",
      "epochs": 10,
      })

  epochs = 10
  offset = random.random() / 5
  for epoch in range(2, epochs):
      acc = 1 - 2 ** -epoch - random.random() / epoch - offset
      loss = 2 ** -epoch + random.random() / epoch + offset
      wandb.log({"acc": acc, "loss": loss})

  # Mark the run as finished
  wandb.finish()