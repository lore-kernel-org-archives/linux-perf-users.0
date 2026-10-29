Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793275526;
	b=GX4L4jXShOifk1Vmelkky3xdybRVHJL1aGl3b0xJtaqYqKKBr3H+kNLQnfwr3edUau5f
	 GMqmIb4p7YX6+rATP4VnqgR2JV1s3aT7h6QrWurLIsTZNvfvDpGSubTp+6aTC/axZ6en3
	 z87gBuSzABufS3qkgeyg6DrIABuNZYr1IkDTpfJ/PaRhTBw9GfRfWxnG14uScodo7Jeyf
	 ZAsBoyXZI4IpEdsJQswFCuLEyGUPP9VThUP4KhyP2IDOYqtiiyCiivarA9o/iTpT4+khB
	 azywE4WszZIvOd+RYgCA/4zd7F0i8bg+ypljMvIwPI0lgGnNrF+KtwhO5Wqc2lzLZOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793275526;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NYvErzRgCpRIiDseAVlafsnpqci4x6lFuGXb2amQsrQ=;
	b=r4n+xGfhr2cGuYj5gwz5evvaEWA9oV70IcBxWAQTPoJIkdGU1+Cq/asTsi6ISs+jh27G
	 hjKU+plEIoKZScyGNlXt4zEyvLqaFhC/5vbwk5FgAqGkYS+EIbdQRp2Xjjzftsyb/nb2N
	 F/JQxBvhqS2TwtsWd4p2t3o+pj6vCx4df2KWThwJnbzcXceDuazD79lEAQRg6SmSX6CpL
	 gUJdyhXwI95kvHfdYiNsWuD1l/BQhuDhIxFoNv7ib0ixxr0+czjxs4Bli0p62LSVxjoGu
	 VTlJj4E/wryNItAhJ6uVB2yS1TXdMbgzxNqOr5e7+1/ZI2VPWyvNS0Qz6j7+iVNYyVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aYKCpOLv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709C1606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aYKCpOLv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2506E1F01829;
	Thu, 29 Oct 2026 12:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793275526;
	bh=NYvErzRgCpRIiDseAVlafsnpqci4x6lFuGXb2amQsrQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aYKCpOLvEGu9yHgCxbtSum1o1ptFT2QzsnM98/iLw3E9rOtya5KJKu3UTXUb+93cd
	 N+z0KHPS653sBO1zv83DUMo4RqUxWVuOIoqaiolLUWUNZi1QAfVWK3DsziGyA49NEa
	 7H0T14l2wxfwSeW5P6MVVOQ65Mt5qvDNw1pBX/OZ+5Hyiy1H0ah2YFFn+zdlaOMb9o
	 UAXjSsB8VfSmLdh+PBtsIfkcOGfXgbcj13QI/EuKgprKv3S+9vPLK7g7+Xs/XN+211
	 ZaZkaq0mYa8Rea7y8QuRCNlo2DMHO88RcdsfpZfJd4fa/EeZCJ2phF7egRP1M8/T4Y
	 h6yR7MjLkdTpw==
Message-ID: <sashiko-outbox-189253@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 11/11] selftests/riscv: add perf user-stack SSE copy
 regression test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261029114953.27453-3-zhangzhanpeng.jasper@bytedance.com>
References: <20261029074853.35467-1-zhangzhanpeng.jasper@bytedance.com>
 <20261029114953.27453-3-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 12:05:25 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] selftests/riscv: sse_perf_ustack fails with EINVAL instead of sk=
ipping without PMU IRQ/SSE
- [Medium] selftests/riscv: stress_worker() overflows default pthread stack=
 on musl in burn_stack()
- [Medium] selftests/riscv: sse_perf_ustack accepts 0-byte ustack copy as t=
runcated
--

commit 5a3dc623890401f5832b1d92fb8db20380606649
Author: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>

selftests/riscv: add perf user-stack SSE copy regression test

