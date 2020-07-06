From: Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 0/3] perf bench numa: fix few minor issues
Date: Mon,  6 Jul 2020 11:42:51 +0200
Message-ID: <cover.1594028310.git.agordeev@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Hi all,

Please, find couple of fixes to the tool. Note, I did not bother
fixing leaked memory allocated with numa_allocate_cpumask().

Alexander Gordeev (3):
  perf bench numa: fix incorrect NUMA toplogy assumption
  perf bench numa: fix benchmark names
  perf bench numa: fix wrong benchmark configuration

 tools/perf/bench/numa.c | 72 ++++++++++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 37 deletions(-)

-- 
1.8.3.1
