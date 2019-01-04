From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/16] tools beauty: Make the prctl option table generator catch all PR_ options
Date: Fri,  4 Jan 2019 15:33:25 -0300
Message-ID: <20190104183337.12771-5-acme@kernel.org>
References: <20190104183337.12771-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190104183337.12771-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Kristina Martsenko <kristina.martsenko@arm.com>, Namhyung Kim <namhyung@kernel.org>, Will Deacon <will.deacon@arm.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

In ba8308856564 ("arm64: add prctl control for resetting ptrauth keys")
the PR_PAC_RESET_KEYS prctl option was introduced, get that into the
regex in addition to PR_GET_* and PR_SET_*:

So just get everything that matches '^#define PR_\w+' this ends up
adding these entries:

  $ tools/perf/trace/beauty/prctl_option.sh  > after
  $ diff -u before after
  --- before	2019-01-03 14:58:51.541807353 -0300
  +++ after	2019-01-03 15:17:05.909583804 -0300
  @@ -19,12 +19,18 @@
          [20] = "SET_ENDIAN",
          [21] = "GET_SECCOMP",
          [22] = "SET_SECCOMP",
  +       [23] = "CAPBSET_READ",
  +       [24] = "CAPBSET_DROP",
          [25] = "GET_TSC",
          [26] = "SET_TSC",
          [27] = "GET_SECUREBITS",
          [28] = "SET_SECUREBITS",
          [29] = "SET_TIMERSLACK",
          [30] = "GET_TIMERSLACK",
  +       [31] = "TASK_PERF_EVENTS_DISABLE",
  +       [32] = "TASK_PERF_EVENTS_ENABLE",
  +       [33] = "MCE_KILL",
  +       [34] = "MCE_KILL_GET",
          [35] = "SET_MM",
          [36] = "SET_CHILD_SUBREAPER",
          [37] = "GET_CHILD_SUBREAPER",
  @@ -33,8 +39,13 @@
          [40] = "GET_TID_ADDRESS",
          [41] = "SET_THP_DISABLE",
          [42] = "GET_THP_DISABLE",
  +       [43] = "MPX_ENABLE_MANAGEMENT",
  +       [44] = "MPX_DISABLE_MANAGEMENT",
          [45] = "SET_FP_MODE",
          [46] = "GET_FP_MODE",
  +       [47] = "CAP_AMBIENT",
  +       [50] = "SVE_SET_VL",
  +       [51] = "SVE_GET_VL",
          [52] = "GET_SPECULATION_CTRL",
          [53] = "SET_SPECULATION_CTRL",
          [54] = "PAC_RESET_KEYS",
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kristina Martsenko <kristina.martsenko@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/n/tip-sg2pkmtjr5988bhbcp4yp6sw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/prctl_option.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/prctl_option.sh b/tools/perf/trace/beauty/prctl_option.sh
index d32f8f1124af..3109d7b05e11 100755
--- a/tools/perf/trace/beauty/prctl_option.sh
+++ b/tools/perf/trace/beauty/prctl_option.sh
@@ -4,7 +4,7 @@
 [ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
 
 printf "static const char *prctl_options[] = {\n"
-regex='^#define[[:space:]]+PR_([GS]ET\w+)[[:space:]]*([[:xdigit:]]+).*'
+regex='^#define[[:space:]]+PR_(\w+)[[:space:]]*([[:xdigit:]]+).*'
 egrep $regex ${header_dir}/prctl.h | grep -v PR_SET_PTRACER | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	sort -n | xargs printf "\t[%s] = \"%s\",\n"
-- 
2.20.1
