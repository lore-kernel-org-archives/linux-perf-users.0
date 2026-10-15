Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D0B42125A
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 06:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792045493; cv=none; b=isnHlthHNcneEwu4IYPuBdHnn/cy/QE86I8UGbfsoENsbRdYAedkJcMup1DQAphlM/g9rFgGP6roTRsEsSylFTpcoIuWIJF48qDIjdTYUv4uKUjX2INsbs1dUC3M0WNwStuQEK5UYZkKv6WbTL2MI9Rxxd4V1Pq6VdblADf1Kck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792045493; c=relaxed/simple;
	bh=RsOwDB2StIwlvsrNY8OiuDGwMI+kd++Y8EDfMa1m3EI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=anHps/jOmNkLRlXnaQLqbR/A5aBm8hrP08V+vLmRNBbptTLkOMgdx4rxPyzFTw51BZQ/A8NZuKztiDE8+qQbIuTep4sjOgUbNTXvtmwXXA/7mA5KxuZSoVISDYCgdFnmvOCpQvcrASUqzH3r0bSYGdFBeAjX/ZZ0TXokDNc1j40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6H3oGmn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6H3oGmn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BA01F000C4;
	Thu, 15 Oct 2026 06:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792045491;
	bh=7nBeDxRoG77uhs3ZjFwAiaqvkof8jJv0wDWgiCiNsPU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N6H3oGmnIpYLWzCVIOXNykVxrWb1TkAFsBCBGGaPCXfKQIrKB5od4aO4yOQ6gbefk
	 GRkp69cca+dHYgyNpr5DIItkf7SrVF/8kBjE6h0c3JHhe5Bng+07HrDBsYoeYAsNrJ
	 7kzCNfEIKiuqoonrSFzLz5hnOShCkRwlqzkR8oRes+4QNVS9H3A/CQyynsmasuaOF9
	 ylZp4cdqU2OXYejJW/SmX0JAwO0dAnSSt9cD/WoSoXEQckM6Vzxwhvw/qRVwD1D21z
	 o68bcxmlG0pDCE7pmg3443jf/GfhyFOhltHjOLjM4lV/GfCNLFLSAQWgqT8H52pODM
	 TpzkXe3Mw9Giw==
Message-ID: <sashiko-outbox-172339@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] perf/amd/ibs: Simplify event state handling with
 IBS_CAPS_DIS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ravi Bangoria" <ravi.bangoria@amd.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261015060430.5877-4-ravi.bangoria@amd.com>
References: <20261015060430.5877-1-ravi.bangoria@amd.com>
 <20261015060430.5877-4-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 06:24:51 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf/amd/ibs: Unhandled NMI panic due to 50us timeout
--

commit be4cf40ba3750348ffc77933b0cfe40c48e335e7
Author: Ravi Bangoria <ravi.bangoria@amd.com>
Subject: perf/amd/ibs: Simplify event state handling with IBS_CAPS_DIS

This commit simplifies event state handling on systems supporting
IBS_CAPS_DIS. It introduces a separate stop path that preserves the
Val bit while disabling the event to catch delayed NMIs.

Link: https://lore.kernel.org/r/20261007234815.4026028-1-jmattson@google.com

> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c

[ ... ]

> @@ -575,23 +583,87 @@ static void perf_ibs_start(struct perf_event *event=
, int flags)

[ ... ]

> +	if (ibs_caps & IBS_CAPS_DIS) {
> +		/*
> +		 *      IBS HW                     SW
> +		 *
> +		 *  o Capture sample       o ->stop()
> +		 *  o Set VAL bit            CTL2[Dis] =3D 1
> +		 *  o Raise NMI --.        o ...
> +		 *                 \       o ->start()
> +		 *                  \        wrmsr(IBS_{FETCH|OP}_CTL, new value);
> +		 *                   \       (wrmsr clears the VAL bit)
> +		 *                    `--> o Receives delayed NMI
> +		 *                           (Unknown NMI since VAL bit is cleared)
> +		 *
> +		 * Handle this with induced delay.
> +		 */
> +		rdmsrq(hwc->config_base, ctl);
> +		while ((ctl & perf_ibs->valid_mask) && delay--) {
> +			udelay(1);
> +			rdmsrq(hwc->config_base, ctl);
> +		}

[Severity: High]
What happens if the delayed NMI takes longer than 50us to arrive, for
example due to hypervisor scheduling, nested virtualization, or SMIs?

If this delay loop expires, the code proceeds to call
perf_ibs_enable_event() which clears the VAL and CTL2[Dis] bits. When the
delayed NMI eventually arrives, it appears it will be treated as an
unhandled NMI.

[ ... ]

> @@ -1419,19 +1494,43 @@ static int perf_ibs_handle_irq(struct perf_ibs *p=
erf_ibs, struct pt_regs *iregs)

[ ... ]

> +	} else {
> +		if (!test_bit(IBS_STARTED, pcpu->state)) {
> +fail:
> +			/*
> +			 * Catch spurious interrupts after stopping IBS: After
> +			 * disabling IBS there could be still incoming NMIs
> +			 * with samples that even have the valid bit cleared.
> +			 * Mark all this NMIs as handled.
> +			 */
> +			if (test_and_clear_bit(IBS_STOPPED, pcpu->state))
> +				return 1;
> =20
> -		return 0;
> +			return 0;
> +		}
> +	}

[Severity: High]
If the NMI is delayed past the 50us timeout in perf_ibs_start(), won't
perf_ibs_handle_irq() return 0 here?

Since IBS_STOPPED is intentionally not set for systems with IBS_CAPS_DIS,
when the delayed NMI arrives, CTL2[Dis] =3D=3D 0 and VAL =3D=3D 0. If the c=
ode
jumps to the 'fail' label due to the cleared VAL bit, IBS_STOPPED will be
clear, causing it to return 0.

Could this result in an unhandled NMI and a subsequent kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015060430.5877=
-1-ravi.bangoria@amd.com?part=3D3
