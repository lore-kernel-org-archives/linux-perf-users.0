Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF8D36C0C8
	for <linux-perf-users@vger.kernel.org>; Sun, 26 Jul 2026 12:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785069287; cv=none; b=qGysYKEPFimzk2gD7lRoSENgZNcWpuItR7WgW55UnOhr1ILx4yYtajDXIpm7dd+/bupaL5kT/SK9LvcG3krhFeaOvn5ILeFKnBulJW4ndxzsyYO08adDZOSdqzFll1zlLt7PM7lq2Cpn2A4HXoPas7wx1bDUWajJCMMG0LXSXOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785069287; c=relaxed/simple;
	bh=m8IhKrX9bcghHtoibYzUUeSOj1GFn7YlO80VR1YSaDk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UTibwc4jvDUJaPBSKeiRV/4V2YEa0fu0Lueetah2aGbGi5HxyF66CTrovLiCEtyQt0l7lFIhMpJpMIANQe2HQ32tivgYC59R2TBpCyeMpCXBgzyZ2yxjPejaVGw5m8VqSUgZfjL5jCQJ0yTkCBcUeO2Ug+lTAuwRWU9tD/+fQQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8VLIpKQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8VLIpKQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07391F000E9;
	Sun, 26 Jul 2026 12:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785069286;
	bh=QI+NH2HS3QBNH7p5uG0iPr+1TNx5LIGi8NrZj+wZ04c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O8VLIpKQ6x2SLCIIm9+nnTnJn4bBjpiGJY4KOITJzakHBSHAhY1g3FFY+OTVFtHTs
	 bzFxmzOIzMjOA7XenER3Ba1SJxP04whPagifQurySIYdL6VxvXTdcfLdjt2gIexWpo
	 NPVgYMFqZEFvlHmP9FdeqfXzuEx7JHjOVHN9S+uyDWahPYvaePVaf7upw1bCVePY6b
	 p0o+dPsBJNeXzy4486dWsF23yMXXPgiTfuukcRrU7umQxDdUZgNaavPIfpeQeFzBJ6
	 +fMewpeMiWrIWbtDORFGxGfC4gSdi7YSp/h5vuPJRFEfQVNNYZONVbXhVVprsdkuLR
	 qlAAcyGOZHI5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] x86/hw_breakpoints: Add
 arch_modify_local_hw_breakpoint_addr() API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinchao Wang" <wangjinchao600@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <59637b96946653393a7ad3c7de094094796b39c2.1785067572.git.wangjinchao600@gmail.com>
References: <178476143000.26117.9810509272687580410.stgit@devnote2>
 <cover.1785067572.git.wangjinchao600@gmail.com>
 <59637b96946653393a7ad3c7de094094796b39c2.1785067572.git.wangjinchao600@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 12:34:45 +0000
Message-Id: <20260726123445.D07391F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] arch_modify_local_hw_breakpoint_addr() fails to increment cpu_dr7_=
seq, causing a race condition that can desynchronize hardware debug registe=
rs from their shadow state if interrupted by an NMI.
- [High] arch_modify_local_hw_breakpoint_addr() fails to update the primary=
 breakpoint shadow address (info->address), causing future updates to silen=
tly revert the address.
--

--- Patch [2]: [PATCH 2/3] x86/hw_breakpoints: Add arch_modify_local_hw_bre=
akpoint_addr() API ---
commit 91337a1d81005389f6b66cba9728d9f95a16cec3
Author: Jinchao Wang <wangjinchao600@gmail.com>

x86/hw_breakpoints: Add arch_modify_local_hw_breakpoint_addr() API

Wprobe needs to move an active per-CPU watchpoint without releasing and
reserving its hardware slot. This adds a new API to find the installed
local slot and update only its address shadow and hardware debug address
register.

> diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpo=
int.c
> index 9ef24b55737f8..ff1b9b78f78c1 100644
> --- a/arch/x86/kernel/hw_breakpoint.c
> +++ b/arch/x86/kernel/hw_breakpoint.c

[ ... ]

> @@ -128,6 +128,26 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
> =20
>  void arch_modify_local_hw_breakpoint_addr(struct perf_event *bp,
>  					  unsigned long addr)
>  {
>  	int i;
> =20
>  	lockdep_assert_irqs_disabled();
> =20
>  	for (i =3D 0; i < HBP_NUM; i++) {
>  		if (this_cpu_read(bp_per_reg[i]) =3D=3D bp)
>  			break;
>  	}
> =20
>  	if (WARN_ONCE(i =3D=3D HBP_NUM, "Can't find any breakpoint slot"))
>  		return;
> =20

[Severity: High]
Does this missing cpu_dr7_seq increment leave a race condition if interrupt=
ed
by an NMI?

If hw_breakpoint_restore() is running, reads the old shadow value, and is
interrupted by an NMI that calls this function to update the address, the
lack of a sequence bump means hw_breakpoint_restore() will not detect the
interruption. It would exit its retry loop and overwrite the hardware
register with the stale value.

[Severity: High]
Could this also cause the watchpoint to silently revert to its previous
value when rescheduled?

Since the perf_event's internal info->address (retrieved via
counter_arch_bp(bp)) is not updated here, any future call to
arch_install_hw_breakpoint() during PMU multiplexing or CPU hotplug
would reinstall the breakpoint using that stale address.

>  	this_cpu_write(cpu_debugreg[i], addr);
>  	barrier();
>  	set_debugreg(addr, i);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785067572.gi=
t.wangjinchao600@gmail.com?part=3D2
