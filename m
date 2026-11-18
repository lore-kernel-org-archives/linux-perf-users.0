Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794998697;
	b=HzShyTiIXG7tmLpcpB/l4stfVE6Gb+YCELMGp0tMVOkLRLlcDQsKI+NhhJypSeIXez8/
	 fz4Tr7Of+KQyFeJHAiWCWkUOI5YWqCDNUvgrvdStknHHAmGYEiNJOv0jSm638zZmaUMjH
	 Nx4v82gmthqmuEMTT73GbMd5p9KE5xnI4pOyjGWJq9MUXjHI8hpdizTItX1hup4unDILX
	 BaNf1/B7s/nbvJWdYSr1/5km3bf1ylyOwyllB6NhwsNcurSxL4qU5m433CH8ybIxlKtIW
	 Ujz9JHmJSrPxqMSkEbVfeccbfjCECwJHENJA+qM3KdBhvdaj4d7/qgcZtIdwCdwLQVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794998697;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hbO7q0hgbcFgGqogPQxCLP68LVciV9U7EkaFcvT0Xak=;
	b=ladcZt9Qy3ZqAMFA4Hp3j0NIz5Ryjq8Lz7qQCuhq7JKlREVKAcbZgurt+i23sIeDpykf
	 OrbhViEBq0dn+eXby15hjPgn6FZ2WUteCsAiva0ew+gdj2oJUKqxLL+n63gKNTHePpmEt
	 Oe/nTa7XlSIbagVHTEvpYvMZ89GkmUZO2YEqrhZIhdh6mykU6AbdqYjVIIkI0wohY1anz
	 aksVXIndcT8XiB8yzetdnGf/1N/CevERmVEguY3OLpFQvLYrKMZyEzzWhXFBXUcST90I/
	 jMRvwS1Lus6LazT668500v7uUhBjidMys3e7XlExfgff6Af4DnOwIOr5K7iXdKYiEXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h+0BuO8m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345F5606A31C;
	Wed, 18 Nov 2026 10:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h+0BuO8m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494621F000C4;
	Wed, 18 Nov 2026 10:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794998696;
	bh=hbO7q0hgbcFgGqogPQxCLP68LVciV9U7EkaFcvT0Xak=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h+0BuO8mLm5ZaiC1+8XciUZ+u8/d8UoCvwTaUtFeO9k7SjO1IvcLA8x4dY5RRTvaB
	 Ewj+5+7YiDqSC49Nn5GNcA1rVLm0boIS6uxyZfAMocPnsfYi3ozx8Ne5MouaKdIAOl
	 d2yiTZUqhWg0Eb/WD0o4Zvywpe5vXczOzUbYr0woYvABbCCvVa3ZyBlMNO27W1JtN7
	 ksZ8P6c3yXyQFV4FhC1yL5lqQXM9NvDy8SNtXbtLMjXADLzJDqc1o01IHovIS5HbpM
	 pXzE/v1kFbpe4HK9K8Eu7buw6rwVQeD+nSbNEwjFATZQ6k/3NnRqK20Yx3j7bLAqJ2
	 0DwRKyx5kP9Vg==
Message-ID: <sashiko-outbox-220738@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf/smmuv3: Add runtime PM support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amita Mishra" <amitamishra@google.com>
Cc: linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261118101913.3135869-3-amitamishra@google.com>
References: <20261118101913.3135869-1-amitamishra@google.com>
 <20261118101913.3135869-3-amitamishra@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 10:44:55 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] perf/smmuv3: missing MSI register restore in
  smmu_pmu_runtime_resume()
- [High] perf/smmuv3: unpowered MMIO writes in smmu_pmu_write_msi_msg()
--

commit 3367ecb885d7f9e9f0717d0698079ca0810697a6
Author: Amita Mishra <amitamishra@google.com>

perf/smmuv3: Add runtime PM support

This commit adds runtime PM support for SMMUv3 PMCG devices attached to a
power domain so that idle PMCGs can be powered off when no perf events are
active.

> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> index 97440b6233c6e..e9da99b4a0866 100644
> --- a/drivers/perf/arm_smmuv3_pmu.c
> +++ b/drivers/perf/arm_smmuv3_pmu.c

