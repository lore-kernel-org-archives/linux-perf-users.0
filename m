Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794884002;
	b=HdR9lRA99Pm0IQgFpvdXP9jLbZlmBMLfJzYwZ+IuIbYwjs+mYbx7THqcnluF56oYY5pF
	 8tTipTFOnwHT6VliqpgGM3YVS1zSpyQqm1VqzKYAjS/ZAcTjBBwrJkekonR0YrjywDzSE
	 VnogNU0f6bWabtzw7+jF31iHl+wp+kzmkC4WUVhrbJo/eUUbhrUUkBSZmPiUCBcbbCbTv
	 /m5vqF9QEw7TvD86gw6HWFfg34LKjxGnvGlp0WzGkz+PIS/Xpuw5800MuyRMNC8XkHcKz
	 Fhw4/uVhKCMjoBG3Yi6NDdedTprO5dlbvPY/FSx5nNm/VBdbHlLXD6Mevo7CslMemAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794884002;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wDSHrl19x4u1Yd9AGjpDlXYjaERCjFsg51HzQ1fImms=;
	b=I538/QUDciQOlFPiMFzcttUS2udVUgkLTlfRWJHSDzTjAwGLoDCGn9ecH+r1SDZzK8md
	 wDBP1tykGToerfIyyvW0jU3fbvbteKlt+E/iG2sU3JbKVXNK6NEYF/4Rw9dwv8A2LMG+M
	 U52E2z9ndT3xUb3w8RUCq2Cr7jCxbGxUuW0wHCWc22TcKfvdM0F6Bg8g3wIy4gEUGFBeX
	 tQJ6h6eVw/xdftJdlADTIUtUtBv482iF+3NswDwI4r9lUm/ZolDAKQbsA80lcgJ6vlESR
	 Sbpk65NWZonWrzqnXaberDhl67nzkq8V6cxkKUcCRNMjRJJQLe19zlzq9Mt6/Q0pPqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gZQ9Faex;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D097E606A31C;
	Tue, 17 Nov 2026 02:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gZQ9Faex
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8CC1F000C4;
	Tue, 17 Nov 2026 02:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794884002;
	bh=wDSHrl19x4u1Yd9AGjpDlXYjaERCjFsg51HzQ1fImms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gZQ9Faexe2C8z5jhyaMBS5JSweyBODZWrldhODFJWOYcoRKU4QeLNB1UZzSMpsTAe
	 UZ1gR/YsRD/EsH2kuRzxszsTlL/Ma1wHLR3qoXV5nRbKKZBcrH3D3L7tofqSl0TZ2G
	 ITMQ9yXyavxg+Y4DSfRWL8wkawrEDoPi7OHNVWngSF8BibQRz2A9hoirJNkm8t+ku5
	 APy6GU9xuXIzlpauT4YbaRvDe5lnaQF1sj6qWhntGB4r6MVIqq6CKY9izQU0xU3ng5
	 umENLH3gM6LHk9SCVZ8yIgd4i+MsgMpZgedtUKaxa7HVXb3dmBiTOc0JvS1ga4BgK1
	 daHdtsFHwRwXA==
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
Subject: [PATCH v5 03/12] perf tests: Exercise DW_OP_addrx global variables
Date: Mon, 16 Nov 2026 23:52:55 -0300
Message-ID: <20261117025305.3958882-4-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117025305.3958882-1-acme@kernel.org>
References: <20261117025305.3958882-1-acme@kernel.org>
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
struct in .bss and the test checks that its accesses are annotated, so
the DW_OP_addrx path is exercised when perf is built with clang and
DWARF 5, and the DW_OP_addr one with gcc.  It skips on 32-bit PIE
builds, which load globals through the GOT and the resolver does not
follow those.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c            |  1 +
 tools/perf/tests/shell/data_type_global.sh | 70 ++++++++++++++++++++++
 tools/perf/tests/tests.h                   |  1 +
 tools/perf/tests/workloads/Build           |  2 +
 tools/perf/tests/workloads/global_data.c   | 55 +++++++++++++++++
 5 files changed, 129 insertions(+)
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
index 0000000000000000..7db2e898a41657bc
--- /dev/null
+++ b/tools/perf/tests/shell/data_type_global.sh
@@ -0,0 +1,70 @@
+#!/bin/bash
+# perf data type profiling test for a global variable
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+perfout=$(mktemp /tmp/__perf_test.perf.out.XXXXX)
+
+cleanup()
+{
+	rm -f "$perfdata" "$perfout"
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
+# 32-bit PIE loads globals through the GOT, which the resolver does not follow
+if [ "$(getconf LONG_BIT)" = 32 ] &&
+   [ "$(od -An -tx1 -j16 -N2 "$(command -v perf)" | awk '{print $1}')" = 03 ]; then
+	echo "Skip: 32-bit PIE uses GOT-relative global accesses"
+	cleanup
+	exit 2
+fi
+
+# No point in recording if the PMU cannot do memory events.
+if perf mem record -o /dev/null -- true 2>&1 | \
+		grep -q "failed: no PMU supports the memory events"; then
+	cleanup
+	exit 2
+fi
+if ! perf mem record -o /dev/null -- true 2>/dev/null; then
+	echo "Skip: cannot record memory events on this PMU"
+	cleanup
+	exit 2
+fi
+
+if ! perf mem record -o "$perfdata" -- perf test -w global_data 1 > /dev/null 2>&1; then
+	echo "FAIL: perf mem record"
+	cleanup
+	exit 1
+fi
+
+if ! perf annotate --code-with-type -i "$perfdata" --stdio \
+		--percent-limit 1 > "$perfout" 2>/dev/null; then
+	echo "FAIL: perf annotate"
+	cleanup
+	exit 1
+fi
+
+if ! grep -q "# data-type: struct conn" "$perfout"; then
+	echo "FAIL: global variable in .bss not resolved"
+	cleanup
+	exit 1
+fi
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
index 0000000000000000..63da5300c5d92387
--- /dev/null
+++ b/tools/perf/tests/workloads/global_data.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A zero initialized global struct, so it lands in .bss, past the file
+ * backed end of the last segment.  clang describes its address with
+ * DW_OP_addrx in DWARF 5, gcc with DW_OP_addr.
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
+	int i = 0;
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
2.56.0

