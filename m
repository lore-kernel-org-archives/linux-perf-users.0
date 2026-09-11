Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7728476684
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2026 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130136; cv=none; b=TO5htKLvhjJPzLLqbdpElH132z8yzN0Y7+CK6THGW8Ihg7INAhaPGXGrYWxQngdW1JAHMAkpShwa87FMm9b95FFRF+4ss+B5dYIC8S3ZUV6nC+Ev/yiFqBfaQwPg1SfQWcQWIk+FADT9SiskiE2ZTHfp/fp5E1CRMRD3q5mUq2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130136; c=relaxed/simple;
	bh=DGN1tovzULoS2hM7OBQZGFGaW587cIdO2/ljCmjbAQE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iX0Kz7IFle2NEVIVM4DcPR2jnPCmAHpLtC36R5sx7R/MQITgycDJQ/qAGHTssZtg4f0tyqodBKXRb6KxXcniuJkXqaSdgTpJcRCeRVOaLxFTWY8egLqk7EOfr15lV78X2Dqx+q4vzC8YDNng5B3LEikFGx8hgL9/AlnW2TGnOjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoBmERKJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoBmERKJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1C11F00893;
	Fri, 11 Sep 2026 12:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789130134;
	bh=BJ7Y4xsb49LC7ENgA4JUO8KXE8sLdvUcF5nkHjE3AOA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FoBmERKJDlpZ1ArPIW+4Wvpa/XeUXphPhkr4DtbkJ+E7Y9V/U58X1EXZYyHSmASKE
	 PNM17NiY7rHmJVRXNyQN7CWE/YA3YEQG93hHbsEXXXERF321hFoYUewWMJgpSovlof
	 ZC+bigQ6Y8ZSUqQTFgc2Q38JpZ+Bew0Dbn1QoHI8PjI+0wIbBofV7PRcSSvEz8JcSH
	 8XrRDcQUZzaH+I6zyP7aaNPn+L9lQu3uWbQAhPWNfgagdIZrv1hkL2abkfgXJ4n2Tx
	 nTcR9TaSzX73sv86Mzb3cv/REbPzAS+rq28k9Z2UTFvtNEAsH3IkLMF9o0VkFcgq/K
	 XhYeQyeSBaleg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 4/9] drivers: firmware: add riscv SSE support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260911121456.33223-5-zhangzhanpeng.jasper@bytedance.com>
References: <20260911121456.33223-1-zhangzhanpeng.jasper@bytedance.com>
 <20260911121456.33223-5-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:35:34 +0000
Message-Id: <20260911123534.6D1C11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] lockdep_assert_preemption_disabled() in local event functions tr=
iggers a lockdep splat when called from CPU hotplug callbacks.
--

commit c8e18c554b3059a878f2a5763162d36f8061a2de
Author: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
drivers: firmware: add riscv SSE support

This commit adds a driver-level interface for RISC-V Supervisor Software
Events (SSE). It allows Linux clients to register NMI-like event handlers,
select target CPUs, and manage global or local events while handling CPU=20
hotplug and firmware interactions.

> diff --git a/drivers/firmware/riscv/riscv_sbi_sse.c b/drivers/firmware/ri=
scv/riscv_sbi_sse.c
> new file mode 100644
> index 0000000000000..e81cfb4b0c563
> --- /dev/null
> +++ b/drivers/firmware/riscv/riscv_sbi_sse.c

[ ... ]

> +int sse_event_disable_local(struct sse_event *event)
> +{
> +	if (!sse_event_is_global(event->evt_id))
> +		lockdep_assert_preemption_disabled();
> +
> +	if (!sse_get_reg_evt(event)->is_enabled)
> +		return 0;
> +
> +	return sse_sbi_event_func(event, SBI_SSE_EVENT_DISABLE);
> +}
> +EXPORT_SYMBOL_GPL(sse_event_disable_local);
> +
> +int sse_event_enable_local(struct sse_event *event)
> +{
> +	struct sse_registered_event *reg_evt =3D sse_get_reg_evt(event);
> +	int ret;
> +
> +	if (!sse_event_is_global(event->evt_id))
> +		lockdep_assert_preemption_disabled();

[ ... ]

> +static int sse_cpu_online(unsigned int cpu)
> +{
> +	int ret, rollback_ret;
> +	struct sse_event *event, *tmp;
> +	struct sse_registered_event *reg_evt;
> +
> +	arch_sse_init_cpu();
> +
> +	list_for_each_entry_safe(event, tmp, &events, list) {
> +		if (sse_event_is_global(event->evt_id))
> +			continue;
> +		if (event->cleanup_pending) {
> +			ret =3D sse_teardown_event(event, cpu);
> +			if (ret)
> +				goto rollback;
> +			sse_release_cleanup_event(event);
> +			continue;
> +		}
> +
> +		ret =3D sse_event_register_local(event);
> +		if (ret)
> +			goto rollback;
> +		if (event->enable_requested)
> +			ret =3D sse_event_enable_local(event);
> +		else
> +			ret =3D sse_event_disable_local(event);

[Severity: Medium]
Will this lockdep assertion trigger a warning during CPU hotplug operations?

The CPU hotplug callback sse_cpu_online() (as well as sse_cpu_teardown() vi=
a=20
sse_teardown_event()) runs from the hotplug thread with preemption enabled.=
=20

When these callbacks process local events, they directly invoke=20
sse_event_enable_local() and sse_event_disable_local(). Because those=20
functions enforce lockdep_assert_preemption_disabled() for local events,=20
could this cause a lockdep splat whenever a CPU is brought online or offlin=
e?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911121456.3322=
3-1-zhangzhanpeng.jasper@bytedance.com?part=3D4
