Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D653E4C69
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 08:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784277192; cv=none; b=fkWpPG40OsA5G1BKFQmgcnLiJl2bHZN9VpuvfbuEEXUciT2SVvOO/plAs5+HqrvuGdG8XeFeG7zMaZbYMiFMzPSoSRY2sut51Esw86H7ew5Z9S2WjIIXe/TEVRGDKmErXWslUJLGIVSbQztRbNxH4Vf85Ved+9W0+NtyelvJ3qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784277192; c=relaxed/simple;
	bh=gVYfqEbbuL6SwrWqA+urvpB+gOSskxsUYb5GrqRCVqk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TSQnzWArthLvus+e1mHw9dnxI0siJ2PY79sAfdwyGoMs0FSFHlXo+0H2d2ateSuEdCsQU11FRnvVpYOZgmxOprSzD9xScLACtxAGRaU+NShL4VFSSdLKl99jRdZlxJKyYbQlk8QVdc7yxf1DYW3xuAzzjeKBFfof/rSF3szGryk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjsTHjYQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjsTHjYQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B551F00A3A;
	Fri, 17 Jul 2026 08:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784277190;
	bh=9F8ErgPgFq33bN4RdsKr/b8x82RI0Jd2+MOwtalzWBU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IjsTHjYQ6yfDhiM10twCaHidJcw2Yu+v+vZZiIua0bqM9WaN0uHRPMlOk0kzw66qw
	 iXWeTt7qKLDEAXo3d51SEfb8iCfjy03O2dVtsAnn/ghzAqw1rnxcM7aUG5n8bEj5hQ
	 oinMx6Uasezqn5Vg04nHh5SYk5krlC0h5Vt07bfsfsVmXyiKZjLCoxIBind/Q0yl5s
	 D/KFW6HkALfMucXQgtOX05is5cTrdGAdEyj5W0tqinqEEq0TK5j6FJqy/PaBjUYXpW
	 x5l9uoZfMtvzTUgdzXohk5ZgBqa3867A5B3dqL13AVX0MNJ2WQxaloNobuUMaT2Tla
	 09t1Q5+GElj0g==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v3 1/8] perf/x86: Unregister PMI handler on PMU init
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260717080342.1879573-2-dapeng1.mi@linux.intel.com>
References: <20260717080342.1879573-1-dapeng1.mi@linux.intel.com>
 <20260717080342.1879573-2-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 08:33:09 +0000
Message-Id: <20260717083310.79B551F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pre-existing Use-After-Free window for `cpuc->pmu` if `perf_pmu_re=
gister()` fails on hybrid systems.
--

--- Patch [1]: [Patch v3 1/8] perf/x86: Unregister PMI handler on PMU init =
failure ---
commit 841a0ed2adb8a95774faf3b5508e90fdd97d9135
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86: Unregister PMI handler on PMU init failure

This commit fixes an NMI handler leak in init_hw_perf_events() by unregiste=
ring
the NMI handler when PMU initialization fails before clearing the x86_pmu s=
tate.

> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index af0b67ffb43d8..872d07a5fa80d 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
[ ... ]
> @@ -2273,6 +2273,8 @@ static int __init init_hw_perf_events(void)
>  	cpuhp_remove_state(CPUHP_AP_PERF_X86_STARTING);
>  out:
>  	cpuhp_remove_state(CPUHP_PERF_X86_PREPARE);
> +pmi_unregister:
> +	unregister_nmi_handler(NMI_LOCAL, "PMI");
>  out_bad_pmu:

[Severity: High]
This is a pre-existing issue, but does this error path leave a dangling
pointer that could lead to a Use-After-Free?

On hybrid systems, if perf_pmu_register() fails, the error path frees the
x86_pmu.hybrid_pmu structures. However, CPUHP_AP_PERF_X86_STARTING was alre=
ady
set up, so cpuc->pmu on all online CPUs was initialized to point to these
now-freed structures.

The CPU hotplug state rollback doesn't set cpuc->pmu back to NULL. Since
x86_pmu_static_call_update() has already routed x86_pmu_guest_get_msrs to
intel_guest_get_msrs(), and the perf_is_hybrid static key remains enabled,
could a subsequent KVM guest launch trigger a UAF?

When KVM calls perf_guest_get_msrs(), it jumps to intel_guest_get_msrs(),
which unconditionally dereferences the dangling cpuc->pmu pointer:

arch/x86/events/intel/core.c:intel_guest_get_msrs() {
    ...
    u64 intel_ctrl =3D hybrid(cpuc->pmu, intel_ctrl);
    ...
}

>  	memset(&x86_pmu, 0, sizeof(x86_pmu));
>  	return err;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717080342.1879=
573-1-dapeng1.mi@linux.intel.com?part=3D1
