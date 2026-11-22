Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795383675;
	b=IenTScaGjxMtdDMwZZHj8zskdfiVu28DXOJt/IVelpiruhUeFeZVUC9sy+476W15SClF
	 +SsLQu1a/FDR89fxTVl2OTZ0Q3493QOQhxEMRosICnc1KrIvXfkUZZtpX5HCnuFicLWfb
	 mXWYpP5OzDp/o3p6J/w0SvPzPg+H9RVwbwZ4FmVK2pQmr46lXMPf6RKn+1u4OiZOTeSwo
	 S/UYRSiPTrm4VOBFVQcJaO3UgbkJ2uOH2xPvO+j+jCZCw2eZItkKdaumS0denAW22YF+D
	 6Q0mPyAqb9DQC5JBqCmC1koUR1adyBcpZp/UH+M+f1xbsPPiJrqNlDHq+EbanPDiwrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795383675;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=L7LgMWelgSFCPRdJlOZBg8BypfgyuGdT7FTtHF4eyf0=;
	b=MXrhbbYa7IWk+O0U4OaBzJcGlZ+IXlzk0WK1+dp96KphhvL3/J1KKSUXwPFP6ZMUdAaS
	 2D/tiT9rh6iuFVLLax5XHOuuU2BfNn1sAQiPaYZW7RV9I+GQUG4Yvddj2NCfLkPVopVCD
	 cgnfXR/PZr5BtT4g3wRtXyp/eTu6aHTZB4HMbwG+rSd4zCqa//O4DYB4uDonWRtHy9x1L
	 gSKnmLlDdvN93Or7gBt2gcH2ecl8wLqAyaUPK0vwprCFGY7Wv0UEyJrEVjwvoL+iyk4l8
	 qTpMhtjgwQlCHJQl09jXlJWqP6h8VbRE1ky/oMDOmQqaid/1Pv6g256FDd0Xc4PA6Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SSeDmni3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8515606A32C;
	Sun, 22 Nov 2026 21:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SSeDmni3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4644C1F000D1;
	Sun, 22 Nov 2026 21:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795383674;
	bh=L7LgMWelgSFCPRdJlOZBg8BypfgyuGdT7FTtHF4eyf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SSeDmni3QcJ6EEVq5O9CPGRltPe+DNllZnUe+xBamDsp4sTzsFBpMCMs08sLYueP6
	 C+ECWLFhMeWESrdcL3Al+GIQo5P4sJPl5hjcKDrXu+dyxLsbxwf0NajBj24Rhm6JWB
	 6C38I+b4RPaEUZgrpCJ2ft/lhIUF6xzLjohBomkEVjf2cLJAzjNkIGCDZ6jxcg0m+k
	 /ui5DEK1PT185BvIGnw+l2rHeSiyQAk0/gowGJkWFzEbY8LE1BsDMCmJsqcaW+GQre
	 BvGTAUxIaTwniDQJeuf01r3PnL4ZWuOaBkkhtvkbW3JXzElwotlhWe3annstIvHuLn
	 JrfTRTDJ1nYDw==
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
Subject: [PATCH v11 12/19] perf test: Exercise the annotate stats output
Date: Sun, 22 Nov 2026 18:40:18 -0300
Message-ID: <20261122214025.16769-13-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261122214025.16769-1-acme@kernel.org>
References: <20261122214025.16769-1-acme@kernel.org>
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
once, after the annotations, and for the warning when --type-stat is
used without --data-type.  The instruction stats run with one and with
two events and are checked against the per-instruction rows, so a total
that counts only the first event, or does not match the rows, fails; the
data type total is checked against its counters.  A repeated section
also fails.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/annotate_stats.sh | 172 +++++++++++++++++++++++
 1 file changed, 172 insertions(+)
 create mode 100755 tools/perf/tests/shell/annotate_stats.sh

