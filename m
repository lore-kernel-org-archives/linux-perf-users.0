From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/17] perf config: Rename to HAVE_DWARF_GETLOCATIONS_SUPPORT
Date: Tue,  3 Apr 2018 23:21:47 -0300
Message-ID: <20180404022158.12190-7-acme@kernel.org>
References: <20180404022158.12190-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180404022158.12190-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

In Makefile.config, to make all libraries flags have _SUPPORT suffix,
rename HAVE_DWARF_GETLOCATIONS to HAVE_DWARF_GETLOCATIONS_SUPPORT

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Suggested-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1522402036-22915-4-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config  | 2 +-
 tools/perf/util/dwarf-aux.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index deb8fba2f4f1..c7abd83a8e19 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -346,7 +346,7 @@ else
       ifneq ($(feature-dwarf_getlocations), 1)
         msg := $(warning Old libdw.h, finding variables at given 'perf probe' point will not work, install elfutils-devel/libdw-dev >= 0.157);
       else
-        CFLAGS += -DHAVE_DWARF_GETLOCATIONS
+        CFLAGS += -DHAVE_DWARF_GETLOCATIONS_SUPPORT
       endif # dwarf_getlocations
     endif # Dwarf support
   endif # libelf support
diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index f5acda13dcfa..7eb7de5aee44 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -979,7 +979,7 @@ int die_get_varname(Dwarf_Die *vr_die, struct strbuf *buf)
 	return ret < 0 ? ret : strbuf_addf(buf, "\t%s", dwarf_diename(vr_die));
 }
 
-#ifdef HAVE_DWARF_GETLOCATIONS
+#ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT
 /**
  * die_get_var_innermost_scope - Get innermost scope range of given variable DIE
  * @sp_die: a subprogram DIE
-- 
2.14.3
