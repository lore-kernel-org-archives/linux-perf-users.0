From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/13] perf/hw_breakpoint: Simplify breakpoint enable in perf_event_modify_breakpoint
Date: Mon,  3 Sep 2018 11:52:17 -0300
Message-ID: <20180903145224.12318-7-acme@kernel.org>
References: <20180903145224.12318-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180903145224.12318-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Milind Chabbi <chabbi.milind@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We can safely enable the breakpoint back for both the fail and success
paths by checking only the bp->attr.disabled, which either holds the new
'requested' disabled state or the original breakpoint state.

Committer testing:

At the end of the series, the 'perf test' entry introduced as the first
patch now runs to completion without finding the fixed issues:

  # perf test "bp modify"
  62: x86 bp modify                                         : Ok
  #

In verbose mode:

  # perf test -v "bp modify"
  62: x86 bp modify                                         :
  --- start ---
  test child forked, pid 5161
  rip 5950a0, bp_1 0x5950a0
  in bp_1
  rip 5950a0, bp_1 0x5950a0
  in bp_1
  test child finished with 0
  ---- end ----
  x86 bp modify: Ok

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Milind Chabbi <chabbi.milind@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180827091228.2878-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 kernel/events/core.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f6ea33a9f904..22ede28ec07d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2867,16 +2867,11 @@ static int perf_event_modify_breakpoint(struct perf_event *bp,
 	_perf_event_disable(bp);
 
 	err = modify_user_hw_breakpoint_check(bp, attr, true);
-	if (err) {
-		if (!bp->attr.disabled)
-			_perf_event_enable(bp);
 
-		return err;
-	}
-
-	if (!attr->disabled)
+	if (!bp->attr.disabled)
 		_perf_event_enable(bp);
-	return 0;
+
+	return err;
 }
 
 static int perf_event_modify_attr(struct perf_event *event,
-- 
2.14.4
