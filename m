Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795383664;
	b=4IKH0r5iQ+WRfthJ2wq3mcG/tDd36/cOTUB7bDHwvpwusq6+HTllCHasTh5UeJGeVINA
	 61+met/ZMS3WCjlMADKo3+ZcJVA2HfhLpMptQUZOMJMxXR+G2Fbww9EwmRnEb0zwBqD/n
	 IC+6GD0vOcD4CEMn0p5Yc0SknzuB3riPfr1VCUZ2Dzn5MeiRbL36ZvZ1KH+dkVAaq7r+D
	 rX3MO0xlxIdSUvat2ssESjQm6h0f8p6THGwPQC6hRcTfiW4hOB0ws/1VC0J7xAJv6k5Qp
	 sTcn7deAXBjKSVq6E6jv2QMsMPbnLz3UzhYZz0c/U02LXfDwwK47t3rch8seqrYMzrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795383664;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Iq5zUfVQqMQript0+eZ1oKQiZ3XIGe6hzC7xV46y690=;
	b=1juWdTMnxptCaZUzBGVM6DQamqPCwGhIFQPgC2qYZ+fSTbGu5bN75X7uhNQ2bgbgtWml
	 7Cfy8eoxFJtD++iCM6twYZFHHO6qK1OAgPqY+F8n+XEzU2+flQ/NjE1mqWylAI5m31Nva
	 KCHPiE0ZfoWwFAD/ETjrkRKK30Pcd+pUPGg41Qewf7/OkU3ZgHneFIvCqguTlXGYX1rza
	 P4XjXuJbEE/lDgvCzHqZMKb6RA7eNbyOeOlVT9ksZuurNBPvcRiugsCBI23sdB/cNsP2p
	 ej0UZRBpelyomjtTOxj/+LSsaMIiDmHcFLkqDm7KaViawPhozBkwA9wm/6WYFUWQrAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N9r7XNc+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA014606A31D;
	Sun, 22 Nov 2026 21:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N9r7XNc+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912141F000D0;
	Sun, 22 Nov 2026 21:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795383664;
	bh=Iq5zUfVQqMQript0+eZ1oKQiZ3XIGe6hzC7xV46y690=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N9r7XNc+lLstorWFT2OfcHChF+UCZQzC4oTrJB+Hjh4swujx4fkDDboXlSSodXHPJ
	 BNTuQ5jomXTTRRSvgjA++n4bvqv4Z68/xyP5S/noqQR6uplg4HFdZaHZDR50ceYLEd
	 7/tpR5+slazNxG/tHjVfVdbbdvFbdT9wp3wCJ4eeOYX5/e8B8OcHvT79ixS5dCGTO2
	 w8wQF/r8I8ciIJEyr7llCah0GpUGnsi4fTSt0KyHLiYQWDVTwge0M4bDqKZms9DNCY
	 vvLYxXAbpj64MGTQFJSMdpg+NfOc6Na1UxYmdPfwmsElAgVAICfR3ROoP3mrHLYTTg
	 TllY5+J8CdCtQ==
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
Subject: [PATCH v11 09/19] perf test: Exercise DW_OP_addrx global variables
Date: Sun, 22 Nov 2026 18:40:15 -0300
Message-ID: <20261122214025.16769-10-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261122214025.16769-1-acme@kernel.org>
References: <20261122214025.16769-1-acme@kernel.org>
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
is built with clang and DWARF 5 (e.g. scripts/coverage.sh with
DWARF_VERSION=5), and the DW_OP_addr one with gcc.

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
index a27baf3a819ccf36..42e85d1b1420f0a7 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -214,6 +214,7 @@ static struct test_workload *workloads[] = {
 	&workload__deterministic,
 	&workload__callchain,
 	&workload__false_sharing,
+	&workload__global_data,
 
 #ifdef HAVE_RUST_SUPPORT
 	&workload__code_with_type,
diff --git a/tools/perf/tests/shell/data_type_global.sh b/tools/perf/tests/shell/data_type_global.sh
new file mode 100755
index 0000000000000000..14f57d5a1b26a5ea
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
+		grep 'struct conn' "$perfout" || true
+		cleanup
+		exit 1
+	fi
+done
+
+echo "global variable resolved"
+cleanup
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 963cb34acd345153..63d49a960eab8f3c 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -274,6 +274,7 @@ DECLARE_WORKLOAD(context_switch_loop);
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

