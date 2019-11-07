From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 32/63] libsubcmd: Move EXTRA_FLAGS to the end to allow overriding existing flags
Date: Thu,  7 Nov 2019 15:59:40 -0300
Message-ID: <20191107190011.23924-33-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, James Clark <James.Clark@arm.com>, James Clark <james.clark@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>, Josh Poimboeuf <jpoimboe@redhat.com>, nd <nd@arm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: James Clark <James.Clark@arm.com>

Move EXTRA_WARNINGS and EXTRA_FLAGS to the end of the compilation line,
otherwise they cannot be used to override the default values.

Signed-off-by: James Clark <james.clark@arm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@arm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: nd <nd@arm.com>
Link: http://lore.kernel.org/lkml/20191028113340.4282-1-james.clark@arm.com
[ split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/subcmd/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
index 5b2cd5e58df0..352c6062deba 100644
--- a/tools/lib/subcmd/Makefile
+++ b/tools/lib/subcmd/Makefile
@@ -19,8 +19,7 @@ MAKEFLAGS += --no-print-directory
 
 LIBFILE = $(OUTPUT)libsubcmd.a
 
-CFLAGS := $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
-CFLAGS += -ggdb3 -Wall -Wextra -std=gnu99 -fPIC
+CFLAGS := -ggdb3 -Wall -Wextra -std=gnu99 -fPIC
 
 ifeq ($(DEBUG),0)
   ifeq ($(feature-fortify-source), 1)
@@ -43,6 +42,8 @@ CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE
 
 CFLAGS += -I$(srctree)/tools/include/
 
+CFLAGS += $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
+
 SUBCMD_IN := $(OUTPUT)libsubcmd-in.o
 
 all:
-- 
2.21.0
