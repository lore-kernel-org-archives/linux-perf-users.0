Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C29B4CA780
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789498399; cv=none; b=mtS6aEZkC79x03QpOg2KroIa9C469PkPuZi1CwlV2JFbH7m/wxypQBY4NiJVQ8okz8tAdt15+XwIv34PWd5pL2sF7cNHWD9AOhZSmH7F/MehYG1UR686ty2kCAK1AY8l29YOzixANxdfVGi9vZr+FJe706vRXnrdUchtPMV8GDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789498399; c=relaxed/simple;
	bh=1oNXim9qkJ31rS8Z9hnMZcKukQ1pTE/vQzr9bwYAKug=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K4FJAXBYAF95r9zVQBIxv7UTlktJQVq6zDUALLlT2LO8G3CZS4Uj6AZ3vE+wgbLE6tfet+A8CaIRQc7zM/WERm1w3LTR/tHlinTWxRqe8GQfcszI8QYDeg4GiBP0W+3io0PXc5j/F4AemoU9lG4SDlmpcvePhzz6O7JndjyRPZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fh6Fn89a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fh6Fn89a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0573C1F00893;
	Tue, 15 Sep 2026 18:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789498398;
	bh=mMuspHuzZH5XDRaS8dzIGEmXWOQr6fwgMg6KG26r3ps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fh6Fn89aqCfWjx7OL9lCYp/wI+REVMYkAzywRyxPL75Xw0iNfT14YjhADd3LFhp0W
	 RL9RV73Q4HSxQkCt/aQZyJX60j6K9/X+rGpV7Y9xcwIeRrIPaUy2ca0meBnxrvwz1U
	 OSyfR2GFgQJZHlBRh/GYi3unNFlVAtqfmDx8oXgJ++IpYQo554/9tjwBsg5eWOQ5Rp
	 V2w1kaM07vh3CXC59KpEnmLpexY/6evxlVqzPiFEdk6AERbOwugGepN/ug1PVboNee
	 CkE2fiB7FPuLHLV+6QSee1Nbl7SaSW3IK4GdwA3xSZlGpPBBGXtWRBLwk5GN/47+sc
	 7THPyroI3dKpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] perf symbols: Fix broken ELF_C_READ_MMAP fallback
 guard
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260915-perf-symbol-memory-send-v1-1-1d3360e21f07@uber.com>
References: <20260915-perf-symbol-memory-send-v1-0-1d3360e21f07@uber.com>
 <20260915-perf-symbol-memory-send-v1-1-1d3360e21f07@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 18:53:16 +0000
Message-Id: <20260915185318.0573C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf: build failure on systems lacking ELF_C_READ_MMAP enum
--

commit d38dd3de1c465f53af2cb4e7df04744c926b7ed6
Author: Alireza Haghdoost <haghdoost@uber.com>

perf symbols: Fix broken ELF_C_READ_MMAP fallback guard

This patch attempts to make perf mmap ELF files by unconditionally defining
PERF_ELF_C_READ_MMAP to ELF_C_READ_MMAP. It removes the previous guard
because ELF_C_READ_MMAP is an enum rather than a preprocessor macro.

> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -57,15 +57,8 @@ static inline bool is_livepatch_symbol(const char *str)
>  	return strstarts(str, KLP_SYM_PREFIX);
>  }
> =20
> -/*
> - * libelf 0.8.x and earlier do not support ELF_C_READ_MMAP;
> - * for newer versions we can use mmap to reduce memory usage:
> - */
> -#ifdef ELF_C_READ_MMAP
> -# define PERF_ELF_C_READ_MMAP ELF_C_READ_MMAP
> -#else
> -# define PERF_ELF_C_READ_MMAP ELF_C_READ
> -#endif
> +/* libelf falls back to internal reads when mmap fails (e.g. non-seekabl=
e fd). */
> +#define PERF_ELF_C_READ_MMAP ELF_C_READ_MMAP

[Severity: Low]
Will this cause compilation errors on systems where the libelf.h header lac=
ks
the ELF_C_READ_MMAP enum?

By unconditionally assigning PERF_ELF_C_READ_MMAP to ELF_C_READ_MMAP in
tools/perf/util/symbol.h, this bypasses build feature detection. On systems
with libelf implementations that do not provide ELF_C_READ_MMAP, such as
elftoolchain on FreeBSD and macOS, this triggers an undeclared identifier
compilation error.

The commit message notes that objtool uses an #ifndef guard which works fin=
e,
but since ELF_C_READ_MMAP is an enum in libelf, that #ifndef in objtool
silently evaluates to true and incorrectly downgrades all mmap reads to
standard reads instead of actually using mmap.

Could we restore a proper feature detection mechanism here rather than
relying on an unconditional definition?

> =20
>  #ifdef HAVE_LIBELF_SUPPORT
>  Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-perf-symbo=
l-memory-send-v1-0-1d3360e21f07@uber.com?part=3D1
