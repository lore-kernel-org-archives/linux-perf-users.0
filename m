From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/43] perf symbols: Using O_CLOEXEC in do_open
Date: Tue, 23 Jan 2018 10:12:15 -0300
Message-ID: <20180123131251.28197-8-acme@kernel.org>
References: <20180123131251.28197-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180123131251.28197-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Wang YanQing <udknight@gmail.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Wang YanQing <udknight@gmail.com>

I've meet a strange behavior with these commands on my gentoo box:

1: perf kmem record
2: CTRL-C to stop 1
3: perf report
4: "Enter", "Enter", "Run scripts for all samples",
   "event_analyzing_sample".

Then 'perf report' says:

  "
  No kallsyms or vmlinux with build-id xxxx was found
  /lib/modules/4.10.0+/build/vmlinux with build id xxxx not found,
  continuing without symbols
  ".

It is strange because I am sure /lib/modules/4.10.0+/build/vmlinux is
right for perf.data.

After digging, I found out the reason is that "perf report" generates
many open fds, then "script_browse" uses popen to run "perf script"
which run out of open files.

The gentoo box has a small default value for "max open files", 1024.
Yes, "ulimit -n " with a bigger number could fix it, but I think that
using O_CLOEXEC in do_open is a better way.

Signed-off-by: Wang YanQing <udknight@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180115050448.GA20759@udknight
[ Make sure O_CLOEXEC is available in old systems by adding a patch
  just before this one, to keep this bisectable in such systems ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index d5b6f7f5baff..36ef45b2e89d 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -446,7 +446,7 @@ static int do_open(char *name)
 	char sbuf[STRERR_BUFSIZE];
 
 	do {
-		fd = open(name, O_RDONLY);
+		fd = open(name, O_RDONLY|O_CLOEXEC);
 		if (fd >= 0)
 			return fd;
 
-- 
2.14.3
