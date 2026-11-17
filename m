Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945899;
	b=VfAIHHwji+sjRfuYdmfkY+M0h15NKRaiF42XcUJJMxcXkXCIKZGuJiMSQqcJiAXnQp76
	 xySRxknUh/jQhNqC3rkzy2BZXRaihB/dF5pby8VGUU4zBJvT6QVXwR7gETgtSSICQGb7R
	 jU/nT0wZCSF2GWw3Fbj2yPNPxF9D73KAakTIsIRsNYbsNImuan9od0MTTthaQrpQaCbO+
	 M43rxuyL/bHJHn0CjHmrCkvfjYc3hGVXTVT7VPDcS7yqSaslpyvJ3BuQI+u7NIMCgh8S1
	 xoBFa4OzGFLBUjC8HbD2c0VGUpnf7RCZfI6Dh+A0RSacHYaj8Z1lXklkZOGqzdtAGyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945899;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=M6HD5exBWL/fKf7qQ8cuUtCSEy9+foobjpOihXQqDu0=;
	b=GTlNPGzOSqeVz3LspSMbv3hB0vWoPW/bcLWRRTbwqYFBL83URPAkX6Uu+UXoqCwb4aze
	 UPfSD8Y1cHkk2iFgo/pSmNKP/o+VD4SHOYeIbTb81aIIo6Q867JLaH6WqUcSCZdikBU08
	 L0BvWeo63E4X1QUq5+S5n2jFrR/OLVbSc1Sx4b/29Nq6xuTNGtgx1sG5/zyCsOLsucLaU
	 CNlyXwphQMeCHaxlpWGGd1PJ4V+w9eTElNMkxw0GXHdZxPayvk2MRysMUA49/TYvyJ/Gx
	 gdTFzlUL9wzmtfs+jJQN95NNTvJjcU4rbXG2ZOrDGjkHgb5nWz5OoeqyN8WIEX+BXeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LTr4k4Tk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D09606A88C;
	Tue, 17 Nov 2026 20:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LTr4k4Tk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C091F000C4;
	Tue, 17 Nov 2026 20:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794945899;
	bh=M6HD5exBWL/fKf7qQ8cuUtCSEy9+foobjpOihXQqDu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LTr4k4Tk64G40swgmqYtoqihi55nqiDQweXqCkCQVf/TkVYUpwzeHlObRl4X9ZFGB
	 v9po67NMuW8aszWJnWlBmLaxq0PPO/FFxCKvEBRw/JCK7oPFaA3K9fCGflH3svsgDx
	 onwRqzZ6TjPp5OCeq7SIxwo91zrY1oFoaxDEY8n2PomDqDcduJTC4jbIW7R7LNjcEf
	 rCcYM0lzOwi+koRehjzOR2nMn5/U2NlsXZ9fotAQbOSArIYxt/x4uiu7FEc6sAKQR8
	 ZfltazqqQRdNrT5XAP2Nk54zumWXayxainoaeL/sezlWzgL2m5OB9QCY20MYZIdnTi
	 hxh74BPKKh4EQ==
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
Subject: [PATCH v6 07/13] perf tests: Exercise data type resolution from a register
Date: Tue, 17 Nov 2026 17:04:25 -0300
Message-ID: <20261117200433.45174-8-acme@kernel.org>
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

At -O2 a struct pointer lives in a register (with DWARF describing it with
a register location on register-argument ABIs), while the unoptimized
workloads the data type tests profile keep their variables on the stack.

Add a regptr workload with a noinline function that takes the pointer from
a volatile global, so the compiler cannot constant-propagate the object
address, and check that its three member accesses are resolved from that
register.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c              |  1 +
 tools/perf/tests/shell/data_type_register.sh | 60 +++++++++++++++++++
 tools/perf/tests/tests.h                     |  1 +
 tools/perf/tests/workloads/Build             |  2 +
 tools/perf/tests/workloads/regptr.c          | 61 ++++++++++++++++++++
 5 files changed, 125 insertions(+)
 create mode 100755 tools/perf/tests/shell/data_type_register.sh
 create mode 100644 tools/perf/tests/workloads/regptr.c

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 8fc425d470c17dbf..fe4d4cd54f85d502 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -215,6 +215,7 @@ static struct test_workload *workloads[] = {
 	&workload__false_sharing,
 	&workload__global_data,
 	&workload__flex_array,
+	&workload__regptr,
 
 #ifdef HAVE_RUST_SUPPORT
 	&workload__code_with_type,
diff --git a/tools/perf/tests/shell/data_type_register.sh b/tools/perf/tests/shell/data_type_register.sh
new file mode 100755
index 0000000000000000..0d4a420cad9475cd
--- /dev/null
+++ b/tools/perf/tests/shell/data_type_register.sh
@@ -0,0 +1,60 @@
+#!/bin/bash
+# perf data type profiling tests for register variables
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
+# No point in recording if the PMU cannot do memory events.
+if ! perf mem record -o /dev/null -- true 2>/dev/null; then
+	echo "Skip: cannot record memory events on this PMU"
+	cleanup
+	exit 2
+fi
+
+if ! perf mem record -o "$perfdata" -- perf test -w regptr 1 > /dev/null 2>&1; then
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
+for member in "+0 (a)" "+0x8 (b)" "+0x10 (c)"; do
+	if ! grep -Fq "# data-type: struct node ${member}" "$perfout"; then
+		echo "FAIL: member ${member} not resolved from the register"
+		tail -n 30 "$perfout"
+		cleanup
+		exit 1
+	fi
+done
+
+echo "register held access resolved"
+cleanup
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 0cf33d91804f19c4..b03c56d5e4c98aaf 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -275,6 +275,7 @@ DECLARE_WORKLOAD(callchain);
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
index 0000000000000000..441202b61ae7b2e6
--- /dev/null
+++ b/tools/perf/tests/workloads/regptr.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A struct pointer that -O2 keeps in a register, so the member accesses
+ * have to be resolved from the register's type state and not from a
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
+static struct node n;
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
+	/* A load too, or a load-only PMU never resolves b. */
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
+	vp = &n;
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

