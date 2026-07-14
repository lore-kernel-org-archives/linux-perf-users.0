Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE39331A61
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 18:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054836; cv=none; b=CF7rHY1gReCoCTUaYbTZ+BQtuoExVrZpxwqao+HZuSquLtXRLGgszPPrVxyRwGuujbm+6btZvz81xySui2KBZQDlbswRtFj6kgYhcPR0tvysRHumHH7NM7p0cQcjSHJGy+H1/1fey/xLWz05EBsyM4k4yp2hIuoNzpCCOEJCYqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054836; c=relaxed/simple;
	bh=EaAclnHYkeRox42EORxekB0feAYksNPZWo8oKNESrks=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KQbKg9qI7NEQm3WsSjYR+Xs7rC0Z6XyP0YHPZHMkInXqOPFm+TbYF4HXKArlgXPWlFVEffwXxP9WGgNgoBRGze0SWdDRYhd5A8p73ghpgELtCsfNQY3mhYE95RhR547zME2bN6cwS+g+WvcAKrXFjPruhikIhbsMNpWlcMFDAZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcAGuIsf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcAGuIsf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05D21F000E9;
	Tue, 14 Jul 2026 18:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784054834;
	bh=us+Y3CFh5OI7/TRf+LgFKa7uPaSqSyffuNRtbuljoSw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gcAGuIsfqBm7jTAL9IdIOFiAW4FLh/MrvLKkwVvlvOugPpQL6vYr5oCZUw1owjngK
	 fPqlEkMmMAzPryaG3Ja+Qt/g9fZ9Ugiwbi7f3eRAj6agoOx9WiPWMV2t/2h2hMRJO3
	 9zyhn+75mtcRPssdjPRL5WQdAMGiTSRXLJkqGj0WKqyBKKQxDedaVcPAbrANYio+7C
	 CgVUkbAkZBz4H4hMgWXbY28EMzm11Y/C8qeyVjJbDqJd67uti5speo0sJ2kOgIpett
	 UwF5SzJV4e2/wRqDA8jHy/2515vP8LFDPaTk7jvkHokoykSBHlINy4Ali+m0NMQLar
	 gk9Phpg6xN8jg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 02/13] x86/hw_breakpoint: Unify breakpoint
 install/uninstall
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinchao Wang" <wangjinchao600@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260714182243.10687-3-wangjinchao600@gmail.com>
References: <20260714182243.10687-1-wangjinchao600@gmail.com>
 <20260714182243.10687-3-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 18:47:14 +0000
Message-Id: <20260714184714.A05D21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing compiler barrier during hardware breakpoint uninstall re=
introduces an NMI race condition.
- [Medium] Redundant hardware debug address register write during breakpoin=
t uninstall degrades performance.
--

--- Patch [2]: [RFC PATCH 02/13] x86/hw_breakpoint: Unify breakpoint instal=
l/uninstall ---
commit 856f1186c52b7f5043f0e5e6063055a66d542dc1
Author: Jinchao Wang <wangjinchao600@gmail.com>

x86/hw_breakpoint: Unify breakpoint install/uninstall

Consolidate breakpoint management to reduce code duplication and shrink
stripped code size. This refactoring paves the way for reinstalling
breakpoints and adds a missing types dependency.

> diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpo=
int.c
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
Does this code unconditionally write the hardware debug address register
even on the uninstall path?

Writing to DR0-DR3 is typically a slow serializing operation, which can
also trigger expensive VMExits in virtualized environments. Since the
breakpoint is being disabled via DR7 anyway when enable is false, is
this address register write necessary here? Could this introduce
unnecessary overhead on the hot path during perf event scheduling?

> +
> +	dr7 =3D this_cpu_read(cpu_dr7);
> +	if (enable)
> +		dr7 |=3D encode_dr7(slot, info->len, info->type);
> +	else
> +		dr7 &=3D ~__encode_dr7(slot, info->len, info->type);
> +
> +	/*
> +	 * Enabling:
> +	 *   Ensure we first write cpu_dr7 before we set the DR7 register.
> +	 *   This ensures an NMI never see cpu_dr7 0 when DR7 is not.
> +	 */
> +	if (enable)
> +		this_cpu_write(cpu_dr7, dr7);
> +
> +	barrier();
> +
> +	set_debugreg(dr7, 7);
> +
> +	if (info->mask)
> +		amd_set_dr_addr_mask(enable ? info->mask : 0, slot);
> +
> +	/*
> +	 * Disabling:
> +	 *   Ensure the write to cpu_dr7 is after we've set the DR7 register.
> +	 *   This ensures an NMI never see cpu_dr7 0 when DR7 is not.
> +	 */
> +	if (!enable)
> +		this_cpu_write(cpu_dr7, dr7);

[Severity: Medium]
Could the compiler reorder this write to cpu_dr7 before the DR7 register
is updated on the disable path?

The original uninstall code included an explicit compiler barrier before
updating cpu_dr7, but it appears to be missing here. If the compiler
reorders this memory access, could an NMI hit in the middle, observe a=20
cleared cpu_dr7, and incorrectly assume no breakpoints are active?=20

If the NMI handler then touches watched memory, could this lead to a fatal
nested hardware breakpoint exception?

> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714182243.1068=
7-1-wangjinchao600@gmail.com?part=3D2
