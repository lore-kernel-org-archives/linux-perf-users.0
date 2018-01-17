From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/32] tools lib traceevent: Fix missing break in FALSE case of pevent_filter_clear_trivial()
Date: Wed, 17 Jan 2018 13:12:06 -0300
Message-ID: <20180117161222.15611-17-acme@kernel.org>
References: <20180117161222.15611-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117161222.15611-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Taeung Song <treeze.taeung@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Taeung Song <treeze.taeung@gmail.com>

Currently the FILTER_TRIVIAL_FALSE case has a missing break statement,
if the trivial type is FALSE, it will also run into the TRUE case, and
always be skipped as the TRUE statement will continue the loop on the
inverse condition of the FALSE statement.

Reported-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: http://lkml.kernel.org/r/20180112004823.012918807@goodmis.org
Link: http://lkml.kernel.org/r/1493218540-12296-1-git-send-email-treeze.taeung@gmail.com
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/parse-filter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
index 2410afdcbcfe..2b9048f90bae 100644
--- a/tools/lib/traceevent/parse-filter.c
+++ b/tools/lib/traceevent/parse-filter.c
@@ -1631,6 +1631,7 @@ int pevent_filter_clear_trivial(struct event_filter *filter,
 		case FILTER_TRIVIAL_FALSE:
 			if (filter_type->filter->boolean.value)
 				continue;
+			break;
 		case FILTER_TRIVIAL_TRUE:
 			if (!filter_type->filter->boolean.value)
 				continue;
-- 
2.14.3
