Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5E2386C3E;
	Wed, 13 May 2026 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778688329; cv=none; b=T9tLy2hMYQwZL6GjGiaRfIpgy1F3kbV+ffeD5s3DXRkgOCXCrK/jSuYE5qMurqqakgEKa+fZfCX0LS2qvGoXp7eBiVrGnFxyAFsbrZPqrynSWicVl8wD0zvWKXxC2NnghIEE3Op1Q8tZZ9absKjefu6cUuSMuLOBEURlWCf4jms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778688329; c=relaxed/simple;
	bh=dwfbr8YxSpBWCb/v6RltyyenNV+L4ch/70b7Fk5poeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYw5viOgR9Y+hENByUYCYyxq4qGb/STFqUL4et1w/0y7BZHSSP6dhT5Gt5PQcjYn1K8jISK3aBy8kPOS2ME8SlwYFRPBvIJJ0fqTzmWSXNQHpJ0C6oNidiEt4JAadlUm5NoQF9QqGZKo/BEHhCAPKas563tCaoZc//YOH4ePUKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Q91vDpCO; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Q91vDpCO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1778688323;
	bh=7zooLJmj+mZUvVlCoHTF1D45jcZXXLvz2dbvpnf172Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q91vDpCOb0v2gyxCoxdwVNuJNipcsni2xut7ms82HKUmQkx6chQn7OJvpXnGJvxoT
	 YoVDMk/q8s+R8KqAec/qR/M+YPGIA8aZWzKVmzeD8Zs7Dc1t9jYxMS78BmbdX26mh6
	 uC6ZFXek3zScQzSRwrYe2D4D5huVFRVMlKbdLIGyxeQUngMjFmOuZR+GNC7ILMKIY4
	 qyVAuI5E2+okdBGSkpd3R+sgST6pQxeH2cGp6JpjZCCxoxk5sy2y3iNAa7xqkqe+Ci
	 UCaTJYY6m0zxqBJZ9+eb5cq94UdmGksy/TfIPHmsjlzYMUhkp1Z7mU638etWHHVIWJ
	 qY5pUsVeaH2Ow==
Received: from laptop-mjeanson.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4gFywg4Czzz4Br;
	Wed, 13 May 2026 12:05:23 -0400 (EDT)
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
Subject: [PATCH v2] perf data ctf: replace libbabeltrace with babeltrace2-ctf-writer
Date: Wed, 13 May 2026 12:05:10 -0400
Message-ID: <20260513160513.236214-1-mjeanson@efficios.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260512194710.162215-1-mjeanson@efficios.com>
References: <20260512194710.162215-1-mjeanson@efficios.com>
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

This patch add a 'babeltrace2-ctf-writer' build feature using pkgconfig
detection with a fallback to 'libbabeltrace'. There's a minor change to
the API that is handled with simple preprocessor defines.

There is no changes to the output ctf traces, the ctf-writer API still
implements version 1.8 of the CTF specification that can be read by
either Babeltrace 1 / 2 or any CTF compliant reader.

Also remove some ifdefs in the cli option parsing to allow printing the
helpful error message with '--to-ctf' when built without babeltrace.

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
Changes since v1:
* Keep babeltrace 1 support as fallback
---
 tools/build/Makefile.feature                  |  3 ++
 tools/build/feature/Makefile                  |  4 ++
 .../feature/test-babeltrace2-ctf-writer.c     |  9 ++++
 tools/perf/Makefile.config                    | 24 +++++++---
 tools/perf/builtin-check.c                    |  1 +
 tools/perf/builtin-data.c                     | 20 +++-----
 .../shell/test_perf_data_converter_ctf.sh     |  9 ++--
 tools/perf/util/Build                         |  2 +-
 tools/perf/util/data-convert-bt.c             | 48 ++++++++++++-------
 tools/perf/util/data-convert.h                |  4 +-
 10 files changed, 80 insertions(+), 44 deletions(-)
 create mode 100644 tools/build/feature/test-babeltrace2-ctf-writer.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 0b7a7c38cb88..ce0bbbfa5d6c 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -114,6 +114,7 @@ FEATURE_TESTS_EXTRA :=                  \
          gtk2-infobar                   \
          hello                          \
          libbabeltrace                  \
+         babeltrace2-ctf-writer         \
          libcapstone                    \
          libbfd-liberty                 \
          libbfd-liberty-z               \
