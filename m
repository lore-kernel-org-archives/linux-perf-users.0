Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100CF2F12AB
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 19:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056969; cv=none; b=NCCoCiJAqMWI+eEdBGsxomZNAUlj18EwZBojTodnKFjSLmo4Mqyuc3aop7HJwNfYKOeL4AZitv2Xve4R6ByBN7BW7qq+31GDBymJWiVRFlUQWNjs8oIFatqkcPJr2vnOTUT1OkYS7tBPB+AaPZaykLbGSLff3Tm3JMKStZvlVws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056969; c=relaxed/simple;
	bh=sMpmYvZTdDuD1UJRvKX9TFHtEx8cBtuA9TZc+aXPmP4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uwMHvXSB5N/YcdtP4VMY5GKNdeaG17xoDJK2Y6zgi9q5W1oJR5KXFfgHU0OyH0exTXTVHV1uDJYSEemX1PCVvmzzCE7r6aWh0ePvqUw7JsluIycjRdYFV8yDKzdJI00GPydgiSURiZmFITAIMZv0+kajyqFIUB77rAeKoPBa6S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxTPL2uX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxTPL2uX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9EB1F000E9;
	Tue, 14 Jul 2026 19:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784056967;
	bh=DV5O96uOPJ+04BmUUWrKwxnXCpsaGFd/3fnk6CmiMns=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kxTPL2uXThdHflIlVuyhPnr5ZOk7/JYWxC/5pD8amojEWM9fWTmD8xDN5W7QcdPN/
	 XRQGKBcb0HibS+vQAOlRKjtOfoxTUPh5k08AylwfDNrauHk4zDIxzuJy7QZlBP/2dj
	 M4lzzVMXtkOFAjZ+qaFlw4EpkmT3ymJgilYidfY1s3hwg7kn8XLR7UxvQCLI312ZLB
	 DIXNSgfmxjwlc7Unvp9GtQnUKPqN/UCdQUewalyvtPCxteuu6xKEwaCRBK/4kLwwg4
	 AQWQ580aeZlkvQu77u5zlyAy9P5JFJ67H+9F7424A32DNIsZww2csife600JZXwQ/i
	 H/XJundwYBgxg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 03/13] x86/hw_breakpoint: Add
 arch_reinstall_hw_breakpoint
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinchao Wang" <wangjinchao600@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260714182243.10687-4-wangjinchao600@gmail.com>
References: <20260714182243.10687-1-wangjinchao600@gmail.com>
 <20260714182243.10687-4-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 19:22:47 +0000
Message-Id: <20260714192247.8F9EB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] In-place hardware breakpoint reinstallation via `arch_reinstall_=
hw_breakpoint()` fails to clear the AMD hardware breakpoint address mask wh=
en transitioning from a range breakpoint to an exact address breakpoint.
--

--- Patch [3]: [RFC PATCH 03/13] x86/hw_breakpoint: Add arch_reinstall_hw_b=
reakpoint ---
commit 59c50868129e1541bda319c3957c2b199256f005
Author: Jinchao Wang <wangjinchao600@gmail.com>

x86/hw_breakpoint: Add arch_reinstall_hw_breakpoint

This commit introduces arch_reinstall_hw_breakpoint to allow efficient
re-establishment of existing breakpoints in atomic contexts. It also modifi=
es
setup_hwbp to clear the slot's stale length/type and enable bits in DR7
before re-encoding to avoid OR-merging with the old encoding.

> diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpo=
int.c
> index 877509539300c..4221dbb899f90 100644
> --- a/arch/x86/kernel/hw_breakpoint.c
> +++ b/arch/x86/kernel/hw_breakpoint.c

[ ... ]

> @@ -188,6 +195,11 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
>  	return arch_manage_bp(bp, BP_SLOT_ACTION_INSTALL);
>  }
> =20
> +int arch_reinstall_hw_breakpoint(struct perf_event *bp)
> +{
> +	return arch_manage_bp(bp, BP_SLOT_ACTION_REINSTALL);
> +}

[Severity: Medium]
When arch_reinstall_hw_breakpoint is called to transition an active
breakpoint from an AMD range breakpoint to an exact address breakpoint,
does it fail to clear the old hardware breakpoint address mask?

If the caller updates the breakpoint configuration to an exact address
where the new mask is 0 and reinstalls it, the flow bypasses the uninstall
phase and calls setup_hwbp with enable set to true:

arch_manage_bp()->setup_hwbp()
    if (info->mask)
        amd_set_dr_addr_mask(enable ? info->mask : 0, slot);

Since info->mask evaluates to 0 for the new exact address breakpoint,
this condition skips calling amd_set_dr_addr_mask. This leaves the old
non-zero mask in the CPU MSR, which could cause the CPU to continue
monitoring the old, wider address range and potentially trigger spurious
hardware traps on memory accesses.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714182243.1068=
7-1-wangjinchao600@gmail.com?part=3D3