[ ... ]

> @@ -975,15 +1040,45 @@ static void smmu_pmu_remove(struct platform_device=
 *pdev)
> =20
>  	perf_pmu_unregister(&smmu_pmu->pmu);
>  	cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &smmu_pmu->node);
> +	if (pdev->dev.pm_domain)
> +		pm_runtime_disable(&pdev->dev);
>  }

[Severity: High]
Can tearing down or retargeting the MSI while the PMCG is runtime-suspended
write to SMMU_PMCG_IRQ_CFG0, SMMU_PMCG_IRQ_CFG1, and SMMU_PMCG_IRQ_CFG2
while the power domain is off?

When the driver is unbound with no active events, __device_release_driver()
leaves the device runtime-suspended and smmu_pmu_remove() disables runtime
PM.  devres_release_all() then frees the devm_request_irq() handler via
free_irq() -> irq_domain_deactivate_irq() -> msi_domain_deactivate() ->
smmu_pmu_write_msi_msg(), which writes to the unpowered PMCG registers and
triggers an external abort or SError.  The same unpowered write happens if
smmu_pmu->on_cpu is offlined while suspended and smmu_pmu_offline_cpu()
calls irq_set_affinity() -> msi_domain_set_affinity() ->
smmu_pmu_write_msi_msg().

> =20
>  static void smmu_pmu_shutdown(struct platform_device *pdev)
>  {
>  	struct smmu_pmu *smmu_pmu =3D platform_get_drvdata(pdev);
> =20
> -	smmu_pmu_disable(&smmu_pmu->pmu);
> +	if (pdev->dev.pm_domain) {
> +		if (pm_runtime_get_if_active(&pdev->dev) <=3D 0)
> +			return;
> +		__smmu_pmu_disable(smmu_pmu);
> +		pm_runtime_put(&pdev->dev);
> +		return;
> +	}
> +
> +	__smmu_pmu_disable(smmu_pmu);
>  }
> =20
> +static int smmu_pmu_runtime_suspend(struct device *dev)
> +{
> +	struct smmu_pmu *smmu_pmu =3D dev_get_drvdata(dev);
> +
> +	__smmu_pmu_disable(smmu_pmu);
> +	return 0;
> +}
> =20
> +static int smmu_pmu_runtime_resume(struct device *dev)
> +{
> +	struct smmu_pmu *smmu_pmu =3D dev_get_drvdata(dev);
> +
> +	smmu_pmu_reset(smmu_pmu);
> +	return 0;
> +}

[Severity: High]
Does smmu_pmu_runtime_resume() lose the MSI configuration programmed in
SMMU_PMCG_IRQ_CFG0, SMMU_PMCG_IRQ_CFG1, and SMMU_PMCG_IRQ_CFG2 when the
power domain is powered off and back on?

During probe, smmu_pmu_setup_irq() clears SMMU_PMCG_IRQ_CFG0 and
devm_request_irq() activates the MSI via smmu_pmu_write_msi_msg(), before
pm_runtime_put_sync() at the end of smmu_pmu_probe() suspends the device
and drops power to those registers:

drivers/perf/arm_smmuv3_pmu.c:smmu_pmu_write_msi_msg() {
	...
	writeq_relaxed(doorbell, pmu->reg_base + SMMU_PMCG_IRQ_CFG0);
	writel_relaxed(msg->data, pmu->reg_base + SMMU_PMCG_IRQ_CFG1);
	writel_relaxed(MSI_CFG2_MEMATTR_DEVICE_nGnRE,
		       pmu->reg_base + SMMU_PMCG_IRQ_CFG2);
}

When smmu_pmu_event_init() later resumes the device,
smmu_pmu_runtime_resume() only calls smmu_pmu_reset(), leaving the MSI
registers unprogrammed (or leaving SMMU_PMCG_IRQ_CFG0 at its UNKNOWN reset
value when wired interrupts are used on an MSI-capable PMCG) so counter
overflow interrupts do not work.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118101913.3135=
869-1-amitamishra@google.com?part=3D2
