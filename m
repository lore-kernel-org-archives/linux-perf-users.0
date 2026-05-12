Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE8025B085;
	Tue, 12 May 2026 19:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778615247; cv=none; b=Axwsk/QfB0uf+iiSGe9bDLBtI1ZhIJqQGKfwFD/ajAqhmPbafxNMSpb3jyhfL/+T3FevlbzWV/KflHnJg2toDWl2fTF10h0HxMyfhkBGSRojqVMayn67qOqxq2lmZlIO5dAb1Ppi5vGirE/R+5ZKDSmO/VYUQB3wLXCu+149a4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778615247; c=relaxed/simple;
	bh=EcEk/qohmrJpbacVykP96vfizfoLpbBTAJKg6qVjM3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fwg6BZYVpawQHEvSzOLRmjFSmXAIzUtfcLm3oSEbktUv1dWGhBNHR3/KoIBzgXSqqVYBj56O7EggN2iUeIk+Beg5jDmFRq6E1dNlcVERXfIQkWR8+2KgIRbpAbibQIqRiT8PRrLZf6YGIPP0EIsVOwiNE1/j13QF1tdFOiqXAyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=luAVaFmv; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="luAVaFmv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1778615238;
	bh=N0rtS1bYF7zf82Fjg/D2Mn+n7P0JjAzFBKdc3PmMR4g=;
	h=From:To:Cc:Subject:Date:From;
	b=luAVaFmvCdotroD3ncJFtBm/vfRrjVz84gxoO3gvG6xM1QIdSf4Mxe+fwANav5cFB
	 IJfUrQpofpAUibGTRxG3WhXRfI2c5jrY8BWi7Ndh/cAtFBghIkxBVuhC/I10o+reUF
	 9vJqEQ9K3HSqMZ1cMdrxTrULI64Pr8LGY3WeCed8iemhnz0fmLFeBG3xTBh1F/43XF
	 lwMQQUNiKWZ7SVNuSj6oPn3Xc7IijvZjfW9KFvrMe+f60TB7bYkFol9zK+kGf6YxJA
	 Wc/rf/cg7RZgPpOaXkVuTpAaGYJUrvOHQH8C6oKp6zIzcsBREPOjezl8nbgjj1FqOv
	 3cpSsKr+EKG5g==
Received: from laptop-mjeanson.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4gFRv96sZKz2Pp;
	Tue, 12 May 2026 15:47:17 -0400 (EDT)
From: Michael Jeanson <mjeanson@efficios.com>
To: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org,
	Michael Jeanson <mjeanson@efficios.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Derek Foreman <derek.foreman@collabora.com>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] perf data ctf: replace libbabeltrace with babeltrace2-ctf-writer
Date: Tue, 12 May 2026 15:47:04 -0400
Message-ID: <20260512194710.162215-1-mjeanson@efficios.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 1.x branch of Babeltrace has been superseded by 2.x in 2020 and has
been unmaintained since 2022, efforts have started to remove it from
popular distributions.

Babeltrace 2.x offers a very similar 'ctf-writer' library that can be used
with minimal changes for the '--to-ctf' feature and has been packaged
since Debian 11 and Fedora 32.

This patch replaces the 'libbabeltrace' build feature with
'babeltrace2-ctf-writer' using pkgconfig detection, adjusts the naming of
the public headers and applies minor API cleanups.

No changes to the output ctf traces, this API still implements version
1.8 of the CTF specification that can be read by either Babeltrace 1 / 2
or any CTF compliant reader.