@@ -162,6 +163,7 @@ FEATURE_GROUP_MEMBERS-libbfd = libbfd-liberty libbfd-liberty-z
 # Declare list of feature dependency packages that provide pkg-config files.
 #
 FEATURE_PKG_CONFIG ?=           \
+	 babeltrace2-ctf-writer \
          libtraceevent          \
          libtracefs
 
@@ -209,6 +211,7 @@ ifeq ($(feature-all), 1)
   $(call feature_check,compile-x32)
   $(call feature_check,bionic)
   $(call feature_check,libbabeltrace)
+  $(call feature_check,babeltrace2-ctf-writer)
 else
   $(foreach feat,$(FEATURE_TESTS),$(call feature_check,$(feat)))
 endif
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 1fbcb3ce74d2..314ff4c6f14b 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -49,6 +49,7 @@ FILES=                                          \
          test-stackprotector-all.bin            \
          test-timerfd.bin                       \
          test-libbabeltrace.bin                 \
+         test-babeltrace2-ctf-writer.bin        \
          test-libcapstone.bin			\
          test-compile-32.bin                    \
          test-compile-x32.bin                   \
@@ -304,6 +305,9 @@ $(OUTPUT)test-timerfd.bin:
 $(OUTPUT)test-libbabeltrace.bin:
 	$(BUILD) # -lbabeltrace provided by $(FEATURE_CHECK_LDFLAGS-libbabeltrace)
 
+$(OUTPUT)test-babeltrace2-ctf-writer.bin:
+	$(BUILD) # -lbabeltrace2-ctf-writer provided by $(FEATURE_CHECK_LDFLAGS-babeltrace2-ctf-writer)
+
 $(OUTPUT)test-libcapstone.bin:
 	$(BUILD) # -lcapstone provided by $(FEATURE_CHECK_LDFLAGS-libcapstone)
 
diff --git a/tools/build/feature/test-babeltrace2-ctf-writer.c b/tools/build/feature/test-babeltrace2-ctf-writer.c
new file mode 100644
index 000000000000..9c89082e9f88
--- /dev/null
+++ b/tools/build/feature/test-babeltrace2-ctf-writer.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <babeltrace2-ctf-writer/writer.h>
+
+int main(void)
+{
+	bt_ctf_stream_class_get_packet_context_type((void *) 0);
+	return 0;
+}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 15fbba9f4ca8..e3d248bf2b46 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1059,14 +1059,24 @@ else
 endif
 
 ifndef NO_LIBBABELTRACE
-  $(call feature_check,libbabeltrace)
-  ifeq ($(feature-libbabeltrace), 1)
-    CFLAGS += -DHAVE_LIBBABELTRACE_SUPPORT $(LIBBABELTRACE_CFLAGS)
-    LDFLAGS += $(LIBBABELTRACE_LDFLAGS)
-    EXTLIBS += -lbabeltrace-ctf
-    $(call detected,CONFIG_LIBBABELTRACE)
+  # First check for babeltrace2-ctf-writer
+  $(call feature_check,babeltrace2-ctf-writer)
+  ifeq ($(feature-babeltrace2-ctf-writer), 1)
+    CFLAGS += -DHAVE_BABELTRACE2_CTF_WRITER_SUPPORT $(shell $(PKG_CONFIG) --cflags babeltrace2-ctf-writer)
+    LDFLAGS += $(shell $(PKG_CONFIG) --libs-only-L babeltrace2-ctf-writer)
+    EXTLIBS += $(shell $(PKG_CONFIG) --libs-only-l babeltrace2-ctf-writer)
+    $(call detected,CONFIG_BABELTRACE_CTF_WRITER)
   else
-    $(warning No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev)
+    # If we didn't find babeltrace2-ctf-writer, try for libbabeltrace1
+    $(call feature_check,libbabeltrace)
+    ifeq ($(feature-libbabeltrace), 1)
+      CFLAGS += -DHAVE_LIBBABELTRACE_SUPPORT $(LIBBABELTRACE_CFLAGS)
+      LDFLAGS += $(LIBBABELTRACE_LDFLAGS)
+      EXTLIBS += -lbabeltrace-ctf
+      $(call detected,CONFIG_BABELTRACE_CTF_WRITER)
+    else
+      $(warning No libbabeltrace or babeltrace2-ctf-writer found, disables 'perf data' CTF format support, please install libbabeltrace2-dev[el] or libbabeltrace-dev[el]/libbabeltrace-ctf-dev)
+    endif
   endif
 endif
 
diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index 3641d263b345..c0837513f9ed 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -44,6 +44,7 @@ struct feature_status supported_features[] = {
 	FEATURE_STATUS("dwarf-unwind", HAVE_DWARF_UNWIND_SUPPORT),
 	FEATURE_STATUS_TIP("libbfd", HAVE_LIBBFD_SUPPORT, "Deprecated, license incompatibility, use BUILD_NONDISTRO=1 and install binutils-dev[el]"),
 	FEATURE_STATUS("libbabeltrace", HAVE_LIBBABELTRACE_SUPPORT),
+	FEATURE_STATUS("babeltrace2-ctf-writer", HAVE_BABELTRACE2_CTF_WRITER_SUPPORT),
 	FEATURE_STATUS("libbpf-strings", HAVE_LIBBPF_STRINGS_SUPPORT),
 	FEATURE_STATUS("libcapstone", HAVE_LIBCAPSTONE_SUPPORT),
 	FEATURE_STATUS("libdw-dwarf-unwind", HAVE_LIBDW_SUPPORT),
diff --git a/tools/perf/builtin-data.c b/tools/perf/builtin-data.c
index 85f59886b5cf..9e8eacbaea74 100644
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
@@ -65,29 +63,23 @@ static int cmd_data_convert(int argc, const char **argv)
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
+#if (defined(HAVE_BABELTRACE2_CTF_WRITER_SUPPORT) || defined(HAVE_LIBBABELTRACE_SUPPORT)) \
+	&& defined(HAVE_LIBTRACEEVENT)
 		return bt_convert__perf2ctf(input_name, to_ctf, &opts);
 #else
-		pr_err("The libbabeltrace support is not compiled in. perf should be "
-		       "compiled with environment variables LIBBABELTRACE=1 and "
-		       "LIBBABELTRACE_DIR=/path/to/libbabeltrace/.\n"
-		       "Check also if libbtraceevent devel files are available.\n");
+		pr_err("The babeltrace ctf support is not compiled in. Ensure you have either\n"
+		       "libbabeltrace2-dev[el] or libbabeltrace-dev[el] installed and also\n"
+		       "libtraceevent-dev[el] or set PKG_CONFIG_PATH to find a local\n"
+		       "installation of those libraries.\n");
 		return -1;
 #endif
 	}
diff --git a/tools/perf/tests/shell/test_perf_data_converter_ctf.sh b/tools/perf/tests/shell/test_perf_data_converter_ctf.sh
index 334eebc9945e..1bcffbadf279 100755
--- a/tools/perf/tests/shell/test_perf_data_converter_ctf.sh
+++ b/tools/perf/tests/shell/test_perf_data_converter_ctf.sh
@@ -26,10 +26,13 @@ trap trap_cleanup exit term int
 
 check_babeltrace_support()
 {
-	if ! perf check feature libbabeltrace
+	if ! perf check feature babeltrace2-ctf-writer
 	then
-		echo "perf not linked with libbabeltrace, skipping test"
-		exit 2
+		if ! perf check feature libbabeltrace
+		then
+			echo "perf not linked with libbabeltrace2-ctf-writer or libbabeltrace, skipping test"
+			exit 2
+		fi
 	fi
 }
 
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index bcccad7487a9..ba222abbd3e3 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -233,7 +233,7 @@ perf-util-$(CONFIG_LIBUNWIND_X86)      += libunwind/x86_32.o
 perf-util-$(CONFIG_LIBUNWIND_AARCH64)  += libunwind/arm64.o
 
 ifeq ($(CONFIG_LIBTRACEEVENT),y)
-  perf-util-$(CONFIG_LIBBABELTRACE) += data-convert-bt.o
+  perf-util-$(CONFIG_BABELTRACE_CTF_WRITER) += data-convert-bt.o
 endif
 
 perf-util-y += data-convert-json.o
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index ba1c8e48d495..8f2060dca234 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -11,14 +11,6 @@
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
 #include "asm/bug.h"
 #include "data-convert.h"
 #include "session.h"
@@ -37,6 +29,28 @@
 #include "util/time-utils.h"
 #include "header.h"
 
