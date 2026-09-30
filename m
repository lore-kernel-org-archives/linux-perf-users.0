Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42188449987
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 06:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751008; cv=none; b=QPoJoaYfzR7pjW+5/wcR9OYiRTNTW3XIMS58hJtQAGAahCgw6sjOJG71w6K0TJmHwps5VqZ06od+eEgW/wIYXVEZGHO/H7q7yNZb1xAOepAUIt84JLws/o7MDTz7hjVR6ox0DYYbvckpFz+OhpPtVDIapwxtDqC2X98QTcPEcUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751008; c=relaxed/simple;
	bh=bl3tBrHIFLqIWZSa8xIS1bjE6qLRjsI5SdD9BFmC2fk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MClrm2YjyAfOTS+jjeqYcb3qgsukjgccHFDP6B3QSN6tY/BuEZF5ytaHlXfUqZdiIyI65bF0H6/aZMT7glyUHa+lqGNavP6LMDyWcxl8RenjeHwoQ5+oJmRzW5mbsNGUaXy8VFZ2DfQz4UZ8FnQwqyVfFqGX07dTtEOHD6Xe4zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kc/qU3sH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kc/qU3sH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23FD71F000FF;
	Wed, 30 Sep 2026 06:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790750997;
	bh=jhlQJfJ8Dz5EczELv6ePL4lfaQ0MZChPLY2M0ROi+vg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kc/qU3sH0/b5VimfGs/8olqB0lxtLkt4u3YIkNH5OwymT9eCap+QKTRzs+N3EUYAM
	 5o1Vdrjt1JczkQtPrObBPFco3UUrktS9rwHr6MFgw64LRBYFFAVTjmKM2UFwnG6KY1
	 0jVm6DfQsReKdnersMArF+RZSAfN7WufSmG7zrW9FFwNuPGFr7RwsUVYt4vB+O9tmC
	 b9FyV3aJ0sWHpCNXxwZF5E8H8n7Ld/kBCIQ1VbaGavCyZOz5GTTlcdTKIuaK9UOIgs
	 i6+jueurV/7hQOjhs+bOSqzXU5E5+wkhNjEw0kliWxaNZYEOzFTa5yzDDwam5KSyt/
	 HYFOUs3CeVOBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/8] riscv: Add breakpoint and watchpoint test for
 riscv
Reply-To: sashiko-reviews@lists.linux.dev
To: "Himanshu Chauhan" <himanshu.chauhan@oss.qualcomm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260930063919.608911-3-himanshu.chauhan@oss.qualcomm.com>
References: <20260930063919.608911-1-himanshu.chauhan@oss.qualcomm.com>
 <20260930063919.608911-3-himanshu.chauhan@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 06:49:56 +0000
Message-Id: <20260930064957.23FD71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] selftests/breakpoints: Makefile fails to match riscv64 native ar=
chitecture
- [Low] selftests/breakpoints: global CFLAGS +=3D -static affects other tes=
ts
- [Low] selftests/breakpoints: file descriptor leak in trigger_wp()
- [Low] selftests/breakpoints: shared variables lack volatile sig_atomic_t =
qualifier
--

commit d5a08206a858d8d5760badeff5fe2c51c8a98f2b
Author: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: riscv: Add breakpoint and watchpoint test for riscv

This commit adds a selftest for the RISC-V architecture using the ptrace
framework. It sets and unsets breakpoints and watchpoints, and uses signals=
=20
to verify the triggers.

> diff --git a/tools/testing/selftests/breakpoints/Makefile b/tools/testing=
/selftests/breakpoints/Makefile
> index 0b8f5acf7c78f..b32c56b3c1db2 100644
> --- a/tools/testing/selftests/breakpoints/Makefile
> +++ b/tools/testing/selftests/breakpoints/Makefile
> @@ -12,5 +12,10 @@ ifneq (,$(filter $(ARCH),aarch64 arm64))
>  TEST_GEN_PROGS +=3D breakpoint_test_arm64
>  endif
> =20
> +ifneq (,$(filter $(ARCH),riscv))

[Severity: Medium]
Will this test be silently skipped during a native build on a RISC-V machin=
e?

The native architecture reported by uname -m is "riscv64", but this filter
expects exactly "riscv". Since this leaf Makefile doesn't include the
kernel's subarch.include to normalize the architecture name, it looks like =
it
might fail to match the native architecture.

> +CFLAGS +=3D -static $(KHDR_INCLUDES)

[Severity: Low]
Does appending to the global CFLAGS here force other unrelated tests in this
directory to inadvertently build statically on RISC-V?

Using a target-specific flag just for breakpoint_test_riscv might prevent
impacting tests like step_after_suspend_test.

> +TEST_GEN_PROGS +=3D breakpoint_test_riscv
> +endif
> +
>  include ../lib.mk

[ ... ]

> diff --git a/tools/testing/selftests/breakpoints/breakpoint_test_riscv.c =
b/tools/testing/selftests/breakpoints/breakpoint_test_riscv.c
> new file mode 100644
> index 0000000000000..0649940b709e0
> --- /dev/null
> +++ b/tools/testing/selftests/breakpoints/breakpoint_test_riscv.c
> @@ -0,0 +1,219 @@

[ ... ]

> +#ifndef noinline
> +#define noinline __attribute__((noinline))
> +#endif
> +
> +static int gfd;
> +sem_t ib_mtx, wp_mtx;
> +static int bp_triggered, wp_triggered;

[Severity: Low]
Can the compiler optimize and incorrectly cache these variables since they
are modified asynchronously in a signal handler but lack the volatile
sig_atomic_t qualifiers?

They are incremented in sig_handler_bp() and sig_handler_wp(), so standard
POSIX signal safety might require the proper qualifiers to avoid potential
hangs or incorrect test failures.

> +static int test_func_sink;
> +static const int wait_timeout_sec =3D 5;

[ ... ]

> +static int trigger_wp(void)
> +{
> +	struct sigaction sa;
> +	unsigned long test_data;

[ ... ]

> +	if (gfd < 0) {
> +		printf("Failed to setup watchpoint\n");
> +		return -1;
> +	}
> +
> +	ioctl(gfd, PERF_EVENT_IOC_ENABLE, 0);
> +	test_data =3D 0xdeadbeef;
> +	ioctl(gfd, PERF_EVENT_IOC_DISABLE, 0);
> +
> +	return 0;
> +}

[Severity: Low]
Does this success path leak the file descriptor allocated by setup_bp()?

It looks like close(gfd) is correctly called on the success path in
trigger_bp(), but appears to be missing here before returning.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930063919.6089=
11-1-himanshu.chauhan@oss.qualcomm.com?part=3D2
