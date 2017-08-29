From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/18] perf tools: Pass full path of FEATURES_DUMP
Date: Tue, 29 Aug 2017 16:42:50 -0300
Message-ID: <20170829194254.1338-15-acme@kernel.org>
References: <20170829194254.1338-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170829194254.1338-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, David Carrillo-Cisneros <davidcc@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Paul Turner <pjt@google.com>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: David Carrillo-Cisneros <davidcc@google.com>

When building with an external FEATURES_DUMP, bpf complains
that features dump file is not found. Fix it by passing full file path.

Signed-off-by: David Carrillo-Cisneros <davidcc@google.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Paul Turner <pjt@google.com>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20170827075442.108534-7-davidcc@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 58924eb0f40b..a5bf3100f812 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -240,7 +240,7 @@ endif
 ifeq ($(FEATURES_DUMP),)
 FEATURE_DUMP_EXPORT := $(realpath $(OUTPUT)FEATURE-DUMP)
 else
-FEATURE_DUMP_EXPORT := $(FEATURES_DUMP)
+FEATURE_DUMP_EXPORT := $(realpath $(FEATURES_DUMP))
 endif
 
 export prefix bindir sharedir sysconfdir DESTDIR
-- 
2.13.5
