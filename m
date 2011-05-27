From: David Ahern <dsahern@gmail.com>
Subject: perf, H/W counters - ESX hosted VM
Date: Fri, 27 May 2011 13:33:54 -0600
Message-ID: <4DDFFCA2.8030100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39876 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932098Ab1E0Td4 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 27 May 2011 15:33:56 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>


Has anyone successfully used perf within an ESX VM? dmesg shows a PMU is
discovered:

dmesg | grep -i performance
Performance Events: Nehalem/Corei7 events, Intel PMU driver.

yet data from it is nonsensical:

perf stat -v -- /tmp/a

task-clock-msecs: 20593318 20593318 20593318
context-switches: 2 20593318 20593318
CPU-migrations: 0 20593318 20593318
page-faults: 387 20593318 20593318
cycles: 10737418235 20593318 20593318
instructions: 10737418235 20593318 20593318
cache-references: 10737418235 20593318 20593318
cache-misses: 10737418235 20593318 20593318

 Performance counter stats for '/tmp/a':

      20.593318  task-clock-msecs         #      0.988 CPUs
              2  context-switches         #      0.000 M/sec
              0  CPU-migrations           #      0.000 M/sec
            387  page-faults              #      0.019 M/sec
    10737418235  cycles                   # 521403.022 M/sec
    10737418235  instructions             #      1.000 IPC
    10737418235  cache-references         # 521403.022 M/sec
    10737418235  cache-misses             # 521403.022 M/sec

    0.020837863  seconds time elapsed

David

/tmp/a  -- a step above 'sleep 1'

#!/bin/sh

declare -i i=0;
declare -i sum=0;
while [ $i -lt 1000 ]
do
	sum=$((sum + i))
    i=$((i+1))
done
echo "sum $sum"
