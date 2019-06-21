From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 23/25] tools build: Add test to check if slang.h is in /usr/include/slang/
Date: Fri, 21 Jun 2019 14:38:29 -0300
Message-ID: <20190621173831.13780-24-acme@kernel.org>
References: <20190621173831.13780-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190621173831.13780-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Florian Fainelli <f.fainelli@gmail.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

A few odd old distros (rhel5, 6, yeah, lots of those out in use, in many
cases we want to use upstream perf on it) have the slang header files in
/usr/include/slang/, so add a test that will be performed only when
test-all.c (the one with the most common sane settings) fails, either
because we're in one of these odd distros with slang/slang.h or because
something else failed (say libelf is not present).

So for the common case nothing changes, no additional test is performed.

Next step is to check in perf the result of these tests.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: 1955c8cf5e26 ("perf tools: Don't hardcode host include path for libslang")
Link: https://lkml.kernel.org/n/tip-2sy7hbwkx68jr6n97qxgg0c6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature                       | 2 +-
 tools/build/feature/Makefile                       | 4 ++++
 tools/build/feature/test-libslang-include-subdir.c | 7 +++++++
 3 files changed, 12 insertions(+), 1 deletion(-)
 create mode 100644 tools/build/feature/test-libslang-include-subdir.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 50377cc2f5f9..86b793dffbc4 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -53,6 +53,7 @@ FEATURE_TESTS_BASIC :=                  \
         libpython                       \
         libpython-version               \
         libslang                        \
+        libslang-include-subdir         \
         libcrypto                       \
         libunwind                       \
         pthread-attr-setaffinity-np     \
@@ -114,7 +115,6 @@ FEATURE_DISPLAY ?=              \
          numa_num_possible_cpus \
          libperl                \
          libpython              \
-         libslang               \
          libcrypto              \
          libunwind              \
          libdw-dwarf-unwind     \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 7ef7cf04a292..0658b8cd0e53 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -31,6 +31,7 @@ FILES=                                          \
          test-libpython.bin                     \
          test-libpython-version.bin             \
          test-libslang.bin                      \
+         test-libslang-include-subdir.bin       \
          test-libcrypto.bin                     \
          test-libunwind.bin                     \
          test-libunwind-debug-frame.bin         \
@@ -184,6 +185,9 @@ $(OUTPUT)test-libaudit.bin:
 $(OUTPUT)test-libslang.bin:
 	$(BUILD) -lslang
 
+$(OUTPUT)test-libslang-include-subdir.bin:
+	$(BUILD) -lslang
+
 $(OUTPUT)test-libcrypto.bin:
 	$(BUILD) -lcrypto
 
diff --git a/tools/build/feature/test-libslang-include-subdir.c b/tools/build/feature/test-libslang-include-subdir.c
new file mode 100644
index 000000000000..3ea47ec7590e
--- /dev/null
+++ b/tools/build/feature/test-libslang-include-subdir.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <slang/slang.h>
+
+int main(void)
+{
+	return SLsmg_init_smg();
+}
-- 
2.20.1
