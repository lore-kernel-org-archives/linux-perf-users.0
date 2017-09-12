From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 6/9] perf ui progress: Fix progress update
Date: Tue, 12 Sep 2017 16:24:35 -0300
Message-ID: <20170912192438.1334-7-acme@kernel.org>
References: <20170912192438.1334-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751388AbdILTZN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Sep 2017 15:25:13 -0400
In-Reply-To: <20170912192438.1334-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jiri Olsa <jolsa@kernel.org>

We currently update the 'next' variable only with a single step value.
But it's possible the 'adv' update is bigger than single 'step' value.
This would leave 'next' value under counted and force unnecessary
ui_progress__ops->update calls.

Calculate the amount of steps we need for 'adv' update and increase the
'next' with that amounts of steps.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lkml.kernel.org/r/20170908120510.22515-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/progress.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/progress.c b/tools/perf/ui/progress.c
index a9c15804b1f6..ae91c8148edf 100644
--- a/tools/perf/ui/progress.c
+++ b/tools/perf/ui/progress.c
@@ -1,3 +1,4 @@
+#include <linux/kernel.h>
 #include "../cache.h"
 #include "progress.h"
 
@@ -14,10 +15,14 @@ struct ui_progress_ops *ui_progress__ops = &null_progress__ops;
 
 void ui_progress__update(struct ui_progress *p, u64 adv)
 {
+	u64 last = p->curr;
+
 	p->curr += adv;
 
 	if (p->curr >= p->next) {
-		p->next += p->step;
+		u64 nr = DIV_ROUND_UP(p->curr - last, p->step);
+
+		p->next += nr * p->step;
 		ui_progress__ops->update(p);
 	}
 }
-- 
2.13.5
