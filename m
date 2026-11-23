Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471268;
	b=atPM0UvxTMQz0rtp5Pag8QwSLt7OALM7VSjpMIDtJQ4VWxhs1ClO6Y7PIGIKv7xt7gFh
	 OIc0L65W+i9e8f0vAAaKSWaS+Bqyu9Ed18VRzd9WCaKbDkeGPUazNFGkXDH6OxHtsNxJQ
	 bs5GbDzWsLN3JgsXQsreocOxulfwWRYEttqYx58/rP8TP8JILZ/h8OBJQiFOWiI7Z5zFd
	 /XikrLCb5u/wZiBQB04tnH5jKl24IGmzL0lWV/hSKoXOfsZQfp7Mjc0gAqCZe5j9sfqMu
	 LZQIvdLKlB7tEOVosGfUxBgXUBLnuQXJsbmyoa4816ZdUtFQvPq2VOMqvlfwkjYwKIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471268;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aNowa5HbhL+W8dMCJ10dFLhGp6iuE6rrTmju3Z9f6Nw=;
	b=lkByBJX7woi4R/XC2XL6Zbd6b/UXuJR3n/L7jeaeHorKfNwkUnO7UWmwLSaC5KL923EE
	 W41kWfBTvZCfTDsZVM4N4WTrWycctz5k7Iv4MzzHzmGkC7SNkmyis/QF6vNrsshbetLkc
	 3hvAcRCoBFmyLscQPL4yTL89RayeJ1B/wuB+HRQQtImp2vf0jARz+eN97Z01Qh4fZlH1p
	 nHUCgE157u8VnHpd2c2RszMPAitUwE56loZvEDhOCT85RROQRXhFv5KHKaiZmRCDKQFHF
	 Nx4QfA9H4kYQU0cflsCwNmJkYgX1wpkQk3L48dKlY04eJfJDIO2GNHqXi4hb8rCFE4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vnwh0MkW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0A3606A321;
	Mon, 23 Nov 2026 22:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vnwh0MkW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623461F000EB;
	Mon, 23 Nov 2026 22:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795471268;
	bh=aNowa5HbhL+W8dMCJ10dFLhGp6iuE6rrTmju3Z9f6Nw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vnwh0MkW07aRnSf284WW6diynCCtsBzWOzJ1p+TLwRk+Cnz7A7/ib694KIpwWpQNf
	 7gR52Wulx+LyAIS+HGur6QizSpEFDCyji5m4+yRnY6m15+xCUerCale8KyrlGLLtQP
	 NZb8tf7tWA79zAlgHtde85soMZ1Zc5knIDm05/GFxfVA0OsWwRuHVN0UI6ZJLorJRZ
	 UQpAsYUoHAIlWWSVOFnR9OLO/Up2CkT0kTlPjaGWPuA+JMAjQ2/YQlSUIXXgTKyWYj
	 O+UKeTF8PDIxiUWBEobefsLSpl1H8puuZwD8ZxJshGQXemjB5DkutElpZDLhW9uDJv
	 YHy0jw5o4qDSg==
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
Subject: [PATCH v12 11/19] perf test: Exercise data type resolution from a register
Date: Mon, 23 Nov 2026 19:00:16 -0300
Message-ID: <20261123220024.14891-12-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123220024.14891-1-acme@kernel.org>
References: <20261123220024.14891-1-acme@kernel.org>
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

At -O2 a struct pointer lives in a register (with DWARF describing it with
a register location on register-argument ABIs), while the unoptimized
workloads the data type tests profile keep their variables on the stack.

