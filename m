From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/16] perf python: Make sure the python binding output directory is in place
Date: Fri,  4 Jan 2019 15:33:36 -0300
Message-ID: <20190104183337.12771-16-acme@kernel.org>
References: <20190104183337.12771-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190104183337.12771-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Instead of doing an unconditional mkdir, use a dummy Makefile variable
to check if the directory is there and if not, create it.

This is better than what we had and will help with other python bindings
that are in development, like one involved with python backtraces.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-iis6us2nocw3y4uuoon9osd7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index ff29c3372ec3..2921f829a0f4 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -524,12 +524,14 @@ $(arch_errno_name_array): $(arch_errno_tbl)
 
 all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
 
+# Create python binding output directory if not already present
+_dummy := $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
+
 $(OUTPUT)python/perf.so: $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBTRACEEVENT_DYNAMIC_LIST)
 	$(QUIET_GEN)LDSHARED="$(CC) -pthread -shared" \
         CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS) $(LIBTRACEEVENT_DYNAMIC_LIST_LDFLAGS)' \
 	  $(PYTHON_WORD) util/setup.py \
 	  --quiet build_ext; \
-	mkdir -p $(OUTPUT)python && \
 	cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/
 
 please_set_SHELL_PATH_to_a_more_modern_shell:
-- 
2.20.1
