From: sathnaga@linux.vnet.ibm.com
Subject: [PATCH v4 0/1] Fixup for discontiguous/sparse numa nodes
Date: Wed, 22 Nov 2017 13:13:34 +0530
Message-ID: <1511336614-15283-1-git-send-email-sathnaga@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43070 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751371AbdKVHny (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Nov 2017 02:43:54 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAM7eG8C144904
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Nov 2017 02:43:53 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ed4jhh9rh-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Nov 2017 02:43:53 -0500
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <sathnaga@linux.vnet.ibm.com>;
        Wed, 22 Nov 2017 07:43:51 -0000
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: srikar@linux.vnet.ibm.com, bala24@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

Certain systems would have sparse/discontinguous
numa nodes.
perf bench numa doesnt work well on such nodes.
1. It shows wrong values.
2. It can hang.
3. It can show redundant information for non-existant nodes.

 #numactl -H
available: 2 nodes (0,8)
node 0 cpus: 0 1 2 3 4 5 6 7
node 0 size: 61352 MB
node 0 free: 57168 MB
node 8 cpus: 8 9 10 11 12 13 14 15
node 8 size: 65416 MB
node 8 free: 36593 MB
node distances:
node   0   8
  0:  10  40
  8:  40  10

Scenario 1:

Before Fix:
 # perf bench numa mem --no-data_rand_walk -p 2 -t 20 -G 0 -P 3072 -T 0 -l 50 -c -s 1000
...
...
 # 40 tasks will execute (on 9 nodes, 16 CPUs): ----> Wrong number of nodes
...
 #    2.0%  [0.2 mins]  1/1   0/0   0/0   0/0   0/0   0/0   0/0   0/0   4/1  [ 4/2 ] l:  0-0   (  0) ----> Shows info on non-existant nodes.

After Fix:
 # ./perf bench numa mem --no-data_rand_walk -p 2 -t 20 -G 0 -P 3072 -T 0 -l 50 -c -s 1000
...
...
 # 40 tasks will execute (on 2 nodes, 16 CPUs):
... 
 #    2.0%  [0.2 mins]  9/1   0/0  [ 9/1 ] l:  0-0   (  0)
 #    4.0%  [0.4 mins] 21/2  19/1  [ 2/3 ] l:  0-1   (  1) {1-2}

Scenario 2:

Before Fix:
 # perf bench numa all
 # Running numa/mem benchmark...
....
...
 # Running RAM-bw-remote, "perf bench numa mem -p 1 -t 1 -P 1024 -C 0 -M 1 -s 20 -zZq --thp  1 --no-data_rand_walk"
perf: bench/numa.c:306: bind_to_memnode: Assertion `!(ret)' failed. ------------> Got hung

After Fix:
 # ./perf bench numa all
 # Running numa/mem benchmark...
....
...
 # Running RAM-bw-remote, "perf bench numa mem -p 1 -t 1 -P 1024 -C 0 -M 1 -s 20 -zZq --thp  1 --no-data_rand_walk"

 # NOTE: ignoring bind NODEs starting at NODE#1
 # NOTE: 0 tasks mem-bound, 1 tasks unbound
         20.017 secs slowest (max) thread-runtime
         20.000 secs fastest (min) thread-runtime
         20.006 secs average thread-runtime
          0.043 % difference between max/avg runtime
        413.794 GB data processed, per thread
        413.794 GB data processed, total
          0.048 nsecs/byte/thread runtime
         20.672 GB/sec/thread speed
         20.672 GB/sec total speed

Changes in v2:
Fixed review comments for function names and alloc failure handle

Changes in v3:
Coding Style fixes.

Changes in v4:
Address review comments from Naveen and Arnaldo.
Merge two commits into single.


Satheesh Rajendran (1):
  perf/bench/numa: Handle discontiguous/sparse numa nodes

 tools/perf/bench/numa.c | 57 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 51 insertions(+), 6 deletions(-)

-- 
2.7.4
