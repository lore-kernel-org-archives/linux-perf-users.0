Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1519656E077
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 19:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790192742; cv=none; b=D/MDfAPqRULsuP4YDA1j6Bhh/sLHlIxcU845Q0145AJVQxUkYGBLj0z08qUtRkdx5Wf8ybOEffoZ0w6m0wIndVu4hAcDQeHTX31LxAB/gEJ3G8enIWEktYv2d+V58cFYb4j0OFYnFzZ2nmgIfl0H96O5vJ6DXVNzTpJlskkYl30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790192742; c=relaxed/simple;
	bh=aQFK1KH6zhgq7yXnFqGzzNrOCuS1v937rbVKSmoRR1U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qwf5Idvlpy7azlewNeR45Fq5hmPVyjKrFASsFMpwC5Y3LcztSIXL5hp/X+WbXL/YTZ62Tvd3tvwmzmbPYewZSzQBIMw7oawWWHHvfXhZ672PKlEmwbYMiMjS0B/GtCoSn9tZz8DlmwiW/4lirSEMsuHCnnixu4KigWDAzTg+0Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpXoe5NO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpXoe5NO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89B71F000FF;
	Wed, 23 Sep 2026 19:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790192735;
	bh=tg1IZXGQotvv+M320kyHii2IHxkfwASlCSpbnez+E0A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GpXoe5NOI0Aw3R87HPKagsIdpIVKXScT6Dc6u+42p4EYO2V8pEdLgP3URa3YnxZLc
	 +7hLejDmGTxkeVifnZGglUO2UfeaZ2nDZpaaG/reR8CJJTbyBG5ydoeoAHXnvqX6XK
	 AyP/OHWX93wJgZSaoK11n3QVR24TT+WL0ABCNVdxsxqfpDaHQKf0BJspgHX7jvUyv6
	 fIazVBDXVadAsyezcvQrmOQ1zS+8kEAOIgcU8KmfhzvgRfS/0Q2ZIBGW4vYAuyU01x
	 M2ZFtbLdSxn+tJA97qisn7M6Lti5wY+OuEm1o5BpNHla/zkQvi+P+wjLb4+zx4MU2Q
	 Z6b2oNktxGz0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf unwind-libdw: Fix reading the stack of a 32-bit
 task
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stian Halseth" <stian@itx.no>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923193432.2489729-1-stian@itx.no>
References: <20260923193432.2489729-1-stian@itx.no>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 19:45:34 +0000
Message-Id: <20260923194534.C89B71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf: incorrect data extraction for unaligned stack reads during cr=
oss-endian unwinding
--

commit c969a9ae6966b9f317efd438b881a5fa16635c84
Author: Stian Halseth <stian@itx.no>

perf unwind-libdw: Fix reading the stack of a 32-bit task

This commit fixes reading the stack of a 32-bit task during unwinding on
big-endian machines by reading 4 bytes instead of 8, preventing traps. It
also corrects word ordering for cross-endian unwinding.

> diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libd=
w.c
> index 4ccfcc7c2dfca..d49901b1571e9 100644
> --- a/tools/perf/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw.c
[ ... ]
> +/*
> + * libdw expects a 32-bit task's words zero-extended.  A recording of the
> + * other byte order was swapped in 8-byte units when it was read (see
> + * perf_event__all64_swap()), so a 4-byte word is picked out of its unit=
 with
> + * that swap undone, as for PERF_SAMPLE_CPU in __evsel__parse_sample().
> + */
> +static Dwarf_Word stack_word(struct stack_dump *stack, int offset, size_=
t len,
> +			     bool swapped)
> +{
> +	union u64_swap u;
> +
> +	if (len =3D=3D sizeof(u64))
> +		return *(Dwarf_Word *)&stack->data[offset];
> +	if (!swapped)
> +		return *(u32 *)&stack->data[offset];
> +
> +	u.val64 =3D bswap_64(*(u64 *)&stack->data[offset & ~7]);

[Severity: Low]
Does this bitwise logic truncate the offset to a 4-byte boundary?

If a DWARF CFI expression requests a stack read at an unaligned address
during cross-endian unwinding, the calculation discards the unaligned bits.

While register unwinding typically targets 4-byte aligned addresses on
32-bit architectures, could a malformed or custom ELF with non-standard
CFI trigger an unaligned read? If so, would this extract the wrong bytes
instead of the requested data, potentially corrupting the unwind results?

> +	return bswap_32(u.val32[(offset & 4) / 4]);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923193432.2489=
729-1-stian@itx.no?part=3D1
