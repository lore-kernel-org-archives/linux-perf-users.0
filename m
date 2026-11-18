Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039057;
	b=HaarVg3tPM54eI7J6NnwK8LmEQmS3U6ZVc1kGIIAYopUz8OeIx7Gdu09TsKO/kuhG3IT
	 tZfGduhdaxm6ORzjDZJIpE0C/RSsN2/XHB94md01SDU6kmazVw67o6IiqSd7TJ4L9FrBu
	 +UVqHA12qvf0ZLmn2UAMlcilOCscqwd42txFJpFXdy9yYqcw1jcpMY7MsXIugY5zjgWpa
	 zw80tERehT4X8khTNEPSpkOVPNEaC/0sH0v4xMuvowt+Qf/fTbiuOOh4+Jppqr1/rzBdB
	 3GwFU3e+p05Q+QWFpoVO/yuL/5c7lJ4N7xWKmCbjalsDR+/o4I6gPK6OocRrm6Ea0sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039057;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dCpUFQTmfxMvrYVOEbCqJQSqnG5loUq97vjZxowCiuU=;
	b=CdaebveWCa6q1uJmN4E+U5nyz58qjK2rOAOstqmgO2lj9thM3OaIzm7RKEnG7BKiDq7e
	 NvxPpe98RBNPb59nRuYJZw5fB2QzGGSDxNd4tcjiGB3Qjs6RKFTZMGZxsnpBCWJKd8CF9
	 A4JM8/6Oz7AqcI0a5UVg/WfJ6xJr5jt2dpR0dHZZ0GMrHgqC0FNI4eItlxb3l1ddoI8D5
	 O9Vn7KFAJuUNTAjqO5xxrNJFTMaJMMZIU9Q0Qe+As3N8hJjDpZ0ftBalwOuLVpHWHWLx/
	 lW8Aw5pwCwi9khfZpXGZyaAJiTsqbVUmY80kYyAUAEABONSqAYb0GFduFBc+i9Wdt9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KQHdF7+v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3C9606A32A;
	Wed, 18 Nov 2026 21:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KQHdF7+v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7BB1F000C9;
	Wed, 18 Nov 2026 21:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795039057;
	bh=dCpUFQTmfxMvrYVOEbCqJQSqnG5loUq97vjZxowCiuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KQHdF7+vn+3DU6RNldsfqjbHylbrny5FRbGOv7JSdJWpD+2mGO9G/Rjfmd64D5Y1l
	 QaEgnTPxIbpsnSeD/BvccyzGl/AImtSf9M8SwCzvzmsLet60b0MdXZpynt29Zqqax2
	 TPIyVSzrhm6RuvEp0FxagragJnMcar+CHx8r6DiKncsPWwOwhlCOEAhvghu8iK2JVg
	 9Kh3j9SXsKegwOUb/9ZT5/1hRtWE8M5BHo0dk4zZoZAS2XpUPGDRTlorHSUtSfZEjA
	 xIwcukh6ceoZFsZjnVE7RbkwyXK7pZvMY0BAahaUO/LkTCuG3Y9GgBLVNQCFmVbzIc
	 fZHE0XN1NGbhA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v7 04/13] perf tests: Exercise DW_OP_addrx global variables
Date: Wed, 18 Nov 2026 18:57:06 -0300
Message-ID: <20261118215716.114868-5-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118215716.114868-1-acme@kernel.org>
References: <20261118215716.114868-1-acme@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

clang emits DW_AT_location with DW_OP_addrx for globals in DWARF 5, gcc
emits DW_OP_addr.  The global_data workload keeps a zero initialized
struct in .bss: at run time it sits past the file backed mapping, where
the by-name fallback through the thread maps cannot find it, so only the
DWARF address lookup resolves it.  The test checks that its three member
accesses are annotated, so the DW_OP_addrx path is exercised when perf
is built with clang and DWARF 5 (e.g. coverage.sh --dwarf-version 5),
and the DW_OP_addr one with gcc.

