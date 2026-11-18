Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795041469;
	b=MAI5x56P2CDX8Gek/axeYHSYeElur78s4VPAz0PyIeuySIMTxzutbbl+boxPr5aHydMc
	 9g2FjlGaMIXD1CG1wIPuLXRRzOwpTpn4w1BUvn1JF8muW3RXbezaey9YZr3EOlTmOh/to
	 7PF7mw8ZRGITm6ztSf3gIaA7MUTNk4t6zaVSRZmvIuyr5C+i7iFgjLmm6oyk0ydLJpHnU
	 sCFqMpw7IZknuD0ecq6/REPb3ONpBvDe5iZMXqIoj2E5O4eXACHFjr+Ci/fpauass55A4
	 EdOdpn7UlbVt3BZONFdLHC3SYkhvHOBu8cm8Wzgq0gMhNngsuZ6Aw36shAefXVMQ/Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795041469;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fq07rHoyX6fjXGy2GNf2vEoO/ezYp8ILKOq2QP3JirA=;
	b=KFS51KB3VmfE5kT42HJ+c/YlKHONqvBnYr/wUYtWefNeCWBxcJyshr2Jgf5i7ZQwy8Ln
	 HEFhd2HUzHw741gw5xeRiY0h5gcBmQSqvVgqd9QMvtA1WP60JMQsIwurwsRcrNXUijpgP
	 rGzjFxl/dNA1ayzLmWclRoiywf8B+gDdRuWlppt7POgQH8qVdQ8zgwTPnewkm5+mFD7hW
	 F1ZRjMcRALHjn10yhmoHuCsyN7bz0q1BGsMKaT1hcb8lxMebbNzhSLCwIxfhsnlqwI2DS
	 1XQo1mkzO/y3nHYSigSEacp843s9FUnPfaQgK+SPFbVOAeIwT71B5ZEKMB13g1h2WLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GFwwzFMR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B0460A5BCB;
	Wed, 18 Nov 2026 22:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GFwwzFMR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B301F000C7;
	Wed, 18 Nov 2026 22:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795041469;
	bh=fq07rHoyX6fjXGy2GNf2vEoO/ezYp8ILKOq2QP3JirA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GFwwzFMRo6dd6fIBeHM89cW2ujZLa5fvjSm6tDZULCvHTM2gKPyf44fJuZdNSdm78
	 WX1V5/b2cQB8rfIZA8hx8UstZPH3Zpwx0pNQrgEMHvqKV1yZL67+j2yx0nQ3lxBxRq
	 rbKOcUtS215n3R7EucKbSr2KNT5SEtZrl2ElSS2vlhYclczpvNLD8m1JMCWMjZ8T4/
	 khzLjcSEF84zXNvyrDTPMeDb1Xn36QhYDX7Twqoo49lCrAM/CNZ2Ib+Jn9Jzx50/xm
	 Tzu18krnWjzrlo2cwbb7aok+Eliq0OvbIqh5jr4vsmh81SniqJ+vEhOrYmYV4QT2Ka
	 0DIG2rRmP4r+Q==
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
Subject: [PATCH v8 05/13] perf tests: Exercise the flexible array member path
Date: Wed, 18 Nov 2026 19:37:16 -0300
Message-ID: <20261118223725.121500-6-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118223725.121500-1-acme@kernel.org>
References: <20261118223725.121500-1-acme@kernel.org>
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

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c               |  1 +
 .../perf/tests/shell/data_type_flex_array.sh  | 71 +++++++++++++++++++
 tools/perf/tests/tests.h                      |  1 +
 tools/perf/tests/workloads/Build              |  2 +
 tools/perf/tests/workloads/flex_array.c       | 55 ++++++++++++++
 5 files changed, 130 insertions(+)
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
index 0000000000000000..620c28ec24059661
--- /dev/null
+++ b/tools/perf/tests/shell/data_type_flex_array.sh
@@ -0,0 +1,71 @@
+#!/bin/bash
+# perf data type profiling tests for flexible array members
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
+if ! perf mem record -o "$perfdata" -- perf test -w flex_array 1 \
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
2.56.1

