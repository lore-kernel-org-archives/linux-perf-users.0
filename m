Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6811531C8
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 00:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778720290; cv=none; b=lcxa4pI43iJvvUflfn25yRalV4cwOV3J1wBHfeCrVCbK7Y0avcc4Kbe7LFl79y57rQUqJT3vQOnm4JQt8J7sG9wDP+XZids1XD6QkJaHTVMb7UPiyBB/hc4QgBWcF1GGEPypGH4UvDUxBkJ7ou0uESIQ9INw4aIijA2yb/rrfk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778720290; c=relaxed/simple;
	bh=Rw1ZYh2s5YV7uTtWUn+PIMnfiHPfdexI5oxA9GbXFNE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IbTiisIgIdAtMR9ltHUkEvwygxQBZ8JVYBuhUSPb7fMFB+o7Ay2O9NZvOzWEcxFa/7Dyrtn1zyzOGLTde6xYovtEepuEuqgwFfFINroAUrxKa/hOl9zr39Y7CG1eYVCrwgVvGKQf4WnGJU7+NXBSH5Xx0j7ELCJOEwd12SPOVTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OU180hws; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OU180hws"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D0CC19425;
	Thu, 14 May 2026 00:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778720290;
	bh=Rw1ZYh2s5YV7uTtWUn+PIMnfiHPfdexI5oxA9GbXFNE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=OU180hwsB/92ji/Q3mp4XXekkrMpyU0C/Ifzcn9k458QdjDI3TxMBRpL2R2njKdx7
	 9/MLXGzTg1daqzM47Sl3Mpq26DcChywPyNFxSqYrhE/ft6INBiRcKhmxJpq6ypaqOT
	 Y7HJqfI2JGMcq7OPLIIPeEu+nGdNYyww+newea0dWzn9OtGcan527KfGOcWn0SvcAB
	 Ls7TMLRxLdXBTHi+rdS0AJwJ6LM82onqqVanlSo38YbX0beK4pXMougCkAzcMHFUwD
	 zUEnxmZNnbRvd5UGEkez5KaZVsATYq+UrbQ8ZAY7v6MUdCrMc+BZONAFloRw/cYDKu
	 Y4j899NaFbEEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] perf/x86/intel/uncore: Rename refcount fields and
 other cleanups
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260512233048.9577-2-zide.chen@intel.com>
References: <20260512233048.9577-2-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 00:58:09 +0000
Message-Id: <20260514005809.D4D0CC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] NULL Pointer Dereference in `uncore_pci_pmu_unregister()` when dev=
ice registration fails.
- [High] NULL Pointer Dereference (previously reported as UAF) during perf =
event operations if a PCI device is removed while events are active.
--

commit 247a617f910d49e9f19af35d0216a5b938d9d034
Author: Zide Chen <zide.chen@intel.com>

perf/x86/intel/uncore: Rename refcount fields and other cleanups

This commit renames several fields and parameters in the intel uncore PMU
driver to clarify their purpose, such as activeboxes to die_refcnt and
box->refcnt to box->cpu_refcnt. It also fixes a typo and removes an
incorrect refcount increment.

> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncor=
e.c
> index e9cc1ba921c5e..e200f4744eb9b 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c

[ ... ]

> @@ -1230,7 +1229,7 @@ static void uncore_pci_pmu_unregister(struct intel_=
uncore_pmu *pmu, int die)
>  	struct intel_uncore_box *box =3D pmu->boxes[die];
> =20
>  	pmu->boxes[die] =3D NULL;
> -	if (atomic_dec_return(&pmu->activeboxes) =3D=3D 0)
> +	if (atomic_dec_return(&pmu->die_refcnt) =3D=3D 0)
>  		uncore_pmu_unregister(pmu);
>  	uncore_box_exit(box);

While reviewing these unregistration changes, I noticed a pre-existing issue
here.

If PMU registration fails during PCI device probe, uncore_pci_pmu_register()
frees the box and sets pmu->boxes[die] =3D NULL.

Later, when the device is removed, the bus notifier calls
uncore_pci_pmu_unregister() which fetches the NULL box:

    struct intel_uncore_box *box =3D pmu->boxes[die];

and passes it to uncore_box_exit(box).

Since uncore_box_exit() does not check for NULL before testing box->flags:

static inline void uncore_box_exit(struct intel_uncore_box *box)
{
        if (test_and_clear_bit(UNCORE_BOX_FLAG_INITIALIZED, &box->flags)) {

Does this sequence result in a NULL pointer dereference?

Additionally, if a PCI device is removed while perf events are still active
on its CPU, this function sets pmu->boxes[die] =3D NULL and frees the box.

If other dies still have boxes present, die_refcnt will be greater than zero
and uncore_pmu_unregister(pmu) is bypassed.

Could this leave active events scheduled in the perf subsystem?

If the perf subsystem later attempts to read or stop the event,
uncore_event_to_box() would return NULL. Would subsequent calls like
uncore_perf_event_update() or accesses to box->n_active then trigger a NULL
pointer dereference when operating on the missing box?

>  	kfree(box);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512233048.9577=
-1-zide.chen@intel.com?part=3D1
