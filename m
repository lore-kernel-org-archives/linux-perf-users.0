From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/25] perf counts: Add missing headers needed for types used
Date: Thu, 22 Aug 2019 18:00:44 -0300
Message-ID: <20190822210100.3461-10-acme@kernel.org>
References: <20190822210100.3461-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190822210100.3461-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We get these by sheer luck, since we're cleaning unneeded headers use,
this needs to be done first to avoid breakage down the line.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-p7bncbi53t4p2kobkbmu86a4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/counts.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/counts.h b/tools/perf/util/counts.h
index 13430f353c19..92196df4945f 100644
--- a/tools/perf/util/counts.h
+++ b/tools/perf/util/counts.h
@@ -2,8 +2,12 @@
 #ifndef __PERF_COUNTS_H
 #define __PERF_COUNTS_H
 
+#include <linux/types.h>
 #include <internal/xyarray.h>
 #include <perf/evsel.h>
+#include <stdbool.h>
+
+struct evsel;
 
 struct perf_counts {
 	s8			  scaled;
-- 
2.21.0
