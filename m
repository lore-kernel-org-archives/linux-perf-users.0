Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582371;
	b=UCfhI0dNpv9+r43QUK7baz7PHGwEA4kFNBUDfZ9vLYDWGEId6MPBDAFC3K0au1H2m1u5
	 9AjYtmthWcHZ9/RAVESsfSiHt8McKdJ2XSLae9d6AzGE/ZDoF07GxdQ2bgKRsYRC6LANy
	 VsKNt90SJ0u16xQG41VMLi0rMEMni1ILsRbvhqtMXq6E8aS0nF0iU0YJW8S+4QlEki57k
	 EnNurEIqpvMnN//xi7mZqFaUsJLBNJ5fJqQ5EEqJYdiRa6McACyNv7PKzptyRUq6ZInu2
	 HF456v6AsAz4IAK504d0L6jjD3fJj19cYtKAW5msTfs+eFF04XgcMllnc5KjPt3l7pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582371;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gOw96QIu9a38Kx5P1BYN/ZHmNmKy8yPGb/otYrwHJls=;
	b=WIHbG51ywK8yTYy8B4Lo2QE+IfkIYKUXBC2iVdBQ8q44UaQ/v4ZPGMDHi7ir/ltGuLAu
	 83cfznPxARu/yun65jABQxVeJONo1ZWurxsGFh8dEpGimDS5JnnKdVU+KCAeXnArI7rC8
	 FYqaI+FKlx1eiCHEa6RLvDEvCDavBh7Vr88WBSb/lH4UGl2jUlBExJPnOc78cF2AQpVH3
	 JBQ0giCXsRSXeJ/vbOfikovfnxYViK6YELPdRKs54n9Ev8fOIrCD6BtxfaAQAPCBowWPo
	 EtlQ56IEknRhYN6jtVUBTJRBVFZ9f9YY9ctGlFDwqTzn3LfAdIb6wGSgiTt+Dnv0Z/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WmzRc97z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC3E606A8AD;
	Fri, 13 Nov 2026 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WmzRc97z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146CC1F000C4;
	Fri, 13 Nov 2026 15:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794582371;
	bh=gOw96QIu9a38Kx5P1BYN/ZHmNmKy8yPGb/otYrwHJls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WmzRc97zrDELQ+xDrhMYrKgn7K9hzjMA89zDHd6dgenACHfUXf1qjfNYASRdbaq26
	 9mjZKu992uHonMDnQeMmOZ2Ks7SWh9CRl5IqoJbirKS7kTU5OstSMXYBH2eM8A5/n3
	 dV1roeUtoiFnD30WRMgR4RWpXprPQ6Eg96o5kwBQa4ucutf0wuLwXJ8XQwdxoCWalV
	 St0IGr3jD6Tsda4WR+7Z4aXmcacs4eiIkFbdG8fbI+8G/YQUOSHKUiQtFXpUnwhfQt
	 p4hVUkwQxzOzVGBNNnYs68CXOQwby4OiHNvw8gNMhlbPvoirKDktKyJ3LpTLriOOeY
	 4Vs6DZmMrwTrA==
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
Subject: [PATCH v1 03/12] perf tests: Exercise the flexible array member path
Date: Fri, 13 Nov 2026 12:05:44 -0300
Message-ID: <20261113150555.1163049-4-acme@kernel.org>
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

