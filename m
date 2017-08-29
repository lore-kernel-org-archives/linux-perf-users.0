From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/18] tools lib: Allow external definition of CC, AR and LD
Date: Tue, 29 Aug 2017 16:42:48 -0300
Message-ID: <20170829194254.1338-13-acme@kernel.org>
References: <20170829194254.1338-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170829194254.1338-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, David Carrillo-Cisneros <davidcc@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Paul Turner <pjt@google.com>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: David Carrillo-Cisneros <davidcc@google.com>

Use already defined values for CC, AR and LD when available.

Signed-off-by: David Carrillo-Cisneros <davidcc@google.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Paul Turner <pjt@google.com>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20170827075442.108534-4-davidcc@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/api/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
index eb6e0b36bfc1..2538675731c7 100644
--- a/tools/lib/api/Makefile
+++ b/tools/lib/api/Makefile
@@ -8,9 +8,9 @@ srctree := $(patsubst %/,%,$(dir $(srctree)))
 #$(info Determined 'srctree' to be $(srctree))
 endif
 
-CC = $(CROSS_COMPILE)gcc
-AR = $(CROSS_COMPILE)ar
-LD = $(CROSS_COMPILE)ld
+CC ?= $(CROSS_COMPILE)gcc
+AR ?= $(CROSS_COMPILE)ar
+LD ?= $(CROSS_COMPILE)ld
 
 MAKEFLAGS += --no-print-directory
 
-- 
2.13.5
