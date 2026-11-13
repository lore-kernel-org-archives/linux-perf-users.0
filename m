Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600546;
	b=BEYprDHVLfldKDBe+rF0kA3k1qeTuOMltMU5TOo1NueDqZFC9OP9mYzE91aH1VmvDKzt
	 NLLcZjsQWJUJTC0nNJd4Z0zAFF4ZANguaDe35fOuAI62xU6WWPUNkRIyhnIfs47MfqCHH
	 7WCgAIil2qK06bJPGocQxKYyjSRXecH3EYOqfq2WSB6kQ/7R721j0v42JTAhObDzMZhkg
	 NGutxuZ2nnsavXKu7lyrFgLNG5/k1mlUwet/m5s0hxGA5jm3SRQf6Wfih9AlAo+nNt3Se
	 nQVAhip3Etwbx14xNgCY1mX/MOQmSCiKF19ke3UkW1LRmy5BVqiR3eHk79ql3A+DMiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600546;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gOw96QIu9a38Kx5P1BYN/ZHmNmKy8yPGb/otYrwHJls=;
	b=G36IDKfI0fGQmBo+u5I8ucK8IMMXz4U2rf5IThtjZU0YQmiqMN4ijMrGbXO1QbU1BgYG
	 zhKTeAHHu0KyuTMFGQKNOk7tPOcpE5qIVU4MdjVDY0G0SmZ49iQNZQYOqpujI5Vt/yb0U
	 9LZ9FH6vvL1dhUbsK5/gPLStU2G2NLfiSsrvXSya/6/LAmWcGldB4NrdCf+Ep6XJaFZS6
	 9l4UeMEDMWoNLYbmM4NcSjube3VhVSMts7CXCEjVw47k90kZiottbPnUWyJ1aojkU5QgM
	 +W5PNuvxRvCajpV+pknrvJ+UXeHP7Icsz/qXhfm7oJXjN+moI5zvv4B/7YqtqU3rbpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="S9pG5rV/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C91606A33E;
	Fri, 13 Nov 2026 20:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S9pG5rV/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D4A1F000C5;
	Fri, 13 Nov 2026 20:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600545;
	bh=gOw96QIu9a38Kx5P1BYN/ZHmNmKy8yPGb/otYrwHJls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S9pG5rV/q0slvtu49SsaxNnbXRacwY0+yravX63YxiFgFC8FM06lh/iyK0UwURTfd
	 X2wWkFr8foP4HRNPE+jPvNz4qt74bvGrasPn8HZBwLmOblnbJ97umKN3cBYF9ohocc
	 tz25/JJJjr1PGmQchH0YTJP+60w45P0rzTYhKXPTb/9pCWUfqNXqf9vmegb/Clq4t0
	 LSYnltRqE1sMx8QvjLrqd3o4mm/wL3y+EPhPFIRH661PWrUUzdZvowt5t6LXGRctZE
	 ZWv3XucsyeVlkODfyLfynLV7TVZhhrQyhOpJcHv0ojNVYcJl7YBTOmR3sUF4437ZUh
	 EcuFoAVR1j0Cw==
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
Subject: [PATCH v2 03/11] perf tests: Exercise the flexible array member path
Date: Fri, 13 Nov 2026 17:08:41 -0300
Message-ID: <20261113200850.2803460-4-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113200850.2803460-1-acme@kernel.org>
References: <20261113200850.2803460-1-acme@kernel.org>
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

No test covered find_flex_array() and get_flex_array_member().  Add one
that keeps a struct with a trailing data[] behind a global pointer and
checks that accesses past the struct size are resolved and named after
the flexible array member.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/tests/shell/data_type_flex_array.sh  | 104 ++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100755 tools/perf/tests/shell/data_type_flex_array.sh

diff --git a/tools/perf/tests/shell/data_type_flex_array.sh b/tools/perf/tests/shell/data_type_flex_array.sh
new file mode 100755
index 0000000000000000..983cde2b3c7d2b29
--- /dev/null
+++ b/tools/perf/tests/shell/data_type_flex_array.sh
@@ -0,0 +1,104 @@
+#!/bin/bash
+# perf data type profiling tests for flexible array members
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+perfout=$(mktemp /tmp/__perf_test.perf.out.XXXXX)
+prog=$(mktemp /tmp/__perf_test.flex.XXXXX)
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
+struct flex {
+	int len;
+	char data[];
+};
+
+static struct flex *gp;
+static volatile sig_atomic_t done;
+
+static void stop(int sig)
+{
+	done = 1;
+}
+
+int main(void)
+{
+	unsigned long sum = 0;
+
+	gp = calloc(1, sizeof(*gp) + 4096);
+	if (gp == NULL)
+		return 1;
+	gp->len = 4096;
+
+	signal(SIGALRM, stop);
+	alarm(1);
+
+	while (!done) {
+		sum += gp->data[3];
+		gp->data[5] = 1;
+	}
+	return sum != 0;
+}
+EOF
+
+# -fPIE keeps the global pointer load PC-relative on x86_64, so the
+# resolver can tell the register holds a struct flex pointer.
+if ! cc -O0 -g -fPIE -pie -o "$prog" "$src" 2>/dev/null; then
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
+if ! grep -Fq "# data-type: struct flex +0x4 (data)" "$perfout"; then
+	echo "FAIL: flexible array member not resolved"
+	cleanup
+	exit 1
+fi
+
+echo "flexible array member resolved"
+cleanup
-- 
2.56.0

