From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/73] perf parse-regs: Improve error output when faced with unknown register name
Date: Fri, 17 May 2019 16:35:09 -0300
Message-ID: <20190517193611.4974-12-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Add quotes around the register name and suggest using 'perf record -I?'
to get the list of available registers.

Before:

  # perf record -Idi,xmm20,xmm1
  Warning:
  unknown register xmm20, check man page

   Usage: perf record [<options>] [<command>]
      or: perf record [<options>] -- <command> [<options>]

      -I, --intr-regs[=<any register>]
                            sample selected machine registers on interrupt, use -I ? to list register names
  #
  # perf record -Idi,xmm20,xmm1
  Warning:
  unknown register "xmm20", check man page or run "perf record -I?"

   Usage: perf record [<options>] [<command>]
      or: perf record [<options>] -- <command> [<options>]

      -I, --intr-regs[=<any register>]
                            sample selected machine registers on interrupt, use -I ? to list register names
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: https://lkml.kernel.org/n/tip-9a9hyuum8c0oggg86xd3sxc5@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-regs-options.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
index e6599e290f46..9cb187a20fe2 100644
--- a/tools/perf/util/parse-regs-options.c
+++ b/tools/perf/util/parse-regs-options.c
@@ -48,8 +48,7 @@ parse_regs(const struct option *opt, const char *str, int unset)
 					break;
 			}
 			if (!r->name) {
-				ui__warning("unknown register %s,"
-					    " check man page\n", s);
+				ui__warning("Unknown register \"%s\", check man page or run \"perf record -I?\"\n", s);
 				goto error;
 			}
 
-- 
2.20.1
