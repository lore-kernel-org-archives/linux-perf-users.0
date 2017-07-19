From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/86] perf trace: Beautify new write hint fcntl commands
Date: Wed, 19 Jul 2017 11:28:38 -0300
Message-ID: <20170719142950.3747-15-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jens Axboe <axboe@kernel.dk>, Jiri Olsa <jolsa@kernel.org>, "Martin K . Petersen" <martin.petersen@oracle.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Those introduced by the commit c75b1d9421f8 ("fs: add fcntl() interface for
setting/getting write life time hints"), tested using the proggie in that
commit comment:

  # perf trace -e fcntl ./write_hint write_hint.c
  fcntl: F_GET_RW_HINT: Invalid argument
     0.000 ( 0.006 ms): write_hint/7576 fcntl(fd: 3, cmd: GET_RW_HINT, arg: 0x7ffc6c918da0) = -1 EINVAL Invalid argument
     0.014 ( 0.004 ms): write_hint/7576 fcntl(fd: 4, cmd: GETFL) = 33794
  # perf trace -e fcntl ./write_hint write_hint.c 1
  fcntl: F_SET_RW_HINT: Invalid argument
     0.000 ( 0.007 ms): write_hint/7578 fcntl(fd: 3, cmd: SET_RW_HINT, arg: 0x7fff03866d70) = -1 EINVAL Invalid argument
     0.019 ( 0.002 ms): write_hint/7578 fcntl(fd: 4, cmd: GETFL) = 33794
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-iacglkc99cchou87k62736dn@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 2a894ea7f540..1f070bc43742 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -449,6 +449,7 @@ static DEFINE_STRARRAY(fcntl_cmds);
 static const char *fcntl_linux_specific_cmds[] = {
 	"SETLEASE", "GETLEASE", "NOTIFY", [5] =	"CANCELLK", "DUPFD_CLOEXEC",
 	"SETPIPE_SZ", "GETPIPE_SZ", "ADD_SEALS", "GET_SEALS",
+	"GET_RW_HINT", "SET_RW_HINT", "GET_FILE_RW_HINT", "SET_FILE_RW_HINT",
 };
 
 static DEFINE_STRARRAY_OFFSET(fcntl_linux_specific_cmds, F_LINUX_SPECIFIC_BASE);
-- 
2.9.4
