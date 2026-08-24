Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9D83EC804
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 08:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561910; cv=none; b=PnePWeKJG/ylSvOPEqi0hFptGaxC5FHxWf9kyOYQVD5UA3xNS9aiHbyTuqgin2u5FdGwViChKOIOxnFE5+RUyJK2kKlQFblHS6YCdMJT08FhmqcJ9NJQf9jxp4vlo1WN24a0VmcbjHFgknFmGFypXtafSpKclEMhAS7zoekmdUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561910; c=relaxed/simple;
	bh=fUd8kc6EA7LxslRoA8PQZhIWh8vb/SIgy1Cbvn7NCsM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nHQjrDlbii0zoTbzoASjWVASHX/qePnafY9rA7AMuX2uRa10yVLQPF1gC+MAkoMyiXaNXW/ONewylK6zTKX1Bcc8Pq6uuIOMl2repAaESpSG6KF60opM55AH0AmKbraewqTvKhXntTXodeyJb5ZVVg8pwdu/0V97mNsv4oQBR4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1Hbi2Cc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1Hbi2Cc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B8B1F000E9;
	Mon, 24 Aug 2026 08:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787561908;
	bh=saHHP0qr72Xaa5pFMo8XLD8gDBCb5363gKTyGevV13I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M1Hbi2CcXCR66YHo2kycx3bKYfPeRiwJJ0LRTFbDgBo1bZNPKhjeixNF2vB/grfm3
	 myHDBDC5FazxlvAAy4ia8iDp7sjS4flCE2riDe0pJL9AVdFcQ4lWoMEi8TBErrRixP
	 VZ3aVNc1dE3nFX1OcXcWqvQv0XDoRL0dm5TXe/5iQoZzR6GzKD3dBjEIqysoJEpXRy
	 QoaOtGkUfJ52Yvh4OsYDhjHdBnEG9O/QVwaUrCIUfyogGOo3/MWBmPYBOUq3AJ9Ysh
	 eI67h24G74rl6Jkm9/zN91kdivjDHnzy8pbiSseqRzSEmQHnvdbyPkAZhFGkrymyJs
	 EjbVrTlnOv2GQ==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND Patch v10 15/23] perf/x86: Support ZMM sampling using
 sample_simd_vec_reg_* fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824082731.1013973-16-dapeng1.mi@linux.intel.com>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
 <20260824082731.1013973-16-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 08:58:28 +0000
Message-Id: <20260824085828.79B8B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Relaxed vector mask validation allows users to request sampling =
of XMM16-31 and YMM16-31 registers, but the kernel silently outputs zeroes =
for them.
--

--- Patch [15]: [RESEND Patch v10 15/23] perf/x86: Support ZMM sampling usi=
ng sample_simd_vec_reg_* fields ---
commit 88766819a94c672c41219599404eada3a0d0fa19
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86: Support ZMM sampling using sample_simd_vec_reg_* fields

This patch adds support for sampling up to 32 ZMM registers via the
sample_simd_vec_reg_* fields. ZMM0-15 are assembled from XMM, YMMH,
and ZMMH components, while ZMM16-31 are extracted as a whole.

> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index 01de7799f907b..f59551200f18c 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
[ ... ]
> @@ -209,6 +209,60 @@ static inline bool event_needs_ymm(struct perf_event=
 *event)
[ ... ]
> +static inline bool __event_needs_high16_zmm(struct perf_event *event,
> +					    u64 sample_type)
> +{
> +	if (!event->attr.sample_simd_regs_enabled)
> +		return false;
> +	if (event->attr.sample_simd_vec_reg_qwords < PERF_X86_ZMM_QWORDS)
> +		return false;

[Severity: Medium]
Will this abort collection of high-register state for XMM16-31 or YMM16-31
requests?

When sample_simd_vec_reg_qwords is less than PERF_X86_ZMM_QWORDS (e.g., 2 f=
or
XMM or 4 for YMM), this returns false. Consequently, the hardware state for
the high 16 registers is not extracted.

> +
> +	if ((sample_type & PERF_SAMPLE_REGS_USER) &&
[ ... ]
> diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
> index 0076974498eee..93370d4657860 100644
> --- a/arch/x86/kernel/perf_regs.c
> +++ b/arch/x86/kernel/perf_regs.c
[ ... ]
> @@ -123,7 +136,8 @@ int perf_simd_reg_validate(u16 vec_qwords, u64 vec_ma=
sk,
> =20
>  	if (vec_qwords) {
>  		if (vec_qwords !=3D PERF_X86_XMM_QWORDS &&
> -		    vec_qwords !=3D PERF_X86_YMM_QWORDS)
> +		    vec_qwords !=3D PERF_X86_YMM_QWORDS &&
> +		    vec_qwords !=3D PERF_X86_ZMM_QWORDS)
>  			return -EINVAL;
>  		if (vec_mask & ~PERF_X86_SIMD_VEC_MASK)
>  			return -EINVAL;

[Severity: Medium]
Does this validation allow users to request sampling of XMM16-31 and YMM16-=
31
registers?

With PERF_X86_SIMD_VEC_MASK expanded to 32 bits, this check now allows bits
16-31 to be set in the user mask for XMM and YMM requests.

Because bitmap_full(&mask, PERF_X86_SIMD_XMM_REGS) only validates that the
first 16 bits are set and ignores the rest, it won't reject masks that incl=
ude
the upper 16 registers.

Combined with __event_needs_high16_zmm() returning false for non-ZMM reques=
ts,
does this mean the kernel will silently accept invalid UAPI configurations =
for
XMM16-31/YMM16-31 and return zeroes to userspace instead of actual data or =
an
error?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824082731.1013=
973-1-dapeng1.mi@linux.intel.com?part=3D15
