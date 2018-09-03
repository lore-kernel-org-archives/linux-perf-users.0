From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/13] perf/hw_breakpoint: Modify breakpoint even if the new attr has disabled set
Date: Mon,  3 Sep 2018 11:52:14 -0300
Message-ID: <20180903145224.12318-4-acme@kernel.org>
References: <20180903145224.12318-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180903145224.12318-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We need to change the breakpoint even if the attr with new fields has
disabled set to true.

Current code prevents following user code to change the breakpoint
address:

  ptrace(PTRACE_POKEUSER, child, offsetof(struct user, u_debugreg[0]), addr_1)
  ptrace(PTRACE_POKEUSER, child, offsetof(struct user, u_debugreg[0]), addr_2)
  ptrace(PTRACE_POKEUSER, child, offsetof(struct user, u_debugreg[7]), dr7)

The first PTRACE_POKEUSER creates the breakpoint with attr.disabled set
to true:

  ptrace_set_breakpoint_addr(nr = 0)
    struct perf_event *bp = t->ptrace_bps[nr];

    ptrace_register_breakpoint(..., disabled = true)
      ptrace_fill_bp_fields(..., disabled)
      register_user_hw_breakpoint

So the second PTRACE_POKEUSER will be omitted:

  ptrace_set_breakpoint_addr(nr = 0)
    struct perf_event *bp = t->ptrace_bps[nr];
    struct perf_event_attr attr = bp->attr;

    modify_user_hw_breakpoint(bp, &attr)
      if (!attr->disabled)
        modify_user_hw_breakpoint_check

Reported-by: Milind Chabbi <chabbi.milind@gmail.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180827091228.2878-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 kernel/events/hw_breakpoint.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index b3814fce5ecb..fb229d9c7f3c 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -509,6 +509,8 @@ modify_user_hw_breakpoint_check(struct perf_event *bp, struct perf_event_attr *a
  */
 int modify_user_hw_breakpoint(struct perf_event *bp, struct perf_event_attr *attr)
 {
+	int err;
+
 	/*
 	 * modify_user_hw_breakpoint can be invoked with IRQs disabled and hence it
 	 * will not be possible to raise IPIs that invoke __perf_event_disable.
@@ -520,11 +522,11 @@ int modify_user_hw_breakpoint(struct perf_event *bp, struct perf_event_attr *att
 	else
 		perf_event_disable(bp);
 
-	if (!attr->disabled) {
-		int err = modify_user_hw_breakpoint_check(bp, attr, false);
+	err = modify_user_hw_breakpoint_check(bp, attr, false);
+	if (err)
+		return err;
 
-		if (err)
-			return err;
+	if (!attr->disabled) {
 		perf_event_enable(bp);
 		bp->attr.disabled = 0;
 	}
-- 
2.14.4
