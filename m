Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795547009;
	b=eBqNUt0YYZKn2EGngfjdgTHYHxiKp03WhBUl//vkdg/CtFBtbZPePGvJ0hsaRhXpwNxT
	 wjdIoFKtrXu5jPcoS4ChU3RNL3eQOdRJNtk49aBrRvZD/gZkdD3AccTqEBZX8I4O/zqOS
	 jq45ZTcooWtDSGtw7RliKggHPBZiC0v8dUFgF489BS+g7Gm6iYYdbunAc37emRPFAQSfr
	 zovBa/GdPs/yOZ2Tja6yRxuCoG/2pO7Anapcl1fGBqMFMBMwBJNkRiTxaMJqeORFU2cFV
	 rtr587TAcKPTnZdZba+3n6aGZO+rjP054Dlsc9Aos1G/c5pgAEaJlCW/4kGNT3b2gew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795547009;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tFSKVc8/4/M9K434I9ZRzUXeWU6mUH3OwZ+EBedr3/U=;
	b=2LKuRR/lwZWrdOl04nd00/lHyGQi9YiBy8r7b7F6Akn/fub6Nc5qgtQmzal77STOgRfV
	 ZyO95bvpi0tM0ZojHqkw/Du4x/d4FjScPHzljVSyvNdlgNkUPUQaZ0mHHvvPb4hVfnr3w
	 l4vCQfn26V661rYKTtCBJcu2K+cLupN9MTVDHXrkvvABHmOQ/v7y74JPJyV60AGcilrwP
	 LpV8YJvtGTmBAskWEWAgqlN07s+7hP98XjHrbSjjeH/c8KnS51aY8AjGkazu9XyXU/Uwn
	 oebplX94wUGTCFOnQTDDefHw6FtcltzN1PYtY9xEU9jgX+HKqYg5t/Sch3JNQPwFogQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CDDfN+/t";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3B3606A31E
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 19:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CDDfN+/t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB121F000C0;
	Tue, 24 Nov 2026 19:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795547008;
	bh=tFSKVc8/4/M9K434I9ZRzUXeWU6mUH3OwZ+EBedr3/U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CDDfN+/tJfTGsY53YOo1V+QzpuO9pCc/NXc/GoHwDpn03BzN/mBuyYd3UBOpZHK+l
	 e0YuKrVVxA/rSsNQBckh/6cN47/jgHh2tDd1CQ+6ewjUiU/XHeuPHbGYBnbbCC52tj
	 6Tdl2txIwmonVHshpm/2NhuOd03Vm2yaAoou4t/UhXnRbPJnFPQJamjhyW3JADeUFI
	 65x2XyEbE4wN60mhtzhqLRs8OAGeisw8g1EyCuKOsvxU7Lgo3604Jq6OXkVTR2+HZQ
	 3EixhaXkX7IizZik7lqF4jk6RHNE8P4mDnrId+igwl7aSszBvNX8AqocYED25m31zB
	 QappbQXLJd1eQ==
Message-ID: <sashiko-outbox-231874@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 14/17] perf tests bench: Add smoke tests for perf
 bench
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261124184604.24983-15-acme@kernel.org>
References: <20261124184604.24983-1-acme@kernel.org>
 <20261124184604.24983-15-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 19:03:28 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Medium] perf tests bench: uprobe skip check unreachable when
  bench_uprobe() returns 0
- [Medium] perf tests bench: incomplete taskset CPU checks for
  numa/mem/bind and zero
- [Low] perf tests bench: missing libnuma feature check before numa/mem
  benchmarks
- [Low] perf tests bench: missing skip handling for unsupported hardware
  breakpoints
--

commit d897107fc32e43a1f8a01917f38114b9c2da689a
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tests bench: Add smoke tests for perf bench

This commit adds a shell smoke test that exercises the numa, sched,
futex, epoll, syscall, mem, internals, breakpoint, and uprobe benchmarks
in perf bench with small workloads.

> diff --git a/tools/perf/tests/shell/bench.sh b/tools/perf/tests/shell/ben=
ch.sh
> new file mode 100755
> index 0000000000000..7f5bca2c126a5
> --- /dev/null
> +++ b/tools/perf/tests/shell/bench.sh
> @@ -0,0 +1,130 @@

[ ... ]

> +# Some benchmarks need root, others only report that the hardware is
> +# not there, so treat the environment as a skip and a missing result
> +# as a failure.
> +bench_skip_reasons=3D"No hardware support|perf_event_open: Permission de=
nied"

[ ... ]

> +run_bench numa/mem "GB/sec" numa mem -p 2 -t 2 -P 2 -T 1 -s 1 -l 1
> +run_bench numa/mem/options "GB/sec" numa mem -p 1 -t 1 -P 2 -s 1 -l 1 -c=
 -d -r -z -B -R -W
> +run_bench numa/mem/init "GB/sec" numa mem -p 1 -t 1 -P 2 -s 1 -l 1 -I -H=
 1 -S -u 1 -B -r -z -Z

