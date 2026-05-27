Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A196C3F164D;
	Wed, 27 May 2026 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779900817; cv=none; b=XFyu9gQgea5OBpftwNzquwMG5YS0LUjS9rx7MgV+S+K5KIYThTY0OVw1ed/7qr9ClYhqjvOoWODNNS9q3UNBo73kmkvnJdBPb+r3hup9Py2G81f97An25N8UedTSnaDmlNJJl0OkrpFYOt/h6hjUGXzY6DfQlve/LlLZ3ulHnI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779900817; c=relaxed/simple;
	bh=rRqyvJfHs8n1tE/OfXST04kLa/4UKsV0mDX8EGPbOuY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P+FDQr6VpbkRh0RENlqH9t34F9C9NAZuagGjJLoqyRdU7z+byVLOJqKWhI0IEMAyFXVJFpxSzKyuIMFloazE8pjDSxTLN8EEJqXegW4PvFeZahqAITRi/NsImcWeamd2j1hrra+3BVsv4rDyAW01Vi+mePE7bF4xblbc5TZOvWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0hPoM2j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0hPoM2j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50F11F000E9;
	Wed, 27 May 2026 16:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779900814;
	bh=eo/+7L8mF01Yjie7mzgiNCrnqacT5ORoW57yVAEacLw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L0hPoM2jdXbxZUHRZl7xnlIpqAxDK2EHfCEOOXrU7g89/i/ezMgehh9fA2WnK3+b+
	 ysYzDYzAE+uohN0DMvqjK7VvraUYKslEq6jzAxdDe52KIOohyGliep6xu8vkwjmXUz
	 ETO0+9tVKHIJyYMGJk+sVb5mZl3QeZWyK/0c+NTCFqQy3qld8phqrdWyzOkcqpKdvA
	 I+0WogCZEcYnwu2Ngs5NzVNvLJvwZ1QYkSR5o7oFLkrn3OPzsMV1vW0plUZ5V+YOvA
	 1IMofFeDSKT+UestqS5xcCNdo0yZi6O+JzmLyGsmHfwZyEZnhG6eHF+xvWoVBGdBpa
	 pcH+NjGv3YZ7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/2] perf: marvell: Add CN20K DDR PMU support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geetha sowjanya" <gakula@marvell.com>
Cc: conor+dt@kernel.org, linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260527154118.12884-3-gakula@marvell.com>
References: <20260527154118.12884-3-gakula@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 16:53:32 +0000
Message-Id: <20260527165333.B50F11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The PMU driver unregisters the PMU but fails to cancel the hrtimer=
 during device removal, leading to a Use-After-Free when the device memory =
is freed.
--

commit d18b18c0fd01da6bd683596bdd96464d25ed18a9
Author: Geetha sowjanya <gakula@marvell.com>

perf: marvell: Add CN20K DDR PMU support

The CN20K DRAM Subsystem exposes performance counters for DDR traffic.
This commit adds CN20K register offsets, event maps, and sysfs attributes,
and matches the device via OF and ACPI. Platform data is updated to use
silicon flags to reuse the CN10K PMU code path.

> diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_=
cn10k_ddr_pmu.c
> index 72ac17efd846a..6f638dfe829b8 100644
> --- a/drivers/perf/marvell_cn10k_ddr_pmu.c
> +++ b/drivers/perf/marvell_cn10k_ddr_pmu.c

[ ... ]

> @@ -1098,6 +1294,7 @@ static void cn10k_ddr_perf_remove(struct platform_d=
evice *pdev)

[Severity: High]
This is a pre-existing issue, but does this function need to cancel the
hrtimer before returning?

Looking at how the driver manages memory, struct cn10k_ddr_pmu is allocated
with devm_kzalloc() in cn10k_ddr_perf_probe(). This means the memory will be
automatically freed by devres immediately after cn10k_ddr_perf_remove()
finishes.

If the device is unbound via sysfs while a perf event is still active, the
hrtimer could still be running or queued. Because perf_pmu_unregister() does
not stop the PMU's internal timers, would the timer callback
(cn10k_ddr_pmu_timer_handler) execute after the devres cleanup and cause a
use-after-free on the freed ddr_pmu structure?

Could we add hrtimer_cancel(&ddr_pmu->hrtimer) to cn10k_ddr_perf_remove()
to prevent this?

>  #ifdef CONFIG_OF
>  static const struct of_device_id cn10k_ddr_pmu_of_match[] =3D {
>  	{ .compatible =3D "marvell,cn10k-ddr-pmu", .data =3D &cn10k_ddr_pmu_pda=
ta },
> +	{ .compatible =3D "marvell,cn20k-ddr-pmu", .data =3D &cn20k_ddr_pmu_pda=
ta },
>  	{ },
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527154118.1288=
4-1-gakula@marvell.com?part=3D2
