From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/10] perf build: Do not use -Wshadow on gcc < 4.8
Date: Tue, 23 Jul 2019 17:05:30 -0300
Message-ID: <20190723200530.14090-11-acme@kernel.org>
References: <20190723200530.14090-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190723200530.14090-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As it is too strict, see https://lkml.org/lkml/2006/11/28/253 and
https://gcc.gnu.org/gcc-4.8/changes.html, that takes into account
Linus's comments (search for Wshadow) for the reasoning about -Wshadow
not being interesting before gcc 4.8.

Acked-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/r/20190719183417.GQ3624@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/scripts/Makefile.include | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 495066bafbe3..ded7a950dc40 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -32,7 +32,6 @@ EXTRA_WARNINGS += -Wno-system-headers
 EXTRA_WARNINGS += -Wold-style-definition
 EXTRA_WARNINGS += -Wpacked
 EXTRA_WARNINGS += -Wredundant-decls
-EXTRA_WARNINGS += -Wshadow
 EXTRA_WARNINGS += -Wstrict-prototypes
 EXTRA_WARNINGS += -Wswitch-default
 EXTRA_WARNINGS += -Wswitch-enum
@@ -69,8 +68,16 @@ endif
 # will do for now and keep the above -Wstrict-aliasing=3 in place
 # in newer systems.
 # Needed for the __raw_cmpxchg in tools/arch/x86/include/asm/cmpxchg.h
+#
+# See https://lkml.org/lkml/2006/11/28/253 and https://gcc.gnu.org/gcc-4.8/changes.html,
+# that takes into account Linus's comments (search for Wshadow) for the reasoning about
+# -Wshadow not being interesting before gcc 4.8.
+
 ifneq ($(filter 3.%,$(MAKE_VERSION)),)  # make-3
 EXTRA_WARNINGS += -fno-strict-aliasing
+EXTRA_WARNINGS += -Wno-shadow
+else
+EXTRA_WARNINGS += -Wshadow
 endif
 
 ifneq ($(findstring $(MAKEFLAGS), w),w)
-- 
2.21.0
