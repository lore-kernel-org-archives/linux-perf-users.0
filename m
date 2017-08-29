From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/18] perf tools: Allow external definition of flex and bison binary names
Date: Tue, 29 Aug 2017 16:42:47 -0300
Message-ID: <20170829194254.1338-12-acme@kernel.org>
References: <20170829194254.1338-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170829194254.1338-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, David Carrillo-Cisneros <davidcc@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Paul Turner <pjt@google.com>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: David Carrillo-Cisneros <davidcc@google.com>

Allow user to define flex and bison binary names by passing FLEX and
BISON variables.

Signed-off-by: David Carrillo-Cisneros <davidcc@google.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Paul Turner <pjt@google.com>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20170827075442.108534-3-davidcc@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index a700a079a218..58924eb0f40b 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -164,8 +164,8 @@ LN      = ln -f
 MKDIR   = mkdir
 FIND    = find
 INSTALL = install
-FLEX    = flex
-BISON   = bison
+FLEX    ?= flex
+BISON   ?= bison
 STRIP   = strip
 AWK     = awk
 
-- 
2.13.5
