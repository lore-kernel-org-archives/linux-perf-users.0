From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/13] perf intel-pt: Fix syntax in documentation of config option
Date: Mon,  4 Sep 2017 11:00:36 -0300
Message-ID: <20170904140044.22912-6-acme@kernel.org>
References: <20170904140044.22912-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170904140044.22912-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jack Henschel <jackdev@mailbox.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jack Henschel <jackdev@mailbox.org>

As specified in tools/perf/Documentation/perf-config.txt, perf
configuration items must be in 'key = value' format, otherwise the
following error message occurs:

  $ perf record -e intel_pt//u -- ls
  bad config file line 2 in ~/.perfconfig
  $ cat .perfconfig
  [intel-pt]
      mispred-all

Changing to assigning a value to the key 'mispred-all' fixes the issue:

  $ perf record -e intel_pt//u -- ls
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Capured and wrote 0.031 MB perf.data]
  $ cat .perfconfig
  [intel-pt]
      mispred-all = true

Signed-off-by: Jack Henschel <jackdev@mailbox.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20170831080535.2157-1-jackdev@mailbox.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/intel-pt.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/intel-pt.txt b/tools/perf/Documentation/intel-pt.txt
index ab1b0825130a..76971d2e4164 100644
--- a/tools/perf/Documentation/intel-pt.txt
+++ b/tools/perf/Documentation/intel-pt.txt
@@ -873,7 +873,7 @@ amended to take the number of elements as a parameter.
 
 	$ cat ~/.perfconfig
 	[intel-pt]
-		mispred-all
+		mispred-all = on
 
 	$ perf record -e intel_pt//u ./sort 3000
 	Bubble sorting array of 3000 elements
-- 
2.13.5
