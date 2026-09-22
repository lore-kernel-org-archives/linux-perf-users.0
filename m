Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5911F5505D5
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790086708; cv=none; b=uH4Zyq46RLRA/iygROcuiGVZvsdnucAf80sT0GwdR5CM3Gmw7D5BStlK4hmC1PLUr0DXXrctvAHGiwYtf67c+Z13eN8TpAUyC+4xjWn4Lgi9NCpyZ9oC87Sa6pGuUzT8tKyK5k3GxGfL3dHb5U7Q4VGgY1v2BIdIBxpKCorzZ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790086708; c=relaxed/simple;
	bh=m8GORMNEaQpI1ukATgJIlsd0IsM+vNJeqIh5nlnr3mg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=srYp+KeEwQfISH6YRKkANk4h6qZHNBGoQlKvFngAltUS79ZoqsPpo98D50rxaIqNwDUM/G5ARZfUelHbTSSGc2IjhnLx5Rvv+ft5MR/vHA7+15ldxS2FQftME4uprvjXLgPqbdEGQx8iGHIRKm3t9CjNWhnpmlmeCX+p3QIYmh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCjOSUIj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCjOSUIj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3081F00898;
	Tue, 22 Sep 2026 14:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790086707;
	bh=TEKszRON7WJ7Vg3RSwP9sNyldQuuO6X/sD+lGrxYJ2c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NCjOSUIjPqufs9yTUM4Df8c6Dx6Z/ckTxtCbChV2FDp1Hvn/LXHcZ3xzYmRJ9aibk
	 i+MAladVzlXljlJdqJoOqsqTAiw3SEkAnjXebtLZrRZ+gVHTiNpDxC+JBM0EFfpz0I
	 3zGtc5/QzmngOUSNqszjtKh8puYFOs2r5KLVyXlPdWEYrIFBBh8HRZnKOzlfcGcjQd
	 Fxqs7t7IrwyD7mIiXi8WUq0KDICzZUcpBPzywDzompGgVhQVHNMNd/o4D/cWDaUtd/
	 YkhIYC0tmoNeHe28dD44ZrowF/DNNg1siVc4tqotBjcKBxJg7HfXz/8v3jIFKLQ7wu
	 ISHLyqrLiOZJQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/2] sparc64: Support PERF_SAMPLE_REGS_USER and
 PERF_SAMPLE_STACK_USER
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stian Halseth" <stian@itx.no>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260922135653.1622301-3-stian@itx.no>
References: <20260922135653.1622301-1-stian@itx.no>
 <20260922135653.1622301-3-stian@itx.no>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 14:18:26 +0000
Message-Id: <20260922141826.CC3081F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf: sparc64 user stack dumps read from unmapped biased pointer
- [Medium] perf: sparc64 truncates 64-bit kernel registers for 32-bit compa=
t tasks
--

commit 549c908d74e0e448486cd60566d4f3e6ff5d6f8e
Author: Stian Halseth <stian@itx.no>
sparc64: Support PERF_SAMPLE_REGS_USER and PERF_SAMPLE_STACK_USER

This commit adds support for PERF_SAMPLE_REGS_USER and PERF_SAMPLE_STACK_US=
ER
on sparc64. It selects HAVE_PERF_REGS and HAVE_PERF_USER_STACK_DUMP,
implements the perf_regs interface to expose registers mirroring pt_regs, a=
nd
provides perf_arch_prepare_ustack() to flush user register windows.

> diff --git a/arch/sparc/include/asm/perf_event.h b/arch/sparc/include/asm=
/perf_event.h
> index c2aec0c7f4f5e..03f1ab1618b95 100644
> --- a/arch/sparc/include/asm/perf_event.h
> +++ b/arch/sparc/include/asm/perf_event.h
[ ... ]
> @@ -25,6 +25,9 @@ do {							\
>  	(regs)->u_regs[UREG_I6] =3D _fp;			\
>  	(regs)->u_regs[UREG_I7] =3D _i7;			\
>  } while (0)
> +
> +void perf_arch_prepare_ustack(void);
> +#define perf_arch_prepare_ustack	perf_arch_prepare_ustack

[Severity: Medium]
Since HAVE_PERF_USER_STACK_DUMP is selected in Kconfig, shouldn't there also
be an override for perf_user_stack_pointer() here to account for STACK_BIAS
on 64-bit tasks?

When a user requests a perf record with user stack sampling
(--call-graph dwarf) on a 64-bit SPARC process, the generic perf core
attempts to copy memory from the address returned by
perf_user_stack_pointer(regs). On 64-bit SPARC, the stack pointer
register %o6 (UREG_FP) is biased by 2047 bytes.

Without overriding perf_user_stack_pointer() to add STACK_BIAS, the core
perf code will attempt to read memory starting 2047 bytes below the
valid stack. Does this cause the copy to fail immediately upon hitting
an unmapped guard page, resulting in an empty stack dump?

> diff --git a/arch/sparc/kernel/perf_regs.c b/arch/sparc/kernel/perf_regs.c
> new file mode 100644
> index 0000000000000..644a0a11cb907
> --- /dev/null
> +++ b/arch/sparc/kernel/perf_regs.c
> @@ -0,0 +1,65 @@
[ ... ]
> +u64 perf_reg_value(struct pt_regs *regs, int idx)
> +{
> +	u64 val;
> +
> +	switch (idx) {
[ ... ]
> +	case PERF_REG_SPARC_Y:
> +		return regs->y;
> +	default:
> +		WARN_ON_ONCE(1);
> +		return 0;
> +	}
> +
> +	if (test_thread_flag(TIF_32BIT))
> +		val =3D (u32)val;

[Severity: Medium]
Will this unconditionally truncate 64-bit kernel registers for 32-bit compat
tasks?

When profiling kernel state via PERF_SAMPLE_REGS_INTR, the interrupted
registers belong to the 64-bit kernel mode, even if the current task is a
32-bit compat task (for instance, when servicing a system call).

Should this truncation be conditional on user_mode(regs) to avoid destroying
kernel register samples and breaking unwinding and symbol resolution for
kernel execution?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922135653.1622=
301-1-stian@itx.no?part=3D2