This commit adds a RISC-V SSE selftest exercising PERF_SAMPLE_STACK_USER
raw user-stack copying under PMU overflow sampling. It checks page-boundary
truncation against a PROT_NONE guard page and runs a multi-CPU stress
workload combining unix sockets and deep stack recursion.

> diff --git a/tools/testing/selftests/riscv/sse/sse_perf_ustack.c b/tools/=
testing/selftests/riscv/sse/sse_perf_ustack.c
> new file mode 100644
> index 0000000000000..9535b6d7ba4c1
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/sse/sse_perf_ustack.c
[ ... ]
> +static struct perf_event_attr sampling_attr(unsigned long freq)
> +{
> +	struct perf_event_attr attr =3D {
> +		.type		=3D PERF_TYPE_HARDWARE,
> +		.size		=3D sizeof(attr),
> +		.config		=3D PERF_COUNT_HW_INSTRUCTIONS,
> +		.sample_type	=3D PERF_SAMPLE_STACK_USER,
> +		.sample_stack_user =3D STACK_DUMP_SIZE,
> +		.freq		=3D 1,
> +		.sample_freq	=3D freq,
> +		.disabled	=3D 1,
> +		.exclude_kernel	=3D 1,
> +		.exclude_hv	=3D 1,
> +	};
> +
> +	return attr;
> +}
> +
> +static bool open_skip_reason(int err, const char **why)
> +{
> +	switch (err) {
> +	case EACCES:
> +	case EPERM:
> +		*why =3D "insufficient privilege for PMU sampling (perf_event_paranoid=
)";
> +		return true;
> +	case ENOENT:
> +	case ENODEV:
> +	case EOPNOTSUPP:
> +		*why =3D "hardware PMU sampling event not available";
> +		return true;
> +	default:
> +		return false;
> +	}
> +}

[Severity: Medium]
When running on a RISC-V system where neither SBI SSE nor Sscofpmf IRQ
overflow delivery is supported, will test_ustack_records_wellformed() fail
with EINVAL instead of skipping?

In that configuration, no riscv-pmu interrupt is registered in
/proc/interrupts, so pmu_sse_route_testable() returns true, and
pmu_sbi_device_probe() sets both PERF_PMU_CAP_NO_INTERRUPT and
PERF_PMU_CAP_NO_EXCLUDE:

drivers/perf/riscv_pmu_sbi.c:pmu_sbi_device_probe() {
    ...
	ret =3D pmu_sbi_setup_irqs(pmu, pdev);
	if (ret < 0) {
		pr_info("Perf sampling/filtering is not supported as sscof extension is n=
ot available\n");
		pmu->pmu.capabilities |=3D PERF_PMU_CAP_NO_INTERRUPT;
		pmu->pmu.capabilities |=3D PERF_PMU_CAP_NO_EXCLUDE;
	}
    ...
}

Because sampling_attr() sets exclude_kernel and exclude_hv,
perf_event_open() -> perf_event_alloc() -> perf_init_event() ->
perf_try_init_event() rejects the event with -EINVAL before
perf_event_open() reaches the PERF_PMU_CAP_NO_INTERRUPT check that returns
-EOPNOTSUPP:

kernel/events/core.c:perf_try_init_event() {
    ...
	if (pmu->capabilities & PERF_PMU_CAP_NO_EXCLUDE &&
	    event_has_any_exclude_flag(event)) {
		ret =3D -EINVAL;
		goto err_destroy;
	}
    ...
}

Since open_skip_reason() does not match EINVAL, test_ustack_records_wellfor=
med()
calls ksft_test_result_fail() rather than ksft_test_result_skip().

[ ... ]
> +static int truncation_child(void *arg)
> +{
> +	int ready_fd =3D (intptr_t)arg;
> +	char ready =3D 1;
> +
> +	if (write(ready_fd, &ready, sizeof(ready)) !=3D 1)
> +		return 1;
> +
> +	for (;;)
> +		__asm__ __volatile__("" : : : "memory");
> +}
[ ... ]
> +static void test_ustack_records_wellformed(void)
> +{
[ ... ]
> +					if (dyn_size > dump_size) {
> +						ok =3D false;
> +						break;
> +					}
> +					if (dyn_size < dump_size)
> +						truncated++;
> +				}
> +			}

