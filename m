Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D975218B5
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 19:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791918680; cv=none; b=W9pSduZua4Sdue7jagz4BibSrg6u9v/v1FvNiv6wxTnN7sX8hNkKEg9hQDhhtcXgeRtCmsMotdDw8qam/vNRahtUQbN20VCp6iaZbYSxWrgaHhUmA1I85TwRW6IZcpluJQpOXVFPjbXdeC7Nb3miXf/ugnMDxJKT1+bl8QOYKiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791918680; c=relaxed/simple;
	bh=+toy0k7Z7E05lVtAvpulsZZ9KRUGedYQ7S/9yclBQoY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=HI4wxu8mpMJM82y4QLozXgINtbfmwOd8c0mvWEKJO4VIs1AQ7uL4DGDT2FaX40kW/vAdpPx+LmRuRqN/13BlNyFZYh/77mmXYRnB77C2Qu08n7q7XDinEid4reoiiLUfO7n/jkD2vQjX4RWzl9Xb8q12301Gep1cLjz8Uaj+aDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddedhE3P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddedhE3P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A921F000FF;
	Tue, 13 Oct 2026 19:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791918678;
	bh=DfdjgAfKxpfvZbV65xIAbgnrJBf7OgwnaoJsSiP/qBo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ddedhE3PpQe2MORHrkEf8wq1aurQ8ryBJfSbvi1zSkjIXZD7S8sqAAASn5dhAIRoL
	 b6RI8+dO/Via37F9aDbEYINB0dkaV5tyzU2ORUV9Y3WZvLt/FIEBSkbQt+m2LDZSYl
	 97IIqod5uTMivzwxBtevxA6unOS8xatAgE+6J2poWb0IoiXTBk2XATY+c5F9j16Ogb
	 rJAZRKykWPHDe6J/l8+JRkEuEdoskk1RvxsPdLRbIi3VTF5FADjo1Et9bgDUdpoHo2
	 1hioSSo4eIjND5hlJurfpz1ACwxbL2/m/4E4swQ6PIGwrDPcWgxQ4kI7a2gMvPLlSW
	 kjMmHfteElhYA==
Message-ID: <sashiko-outbox-170381@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] perf/core: Add PERF_PMU_SCOPE_DEVICE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haris Okanovic" <harisokn@amazon.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013185603.1347265-3-harisokn@amazon.com>
References: <20261013185603.1347265-1-harisokn@amazon.com>
 <20261013185603.1347265-3-harisokn@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 19:11:17 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] perf: WARN_ON_ONCE DoS during CPU hotplug for restricted device PM=
Us
- [Low] perf: spurious -ENODEV instead of -EBUSY during PMU migration
--

commit 97f2867d7b192326f20b5dc11e93789631bd5a2f
Author: Haris Okanovic <harisokn@amazon.com>

perf/core: Add PERF_PMU_SCOPE_DEVICE

Add a "device" pmu::scope for PMUs counted on a single CPU drawn
from a driver-supplied set instead of a fixed topology.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index dacc7375506a7..6274fea465a38 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
[ ... ]
> @@ -14109,6 +14216,12 @@ SYSCALL_DEFINE5(perf_event_open,
>  		}
>  	}
> =20
> +	/* The PMU may have moved since it was picked, retry if so. */
> +	if (perf_event_pmu_moved(event)) {
> +		err =3D -EBUSY;
> +		goto err_locked;
> +	}
> +

[Severity: Low]
During a PMU migration caused by a CPU hotplug, a concurrent
sys_perf_event_open() could see cpuctx->online =3D=3D 0. Does the existing
check for !cpuctx->online (which returns -ENODEV) eclipse this new
perf_event_pmu_moved() check, breaking the intent to return -EBUSY?

[ ... ]
> @@ -14406,6 +14519,12 @@ perf_event_create_kernel_counter(struct perf_eve=
nt_attr *attr, int cpu,
>  		}
>  	}
> =20
> +	/* The PMU may have moved since it was picked, retry if so. */
> +	if (perf_event_pmu_moved(event)) {
> +		err =3D -EBUSY;
> +		goto err_pmu_ctx;
> +	}
> +

[Severity: Low]
Similarly, does the !cpuctx->online check in perf_event_create_kernel_count=
er()
hide the -EBUSY return path when a PMU migrates due to CPU hotplug?

[ ... ]
> @@ -15202,6 +15322,36 @@ static void perf_swevent_init_cpu(unsigned int c=
pu)
>  	mutex_unlock(&swhash->hlist_mutex);
>  }
> =20
> +static void perf_pmu_rebind(struct pmu *pmu)
> +{
> +	int ret;
> +
> +	/*
> +	 * An empty mask legitimately happens for the last CPU in the
> +	 * perf_reboot() teardown, when there is nothing left to migrate to.
> +	 */
> +	if (cpumask_empty(perf_online_mask))
> +		return;
> +
> +	/* Failing to pick out of every online CPU is a PMU bug. */
> +	ret =3D perf_pmu_set_cpu(pmu, perf_online_mask);
> +	WARN_ON_ONCE(ret);
> +}

[Severity: High]
If a device PMU implements filter_allowed_cpus() to restrict its valid exec=
ution
CPUs, and a user hot-unplugs all of those restricted CPUs while keeping at =
least
one other system CPU online, perf_pmu_set_cpu() accurately returns -ENODEV.
Will this legitimately return -ENODEV and trigger the WARN_ON_ONCE() in
perf_pmu_rebind(), leading to a denial of service if panic_on_warn is enabl=
ed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013185603.1347=
265-1-harisokn@amazon.com?part=3D2
