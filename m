Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978C3388377
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 16:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785945998; cv=none; b=Qs0MxJCR9+1HSz5LD34G+oDk8zJfBOA33auF1wypQMSb5rSniFSphEEaV9tfAHZSugppgAJxLjEnC0K15uG21m28dLPG9CdPEN/ApokpVf8SEo/9o0ffE8WvJYqjOdWU3OzgeGBroWbMRFuXdwL024GSScvjMOaoYqgQIzNluEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785945998; c=relaxed/simple;
	bh=PF97jYKD6H1BmcFpQJ5/KzdYb2OL9LIZ7FHdKnRnXW4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CfVqpwEEM0luzE9lbP1FOlDijwS4/prXKak/rSX4Zw8CKDm6gomDFnCSdCcIYAYGNFeDC8GWEJRwhl6Xs+sODLBtrsnFhfQzmPHoAisLsw70mhNDyQDdqo1I4/56qgoLBgmL3Bnk0zkxefhkuG19Od+JG/7XXEDfHqLQhcxGd2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQxWPy32; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQxWPy32"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E851F000E9;
	Wed,  5 Aug 2026 16:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785945997;
	bh=9oq45bl7B+Judo3B9mAo4w+SVBypbwii4B3omx10Cgc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MQxWPy32V4AEHuEx6FwHCMFZG8a4LEal9vR2BKY9TwEiaZTBhh+AwuVkZ1zYGqPaz
	 NmzZbIeqEZbjX2JeuABJb1PhOlSa4bQYjAHVi0ObKRauGzZ75/+HPJ4pgoO4o19w5y
	 KCSaG64ok7oAhksYPk+vvCvu7zwMk3D/guRUHz3iomAXtFhSSzxlw/aZ0XljfGgxVk
	 LVeM3/0ShgUgb74s5stcRM4K2OHQcAC9vjbO66GrIHVzPjLPgLv4HkFx2STTk0BXcq
	 ylPZ3Lg/UtGQTTZWJnqGRs0bNWaxBvk3mY2EBt8mHJthGG1tWFh8M+pzimmJhByguB
	 5cNoWFEJM8r6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/11] perf/cxl: Accept an overflow interrupt on MSI
 message number 0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260805155501.1294472-5-dave.jiang@intel.com>
References: <20260805155501.1294472-1-dave.jiang@intel.com>
 <20260805155501.1294472-5-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:06:36 +0000
Message-Id: <20260805160637.52E851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Modifying CPU affinity on a shared interrupt line alters the affin=
ity for all devices sharing the line.
--

--- Patch [4]: [PATCH v4 04/11] perf/cxl: Accept an overflow interrupt on M=
SI message number 0 ---
commit 54fa1d2700a4dd3fe1865a2f2f6744ccbafc3070
Author: Dave Jiang <dave.jiang@intel.com>
Subject: perf/cxl: Accept an overflow interrupt on MSI message number 0

cxl_pmu_probe() rejects the PMU when info->irq <=3D 0, but at that point the
field still holds the MSI/MSI-X message number the device signals overflow
on, not a Linux virq. That number is 0-based, and -1 means no interrupt
support. Message number 0 is valid and pci_irq_vector() takes a 0-based
index, so a compliant device signalling on the first vector fails to probe.

Link: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.=
net?part=3D1

> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 40741e529d9b2..2bebbbe67a0a2 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -873,7 +873,7 @@ static int cxl_pmu_probe(struct device *dev)
>  		.capabilities =3D PERF_PMU_CAP_NO_EXCLUDE,
>  	};
> =20
> -	if (info->irq <=3D 0)
> +	if (info->irq < 0)
>  		return -EINVAL;
> =20
>  	rc =3D pci_irq_vector(pdev, info->irq);

[Severity: High]
This is a pre-existing issue, but I noticed the interrupt is requested as
shared in cxl_pmu_probe() and then its affinity is forcibly modified during
hotplug operations.

The interrupt is requested as a shared interrupt:

	rc =3D devm_request_irq(dev, irq, cxl_pmu_irq, IRQF_SHARED | IRQF_NO_THREA=
D,
			      irq_name, info);

But the CPU affinity is later altered directly in cxl_pmu_online_cpu():

	WARN_ON(irq_set_affinity(info->irq, cpumask_of(cpu)));

And similarly in cxl_pmu_offline_cpu():

	WARN_ON(irq_set_affinity(info->irq, cpumask_of(target)));

Does this cause issues for other devices sharing the interrupt line?

Modifying CPU affinity on a shared interrupt alters the affinity for all de=
vices
sharing the line, which could break CPU affinity expectations for other
endpoints and potentially cause performance degradation or incorrect behavi=
or.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805155501.1294=
472-1-dave.jiang@intel.com?part=3D4
