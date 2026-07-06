Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310C236C9EC
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jul 2026 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350675; cv=none; b=lmn/i4P/UP0oiYOJzxor40vHGI9Fqhp/JAggMrQwxYwUkLY9gYB2ffFWxRNIPvGCUNrS66+9pUWTsJ++SJOnCeUV+0sf7je8Ktc77IGYoKQLUCMP03bpJEL5II2E7Pf0r5pJJ5m1wzyPt9De5GBWEIbTx7gT2WhUlQmddaNZq0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350675; c=relaxed/simple;
	bh=t3OEBy2YzEGuuhS53lfXX7019bgkEiNZJnC1ASeul1w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mdiDO3abwhhfC2Re0YjerudQ6FbA8Yhj6wJhCqPzTnqC1Yt/F8NGJf0KbpjDRXuQFaxvHqklMmOlW0eYY2bNuWK/XCh5+6HJ8ONl3AHelxvBfR0MkRzFD1G/ywVgfpGHFlJ/m4ddabAqVNo3C7m226rXnGqmGkgwYpAGU/8pyDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzRymNZF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzRymNZF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEC91F000E9;
	Mon,  6 Jul 2026 15:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783350673;
	bh=//20w4blUXZE/skshLW2T5QRYomiLHqmI0sIsKNJiVY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mzRymNZFSDm4W6v2UDAJTf6A8+cHvRKHtu/Bkqr2uylWV9wfZEySiWteCQ/j1F6bh
	 Dmyya5OGtWCc9nKV3+1GtoBpfLFL0a0kStqXYcKTKE0NP+m68UloFnBsbkBvceKLVA
	 yiDU8Gt+U2tf+sIBpIxmPLguuJ9V4yh0rFxRcywZnQF1Tw8BxVcF2DlU+nfdX33BIF
	 vZamXUbikE7EuoFh+RCsGHJeeT20eJJaW/zcspQyXkMpL25A4IP44Eg4PJzi/V047o
	 BHRUoXL43XnYHp1TSq7gY0f3QxXje/41qUOwY3KJF3AuTmburSwlTBVkmOgtHrfbQL
	 ZjiJI8XAiJJmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drivers/perf: thunderx2_pmu: add error handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <2026070635-feel-joyride-6d5b@gregkh>
References: <2026070635-feel-joyride-6d5b@gregkh>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 15:11:13 +0000
Message-Id: <20260706151113.7DEC91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing unregistration on error paths during PMU addition and devi=
ce probe leads to Use-After-Free of PMU and hotplug structures.
--

commit bfe9572d37443a1d40e13a34014a4451ab6d0e17
Author: Griffin Kroah-Hartman <griffin@kroah.com>

drivers/perf: thunderx2_pmu: add error handling

This commit adds missing error checks for devm_kasprintf() in
tx2_uncore_pmu_register() and tx2_uncore_pmu_init_dev(). It also centralizes
the error cleanup in tx2_uncore_pmu_init_dev() using a goto err pattern.

> diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
> index 6ed4707bd6bb5..1a6aa94a3efb9 100644
> --- a/drivers/perf/thunderx2_pmu.c
> +++ b/drivers/perf/thunderx2_pmu.c
> @@ -738,6 +738,8 @@ static int tx2_uncore_pmu_register(
> =20
>  	tx2_pmu->pmu.name =3D devm_kasprintf(dev, GFP_KERNEL,
>  			"%s", name);
> +	if (!tx2_pmu->pmu.name)
> +		return -ENOMEM;
> =20
>  	return perf_pmu_register(&tx2_pmu->pmu, tx2_pmu->pmu.name, -1);
>  }

[ ... ]

> @@ -866,17 +872,21 @@ static struct tx2_uncore_pmu *tx2_uncore_pmu_init_d=
ev(struct device *dev,
>  		tx2_pmu->attr_groups =3D ccpi2_pmu_attr_groups;
>  		tx2_pmu->name =3D devm_kasprintf(dev, GFP_KERNEL,
>  				"uncore_ccpi2_%d", tx2_pmu->node);
> +		if (!tx2_pmu->name)
> +			goto err;
>  		tx2_pmu->init_cntr_base =3D init_cntr_base_ccpi2;
>  		tx2_pmu->start_event =3D uncore_start_event_ccpi2;
>  		tx2_pmu->stop_event =3D uncore_stop_event_ccpi2;
>  		tx2_pmu->hrtimer_callback =3D NULL;
>  		break;
>  	case PMU_TYPE_INVALID:
> -		devm_kfree(dev, tx2_pmu);
> -		return NULL;
> +		goto err;
>  	}
> =20
>  	return tx2_pmu;
> +err:
> +	devm_kfree(dev, tx2_pmu);
> +	return NULL;
>  }

[Severity: High]
This is a pre-existing issue, but looking at how error paths are handled,
could these new error returns lead to a use-after-free in the perf core or
CPU hotplug core?

If cpuhp_state_add_instance() fails in tx2_uncore_pmu_add_dev(), it returns
an error without calling perf_pmu_unregister() for the PMU that was just
registered:

	ret =3D tx2_uncore_pmu_register(tx2_pmu);
	if (ret) {
...
	}

	ret =3D cpuhp_state_add_instance(
			CPUHP_AP_PERF_ARM_CAVIUM_TX2_UNCORE_ONLINE,
			&tx2_pmu->hpnode);
	if (ret) {
		dev_err(tx2_pmu->dev, "Error %d registering hotplug", ret);
		return ret;
	}

Additionally, if devm_kasprintf() fails and returns NULL here,
tx2_uncore_pmu_add() will return AE_ERROR. This causes acpi_walk_namespace()
in tx2_uncore_probe() to fail and abort the probe:

	status =3D acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
				     tx2_uncore_pmu_add,
				     NULL, dev, NULL);
	if (ACPI_FAILURE(status)) {
		dev_err(dev, "failed to probe PMU devices\n");
		return_ACPI_STATUS(status);
	}

Since tx2_uncore_probe() aborts with an error, the driver core will free
all devm_ allocated memory. Are the PMUs that were successfully added in
previous iterations of acpi_walk_namespace() unregistered before the memory
is freed, or will this leave dangling pointers in the core kernel subsystem=
s?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026070635-feel-joy=
ride-6d5b@gregkh?part=3D1