+#ifdef HAVE_BABELTRACE2_CTF_WRITER_SUPPORT
+#include <babeltrace2-ctf-writer/writer.h>
+#include <babeltrace2-ctf-writer/clock.h>
+#include <babeltrace2-ctf-writer/stream.h>
+#include <babeltrace2-ctf-writer/event.h>
+#include <babeltrace2-ctf-writer/event-types.h>
+#include <babeltrace2-ctf-writer/event-fields.h>
+#include <babeltrace2-ctf-writer/utils.h>
+#elif defined(HAVE_LIBBABELTRACE_SUPPORT)
+#include <babeltrace/ctf-writer/writer.h>
+#include <babeltrace/ctf-writer/clock.h>
+#include <babeltrace/ctf-writer/stream.h>
+#include <babeltrace/ctf-writer/event.h>
+#include <babeltrace/ctf-writer/event-types.h>
+#include <babeltrace/ctf-writer/event-fields.h>
+#include <babeltrace/ctf-ir/utils.h>
+#include <babeltrace/ctf/events.h>
+
+#define bt_ctf_field_integer_signed_set_value bt_ctf_field_signed_integer_set_value
+#define bt_ctf_field_integer_unsigned_set_value bt_ctf_field_unsigned_integer_set_value
+#endif
+
 #ifdef HAVE_LIBTRACEEVENT
 #include <event-parse.h>
 #endif
@@ -121,13 +135,13 @@ static int value_set(struct bt_ctf_field_type *type,
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
@@ -374,10 +388,10 @@ static int add_tracepoint_field_value(struct ctf_writer *cw,
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
 
@@ -471,7 +485,7 @@ add_bpf_output_values(struct bt_ctf_event_class *event_class,
 		goto put_len_type;
 	}
 
-	ret = bt_ctf_field_unsigned_integer_set_value(len_field, nr_elements);
+	ret = bt_ctf_field_integer_unsigned_set_value(len_field, nr_elements);
 	if (ret) {
 		pr_err("failed to set field value for raw_len\n");
 		goto put_len_field;
@@ -500,7 +514,7 @@ add_bpf_output_values(struct bt_ctf_event_class *event_class,
 		struct bt_ctf_field *elem_field =
 			bt_ctf_field_sequence_get_field(seq_field, i);
 
-		ret = bt_ctf_field_unsigned_integer_set_value(elem_field,
+		ret = bt_ctf_field_integer_unsigned_set_value(elem_field,
 				((u32 *)(sample->raw_data))[i]);
 
 		bt_ctf_field_put(elem_field);
@@ -545,7 +559,7 @@ add_callchain_output_values(struct bt_ctf_event_class *event_class,
 		goto put_len_type;
 	}
 
-	ret = bt_ctf_field_unsigned_integer_set_value(len_field, nr_elements);
+	ret = bt_ctf_field_integer_unsigned_set_value(len_field, nr_elements);
 	if (ret) {
 		pr_err("failed to set field value for perf_callchain_size\n");
 		goto put_len_field;
@@ -575,7 +589,7 @@ add_callchain_output_values(struct bt_ctf_event_class *event_class,
 		struct bt_ctf_field *elem_field =
 			bt_ctf_field_sequence_get_field(seq_field, i);
 
-		ret = bt_ctf_field_unsigned_integer_set_value(elem_field,
+		ret = bt_ctf_field_integer_unsigned_set_value(elem_field,
 				((u64 *)(callchain->ips))[i]);
 
 		bt_ctf_field_put(elem_field);
@@ -728,7 +742,7 @@ static struct ctf_stream *ctf_stream__create(struct ctf_writer *cw, int cpu)
 		goto out;
 	}
 
-	ret = bt_ctf_field_unsigned_integer_set_value(cpu_field, (u32) cpu);
+	ret = bt_ctf_field_integer_unsigned_set_value(cpu_field, (u32) cpu);
 	if (ret) {
 		pr_err("Failed to update CPU number\n");
 		goto out;
diff --git a/tools/perf/util/data-convert.h b/tools/perf/util/data-convert.h
index ee651fa680a1..febfc0b05268 100644
--- a/tools/perf/util/data-convert.h
+++ b/tools/perf/util/data-convert.h
@@ -11,10 +11,10 @@ struct perf_data_convert_opts {
 	const char *time_str;
 };
 
-#ifdef HAVE_LIBBABELTRACE_SUPPORT
+#if defined(HAVE_BABELTRACE2_CTF_WRITER_SUPPORT) || defined(HAVE_LIBBABELTRACE_SUPPORT)
 int bt_convert__perf2ctf(const char *input_name, const char *to_ctf,
 			 struct perf_data_convert_opts *opts);
-#endif /* HAVE_LIBBABELTRACE_SUPPORT */
+#endif
 
 int bt_convert__perf2json(const char *input_name, const char *to_ctf,
 			 struct perf_data_convert_opts *opts);
-- 
2.47.3

