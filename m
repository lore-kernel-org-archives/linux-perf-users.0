From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 64/85] perf script: Set perf time interval in itrace_synth_ops
Date: Tue, 11 Jun 2019 15:58:50 -0300
Message-ID: <20190611185911.11645-65-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Instruction trace decoders can optimize output based on what time
intervals will be filtered, so pass that information in
itrace_synth_ops.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 80c722ade852..61f00055476a 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3829,6 +3829,10 @@ int cmd_script(int argc, const char **argv)
 						  &script.range_num);
 		if (err < 0)
 			goto out_delete;
+
+		itrace_synth_opts__set_time_range(&itrace_synth_opts,
+						  script.ptime_range,
+						  script.range_num);
 	}
 
 	err = __cmd_script(&script);
@@ -3836,8 +3840,10 @@ int cmd_script(int argc, const char **argv)
 	flush_scripting();
 
 out_delete:
-	if (script.ptime_range)
+	if (script.ptime_range) {
+		itrace_synth_opts__clear_time_range(&itrace_synth_opts);
 		zfree(&script.ptime_range);
+	}
 
 	perf_evlist__free_stats(session->evlist);
 	perf_session__delete(session);
-- 
2.20.1
