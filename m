Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795041476;
	b=c4t44+zQvXLS+f1b02GjiLn9ganabFrp6/UCZUW3YMz8Lue8DgBIxb3WA2q5RT498TSO
	 aG7aSYlpaAfyp+FbK4J8f6ve+95L63CmvXp066PzQEXsdlIFJKzz1KgF3iKIv5bl0y+JM
	 lqDIDGJKLh4KJ2pTKDFbwFN+0uhglm6kfPD7Izsi0uumLgbvylXwugYenW0HzlF6nXHc1
	 9cLSND/NEp+MiAtRysfrMVbssN+2n0AhO5yfpBSfW28Mk+x2zjOAdWLVrwgXaYd+VwD8X
	 LoD+vVFJS2iUVnSRQr92CQmaHFiz38P5ZSxHuLheaSa4VWhUytFXClk/nd1d7RXbxcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795041476;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TUmcrWEikoX3MlUYOPP3sYIXacC4M4mzj+fDr9u6mgI=;
	b=Mehdr9v3a/AwVOd0qsFJGc8rVejuQ1ZCVUl+9wZpOBDU+BHmTz25IitCBNwzyoAM+FNr
	 /nIW3VUIiqKUKrx+dt2J/WDNZJ6H2KFm++YQHgT874Y9B7uErthvB+IdkLiq7a43SNf/g
	 +HvjpVkNk1gi5hsp6YG2T4LgZXWyTQOuTPuWVoEpuDS5uYg2Y7qD5p6YVb33lqOJtDLqm
	 eHcaA9O7qh5vrlZ+ZkLHWmq1CvbaTsMFhqPXduqBmbm7n9qUxGfNRP0Iwa2xRXnY6DNyD
	 tmseIV2PLVv/nu9uIOhek6Af5v0bFqmWesS3EAwz5oSUrms7D49n6A/nE2bchQPzWbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m1a+0TEP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26A060A5BEA;
	Wed, 18 Nov 2026 22:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m1a+0TEP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A1D21F000C6;
	Wed, 18 Nov 2026 22:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795041476;
	bh=TUmcrWEikoX3MlUYOPP3sYIXacC4M4mzj+fDr9u6mgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m1a+0TEPaZhvnLeXzuRlmXUIas8eC7xq8NJLvnjFCW/oA4u2AchlW+OPJ69iVq4jm
	 Gi37XwO1pVeSfJzZlUMzj6DoyzYwYBaKb8K5Qk7sWqOHfbtbs+pcTeunC38rdGjkHQ
	 zMVuLUGKWik+iCHTZSZgulmCj5vEnKuodYSzo/Kybuom3IX1P4hrUPLOqvUDxI/dBh
	 Vy2Ci4mlObxR8uXqWrRtu0yF8ZzwYrKUn6zNKnPMPicEhkqhUW/gw0dAR8K6JG2QUJ
	 bgjd7ezw9b1huOioYViYP1ZlBUp09iMhLvPtmG91sYtE8CbwuGJe1yFEtShv06L49I
	 XH2IUVKm3hmLA==
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
Subject: [PATCH v8 07/13] perf tests: Exercise data type resolution from a register
Date: Wed, 18 Nov 2026 19:37:18 -0300
Message-ID: <20261118223725.121500-8-acme@kernel.org>
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

At -O2 a struct pointer lives in a register (with DWARF describing it with
a register location on register-argument ABIs), while the unoptimized
workloads the data type tests profile keep their variables on the stack.

Add a regptr workload with a noinline function that takes the pointer from
a volatile global, so the compiler cannot constant-propagate the object
address, and check that its three member accesses are resolved from that
register.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c              |  1 +
 tools/perf/tests/shell/data_type_register.sh | 63 ++++++++++++++++++++
 tools/perf/tests/tests.h                     |  1 +
 tools/perf/tests/workloads/Build             |  2 +
 tools/perf/tests/workloads/regptr.c          | 60 +++++++++++++++++++
 5 files changed, 127 insertions(+)
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
index 0000000000000000..055279bd8b0f9c25
--- /dev/null
+++ b/tools/perf/tests/shell/data_type_register.sh
@@ -0,0 +1,63 @@
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
+		--percent-limit 1 > "$perfout"; then
+	echo "FAIL: perf annotate"
+	cleanup
+	exit 1
+fi
+
+for member in "+0 (a)" "+0x8 (b)" "+0x10 (c)"; do
+	if ! grep -Fq "# data-type: struct node ${member}" "$perfout"; then
+		echo "FAIL: member ${member} not resolved from the register"
+		grep 'struct node' "$perfout"
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
index 0000000000000000..00f31c16ac1e4a5a
--- /dev/null
+++ b/tools/perf/tests/workloads/regptr.c
@@ -0,0 +1,60 @@
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
2.56.1

