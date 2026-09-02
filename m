Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B15440DB45
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Sep 2026 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788340507; cv=none; b=uHUT0MmFM36IXZnhJRVexZB6sDIfnCmJtmJZWeE29IbC9Kr3w5OEJS7+Y4aZDiO3i4fzhDFq5Pgn9exZeaTLg/KFSNvZb9498ZFh5H3emPEJT4FbrsJokcmksXwB5oPE+xotlUWPyw3e4tKFdMT+V54eU6mx1WZWOquKAzm+KII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788340507; c=relaxed/simple;
	bh=A1jiuhNYfiQcj3YIgy0A1EBHOGYkDiZ9boghA8l8uuY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iJ3Z1b32kJuN13thyvHoxO0drGFq6XTiaWErzm1pBayqVILER7rj3JjAZnyn3MiUSPX/ppXbUXfR8hfJRrc1MqL0eGVD4l/C34a1qPinCHhqZV9A/fIBQOFQZ/Fxje8ZORBRC1eiIzf9YyMxVnrgeeZaTgQzSgv/mu+snoWDU2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erIT6C0T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erIT6C0T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B811F000E9;
	Wed,  2 Sep 2026 09:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788340505;
	bh=G8USjhkU74YrH0gH8Uk9vc4xP58hf+DSR6+yrnyaETs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=erIT6C0TVQs3Hdp+1ok905ftpioT4viFQdd65WctIb6Y68GfxjkSbcpfGyvyZIzar
	 WFhjgShmJSQ8yZtlw9pRLDR0vQZYNVx/ouWEFMX25C3b7lyJLXrV6XoW5Fz8lVhs4H
	 Uwbu1lXwGY29WLPpZv+Q0nLEvPIPbfBG3AWof9sYQmNhJdUrmv4S0iXnPzIKGdKf5w
	 rDGAuN7fxaW0NPEKRoUFgNZ2d37pRroSeRtFXmYdHsL39fdqcUh/eiuisVDuZKV9XU
	 RZzdliyH89aDG/DjcQQEqT/YA4neYiiYFK2kRrVgtJUlvmwexSkuSFJTSq5Wubvx1c
	 sxEmhsDwvUHCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/amd/ibs: add phy_addr_only software filter for
 ibs_op
Reply-To: sashiko-reviews@lists.linux.dev
To: "Huang Shijie" <huangsj@hygon.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260902085251.4046240-1-huangsj@hygon.cn>
References: <20260902085251.4046240-1-huangsj@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 09:15:05 +0000
Message-Id: <20260902091505.B1B811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds stack write to ibs_data.regs in perf_ibs_handle_irq =
when IBS_CAPS_OPDATA4 is present.
--

commit 5394e86487207a321dbcef29ca4cd958bfbe243c
Author: Huang Shijie <huangsj@hygon.cn>

perf/amd/ibs: add phy_addr_only software filter for ibs_op

This commit introduces an ibs_op/phy_addr_only filter to discard samples
without a valid physical address directly in the interrupt handler. This
avoids wasting CPU cycles and reduces noise when tracking a process's memory
footprint using perf record.

> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index 3531f9c23b8c9..754f6f10b1717 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
[ ... ]
> @@ -1479,6 +1490,16 @@ static int perf_ibs_handle_irq(struct perf_ibs *pe=
rf_ibs, struct pt_regs *iregs)
>  		}
>  	}
> =20
> +	if (perf_ibs_phy_addr_only_event(perf_ibs, event)) {
> +		union ibs_op_data3 op_data3;
> +
> +		op_data3.val =3D ibs_data.regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA3)];
> +		if (!op_data3.dc_phy_addr_valid) {
> +			throttle =3D perf_event_account_interrupt(event);
> +			goto out;
> +		}
> +	}
> +
>  	if (perf_ibs_fetch_lat_event(perf_ibs, event)) {
>  		union ibs_fetch_ctl fetch_ctl;
> =20

[Severity: High]
This isn't a bug introduced by this patch, but is there an out-of-bounds
write to the ibs_data.regs[] array further down in perf_ibs_handle_irq()?

The array is sized to MSR_AMD64_IBS_REG_COUNT_MAX, which is 8:

arch/x86/include/asm/msr-index.h:
#define MSR_AMD64_IBS_REG_COUNT_MAX 8

When reading MSRs, if the hardware supports both IBS_CAPS_BRNTRGT and
IBS_CAPS_OPDATA4, the code reads up to 7 MSRs into the buffer in a loop
and then continues:

arch/x86/events/amd/ibs.c:perf_ibs_handle_irq() {
    ...
		if (perf_ibs =3D=3D &perf_ibs_op) {
			if (ibs_caps & IBS_CAPS_BRNTRGT) {
				rdmsrq(MSR_AMD64_IBSBRTARGET, *buf++);
				br_target_idx =3D size;
				size++;
			}
			if (ibs_caps & IBS_CAPS_OPDATA4) {
				rdmsrq(MSR_AMD64_IBSOPDATA4, *buf++);
				size++;
			}
    ...

The rdmsrq() for IBS_CAPS_BRNTRGT writes into regs[7] and increments buf to
regs[8]. The rdmsrq() for IBS_CAPS_OPDATA4 then writes into regs[8], which =
is
past the end of the array.

Could this corrupt the kernel stack in NMI context when a user requests
PERF_SAMPLE_RAW?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902085251.4046=
240-1-huangsj@hygon.cn?part=3D1
