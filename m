From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/44] perf record: Clarify help for --switch-output
Date: Thu, 21 Mar 2019 15:51:01 -0300
Message-ID: <20190321185142.11441-4-acme@kernel.org>
References: <20190321185142.11441-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190321185142.11441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The help description for --switch-output looks like there are multiple
comma separated fields. But it's actually a choice of different options.
Make it clear and less confusing.

Before:

  % perf record -h
  ...
          --switch-output[=<signal,size,time>]
                            Switch output when receive SIGUSR2 or cross size,time threshold

After:

  % perf record -h
  ...

          --switch-output[=<signal or size[BKMG] or time[smhd]>]
                            Switch output when receiving SIGUSR2 (signal) or cross a size or time threshold

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
LPU-Reference: 20190314225002.30108-4-andi@firstfloor.org
Link: https://lkml.kernel.org/n/tip-9yecyuha04nyg8toyd1b2pgi@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 02d7c40b2d10..e7144a1c1c82 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1989,8 +1989,8 @@ static struct option __record_options[] = {
 	OPT_BOOLEAN(0, "timestamp-boundary", &record.timestamp_boundary,
 		    "Record timestamp boundary (time of first/last samples)"),
 	OPT_STRING_OPTARG_SET(0, "switch-output", &record.switch_output.str,
-			  &record.switch_output.set, "signal,size,time",
-			  "Switch output when receive SIGUSR2 or cross size,time threshold",
+			  &record.switch_output.set, "signal or size[BKMG] or time[smhd]",
+			  "Switch output when receiving SIGUSR2 (signal) or cross a size or time threshold",
 			  "signal"),
 	OPT_INTEGER(0, "switch-max-files", &record.switch_output.num_files,
 		   "Limit number of switch output generated files"),
-- 
2.20.1
