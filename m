Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6E63ACF13
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778745990; cv=none; b=FA3mvgMi+C9Fo/cNfvbYPXsRLl5H+GFX+1eMJjhl5mjA13V/r6XSGduuMznoTlwPlZtz5vHRviPUP6QliKN87medqIHVLCIG0jlxn3CkxBI9uqCcmPFbcvDYHQk6+5GBl4rHCAXy9bmzD0b4LskboeLJmR+5JaBDa8GuVpgR8Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778745990; c=relaxed/simple;
	bh=FZLRCCRAzg3lLLhG7rcSm0OsnuaxhO1P7+CQfJ5ZTdw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lkh0Qi84C8UIAbFZRxpNE7YZGunRRoWcLuMOr0n2C/FBHGmJ4VN3ZLSve8InTNtIcV2rQDInpICzifR8CdaVqIDbm934TypfqhQGwm8wCQjGqm4MqeGnuWGnD1SrmdKMPseJzUH2v2H1t1NBW4tmF+UzrkRhWmuX+S1sDCN5HuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wvs7NMYN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wvs7NMYN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128FAC2BCB7;
	Thu, 14 May 2026 08:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778745990;
	bh=FZLRCCRAzg3lLLhG7rcSm0OsnuaxhO1P7+CQfJ5ZTdw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Wvs7NMYNMirS62WqYfIP3XzUv78YuwmhsrWyPuI4+8k9z6RmPHDwyI0d3YxM+jS4n
	 6xY2sN7j4BOrOI2u12hg5ckKllDLjvaR+AHYcFijP7s8XggglloYQfhBIStNZZtOEq
	 xk+/ckO6ARvKC4q2LVTC5LViPjPNAoFbAgmerkiRF6sNwh4PFuKsYuwe9jno1XPm0X
	 EMFodTCxmlw8m5NELcjP79UwiLWBd/ExQlQIXpuqUrSvMJ4tG3vnh+aCJnkU0tMvrX
	 UOi8BQh7bomzu9T+bzGumMa3VXto3JmVwV4zwy1aPCPWHkVhL8T9GeYp3BKDwhB7mx
	 jIvcDZ6uE0OlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] perf script: Provide weak stubs for instruction
 decoding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Li Guan" <guanli.oerv@isrc.iscas.ac.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260513154851.1085334-4-guanli.oerv@isrc.iscas.ac.cn>
References: <20260513154851.1085334-4-guanli.oerv@isrc.iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 08:06:29 +0000
Message-Id: <20260514080630.128FAC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The weak stub for `dump_insn` returns `NULL`, causing undefined be=
havior and a potential segmentation fault when passed to `fprintf`.
- [Low] Architectural layering violation by placing utility function stubs =
in a specific subcommand module.
--

commit c0a4d858da63f7e967ef9c465327ead66a0bd83b
Author: Li Guan <guanli.oerv@isrc.iscas.ac.cn>

perf script: Provide weak stubs for instruction decoding

This commit provides global weak stubs for dump_insn and
arch_is_uncond_branch to resolve undefined reference linker errors
when cross-compiling perf for non-x86 architectures like ARM64 and
RISC-V.

> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index c8ac9f01a36bc..80a8f0e80b42d 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -4608,3 +4608,25 @@ int cmd_script(int argc, const char **argv)
>  out:
>  	return err;
>  }
> +
> +/*
> + * Provide weak stubs for architectures that have not yet implemented
> + * instruction decoding. This prevents linker errors (undefined
> + * references) on non-x86 architectures (like ARM64, RISC-V) when
> + * building perf script.
> + */

Since dump_insn and arch_is_uncond_branch are general utility functions
declared in tools/perf/util/dump-insn.h, is it appropriate to place their
weak fallback implementations in a specific subcommand file?

This creates a structural inversion where a general utility header relies
on a subcommand's compilation to satisfy linker requirements. Would it be
better to place these stubs in a dedicated utility file like
tools/perf/util/dump-insn.c to preserve module boundaries and allow future
reuse across other perf tools?

> +const char * __weak dump_insn(struct perf_insn *x __maybe_unused,
> +			      u64 ip __maybe_unused,
> +			      u8 *inbuf __maybe_unused,
> +			      int inlen __maybe_unused,
> +			      int *lenp __maybe_unused)
> +{
> +	return NULL;

Does returning a null pointer here cause a segmentation fault?

Looking at any_dump_insn(), if Capstone disassembly is not used or fails,
the result is unconditionally formatted using fprintf:

fprintf(fp, "%s", dump_insn(...));

Passing a null pointer to the %s format specifier is undefined behavior.
While some standard C libraries like glibc defensively print "(null)", other
implementations commonly used on ARM or embedded systems (such as musl or
bionic) will directly dereference the null pointer, crashing perf script.

Should this return a valid static string literal like "<bad>" instead,
which matches the failure behavior of the x86 implementation?

> +}
> +
> +int __weak arch_is_uncond_branch(const unsigned char *buf __maybe_unused,
> +				 size_t len __maybe_unused,
> +				 int x86_64 __maybe_unused)
> +{
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513154851.1085=
334-1-guanli.oerv@isrc.iscas.ac.cn?part=3D3
