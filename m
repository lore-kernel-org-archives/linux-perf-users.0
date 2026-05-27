Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4C7381B10
	for <linux-perf-users@vger.kernel.org>; Wed, 27 May 2026 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779902921; cv=none; b=O0ytnpGux3YtgQafu60FG4uBpSvpNVMLGiM59Ke5FAeahWnmHACBuG6PeOXMIHXrlCtxYspsjsbBsIzBBsOBOHxrRBpXUZ7RUU4ENFzd49C0H2sAcH7TgAKxjzCkHSREawz9CIytxktle21pusJCfrAG1TMqEUxpH8a3uHK6msE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779902921; c=relaxed/simple;
	bh=a56QDnTNljNmdxuOfgpIX0Nt38XByWBsQw7GGK5oaec=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xo6ZaE6SqrsQtHvNa/6KXxw/MU6ZKOM+J8v+G5uW+vgK1D7c7gF+dYUaxxC816qrLUDEsTXWcQULLJ0uRQWcuj9VKOt0IBr1aKhoBy5ebaCNtdWTaZP6X44bhCjfO13pMuFSt5AiHI9wd628RYMihmv9kGOCrRNF2qnNlRSAiro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUn0hxqR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUn0hxqR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399211F000E9;
	Wed, 27 May 2026 17:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779902920;
	bh=8A1ZB/0FO7b5+8ACGM7sFII7OMb7w2M41ImenvBkTLM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aUn0hxqR26saeUiE78P3Lye84/f2X18zVOly+cEaXUpgIbqo71nUlM524LsamGLbg
	 82qWqzeYXtYYRZiuDCETE3AAzly804Ys2VYFoYoTmmcYxQvu+YVrgMqs2Eh4Tq1nQS
	 orwGAz6W2djsfF8WWK82emUweWXLNsQsXXbQKhe2Jd9rmnbGIGW9dK5p+bpSI0pX6y
	 tEWq6de6bFMVP44gCvIx37EPU3DTP58ymuXkUIt4OuRinTg8hXwEVnVpfiULEXugcK
	 oOh3Pwe71fNZbFB7lWzMftdizT0lVHo0U0ySwMZNOnuaac1l3BvSvb87wT+dTfINMq
	 XY6BQybCr2lcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 2/7] perf/x86/intel/uncore: Guard against invalid box
 control address
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260527151154.130505-2-zide.chen@intel.com>
References: <20260527151154.130505-2-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 17:28:39 +0000
Message-Id: <20260527172840.399211F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch guards box-level operations against invalid (0) control =
addresses when a discovery unit is missing, but it critically misses event-=
level operations. This omission allows an unprivileged or privileged user r=
unning `perf` to trigger a #GP fault (kernel panic) or PCI configuration sp=
ace corruption.
--

commit 65ddbcdd36196085490e8783cb658d7e20c2e9c5
Author: Zide Chen <zide.chen@intel.com>

perf/x86/intel/uncore: Guard against invalid box control address

This commit guards against a NULL return value from
intel_uncore_find_discovery_unit() before accessing hardware box control
addresses. It prevents potential faults when a CPU die is offline during
uncore enumeration.

> diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/i=
ntel/uncore_discovery.c
> index 60e1200c4691d..af2217b44a814 100644
> --- a/arch/x86/events/intel/uncore_discovery.c
> +++ b/arch/x86/events/intel/uncore_discovery.c

[ ... ]

> @@ -549,6 +560,10 @@ bool intel_generic_uncore_assign_hw_event(struct per=
f_event *event,
> =20
>  	if (box->pci_dev) {
>  		box_ctl =3D UNCORE_DISCOVERY_PCI_BOX_CTRL(box_ctl);
> +
> +		if (!box_ctl)
> +			return false;
> +

[Severity: High]
This is a pre-existing issue, but does returning false here when box_ctl is
invalid still leave us vulnerable to hardware access faults during event
execution?

When intel_generic_uncore_assign_hw_event() returns false, the caller
uncore_assign_hw_event() unconditionally falls back to legacy offset
calculations using uncore_event_ctl(). For discovery PMUs, this results in
hwc->config_base being set to a small relative offset like 0x0.

Later, when a user schedules a perf event on this box, the event startup
routines execute blindly using this base:

intel_generic_uncore_msr_enable_event()
    wrmsrq(hwc->config_base, hwc->config);

Could this result in a fatal #GP fault by executing wrmsrq(0, ...), or
corrupt PCI configuration space by overwriting the Vendor or Device ID at
offset 0x0?

While this patch successfully prevents faults during boot or hotplug box
initialization, could it leave the crash accessible through user-controlled
perf execution?

>  		hwc->config_base =3D box_ctl + uncore_pci_event_ctl(box, hwc->idx);
>  		hwc->event_base  =3D box_ctl + uncore_pci_perf_ctr(box, hwc->idx);
>  		return true;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527151154.1305=
05-1-zide.chen@intel.com?part=3D2