Add a regptr workload with a noinline function that takes the pointer from
a volatile global, so the compiler cannot constant-propagate the object
address, and check that its three member accesses are resolved from that
register.  The type statistics also verify that the instruction-tracking
fallback did not resolve them.  The test skips 32-bit x86, which has no
register-argument ABI.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c              |  1 +
 tools/perf/tests/shell/data_type_register.sh | 86 ++++++++++++++++++++
 tools/perf/tests/tests.h                     |  1 +
 tools/perf/tests/workloads/Build             |  2 +
 tools/perf/tests/workloads/regptr.c          | 60 ++++++++++++++
 5 files changed, 150 insertions(+)
 create mode 100755 tools/perf/tests/shell/data_type_register.sh
 create mode 100644 tools/perf/tests/workloads/regptr.c

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index d761758201a4b2f2..29068963b9d5bae0 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -216,6 +216,7 @@ static struct test_workload *workloads[] = {
 	&workload__false_sharing,
 	&workload__global_data,
 	&workload__flex_array,
+	&workload__regptr,
 
 #ifdef HAVE_RUST_SUPPORT
 	&workload__code_with_type,
diff --git a/tools/perf/tests/shell/data_type_register.sh b/tools/perf/tests/shell/data_type_register.sh
new file mode 100755
index 0000000000000000..a36e4ce8f37d3982
--- /dev/null
+++ b/tools/perf/tests/shell/data_type_register.sh
@@ -0,0 +1,86 @@
+#!/bin/bash
+# perf data type profiling tests for register variables
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
+# 32-bit x86 passes the struct pointer in a stack slot, so nothing is
+# resolved from a register; e_machine's low byte is at 18 on LE x86.
+perf_bin=$(command -v perf)
+if [ "$(od -An -tx1 -j18 -N1 "$perf_bin" | tr -d ' ')" = 03 ]; then
+	echo "Skip: 32-bit x86 keeps the argument in a stack slot"
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
+if ! perf mem record -o "$perfdata" -- perf test -w regptr 1 \
+		> /dev/null 2> "$perferr"; then
+	echo "FAIL: perf mem record"
+	cat "$perferr"
+	cleanup
+	exit 1
+fi
+
+if ! perf annotate --code-with-type -i "$perfdata" --stdio \
+		--percent-limit 1 touch > "$perfout"; then
+	echo "FAIL: perf annotate"
+	cleanup
+	exit 1
+fi
+
+for member in "+0 (a)" "+0x8 (b)" "+0x10 (c)"; do
+	if ! grep -Fq "# data-type: struct node ${member}" "$perfout"; then
+		echo "FAIL: member ${member} not resolved from the register"
+		grep 'struct node' "$perfout" || true
+		cleanup
+		exit 1
+	fi
+done
+
+if ! perf annotate --data-type --type-stat -i "$perfdata" --stdio \
+		touch > "$perfout"; then
+	echo "FAIL: perf annotate --data-type --type-stat"
+	cleanup
+	exit 1
+fi
+
+if grep -Eq '^[[:space:]]*[0-9]+ : insn_track$' "$perfout"; then
+	echo "FAIL: data type resolved by instruction tracking"
+	tail -n 30 "$perfout"
+	cleanup
+	exit 1
+fi
+
+echo "register held access resolved"
+cleanup
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 8621ea345b5f06ff..6bfb30687e12eeb7 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -276,6 +276,7 @@ DECLARE_WORKLOAD(callchain);
 DECLARE_WORKLOAD(false_sharing);
 DECLARE_WORKLOAD(global_data);
 DECLARE_WORKLOAD(flex_array);
+DECLARE_WORKLOAD(regptr);
 
 #ifdef HAVE_RUST_SUPPORT
 DECLARE_WORKLOAD(code_with_type);
diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
index 74a0cbe49dc93533..17189458032c0a17 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -19,6 +19,7 @@ perf-test-y += callchain.o
 perf-test-y += false_sharing.o
 perf-test-y += global_data.o
 perf-test-y += flex_array.o
+perf-test-y += regptr.o
 
 ifeq ($(CONFIG_RUST_SUPPORT),y)
     perf-test-y += code_with_type.o
@@ -39,3 +40,4 @@ CFLAGS_callchain.o        = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_false_sharing.o    = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_global_data.o      = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_flex_array.o       = -g -O0 -fno-inline -U_FORTIFY_SOURCE
+CFLAGS_regptr.o           = -g -O2
diff --git a/tools/perf/tests/workloads/regptr.c b/tools/perf/tests/workloads/regptr.c
new file mode 100644
index 0000000000000000..8c3ab7d316870a3b
--- /dev/null
+++ b/tools/perf/tests/workloads/regptr.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A struct pointer that -O2 keeps in a register, so the member accesses
+ * have to be resolved from its DWARF register location and not from a
+ * stack slot.
+ *
+ * See tests/shell/data_type_register.sh.
+ */
+#include <signal.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <linux/compiler.h>
+#include "../tests.h"
+
+struct node {
+	long long a;
+	long long b;
+	long long c;
+};
+
+static struct node node;
+static struct node *volatile vp;
+static volatile unsigned long long reg_sink;
+static volatile sig_atomic_t done;
+
+static void sighandler(int sig __maybe_unused)
+{
+	done = 1;
+}
+
+static noinline long long touch(struct node *p)
+{
+	long long sum = 0;
+
+	sum += p->a;
+	p->b += sum;
+	sum += p->c;
+	return sum;
+}
+
+static int regptr(int argc, const char **argv)
+{
+	unsigned long long sum = 0;
+	int sec = 1;
+
+	if (argc > 0)
+		sec = atoi(argv[0]);
+
+	vp = &node;
+	signal(SIGINT, sighandler);
+	signal(SIGALRM, sighandler);
+	alarm(sec);
+
+	while (!done)
+		sum += touch(vp);
+	reg_sink = sum;
+	return 0;
+}
+
+DEFINE_WORKLOAD(regptr);
-- 
2.56.0