Also remove some ifdefs in the cli option parsing to allow printing the
helpful error message with '--to-ctf' when built without babeltrace2.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Derek Foreman <derek.foreman@collabora.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 tools/build/Makefile.feature                  |  5 +--
 tools/build/feature/Makefile                  |  6 ++--
 tools/build/feature/test-all.c                | 13 ++------
 ...ltrace.c => test-babeltrace2-ctf-writer.c} |  3 +-
 tools/perf/Makefile.config                    | 28 ++++++++--------
 tools/perf/Makefile.perf                      |  2 +-
 tools/perf/builtin-check.c                    |  2 +-
 tools/perf/builtin-data.c                     | 18 +++-------
 tools/perf/tests/make                         |  4 +--
 .../shell/test_perf_data_converter_ctf.sh     |  8 ++---
 tools/perf/util/Build                         |  2 +-
 tools/perf/util/data-convert-bt.c             | 33 +++++++++----------
 tools/perf/util/data-convert.h                |  4 +--
 13 files changed, 55 insertions(+), 73 deletions(-)
 rename tools/build/feature/{test-libbabeltrace.c => test-babeltrace2-ctf-writer.c} (59%)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 0b7a7c38cb88..9e097144817e 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -113,7 +113,7 @@ FEATURE_TESTS_EXTRA :=                  \
          gtk2                           \
          gtk2-infobar                   \
          hello                          \
-         libbabeltrace                  \
+         babeltrace2-ctf-writer         \
          libcapstone                    \
          libbfd-liberty                 \
          libbfd-liberty-z               \
@@ -162,6 +162,7 @@ FEATURE_GROUP_MEMBERS-libbfd = libbfd-liberty libbfd-liberty-z
 # Declare list of feature dependency packages that provide pkg-config files.
 #
 FEATURE_PKG_CONFIG ?=           \
+	 babeltrace2-ctf-writer \
          libtraceevent          \
          libtracefs
 
@@ -208,7 +209,7 @@ ifeq ($(feature-all), 1)
   $(call feature_check,compile-32)
   $(call feature_check,compile-x32)
   $(call feature_check,bionic)
-  $(call feature_check,libbabeltrace)
+  $(call feature_check,babeltrace2-ctf-writer)
 else
   $(foreach feat,$(FEATURE_TESTS),$(call feature_check,$(feat)))
 endif
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 1fbcb3ce74d2..7735e257c263 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -48,7 +48,7 @@ FILES=                                          \
          test-pthread-barrier.bin		\
          test-stackprotector-all.bin            \
          test-timerfd.bin                       \
-         test-libbabeltrace.bin                 \
+         test-babeltrace2-ctf-writer.bin        \
          test-libcapstone.bin			\
          test-compile-32.bin                    \
          test-compile-x32.bin                   \
@@ -301,8 +301,8 @@ $(OUTPUT)test-backtrace.bin:
 $(OUTPUT)test-timerfd.bin:
 	$(BUILD)
 
-$(OUTPUT)test-libbabeltrace.bin:
-	$(BUILD) # -lbabeltrace provided by $(FEATURE_CHECK_LDFLAGS-libbabeltrace)
+$(OUTPUT)test-babeltrace2-ctf-writer.bin:
+	$(BUILD) # -lbabeltrace2-ctf-writer provided by $(FEATURE_CHECK_LDFLAGS-babeltrace2-ctf-writer)
 
 $(OUTPUT)test-libcapstone.bin:
 	$(BUILD) # -lcapstone provided by $(FEATURE_CHECK_LDFLAGS-libcapstone)
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 1488bf6e6078..145abdee049d 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -98,17 +98,9 @@
 # include "test-sched_getcpu.c"
 #undef main
 
-# if 0
-/*
- * Disable libbabeltrace check for test-all, because the requested
- * library version is not released yet in most distributions. Will
- * reenable later.
- */
-
-#define main main_test_libbabeltrace
-# include "test-libbabeltrace.c"
+#define main main_test_babeltrace2_ctf_writer
+# include "test-babeltrace2-ctf-writer.c"
 #undef main
-#endif
 
 #define main main_test_lzma
 # include "test-lzma.c"
@@ -178,6 +170,7 @@ int main(int argc, char *argv[])
 	main_test_libzstd();
 	main_test_libtraceevent();
 	main_test_libopenssl();
+	main_test_babeltrace2_ctf_writer();
 
 	return 0;
 }
