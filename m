From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 48/86] perf tests attr: Fix record dwarf test
Date: Wed, 19 Jul 2017 11:29:12 -0300
Message-ID: <20170719142950.3747-49-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Following commit:

  commit 5c0cf22477ea ("perf record: Store data mmaps for dwarf unwind")

have enabled address sampling for dwarf unwind, we need to reflect that
in this test by adding ADDR sample_type and enabling mmap_data.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20170703145030.12903-8-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/attr/test-record-graph-dwarf | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/attr/test-record-graph-dwarf b/tools/perf/tests/attr/test-record-graph-dwarf
index d6f324ea578c..8321c602dc38 100644
--- a/tools/perf/tests/attr/test-record-graph-dwarf
+++ b/tools/perf/tests/attr/test-record-graph-dwarf
@@ -3,8 +3,9 @@ command = record
 args    = --call-graph dwarf -- kill >/dev/null 2>&1
 
 [event:base-record]
-sample_type=12583
+sample_type=45359
 exclude_callchain_user=1
 sample_stack_user=8192
 # TODO different for each arch, no support for that now
 sample_regs_user=*
+mmap_data=1
-- 
2.9.4
