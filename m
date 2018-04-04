From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/17] perf version: Add man page
Date: Tue,  3 Apr 2018 23:21:50 -0300
Message-ID: <20180404022158.12190-10-acme@kernel.org>
References: <20180404022158.12190-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180404022158.12190-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

Since a new option '--build-options' is created for 'perf version', so
we need to document it.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1522402036-22915-7-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-version.txt | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 tools/perf/Documentation/perf-version.txt

diff --git a/tools/perf/Documentation/perf-version.txt b/tools/perf/Documentation/perf-version.txt
new file mode 100644
index 000000000000..e207b7cfca26
--- /dev/null
+++ b/tools/perf/Documentation/perf-version.txt
@@ -0,0 +1,24 @@
+perf-version(1)
+===============
+
+NAME
+----
+perf-version - display the version of perf binary
+
+SYNOPSIS
+--------
+'perf version' [--build-options]
+
+DESCRIPTION
+-----------
+With no options given, the 'perf version' prints the perf version
+on the standard output.
+
+If the option '--build-options' is given, then the status of
+compiled-in libraries are printed on the standard output.
+
+OPTIONS
+-------
+--build-options::
+        Prints the status of compiled-in libraries on the
+        standard output.
-- 
2.14.3
