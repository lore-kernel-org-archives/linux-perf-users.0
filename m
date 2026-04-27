Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F51931194C
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Apr 2026 12:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777291951; cv=none; b=SivAbA48ylWGd3FMEMxeJh0t/btHDbZGykfFyzdQnT+oqCXb8e4HbSQxH3p4V9henMAv5vqP36UWI+EK+RaT1JgYCQMjRLvWxjz6gtDFH5ZhkkFMfseY8y9eJ1KSHAZMIZTZY6PDWgHfmEBWaXoC/d3Y6sTmoVihVlHGLtAmXYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777291951; c=relaxed/simple;
	bh=i1hQTRTdTNLXQv3Muh5jWPrnYpkoEXfNbXYNgjwXhrY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WrCyZYcAVfsiUPBj+Lq0/ujt5sD6REmy8nI08geqSXKwK17zYuH/+1EP+DfL3k9KE4KO617y01mxgtblGecxlh4SgVtp48GNgq9yVVKzj4/zvJyRbrXzKXxZdRc5ftKDjQ9c/40qkGhUZk9ayq95pyBLRgLBDl6LVVpL7qIpq/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEYAbB6r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEYAbB6r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7567C19425;
	Mon, 27 Apr 2026 12:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777291950;
	bh=i1hQTRTdTNLXQv3Muh5jWPrnYpkoEXfNbXYNgjwXhrY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=WEYAbB6rhGE2w0vd9HwT3jUhIS96kMIM28HTS9N58omxTadA1yNtVAh2V8BC11q1l
	 cEdy3xkj6G0+Z4TMqIPtbRkrSDUQD2Ifg1GpggJSiR4i54mtdar6RpAKNMHc3A80/E
	 2p8VE6JohHhGWFkPtublivZ5+Ts92pg5uTunUQysG6Som2/w5WRVUGyTqPxg6PDCrL
	 h+OEeUxEt1MYD21fGNP/T/WeRSBtrNtm/AtvAfWfI92BWUKUc088X+TPI6o/6EnYnF
	 Pp98uYTBZkizYplZgrWYM+XBoXobtDORbkYXAaxLOaLn+SIThjSdFo3YcLUf47Neq4
	 TOh/iTcITHD2w==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v3 4/4] perf/x86/intel: Consolidate MSR_IA32_PERF_CFG_C
 tracking
Reply-To: sashiko@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260427085513.3728672-5-dapeng1.mi@linux.intel.com>
References: <20260427085513.3728672-5-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Apr 2026 12:12:30 +0000
Message-Id: <20260427121230.C7567C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] intel_pmu_config_acr() clobbers upper Architectural PEBS configu=
ration bits in cfg_c_val and the PERF_CFG_C MSR.
--

commit 5ded8e15814c1efc4e7b5c766abdd782de4d360c
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/intel: Consolidate MSR_IA32_PERF_CFG_C tracking

This commit consolidates the tracking of the PERF_CFG_C MSR into a single
variable, cfg_c_val, to maintain a unified view of the MSR state for both
Auto Counter Reload (ACR) and Architectural PEBS configurations.

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
[ ... ]
> @@ -3169,10 +3169,10 @@ static void intel_pmu_config_acr(int idx, u64 mas=
k, u32 reload)
>  		wrmsrl(msr_b + msr_offset, mask);
>  		cpuc->acr_cfg_b[idx] =3D mask;
>  	}
> -	/* Only need to update the reload value when there is a valid config va=
lue. */
> -	if (mask && cpuc->acr_cfg_c[idx] !=3D reload) {
> +	/* Only update CFG_C reload when ACR is actively enabled (mask !=3D 0) =
*/
> +	if (mask && ((cpuc->cfg_c_val[idx] & ARCH_PEBS_RELOAD) !=3D reload)) {
>  		wrmsrl(msr_c + msr_offset, reload);
> -		cpuc->acr_cfg_c[idx] =3D reload;
> +		cpuc->cfg_c_val[idx] =3D reload;
>  	}
>  }

Can this assignment wipe out the upper Architectural PEBS configuration bit=
s?

Since reload is passed as a u32 and cfg_c_val is a 64-bit value, assigning=
=20
reload directly zero-extends the value. This will clear the upper 32 bits,=
=20
unintentionally removing any existing Architectural PEBS configurations=20
like ARCH_PEBS_EN from the software cache, and writing zeroes to the=20
upper bits of the physical MSR.

Although intel_pmu_enable_event_ext() recalculates the full MSR state short=
ly
after and detects the mismatch, resulting in a second wrmsrq() to restore t=
he
missing PEBS bits, this causes an inefficient double MSR write and seems to=
=20
defeat the goal of maintaining a consistent MSR view.

Would it be better to use a read-modify-write pattern here instead?=20
For example:

cpuc->cfg_c_val[idx] =3D (cpuc->cfg_c_val[idx] & ~ARCH_PEBS_RELOAD) | reloa=
d;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260427085513.3728=
672-1-dapeng1.mi@linux.intel.com?part=3D4