diff --git a/tools/build/feature/test-libbabeltrace.c b/tools/build/feature/test-babeltrace2-ctf-writer.c
similarity index 59%
rename from tools/build/feature/test-libbabeltrace.c
rename to tools/build/feature/test-babeltrace2-ctf-writer.c
index 10bb69d55694..9c89082e9f88 100644
--- a/tools/build/feature/test-libbabeltrace.c
+++ b/tools/build/feature/test-babeltrace2-ctf-writer.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <babeltrace/ctf-writer/writer.h>
-#include <babeltrace/ctf-ir/stream-class.h>
+#include <babeltrace2-ctf-writer/writer.h>
 
 int main(void)
 {
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 15fbba9f4ca8..f2f5051c94e3 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -196,13 +196,13 @@ FEATURE_CHECK_CFLAGS-libdw := $(LIBDW_CFLAGS)
 FEATURE_CHECK_LDFLAGS-libdw := $(LIBDW_LDFLAGS) $(DWARFLIBS)
 
 # for linking with debug library, run like:
-# make DEBUG=1 LIBBABELTRACE_DIR=/opt/libbabeltrace/
-ifdef LIBBABELTRACE_DIR
-  LIBBABELTRACE_CFLAGS  := -I$(LIBBABELTRACE_DIR)/include
-  LIBBABELTRACE_LDFLAGS := -L$(LIBBABELTRACE_DIR)/lib
+# make DEBUG=1 PKG_CONFIG_PATH=/opt/babeltrace2/(lib|lib64)/pkgconfig
+
+ifneq ($(NO_BABELTRACE2),1)
+  ifeq ($(call get-executable,$(PKG_CONFIG)),)
+    $(error Error: $(PKG_CONFIG) needed by babeltrace2 is missing on this system, please install it)
+  endif
 endif
-FEATURE_CHECK_CFLAGS-libbabeltrace := $(LIBBABELTRACE_CFLAGS)
-FEATURE_CHECK_LDFLAGS-libbabeltrace := $(LIBBABELTRACE_LDFLAGS) -lbabeltrace-ctf
 
 # for linking with debug library, run like:
 # make DEBUG=1 LIBCAPSTONE_DIR=/opt/capstone/
@@ -1058,15 +1058,15 @@ else
   NO_PERF_READ_VDSOX32 := 1
 endif
 
-ifndef NO_LIBBABELTRACE
-  $(call feature_check,libbabeltrace)
-  ifeq ($(feature-libbabeltrace), 1)
-    CFLAGS += -DHAVE_LIBBABELTRACE_SUPPORT $(LIBBABELTRACE_CFLAGS)
-    LDFLAGS += $(LIBBABELTRACE_LDFLAGS)
-    EXTLIBS += -lbabeltrace-ctf
-    $(call detected,CONFIG_LIBBABELTRACE)
+ifndef NO_BABELTRACE2
+  $(call feature_check,babeltrace2-ctf-writer)
+  ifeq ($(feature-babeltrace2-ctf-writer), 1)
+    CFLAGS += -DHAVE_BABELTRACE2_SUPPORT $(shell $(PKG_CONFIG) --cflags babeltrace2-ctf-writer)
+    LDFLAGS += $(shell $(PKG_CONFIG) --libs-only-L babeltrace2-ctf-writer)
+    EXTLIBS += $(shell $(PKG_CONFIG) --libs-only-l babeltrace2-ctf-writer)
+    $(call detected,CONFIG_BABELTRACE2)
   else
-    $(warning No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev)
+    $(warning No babeltrace2 found, disables 'perf data' CTF format support, please install libbabeltrace2-dev[el])
   endif
 endif
 
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index f7b936deeaa2..1f4e84a8472e 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -79,7 +79,7 @@ include ../scripts/utilities.mak
 #
 # Define NO_ZLIB if you do not want to support compressed kernel modules
 #
-# Define NO_LIBBABELTRACE if you do not want libbabeltrace support
+# Define NO_BABELTRACE2 if you do not want babeltrace2-ctf-writer support
 # for CTF data format.
 #
 # Define NO_CAPSTONE if you do not want libcapstone support
diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index 3641d263b345..e9d14a960a03 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -43,7 +43,7 @@ struct feature_status supported_features[] = {
 	FEATURE_STATUS("dwarf_getlocations", HAVE_LIBDW_SUPPORT),
 	FEATURE_STATUS("dwarf-unwind", HAVE_DWARF_UNWIND_SUPPORT),
 	FEATURE_STATUS_TIP("libbfd", HAVE_LIBBFD_SUPPORT, "Deprecated, license incompatibility, use BUILD_NONDISTRO=1 and install binutils-dev[el]"),
-	FEATURE_STATUS("libbabeltrace", HAVE_LIBBABELTRACE_SUPPORT),
+	FEATURE_STATUS("babeltrace2-ctf-writer", HAVE_BABELTRACE2_SUPPORT),
 	FEATURE_STATUS("libbpf-strings", HAVE_LIBBPF_STRINGS_SUPPORT),
 	FEATURE_STATUS("libcapstone", HAVE_LIBCAPSTONE_SUPPORT),
 	FEATURE_STATUS("libdw-dwarf-unwind", HAVE_LIBDW_SUPPORT),
diff --git a/tools/perf/builtin-data.c b/tools/perf/builtin-data.c
index 85f59886b5cf..260d74476439 100644
--- a/tools/perf/builtin-data.c
+++ b/tools/perf/builtin-data.c
@@ -40,10 +40,8 @@ const struct option data_options[] = {
 		OPT_INCR('v', "verbose", &verbose, "be more verbose"),
 		OPT_STRING('i', "input", &input_name, "file", "input file name"),
 		OPT_STRING(0, "to-json", &to_json, NULL, "Convert to JSON format"),
-#ifdef HAVE_LIBBABELTRACE_SUPPORT
 		OPT_STRING(0, "to-ctf", &to_ctf, NULL, "Convert to CTF format"),
 		OPT_BOOLEAN(0, "tod", &opts.tod, "Convert time to wall clock time"),
-#endif
 		OPT_BOOLEAN('f', "force", &opts.force, "don't complain, do it"),
 		OPT_BOOLEAN(0, "all", &opts.all, "Convert all events"),
 		OPT_STRING(0, "time", &opts.time_str, "str",
@@ -65,29 +63,21 @@ static int cmd_data_convert(int argc, const char **argv)
 		pr_err("You cannot specify both --to-ctf and --to-json.\n");
 		return -1;
 	}
-#ifdef HAVE_LIBBABELTRACE_SUPPORT
 	if (!to_json && !to_ctf) {
 		pr_err("You must specify one of --to-ctf or --to-json.\n");
 		return -1;
 	}
-#else
-	if (!to_json) {
-		pr_err("You must specify --to-json.\n");
-	return -1;
-}
-#endif
 
 	if (to_json)
 		return bt_convert__perf2json(input_name, to_json, &opts);
 
 	if (to_ctf) {
-#if defined(HAVE_LIBBABELTRACE_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
+#if defined(HAVE_BABELTRACE2_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
 		return bt_convert__perf2ctf(input_name, to_ctf, &opts);
 #else
-		pr_err("The libbabeltrace support is not compiled in. perf should be "
-		       "compiled with environment variables LIBBABELTRACE=1 and "
-		       "LIBBABELTRACE_DIR=/path/to/libbabeltrace/.\n"
-		       "Check also if libbtraceevent devel files are available.\n");
+		pr_err("The babeltrace2 support is not compiled in. Ensure you have both\n"
+			"libbabeltrace2-dev[el] and libtraceevent-dev[el] installed or set\n"
+			"PKG_CONFIG_PATH to find a local installation of those libraries.\n");
 		return -1;
 #endif
 	}
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 6587dc326d1b..04f9b686cec0 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -93,7 +93,7 @@ make_no_libbpf	    := NO_LIBBPF=1
 make_libbpf_dynamic := LIBBPF_DYNAMIC=1
 make_no_libbpf_DEBUG := NO_LIBBPF=1 DEBUG=1
 make_no_libllvm     := NO_LIBLLVM=1
-make_with_babeltrace:= LIBBABELTRACE=1
+make_with_babeltrace2 := BABELTRACE2=1
 make_with_coresight := CORESIGHT=1
 make_no_sdt	    := NO_SDT=1
 make_no_libpfm4     := NO_LIBPFM4=1
@@ -170,7 +170,7 @@ run += make_no_libbpf_DEBUG
 run += make_no_libllvm
 run += make_no_sdt
 run += make_no_syscall_tbl
-run += make_with_babeltrace
+run += make_with_babeltrace2
 run += make_with_coresight
 run += make_with_clangllvm
 run += make_no_libpfm4
diff --git a/tools/perf/tests/shell/test_perf_data_converter_ctf.sh b/tools/perf/tests/shell/test_perf_data_converter_ctf.sh
index 334eebc9945e..65d49a10c028 100755
--- a/tools/perf/tests/shell/test_perf_data_converter_ctf.sh
+++ b/tools/perf/tests/shell/test_perf_data_converter_ctf.sh
@@ -24,11 +24,11 @@ trap_cleanup()
 }
 trap trap_cleanup exit term int
 
-check_babeltrace_support()
+check_babeltrace2_support()
 {
-	if ! perf check feature libbabeltrace
+	if ! perf check feature babeltrace2-ctf-writer
 	then
-		echo "perf not linked with libbabeltrace, skipping test"
+		echo "perf not linked with libbabeltrace2-ctf-writer, skipping test"
 		exit 2
 	fi
 }
@@ -97,7 +97,7 @@ test_ctf_converter_pipe()
 	fi
 }
 
-check_babeltrace_support
+check_babeltrace2_support
 test_ctf_converter_file
 test_ctf_converter_pipe
 
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index bcccad7487a9..7f3b67c8eeab 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -233,7 +233,7 @@ perf-util-$(CONFIG_LIBUNWIND_X86)      += libunwind/x86_32.o
 perf-util-$(CONFIG_LIBUNWIND_AARCH64)  += libunwind/arm64.o
 
 ifeq ($(CONFIG_LIBTRACEEVENT),y)
-  perf-util-$(CONFIG_LIBBABELTRACE) += data-convert-bt.o
+  perf-util-$(CONFIG_BABELTRACE2) += data-convert-bt.o
 endif
 
 perf-util-y += data-convert-json.o
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index ba1c8e48d495..91d8cdc9e8c7 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -11,14 +11,13 @@
 #include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
-#include <babeltrace/ctf-writer/writer.h>
-#include <babeltrace/ctf-writer/clock.h>
-#include <babeltrace/ctf-writer/stream.h>
-#include <babeltrace/ctf-writer/event.h>
-#include <babeltrace/ctf-writer/event-types.h>
-#include <babeltrace/ctf-writer/event-fields.h>
-#include <babeltrace/ctf-ir/utils.h>
-#include <babeltrace/ctf/events.h>
+#include <babeltrace2-ctf-writer/writer.h>
+#include <babeltrace2-ctf-writer/clock.h>
+#include <babeltrace2-ctf-writer/stream.h>
+#include <babeltrace2-ctf-writer/event.h>
+#include <babeltrace2-ctf-writer/event-types.h>
+#include <babeltrace2-ctf-writer/event-fields.h>
+#include <babeltrace2-ctf-writer/utils.h>
 #include "asm/bug.h"
 #include "data-convert.h"
 #include "session.h"
@@ -121,13 +120,13 @@ static int value_set(struct bt_ctf_field_type *type,
 	}
 
 	if (sign) {
-		ret = bt_ctf_field_signed_integer_set_value(field, val);
+		ret = bt_ctf_field_integer_signed_set_value(field, val);
 		if (ret) {
 			pr_err("failed to set field value %s\n", name);
 			goto err;
 		}
 	} else {
-		ret = bt_ctf_field_unsigned_integer_set_value(field, val);
+		ret = bt_ctf_field_integer_unsigned_set_value(field, val);
 		if (ret) {
 			pr_err("failed to set field value %s\n", name);
 			goto err;
@@ -374,10 +373,10 @@ static int add_tracepoint_field_value(struct ctf_writer *cw,
 					data + offset + i * len, len);
 
 			if (!(flags & TEP_FIELD_IS_SIGNED))
-				ret = bt_ctf_field_unsigned_integer_set_value(
+				ret = bt_ctf_field_integer_unsigned_set_value(
 						field, value_int);
 			else
-				ret = bt_ctf_field_signed_integer_set_value(
+				ret = bt_ctf_field_integer_signed_set_value(
 						field, adjust_signedness(value_int, len));
 		}
 
@@ -471,7 +470,7 @@ add_bpf_output_values(struct bt_ctf_event_class *event_class,
 		goto put_len_type;
 	}
 
-	ret = bt_ctf_field_unsigned_integer_set_value(len_field, nr_elements);
+	ret = bt_ctf_field_integer_unsigned_set_value(len_field, nr_elements);
 	if (ret) {
 		pr_err("failed to set field value for raw_len\n");
 		goto put_len_field;
@@ -500,7 +499,7 @@ add_bpf_output_values(struct bt_ctf_event_class *event_class,
 		struct bt_ctf_field *elem_field =
 			bt_ctf_field_sequence_get_field(seq_field, i);
 
-		ret = bt_ctf_field_unsigned_integer_set_value(elem_field,
+		ret = bt_ctf_field_integer_unsigned_set_value(elem_field,
 				((u32 *)(sample->raw_data))[i]);
 
 		bt_ctf_field_put(elem_field);
@@ -545,7 +544,7 @@ add_callchain_output_values(struct bt_ctf_event_class *event_class,
 		goto put_len_type;
 	}
 
-	ret = bt_ctf_field_unsigned_integer_set_value(len_field, nr_elements);
+	ret = bt_ctf_field_integer_unsigned_set_value(len_field, nr_elements);
 	if (ret) {
 		pr_err("failed to set field value for perf_callchain_size\n");
 		goto put_len_field;
@@ -575,7 +574,7 @@ add_callchain_output_values(struct bt_ctf_event_class *event_class,
 		struct bt_ctf_field *elem_field =
 			bt_ctf_field_sequence_get_field(seq_field, i);
 
-		ret = bt_ctf_field_unsigned_integer_set_value(elem_field,
+		ret = bt_ctf_field_integer_unsigned_set_value(elem_field,
 				((u64 *)(callchain->ips))[i]);
 
 		bt_ctf_field_put(elem_field);
@@ -728,7 +727,7 @@ static struct ctf_stream *ctf_stream__create(struct ctf_writer *cw, int cpu)
 		goto out;
 	}
 
-	ret = bt_ctf_field_unsigned_integer_set_value(cpu_field, (u32) cpu);
+	ret = bt_ctf_field_integer_unsigned_set_value(cpu_field, (u32) cpu);
 	if (ret) {
 		pr_err("Failed to update CPU number\n");
 		goto out;
diff --git a/tools/perf/util/data-convert.h b/tools/perf/util/data-convert.h
index ee651fa680a1..d174e6f2729d 100644
--- a/tools/perf/util/data-convert.h
+++ b/tools/perf/util/data-convert.h
@@ -11,10 +11,10 @@ struct perf_data_convert_opts {
 	const char *time_str;
 };
 
-#ifdef HAVE_LIBBABELTRACE_SUPPORT
+#ifdef HAVE_BABELTRACE2_SUPPORT
 int bt_convert__perf2ctf(const char *input_name, const char *to_ctf,
 			 struct perf_data_convert_opts *opts);
-#endif /* HAVE_LIBBABELTRACE_SUPPORT */
+#endif /* HAVE_BABELTRACE2_SUPPORT */
 
 int bt_convert__perf2json(const char *input_name, const char *to_ctf,
 			 struct perf_data_convert_opts *opts);
-- 
2.47.3

