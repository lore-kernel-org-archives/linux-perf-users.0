Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E4C299929
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 05:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778735529; cv=none; b=rtqmEY3ka7+l9pcMJCLfvShZLTzDQ/D6bPUePi33kQLKyioRPuN66AgxsSKTc8EgPwNRvij40c6GpQ6287rL/ZzpEnAoZ9ygJP9/yfygBFTBPJ36FfOIGaXdRtz6UHIM3RgTNIdPdthpyDKIhLmTBcZiqjpUt07xV4BLhokR+P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778735529; c=relaxed/simple;
	bh=N2hOzLJhPj7YZe6+GM52kP0ytRVzomLb6qq7ROjeUho=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bK2MBN7Bck6CU3mVVxXf2LyNEG9ODqZtCEEFvM0sdz2EmWZxxzjErswoci05IThSfKUraIISKH01baXNy6ND4L6mkN/umK4FY3HcnhIZ75qwj8wu/kN0B9NFk9pjJgByBZirKsMtChVipUFZkMLbFo7RgfOaa9qcI/UO8ImBvUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvLK27Rm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvLK27Rm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9140BC2BCB7;
	Thu, 14 May 2026 05:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778735528;
	bh=N2hOzLJhPj7YZe6+GM52kP0ytRVzomLb6qq7ROjeUho=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=IvLK27RmxqS8q3qdP7ItV01ww+ZKinYoRptfi1081+F7cgWpoqhsyn4B18zVJEOS4
	 LWwkOG0+Q8oG2uErBX+AtYsT60OKpv7/Bofwyf/4P8ACKfAFdK9KGrsfXpQuf2J08p
	 XvMB0b8waEjXQv3ZCadEeR6GhtvMP2L0IspakwDSEkMyfsHC76cHbgIdsdR6MQs+ly
	 +UuTrkIednELLJiqponRm5rpIJwuJZRJfT5ch17l00lMZYj2ksET4OqR+4+xm4bdJ3
	 2Wu27kfV4w7P1WgNMPEhiuvlbBsnZOYbE00ZSmfwPZ81pOL6CB3n4ZWisgV3XnHgyW
	 UWu6rY80sJKcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] perf/x86/intel/uncore: Fix uncore_box ref/unref
 ordering on CPU hotplug
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260512233048.9577-7-zide.chen@intel.com>
References: <20260512233048.9577-7-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 05:12:08 +0000
Message-Id: <20260514051208.9140BC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Swapping the order of `uncore_box_unref()` and `uncore_change_=
context()` unmaps MMIO memory while perf events are still active on the off=
lining CPU, leading to a kernel panic.
--

commit c3109355d1e7c9f59ae1464588987b4aa4135388
Author: Zide Chen <zide.chen@intel.com>

perf/x86/intel/uncore: Fix uncore_box ref/unref ordering on CPU hotplug

This commit reorders the setup and teardown sequence in the uncore CPU
hotplug callbacks. It swaps the order of uncore_box_ref/unref and
uncore_change_context to ensure that the uncore box references the correct
context.

> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncor=
e.c
> index 4d31dcaf5405b..b9b901b789d15 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1555,9 +1555,15 @@ static int uncore_event_cpu_offline(unsigned int c=
pu)
>  {
>  	int die, target;
> =20
> +	/* Clear the references */
> +	die =3D topology_logical_die_id(cpu);
> +	uncore_box_unref(uncore_msr_uncores, die);
> +	uncore_box_unref(uncore_mmio_uncores, die);
> +

When uncore_box_unref() executes before uncore_change_context(), can this
cause a page fault if there are active events?

During CPU offline, the uncore teardown callback runs at state
CPUHP_AP_PERF_X86_UNCORE_ONLINE, which executes before the generic perf core
teardown at CPUHP_AP_PERF_ONLINE.

If the offlining CPU is the last CPU in the die, cpu_refcnt reaches 0 and
uncore_box_exit() is called immediately. For MMIO PMUs, this calls
uncore_mmio_exit_box(), which executes iounmap(box->io_addr).

Since uncore_change_context() is called later with target =3D -1, no event
migration happens, and the active uncore perf events stay attached to the
offlining CPU's context.

When teardown reaches CPUHP_AP_PERF_ONLINE, perf_event_exit_cpu_context()
runs to clean up remaining events on the dying CPU. It calls pmu->stop()
to disable the events.

Will uncore_pmu_event_stop() dereference the unmapped box->io_addr via
uncore_perf_event_update() and disable_event(), leading to a kernel panic?

Even if a later patch adds uncore_pmu_unregister() to uncore_box_unref(),
this registration is only skipped if die_refcnt > 0. On a multi-die system,
offlining all CPUs in a single die leaves die_refcnt > 0, so the PMU
unregistration is skipped and the panic could still occur.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512233048.9577=
-1-zide.chen@intel.com?part=3D6
