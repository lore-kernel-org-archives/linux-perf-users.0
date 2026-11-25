Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634639;
	b=PN7FEBaRvZjF1P4glzLlTDhvXZfs19b1gBKbxoZr5URJ74uMP599S70ZrCKj39ad8cgj
	 IK37oNWu47UB1KdpFUvMlHpi6IKqte9cXX1nI3eicxmGGUI0ZB2rCJ+nb4DWnMQ629nO9
	 /h1GMSZCc+NY6YpIvo3WYGw38FFJcB3AdllVoUzmC/xTL4A41KhtlPZAuiHGT+qke6aRH
	 dkez6Ho5PtMXYNMS4zBpF460ve+d3eFAFhHpp/ldv99KCw/dp2HvdPB0VsoFUYZ51etv0
	 HFo8fXmPRGxJHIMq6yFum+K21k5EcHHrgvjxc0tVOkcf2/Xd70HtvgE7phxSD38U0Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634639;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9pqTRArJvWden/UxEsaajngD3idnajVSzJD/emrq9ow=;
	b=LgPGYVNoNm3wMOI0MHLNXCsWglpE/1vtICqwOts07G9VfsBtzPzEAobGfEweKtaSZN/k
	 E9IN+jLlICtD/YOSQVVWYACUDQjzdZGdcJpZCmTH0D6QX4urVUX75GDZ+nm5uivIYlw8V
	 bP9O5AIJbFMIL1/RZCJrA2kbLFz2gs+K/EFnIlTQrUMYnDFoBfTDmtkBdUlKsEk3sBDy6
	 n5ZBKLIkOzXP2D5yNagvwMIUsW5s+Sc3r5jqJyY+pxK1DL7YFuzD59FT6i268MgtvrttG
	 IDMvY477DynbCCHWRnq2jVSP77aRxOb9CikliQDawR873iCnZZ47x7XFrNNPo2hGyZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BCTysq8Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A75606A32A;
	Wed, 25 Nov 2026 19:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BCTysq8Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764D81F000C0;
	Wed, 25 Nov 2026 19:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634639;
	bh=9pqTRArJvWden/UxEsaajngD3idnajVSzJD/emrq9ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BCTysq8ZBFfwTigtE5aeWwl32tqds4bZEI9vibY5BHbou9VESPMP46wknzZlQVhsi
	 fNOhSebiW5kEM2/bgPRfG62r67wvghKwT6jstwNkkTUlr0r6MYMt5JUW6gTT3SYAzE
	 ADpq972+HaTB5Y5R9D2M7i3cCaxy+7shKeey5yRPvODxOOL11H1sSOlBXQ2VEwiaOK
	 CUN3b+vg045Rleqpyw0t/7sm84ikcwL3ZFHdJAE3HDP8v2T4Ou2SEzHNzXA0Nx7A+G
	 ZAW8+7nDvj+TK0VlO09nkrH/eSCF3Sc/d7BFy4oyDIZb2L5RNqtrlb8OaGE7ywWWA1
	 Dt/JRLuYam/WQ==
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
Subject: [PATCH v13 12/19] perf test: Exercise the annotate stats output
Date: Wed, 25 Nov 2026 16:23:05 -0300
Message-ID: <20261125192312.34134-13-acme@kernel.org>
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

Add a shell test for the --insn-stat and --type-stat output and for the
warning when --type-stat is used without --data-type.  The
--code-with-type stats are resolved while printing, so they are
expected once, after the annotations; the plain --data-type stats are
resolved in the histogram resort, so they are expected once, before
them.  The instruction stats run with one and with two events and are
checked against the per-instruction rows, so a total that counts only
the first event, or does not match the rows, fails; the data type total
is checked against its counters.  A repeated section also fails.

Operand extraction is implemented only for x86, arm64 and powerpc, so
other architectures skip rather than fail on the zero totals it would
leave.  The bad counters check compares numerically: when every access
resolves no counter line is printed, and awks that follow POSIX would
then compare "0" to the unset sum as strings.  The warning is matched
as a substring, as some disassembly errors are printed without a
trailing newline and would join it into one line.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/annotate_stats.sh | 186 +++++++++++++++++++++++
 1 file changed, 186 insertions(+)
 create mode 100755 tools/perf/tests/shell/annotate_stats.sh

diff --git a/tools/perf/tests/shell/annotate_stats.sh b/tools/perf/tests/shell/annotate_stats.sh
new file mode 100755
index 0000000000000000..085dde4ddecff18f
--- /dev/null
+++ b/tools/perf/tests/shell/annotate_stats.sh
@@ -0,0 +1,186 @@
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
+# The data type stats are accounted in the histogram resort, before any
+# annotation is printed, and must add up like the instruction stats above.
+if ! perf annotate --data-type --type-stat -i "$perfdata" --stdio \
+		> "$perfout"; then
+	echo "FAIL: perf annotate --data-type --type-stat"
+	cleanup
+	exit 1
+fi
+
+if ! awk '
+	/^Annotate data type stats:/ { sections++; after = 1; next }
+	after && /^Annotate type: / { annotated++ }
+	END { exit !(sections == 1 && annotated) }
+' "$perfout"; then
+	echo "FAIL: data type stats not printed once before the annotations"
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
+# -F without -x: some disassembly errors print without a trailing
+# newline and would join the warning into one line.
+if ! perf annotate --type-stat -i "$perfdata" --stdio > /dev/null 2> "$perferr" ||
+   ! grep -Fq "Warning: --type-stat needs --data-type" "$perferr"; then
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

