Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB9228727D
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 03:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784171323; cv=none; b=nFKO7qK3+Cfqt5ZAhldirBvMfyB72984UB5SpmS9t/H8Yod8HvnivHMvF11PrrZ5LQxs19rKmZVsZZIHLkVoTljBVc5gg5lwqRoJGh1Hq79YcUHXqO5L0gRxyVvo6XOwql1J5Y7SKJ8/J4xOUVrIRHJG8wVpVsTR6uQZ/Wk0mbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784171323; c=relaxed/simple;
	bh=ufY9ckgMwo4AWbBTB91mXqDZSne3OpOONFqF2GtjjNc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KEfF1DIkJX0jRt4m2Hip61xeShiEd7Hqx+EF9L7IKLazXCTS2a6zT3/6D7aUbDzwprI2zU/WYRC8OnGh8uPURO5cMNqWv7Vey3DTDQ5iLCatAwzmAfmJTXm2hZUt/+E5cbsmMPJFJ1/yGvUfXWueyNVxhM+qLR84OkeFyXQEHVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7R6Hdds; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7R6Hdds"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8A51F000E9;
	Thu, 16 Jul 2026 03:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784171321;
	bh=mqDG00WbeHXTlf3WKWeay5M+N7ozRcc2GPdir47xDGE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k7R6Hddst58A0GPzbDqowntEF3g6Uz1nrsLpJsGyRfDk44+u3T5C6iTGTLWbt+JFY
	 jZLg0B6GpAxyyq1qWybvL7xqdEWQimLaFkZlubq6538kjCrsIZ5kjPPX/AFhE0qJX7
	 8G3Cy6S83yQN0rJHKgy+iUbziBoayYIUwg2bSDPFOBjUJxukXPag2/MBjjukZ0915H
	 hSEAjgyLd+dllmzLwxbskM3b9mjMbiVA83fKoVM6H/RZ5D4imGuVuCxem0EF97Nwwf
	 1V4tVZ1urDAtUYVrK1W5JsYGksBXcZRyYaIvHifn/grit7c/SpskTpmRn3EOGIMxXv
	 4fU0fWi/YEo5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 6/9] x86/hw_breakpoint: Add
 arch_reinstall_hw_breakpoint
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <178417040126.209165.5176961124203156666.stgit@devnote2>
References: <178417033089.209165.16717079876036408877.stgit@devnote2>
 <178417040126.209165.5176961124203156666.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 03:08:40 +0000
Message-Id: <20260716030841.5C8A51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Modifying an active breakpoint via `arch_reinstall_hw_breakpoint()=
` updates the debug address register before disabling it in the control reg=
ister, violating architectural requirements and creating a race condition t=
hat can trigger spurious `#DB` exceptions.
- [Low] The newly added function `arch_reinstall_hw_breakpoint()` has no ca=
llers in the kernel tree.
--

--- Patch [6]: [PATCH v8 6/9] x86/hw_breakpoint: Add arch_reinstall_hw_brea=
kpoint ---
commit 26fd09a1abe10d2182564575b6e349d84a888d45
Author: Jinchao Wang <wangjinchao600@gmail.com>

x86/hw_breakpoint: Add arch_reinstall_hw_breakpoint

The new arch_reinstall_hw_breakpoint() function can be used in an
atomic context to efficiently re-establish an existing breakpoint
without going through the more expensive free and re-allocation path.

> diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpo=
int.c
> index c323c2aab2af9..5821bb4650cec 100644
> --- a/arch/x86/kernel/hw_breakpoint.c
> +++ b/arch/x86/kernel/hw_breakpoint.c

[ ... ]

> @@ -189,6 +193,11 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
>  	return arch_manage_bp(bp, BP_SLOT_ACTION_INSTALL);
>  }
> =20
> +int arch_reinstall_hw_breakpoint(struct perf_event *bp)
> +{
> +	return arch_manage_bp(bp, BP_SLOT_ACTION_REINSTALL);
> +}

[Severity: High]
Does this sequence risk triggering spurious hardware debug exceptions?

When arch_reinstall_hw_breakpoint() modifies an active breakpoint, it calls
arch_manage_bp() which then invokes setup_hwbp(). In setup_hwbp(), the debug
address register is updated before the control register (dr7) is safely
cleared:

arch/x86/kernel/hw_breakpoint.c:setup_hwbp() {
    ...
    set_debugreg(info->address, slot);
    ...
    dr7 &=3D ~(__encode_dr7(slot, 0xc, 0x3) |
             (DR_LOCAL_ENABLE << (slot * DR_ENABLE_SIZE)));
    ...
}

Because BP_SLOT_ACTION_REINSTALL operates on a breakpoint that might already
be active, dr7 is currently enabled in hardware during this window. Can
writing to the address register while the slot is still enabled in dr7
trigger a spurious debug exception if a concurrent execution accesses the n=
ew
address?

[Severity: Low]
This isn't a bug, but are there any planned callers for this function?

A search of the tree indicates that arch_reinstall_hw_breakpoint() is not
currently invoked by any subsystem or exported to modules.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178417033089.209165=
.16717079876036408877.stgit@devnote2?part=3D6
