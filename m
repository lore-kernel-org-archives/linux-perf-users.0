From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/40] perf trace: Add missing ' = ' in the default formatting of syscall returns
Date: Wed, 26 Jul 2017 11:16:53 -0300
Message-ID: <20170726141730.30750-4-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We lost it recently, put it back.

Before:

  789.499 ( 0.001 ms): libvirtd/1175 lseek(fd: 22, whence: CUR) 4328

After:

  789.499 ( 0.001 ms): libvirtd/1175 lseek(fd: 22, whence: CUR) = 4328

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: 1f63139c3f8a ("perf trace beauty: Simplify syscall return formatting")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1e4c0657b712..4370ce4f28c7 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1660,7 +1660,7 @@ static int trace__sys_exit(struct trace *trace, struct perf_evsel *evsel,
 		if (ret < 0)
 			goto errno_print;
 signed_print:
-		fprintf(trace->output, ") %ld", ret);
+		fprintf(trace->output, ") = %ld", ret);
 	} else if (ret < 0) {
 errno_print: {
 		char bf[STRERR_BUFSIZE];
-- 
2.9.4
