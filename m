Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1226B22D7A9
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 16:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946073; cv=none; b=kMaIxBcy9S7E5ysIqvoIthtgyCL5A3dSkke0hVLyeOhcsb5vASPlq2MDXyyfFlLScK4GE8risvyg3e7xDibyx99GG/cJQ+3kgIl/n//R7tpRY776AaNMxzgT2QhnwdeKk+mOqmdm0LKGLl63izZTcUlj/19YWXHjEbMhzFIWKRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946073; c=relaxed/simple;
	bh=KMj+T5YqjcKShCD408kECrHeeM5E2SOkYSCeRF4X2Uo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jZE1bq5e5VCfobxlOQ6yaUKnWRUHqkKW+FnICC1wE05jZ9IQplqYCQxbrGWlHpPBkPwsEDcogA/rLSLYml6XtTJR5IMzg5i25yP+Gl8nOGUIsWtTNcwMujVMthh/JJ4F6XdvZkHBs5s23I4pLXKWDdi9bADXyAkRyt3YqyJ0L3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbFiSbfJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbFiSbfJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4DA1F00A3A;
	Wed,  5 Aug 2026 16:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785946069;
	bh=je8pJAuBGvsTsB63m1Co8UZzQm9jQP9Za0C3s6aRT+c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jbFiSbfJnoeMqtZsGSorCwZyAZflQUAMxuU5KTROiHA6B5wyQxBhDixgR7cmc13It
	 XldglZcg0Rh0sXDuZueftRgQSTG9LQnomqEdysBGoiEpq1N8Vlgk3FSaQeKVRbZKGY
	 RaKQ7M9hpWEb5itmOIjwWaLmx5FIYtmxq0xjtm0gSYciYvEbyIBUSV82/p2majIqBd
	 AKhR0Z78PQ6hphtMdy6CL5NxFs/j7oVvjzl3XlFfJi8WDjbDcN9gsfR9zBfNie3wc0
	 R2bW5I4PRYnXpyWvDANHbAHPRbvzdnZ330VAvMSCMlPN5VT+Ch2NH3cU1glnH37jZT
	 0hvh1Ar4ffIrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/11] perf/cxl: Split the MSI vector out of
 info->irq
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260805155501.1294472-6-dave.jiang@intel.com>
References: <20260805155501.1294472-1-dave.jiang@intel.com>
 <20260805155501.1294472-6-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:07:48 +0000
Message-Id: <20260805160748.ED4DA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The CXL PMU interrupt is requested with IRQF_SHARED, but its CPU a=
ffinity is dynamically modified during CPU hotplug, which is unsafe for sha=
red interrupts.
--

--- Patch [5]: [PATCH v4 05/11] perf/cxl: Split the MSI vector out of info-=
>irq ---
commit 7ced4bedee1c856d5114f92c2eb91db914c1a974
Author: Dave Jiang <dave.jiang@intel.com>

perf/cxl: Split the MSI vector out of info->irq

This commit separates the MSI/MSI-X message number from the Linux virq in
info->irq. It introduces info->msi_vec for the message number while retaini=
ng
info->irq for the Linux virq to prevent mix-ups between the two distinct
values.

> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 2bebbbe67a0a2..481d32d0c1b02 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c

[ ... ]

> @@ -873,10 +874,10 @@ static int cxl_pmu_probe(struct device *dev)
>  		.capabilities =3D PERF_PMU_CAP_NO_EXCLUDE,
>  	};
> =20
> -	if (info->irq < 0)
> +	if (info->msi_vec < 0)
>  		return -EINVAL;
> =20
> -	rc =3D pci_irq_vector(pdev, info->irq);
> +	rc =3D pci_irq_vector(pdev, info->msi_vec);
>  	if (rc < 0)
>  		return rc;
>  	irq =3D rc;

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the IRQ
handling here, I noticed a potential problem with how the PMU interrupt is
managed in drivers/perf/cxl_pmu.c.

In cxl_pmu_probe(), the interrupt is requested as shared and without
IRQF_NOBALANCING:

rc =3D devm_request_irq(dev, irq, cxl_pmu_irq, IRQF_SHARED | IRQF_NO_THREAD,
                      irq_name, info);

However, the CPU hotplug callbacks dynamically modify the CPU affinity of
this shared interrupt:

cxl_pmu_online_cpu() {
    ...
    WARN_ON(irq_set_affinity(info->irq, cpumask_of(cpu)));
}

cxl_pmu_offline_cpu() {
    ...
    WARN_ON(irq_set_affinity(info->irq, cpumask_of(target)));
}

Is it safe to change the affinity of a shared interrupt like this?

Modifying the affinity alters it for all co-owners of the IRQ.

Additionally, if irqbalance changes the affinity (since IRQF_NOBALANCING is
missing), could the PMU interrupt handler be forced to execute on the wrong
CPU and potentially corrupt state when locklessly accessing per-CPU data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805155501.1294=
472-1-dave.jiang@intel.com?part=3D5
