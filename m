From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/14] perf llvm-utils: Remove bashism from kernel include fetch script
Date: Wed, 11 Jul 2018 16:43:00 -0400
Message-ID: <20180711204305.12924-10-acme@kernel.org>
References: <20180711204305.12924-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180711204305.12924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kim Phillips <kim.phillips@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Michael Petlan <mpetlan@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Sandipan Das <sandipan@linux.vnet.ibm.com>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kim Phillips <kim.phillips@arm.com>

Like system(), popen() calls /bin/sh, which may/may not be bash.

Script when run on dash and encounters the line, yields:

 exit: Illegal number: -1

checkbashisms report on script content:

 possible bashism (exit|return with negative status code):
 exit -1

Remove the bashism and use the more portable non-zero failure
status code 1.

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20180629124652.8d0af7e2281fd3fd8262cacc@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/llvm-utils.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index 976e658e38dc..5e94857dfca2 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -266,16 +266,16 @@ static const char *kinc_fetch_script =
 "#!/usr/bin/env sh\n"
 "if ! test -d \"$KBUILD_DIR\"\n"
 "then\n"
-"	exit -1\n"
+"	exit 1\n"
 "fi\n"
 "if ! test -f \"$KBUILD_DIR/include/generated/autoconf.h\"\n"
 "then\n"
-"	exit -1\n"
+"	exit 1\n"
 "fi\n"
 "TMPDIR=`mktemp -d`\n"
 "if test -z \"$TMPDIR\"\n"
 "then\n"
-"    exit -1\n"
+"    exit 1\n"
 "fi\n"
 "cat << EOF > $TMPDIR/Makefile\n"
 "obj-y := dummy.o\n"
-- 
2.14.4
