Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582377;
	b=Cj03YIVKDdQJUStxLaY4BMTFc7cvj+sP+ntETKBean5uuYFaCpbKCpnl2AGSBlnnCw03
	 nMsxVTq7UbGadf8ol3Fq4IMZ4ZKhsK18hArpdNltM4zQCxw0R6i7G6le+HeAjyZgwPd3a
	 CbFDWQcyLMVQBCgceWP95cQ0WoUZnujh95hmwZvx39LppLV0OczSXh3c4P+nLMPz1WOra
	 RgigURCBjup/uuGE0+us5LShzbYs0oDVElXzqBSqH9hYnOxv01jtq9Sx9gpok8f8iN/XJ
	 7kX8oKI2xqQfLA9orNnhtZSiWQJCeICC9heqZcGTi1uRVinv6mzTODmygFlQdaWL5dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582377;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2e0D4VsHpXShUxzHyxdi5LrTZGO+JfPq7HMyVhQ0gqY=;
	b=s+3Q8tCIMkQZ3/21chxtcDHXddTIqOdU1i02NEPOIsqDiOsZ3/Je8BsIoKOHpeqt28Q6
	 wNqbE/ZLMgGtr6zTDjJp6VHlVnis2Ie85GzszJ2v16MMWSPuyZa6usvGFgLUr6dCq/Q7H
	 Gkoj7YVX/vZd6cIfIkq9wkWQiyfoxF3baCSLHZZNIgFjZMLwx6JI3rzG3CM3MkhgYH1fA
	 5OUKpBzQBlRdPTd0sejV5+AXF+B8k90WtM8VKapGAA2ozVorFv4MPuYI/2XWdULYw2lFM
	 I9mYOPUkrc6GQhs+GVJoopfY7OeVdi1DRScJsjuDKr8jbIHYnj3JssOJGjt1bSoWUDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I2Qtfj9X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2B660A2624;
	Fri, 13 Nov 2026 15:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I2Qtfj9X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAB91F000C9;
	Fri, 13 Nov 2026 15:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794582377;
	bh=2e0D4VsHpXShUxzHyxdi5LrTZGO+JfPq7HMyVhQ0gqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I2Qtfj9XKnzi9wam3XHCgAjaWwy2X1PXD8qc7H4cKH7lb43N3BkGUnPuLTpFFWRyv
	 3hB7PVg6R+7koorWgXu7rKPkeOjU6QaHEJh6uSJOwFrMjFaghASOi3gIl54W9eCYjQ
	 f+qVEOyoICK2AMQCnZKFJFbjFKdiXo2BYJWGShUBXfHRemjOPHGMIrFEIdLcUx+2FV
	 thBp1OVHIbYHsV4XfbkSJu89jPouoZKP0i7K4iBdv2rJ0wbcDHVWAmMWuheqQY8Urc
	 u0JNz1F9JjHZJeP5fP9vIoV1XCdiEX8EubOReucNyMaiEgKMGyF6jNx6cYPm+Moq7m
	 e2soW5wi1vmJQ==
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
Subject: [PATCH v1 05/12] perf tests: Exercise data type resolution from a register
Date: Fri, 13 Nov 2026 12:05:46 -0300
Message-ID: <20261113150555.1163049-6-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113150555.1163049-1-acme@kernel.org>
References: <20261113150555.1163049-1-acme@kernel.org>
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

At -O2 a struct pointer lives in a register and DWARF describes it with
a register location, while the unoptimized workloads the data type tests
profile keep their variables on the stack.

Build a workload with a noinline function that gets the pointer from a
volatile global, which keeps it in a register, and check that its three
member accesses are resolved from that location.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/data_type_register.sh | 120 +++++++++++++++++++
 1 file changed, 120 insertions(+)
 create mode 100755 tools/perf/tests/shell/data_type_register.sh

diff --git a/tools/perf/tests/shell/data_type_register.sh b/tools/perf/tests/shell/data_type_register.sh
new file mode 100755
index 0000000000000000..e0369f076ae6f4b2
--- /dev/null
+++ b/tools/perf/tests/shell/data_type_register.sh
@@ -0,0 +1,120 @@
+#!/bin/bash
+# perf data type profiling tests for register variables
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+perfout=$(mktemp /tmp/__perf_test.perf.out.XXXXX)
+prog=$(mktemp /tmp/__perf_test.regs.XXXXX)
+src="${prog}.c"
+
+cleanup()
+{
+	rm -f "$perfdata" "$perfout" "$prog" "$src"
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
+cat > "$src" <<'EOF'
+#include <signal.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+struct node {
+	long a;
+	long b;
+	long c;
+};
+
+static struct node n;
+static struct node *volatile vp;
+static volatile sig_atomic_t done;
+
+static void stop(int sig)
+{
+	done = 1;
+}
+
+__attribute__((noinline)) static long touch(struct node *p)
+{
+	long sum = 0;
+
+	sum += p->a;
+	p->b = sum;
+	sum += p->c;
+	return sum;
+}
+
+int main(void)
+{
+	unsigned long sum = 0;
+
+	vp = &n;
+	signal(SIGALRM, stop);
+	alarm(1);
+
+	while (!done)
+		sum += touch(vp);
+
+	return sum != 0;
+}
+EOF
+
+# -O2: the pointer stays in a register, so the accesses are resolved
+# from its type state instead of from a stack slot.
+if ! cc -O2 -g -fPIE -pie -o "$prog" "$src" 2>/dev/null; then
+	echo "Skip: cannot build the workload"
+	cleanup
+	exit 2
+fi
+
+if ! perf mem record -o "$perfdata" -- "$prog" > /dev/null 2>&1; then
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
+for member in "+0 (a)" "+0x8 (b)" "+0x10 (c)"; do
+	if ! grep -Fq "# data-type: struct node ${member}" "$perfout"; then
+		echo "FAIL: member ${member} not resolved from the register"
+		cleanup
+		exit 1
+	fi
+done
+
+echo "register held access resolved"
+
+cleanup
-- 
2.56.0