It skips on 32-bit PIE builds, which reach static globals relative to
the GOT base register, and the resolver does not track that.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c            |  1 +
 tools/perf/tests/shell/data_type_global.sh | 73 ++++++++++++++++++++++
 tools/perf/tests/tests.h                   |  1 +
 tools/perf/tests/workloads/Build           |  2 +
 tools/perf/tests/workloads/global_data.c   | 57 +++++++++++++++++
 5 files changed, 134 insertions(+)
 create mode 100755 tools/perf/tests/shell/data_type_global.sh
 create mode 100644 tools/perf/tests/workloads/global_data.c

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 327483f96401b580..e056a3d3594ff8a2 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -213,6 +213,7 @@ static struct test_workload *workloads[] = {
 	&workload__deterministic,
 	&workload__callchain,
 	&workload__false_sharing,
+	&workload__global_data,
 
 #ifdef HAVE_RUST_SUPPORT
 	&workload__code_with_type,
diff --git a/tools/perf/tests/shell/data_type_global.sh b/tools/perf/tests/shell/data_type_global.sh
new file mode 100755
index 0000000000000000..11fbf852b44cfaad
--- /dev/null
+++ b/tools/perf/tests/shell/data_type_global.sh
@@ -0,0 +1,73 @@
+#!/bin/bash
+# perf data type profiling test for a global variable
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+perfout=$(mktemp /tmp/__perf_test.perf.out.XXXXX)
+perferr=$(mktemp /tmp/__perf_test.perf.err.XXXXX)
+
+cleanup()
+{
+	rm -f "$perfdata" "$perfout" "$perferr"
+	trap - EXIT TERM INT
+}
+
+trap_cleanup()
+{
+	echo "Unexpected signal in ${FUNCNAME[1]}"
+	cleanup
+	exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+if ! perf check feature -q dwarf; then
+	echo "Skip: no DWARF (libdw) support"
+	cleanup
+	exit 2
+fi
+
+# 32-bit x86 PIE reaches static globals relative to the GOT base register,
+# which the resolver does not track; e_type's low byte is at 16 on LE x86.
+perf_bin=$(command -v perf)
+if [ "$(od -An -tx1 -j4 -N1 "$perf_bin" | tr -d ' ')" = 01 ] &&
+   [ "$(od -An -tx1 -j16 -N1 "$perf_bin" | tr -d ' ')" = 03 ]; then
+	echo "Skip: 32-bit PIE uses GOT-relative global accesses"
+	cleanup
+	exit 2
+fi
+
+# No point in recording if the PMU cannot do memory events.
+if ! perf mem record -o /dev/null -- true 2>/dev/null; then
+	echo "Skip: cannot record memory events on this PMU"
+	cleanup
+	exit 2
+fi
+
+if ! perf mem record -o "$perfdata" -- perf test -w global_data 1 \
+		> /dev/null 2> "$perferr"; then
+	echo "FAIL: perf mem record"
+	cat "$perferr"
+	cleanup
+	exit 1
+fi
+
+if ! perf annotate --code-with-type -i "$perfdata" --stdio \
+		--percent-limit 1 > "$perfout"; then
+	echo "FAIL: perf annotate"
+	cleanup
+	exit 1
+fi
+
+for member in "+0 (saddr)" "+0x4 (daddr)" "+0x8 (bytes)"; do
+	if ! grep -Fq "# data-type: struct conn ${member}" "$perfout"; then
+		echo "FAIL: member ${member} not resolved"
+		grep 'struct conn' "$perfout"
+		cleanup
+		exit 1
+	fi
+done
+
+echo "global variable resolved"
+cleanup
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index af822885890dda73..049a164503166529 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -273,6 +273,7 @@ DECLARE_WORKLOAD(context_switch_loop);
 DECLARE_WORKLOAD(deterministic);
 DECLARE_WORKLOAD(callchain);
 DECLARE_WORKLOAD(false_sharing);
+DECLARE_WORKLOAD(global_data);
 
 #ifdef HAVE_RUST_SUPPORT
 DECLARE_WORKLOAD(code_with_type);
diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
index 43cc4da6fb0786de..03017aaaaa0bec32 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -17,6 +17,7 @@ perf-test-y += context_switch_loop.o
 perf-test-y += deterministic.o
 perf-test-y += callchain.o
 perf-test-y += false_sharing.o
+perf-test-y += global_data.o
 
 ifeq ($(CONFIG_RUST_SUPPORT),y)
     perf-test-y += code_with_type.o
@@ -35,3 +36,4 @@ CFLAGS_deterministic.o    = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_named_threads.o    = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_callchain.o        = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_false_sharing.o    = -g -O0 -fno-inline -U_FORTIFY_SOURCE
+CFLAGS_global_data.o      = -g -O0 -fno-inline -U_FORTIFY_SOURCE
diff --git a/tools/perf/tests/workloads/global_data.c b/tools/perf/tests/workloads/global_data.c
new file mode 100644
index 0000000000000000..5973f7bb16fd007c
--- /dev/null
+++ b/tools/perf/tests/workloads/global_data.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A zero initialized global struct, so it lands in .bss, past the file
+ * backed end of the last segment: at run time it sits in an anonymous
+ * mapping that the thread maps do not name, so only the DWARF address
+ * lookup finds it.  clang describes its address with DW_OP_addrx in
+ * DWARF 5, gcc with DW_OP_addr.
+ *
+ * 'perf mem record' of this workload followed by 'perf annotate
+ * --code-with-type' (see tests/shell/data_type_global.sh) resolves the
+ * accesses to struct conn.
+ */
+#include <signal.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <linux/compiler.h>
+#include "../tests.h"
+
+struct conn {
+	int saddr;
+	int daddr;
+	long bytes;
+};
+
+static volatile struct conn conn;
+static volatile unsigned long conn_sink;
+static volatile sig_atomic_t done;
+
+static void sighandler(int sig __maybe_unused)
+{
+	done = 1;
+}
+
+static int global_data(int argc, const char **argv)
+{
+	unsigned long sum = 0;
+	unsigned int i = 0;
+	int sec = 1;
+
+	if (argc > 0)
+		sec = atoi(argv[0]);
+
+	signal(SIGINT, sighandler);
+	signal(SIGALRM, sighandler);
+	alarm(sec);
+
+	while (!done) {
+		conn.saddr = i;
+		conn.daddr = i + 1;
+		sum += conn.bytes;
+		i++;
+	}
+	conn_sink = sum;
+	return 0;
+}
+
+DEFINE_WORKLOAD(global_data);
-- 
2.56.1

