From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 91/91] perf flamegraph: Use /bin/bash for report and record scripts
Date: Wed,  6 May 2020 12:22:34 -0300
Message-ID: <20200506152234.21977-92-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>, Andreas Gerstmayr <agerstmayr@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, lkft-triage@lists.linaro.org
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As all the other tools/perf/scripts/python/bin/*-{report,record}
scripts, fixing the this problem reported by Daniel Diaz:

  Our OpenEmbedded builds detected an issue with 5287f9269206 ("perf
  script: Add flamegraph.py script"):
    ERROR: perf-1.0-r9 do_package_qa: QA Issue:
  /usr/libexec/perf-core/scripts/python/bin/flamegraph-report contained
  in package perf-python requires /usr/bin/sh, but no providers found in
  RDEPENDS_perf-python? [file-rdeps]

  This means that there is a new binary pulled in in the shebang line
  which was unaccounted for: `/usr/bin/sh`. I don't see any other usage
  of /usr/bin/sh in the kernel tree (does not even exist on my Ubuntu
  dev machine) but plenty of /bin/sh. This patch is needed:
  -----8<----------8<----------8<-----
  diff --git a/tools/perf/scripts/python/bin/flamegraph-record
  b/tools/perf/scripts/python/bin/flamegraph-record
  index 725d66e71570..a2f3fa25ef81 100755
  --- a/tools/perf/scripts/python/bin/flamegraph-record
  +++ b/tools/perf/scripts/python/bin/flamegraph-record
  @@ -1,2 +1,2 @@
  -#!/usr/bin/sh
  +#!/bin/sh
   perf record -g "$@"
  diff --git a/tools/perf/scripts/python/bin/flamegraph-report
  b/tools/perf/scripts/python/bin/flamegraph-report
  index b1a79afd903b..b0177355619b 100755
  --- a/tools/perf/scripts/python/bin/flamegraph-report
  +++ b/tools/perf/scripts/python/bin/flamegraph-report
  @@ -1,3 +1,3 @@
  -#!/usr/bin/sh
  +#!/bin/sh
   # description: create flame graphs
   perf script -s "$PERF_EXEC_PATH"/scripts/python/flamegraph.py -- "$@"
  ----->8---------->8---------->8-----

Fixes: 5287f9269206 ("perf script: Add flamegraph.py script")
Reported-by: Daniel Díaz <daniel.diaz@linaro.org>
Acked-by: Andreas Gerstmayr <agerstmayr@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: lkft-triage@lists.linaro.org
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/CAEUSe7_wmKS361mKLTB1eYbzYXcKkXdU26BX5BojdKRz8MfPCw@mail.gmail.com
Link: http://lore.kernel.org/lkml/20200505170320.GZ30487@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/bin/flamegraph-record | 2 +-
 tools/perf/scripts/python/bin/flamegraph-report | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/scripts/python/bin/flamegraph-record b/tools/perf/scripts/python/bin/flamegraph-record
index 725d66e71570..7df5a19c0163 100755
--- a/tools/perf/scripts/python/bin/flamegraph-record
+++ b/tools/perf/scripts/python/bin/flamegraph-record
@@ -1,2 +1,2 @@
-#!/usr/bin/sh
+#!/bin/bash
 perf record -g "$@"
diff --git a/tools/perf/scripts/python/bin/flamegraph-report b/tools/perf/scripts/python/bin/flamegraph-report
index b1a79afd903b..53c5dc90c87e 100755
--- a/tools/perf/scripts/python/bin/flamegraph-report
+++ b/tools/perf/scripts/python/bin/flamegraph-report
@@ -1,3 +1,3 @@
-#!/usr/bin/sh
+#!/bin/bash
 # description: create flame graphs
 perf script -s "$PERF_EXEC_PATH"/scripts/python/flamegraph.py -- "$@"
-- 
2.21.1
