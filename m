From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 69/83] perf trace: Document missing option, colons
Date: Fri, 17 Nov 2017 17:15:47 -0300
Message-ID: <20171117201601.24110-70-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Sihyeon Jang <uneedsihyeon@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Sihyeon Jang <uneedsihyeon@gmail.com>

Add missing --force option to the man page.

Signed-off-by: Sihyeon Jang <uneedsihyeon@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/1510842367-11011-2-git-send-email-uneedsihyeon@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-trace.txt | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index d53bea6bd571..6909cf1e0eea 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -86,18 +86,18 @@ comma-separated list with no space: 0,1. Ranges of CPUs are specified with -: 0-
 In per-thread mode with inheritance mode on (default), Events are captured only when
 the thread executes on the designated CPUs. Default is to monitor all CPUs.
 
---duration:
+--duration::
 	Show only events that had a duration greater than N.M ms.
 
---sched:
+--sched::
 	Accrue thread runtime and provide a summary at the end of the session.
 
--i
---input
+-i::
+--input::
 	Process events from a given perf data file.
 
--T
---time
+-T::
+--time::
 	Print full timestamp rather time relative to first sample.
 
 --comm::
@@ -117,6 +117,10 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
 	Show tool stats such as number of times fd->pathname was discovered thru
 	hooking the open syscall return + vfs_getname or via reading /proc/pid/fd, etc.
 
+-f::
+--force::
+	Don't complain, do it.
+
 -F=[all|min|maj]::
 --pf=[all|min|maj]::
 	Trace pagefaults. Optionally, you can specify whether you want minor,
-- 
2.13.6
