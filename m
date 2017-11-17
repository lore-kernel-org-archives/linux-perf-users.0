From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 50/83] perf top: Remove a duplicate word
Date: Fri, 17 Nov 2017 17:15:28 -0300
Message-ID: <20171117201601.24110-51-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758791AbdKQUTA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:19:00 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Sihyeon Jang <uneedsihyeon@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Sihyeon Jang <uneedsihyeon@gmail.com>

Signed-off-by: Sihyeon Jang <uneedsihyeon@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/1510449047-12941-3-git-send-email-uneedsihyeon@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 0789f95ca2f3..68320ac5e9b0 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -412,7 +412,7 @@ static void perf_top__print_mapped_keys(struct perf_top *top)
 	fprintf(stdout, "\t[S]     stop annotation.\n");
 
 	fprintf(stdout,
-		"\t[K]     hide kernel_symbols symbols.     \t(%s)\n",
+		"\t[K]     hide kernel symbols.             \t(%s)\n",
 		top->hide_kernel_symbols ? "yes" : "no");
 	fprintf(stdout,
 		"\t[U]     hide user symbols.               \t(%s)\n",
-- 
2.13.6
