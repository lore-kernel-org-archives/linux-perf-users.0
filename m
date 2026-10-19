Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768075A358A
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421066; cv=none; b=prSsn0sPzrtXl6kfspqSSRhiwLbZvmk4GTw4VLDdfiAkKyXSJPibg2FgGnB+ch+GE24gvOqDY6H2XmMc1SkYsSkdVFlaYkFa10glvvmszRdViMZZdBUiY7dUAkhviXar1dked1pzmOg6dz5qJOHvXoOuTQtk9ng2PricXugulks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421066; c=relaxed/simple;
	bh=g6TZew8FM3MjfoeBphv//yG4iB/8Ep93uCbbURryM7E=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=BQWY03zb+Azwg1TSxvkPKFeV0BgXx338BxUk2KNcE4gbbqmMvfNBtrximixMxbCBQIj96jvImNJwj62W1JlSpvhGWS4FzkJv7O4QIbiraI710m9qyvwi8ULFwoBzVm4dmNa3xW7zj77381hhN69+6rgcRqZ9NXnjJ6wBWnOTABI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADbq8/A+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADbq8/A+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D781F000C4;
	Mon, 19 Oct 2026 14:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792421064;
	bh=FL/7PJAAxp4VwhrcemgwAPEAFGeeWl3dEqliGSc0qYA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ADbq8/A+DY7W+EuKC4qsXlGUebneYeaeIevLby8n0yUjXOlEZQqaCtChURin6NIE9
	 9tY8cBmmxuMNZnKO06qpMa5sz4cxZTMGsTYGuvJpfOrO+6398j7fii95Xd2NxwOTo1
	 U/IbxJETFSMtgVEflaR8/OC49M+wzWByA/x9CLcEwEnSxmgVCNvrzY5J7VLKQsTSAv
	 tf0ZIDxHWIxh0zmpsYKBBGSVZXVkWNCNrWbWnawVX73Ub3kQjSQ+Kh20HC6y9IuASp
	 K3UFdvZ0YWhtG5ZRDvBGIEeXAzcMrxNHbrAH0VcBRpLNU0xv7ZJE64FJ6a7RMXpnoa
	 JOemQMl/aHiuA==
Message-ID: <sashiko-outbox-177485@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.1] perf: marvell: Cancel CN10K DDR PMU
 hrtimer on device remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261019135441.1420968-185-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-185-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 14:44:23 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf: marvell: premature hrtimer_cancel() in cn10k_ddr_perf_remove=
()
--

commit ee388a976febdb25de30edee55cec9fcf0a7184a
Author: Geetha sowjanya <gakula@marvell.com>

perf: marvell: Cancel CN10K DDR PMU hrtimer on device remove

This commit cancels the poll hrtimer in cn10k_ddr_perf_remove() so the
timer callback cannot run after the device is unbound and its resources
are freed.

> diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_=
cn10k_ddr_pmu.c
> index 72ac17efd846a..9974b62541f0d 100644
> --- a/drivers/perf/marvell_cn10k_ddr_pmu.c
> +++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
> @@ -1088,6 +1088,12 @@ static void cn10k_ddr_perf_remove(struct platform_=
device *pdev)
>  {
>  	struct cn10k_ddr_pmu *ddr_pmu =3D platform_get_drvdata(pdev);
> =20
> +	/*
> +	 * Cancel the poll timer before further teardown so the handler
> +	 * cannot run after this function returns.
> +	 */
> +	hrtimer_cancel(&ddr_pmu->hrtimer);
> +
>  	cpuhp_state_remove_instance_nocalls(
>  				CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE,
>  				&ddr_pmu->node);

[Severity: High]
Can ddr_pmu->hrtimer be re-armed after hrtimer_cancel() returns here?

In cn10k_ddr_perf_remove(), hrtimer_cancel(&ddr_pmu->hrtimer) is called
before cpuhp_state_remove_instance_nocalls() and perf_pmu_unregister():

drivers/perf/marvell_cn10k_ddr_pmu.c:cn10k_ddr_perf_remove() {
	hrtimer_cancel(&ddr_pmu->hrtimer);

	cpuhp_state_remove_instance_nocalls(
				CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE,
				&ddr_pmu->node);

	perf_pmu_unregister(&ddr_pmu->pmu);
}

Until cpuhp_state_remove_instance_nocalls() removes the hotplug instance
and perf_pmu_unregister() finishes synchronize_srcu() / synchronize_rcu()
and detaches events via pmu_detach_events(), PMU and CPU hotplug callbacks
remain active:

kernel/events/core.c:perf_pmu_unregister() {
	...
	synchronize_srcu(&pmus_srcu);
	synchronize_rcu();
	...
	pmu_detach_events(pmu);
	...
}

During that window, cn10k_ddr_perf_event_add() can still run on another
CPU (via an in-flight perf_event_open(), ioctl(PERF_EVENT_IOC_ENABLE),
perf_rotate_context(), or cn10k_ddr_pmu_offline_cpu() ->
perf_pmu_migrate_context()) and call hrtimer_start() when
pmu->active_events becomes 1:

drivers/perf/marvell_cn10k_ddr_pmu.c:cn10k_ddr_perf_event_add() {
	...
	pmu->active_events++;
	hwc->idx =3D counter;

	if (pmu->active_events =3D=3D 1)
		hrtimer_start(&pmu->hrtimer, cn10k_ddr_pmu_timer_period(),
			      HRTIMER_MODE_REL_PINNED);

	if (counter < DDRC_PERF_NUM_GEN_COUNTERS) {
		/* Generic counters, configure event id */
		reg_offset =3D DDRC_PERF_CFG(p_data->cfg_base, counter);
		ret =3D ddr_perf_get_event_bitmap(config, &val, pmu);
		if (ret)
			return ret;
	...
}

If ddr_perf_get_event_bitmap() then returns -EINVAL (or if
pmu->active_events was previously skewed by a failed add),
cn10k_ddr_perf_event_add() returns without decrementing pmu->active_events
or stopping pmu->hrtimer. Because event_sched_in() leaves the event in
PERF_EVENT_STATE_INACTIVE on add failure, pmu_detach_events() ->
event_sched_out() never calls cn10k_ddr_perf_event_del() for that event
(and even if other active events are detached, pmu->active_events never
reaches 0 in cn10k_ddr_perf_event_del()).

This leaves ddr_pmu->hrtimer armed when cn10k_ddr_perf_remove() returns,
allowing cn10k_ddr_pmu_timer_handler() to run after devm frees struct
cn10k_ddr_pmu and unmaps ddr_pmu->base.

Should hrtimer_cancel(&ddr_pmu->hrtimer) be called after
perf_pmu_unregister() and cpuhp_state_remove_instance_nocalls() have
completed (matching the reverse of the setup order in
cn10k_ddr_perf_probe())?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-185-sashal@kernel.org?part=3D1
