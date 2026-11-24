Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546011;
	b=yFTgB1pwU93upwyL3EndGHVnu35f+q5ffkWfGfEtCs5waDGhCsX4gw26/wwMjkN4I9r+
	 gGPQTV2cWErVUtqscyqgkm4mfDCWttq25pFfR/QvGdLH11eTrEbNYHFV3xck715jmlwwZ
	 LXUdTJZGlqvQoo6UnnSup+gWqiwqBAO8eV6tUQ7hiivLDKR7W1oXBXHiYTKXP9Qhmw3QW
	 T/2rrQg7Z0NUm7fCQtyFaxCTs3vnWSM/8ovKD25NFrOo13XBGoKd9gYznN+ofeM4LEPn7
	 ZWrJeIrNxPN/dFHqsoG6uLyhRyuIGj+0kt3K815MY7QmbDn8DtfGYbk32Z0it+sVwGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546011;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XTukCFqoz3XUndLnYT955iLc7efqig7bApIyB0oL9yE=;
	b=yOFFeagaQwgI+b9/R28vRFvVioAQtb18XkYWshNKzmfeEeI/V4nJhpF0qvhUlbZH/uYR
	 Hm6Pb6IAMe1vhY65Nx+ebgbFPuwEZb8et6v+GjlurDHKDkaQ1lGe8teZwTA4WzwL0ZRqM
	 5mVMHTxCzTIYkM5j891BybIaMNfS0MW0Whg4+wu4h4HSluLorrWtRhqbzXOfkktqAw4EM
	 e5NSdu7nfECrECZZMtBlTiugQln1m764moBJUS7VJenaKwU6wJkf+Wn77ULKKmepzaa3C
	 7K2VgAzCMBB6bSAmbrvBjDObpTGOJeF7XnnpGA1KyRBScQKR984PEPyh5zqZLl1jiGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KwS/t4wM";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7FE606A323;
	Tue, 24 Nov 2026 18:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KwS/t4wM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B64F1F000C0;
	Tue, 24 Nov 2026 18:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795546010;
	bh=XTukCFqoz3XUndLnYT955iLc7efqig7bApIyB0oL9yE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KwS/t4wMfu5RHRhIUms6hfdLUEj525uLZ0ywe1/t/Hnqc0EWlVNaz2EpeEtBWXpnP
	 +bTU2XwqHScZIKT36Cp0SK/Ed1m1yOmLDUDEMJYA45tHdd4lxXoHs7f4FCUahL1/ka
	 JDu02quCOGCiaQ345l6JJA03SYPGXy0d2orXlbvMyDn4904LKQqkS+/CAUfVr8G21j
	 NBC5MkPu1oZMroO7xwGo3U2846JxTD9GOhRZW5/o0lWMdzTvOXsJRa6zULDvyk/dvg
	 oWKnZOjR3G+21D4MF3GsKu5FyNlIsg7+lpWcZw63j3QaAcPv+t9m2vYr2k54e/rLGq
	 /CUMhdUbn1v2A==
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
Subject: [PATCH v1 11/17] perf tests trace: Exercise the tracing options
Date: Tue, 24 Nov 2026 15:45:58 -0300
Message-ID: <20261124184604.24983-12-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124184604.24983-1-acme@kernel.org>
References: <20261124184604.24983-1-acme@kernel.org>
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

Cover page faults, scheduler stats, syscall and failure summaries,
event limits, callchains, target filters and the remaining tracing
options.  Like the summary test it needs root.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/trace_options.sh | 97 +++++++++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100755 tools/perf/tests/shell/trace_options.sh

diff --git a/tools/perf/tests/shell/trace_options.sh b/tools/perf/tests/shell/trace_options.sh
new file mode 100755
index 0000000000000000..3f686a293bb9d557
--- /dev/null
+++ b/tools/perf/tests/shell/trace_options.sh
@@ -0,0 +1,97 @@
+#!/bin/bash
+# perf trace option tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+. "$(dirname $0)"/lib/probe.sh
+
+skip_if_no_perf_trace || exit 2
+
+# The syscall tracepoints need root to open.
+if [ "$(id -u)" != 0 ]; then
+	echo "[Skip] No root permission"
+	exit 2
+fi
+
+err=0
+out=$(mktemp /tmp/__perf_test_trace_opts.out.XXXXX)
+
+cleanup() {
+	rm -f "${out}"
+
+	trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+	echo "Unexpected signal in ${FUNCNAME[1]}"
+	cleanup
+	exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+run_trace() {
+	local desc="$1" expect="$2"
+
+	shift 2
+	echo "Trace ${desc}"
+	if ! perf trace "$@" > "${out}" 2>&1; then
+		echo "Trace ${desc} [Failed: perf trace failed]"
+		cat "${out}"
+		err=1
+		return
+	fi
+	if [ -n "${expect}" ] && ! grep -qE "${expect}" "${out}"; then
+		echo "Trace ${desc} [Failed: missing '${expect}']"
+		cat "${out}"
+		err=1
+		return
+	fi
+	echo "Trace ${desc} [Success]"
+}
+
+# Page faults are software events, not syscalls, and exercise the
+# separate page fault printing path.
+run_trace "pagefaults" "fault \[" -F all -- perf test -w noploop 1
+run_trace "minor pagefaults" "fault \[" -F min -- perf test -w noploop 1
+run_trace "major pagefaults" "" -F maj -- sleep 0.1
+
+# sched_stat_runtime feeds the "sched" summary counters.
+run_trace "sched" "" --sched -s -- sleep 0.1
+
+run_trace "syscalls" "" --syscalls -- true
+run_trace "events" "openat" -e openat -e read -e write -- cat /dev/null
+run_trace "failure" "" --failure -- false
+run_trace "errno summary" "" --errno-summary -s -- cat /dev/null
+run_trace "summary" "" -S --summary-mode=total -- cat /dev/null
+run_trace "summary thread" "" -s --summary-mode=thread -- cat /dev/null
+run_trace "duration filter" "" --duration 0.01 -- cat /dev/null
+run_trace "max events" "" --max-events 5 -e write -- seq 1 100
+run_trace "sort events" "" --sort-events -e write -- echo hello
+run_trace "call graph" "" --call-graph fp --max-stack 5 --min-stack 1 \
+	-e write -- echo hello
+run_trace "kernel syscall graph" "" --kernel-syscall-graph \
+	--call-graph fp -e write -- echo hello
+run_trace "libtraceevent print" "" --libtraceevent_print \
+	-e kmem:kmalloc -- true
+run_trace "filter pids" "" --filter-pids 1 -- cat /dev/null
+run_trace "proc map timeout" "" --proc-map-timeout 100 -- cat /dev/null
+run_trace "mmap pages" "" -m 8 -- sleep 0.1
+run_trace "delay" "" -D 10 -- sleep 0.1
+run_trace "no inherit" "" --no-inherit -- sleep 0.1
+run_trace "uid" "" -u "$(id -un)" -- true
+run_trace "cpu" "" -C 0 -- sleep 0.1
+run_trace "pid" "" -p $$ -- sleep 0.1
+run_trace "tid" "" -t $$ -- sleep 0.1
+run_trace "verbose" "" -v -e write -- echo hello
+run_trace "bitmask list" "" --bitmask-list -e openat -- cat /dev/null
+run_trace "print sample" "" --print-sample -e write -- echo hello
+
+echo "Trace invalid pagefault type"
+if perf trace -F bogus -- true > "${out}" 2>&1; then
+	echo "Trace invalid pagefault type [Failed: accepted invalid value]"
+	err=1
+fi
+
+cleanup
+exit $err
-- 
2.56.0

