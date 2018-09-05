From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 69/77] perf trace beauty: Alias 'umount' to 'umount2'
Date: Wed,  5 Sep 2018 19:04:32 -0300
Message-ID: <20180905220440.20256-70-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Benjamin Peterson <benjamin@python.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Benjamin Peterson <benjamin@python.org>

Before:

  # perf trace -e *mount* umount /dev/mapper/fedora-home /s
    11.576 ( 0.004 ms) umount/3138 umount2(arg0: 94501956754656, arg1: 0, arg2: 1, arg3: 140051050083104, arg4: 4, arg5: 94501956755136) = -1 EINVAL Invalid argument
  #

After:

  # perf trace -e *mount* umount /s
     0.000 ( 9.241 ms): umount/5251 umount2(name: 0x55f74a986480) = 0

Signed-off-by: Benjamin Peterson <benjamin@python.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180828035344.31500-1-benjamin@python.org
[ split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 97ace635bed8..c106189f4066 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -825,6 +825,7 @@ static struct syscall_fmt {
 	  .arg = { [2] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
 	{ .name	    = "tkill",
 	  .arg = { [1] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
+	{ .name     = "umount2", .alias = "umount", },
 	{ .name	    = "uname", .alias = "newuname", },
 	{ .name	    = "unlinkat",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
-- 
2.14.4
