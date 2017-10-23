From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/24] perf list: Fix group description in the man page
Date: Mon, 23 Oct 2017 20:47:27 -0300
Message-ID: <20171023234736.5335-16-acme@kernel.org>
References: <20171023234736.5335-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171023234736.5335-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Fix an incorrect description in the 'perf list' manpage. When a group
does not fit into the hardware it is partially scheduled, but does not
error out.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20171010224322.15861-1-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-list.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 24679aed90b7..e2a897ae3596 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -204,7 +204,7 @@ For example Intel Core CPUs typically have four generic performance counters
 for the core, plus three fixed counters for instructions, cycles and
 ref-cycles. Some special events have restrictions on which counter they
 can schedule, and may not support multiple instances in a single group.
-When too many events are specified in the group none of them will not
+When too many events are specified in the group some of them will not
 be measured.
 
 Globally pinned events can limit the number of counters available for
-- 
2.13.6