diff --git a/tools/perf/tests/shell/annotate_stats.sh b/tools/perf/tests/shell/annotate_stats.sh
new file mode 100755
index 0000000000000000..5d8a687e85ecb526
--- /dev/null
+++ b/tools/perf/tests/shell/annotate_stats.sh
@@ -0,0 +1,172 @@
+#!/bin/bash
+# perf annotate instruction stats test
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+shelldir=$(dirname "$0")
+. "${shelldir}"/lib/perf_has_symbol.sh
+
+skip_test_missing_symbol datasym
+
+perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+perfone=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+perftwo=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+perfout=$(mktemp /tmp/__perf_test.perf.out.XXXXX)
+perfout2=$(mktemp /tmp/__perf_test.perf.out.XXXXX)
+perferr=$(mktemp /tmp/__perf_test.perf.err.XXXXX)
+
+cleanup()
+{
+	rm -f "$perfdata" "$perfone" "$perftwo" "$perfout" "$perfout2" "$perferr"
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
+if ! perf record -o "$perfone" -e cpu-clock -- perf test -w datasym \
+		> /dev/null 2>&1 ||
+   ! perf record -o "$perftwo" -e cpu-clock -e task-clock -- \
+		perf test -w datasym > /dev/null 2>&1; then
+	echo "FAIL: perf record"
+	cleanup
+	exit 1
+fi
+
+if ! perf annotate --code-with-type --insn-stat -i "$perfone" --stdio \
+		--percent-limit 1 datasym > "$perfout"; then
+	echo "FAIL: perf annotate"
+	cleanup
+	exit 1
+fi
+
+if ! perf annotate --code-with-type --insn-stat -i "$perftwo" --stdio \
+		--percent-limit 1 datasym > "$perfout2"; then
+	echo "FAIL: perf annotate"
+	cleanup
+	exit 1
+fi
+
+# The instruction stats are accounted while the instructions are
+# displayed; printing them before the display loop shows zeros.  A single
+# positive total would also accept a stale first event's total, so check
+# that the section is printed once, after the annotations.
+if ! awk '
+	/^Annotate Instruction stats/ { sections++ }
+	sections && /^[[:space:]]*[0-9]+\.[0-9]+ : / { late = 1 }
+	END { exit !(sections == 1 && !late) }
+' "$perfout2"; then
+	echo "FAIL: instruction stats not printed once after the annotations"
+	tail -n 30 "$perfout2"
+	cleanup
+	exit 1
+fi
+
+# Each event annotates the same instructions, so the two-event total is
+# twice the one-event total.
+one_total=$(awk '/^total / { t = $2; sub(/,/, "", t); print t; exit }' \
+	    "$perfout")
+two_total=$(awk '/^total / { t = $2; sub(/,/, "", t); print t; exit }' \
+	    "$perfout2")
+if [ -z "$one_total" ] || [ -z "$two_total" ] ||
+   [ "$two_total" -le 0 ] || [ "$two_total" -ne $((2 * one_total)) ]; then
+	echo "FAIL: instruction stats do not count every event" \
+	     "(one event: ${one_total:-none}, two events: ${two_total:-none})"
+	tail -n 30 "$perfout2"
+	cleanup
+	exit 1
+fi
+
+# The totals are the sums of the per-instruction rows.
+if ! awk '
+	/^total / {
+		t = $2; o = $4; b = $7
+		sub(/,/, "", t); sub(/,/, "", o); sub(/,/, "", b)
+		total = t; ok = o; bad = b; next
+	}
+	/^  .*: +[0-9]+ +[0-9]+$/ { good += $(NF - 1); bads += $NF }
+	END {
+		exit !(total > 0 && total == good + bads &&
+		       ok == good && bad == bads)
+	}
+' "$perfout2"; then
+	echo "FAIL: instruction stats do not add up"
+	tail -n 30 "$perfout2"
+	cleanup
+	exit 1
+fi
+
+# No point in recording the data type samples if the PMU cannot do memory
+# events.
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
+# The data type stats are only printed with --data-type, and must be
+# accounted like the instruction stats above.
+if ! perf annotate --data-type --type-stat -i "$perfdata" --stdio \
+		> "$perfout"; then
+	echo "FAIL: perf annotate --data-type --type-stat"
+	cleanup
+	exit 1
+fi
+
+if ! awk '
+	/^Annotate data type stats:/ { sections++ }
+	sections && /^Annotate type: / { late = 1 }
+	END { exit !(sections == 1 && !late) }
+' "$perfout"; then
+	echo "FAIL: data type stats not printed once after the annotations"
+	tail -n 30 "$perfout"
+	cleanup
+	exit 1
+fi
+
+# The total is the sum of the bad counters and of the good ones.
+if ! awk '
+	/^Annotate data type stats:/ { stats = 1; next }
+	!stats { next }
+	/^total / {
+		t = $2; o = $4; b = $7
+		sub(/,/, "", t); sub(/,/, "", o); sub(/,/, "", b)
+		total = t; ok = o; bad = b; next
+	}
+	/^[[:space:]]*[0-9]+ : / && $3 != "insn_track" { fields += $1 }
+	END { exit !(total > 0 && total == ok + bad && bad == fields) }
+' "$perfout"; then
+	echo "FAIL: data type stats do not add up"
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
2.56.1

