Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44E23EFD37
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 13:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784294139; cv=none; b=rE8ane+qZlRRt4MrYLaEck0gdHs6B9ncYeYNTiNnTakXwiQa9QW/yiko5We/LQtXhLNiVCKWZGbnHJrn1AwJT97rcZNCRENnTsTr1yhQgCcr3posoKp5I25f37nUG1+ozOreZN+hv5MJtkYUB+qjGaKaLjJar0d1uzo+ni1EShc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784294139; c=relaxed/simple;
	bh=fdIVj6ByjVe43ekwuljfWtdmWzwFVVKgwIQ8KRczb8o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=stJ2/CTB3sjTDHYQFcVVLtKL/GEfWvQae4XD6dFWM1NCAfU6FM/bWRusoLy61WsHEX4gZNGahCmlT90+3cxIhE4TDR5C/QdlJzqa6WEPpIwCufDIA+xn2ZE9fOhkckpnoz0m2NfIjJDy7lpa5EtE7r0deBKz7Iy1VrIgW4I/8tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7sEQXnV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7sEQXnV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BF61F00A3A;
	Fri, 17 Jul 2026 13:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784294138;
	bh=qBoFW5wboq4Hela750z5bZacSA6KNjq/LsUrClBIIOU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L7sEQXnV6okq9qgWHKUmhdEjbyRGjEmrrj6VAccRFHlLkKVn61GBbew3Kvoe1M/iD
	 gJsyhikCFcaUPZNkjj3ec6WeSZTDpjUube+eiYP9kJ5NIj0SW3zNekWs/LGuZC6XkA
	 +bp4e6f+H0/SLfeAMF1mos1qEQlQVvB6bs+LrFUAjmOw2mlt3InaQxCBsxQvWUjGYW
	 d5parbkiHBMUdhWQcywfr85F4aAhWIL4EVwVC3PbEqcdblQtbBMzRktynwl1QtoS80
	 unKfnDp1HeAnfGlraYx4hnVCmYM0+NdtzWsMyEW9kqeVIbfIMLAeZ8sff/7/vBJsve
	 yiP1ZBqarzIag==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 02/13] x86/hw_breakpoint: Unify breakpoint
 install/uninstall
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinchao Wang" <wangjinchao600@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260717130251.1901695-1-wangjinchao600@gmail.com>
References: <20260717125023.1895892-1-wangjinchao600@gmail.com>
 <20260717130251.1901695-1-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 13:15:37 +0000
Message-Id: <20260717131538.55BF61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unnecessary write to debug address registers (DR0-DR3) during br=
eakpoint uninstall causes a performance regression.
--

--- Patch [2]: [RFC PATCH v2 02/13] x86/hw_breakpoint: Unify breakpoint ins=
tall/uninstall ---
commit 5b286a3cc2eb7cc8f15c628fb198117f5bc1729d
Author: Jinchao Wang <wangjinchao600@gmail.com>

x86/hw_breakpoint: Unify breakpoint install/uninstall

This commit consolidates breakpoint management to reduce code duplication
by unifying the install and uninstall paths into common management function=
s.
It also includes linux/types.h to fix a missing build dependency.

> --- a/arch/x86/kernel/hw_breakpoint.c
> +++ b/arch/x86/kernel/hw_breakpoint.c

[ ... ]

> +static void setup_hwbp(struct arch_hw_breakpoint *info, int slot, bool e=
nable)
> +{
> +	unsigned long dr7;
> +
> +	set_debugreg(info->address, slot);
> +	__this_cpu_write(cpu_debugreg[slot], info->address);

[Severity: Medium]
Does this code introduce a performance regression by unconditionally writin=
g to
the hardware debug address registers (DR0-DR3) during uninstallation?

Writing to hardware debug registers is an expensive operation that forces
pipeline flushes on bare metal and causes VM-exits in virtualized environme=
nts.
Looking at the old arch_uninstall_hw_breakpoint(), the uninstall path used =
to
only update DR7 and skipped writing the address register.

Now, when a task with a hardware breakpoint is scheduled out, the perf_event
subsystem uninstalls the breakpoint which calls into setup_hwbp() with
enable=3Dfalse. This forces an unconditional set_debugreg() on the address
register anyway. Could this write be restricted to only happen when the ena=
ble
flag is true?

> +
> +	dr7 =3D this_cpu_read(cpu_dr7);
> +	if (enable)
> +		dr7 |=3D encode_dr7(slot, info->len, info->type);
> +	else
> +		dr7 &=3D ~__encode_dr7(slot, info->len, info->type);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717125023.1895=
892-1-wangjinchao600@gmail.com?part=3D2
