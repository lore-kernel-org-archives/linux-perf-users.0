Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795743534;
	b=XsHOaUEHB8xUQolCMe5jOqJpfIOGN9ujrkMno9neRQqJpSYvNGpfGmrDcb0agwz2Ctxj
	 nxDuuPfFmGTCkVKVUXhKMPwARJ1xfY128k2R+KKo3zN5o9QpQlNbVr6VAWWKM7XH+3Szi
	 6vjaSdHR+JoJsDqElJHhdd7guSG4PX06NHs+zp5DlAwyZJPUb6S+6ssUERv8d+raplxC7
	 niX/7B53GPkeQJTN+4JEqLLrRVSoAGTHnXhSwtnsl2ziX2nThXQQ09dnkDhl4t/BoJ5FR
	 b6XEV06QUJNoj4bviTOqdTDnNURxrXtR1FTmZjM7Lf37LTGrt8Pi44ZxnnTfjgdAtWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795743534;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=O78ah5N1oqd6VDyLowFG/7BD2J9RODMHe5GGvZ8b2fA=;
	b=MD2J9gr15eGVi7c3Bsg4RuVfZSP2afqHP7nRBZVbukeNdu/5QB1l93omuaPNW4z2jcCf
	 w/FivjwL5bSh9dH2XLxUvdR1Gs4ukhH7wA4XGxI99ydQj4Pf7fO75zmKpLig494nuGGi7
	 rhE9RRdgxLzcBX9T15W/W6LUunXMki6EKzjcOZpskMRZp9Btld8E/okRTZXHf1B+5TCWh
	 ertLmKMRYcnzS50eC0SyOo2AE4yDXTrU7VZJfW/XkEZ/bkji5Syq4MqZ4VNVnKzItKy0E
	 ksGONg9lKG0lx1O044JAf+ZgJomMPDZOcBXT8IG3ImR6GIhuSOt5VKQ8Hw6vV9eD5uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PjkwlF0F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3A2606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 01:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PjkwlF0F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616C81F00893;
	Fri, 27 Nov 2026 01:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795743534;
	bh=O78ah5N1oqd6VDyLowFG/7BD2J9RODMHe5GGvZ8b2fA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PjkwlF0FUjVCltq4hZByTYoe9IcwdihJRnkL65u0ZwybcApkJU/xlUW8bX1EB8Jnq
	 HlAoU0MS+OvOVCf7D6w4iHDAyACAW5ABBrrQ12FCdEkvGaXnl+JnpDTlFbrVKS0h+4
	 6BrMNeLVSFJwKfEN3QzzCNkUv3iSaaT/jgKbUXkt5IZ1a9bWtKr+gD6dLg1oTsyTtg
	 gKio0Up/XAUIY14zgwmWRsqntZWI9uzB89jUVSa05oI+XbFya02cHssf2DFHuPvRSR
	 SLFEBCoFwmWSfEUhiAH1Rc736majWTKcuKq2WP5T/b5x2mwcRFVxhUquugC81rQdgp
	 LOwG9n/QM845Q==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v2 12/18] perf tests trace: Exercise the tracing options
Date: Thu, 26 Nov 2026 22:37:55 -0300
Message-ID: <20261127013801.14841-13-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127013801.14841-1-acme@kernel.org>
References: <20261127013801.14841-1-acme@kernel.org>
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
 tools/perf/tests/shell/trace_options.sh | 103 ++++++++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100755 tools/perf/tests/shell/trace_options.sh

diff --git a/tools/perf/tests/shell/trace_options.sh b/tools/perf/tests/shell/trace_options.sh
new file mode 100755
index 0000000000000000..5935f9ced6effa03
--- /dev/null
+++ b/tools/perf/tests/shell/trace_options.sh
@@ -0,0 +1,103 @@
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
+# -e is a callback that replaces ev_qualifier, so the syscall list must
+# be a single comma-separated argument rather than three -e flags.
+run_trace "events" "openat" -e openat,read,write -- cat /dev/null
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
+if perf check feature -q bpf_skeletons; then
+	run_trace "uid" "" -u "$(id -un)" -- true
+else
+	echo "Trace uid [Skipped: no BPF skeleton support]"
+fi
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

