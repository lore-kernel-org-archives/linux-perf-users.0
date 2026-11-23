Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471271;
	b=qpCMWwmh+xUKMs8AsRK58F+Ib6hgeNt6lIK2nemWjE08sFmjU1HwnvdnnhW7QEjJqDWh
	 QvCHOrngmqePkOh++CXOk02E0QAncVnRFJLm2eTDwoNNHR7uAJNdV5mrJKBqn7HUkOoRR
	 VsLAGyd/LzLU592BmgPgylWP5SYIk9vThhs/dPeTbAYEM9dUUnl3t84+3UfuZyR5jHsBf
	 yXcaZTGbkKctmw3oNKvrAvJTa7zy8wz5yB0Goa6CK+P5hoTXYq7FSQlfLBFUJBIDrieVX
	 EI16zvhTRCktsnyqyaR7p0J14oydfDKh2Z+bUpvimWm+KyKD7iwMDu9uBcumFYhbHyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471271;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1j8VXhTVKIF04Lq/RG5Pb16hiru/FP0yKgb9wxd0Glg=;
	b=TlmBHrp5a/BDQZbxhJjwdwgQ34HixXhI41SoFMWTKmwiK1etDN9NOAXfY6VrQiElG5G0
	 9RQa+2PPJpiEdBVvzDYOzjKagl9ZjpyqR0Ic6SvDsY7CtUTB2sraLDs4uSJxp6FoxIA28
	 +zQQ4xgGwdCWLK9keSk/jq0r+2Pw2sbNEi50ONzvs7d8qIiMVgdMPxX+GFNxZFr5ulFfn
	 Y8rNRBkXtYOz4/H99rgK1lcZuumpIuH3MoqXNjpIZVp8bBVhG4E37Dd2lxcDATKykXqlz
	 ZKioguVT2NSh/m6cJCE3M1IYfM1up1ORc0gIZUb+Mzjya0UVrIrHm+fCitz24Lrdpzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KjfpFLv4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8264D606A327;
	Mon, 23 Nov 2026 22:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KjfpFLv4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E0E1F000CF;
	Mon, 23 Nov 2026 22:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795471271;
	bh=1j8VXhTVKIF04Lq/RG5Pb16hiru/FP0yKgb9wxd0Glg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KjfpFLv402VtFNT81MNjRYjMu+DLccbsyF1GEjRMbSFHUaE0mD0uJF7ZVaKoOSY3z
	 2aKfdHrpL665ht9SAovrPCEj5Dy8ACHgT+gqyu9ABIIbNnG/zkTTfJmUdDoL+k1HmC
	 oeYfc852cxz4IZgA7tUMOvi+g76cIyZ1ge4NxdnJQtGT0Pu1auKSBCzzNqMNXpzU/h
	 6ayvvccbYgFRfHfehtRCVtuAITMGlSjliuvC/6wnoZDoSX9TrxmTng7OprslqbCRXG
	 jl5yPNevC9+i5HQ4+9HO4TCPGl3YZJ40kL1q2KYp4W5bsIl+74XSX6TbtKEuzBHKRi
	 iTPRbxcA0kpNw==
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
Subject: [PATCH v12 12/19] perf test: Exercise the annotate stats output
Date: Mon, 23 Nov 2026 19:00:17 -0300
Message-ID: <20261123220024.14891-13-acme@kernel.org>
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

Add a shell test for the --insn-stat and --type-stat output printed
once, after the annotations, and for the warning when --type-stat is
used without --data-type.  The instruction stats run with one and with
two events and are checked against the per-instruction rows, so a total
that counts only the first event, or does not match the rows, fails; the
data type total is checked against its counters.  A repeated section
also fails.

Operand extraction is implemented only for x86, arm64 and powerpc, so
other architectures skip rather than fail on the zero totals it would
leave.  The bad counters check compares numerically: when every access
resolves no counter line is printed, and awks that follow POSIX would
then compare "0" to the unset sum as strings.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/annotate_stats.sh | 184 +++++++++++++++++++++++
 1 file changed, 184 insertions(+)
 create mode 100755 tools/perf/tests/shell/annotate_stats.sh

diff --git a/tools/perf/tests/shell/annotate_stats.sh b/tools/perf/tests/shell/annotate_stats.sh
new file mode 100755
index 0000000000000000..656a4c510a8d890f
--- /dev/null
+++ b/tools/perf/tests/shell/annotate_stats.sh
@@ -0,0 +1,184 @@
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
+# The instruction stats are counted by the data type resolver, whose
+# operand extraction is implemented only for x86, arm64 and powerpc;
+# elsewhere the totals are zero by design, not because of a bug.
+case "$(uname -m)" in
+	x86_64 | i[3456]86 | aarch64 | ppc64 | ppc64le) ;;
+	*)
+		echo "Skip: no instruction operand extraction for $(uname -m)"
+		cleanup
+		exit 2
+		;;
+esac
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
+	END { exit !(total > 0 && total == ok + bad && bad + 0 == fields + 0) }
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
2.56.0

