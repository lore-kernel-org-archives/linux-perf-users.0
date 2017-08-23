From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/15] perf tools: Fix static linking with libdw from elfutils
Date: Wed, 23 Aug 2017 16:36:13 -0300
Message-ID: <20170823193614.20394-15-acme@kernel.org>
References: <20170823193614.20394-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170823193614.20394-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Fix feature test for static libdw: link required dependencies.  Backends
of libebl are not statically linked thus libdl is required.

In Debian/Ubuntu libdw-dev includes libebl.a starting from 0.166-1.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/150322916720.129772.7959925864494283854.stgit@buzz
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 37d203c4cd1f..bb4735b92ada 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -103,8 +103,12 @@ ifdef LIBDW_DIR
   LIBDW_CFLAGS  := -I$(LIBDW_DIR)/include
   LIBDW_LDFLAGS := -L$(LIBDW_DIR)/lib
 endif
+DWARFLIBS := -ldw
+ifeq ($(findstring -static,${LDFLAGS}),-static)
+  DWARFLIBS += -lelf -lebl -ldl -lz -llzma -lbz2
+endif
 FEATURE_CHECK_CFLAGS-libdw-dwarf-unwind := $(LIBDW_CFLAGS)
-FEATURE_CHECK_LDFLAGS-libdw-dwarf-unwind := $(LIBDW_LDFLAGS) -ldw
+FEATURE_CHECK_LDFLAGS-libdw-dwarf-unwind := $(LIBDW_LDFLAGS) $(DWARFLIBS)
 
 # for linking with debug library, run like:
 # make DEBUG=1 LIBBABELTRACE_DIR=/opt/libbabeltrace/
@@ -365,10 +369,6 @@ ifndef NO_LIBELF
     else
       CFLAGS += -DHAVE_DWARF_SUPPORT $(LIBDW_CFLAGS)
       LDFLAGS += $(LIBDW_LDFLAGS)
-      DWARFLIBS := -ldw
-      ifeq ($(findstring -static,${LDFLAGS}),-static)
-	DWARFLIBS += -lelf -lebl -lz -llzma -lbz2
-      endif
       EXTLIBS += ${DWARFLIBS}
       $(call detected,CONFIG_DWARF)
     endif # PERF_HAVE_DWARF_REGS
-- 
2.13.5
