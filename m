From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 25/41] perf kmem: Document a missing option & an argument
Date: Fri, 16 Feb 2018 16:17:30 -0300
Message-ID: <20180216191746.11095-26-acme@kernel.org>
References: <20180216191746.11095-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180216191746.11095-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Sangwon Hong <qpakzk@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Taeung Song <treeze.taeung@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Sangwon Hong <qpakzk@gmail.com>

First, 'perf kmem' has a '--force' option, but didn't document it on the
man page. So add it.

Second, the '--time' option has to get a value, but isn't documented on
the man page. Describe it.

Signed-off-by: Sangwon Hong <qpakzk@gmail.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Link: http://lkml.kernel.org/r/1518381517-30766-1-git-send-email-qpakzk@gmail.com
[ Add blank like after --force block, as requested by Namhyung ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-kmem.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-kmem.txt b/tools/perf/Documentation/perf-kmem.txt
index 479fc3261a50..85b8ac695c87 100644
--- a/tools/perf/Documentation/perf-kmem.txt
+++ b/tools/perf/Documentation/perf-kmem.txt
@@ -25,6 +25,10 @@ OPTIONS
 --input=<file>::
 	Select the input file (default: perf.data unless stdin is a fifo)
 
+-f::
+--force::
+	Don't do ownership validation
+
 -v::
 --verbose::
         Be more verbose. (show symbol address, etc)
@@ -61,7 +65,7 @@ OPTIONS
 	default, but this option shows live (currently allocated) pages
 	instead.  (This option works with --page option only)
 
---time::
+--time=<start>,<stop>::
 	Only analyze samples within given time window: <start>,<stop>. Times
 	have the format seconds.microseconds. If start is not given (i.e., time
 	string is ',x.y') then analysis starts at the beginning of the file. If
-- 
2.14.3
