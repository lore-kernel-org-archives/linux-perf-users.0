Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945894;
	b=CKlw8maIhLaPN4Nc4y0e1/2X8HlyoyoL/iVGcNpsGmQTvFUaj6edTgub2n6sseV12EVn
	 1j8cnstOUksuqASi9MTMvPt4yBU32bceeo5+gQbffnB4DfCY4OxUqF/qhmIs0i0rpqaz0
	 vLjEnpNKAuLs4cOueZxUW1uHhP1ZW8CpQUJD/TJwLhhAHQOI8Ich1dzXPXmhDbHsDeCaB
	 vwAbVwapTGzZ73bXl/9M1KK5oeuwbhkJr3AHWlLkgctr5mx7Sh6Telbbgi1oubI2iuQv4
	 9zO7jerM+SeoBQlrq4dzbCXL7J+Uj8OE8xurMXdG5xKzTJDXtCSoKFqrOFGyfksDSmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945894;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YbLk9lyJPOShMv8agNUeIw0Brlh3Xg0eS6eUOD+x1VU=;
	b=Ne4kDAMjKUUTarv5etNOUFhF7+QPCHVVa/ElXP4vzHp9IcoJRO6hSeIEnEQndjZk185r
	 RbowUF0FtST8k+aWDO7MhGpbDvjpUDHHAVzfA8qOIsLQDKx4hpQvm3qeBZxktnkwTyc+P
	 u2Vj5CPtCK8F98NTDuds4J1U1SGoyeYZHCRUDz/tHY3s00R2Sb19KVwfeZDFKQ5RPYAkb
	 1f1+6g1g1YDBSiRx6KtLO7Kz7nlIAELtaAwmsIcBqKVPoH6VH3oubXJoEaQx0g7aBWl1D
	 ZGGyqhV55YWRK+Kj51HAc3zQ/PWCBpuzUI7AcuOfScHaCOLy3MyfR+fKKIrHLQ4S1BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NBja8i01;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB5B606A895;
	Tue, 17 Nov 2026 20:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NBja8i01
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3D61F000C6;
	Tue, 17 Nov 2026 20:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794945894;
	bh=YbLk9lyJPOShMv8agNUeIw0Brlh3Xg0eS6eUOD+x1VU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NBja8i01IHtuflGfYfstDuZaX60IS6C9mvyTnGmfUvLg8+IvcQvuQW3RTCtbtY8io
	 j3RV85yCQBHrAzB2BWasBzTH60MH3G1/WUUUggeMVLb2sL46gVSwpMzqfN3YK0BlHf
	 pwBMJuO4vPJIe52WM2iU4sm5qDnjN9WiBYC0C77titbviGBiMzmY1wErdFKhvPzr1T
	 GTVE2CoFoQ70RPecu9cY/+ZEwaVSKHWOW50O47Oak4YJhtkZ1vXXGUjCZzCUZRkD3E
	 V8F1Wu1yWa0d5F5i60VHXPlf1FctSqgabYh7gF2JfANf/o7bt1VXgnEpnXm5DYQ+I2
	 GXzhpqN6fq0wA==
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
Subject: [PATCH v6 05/13] perf tests: Exercise the flexible array member path
Date: Tue, 17 Nov 2026 17:04:23 -0300
Message-ID: <20261117200433.45174-6-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117200433.45174-1-acme@kernel.org>
References: <20261117200433.45174-1-acme@kernel.org>
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

