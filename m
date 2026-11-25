Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634632;
	b=IvCmAw7G8HTYvQnQWBHqV8YJQR7Awg5BVzwvcm6krwvrV/i/dAtUqdnV7C878YVbHhaG
	 mA3BYPlSrdr0hfADM4EPxKkZ+vIE4S038TrQk4/gfoiD9EhHSuSdIOiMCE2DlwcYD7zsc
	 I7Lv65NRt6IV37mJKGezz3NrSTx4HUsFPltECrVFBxS5G0DL9pWit9sQfc6bmZpQm0HhO
	 FRKJBetVem67Lvxneak+dRyz08EMCtZ1Y1iDoQHeVQztIfr0M0ZX42hOuD/WYdmuznD8n
	 LqST300JQPC5+w2gr87qrwfceJxnxmy6by3hU+87XZIypMgIJyKpIhIxoKucK3JXkUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634632;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=87H2n7vnNz1VvHwbmKk8yzjCiBhIlsUzmV0ldIMU8As=;
	b=JQKsz3vXdE4dyNmmWHIE73Hc/pykSmctT91RB2XgiaQ3HS48H5xfbnSzUTQqahq4yFog
	 goOGPL1hYPob48EaHm/Iy9vH4PKsh7cHhGNm+fVKp3HksmE8mxgEhiJhd/PqtcWsnaVc2
	 6P65aErEQPHUlrV9Ycmtt/DtoZRzkpVI6+nuh93P35Z/CcC9aDwbQ8Tsul9L8NpHyStYQ
	 vbBCuvmIRTcqrtl/Dlssn/pMTEgojJrmHm5MAA7qyDwBgB1GP+lvvkPqqiCTa+wobTqyg
	 K+NBwuBCF0EchQhYby0iTmUqMUzlegGAfYE1lHp/DQ3EueEO9/cUs7gF6NCC+bjG2kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VAY2R3Mn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB51606A32D;
	Wed, 25 Nov 2026 19:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VAY2R3Mn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB66F1F000F4;
	Wed, 25 Nov 2026 19:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634632;
	bh=87H2n7vnNz1VvHwbmKk8yzjCiBhIlsUzmV0ldIMU8As=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VAY2R3MnTJvM6EdQPi9BrFTqNUXe/XDSRzTa1zziy0I1eYqrVHGVY6nfJIifHb/wj
	 5WjZ+XHt0aFiyS4LqX1+ikUZrNXwf9fgyDbNtYxVz1CQP/2742a6aKjY5jpM9B2H+2
	 rVtWJLNI/tMUODlFZdpys6Chi4I7rxgGO2nws+Haav++Dvyr/rdUVrHRfRe9aVZFvP
	 lXp2I/k2g04f9ASTR4qdeTMAD5QQbkMuvYc8vI8Cz8QaRqi/oXyPYm7WIFKfdWIhHX
	 RjA1wmf8frvt1qiJoSwxv1CXGi/gxKJjCbylwQbqdbHM7Wi3BkbwRbPra8ImWVzaLp
	 lUmvvBPSr9vCQ==
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
Subject: [PATCH v13 10/19] perf test: Exercise the flexible array member path
Date: Wed, 25 Nov 2026 16:23:03 -0300
Message-ID: <20261125192312.34134-11-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125192312.34134-1-acme@kernel.org>
References: <20261125192312.34134-1-acme@kernel.org>
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
flex_array workload that keeps structs with trailing data[] members
behind global pointers, and a test that checks accesses at and past the
struct size are resolved and named after the flexible array member;
find_data_type() folds offsets past the struct modulo the element size
back to the member's offset (+0x4 for char data[] and +0xc for the
padded int data[]).  The test also checks that the
accesses count for the struct in the percent, samples and period columns.
It skips on 32-bit PIE builds, which reach static globals relative to the
GOT base register.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c               |   1 +
 .../perf/tests/shell/data_type_flex_array.sh  | 135 ++++++++++++++++++
 tools/perf/tests/tests.h                      |   1 +
 tools/perf/tests/workloads/Build              |   2 +
 tools/perf/tests/workloads/flex_array.c       |  71 +++++++++
 5 files changed, 210 insertions(+)
 create mode 100755 tools/perf/tests/shell/data_type_flex_array.sh
 create mode 100644 tools/perf/tests/workloads/flex_array.c

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 42e85d1b1420f0a7..d761758201a4b2f2 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -215,6 +215,7 @@ static struct test_workload *workloads[] = {
 	&workload__callchain,
 	&workload__false_sharing,
 	&workload__global_data,
+	&workload__flex_array,
 
 #ifdef HAVE_RUST_SUPPORT
 	&workload__code_with_type,
diff --git a/tools/perf/tests/shell/data_type_flex_array.sh b/tools/perf/tests/shell/data_type_flex_array.sh
new file mode 100755
index 0000000000000000..0fb82618dc00f854
--- /dev/null
+++ b/tools/perf/tests/shell/data_type_flex_array.sh
@@ -0,0 +1,135 @@
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
+# The accesses to the flexible arrays are resolved at or past the end of
+# the struct: they must count for the struct, not only for the member.
+if ! perf annotate --data-type -i "$perfdata" --stdio > "$perfout"; then
+	echo "FAIL: perf annotate --data-type"
+	cleanup
+	exit 1
+fi
+
+if ! awk '
+	$1 + 0 == 100.00 && /struct flex/ { struct_ok = 1 }
+	$1 + 0 > 0 && /char\[\]/ && /data;/ { data_ok = 1 }
+	END { exit !(struct_ok && data_ok) }
+' <(sed -n "/^Annotate type: 'struct flex' in/,/^Annotate type: /p" "$perfout"); then
+	echo "FAIL: --data-type does not count the flexible array accesses"
+	tail -n 30 "$perfout"
+	cleanup
+	exit 1
+fi
+
+if ! awk '
+	$1 + 0 == 100.00 && /struct flex_pad/ { struct_ok = 1 }
+	$1 + 0 > 0 && /int\[\]/ && /data;/ { data_ok = 1 }
+	END { exit !(struct_ok && data_ok) }
+' <(sed -n "/^Annotate type: 'struct flex_pad' in/,/^Annotate type: /p" "$perfout"); then
+	echo "FAIL: --data-type does not count the padded flexible array accesses"
+	tail -n 30 "$perfout"
+	cleanup
+	exit 1
+fi
+
+# Same with the samples and period columns, the other two display modes.
+for mode in --show-nr-samples --show-total-period; do
+	if ! perf annotate --data-type -i "$perfdata" --stdio "$mode" > "$perfout"; then
+		echo "FAIL: perf annotate --data-type $mode"
+		cleanup
+		exit 1
+	fi
+
+	if ! awk '
+		$1 + 0 > 0 && /struct flex/ { total = $1 + 0 }
+		/int/ && /len;/ { len = $1 + 0 }
+		/char\[\]/ && /data;/ { data = $1 + 0 }
+		END { exit !(total > 0 && data > 0 && total == data + len) }
+	' <(sed -n "/^Annotate type: 'struct flex' in/,/^Annotate type: /p" "$perfout"); then
+		echo "FAIL: --data-type $mode does not count the flexible array accesses"
+		tail -n 30 "$perfout"
+		cleanup
+		exit 1
+	fi
+
+	if ! awk '
+		$1 + 0 > 0 && /struct flex_pad/ { total = $1 + 0 }
+		/long/ && /x;/ { x = $1 + 0 }
+		/int/ && /len;/ { len = $1 + 0 }
+		/int\[\]/ && /data;/ { data = $1 + 0 }
+		END { exit !(total > 0 && data > 0 && total == data + len + x) }
+	' <(sed -n "/^Annotate type: 'struct flex_pad' in/,/^Annotate type: /p" "$perfout"); then
+		echo "FAIL: --data-type $mode does not count the padded flexible array accesses"
+		tail -n 30 "$perfout"
+		cleanup
+		exit 1
+	fi
+done
+
+echo "flexible array member resolved and counted"
+cleanup
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 63d49a960eab8f3c..8621ea345b5f06ff 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -275,6 +275,7 @@ DECLARE_WORKLOAD(deterministic);
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
index 0000000000000000..cc15e8cac157c337
--- /dev/null
+++ b/tools/perf/tests/workloads/flex_array.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Flexible array member workload for data type profiling: the accesses to
+ * the arrays are at or past the end of their structs, where the resolver
+ * has to find the flexible array members.
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
+struct flex_pad {
+	long x;
+	int len;
+	int data[];
+};
+
+static struct flex *gp;
+static struct flex_pad *gpp;
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
+	gpp = calloc(1, sizeof(*gpp) + 4096);
+	if (gp == NULL || gpp == NULL) {
+		free(gp);
+		free(gpp);
+		return 1;
+	}
+	gp->len = 4096;
+	gpp->x = 1;
+	gpp->len = 4096;
+
+	signal(SIGINT, sighandler);
+	signal(SIGALRM, sighandler);
+	alarm(sec);
+
+	while (!done) {
+		sum += gp->data[3];
+		gp->data[5] = 1;
+		sum += gpp->data[1];
+		gpp->data[2] = 1;
+	}
+	flex_sink = sum;
+	free(gp);
+	free(gpp);
+	return 0;
+}
+
+DEFINE_WORKLOAD(flex_array);
-- 
2.56.0

