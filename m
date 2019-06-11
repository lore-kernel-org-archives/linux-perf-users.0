From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 85/85] perf trace: Skip unknown syscalls when expanding strace like syscall groups
Date: Tue, 11 Jun 2019 15:59:11 -0300
Message-ID: <20190611185911.11645-86-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Leo Yan <leo.yan@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@redhat.com>, Martin KaFai Lau <kafai@fb.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Mike Leach <mike.leach@linaro.org>, Song Liu <songliubraving@fb.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Yonghong Song <yhs@fb.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We have $INSTALL_DIR/share/perf-core/strace/groups/string files with
syscalls that should be selected when 'string' is used, meaning, in this
case, syscalls that receive as one of its arguments a string, like a
pathname.

But those were first selected and tested on x86_64, and end up failing
in architectures where some of those syscalls are not available, like
the 'access' syscall on arm64, which makes using 'perf trace -e string'
in such archs to fail.

Since this the routine doing the validation is used only when reading
such files, do not fail when some syscall is not found in the
syscalltbl, instead just use pr_debug() to register that in case people
are suspicious of problems.

Now using 'perf trace -e string' should work on arm64, selecting only
the syscalls that have a string and are available on that architecture.

Reported-by: Leo Yan <leo.yan@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/r/20190610184754.GU21245@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1a2a605cf068..eb70a4b71755 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1529,6 +1529,7 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 static int trace__validate_ev_qualifier(struct trace *trace)
 {
 	int err = 0, i;
+	bool printed_invalid_prefix = false;
 	size_t nr_allocated;
 	struct str_node *pos;
 
@@ -1555,14 +1556,15 @@ static int trace__validate_ev_qualifier(struct trace *trace)
 			if (id >= 0)
 				goto matches;
 
-			if (err == 0) {
-				fputs("Error:\tInvalid syscall ", trace->output);
-				err = -EINVAL;
+			if (!printed_invalid_prefix) {
+				pr_debug("Skipping unknown syscalls: ");
+				printed_invalid_prefix = true;
 			} else {
-				fputs(", ", trace->output);
+				pr_debug(", ");
 			}
 
-			fputs(sc, trace->output);
+			pr_debug("%s", sc);
+			continue;
 		}
 matches:
 		trace->ev_qualifier_ids.entries[i++] = id;
@@ -1591,15 +1593,14 @@ static int trace__validate_ev_qualifier(struct trace *trace)
 		}
 	}
 
-	if (err < 0) {
-		fputs("\nHint:\ttry 'perf list syscalls:sys_enter_*'"
-		      "\nHint:\tand: 'man syscalls'\n", trace->output);
-out_free:
-		zfree(&trace->ev_qualifier_ids.entries);
-		trace->ev_qualifier_ids.nr = 0;
-	}
 out:
+	if (printed_invalid_prefix)
+		pr_debug("\n");
 	return err;
+out_free:
+	zfree(&trace->ev_qualifier_ids.entries);
+	trace->ev_qualifier_ids.nr = 0;
+	goto out;
 }
 
 /*
-- 
2.20.1
