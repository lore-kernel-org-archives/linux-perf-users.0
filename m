From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 5/9] perf ui progress: Make sure we always define step value
Date: Tue, 12 Sep 2017 16:24:34 -0300
Message-ID: <20170912192438.1334-6-acme@kernel.org>
References: <20170912192438.1334-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170912192438.1334-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Unlikely, but we could have ui_progress__init being called with total <
16, which would set the next and step variables to 0. That would force
unnecessary ui_progress__ops->update calls because 'next' would never
raise.

Forcing the next and step values to be always > 0.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lkml.kernel.org/r/20170908120510.22515-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/progress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/progress.c b/tools/perf/ui/progress.c
index a0f24c7115c5..a9c15804b1f6 100644
--- a/tools/perf/ui/progress.c
+++ b/tools/perf/ui/progress.c
@@ -25,7 +25,7 @@ void ui_progress__update(struct ui_progress *p, u64 adv)
 void ui_progress__init(struct ui_progress *p, u64 total, const char *title)
 {
 	p->curr = 0;
-	p->next = p->step = total / 16;
+	p->next = p->step = total / 16 ?: 1;
 	p->total = total;
 	p->title = title;
 
-- 
2.13.5
