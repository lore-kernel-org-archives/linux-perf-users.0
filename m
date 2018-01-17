From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/32] tools lib traceevent: Fix bad force_token escape sequence
Date: Wed, 17 Jan 2018 13:11:58 -0300
Message-ID: <20180117161222.15611-9-acme@kernel.org>
References: <20180117161222.15611-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117161222.15611-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Michael Sartain <mikesart@fastmail.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Michael Sartain <mikesart@fastmail.com>

Older kernels have a bug that creates invalid symbols. event-parse.c
handles them by replacing them with a "%s" token. But the fix included
an extra backslash, and "\%s" was added incorrectly.

Signed-off-by: Michael Sartain <mikesart@fastmail.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: http://lkml.kernel.org/r/20180112004821.827168881@goodmis.org
Link: http://lkml.kernel.org/r/d320000d37c10ce0912851e1fb78d1e0c946bcd9.1497486273.git.mikesart@fastmail.com
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 7ce724fc0544..0bc1a6df8a27 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -1094,7 +1094,7 @@ static enum event_type __read_token(char **tok)
 		if (strcmp(*tok, "LOCAL_PR_FMT") == 0) {
 			free(*tok);
 			*tok = NULL;
-			return force_token("\"\%s\" ", tok);
+			return force_token("\"%s\" ", tok);
 		} else if (strcmp(*tok, "STA_PR_FMT") == 0) {
 			free(*tok);
 			*tok = NULL;
-- 
2.14.3