No test covered find_flex_array() and get_flex_array_member().  Add a
flex_array workload that keeps a struct with a trailing data[] behind a
global pointer, and a test that checks the accesses past the struct size
are resolved and named after the flexible array member; find_data_type()
folds offsets past the struct modulo the element size back to the
member's offset (+0x4 for char data[]).  The test skips on 32-bit PIE
builds, which reach static globals relative to the GOT base register.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c               |  1 +
 .../perf/tests/shell/data_type_flex_array.sh  | 68 +++++++++++++++++++
 tools/perf/tests/tests.h                      |  1 +
 tools/perf/tests/workloads/Build              |  2 +
 tools/perf/tests/workloads/flex_array.c       | 55 +++++++++++++++
 5 files changed, 127 insertions(+)
 create mode 100755 tools/perf/tests/shell/data_type_flex_array.sh
 create mode 100644 tools/perf/tests/workloads/flex_array.c

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index e056a3d3594ff8a2..8fc425d470c17dbf 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -214,6 +214,7 @@ static struct test_workload *workloads[] = {
 	&workload__callchain,
 	&workload__false_sharing,
 	&workload__global_data,
+	&workload__flex_array,
 
 #ifdef HAVE_RUST_SUPPORT
 	&workload__code_with_type,
diff --git a/tools/perf/tests/shell/data_type_flex_array.sh b/tools/perf/tests/shell/data_type_flex_array.sh
new file mode 100755
index 0000000000000000..850997d94baab07d
--- /dev/null
+++ b/tools/perf/tests/shell/data_type_flex_array.sh
@@ -0,0 +1,68 @@
+#!/bin/bash
+# perf data type profiling tests for flexible array members
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
+if ! perf mem record -o "$perfdata" -- perf test -w flex_array 1 > /dev/null 2>&1; then
+	echo "FAIL: perf mem record"
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
+if ! grep -Fq "# data-type: struct flex +0x4 (data)" "$perfout"; then
+	echo "FAIL: flexible array member not resolved"
+	tail -n 30 "$perfout"
+	cleanup
+	exit 1
+fi
+
+echo "flexible array member resolved"
+cleanup
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 049a164503166529..0cf33d91804f19c4 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -274,6 +274,7 @@ DECLARE_WORKLOAD(deterministic);
 DECLARE_WORKLOAD(callchain);
 DECLARE_WORKLOAD(false_sharing);
 DECLARE_WORKLOAD(global_data);
+DECLARE_WORKLOAD(flex_array);
 
 #ifdef HAVE_RUST_SUPPORT
 DECLARE_WORKLOAD(code_with_type);
diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
index 03017aaaaa0bec32..74a0cbe49dc93533 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -18,6 +18,7 @@ perf-test-y += deterministic.o
 perf-test-y += callchain.o
 perf-test-y += false_sharing.o
 perf-test-y += global_data.o
+perf-test-y += flex_array.o
 
 ifeq ($(CONFIG_RUST_SUPPORT),y)
     perf-test-y += code_with_type.o
@@ -37,3 +38,4 @@ CFLAGS_named_threads.o    = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_callchain.o        = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_false_sharing.o    = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_global_data.o      = -g -O0 -fno-inline -U_FORTIFY_SOURCE
+CFLAGS_flex_array.o       = -g -O0 -fno-inline -U_FORTIFY_SOURCE
diff --git a/tools/perf/tests/workloads/flex_array.c b/tools/perf/tests/workloads/flex_array.c
new file mode 100644
index 0000000000000000..141f9d510816cb05
--- /dev/null
+++ b/tools/perf/tests/workloads/flex_array.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Flexible array member workload for data type profiling: the accesses to
+ * the array are past the end of the struct, where the resolver has to find
+ * the flexible array member.
+ *
+ * See tests/shell/data_type_flex_array.sh.
+ */
+#include <signal.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <linux/compiler.h>
+#include "../tests.h"
+
+struct flex {
+	int len;
+	char data[];
+};
+
+static struct flex *gp;
+static volatile unsigned long flex_sink;
+static volatile sig_atomic_t done;
+
+static void sighandler(int sig __maybe_unused)
+{
+	done = 1;
+}
+
+static int flex_array(int argc, const char **argv)
+{
+	unsigned long sum = 0;
+	int sec = 1;
+
+	if (argc > 0)
+		sec = atoi(argv[0]);
+
+	gp = calloc(1, sizeof(*gp) + 4096);
+	if (gp == NULL)
+		return 1;
+	gp->len = 4096;
+
+	signal(SIGINT, sighandler);
+	signal(SIGALRM, sighandler);
+	alarm(sec);
+
+	while (!done) {
+		sum += gp->data[3];
+		gp->data[5] = 1;
+	}
+	flex_sink = sum;
+	free(gp);
+	return 0;
+}
+
+DEFINE_WORKLOAD(flex_array);
-- 
2.56.0

