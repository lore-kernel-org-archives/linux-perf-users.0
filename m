From: ufo19890607 <ufo19890607@gmail.com>
Subject: [PATCH 0/1] perf stat: Add support to print counts for fixed times
Date: Wed, 17 Jan 2018 13:37:24 +0100
Message-ID: <1516192645-27187-1-git-send-email-ufo19890607@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com, adrian.hunter@intel.com, wangnan0@huawei.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com
List-Id: linux-perf-users.vger.kernel.org

From: yuzhoujian <yuzhoujian@didichuxing.com>

Introduce a new option to print counts for fixed number of times
and update perf-stat documentation accordingly.

Show below is the output of the new option for perf stat.

	$perf stat -I 1000 --times-print 2 -e cycles -a
	#           time             counts unit events
	     1.002827089         93,884,870      cycles
             2.004231506         56,573,446      cycles

We can just print the counts for several times with this newly introduced
option. The usage of it is a little like vmstat.

        $ vmstat -n 1 2 
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
 0  0      0 78270544 547484 51732076    0    0     0    20    1    1  1  0 99  0  0
 0  0      0 78270512 547484 51732080    0    0     0    16  477 1555  0  0 100  0  0

yuzhoujian (1):
  perf stat: Add support to print counts for fixed times

 tools/perf/Documentation/perf-stat.txt |  5 +++++
 tools/perf/builtin-stat.c              | 13 +++++++++++++
 tools/perf/util/stat.h                 |  1 +
 3 files changed, 19 insertions(+)

-- 
2.14.1
