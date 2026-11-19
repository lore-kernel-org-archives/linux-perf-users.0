Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795091666;
	b=E5u9k8nO9Y8QanX63XZYkK/CPwic+jGW4/MX3oipiokgXxDQ/WuYUqehghVX4qsUg6DO
	 vFJFRI2k7cX4NhTQMCMGcmQ6V4IOwNzuyJCmksOSBXxVyWQBEuYdWmhBTJpU7osBJ8Q7c
	 ri5xdFa6XJAg0hSIgStP5YifsOS102noPPxjyHDNU4w7mTKxXKx2z04s5VG9qIBiKb8ML
	 xborYSMu1DrXEjsf8yPcJbi9OiFR+oUNO4GljbPuBU8hi1U3aJBJC0se6jgrePG3mMQnQ
	 tkvYeflgo+QH2qVAhgpC+cVh8B/fBSBHmr6kHuJHGnkmVTp5UGm/qlqKBHXuyQRqlEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795091666;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CWILZy6gDdiem30jdcBC1mwcOrKK3ipboWnqap4Kgsc=;
	b=0If5X5G0bgSyhi7982Er/h4nmtqU4kGekeLH/WBO8awBZ7jZJfV9pKmMotuv0Zp+XjFS
	 YoF3/EByglTi1Db/I9yEgCa9DjxBHUVXnlVlv3XpjLsrRJfHkjkR6leGyn1goy3woT1ns
	 gTIRabpdZg6MTrVwKDIx5lg+X6L6lfTUaxfks0sOalS7DXwvivUaB5Rm4MlvTIIzlvQbL
	 Uu/RbjI76QyQxWTJ4449RjzDcFih0TS9sk10w/1h/triio/dNyLsuL1vGm/yzZNFC/LyA
	 aOO38mpvhFwwzP0WjKXqERl8NUH3KArHNG/18iWgM2cNbUhIFMFo9n94p4sVFxTEkxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hAUaA4Q/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B03606A337
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 12:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hAUaA4Q/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37A31F000C4;
	Thu, 19 Nov 2026 12:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795091666;
	bh=CWILZy6gDdiem30jdcBC1mwcOrKK3ipboWnqap4Kgsc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hAUaA4Q/AU2nRP3JC9syiTniSDlLDx6F/zAvHE1ImiN+M68tKGqNwY1w6gLGNPXxB
	 iFsVBiRAIpwYJBqrA2frtzB59BCoDt0YSoXIBcTukvr1iZOxjvj/VB2VPpS9ef5ikA
	 dkgZNoZ+PYCrttOEJ0d6PxiznwHDuFeC6YMWGldZnWaBSn5CNSHMosh9oUTA4MsafS
	 UjdfdxWNfzb++UnjPCELv16VcHtNXmEC2W3WtdSwo+9/5SM+0OptfXU3gqGJpDGy2J
	 MvTA6cwucQRYtVBS9lJKALFfNUiwLrG+sXE52g3mARkT2L5nHy0bY2b3h62V5ACSsj
	 7AW2dthxf2Djw==
Message-ID: <sashiko-outbox-223093@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 11/11] selftests/riscv: add perf user-stack SSE copy
 regression test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119120824.13969-24-zhangzhanpeng.jasper@bytedance.com>
References: <20261119120824.13969-13-zhangzhanpeng.jasper@bytedance.com>
 <20261119120824.13969-24-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 12:34:25 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [Medium] selftests/riscv: perf_event_open() EINVAL fails instead of
  skipping
- [Medium] selftests/riscv: test_ustack_records_wellformed() accepts
  0-byte copy
- [Medium] selftests/riscv: burn_stack() overflows default musl pthread
  stack
- [Low] selftests/riscv: false skip on setup failure in
  test_sse_stress_no_crash()
- [Low] selftests/riscv: unused stress_thread fields and missing
  .gitignore entry
--

commit e1bf6fbd4261f2eb37c1aa64007c8a76c7256f6e
Author: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>

selftests/riscv: add perf user-stack SSE copy regression test

This commit adds a userspace kselftest under tools/testing/selftests/riscv/=
sse
to exercise PERF_SAMPLE_STACK_USER user-stack copying from RISC-V SBI
Supervisor Software Events (SSE) context across a guard-page boundary and
under multi-CPU stress.

