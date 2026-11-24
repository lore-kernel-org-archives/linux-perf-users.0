Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546021;
	b=CvXxm8q+W+ibG/PV6SxGHCKsPJ9LYZxNivsvTbCx0F4n6DPt+nwBUdDPvQlvbzFukZX8
	 UtyfJvU7eXz1R0wPuI8qfcnB7t4b/BzlMUlZJm8Bi323G6x0f3sEUaTELPdxtE3Qq8Iy7
	 Tko0E3ZNQ/vBbD22M0OmqENykIb3z/oxOfzJOK+Kypv//Yj1yG91JAA68ZdU8zCH+fNGm
	 2FxqKdjPW+QWYGrJJolzsF4ZSexWLqOLT+xNR03Ip0MBx3EGwLSdyU0le6D7IABHCWwpF
	 AamkdBS4wAF3kLK9NoXOw2QZoxfbSKOr6xDIvGp1ddCh9bPS1B7x2XEGWGeB1wdMJ8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546021;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qm3hKmf/R0IakqyPcH/0Ia+Ukjs/ke23vwMPF/3cQLs=;
	b=jz9eTlZP/Tbhu9zXXoIS60PqRexNKpOK2V976oiRDzimLw+9qWyOfQgBxk51mHLuSoNc
	 J6dOdceYDKZnq3eVMsIfQyLHHMhOACnnHRjaZTkRLM6A7kIZUe+t+6xnacj46eFblnJ+C
	 1kvB3oSe5uzUOoh/vg2un5wHNxvckipcXiQ5Yyc2NsOMqWElTYouhBqhm5EO7yAvTQ/0a
	 wkVy60dkFeNCzTRx90FHv4prdyyL4uBl2TkxoTJdtsvEDyFzt+MP4isXdQqZ8BwxQ6lQ3
	 QAykVCrsdUKw1rq9pO2bQdSKO/q1u6mlQHxVHQRjSziTApT6/aZ6Sz0rGXYuRFvvvwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dffkm91U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8756606A31E;
	Tue, 24 Nov 2026 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dffkm91U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF121F000C4;
	Tue, 24 Nov 2026 18:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795546021;
	bh=qm3hKmf/R0IakqyPcH/0Ia+Ukjs/ke23vwMPF/3cQLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dffkm91UY3bmZ5BDKKzj/434PGhm8nyyTdX8XnCGIfGn86dfXcK8mYs1MCMereCoG
	 QGezWwrt7TA5ApUUT8uHAq8A0VrjJ11kwe4NW6NgGkctlXNeR2jLzGfujK2rkIJDNk
	 ZkDDFkZZ2qJIpIi18oRVG5WxztkklW4lMUNo4TDzIBORNSULZAtzchXa96ntz2IVvw
	 6yM1daBrImRp+/I8NDk1dAQKC+IsVBQy1V8cU73AhTV9WIGgDB6T72VTcVzs06/1nh
	 UJrbRuiKGFMjf93GiQhV1dAYrOFUglqALlUi1cU1S51CEWXjZiX6SSnFi2VThCJxuO
	 79vqn4izUS1LA==
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
Subject: [PATCH v1 14/17] perf tests bench: Add smoke tests for perf bench
Date: Tue, 24 Nov 2026 15:46:01 -0300
Message-ID: <20261124184604.24983-15-acme@kernel.org>
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

Run the numa, sched, futex, epoll, syscall, mem, internals, breakpoint
and uprobe benchmarks with small workloads, including the numa
convergence, perturbation and single node variants, and skip the ones
that need root or hardware that is not present.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/bench.sh | 130 ++++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)
 create mode 100755 tools/perf/tests/shell/bench.sh

