Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DE33A48F4
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 09:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782899290; cv=none; b=cPUO+iNCmOe86EZB3LCgeEhMJP6Chy7Z/xKBprsKRPj7BeFh6u0aX1N83E3WmU7ZSFF05ieUPfNGZXHcNafylBXg+v3TNJmtxb3cg9WIMMCGV1jbFx0MLbMlg0XUZlEP8KETJ/Sd2hDlGe5XzlyNgpzZZAoKzaiht+8rfdj1Ylo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782899290; c=relaxed/simple;
	bh=cMtwKkFL+0uaggv5PTC671SyCo4YF5tfXmhqxmkrLZ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U7ai2jI04liZV5ySh12gJqheMb7ecCTib/CSk118pil/omRBNmWvzzjY8IK5ZH04RaR9/IiBOkr0bKZxC4V8HGvlnco6Vs4polXNRfBhUpxJGXDav94HOLEbjgJ7iAZQPdhlwpi7X1e4ij8pcUVIpOnXjPNiy+Q/TL9fR4kHxkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Plou8kxS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Plou8kxS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8BC1F000E9;
	Wed,  1 Jul 2026 09:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782899288;
	bh=ygkXgYM/4IZGn0taYa8nG9m6Qf1mUsUJ8yPlVuJFfbY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Plou8kxSkGdcj0GRzkP4XB01fbDqhz3nMbCMG5aeF2A2kwrouRWZhCC88AYj94Xs9
	 omIHzyHZv2hWuKWIHqShSKOgmVqBn7zkoMz0wcy1JK/jjFyU6CyuIz+OToa+drZNAx
	 o9TJfQa1VdJLQ12jwYj6OaQ65AJhBxtYHs+yyHGZ2svhPGJgfG6iqXHsQtpbzRcb9y
	 OxYhewagFXA+6tKL2mGRU0U/u2fAfIbQcY8o67eB8LgrWHBrNamSZ1r3sPEDR+NroB
	 i1XqQLNgBMysE2jiIMVX181JCxxpXZhnCT9rk0Th43SfQn5s3C4DWQncxJP8DS7y4G
	 TZ2IcYnwbCFnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] perf/x86/amd/uncore: Add Hygon uncore PMU
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qi Liu" <liuqi@hygon.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260701093417.1312443-4-liuqi@hygon.cn>
References: <20260701093417.1312443-1-liuqi@hygon.cn>
 <20260701093417.1312443-4-liuqi@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 09:48:07 +0000
Message-Id: <20260701094808.5C8BC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incorrect teardown order in the init error path causes NULL pointe=
r dereferences and timer Use-After-Free.
--

commit 757cc017754a489c37240b97dc4192801ef594af
Author: Qi Liu <liuqi@hygon.cn>

perf/x86/amd/uncore: Add Hygon uncore PMU support

This patch adds uncore PMU support for Hygon processors based on the shared
AMD-family uncore framework. It reuses the common uncore infrastructure whi=
le
accommodating Hygon-specific differences like MSR base addresses and event
encodings.

> diff --git a/arch/x86/events/amd/hygon_uncore.c b/arch/x86/events/amd/hyg=
on_uncore.c
> new file mode 100644
> --- /dev/null
> +++ b/arch/x86/events/amd/hygon_uncore.c

[ ... ]

> +static int __init hygon_uncore_init(void)
> +{

[ ... ]

> +	ret =3D cpuhp_setup_state(CPUHP_AP_PERF_X86_HYGON_UNCORE_ONLINE,
> +				"perf/x86/hygon/uncore:online",
> +				hygon_uncore_cpu_online,
> +				hygon_uncore_cpu_down_prepare);
> +	if (ret)
> +		goto fail_start;
> +
> +	return 0;
> +
> +fail_start:
> +	cpuhp_remove_state(CPUHP_AP_PERF_X86_HYGON_UNCORE_STARTING);
> +	cpuhp_remove_state(CPUHP_PERF_X86_HYGON_UNCORE_PREP);
> +	hygon_uncore_pmus_unregister();

[Severity: High]
Is the teardown order inverted here?

If initialization successfully registers the PMU on the first CPU but fails=
 on
a subsequent CPU, the error path jumps to fail_start.

If a user manages to open a perf event on this PMU during this small window,
removing the CPUHP_PERF_X86_HYGON_UNCORE_PREP state first will free the PMU
context and set it to NULL.

When hygon_uncore_pmus_unregister() is then called, it triggers
perf_pmu_unregister(), which attempts to detach the active event by calling
amd_uncore_common_stop().

Will amd_uncore_common_stop() then dereference the NULL context or cause a
timer use-after-free?

> +	goto fail;
> +fail_prep:
> +	cpuhp_remove_state(CPUHP_PERF_X86_HYGON_UNCORE_PREP);
> +fail:
> +	hygon_uncore_infos_free();
> +
> +	return ret;
> +}
> +
> +static void __exit hygon_uncore_exit(void)
> +{
> +	cpuhp_remove_state(CPUHP_AP_PERF_X86_HYGON_UNCORE_ONLINE);
> +	cpuhp_remove_state(CPUHP_AP_PERF_X86_HYGON_UNCORE_STARTING);
> +	cpuhp_remove_state(CPUHP_PERF_X86_HYGON_UNCORE_PREP);
> +
> +	hygon_uncore_pmus_unregister();

[Severity: High]
Does this exhibit the same inverted teardown order?

Although module refcounting usually protects the module exit path from exec=
uting
while events are active, shouldn't we unregister the PMUs before removing t=
he
hotplug states to safely detach any resources and mirror the initialization
order?

> +	hygon_uncore_infos_free();
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701093417.1312=
443-1-liuqi@hygon.cn?part=3D3