[Severity: Low]
Will the numa/mem subtests fail when perf is built without
HAVE_LIBNUMA_SUPPORT?  Without libnuma, the numa collection is omitted
from collections[] in tools/perf/builtin-bench.c, so perf bench numa mem
exits with status 1 ("Unknown collection: 'numa'").  Should these
subtests be guarded by checking whether libnuma support is compiled in?

> +if taskset -c 0 true > /dev/null 2>&1; then
> +	run_bench numa/mem/bind "GB/sec" numa mem -p 2 -t 2 -P 2 -T 1 -s 1 -l 1=
 -C 0,1 -M 0,0
> +else
> +	echo "Bench numa/mem/bind [Skipped: cpu 0 not available]"
> +fi
> +run_bench numa/mem/convergence "GB/sec" numa mem -p 1 -t 1 -P 512 -l 1 -=
s 1 -c -m
> +run_bench numa/mem/perturb "GB/sec" numa mem -p 1 -t 1 -P 512 -l 1 -s 1 =
-x 1 -S -d -d
> +run_bench numa/mem/zero "GB/sec" numa mem -p 1 -t 2 -T 64 -l 1 -s 1 -C 0=
 -M 0 -B -Z -H -1

[Severity: Medium]
Does the taskset check for numa/mem/bind verify both CPUs passed to
-C 0,1, and should numa/mem/zero also be guarded by a CPU 0 check?

In tools/perf/bench/numa.c, parse_setup_cpu_list() rejects CPU indices
that are offline or >=3D nr_cpus, and bind_to_cpumask() hits BUG_ON(ret) if
sched_setaffinity() fails.  Because the guard only tests taskset -c 0,
numa/mem/bind will fail on single-CPU systems or when CPU 1 is offline or
excluded by the current cpuset.  In addition, numa/mem/zero passes -C 0
outside the taskset -c 0 guard, so it will fail when CPU 0 is unavailable.

[ ... ]

> +run_bench breakpoint/thread "Created/joined" breakpoint thread -t 2 -b 2=
 -p 1
> +run_bench breakpoint/enable "Enabled/disabled" breakpoint enable -p 1 -a=
 1

[Severity: Low]
Will breakpoint/thread and breakpoint/enable fail instead of skipping on
systems without hardware watchpoints or with only one watchpoint slot?

In tools/perf/bench/breakpoint.c, bench_breakpoint_thread() and
bench_breakpoint_enable() only print "No hardware support" when
perf_event_open() fails with ENODEV, calling perror("perf_event_open")
and exiting with EXIT_FAILURE on other errors.  Kernels without
CONFIG_HAVE_HW_BREAKPOINT (such as s390x) fail with ENOENT, systems with
zero data watchpoint slots fail with EOPNOTSUPP, and passing -b 2 to
breakpoint/thread fails with ENOSPC on CPUs with only one data watchpoint
slot (such as PowerPC without CPU_FTR_DAWR1).  None of those messages
match bench_skip_reasons.

[ ... ]

> +# The uprobe programs attach to usleep in libc, which needs BPF and,
> +# on distributions using musl, is not available by that name.
> +if perf version --build-options | grep -q 'bpf_skeletons: *\[ on' && [ "=
$(id -u)" =3D 0 ]; then
> +	for mode in empty trace_printk empty_ret trace_printk_ret; do
> +		echo "Bench uprobe/${mode}"
> +		if ! perf bench uprobe "${mode}" -l 2 > "${out}" 2>&1; then
> +			if grep -qE 'Failed to (attach bench uprobe|load and verify BPF skele=
ton)' "${out}"; then
> +				echo "Bench uprobe/${mode} [Skipped: no uprobe support]"
> +				continue
> +			fi
> +			echo "Bench uprobe/${mode} [Failed: perf bench failed]"
> +			cat "${out}"
> +			err=3D1
> +			continue
> +		fi
> +		if ! grep -q "usecs/op" "${out}"; then
> +			echo "Bench uprobe/${mode} [Failed missing result]"
> +			cat "${out}"
> +			err=3D1
> +			continue
> +		fi
> +		echo "Bench uprobe/${mode} [Success]"
> +	done

[Severity: Medium]
Is the skip check for uprobe/${mode} reachable when
bench_uprobe__setup_bpf_skel() fails?

tools/perf/bench/uprobe.c:bench_uprobe() {
    ...
	if (bench !=3D BENCH_UPROBE__BASELINE && bench_uprobe__setup_bpf_skel(benc=
h) < 0)
		return 0;
    ...
}

When loading the BPF skeleton or attaching the uprobe to libc's usleep
fails (for example on musl systems or kernels without uprobe support),
bench_uprobe() still returns 0 without running the benchmark or printing
"usecs/op".  Because perf bench uprobe exits with 0, the script skips the
failure branch and fails at the grep -q "usecs/op" check instead of
skipping the subtest.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124184604.2498=
3-1-acme@kernel.org?part=3D14
