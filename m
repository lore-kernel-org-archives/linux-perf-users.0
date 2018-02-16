From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 26/41] perf mem: Document a missing option
Date: Fri, 16 Feb 2018 16:17:31 -0300
Message-ID: <20180216191746.11095-27-acme@kernel.org>
References: <20180216191746.11095-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180216191746.11095-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Sangwon Hong <qpakzk@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Taeung Song <treeze.taeung@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Sangwon Hong <qpakzk@gmail.com>

Add the missing --force option on the man page.

Signed-off-by: Sangwon Hong <qpakzk@gmail.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Link: http://lkml.kernel.org/r/1518381517-30766-2-git-send-email-qpakzk@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-mem.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index 4be08a1e3f8d..b0211410969b 100644
--- a/tools/perf/Documentation/perf-mem.txt
+++ b/tools/perf/Documentation/perf-mem.txt
@@ -28,6 +28,10 @@ OPTIONS
 <command>...::
 	Any command you can specify in a shell.
 
+-f::
+--force::
+	Don't do ownership validation
+
 -t::
 --type=::
 	Select the memory operation type: load or store (default: load,store)
-- 
2.14.3
