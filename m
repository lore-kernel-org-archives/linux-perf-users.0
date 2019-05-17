From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/73] perf record: Fix suggestion to get list of registers usable with --user-regs and --intr-regs
Date: Fri, 17 May 2019 16:35:08 -0300
Message-ID: <20190517193611.4974-11-acme@kernel.org>
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

  $ perf record -h -I

   Usage: perf record [<options>] [<command>]
      or: perf record [<options>] -- <command> [<options>]

      -I, --intr-regs[=<any register>]
                            sample selected machine registers on interrupt, use -I ? to list register names

  $ m
  $ perf record -I ?
  Workload failed: No such file or directory
  $

  After:

  $ perf record -h -I

   Usage: perf record [<options>] [<command>]
      or: perf record [<options>] -- <command> [<options>]

      -I, --intr-regs[=<any register>]
                            sample selected machine registers on interrupt, use '-I?' to list register names

  $
  $ perf record -I?
  available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10 R11 R12 R13 R14 R15

   Usage: perf record [<options>] [<command>]
      or: perf record [<options>] -- <command> [<options>]

      -I, --intr-regs[=<any register>]
                            sample selected machine registers on interrupt, use '-I?' to list register names
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Fixes: bcc84ec65ad1 ("perf record: Add ability to name registers to record")
Link: https://lkml.kernel.org/n/tip-r0xhfhy5radmkhhcbcfs5izf@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index c5e10552776a..d2b5a22b7249 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2017,10 +2017,10 @@ static struct option __record_options[] = {
 		    "use per-thread mmaps"),
 	OPT_CALLBACK_OPTARG('I', "intr-regs", &record.opts.sample_intr_regs, NULL, "any register",
 		    "sample selected machine registers on interrupt,"
-		    " use -I ? to list register names", parse_regs),
+		    " use '-I?' to list register names", parse_regs),
 	OPT_CALLBACK_OPTARG(0, "user-regs", &record.opts.sample_user_regs, NULL, "any register",
 		    "sample selected machine registers on interrupt,"
-		    " use -I ? to list register names", parse_regs),
+		    " use '-I?' to list register names", parse_regs),
 	OPT_BOOLEAN(0, "running-time", &record.opts.running_time,
 		    "Record running/enabled time of read (:S) events"),
 	OPT_CALLBACK('k', "clockid", &record.opts,
-- 
2.20.1
