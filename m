From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/13] perf/hw_breakpoint: Remove superfluous bp->attr.disabled = 0
Date: Mon,  3 Sep 2018 11:52:15 -0300
Message-ID: <20180903145224.12318-5-acme@kernel.org>
References: <20180903145224.12318-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180903145224.12318-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Milind Chabbi <chabbi.milind@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Once the breakpoint was succesfully modified, the attr->disabled value
is in bp->attr.disabled. So there's no reason to set it again, removing
that.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Milind Chabbi <chabbi.milind@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180827091228.2878-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 kernel/events/hw_breakpoint.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index fb229d9c7f3c..3e560d7609fd 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -526,10 +526,9 @@ int modify_user_hw_breakpoint(struct perf_event *bp, struct perf_event_attr *att
 	if (err)
 		return err;
 
-	if (!attr->disabled) {
+	if (!attr->disabled)
 		perf_event_enable(bp);
-		bp->attr.disabled = 0;
-	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(modify_user_hw_breakpoint);
-- 
2.14.4
