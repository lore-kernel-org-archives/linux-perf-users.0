Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793DDEEB3
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Sep 2026 05:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788415110; cv=none; b=n/ooejYFGxSkWc9SCKbF/82MlSzmjMIhUcGQSVnRAONkVwqkLp5VIJCJrpT1Gg2VEo8HK9K/bP7VTS6hNnuagd24kT2bq7FXU+hh61hsjuO5jBCKHNMtshd8bv8DiV13LzOjltranS2fxCkqUcq/gJAX+W6TiH1gJ65K4S1CUjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788415110; c=relaxed/simple;
	bh=Ucji+TVzTnROrtv6VzMNog7CIF/yIUaKmitYByOZw0U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gYxhjeMP/IxORuoD3VxC5uxClWQpnFfUgNUSRlMDyIB1JfqiBw3OtLp77KoE4pdu+t5wxFmSoSY5EnLJ0mXlT7GKZ8d8bYp80G+I8rv21mhgmvcj2Tdi/aheuTQwmweatmEiU2ki/i+fJJKSFjlC0PHdFBf4zR3ZLMz2iRwD/zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOJjKZdH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOJjKZdH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388C21F00A3A;
	Thu,  3 Sep 2026 05:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788415109;
	bh=ciPbbhXA+e14PU8NeEkVd6HxEma/ZMC9rnlzaSyMhGU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EOJjKZdHrww1OKZNyOztxdbeUfF6zDEwk+tGS1Itv+n3yiLxUdHIB0oxtw36W5O5E
	 WYJX8tcNohdYtbPrUP4Z6/AQJCfXQv4AMlhizQx3xuGjcf3hLI/oT3AfIgZMUfS/mZ
	 7jU0PasGU3FYq2h+PCE/eM32ZowULTX8btuAO0l0GwZe4iAUR685xTl9QtZGOGVQ0y
	 7vspdlq2ELbPaPllGw1Yep/mIxTa8Sj6EL3SsbNGd6R6MwDwvoCPAjYUwuqwKd6xLd
	 VJ1i4CCIi8xHclx/1pFM/BbFb8td3NkqiNg5KAQER9mqHDemTNC1cANrm7q7PQgF/y
	 3pEXYdGUZGKrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/amd/ibs: Report physical address for IBS fetch
 samples
Reply-To: sashiko-reviews@lists.linux.dev
To: "Huang Shijie" <huangsj@hygon.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260903054422.148739-1-huangsj@hygon.cn>
References: <20260903054422.148739-1-huangsj@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 05:58:28 +0000
Message-Id: <20260903055829.388C21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Kernel stack buffer overflow when reading MSR_AMD64_IBSOPDATA4.
--

commit 7872bc1d9818cf858d57204bd43f4a048e54da52
Author: Huang Shijie <huangsj@hygon.cn>

perf/amd/ibs: Report physical address for IBS fetch samples

The IBS Fetch sampling does not report the physical address of the
fetched instruction even when PERF_SAMPLE_PHYS_ADDR is requested,
while IBS Op sampling does. This patch reports physical address for
IBS fetch samples which can be used for profiling the running program.

> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index 3531f9c23b8c9..e5376ad5b2ecd 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
[ ... ]
> @@ -1555,6 +1575,8 @@ static int perf_ibs_handle_irq(struct perf_ibs *per=
f_ibs, struct pt_regs *iregs)
> =20
>  	if (perf_ibs =3D=3D &perf_ibs_op)
>  		perf_ibs_parse_ld_st_data(event->attr.sample_type, &ibs_data, &data);
> +	else
> +		perf_ibs_parse_fetch_data(event->attr.sample_type, &ibs_data, &data);

[Severity: High]
This is a pre-existing issue, but does reading MSR_AMD64_IBSOPDATA4 earlier
in perf_ibs_handle_irq() overflow ibs_data.regs[] when both IBS_CAPS_BRNTRGT
and IBS_CAPS_OPDATA4 are present?

The ibs_data.regs array has a fixed size of MSR_AMD64_IBS_REG_COUNT_MAX (8).
If a user requests PERF_SAMPLE_RAW on a CPU supporting both features (like
Zen 4), the interrupt handler reads 7 base registers, an 8th register for
IBSBRTARGET, and a 9th for IBSOPDATA4.

This writes the 9th MSR value into ibs_data.regs[8] on the kernel stack:

    if (ibs_caps & IBS_CAPS_OPDATA4) {
        rdmsrq(MSR_AMD64_IBSOPDATA4, *buf++);
        size++;
    }

Can this corrupt adjacent stack memory when buf advances out of bounds?

> =20
>  	/*
>  	 * rip recorded by IbsOpRip will not be consistent with rsp and rbp

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903054422.1487=
39-1-huangsj@hygon.cn?part=3D1
