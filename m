From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/60] perf stat: Honour --timeout for forked workloads
Date: Mon, 20 Apr 2020 08:52:17 -0300
Message-ID: <20200420115316.18781-2-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Konstantin Kharlamov <hi-angel@yandex.ru>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, yuzhoujian <yuzhoujian@didichuxing.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When --timeout is used and a workload is specified to be started by
'perf stat', i.e.

  $ perf stat --timeout 1000 sleep 1h

The --timeout wasn't being honoured, i.e. the workload, 'sleep 1h' in
the above example, should be terminated after 1000ms, but it wasn't,
'perf stat' was waiting for it to finish.

Fix it by sending a SIGTERM when the timeout expires.

Now it works:

  # perf stat -e cycles --timeout 1234 sleep 1h
  sleep: Terminated

   Performance counter stats for 'sleep 1h':

           1,066,692      cycles

         1.234314838 seconds time elapsed

         0.000750000 seconds user
         0.000000000 seconds sys

  #

Fixes: f1f8ad52f8bf ("perf stat: Add support to print counts after a period of time")
Reported-by: Konstantin Kharlamov <hi-angel@yandex.ru>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=207243
Tested-by: Konstantin Kharlamov <hi-angel@yandex.ru>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Tested-by: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: yuzhoujian <yuzhoujian@didichuxing.com>
Link: https://lore.kernel.org/lkml/20200415153803.GB20324@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index ec053dc1e35c..9207b6c45475 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -686,8 +686,11 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 					break;
 			}
 		}
-		if (child_pid != -1)
+		if (child_pid != -1) {
+			if (timeout)
+				kill(child_pid, SIGTERM);
 			wait4(child_pid, &status, 0, &stat_config.ru_data);
+		}
 
 		if (workload_exec_errno) {
 			const char *emsg = str_error_r(workload_exec_errno, msg, sizeof(msg));
-- 
2.21.1
