Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC643B9617;
	Sun, 30 Aug 2026 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788100731; cv=none; b=MsqVQDUcYO3GWS8KJbCLYEkmuCsi2gxKIio47JjYWmP8nZP69gk04atGZshIoks9i+UPNnggtpp4BEz9VFtDWuOiMxhAQGERsaIrc9Z3c35UyPxdCefIiCseugmgQH12oVFs87A8H7C2fNiKhwOdjU632ojEdqRfHi4qzoEGwxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788100731; c=relaxed/simple;
	bh=nRc+1jUDcukuWBqaC5tmo+ADLAdFo2KMe7qHrhmhryk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DgwsuSbnvWekheJZe4Ys3iZv10Gu4W0hH7uTfCJCWyl3Wtv6fvfNJGNQuH4HUkkutNXzP28sGTqQQHVIFBgQBhWv/ckNEbuUQNuMqRTf+5b4jajiChrSPzqYr4t+bL8DCOX4vGxyl526HfEa98zA1Rj/c2sF9zeV+r50lWqf49I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4kqYqvv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4kqYqvv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070271F000E9;
	Sun, 30 Aug 2026 14:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788100729;
	bh=qrAL3AUON7sWCsPFVJ40jsqe6MqCEQSkoLvn2DXdrkI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M4kqYqvv3mHwXY2+KiL0qVWyJIBYl9JbJlLUnz/Cgn4wMhFCi5oSqBnV2W7UhfVjk
	 VOfqKURRKMnJ25CViDqG+pXRgDnTIvyX2fb9Xerup1u1SV9AlEqHEyZwApkB7jvLvP
	 OPmXrYG2QfIwAVRSw6JC7xGpM5LFmc33EeYVhfBC+b12r8KwWd80UBVvP8ZK5EoZpK
	 QissnAMAaOEzxeCH5ohy+fYf5IkIqPdXfLp7YRNUhYSKT/KAG3MdxyRYKvPJ0n2FD3
	 5AiT6bo6DK2GwtB8EEfkI8H4szs10hWT51f2XyJp++2jXAPwncYu56iLEgtP0ZBqTb
	 lNKF96cOF73nw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 05/14] x86/hw_breakpoints: Add
 arch_modify_local_hw_breakpoint_addr() API
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <178810006604.64882.2095793023976981357.stgit@devnote2>
References: <178810001186.64882.2161016469449127450.stgit@devnote2>
 <178810006604.64882.2095793023976981357.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 14:38:48 +0000
Message-Id: <20260830143849.070271F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Modifying a debug address register without first disabling the cor=
responding breakpoint in DR7 violates the x86 hardware architecture specifi=
cation and causes unpredictable behavior.
--

commit 35b07811f48c348c13ac1d9de7fa44d25fc7f36a
Author: Jinchao Wang <wangjinchao600@gmail.com>

x86/hw_breakpoints: Add arch_modify_local_hw_breakpoint_addr() API

This commit adds an architecture backend to modify the address of an active
per-CPU watchpoint without releasing its hardware slot. It validates the new
address, finds the installed local slot, and updates the hardware debug
register and per-CPU shadow state.

Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.=
1785067572.git.wangjinchao600@gmail.com/

> diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpo=
int.c
> index 3204e75dc4546..2227918b0163c 100644
> --- a/arch/x86/kernel/hw_breakpoint.c
> +++ b/arch/x86/kernel/hw_breakpoint.c

[ ... ]

> +int arch_modify_local_hw_breakpoint_addr(struct perf_event *bp,
> +					 unsigned long addr)
> +{

[ ... ]

> +	do {
> +		seq =3D this_cpu_inc_return(cpu_dr7_seq);
> +		this_cpu_write(cpu_debugreg[i], addr);
> +		barrier();
> +		set_debugreg(addr, i);

[Severity: High]
Does this code risk violating the x86 hardware architecture specification?

Looking at arch_modify_local_hw_breakpoint_addr() in
arch/x86/kernel/hw_breakpoint.c, set_debugreg() directly updates the debug
address register (DR0-DR3) while its corresponding enable bit in DR7 might
still be set.

According to hardware specs, modifying a debug address register without fir=
st
disabling the breakpoint in DR7 can lead to spurious debug exceptions or
unpredictable processor behavior if an NMI occurs or if execution boundaries
trigger a match on the transient state.

Should the DR7 enable bit be cleared before updating the debug register?

> +		barrier();
> +	} while (seq !=3D this_cpu_read(cpu_dr7_seq));
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178810001186.64882.=
2161016469449127450.stgit@devnote2?part=3D5
