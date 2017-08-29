From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/18] perf stat: Fix path to PMU formats in documentation
Date: Tue, 29 Aug 2017 16:42:37 -0300
Message-ID: <20170829194254.1338-2-acme@kernel.org>
References: <20170829194254.1338-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170829194254.1338-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jack Henschel <jackdev@mailbox.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, trivial@kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jack Henschel <jackdev@mailbox.org>

As defined in tools/perf/util/pmu.c, the EVENT_SOURCE_DEVICE_PATH is
/sys/bus/event_source/devices/ (no traling 's' in event_source)

This patch corrects the path in the perf stat documentation

Signed-off-by: Jack Henschel <jackdev@mailbox.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jack Henschel <jackdev@mailbox.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: trivial@kernel.org
Link: http://lkml.kernel.org/r/20170824132022.10934-1-jackdev@mailbox.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-stat.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 698076313606..c37d61682dfb 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -41,13 +41,13 @@ report::
 
 	- a symbolically formed event like 'pmu/param1=0x3,param2/' where
 	  param1 and param2 are defined as formats for the PMU in
-	  /sys/bus/event_sources/devices/<pmu>/format/*
+	  /sys/bus/event_source/devices/<pmu>/format/*
 
 	- a symbolically formed event like 'pmu/config=M,config1=N,config2=K/'
 	  where M, N, K are numbers (in decimal, hex, octal format).
 	  Acceptable values for each of 'config', 'config1' and 'config2'
 	  parameters are defined by corresponding entries in
-	  /sys/bus/event_sources/devices/<pmu>/format/*
+	  /sys/bus/event_source/devices/<pmu>/format/*
 
 -i::
 --no-inherit::
-- 
2.13.5
