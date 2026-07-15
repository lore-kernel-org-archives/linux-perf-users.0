Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4849732B13A
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 02:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784081619; cv=none; b=GLTaCQCNvIo4eO4dY61uQCprP1O7OeKxxmhFvrr07L8Fn0gMUqjm3j6YfLDG+c/60Hn7MZAM+tOvWDCHHGjsrVbW4yKtjrOw0/8gvaqXHyBeTicMHViAm0cgSPVUbmj2I2YOAnyQbuqnE6AObYrplagZbCYILvTRlZEEhocEr5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784081619; c=relaxed/simple;
	bh=NZptgngmdCWPSHbyuccMz0lQCuKBN1gfDbIl37AV0y0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oSbOjaypEdMZVcej/kxLZRaHHpG8zP8ciIdH0ekg7s3i74uYuARfChOn7AEakZqarnY8gyEvEyqeeZBy/yzCkuMcsMuKwsEt/CElYMGcLI1cHmydls+BaEytI8t36GRfzQg42Pl1GxUKKWHjcemEYDrt2Gf7+ILVoWDW6gTl2Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyyFRUz0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyyFRUz0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D0F1F000E9;
	Wed, 15 Jul 2026 02:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784081618;
	bh=oNMnJlFGawsihn6MvT+t84jY5ga+yhTwJlKRA3hNyQU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VyyFRUz0RwFQZUtCaokqQgZrt1EWuzvnM3Eq8ek38D+K4yzQOZWyT/1k/TzC2B8hk
	 dMrnSwZncFSv4CMxxOtGMrF7z91v2Hwccz20pD+SqzrhR/RYBQZOYGVjuMjYElnNnh
	 aiw2gYIofFyK108isde2/rluMwD1tFjD3LmDpttBjwmnGJlF0NbhQUU3XHW6NYKnLc
	 iHRH9JR3zyusL6/STWx8B/Ce7hV+XY7RsXezVBFhdys3dGD6Y8j67xhED9H40DwlzZ
	 9FBL96IDwnfqMXxTX6xztELHihYr6LCiQglgdS/lw/PWJcFT08F/AZefr85dwjDS0m
	 P7P+d6U8cLjwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/10] x86/hw_breakpoint: Add
 arch_reinstall_hw_breakpoint
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <178407992003.95826.8437044383333615344.stgit@devnote2>
References: <178407983818.95826.12714571928538799781.stgit@devnote2>
 <178407992003.95826.8437044383333615344.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 02:13:37 +0000
Message-Id: <20260715021337.E9D0F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] arch_reinstall_hw_breakpoint() fails to clear old DR7 length and=
 type bits before applying new attributes, causing hardware state corruptio=
n if breakpoint parameters are modified.
--

--- Patch [7]: [PATCH v7 07/10] x86/hw_breakpoint: Add arch_reinstall_hw_br=
eakpoint ---
commit 6bcf7b8e474f5683afc4564b0a92754b65b43406
Author: Jinchao Wang <wangjinchao600@gmail.com>

x86/hw_breakpoint: Add arch_reinstall_hw_breakpoint

This commit introduces arch_reinstall_hw_breakpoint() to allow callers to
efficiently re-establish existing hardware breakpoints in an atomic context
without needing the full free and re-allocation path.

> diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpo=
int.c
> index 877509539300c..9af8d81075db7 100644
> --- a/arch/x86/kernel/hw_breakpoint.c
> +++ b/arch/x86/kernel/hw_breakpoint.c
[ ... ]
> @@ -188,6 +192,11 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
>  	return arch_manage_bp(bp, BP_SLOT_ACTION_INSTALL);
>  }
> =20
> +int arch_reinstall_hw_breakpoint(struct perf_event *bp)
> +{
> +	return arch_manage_bp(bp, BP_SLOT_ACTION_REINSTALL);
> +}

[Severity: Medium]
When callers use this new function to update an existing breakpoint's length
or type attributes, will this cause hardware state corruption in the DR7
control register?

The execution path goes through arch_manage_bp() and calls setup_hwbp()
with enable =3D true. Looking at setup_hwbp(), it appears the new control b=
its
are bitwise OR'ed with the existing mask:

arch/x86/kernel/hw_breakpoint.c:setup_hwbp() {
    ...
    if (enable)
        dr7 |=3D encode_dr7(slot, info->len, info->type);
    ...
}

Because the old DR7 configuration bits for this slot are never cleared firs=
t,
could the combination of old and new bits create an invalid breakpoint
configuration mask?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178407983818.95826.=
12714571928538799781.stgit@devnote2?part=3D7
