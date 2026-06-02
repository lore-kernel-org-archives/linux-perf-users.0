Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B70377ED9
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780418691; cv=none; b=SFf5ZrSUCPWSiIWwb7WUOorUG6uStisQSDXAlJpvs41Si0ZVk081bUXFNJp0nlkJRpGkBgTX+rjmj3riSaQnJnGCL6hAwOYNogWK9ss3Twbo04HBoOShnVC1KyDhnonIN5A98ONRQXXCv9dLDu5+aobh6uVN66BTlEoi5wdurI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780418691; c=relaxed/simple;
	bh=6ojBTpLr90WDV5tDNISiPMPTWSaMptqdckASTie4NvM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WcYY69heFFwZ84hRYgGDLhtOhbISphW8tKogMN4b8cfWixX71bTCEbjbVZyVXdTF7jBRhlAx+nMKbL/ZInEiX86DEVNKUI2lgDjjncUGTvXJh5+N4duQBuD/T30+5KnKp1UQVk+Y67oUwRbVWANG1u/dTeOXBI0EPYrsksED2rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1gVjPE6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1gVjPE6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7031F00893;
	Tue,  2 Jun 2026 16:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780418690;
	bh=yTRBh5Af/Y2LDJ+UrxwNuZbmMLa//zLive0RFzptY5A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H1gVjPE6ihdjajVvjIuOT51JEj6e3J5YVI5oCYc2/qKmeNuUWFfPElnpo9RDKiDn1
	 xwxWf4imt0bCM+HMyAudR/a+DjfQdeQOnTZkOSkJLaRJN/haRJqflzgZ+MoeBgfEQj
	 CcZOhurhDBhTzH27tYTMlZgSq5DP/lu8/NHsP0ViAOtfzwi+PUhrk3pZweGDA9jhAI
	 do6ZE4JClAqQw7g8Td/dq6GYCOLkN6IECSeOTvoWCAdE4V4x6Bbiw2/883BhIwV9Ax
	 IzrMxlsrN1YBbJhZw0KCELge51obiMYg95DV7Z77o5Y/jbtkhi9qprMEVIpOxokx7L
	 7jCzulSiLoDFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 7/7] perf/x86/intel/uncore: Implement global init
 callback for GNR uncore
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602144908.263680-8-zide.chen@intel.com>
References: <20260602144908.263680-8-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 16:44:49 +0000
Message-Id: <20260602164450.3A7031F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Hardware trust boundary violation: A spoofed PCIe device can s=
upply an arbitrary `global.ctl` value, leading to arbitrary MSR writes.
- [Medium] The newly added `uncore_msr_global_init()` uses the unchecked `w=
rmsrq_on_cpu()` function to write to an MSR address obtained from the hardw=
are discovery table.
--

commit b0a74f9b5d22ecfcf334d277878f153181fb3107
Author: Zide Chen <zide.chen@intel.com>

perf/x86/intel/uncore: Implement global init callback for GNR uncore

On Sierra Forest and Clearwater Forest, the FRZ_ALL bit in the global
control register defaults to 0 at boot, but UBOX PMON units do not
work until the global control register is explicitly written with 0
to trigger hardware initialization properly.

> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncor=
e.c
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
[ ... ]
> @@ -1731,6 +1731,16 @@ static int uncore_mmio_global_init(u64 ctl)
>  	return 0;
>  }
> =20
> +static int uncore_msr_global_init(int die, u64 msr)
> +{
> +	int cpu =3D uncore_die_to_cpu(die);
> +
> +	if (cpu =3D=3D -1)
> +		return -ENODEV;
> +
> +	return wrmsrq_on_cpu(cpu, msr, 0);

[Severity: Medium]
Since the msr parameter is derived from global.ctl which is read from
the hardware discovery table, could an incorrect value from firmware trigger
an unchecked MSR access warning?  Would it be better to use
wrmsrq_safe_on_cpu() here to prevent scary traces if the hardware table
is invalid?

> +}
> +
>  static const struct uncore_plat_init nhm_uncore_init __initconst =3D {
[ ... ]
> diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/i=
ntel/uncore_discovery.c
> --- a/arch/x86/events/intel/uncore_discovery.c
> +++ b/arch/x86/events/intel/uncore_discovery.c
[ ... ]
> @@ -287,7 +287,7 @@ static int __parse_discovery_table(struct uncore_disc=
overy_domain *domain,
>  	if (!io_addr)
>  		return -ENOMEM;
> =20
> -	if (domain->global_init && domain->global_init(global.ctl)) {
> +	if (domain->global_init && domain->global_init(die, global.ctl)) {

[Severity: Critical]
Does this allow an external device to write 0 to arbitrary MSRs?

The uncore discovery code scans the PCI bus for devices matching the Intel
Vendor ID and discovery Device ID without restricting the search to internal
CPU buses.  If a malicious external PCIe device (e.g., via Thunderbolt)
spoofs these IDs, it can provide a fake discovery table.

Could this attacker-controlled global.ctl value then be passed to
uncore_msr_global_init() and used as the msr index, allowing an attacker
to overwrite security-sensitive MSRs like MSR_LSTAR or MSR_GS_BASE with 0?

>  		ret =3D -ENODEV;
>  		goto out;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602144908.2636=
80-1-zide.chen@intel.com?part=3D7
