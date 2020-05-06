From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 47/91] perf intel-pt: Update documentation about using /proc/kcore
Date: Wed,  6 May 2020 12:21:50 -0300
Message-ID: <20200506152234.21977-48-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Update documentation to reflect the advent of the --kcore option for
'perf record'.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200429150751.12570-10-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-intel-pt.txt | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index 782eb8a65caf..eb8b7d42591a 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -69,22 +69,22 @@ And profiled with 'perf report' e.g.
 To also trace kernel space presents a problem, namely kernel self-modifying
 code.  A fairly good kernel image is available in /proc/kcore but to get an
 accurate image a copy of /proc/kcore needs to be made under the same conditions
-as the data capture.  A script perf-with-kcore can do that, but beware that the
-script makes use of 'sudo' to copy /proc/kcore.  If you have perf installed
-locally from the source tree you can do:
+as the data capture. 'perf record' can make a copy of /proc/kcore if the option
+--kcore is used, but access to /proc/kcore is restricted e.g.
 
-	~/libexec/perf-core/perf-with-kcore record pt_ls -e intel_pt// -- ls
+	sudo perf record -o pt_ls --kcore -e intel_pt// -- ls
 
-which will create a directory named 'pt_ls' and put the perf.data file and
-copies of /proc/kcore, /proc/kallsyms and /proc/modules into it.  Then to use
-'perf report' becomes:
+which will create a directory named 'pt_ls' and put the perf.data file (named
+simply 'data') and copies of /proc/kcore, /proc/kallsyms and /proc/modules into
+it.  The other tools understand the directory format, so to use 'perf report'
+becomes:
 
-	~/libexec/perf-core/perf-with-kcore report pt_ls
+	sudo perf report -i pt_ls
 
 Because samples are synthesized after-the-fact, the sampling period can be
 selected for reporting. e.g. sample every microsecond
 
-	~/libexec/perf-core/perf-with-kcore report pt_ls --itrace=i1usge
+	sudo perf report pt_ls --itrace=i1usge
 
 See the sections below for more information about the --itrace option.
 
-- 
2.21.1
