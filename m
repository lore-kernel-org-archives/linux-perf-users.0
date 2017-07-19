From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 60/86] perf trace beauty fcntl: Do not suppress 'cmd' when zero, should be DUPFD
Date: Wed, 19 Jul 2017 11:29:24 -0300
Message-ID: <20170719142950.3747-61-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Before:

 77059.513 ( 0.005 ms): bash/6649 fcntl(fd: 1</dev/pts/12>, arg: 10) = 10</dev/pts/12>

After:

 77059.513 ( 0.005 ms): bash/6649 fcntl(fd: 1</dev/pts/12>, cmd: DUPFD, arg: 10) = 10</dev/pts/12>

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-woois88uwcr4xu38xx1ihiwo@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index b842bd93457f..bab87f612a36 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -652,7 +652,8 @@ static struct syscall_fmt {
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* fd */ }, }, },
 	{ .name	    = "fcntl",	    .errmsg = true,
 	  .arg = { [1] = { .scnprintf = SCA_FCNTL_CMD, /* cmd */
-			   .parm      = &strarrays__fcntl_cmds_arrays, /* cmd */ },
+			   .parm      = &strarrays__fcntl_cmds_arrays,
+			   .show_zero = true, },
 		   [2] = { .scnprintf =  SCA_FCNTL_ARG, /* arg */ }, }, },
 	{ .name	    = "fdatasync",  .errmsg = true, },
 	{ .name	    = "flock",	    .errmsg = true,
-- 
2.9.4
