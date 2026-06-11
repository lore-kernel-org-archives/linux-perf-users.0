Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB3F43DA24
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195178; cv=none; b=TbZVCM25tx3cxJ/0Vq3AUKO3bYJQH6ipTuipRsQjp3qbXHA+14dFzGLRr3xMgaUvHAZsvthl2sgZsyPti6zGzG0gauuqv3gno73lX0tuzC3fGAlfTBtDgK5600BfPS8C20H2uZscM8ORLyL4JMe6+REAy5X03/qKSo8AUBYUbKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195178; c=relaxed/simple;
	bh=2BDAtTaxU+4cMvU6VbMcRg7wjdJkWqDB0+a88316PMo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TxeSQY6qyRFsC1ep8eTUfIQlXXTIxhVK5u24pJ3Rcal3NjGUIVGG5JiqhFi+As7u+pmWrCApBQ9TeC4OTltS0aXYyQV1mLR/uQnstwKsINFsoy/ZYQXr216IIxm0BqDHIMio7cWMvz6+0ePOoNJRe57icqeNnSIUy56frDzUYTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOM2f74p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOM2f74p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA751F00893;
	Thu, 11 Jun 2026 16:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781195176;
	bh=NVPk92FtG5TwuqvqJwgYTVWq6MEciSRdLk4JZoPAxM4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZOM2f74plKFN+T71KpLg8jnuQsRKV9CpHNV4L1Q1Nja+Wzk/hF73RzuqIhKu3T1+Y
	 yOJSnvUpKLy7hwGzZYYB7IvQOurIK4aQARcJSssExT1A4PdtffINe78Jqo5+T1/gt3
	 vwHYNgRJEzGpB2hBlBM0q2QOR3XFmVAfurKnSVTzYovIRHcX4NWjNUAi4bOZCuOB6n
	 AbAn8Xp6tKYEXyZVoBfRufbOEwkDmAej66/q45mznRpV4XMAk+EKBWQ0rHzTpEHji9
	 4a0X/ZTFVvSVJKOGUouiE6KRa/2L0Fvz5lLuQxoAUhb42GLl1dmGUP9hsxOmezp74n
	 TljdMF2jPa8vA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 1/8] perf/x86/intel/uncore: Fix PCI PMU cleanup on
 setup failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260611160033.66760-2-zide.chen@intel.com>
References: <20260611160033.66760-2-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 16:26:16 +0000
Message-Id: <20260611162616.6DA751F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Unjustified removal of `WARN_ON_ONCE` safety check based on a mi=
sunderstanding of the Linux device model.

Pre-existing issues:
- [High] Active perf events will dereference a freed `intel_uncore_box` whe=
n a PCI device is forcefully unbound.
- [High] Lockless update of `pmu->boxes[die]` in PCI probe/remove paths rac=
es with CPU hotplug callbacks, leading to Use-After-Free.
--

commit 1ebe3c291f253a0ba73f6277fd61a8e1138e1725
Author: Zide Chen <zide.chen@intel.com>
perf/x86/intel/uncore: Fix PCI PMU cleanup on setup failure

This commit attempts to fix a cleanup issue when uncore_pci_pmu_register()
fails by explicitly managing pmu->boxes[die] and activeboxes. It also remov=
es
a WARN_ON_ONCE() under the assumption that a NULL driver data pointer could
result from a registration failure during probe.

Link: https://sashiko.dev/#/patchset/20260512233048.9577-1-zide.chen@intel.=
com?part=3D1

> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncor=
e.c
> index 7857959c6e823..b69b6a21d46bf 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c

[ ... ]

> @@ -1248,6 +1249,9 @@ static void uncore_pci_pmu_unregister(struct intel_=
uncore_pmu *pmu, int die)
>  {
>  	struct intel_uncore_box *box =3D pmu->boxes[die];
> =20
> +	if (!box)
> +		return;
> +
>  	pmu->boxes[die] =3D NULL;
>  	if (atomic_dec_return(&pmu->activeboxes) =3D=3D 0)
>  		uncore_pmu_unregister(pmu);

[Severity: High]
This is a pre-existing issue, but when a PCI device is forcefully unbound,
does unconditionally freeing the box memory here lead to a use-after-free if
there are active perf events?

If active perf events are currently open for this PMU, the perf core retains
them. Subsequent perf operations will dereference the freed memory:

uncore_pmu_event_read() {
    struct intel_uncore_box *box =3D uncore_event_to_box(event);
    uncore_perf_event_update(box, event);
    ...
}

[Severity: High]
This is also a pre-existing issue, but is there a race condition between
setting pmu->boxes[die] to NULL here and concurrent CPU hotplug callbacks?

CPU hotplug callbacks run under cpus_read_lock(), but PCI bind/unbind
operations can execute concurrently without it. If a CPU hotplug event reads
the box right before it is cleared:

CPU1
uncore_change_type_ctx()
    box =3D pmu->boxes[die];

CPU2 would then execute uncore_pci_pmu_unregister():
    pmu->boxes[die] =3D NULL;
    ...
    kfree(box);

Would CPU1 then dereference the freed box memory when it subsequently acces=
ses
box->cpu?

[ ... ]

> @@ -1272,7 +1276,6 @@ static void uncore_pci_remove(struct pci_dev *pdev)
>  				break;
>  			}
>  		}
> -		WARN_ON_ONCE(i >=3D UNCORE_EXTRA_PCI_DEV_MAX);
>  		return;
>  	}

[Severity: Medium]
The commit message states that since pci_get_drvdata() returns NULL on
registration failure, uncore_pci_remove() can no longer treat NULL drvdata =
as
an indicator of an auxiliary PCI device. Is this assumption accurate?

If PMU registration fails during uncore_pci_probe(), the probe function
returns an error code. The PCI driver core responds by aborting the bind
process and will never invoke the driver's remove callback for that device.

Because uncore_pci_remove() is never called as a result of a registration
failure, does removing this check silently mask bugs where a successfully
bound primary device unexpectedly loses its driver data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611160033.6676=
0-1-zide.chen@intel.com?part=3D1
