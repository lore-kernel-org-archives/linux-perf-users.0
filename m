Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795231296;
	b=CMj1nDS1fy1Ib94w3glyiTwjpzUzQUo+K4GSknD4ABeRa1L8Ed/7RG7O/Uy3UmDGo3Kg
	 qMjaQecXmqh6ALobn9AQ80L1InkhhzINLtcdsN4MlkyB+o4Ka71DJwDgyIuwkuyLTQxPy
	 Qgg6uqwwIKOjYPQfCAek9NKj4EjarTDN0/gyJc5bJmPAZP5Lhsh61MxIdUEz7Fa5udRcZ
	 CChmKhZjjWzbrm1Eug926eaY+7N8j6uPTvR7XTwEJSkgO4D2mWXHuV7Xu+gx9NHk7V9XS
	 qhUPTUQANK6t/PMNkIlY6hZWvYReqbQP33KvW3ITXgqRyaZYkruRJUbalV4lBBihvDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795231296;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aMx8BnRMRyGMMSF2p2Wz8shNkvW5U8poKwNGHCZEKAM=;
	b=uWkFjAmz9EGRbZGZJCJQKz5hRerS+5vdi9l5hxdWEvA/kfscPsji1RHbW6fStWV2F/kC
	 wAGGVZvnB1zktyGMKGENsAGKD9TlyNbhwqbuEbT3UhXUn7n+kg6dOLQXpAkDYu6GHGwYL
	 ghw5TfFWBDQKjPXhxdyVzhPTUsQVGtkXcfXuOPQKDkSiqyOiF2TqRMUz/0UAWLMcbBDOh
	 CvAF4KpEQKJSqsSc/qOaXGuG9ji+MIIj7LoQUv2kVqA83FRi3W4zb11RazV3gZhnAVDp5
	 WN6njpTXOHv6+ffo/xXpRlelZJnOcAQKTm9KEvcbnvjAhoeN1gnxvQJ94wW/3cEGE+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jB/gC7GU";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C218606A33D;
	Sat, 21 Nov 2026 03:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jB/gC7GU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5F11F000CF;
	Sat, 21 Nov 2026 03:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795231296;
	bh=aMx8BnRMRyGMMSF2p2Wz8shNkvW5U8poKwNGHCZEKAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jB/gC7GU8OHcmevZMVmM6rqkzOInADRK9SPULIYfEsZtWtmpLG+RAFq7nLqQejfq5
	 UXbdypqoYTsStVQy34dteXPDDb2QNm/vTgS8LpNVG/pZCJ6tXqNWDWN6M+FtVGhw7k
	 tUAZ998KbqkQFhao19eS0WNNt3J+vlSGf5G1+Xg9fP/x8drDeTOURgqSV8wIeFZ2lG
	 O7IGl/YGRBjZNPmSl8O+Wcv4FoTG7ZngT56aWoEFkXw+YjLF808pnqk9QDVopmgmqy
	 w/PjUeSnrLxj7Prr+Uss7SKy3ThNcSbrSFlah2L59evRAPEauba1Po+wx85qe/WFyA
	 4GqBT8a+i0/xw==
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
Subject: [PATCH v10 11/16] perf tests: Exercise the annotate stats output
Date: Sat, 21 Nov 2026 00:20:47 -0300
Message-ID: <20261121032052.1392234-12-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261121032052.1392234-1-acme@kernel.org>
References: <20261121032052.1392234-1-acme@kernel.org>
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

Add a shell test for the --insn-stat and --type-stat output printed
after the annotations, and for the warning when --type-stat is used
without --data-type.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/annotate_stats.sh | 69 ++++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100755 tools/perf/tests/shell/annotate_stats.sh

diff --git a/tools/perf/tests/shell/annotate_stats.sh b/tools/perf/tests/shell/annotate_stats.sh
new file mode 100755
index 0000000000000000..5af48bf187c5e8f5
--- /dev/null
+++ b/tools/perf/tests/shell/annotate_stats.sh
@@ -0,0 +1,69 @@
+#!/bin/bash
+# perf annotate instruction stats test
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
+if ! perf mem record -o "$perfdata" -- perf test -w datasym > /dev/null 2>&1; then
+	echo "FAIL: perf mem record"
+	cleanup
+	exit 1
+fi
+
+if ! perf annotate --code-with-type --insn-stat -i "$perfdata" --stdio \
+		--percent-limit 1 > "$perfout"; then
+	echo "FAIL: perf annotate"
+	cleanup
+	exit 1
+fi
+
+# The instruction stats are accounted while the instructions are
+# displayed; printing them before the display loop shows zeros.
+if ! grep -Eq '^total [1-9][0-9]*,' "$perfout"; then
+	echo "FAIL: instruction stats not accounted"
+	tail -n 30 "$perfout"
+	cleanup
+	exit 1
+fi
+
+if ! perf annotate --type-stat -i "$perfdata" --stdio > /dev/null 2> "$perferr" ||
+   ! grep -Fxq "Warning: --type-stat needs --data-type" "$perferr"; then
+	echo "FAIL: missing --type-stat warning"
+	tail -n 30 "$perferr"
+	cleanup
+	exit 1
+fi
+
+echo "instruction stats accounted"
+cleanup
-- 
2.56.0