> diff --git a/tools/testing/selftests/riscv/sse/sse_perf_ustack.c b/tools/=
testing/selftests/riscv/sse/sse_perf_ustack.c
> new file mode 100644
> index 0000000000000..9535b6d7ba4c1
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/sse/sse_perf_ustack.c
> @@ -0,0 +1,564 @@

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
Does perf_event_open() fail with EINVAL instead of skipping on RISC-V
systems without PMU overflow support?

When neither SBI SSE nor Sscofpmf IRQ overflow delivery is available,
pmu_sbi_device_probe() and riscv_pmu_legacy set both
PERF_PMU_CAP_NO_INTERRUPT and PERF_PMU_CAP_NO_EXCLUDE without registering a
riscv-pmu entry in /proc/interrupts.  Because sampling_attr() sets
exclude_kernel and exclude_hv, perf_try_init_event() rejects the event with
-EINVAL on PERF_PMU_CAP_NO_EXCLUDE before perf_event_open() reaches the
PERF_PMU_CAP_NO_INTERRUPT check that returns -EOPNOTSUPP, causing
test_ustack_records_wellformed() to report FAIL instead of SKIP.

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

> +					if (dyn_size > dump_size) {
> +						ok =3D false;
> +						break;
> +					}
> +					if (dyn_size < dump_size)
> +						truncated++;

[Severity: Medium]
Does test_ustack_records_wellformed() copy 0 bytes on every sample and count
dyn_size =3D=3D 0 as a valid guard-page truncation?

start_truncation_child() passes stack + page_size (immediately below the
PROT_NONE page) to clone(), and truncation_child() only allocates ready_fd
and ready before spinning, leaving sp within 16 to 48 bytes of the guard
page.  On RV64, __copy_from_user_inatomic() enters .Lword_copy in
arch/riscv/lib/uaccess.S and issues eight unrolled REG_L loads (64 bytes)
before storing anything or advancing the destination pointer, so the copy
faults during the first burst and returns a remaining count equal to
dump_size (dyn_size =3D=3D 0).  Since any sample with dyn_size < dump_size
increments truncated, the subtest passes without verifying that a non-zero
partial stack copy occurred across the boundary.

Giving truncation_child() a live stack frame larger than 64 bytes and
requiring 0 < dyn_size && dyn_size < dump_size would ensure a partial copy
is actually tested.

[ ... ]

> +struct stress_thread {
> +	pthread_t tid;
> +	int cpu;
> +	int *stop;
> +	int fd;
> +	void *rb;
> +	size_t rb_bytes;
> +};

[ ... ]

> +		st->fd =3D -1;
> +		st->cpu =3D cpu;
> +		st->stop =3D &stop;
> +		st->rb_bytes =3D rb_bytes;

[Severity: Low]
This isn't a bug, but stress_thread::cpu and stress_thread::rb_bytes are
written here and never read anywhere.  Also, tools/testing/selftests/riscv/=
sse
is missing a .gitignore entry for the new sse_perf_ustack binary added to
TEST_GEN_PROGS.

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
Can stress_worker() overflow the default pthread stack on musl libc?

burn_stack() is noinline and keeps unsigned long frame[32] (256 bytes on
64-bit RISC-V) live across RECURSE_DEPTH (512) recursive calls, consuming
about 145 KiB of stack.  Because thread_attr uses the default stack size
 without pthread_attr_setstacksize(), this exceeds musl's 128 KiB default
pthread stack and crashes the test with SIGSEGV.

[ ... ]

> +	if (started =3D=3D 0) {
> +		free(threads);
> +		if (why)
> +			ksft_test_result_skip("sse stress: %s\n", why);
> +		else
> +			ksft_test_result_skip("sse stress: could not start any sampler\n");
> +		return;
> +	}

[Severity: Low]
Should the else branch report a failure or error rather than
ksft_test_result_skip() when started =3D=3D 0 and why is NULL?

open_skip_reason() sets why when perf_event_open() fails due to missing
privileges or unavailable PMU support, so reaching started =3D=3D 0 with
why =3D=3D NULL means every sampler failed due to an unexpected
perf_event_open(), mmap(), or pthread creation error.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119120824.1396=
9-13-zhangzhanpeng.jasper@bytedance.com?part=3D11
