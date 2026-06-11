Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2118440BCB3
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195347; cv=none; b=huFkjEOxCV8qkfiatpZW8LAb0MZ7owwELTTAGMxtUtA9fh5/3VJEAGgaP6YopdInw/P31SvWZmEAwxG6WdC+eibAhEXskQv26MD9fQo6Zl9PZooPMDSDXe9XsOkz4D6TIBWF+Y8BZD7rqrk7q/50PC32iLE68IOQAfr5vpUK3Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195347; c=relaxed/simple;
	bh=qJbbg+GhLnIwHkdAinV5paNXhJC5UDXjr/M5LX35KQ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MmnLLx9T64BiDoWSpCesc90rHKP7jzQBDADqPOqJUHE5zx1FzrMNg4IoV95QMGs9uR4R0SrtJmXXKyX2NGGrn+7nukwtvrADyYeVOboMb59jOlACyj1Et3f6o6Xya3hPWwGMnXaL9bgp6IaTouRsJmraky6j25+bYNeEvVJ4bxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9plOL4P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9plOL4P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DAD51F00898;
	Thu, 11 Jun 2026 16:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781195345;
	bh=6w2uPnLJlC88osUEkMicAy143uPfN9+69yHzFF9vZuQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X9plOL4Pzbx3NbKMxd1BbhhLlujnjlyXKbvZ043FqIGVJxitpgUEpMAIK649oFshp
	 8IFu7pFNrDm+a1N6kwF5J/FVQEIRcGuSjm5EFLG9Zljmgi9wGDTIbh8fT3bEZJcs22
	 63o5cG//k97Az0Yju0Qkqc1P69kTcTTVnt1DV/tHDL22oZbggBKFoetxyJDyFed9R5
	 Y86oNyuQ5UD7HluL7Rp5VZi9LHuaHCae4wRcjWo0l8jMpMfeHvuKsq6ejR0G+Lq2UZ
	 8a946aHCgUdqltWkZ8hhQYecjHoqW+patX/2LKPB70tvvGT+hOzbtDZU+mEZNmLhRD
	 8s5ic/qTipk1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 2/8] perf/x86/intel/uncore: Fix refcnt and other
 cleanups
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260611160033.66760-3-zide.chen@intel.com>
References: <20260611160033.66760-3-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 16:29:04 +0000
Message-Id: <20260611162905.6DAD51F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free of uncore_box via active perf events and hrtimers a=
fter PCI PMU unregistration
- [High] Lockless race condition on `activeboxes` leading to concurrent per=
f PMU register/unregister
- [High] Missing memory barrier when publishing `box` allowing readers to o=
bserve partially initialized memory
- [High] Use-After-Free race between CPU hotplug context migration and PCI =
PMU unregistration
--

commit 372caa30bbc8374ec4e96cf8e02d24ffa69fe538
Author: Zide Chen <zide.chen@intel.com>
Subject: perf/x86/intel/uncore: Fix refcnt and other cleanups

This commit fixes a typo for the initialized flag and renames the 'id'
parameter to 'die' in uncore_box_{ref,unref}. It also adds reference
counting decrement logic in the PCI PMU unregister path to properly
clean up the uncore box.

> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncor=
e.c
> index b69b6a21d46bf..21c8ed1628cb2 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1255,8 +1255,10 @@ static void uncore_pci_pmu_unregister(struct intel=
_uncore_pmu *pmu, int die)
>  	pmu->boxes[die] =3D NULL;
>  	if (atomic_dec_return(&pmu->activeboxes) =3D=3D 0)
>  		uncore_pmu_unregister(pmu);

[Severity: High]
This is a pre-existing issue, but does this lockless decrement of activebox=
es
create a race condition with concurrent PMU registrations?

If Thread A (unregistering die 0) and Thread B (registering die 1) run
concurrently, Thread A might decrement activeboxes from 1 to 0 here, while
Thread B increments it from 0 to 1 in uncore_pci_pmu_register().

Both threads could then concurrently invoke uncore_pmu_unregister(pmu) and
perf_pmu_register(&pmu->pmu) on the exact same struct pmu object, potential=
ly
corrupting the internal perf core PMU lists.

> -	uncore_box_exit(box);
> -	kfree(box);
> +	if (atomic_dec_return(&box->refcnt) =3D=3D 0) {
> +		uncore_box_exit(box);
> +		kfree(box);
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but does freeing the box here
leave dangling pointers in active perf events or hrtimers?

The perf core doesn't actively detach or destroy open events when the
underlying device is removed. If other dies still have this PMU active,
uncore_pmu_unregister(pmu) is bypassed.

Any armed hrtimer firing asynchronously in uncore_pmu_hrtimer() or userspace
reads invoking uncore_pmu_event_read() would then dereference the freed box
memory, leading to a use-after-free.

[Severity: High]
This is a pre-existing issue, but could this kfree(box) also race with CPU
hotplug context migration?

During CPU hotplug, uncore_change_type_ctx() iterates over pmu->boxes[die]
to migrate perf contexts. It fetches the box pointer and subsequently
accesses it (e.g., reading box->cpu or calling
uncore_pmu_cancel_hrtimer(box)).

If a PCI device removal executes uncore_pci_pmu_unregister() concurrently,
it nullifies pmu->boxes[die] and frees the box here.

If the hotplug thread reads the pointer before it is set to NULL but access=
es
it after the memory is freed, it could result in a use-after-free.

[Severity: High]
This isn't a bug introduced by this patch, but is there a missing memory
barrier when publishing the box pointer during allocation?

In uncore_pci_pmu_register(), a newly allocated box is published to
pmu->boxes[die] using a plain store, lacking an smp_store_release().

Concurrently, a user opening a perf event triggers uncore_pmu_event_init(),
which looks up the box via uncore_pmu_to_box() using a plain load. Due to
CPU reordering, the reader may observe the non-NULL box pointer but read a
stale, uninitialized memory state (such as box->cpu =3D=3D 0 instead of -1).

This would bypass the if (!box || box->cpu < 0) safety check and allow
the perf core to operate on partially initialized memory.

>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611160033.6676=
0-1-zide.chen@intel.com?part=3D2