diff --git a/tools/perf/tests/shell/bench.sh b/tools/perf/tests/shell/bench.sh
new file mode 100755
index 0000000000000000..7f5bca2c126a58aa
--- /dev/null
+++ b/tools/perf/tests/shell/bench.sh
@@ -0,0 +1,130 @@
+#!/bin/bash
+# perf bench tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+err=0
+out=$(mktemp /tmp/__perf_test_bench.out.XXXXX)
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
+# Some benchmarks need root, others only report that the hardware is
+# not there, so treat the environment as a skip and a missing result
+# as a failure.
+bench_skip_reasons="No hardware support|perf_event_open: Permission denied"
+
+run_bench() {
+	local name="$1" expect="$2"
+
+	shift 2
+	echo "Bench ${name}"
+	if ! perf bench "$@" > "${out}" 2>&1; then
+		if grep -qE "${bench_skip_reasons}" "${out}"; then
+			echo "Bench ${name} [Skipped: not supported here]"
+			return
+		fi
+		echo "Bench ${name} [Failed: perf bench failed]"
+		cat "${out}"
+		err=1
+		return
+	fi
+	# A benchmark can also decline to run and exit 0, printing that
+	# the hardware is not there, as the breakpoint ones do; that is a
+	# skip, not a success
+	if grep -qE "${bench_skip_reasons}" "${out}"; then
+		echo "Bench ${name} [Skipped: not supported here]"
+		return
+	fi
+	if ! grep -qE "${expect}" "${out}"; then
+		echo "Bench ${name} [Failed missing '${expect}']"
+		cat "${out}"
+		err=1
+		return
+	fi
+	echo "Bench ${name} [Success]"
+}
+
+run_bench numa/mem "GB/sec" numa mem -p 2 -t 2 -P 2 -T 1 -s 1 -l 1
+run_bench numa/mem/options "GB/sec" numa mem -p 1 -t 1 -P 2 -s 1 -l 1 -c -d -r -z -B -R -W
+run_bench numa/mem/init "GB/sec" numa mem -p 1 -t 1 -P 2 -s 1 -l 1 -I -H 1 -S -u 1 -B -r -z -Z
+if taskset -c 0 true > /dev/null 2>&1; then
+	run_bench numa/mem/bind "GB/sec" numa mem -p 2 -t 2 -P 2 -T 1 -s 1 -l 1 -C 0,1 -M 0,0
+else
+	echo "Bench numa/mem/bind [Skipped: cpu 0 not available]"
+fi
+run_bench numa/mem/convergence "GB/sec" numa mem -p 1 -t 1 -P 512 -l 1 -s 1 -c -m
+run_bench numa/mem/perturb "GB/sec" numa mem -p 1 -t 1 -P 512 -l 1 -s 1 -x 1 -S -d -d
+run_bench numa/mem/zero "GB/sec" numa mem -p 1 -t 2 -T 64 -l 1 -s 1 -C 0 -M 0 -B -Z -H -1
+run_bench sched/messaging "Total time" sched messaging -g 1 -l 10
+run_bench sched/pipe "ops/sec" sched pipe -l 1000
+run_bench sched/seccomp-notify "ops/sec" sched seccomp-notify -l 10
+run_bench futex/hash "operations/sec" futex hash -t 2 -r 1 -s
+run_bench futex/wake "Wokeup" futex wake -t 2
+run_bench futex/wake-parallel "Avg per-thread latency" futex wake-parallel -t 2 -w 1
+run_bench futex/requeue "Requeued" futex requeue -t 2
+run_bench futex/lock-pi "operations/sec" futex lock-pi -t 2 -r 1
+run_bench epoll/wait "operations/sec" epoll wait -r 1 -t 2
+run_bench epoll/ctl "operations" epoll ctl -r 1 -t 2
+run_bench syscall/basic "ops/sec" syscall basic -l 100
+run_bench syscall/getpgid "ops/sec" syscall getpgid -l 100
+run_bench syscall/fork "ops/sec" syscall fork -l 10
+run_bench syscall/execve "ops/sec" syscall execve -l 10
+run_bench mem/memcpy "Copying" mem memcpy -s 4KB -l 1
+run_bench mem/memset "Copying" mem memset -s 4KB -l 1
+run_bench mem/mmap "Copying" mem mmap -s 4KB -l 1
+run_bench internals/synthesize "Average data synthesis took" internals synthesize -s -i 1
+run_bench internals/synthesize-mt "Average synthesis took" internals synthesize -t -m 1 -M 2 -I 1
+run_bench internals/kallsyms-parse "Average kallsyms__parse took" internals kallsyms-parse -i 1
+run_bench internals/inject-build-id "Average build-id injection took" internals inject-build-id -i 2 -m 2 -n 2
+run_bench internals/pmu-scan "Average PMU scanning took" internals pmu-scan -i 1
+run_bench breakpoint/thread "Created/joined" breakpoint thread -t 2 -b 2 -p 1
+run_bench breakpoint/enable "Enabled/disabled" breakpoint enable -p 1 -a 1
+run_bench uprobe/baseline "usecs/op" uprobe baseline -l 2
+
+if [ "$(id -u)" = 0 ]; then
+	run_bench internals/evlist-open-close "Number of events" internals evlist-open-close -i 2
+else
+	echo "Bench internals/evlist-open-close [Skipped: no root permission]"
+fi
+
+# The uprobe programs attach to usleep in libc, which needs BPF and,
+# on distributions using musl, is not available by that name.
+if perf version --build-options | grep -q 'bpf_skeletons: *\[ on' && [ "$(id -u)" = 0 ]; then
+	for mode in empty trace_printk empty_ret trace_printk_ret; do
+		echo "Bench uprobe/${mode}"
+		if ! perf bench uprobe "${mode}" -l 2 > "${out}" 2>&1; then
+			if grep -qE 'Failed to (attach bench uprobe|load and verify BPF skeleton)' "${out}"; then
+				echo "Bench uprobe/${mode} [Skipped: no uprobe support]"
+				continue
+			fi
+			echo "Bench uprobe/${mode} [Failed: perf bench failed]"
+			cat "${out}"
+			err=1
+			continue
+		fi
+		if ! grep -q "usecs/op" "${out}"; then
+			echo "Bench uprobe/${mode} [Failed missing result]"
+			cat "${out}"
+			err=1
+			continue
+		fi
+		echo "Bench uprobe/${mode} [Success]"
+	done
+else
+	echo "Bench uprobe [Skipped: needs root and BPF skeletons]"
+fi
+
+cleanup
+exit $err
-- 
2.56.0

