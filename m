Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A9F40F72B
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 23:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762707; cv=none; b=XXDWEys2LptBhPWJfCSiHyJ6BXte3ZTAg5OjUk9yZlNhmcKT/9zx14wuEyCoT9yt6PKg9WkcpNtLpw8f8zq1TzVgx/MDTET4OQ0GWVnSa/c9dz4RXbB9JDUd2EFVQYrAgTvi8LO47XzKRnlB0Mm9tB1FFlElm3x/ikcH/4tk4E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762707; c=relaxed/simple;
	bh=wQPJyQoM6Y2JA3a5Ck1jFBRqhBXt4/LiwuVhDZQBc/4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bS+voGQZBs14bb50mbPVFZRLHk6bYq23TsaXSMk7JHAjiHAaNkkikJEPuQ5GGnoSBBPXUX0MWXd8apEJA9WBVOSfg2neIqz6Gj0du6FqOsiDs1hrAP8E2Pepgk2FSsZxaH5mIPohJTe/C49RCpOYGI3s606DTFVTJbLQaOzq8lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f795Fbsx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f795Fbsx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D5C1F000E9;
	Wed, 22 Jul 2026 23:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784762706;
	bh=DgAa1BOSVwdLJHYt+JzKYrXTu9uiH/uYyM+F86qwtYM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f795FbsxpOc23vW681CDuiy9JfkBWr0jm/MfX5RB7hUMhooS0G76/KT0mLWR/tAPJ
	 LMhghGDJFv9im3xPJReymniV4LVagRP276qIeBveCQig8h91jXSjux1zhgnJnCVltG
	 69tIpsivpGkmisI3Yo9ZAsY/qC9PBuzemCzsvN1VPaJ3SPmuqrFg8blJBU5QFNqfVt
	 jsb4RjkbhXP1BHp4jpT56Kkiu0+83uZWLE8uAp0r46gM0ncwz227uNSlmnOECb6pj2
	 1liIZSyLRAVlg+Ko2HK8A07JiWQhRdO8DCbeYgNFZJ5+d7LGtnKLm3pmc9QQf7JnTo
	 1btwHY+yX2ibg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 06/11] x86/hw_breakpoint: Add
 arch_reinstall_hw_breakpoint
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <178476141832.26117.3201454711538502687.stgit@devnote2>
References: <178476134787.26117.10094977293012760490.stgit@devnote2>
 <178476141832.26117.3201454711538502687.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 23:25:05 +0000
Message-Id: <20260722232506.10D5C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Spurious debug exceptions during reinstall of AMD range breakpoi=
nts due to incorrect hardware register update ordering.
--

--- Patch [6]: [PATCH v10 06/11] x86/hw_breakpoint: Add arch_reinstall_hw_b=
reakpoint ---
commit f97fcd502b5557f06d1cd0cadf2259bf2197dc51
Author: Jinchao Wang <wangjinchao600@gmail.com>

x86/hw_breakpoint: Add arch_reinstall_hw_breakpoint

The new arch_reinstall_hw_breakpoint() function can be used in an
atomic context, unlike the more expensive free and re-allocation path.
This allows callers to efficiently re-establish an existing breakpoint.

> diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpo=
int.c
> index c323c2aab2af9..0df3ff556f479 100644
> --- a/arch/x86/kernel/hw_breakpoint.c
> +++ b/arch/x86/kernel/hw_breakpoint.c

[ ... ]

> @@ -129,23 +133,36 @@ static int manage_bp_slot(struct perf_event *bp, en=
um bp_slot_action action)
>  static void setup_hwbp(struct arch_hw_breakpoint *info, int slot, bool e=
nable)
>  {
>  	unsigned long dr7;
> -
> -	set_debugreg(info->address, slot);
> -	__this_cpu_write(cpu_debugreg[slot], info->address);
> +	bool enabled;
> =20
>  	dr7 =3D this_cpu_read(cpu_dr7);
> +	enabled =3D dr7 & ((DR_LOCAL_ENABLE | DR_GLOBAL_ENABLE) << (slot * DR_E=
NABLE_SIZE));
>  	dr7 &=3D ~(__encode_dr7(slot, 0xc, 0x3) |
>  		 (DR_LOCAL_ENABLE << (slot * DR_ENABLE_SIZE)));
> -	if (enable)
> -		dr7 |=3D encode_dr7(slot, info->len, info->type);
> +
> +	/*
> +	 * If the slot is currently enabled, disable it first before updating
> +	 * the address register to prevent spurious debug exceptions.
> +	 */
> +	if (enable && enabled) {
> +		barrier();
> +		set_debugreg(dr7, 7);
> +		barrier();
> +		this_cpu_write(cpu_dr7, dr7);
> +	}
> +
> +	set_debugreg(info->address, slot);
> +	__this_cpu_write(cpu_debugreg[slot], info->address);
> =20
>  	/*
>  	 * Enabling:
>  	 *   Ensure we first write cpu_dr7 before we set the DR7 register.
>  	 *   This ensures an NMI never see cpu_dr7 0 when DR7 is not.
>  	 */
> -	if (enable)
> +	if (enable) {
> +		dr7 |=3D encode_dr7(slot, info->len, info->type);
>  		this_cpu_write(cpu_dr7, dr7);
> +	}
> =20
>  	barrier();

[Severity: Medium]
Could this ordering cause a spurious debug exception when reinstalling a
breakpoint with a narrowed address mask?

When arch_reinstall_hw_breakpoint() is called to narrow the mask of an acti=
ve
AMD breakpoint (e.g., changing from a wide range mask like 0xFF to an exact
match 0x0), setup_hwbp() re-enables the breakpoint in DR7 via
set_debugreg(dr7, 7) just after this barrier, but before the AMD address ma=
sk
is updated via amd_set_dr_addr_mask().

If an NMI occurs in this small window, or if the memory accesses of
amd_set_dr_addr_mask() itself fall within the old wider range around the new
address, it seems a spurious #DB exception could fire.

Should the mask be updated before re-enabling the breakpoint in DR7?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178476134787.26117.=
10094977293012760490.stgit@devnote2?part=3D6
