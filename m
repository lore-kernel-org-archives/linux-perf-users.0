From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/27] perf list: Add missing documentation for --desc and --debug options
Date: Wed, 25 Jul 2018 14:59:44 -0300
Message-ID: <20180725180001.15108-11-acme@kernel.org>
References: <20180725180001.15108-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725180001.15108-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Sangwon Hong <qpakzk@gmail.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Sangwon Hong <qpakzk@gmail.com>

Add missing documentation for --desc and --debug options to the 'perf
list' man page.

Signed-off-by: Sangwon Hong <qpakzk@gmail.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20180717110738.10779-1-qpakzk@gmail.com
[ Clarify that --desc is by default active ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-list.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 14e13512c05f..236b9b97dfdb 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -18,6 +18,10 @@ various perf commands with the -e option.
 
 OPTIONS
 -------
+-d::
+--desc::
+Print extra event descriptions. (default)
+
 --no-desc::
 Don't print descriptions.
 
@@ -25,11 +29,13 @@ Don't print descriptions.
 --long-desc::
 Print longer event descriptions.
 
+--debug::
+Enable debugging output.
+
 --details::
 Print how named events are resolved internally into perf events, and also
 any extra expressions computed by perf stat.
 
-
 [[EVENT_MODIFIERS]]
 EVENT MODIFIERS
 ---------------
-- 
2.14.4
