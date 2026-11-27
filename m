Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795743544;
	b=ShnwwGPFGno9T4aHkYSLUunXw69pzcai4CdAkNccY+BwvcrMa+/diya2K3ffb9t8GVek
	 HbIpPedY8yoi7wlu86JVbb9w57JyTKMJ/SmrjAQ41YE5B9GWoJ9ncytHfn4+KHUwtelJJ
	 Z9ZfYous+Ud4zwLN0JS7xnahbrfGdRIGgGYpWoERXSij+ngvSysPMV9Za4AQPmbnL3EXa
	 UjmFJgeFrntOR8tJC5WQLUcqyS5CdgI/mjBj8mbT8svVbxfp1CN3nvlmLOepxEMnV7sC9
	 edcR7UQzrzclVjq/zjcHhbflnbLPFZAqYvschYwLrJEbBjf+bI5gBl2V5sxxT9cHaLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795743544;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zNg6hmEPPDF4l3/AVrnA5RbSPnhIyY5DrKHYYpSSy6Y=;
	b=mueRBKKsRMpp8iT+DZckzYamyzRAAgEkXNpzlQTKilS1/LMypyaiV68zhMTgEL0KgZ11
	 s0YPf4jTPOSSuEqsuiD576EN+DI3aenDS+tlKBmg8c2006CaAnkKXG8xvRxyoWQ7OZ1hc
	 iKQ5eLSrnSFVKVijvAPkFQ/VMGA/tGjStcm0qVKqcUkipvsksKUVrq3Q4hLeI5iUs5vdQ
	 U4aPljbB7IMJ0KZ5nITJcQY72TFW6z5HPTjkW6pRW+pQ//qVOfZdjTBM4r6USfVKATTlE
	 UYWDUM6QfojFCOHXMmHNNSIN+0/BoNJ0ECA4WsixOIDp6LAJFYkYuo3RdsKI+xJWhxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dtFPVjLn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC92606A324
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 01:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dtFPVjLn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C00F1F00897;
	Fri, 27 Nov 2026 01:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795743543;
	bh=zNg6hmEPPDF4l3/AVrnA5RbSPnhIyY5DrKHYYpSSy6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dtFPVjLnAjqmhibvSMFt1YHKQuWkZL80TUkIDsoLBOy9AXLX+33m036MJchPHHWKc
	 fNQR3EZ/j5LxoI5TOH4gxNvYzGtkTaaEIH5DONp8czvtApsqvAWUHBnDeie6O+PtqF
	 hgN5FXOqsEPkj+3+or7uXx8gwGO01KRGhKqS/D0YNcHFKs2UPxk7hlrDJQAFkt2lF/
	 M9DuJJ3kvbquZKF4tz2S9IozQ4vH31BUNtlptwQMLE+yx/n5spK83oc/FPP+ZLCNxc
	 orqybOPe7aT8Og2Kj46+gxFIwC2nBrs5v0HfP0hRhhfYkf9KG3sg/lrv5w063N9XtV
	 Qub0kwHeZxxKw==
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
Subject: [PATCH v2 15/18] perf tests bench: Add smoke tests for perf bench
Date: Thu, 26 Nov 2026 22:37:58 -0300
Message-ID: <20261127013801.14841-16-acme@kernel.org>
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

Run the numa, sched, futex, epoll, syscall, mem, internals, breakpoint
and uprobe benchmarks with small workloads, including the numa
convergence, perturbation and single node variants, and skip the ones
that need root or hardware that is not present.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/bench.sh | 154 ++++++++++++++++++++++++++++++++
 1 file changed, 154 insertions(+)
 create mode 100755 tools/perf/tests/shell/bench.sh

diff --git a/tools/perf/tests/shell/bench.sh b/tools/perf/tests/shell/bench.sh
new file mode 100755
index 0000000000000000..2a9c402c99f24a34
--- /dev/null
+++ b/tools/perf/tests/shell/bench.sh
@@ -0,0 +1,154 @@
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
+bench_skip_reasons="No hardware support|perf_event_open: Permission denied|perf_event_open: No such file or directory|perf_event_open: Operation not supported|perf_event_open: No space left on device"
+
+# The NUMA benchmarks are compiled out without libnuma, and some pass
+# explicit CPU numbers that must be online and in the current cpuset.
+numa_ok=0
+if perf check feature -q libnuma; then
+	numa_ok=1
+fi
+cpu0_ok=0
+cpu1_ok=0
+if taskset -c 0 true > /dev/null 2>&1; then
+	cpu0_ok=1
+fi
+if taskset -c 1 true > /dev/null 2>&1; then
+	cpu1_ok=1
+fi
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
+if [ "${numa_ok}" -eq 1 ]; then
+	run_bench numa/mem "GB/sec" numa mem -p 2 -t 2 -P 2 -T 1 -s 1 -l 1
+	run_bench numa/mem/options "GB/sec" numa mem -p 1 -t 1 -P 2 -s 1 -l 1 -c -d -r -z -B -R -W
+	run_bench numa/mem/init "GB/sec" numa mem -p 1 -t 1 -P 2 -s 1 -l 1 -I -H 1 -S -u 1 -B -r -z -Z
+	if [ "${cpu0_ok}" -eq 1 ] && [ "${cpu1_ok}" -eq 1 ]; then
+		run_bench numa/mem/bind "GB/sec" numa mem -p 2 -t 2 -P 2 -T 1 -s 1 -l 1 -C 0,1 -M 0,0
+	else
+		echo "Bench numa/mem/bind [Skipped: cpu 0 and 1 not available]"
+	fi
+	run_bench numa/mem/convergence "GB/sec" numa mem -p 1 -t 1 -P 512 -l 1 -s 1 -c -m
+	run_bench numa/mem/perturb "GB/sec" numa mem -p 1 -t 1 -P 512 -l 1 -s 1 -x 1 -S -d -d
+	if [ "${cpu0_ok}" -eq 1 ]; then
+		run_bench numa/mem/zero "GB/sec" numa mem -p 1 -t 2 -T 64 -l 1 -s 1 -C 0 -M 0 -B -Z -H -1
+	else
+		echo "Bench numa/mem/zero [Skipped: cpu 0 not available]"
+	fi
+else
+	echo "Bench numa/mem [Skipped: no libnuma support]"
+fi
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
+			# bench_uprobe() returns 0 when the skeleton loads but the
+			# uprobe cannot be attached, so a missing result here is
+			# an unsupported environment, not a test failure.
+			echo "Bench uprobe/${mode} [Skipped: no result]"
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

