From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/35] perf: Mark expected switch fall-through
Date: Thu,  7 Mar 2019 14:44:02 -0300
Message-ID: <20190307174433.28819-5-acme@kernel.org>
References: <20190307174433.28819-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307174433.28819-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Kees Kook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

This patch fixes the following warning:

  kernel/events/core.c: In function ‘perf_event_parse_addr_filter’:
  kernel/events/core.c:9154:11: warning: this statement may fall through [-Wimplicit-fallthrough=]
      kernel = 1;
      ~~~~~~~^~~
  kernel/events/core.c:9156:3: note: here
     case IF_SRC_FILEADDR:
     ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enable -Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kees Kook <keescook@chromium.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190212205430.GA8446@embeddedor
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 kernel/events/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index dd9698ad3d66..6fb27b564730 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9175,6 +9175,7 @@ perf_event_parse_addr_filter(struct perf_event *event, char *fstr,
 		case IF_SRC_KERNELADDR:
 		case IF_SRC_KERNEL:
 			kernel = 1;
+			/* fall through */
 
 		case IF_SRC_FILEADDR:
 		case IF_SRC_FILE:
-- 
2.20.1
