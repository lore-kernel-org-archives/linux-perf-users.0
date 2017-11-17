From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 72/83] perf evlist: Document missing --force option
Date: Fri, 17 Nov 2017 17:15:50 -0300
Message-ID: <20171117201601.24110-73-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Sihyeon Jang <uneedsihyeon@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Sihyeon Jang <uneedsihyeon@gmail.com>

Add --force to the man page.

Signed-off-by: Sihyeon Jang <uneedsihyeon@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/1510842367-11011-5-git-send-email-uneedsihyeon@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-evlist.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/Documentation/perf-evlist.txt b/tools/perf/Documentation/perf-evlist.txt
index 6f7200fb85cf..c0a66400a960 100644
--- a/tools/perf/Documentation/perf-evlist.txt
+++ b/tools/perf/Documentation/perf-evlist.txt
@@ -20,6 +20,10 @@ OPTIONS
 --input=::
         Input file name. (default: perf.data unless stdin is a fifo)
 
+-f::
+--force::
+	Don't complain, do it.
+
 -F::
 --freq=::
 	Show just the sample frequency used for each event.
-- 
2.13.6
