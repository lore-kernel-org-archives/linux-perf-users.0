From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 29/57] perf trace: Show error message when not finding a field used in a filter expression
Date: Mon, 21 Oct 2019 10:38:06 -0300
Message-ID: <20191021133834.25998-30-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It was there, but as pr_debug(), make it pr_err() so that we can see it
without -v:

  # trace -e syscalls:*lseek --filter="whenc==SET" sleep 1
  "whenc" not found in "syscalls:sys_enter_lseek", can't set filter "whenc==SET"
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ly4rgm1bto8uwc2itpaixjob@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e71605c99080..cafd18466dfa 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3611,8 +3611,8 @@ static int trace__expand_filter(struct trace *trace __maybe_unused, struct evsel
 
 			fmt = perf_evsel__syscall_arg_fmt(evsel, arg);
 			if (fmt == NULL) {
-				pr_debug("\"%s\" not found in \"%s\", can't set filter \"%s\"\n",
-					 arg, evsel->name, evsel->filter);
+				pr_err("\"%s\" not found in \"%s\", can't set filter \"%s\"\n",
+				       arg, evsel->name, evsel->filter);
 				return -1;
 			}
 
-- 
2.21.0