[Severity: Medium]
Can test_ustack_records_wellformed() pass when every sample copies 0 bytes
(dyn_size =3D=3D 0) instead of performing a partial copy up to the guard pa=
ge?

start_truncation_child() passes stack + page_size to clone(), where the page
at stack + page_size is mapped PROT_NONE. Inside truncation_child(), the
stack frame only holds ready_fd and ready before entering the spin loop,
leaving the user stack pointer within 16 to 48 bytes of the PROT_NONE page
boundary.

When perf_output_sample_ustack() copies the user stack via
__output_copy_user() -> riscv_perf_out_copy_user() ->
__copy_from_user_inatomic(), fallback_scalar_usercopy_sum_enabled() enters
.Lword_copy and issues 8 unrolled word loads (64 bytes on RV64) before
storing any bytes or advancing dst (a0):

arch/riscv/lib/uaccess.S:fallback_scalar_usercopy_sum_enabled() {
    ...
2:
	fixup REG_L   a4,        0(a1), 10f
	fixup REG_L   a5,    SZREG(a1), 10f
	fixup REG_L   a6,  2*SZREG(a1), 10f
	fixup REG_L   a7,  3*SZREG(a1), 10f
	fixup REG_L   t1,  4*SZREG(a1), 10f
	fixup REG_L   t2,  5*SZREG(a1), 10f
	fixup REG_L   t3,  6*SZREG(a1), 10f
	fixup REG_L   t4,  7*SZREG(a1), 10f
    ...
}

Because the stack pointer is closer than 64 bytes to the PROT_NONE page,
one of the initial loads faults and jumps to the fixup label before a0
advances, returning the full requested size as uncopied and producing
dyn_size =3D=3D 0.

Since test_ustack_records_wellformed() only checks dyn_size < dump_size,
dyn_size =3D=3D 0 increments truncated and passes the test without verifying
that a non-zero partial stack copy succeeded up to the guard page. Should
truncation_child() keep a live stack frame larger than 64 bytes and require
0 < dyn_size && dyn_size < dump_size?

[ ... ]
> +static void test_sse_stress_no_crash(void)
> +{
[ ... ]
> +		CPU_ZERO(&set);
> +		CPU_SET(cpu, &set);
> +		pthread_attr_init(&thread_attr);
> +		ret =3D pthread_attr_setaffinity_np(&thread_attr, sizeof(set), &set);
> +		if (!ret)
> +			ret =3D pthread_create(&st->tid, &thread_attr,
> +					     stress_worker, st);
> +		pthread_attr_destroy(&thread_attr);

[Severity: Medium]
Does stress_worker() overflow the default pthread stack on musl libc when
calling burn_stack(RECURSE_DEPTH, &sink)?

In burn_stack(), each of the 513 active frames (from RECURSE_DEPTH =3D 512
down to 0) allocates unsigned long frame[32] (256 bytes on RV64) plus
saved registers and keeps the frame live across the recursive call via
keep_alive(frame):

static noinline unsigned long burn_stack(int depth, unsigned long *sink)
{
	unsigned long frame[32];
	unsigned int i;

	for (i =3D 0; i < ARRAY_SIZE(frame); i++)
		frame[i] =3D (unsigned long)depth * i + *sink;

	if (depth > 0)
		frame[depth & 31] +=3D burn_stack(depth - 1, sink);

This consumes roughly 148 KiB of stack space, which exceeds musl libc's
default pthread stack size of 128 KiB unless pthread_attr_setstacksize() is
used to request a larger stack for thread_attr.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029074853.3546=
7-1-zhangzhanpeng.jasper@bytedance.com?part=3D11
