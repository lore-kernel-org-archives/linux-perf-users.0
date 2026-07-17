Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2507B3B2D18;
	Fri, 17 Jul 2026 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784284994; cv=none; b=UPjbe76fmwVTr1wCSiStwC0I3I50jzgO4178oths4fGVXSIyxIFgNb0pIimspiDhvjlAiwrZ6dQ4OamN6dmKVVgIDAjYchzNhbAS2fm7iaMrk6om7KHOLNLx0rL4MkXZqSgvgjbq5LO2KywAu9VkkvVvdjjZCgtInO7gm4ALPt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784284994; c=relaxed/simple;
	bh=zMN/Fqyb89XihaW2OLNqlgLr7BesIV4Revh8TpH+c9Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FT0ntOllN0ABnb8VmsVVt76q9SCwcRviMxZySbKCxRVzjbzUcpbCmzEzVnQ28U7dkg3fw1NJdUgURB33vsDanES0OAcEA6pXhonSwH9FcFSs9g1REw0CfANxiDqYsVIKC1FnyjKmZY7rahm5e9SJQTOZtF1kCOpIS68tO0bJf3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsMGtu31; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsMGtu31"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD071F000E9;
	Fri, 17 Jul 2026 10:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784284993;
	bh=TPq1W25HMVIS5gnpZgWWmfKXoYx295Je6Qmbb4tEV7E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UsMGtu31pRDRGAGCB7hD9/DG4fpKQC8JXEp/Pzs167saLMUj3GsONi12pkMoxmxMR
	 KvQnO9PzpnSWmgypmsMEH2tDrxmig9e49yMt9mg4eHxs9r1NgLLWTTwAY2ZUCJ1n2g
	 QCzg5aUTv12lyNdgY6aj6eEhXcOAaZGND1TfLmYPx9ri0+ejkAYpnLACdXVHQsBI1L
	 FmOUHf0wV/z6ZaObE07eCkiwwuER5Cu28Ex8mzT+rN997aek9GbmUFqT7jiO7R552j
	 IVnfgBi6Yr6sWVXcqTeUf+bOm1dXwrxbWvLf/jMTSZRgpse3ibPq7FCfD0F5Qn2x/l
	 Jr/4Hk6fESh3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] perf: Remove redundant dev_err()/dev_err_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, linux-perf-users@vger.kernel.org
In-Reply-To: <20260717103123.34887-2-panchuang@vivo.com>
References: <20260717103123.34887-1-panchuang@vivo.com>
 <20260717103123.34887-2-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 10:43:12 +0000
Message-Id: <20260717104312.DAD071F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] The `memrc` variable is no longer used after the removal of the `de=
v_err()` call, leaving an unused local variable.

Pre-existing issues:
- [High] The IRQ handler context is freed via kfree() before the devm_reque=
st_irq() resource is released, creating a use-after-free vulnerability.
- [High] Missing cleanup of CPU hotplug instance registration when perf_pmu=
_register() fails, leaving a freed pointer in the global hotplug list.
--

--- Patch [1]: [PATCH 1/3] perf: Remove redundant dev_err()/dev_err_probe()=
 ---
commit 83d88878cd6553e7af185d501c3dfdb2c01816e8
Author: Pan Chuang <panchuang@vivo.com>

perf: Remove redundant dev_err()/dev_err_probe()

Since commit 55b48e23f5c4, devm_request_irq() automatically logs
detailed error messages on failure. This patch removes the now-redundant
driver-specific dev_err() and dev_err_probe() calls.

> diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba=
_uncore_drw_pmu.c
> index 74786a5dd6a23..fc934bccf4a64 100644
> --- a/drivers/perf/alibaba_uncore_drw_pmu.c
> +++ b/drivers/perf/alibaba_uncore_drw_pmu.c
> @@ -449,11 +449,8 @@ static struct ali_drw_pmu_irq *__ali_drw_pmu_init_ir=
q(struct platform_device
>  	 */
>  	ret =3D devm_request_irq(&pdev->dev, irq_num, ali_drw_pmu_isr,
>  			       IRQF_SHARED, dev_name(&pdev->dev), irq);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev,
> -			"Fail to request IRQ:%d ret:%d\n", irq_num, ret);
> +	if (ret < 0)
>  		goto out_free;

[Severity: High]
This is a pre-existing issue, but since we are modifying the error path
here, can this lead to a use-after-free if a subsequent step fails?

In __ali_drw_pmu_init_irq(), if devm_request_irq() succeeds but a later
function like irq_set_affinity_hint() fails, the code jumps to out_free:

out_free:
        kfree(irq);
        return ERR_PTR(ret);

Since devm_request_irq() uses the IRQF_SHARED flag, another device sharing
this IRQ could trigger an interrupt immediately. If ali_drw_pmu_isr()
executes before the devres cleanup deregisters the handler, will it
dereference the already freed irq pointer?

> -	}
> =20
>  	ret =3D irq_set_affinity_hint(irq_num, cpumask_of(irq->cpu));
>  	if (ret)

[ ... ]

> diff --git a/drivers/perf/qcom_l3_pmu.c b/drivers/perf/qcom_l3_pmu.c
> index c8d259dd1f807..e18d0f94e8d86 100644
> --- a/drivers/perf/qcom_l3_pmu.c
> +++ b/drivers/perf/qcom_l3_pmu.c
> @@ -767,11 +767,8 @@ static int qcom_l3_cache_pmu_probe(struct platform_d=
evice *pdev)
> =20
>  	ret =3D devm_request_irq(&pdev->dev, ret, qcom_l3_cache__handle_irq, 0,
>  			       name, l3pmu);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Request for IRQ failed for slice @%pa\n",
> -			&memrc->start);
> +	if (ret)
>  		return ret;

[Severity: Low]
The patch removes the dev_err() call which was the only reader of the
memrc variable in qcom_l3_cache_pmu_probe(). Does this leave memrc
populated but entirely unused?

Could the code be cleaned up to use devm_platform_ioremap_resource()=20
instead of devm_platform_get_and_ioremap_resource() and remove memrc=20
completely?

> -	}
> =20
>  	/* Add this instance to the list used by the offline callback */
>  	ret =3D cpuhp_state_add_instance(CPUHP_AP_PERF_ARM_QCOM_L3_ONLINE, &l3p=
mu->node);

[Severity: High]
This isn't a bug introduced by this patch, but does this function leak the
CPU hotplug instance if perf_pmu_register() fails later in the probe?

qcom_l3_cache_pmu_probe() registers the instance here:

    ret =3D cpuhp_state_add_instance(CPUHP_AP_PERF_ARM_QCOM_L3_ONLINE,
                                   &l3pmu->node);

But if perf_pmu_register() fails right after, it returns immediately:

    ret =3D perf_pmu_register(&l3pmu->pmu, name, -1);
    if (ret < 0) {
        dev_err(&pdev->dev, "Failed to register L3 cache PMU (%d)\n", ret);
        return ret;
    }

Since devres will automatically free the l3pmu struct on probe failure,
will the freed l3pmu->node remain linked in the global list and cause a
use-after-free during subsequent CPU hotplug events?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717103123.3488=
7-1-panchuang@vivo.com?part=3D1
