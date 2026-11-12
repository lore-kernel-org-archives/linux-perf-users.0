Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794524426;
	b=1WN0oXD5EmZZmF3qHFDGZWc+9KPoRkueAfxnnGLGW4FFe7ShvUG7Eeidibgsdc2tl4fR
	 JGj5+14LTrgekPMRVUr2q9ICB9+nCcSkegt4dnHOGCk11ogNn8fWHfLq9up9JzomP18sb
	 zxuJwzV8VexWPr2iu6YY6u4uE9cPAFrR7sHRqGwfXiI65YEDFILAv2dawEzQWM8niwdov
	 kJ2X15uMWUjYclcfug6zsYc8IEgoC0ViLqvQISyXyWBi5Jdad4fAvfpR1zRK2Ttl0CSSP
	 zIabu87iakmlITv3+03ftWh23wRw6+mV0HbVgAx2UKEk2hpyDtLWJCHno/ykDAnFLjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524426;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iwRaS3TEjHUe60O3uYbunfTxY8A7J6SsfpcFnUuYyEg=;
	b=Lo8riaZfit4Edcm6opS5fUgYPXgnrqQ0Xf/4tLTT9ORRI6CAJSH6Ae1TQubpZv7e3smf
	 zFr5rRyNtaSKQ6uVsvwM7r+eJnw+brgGFgIOQQPobojFCA09MntxI45os7ySu8u2GEL+0
	 uSPkqYGIv8g2C8kiq/GgD6cm6ZyvH6OHxvYp0cZcyk7egEO2MRnGgseB4ii8z2VVjKcRR
	 6tfQzx+8/qw7B3LN4dC83d1YTfRAZAtzgCYliWu8j2mLduHOA2TSqeYC0GOB8hDQNgOC0
	 tqgcCs5qBSosC0yE+ByRiMHnLnXnk4g7RuAJdSBZovRYgrNhngMxrmZkgrnY2gTUOFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C3iRykh4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA210606A321
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 23:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C3iRykh4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CA91F000C4;
	Thu, 12 Nov 2026 23:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794524426;
	bh=iwRaS3TEjHUe60O3uYbunfTxY8A7J6SsfpcFnUuYyEg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C3iRykh4MR/3AX3ig2zGTkngEHsbz7ZcJupADIJ3NXW5cY7ftszafuCC2FDzyZD+V
	 QJN3ZebARE7gC6nhjIUs7+a0TcUlUKsiBkJvVPLCwtfx01kMsjT3kzOpGRwIg/VSnp
	 UhQku7G1eqij4j9MZyMb3C4mxwFCfX6NL+FvwEEPnKhwGNKRW3t2BAVKPXbkHIyLy4
	 1E3i0iZUZpqOHnbmsTjYET/02BAEuiOIMKqv3Szy7zBVuHXaztSEZ8Vinlgm85F2dS
	 RAn+LBg6YmBbfuIcPAn116oLhPNVIbN42fuij3xpxxnxpGi29B3pOEoDNsyD9P6YxU
	 WAD6I2jjtq0cA==
Message-ID: <sashiko-outbox-211930@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] irqchip/ath79-misc: convert to a platform driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261112224445.213324-4-rosenp@gmail.com>
References: <20261112224445.213324-1-rosenp@gmail.com>
 <20261112224445.213324-4-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 23:00:25 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] irqchip/ath79-misc: ath79_misc_intc_probe() clobbers QCA956x
  timer mask
--

commit 60ba869db8725142b0f8869ed514d502d7719988
Author: Rosen Penev <rosenp@gmail.com>

irqchip/ath79-misc: convert to a platform driver

This commit converts the ath79-misc interrupt controller driver from
IRQCHIP_DECLARE() to a platform driver using device-managed resources.

> diff --git a/drivers/irqchip/irq-ath79-misc.c b/drivers/irqchip/irq-ath79=
-misc.c
> index 5cedea5234e05..b06ece446746c 100644
> --- a/drivers/irqchip/irq-ath79-misc.c
> +++ b/drivers/irqchip/irq-ath79-misc.c
[ ... ]
> @@ -124,65 +125,54 @@ static const struct irq_domain_ops misc_irq_domain_=
ops =3D {
>  	.map =3D misc_map,
>  };
> =20
> -static void __init ath79_misc_intc_domain_init(
> -	struct irq_domain *domain, int irq)
> -{
> -	void __iomem *base =3D domain->host_data;
> -
> -	/* Disable and clear all interrupts */
> -	__raw_writel(0, base + AR71XX_RESET_REG_MISC_INT_ENABLE);
> -	__raw_writel(0, base + AR71XX_RESET_REG_MISC_INT_STATUS);
> -
> -	irq_set_chained_handler_and_data(irq, ath79_misc_irq_handler, domain);
> -}
> -
> -static int __init ath79_misc_intc_of_init(
> -	struct device_node *node, struct device_node *parent)
> +static int ath79_misc_intc_probe(struct platform_device *pdev)
>  {
> +	struct device *dev =3D &pdev->dev;
>  	struct irq_domain *domain;
>  	void __iomem *base;
>  	int irq;
> =20
> -	irq =3D irq_of_parse_and_map(node, 0);
> -	if (!irq) {
> -		pr_err("Failed to get MISC IRQ\n");
> -		return -EINVAL;
> -	}
> +	irq =3D platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> =20
> -	base =3D of_iomap(node, 0);
> -	if (!base) {
> -		pr_err("Failed to get MISC IRQ registers\n");
> -		return -ENOMEM;
> -	}
> +	base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> =20
> -	domain =3D irq_domain_create_linear(of_fwnode_handle(node), ATH79_MISC_=
IRQ_COUNT,
> -				&misc_irq_domain_ops, base);
> -	if (!domain) {
> -		pr_err("Failed to add MISC irqdomain\n");
> -		return -EINVAL;
> -	}
> +	domain =3D devm_irq_domain_create_linear(dev, dev_fwnode(dev),
> +					       ATH79_MISC_IRQ_COUNT,
> +					       &misc_irq_domain_ops, base);
> +	if (!domain)
> +		return dev_err_probe(dev, -ENOMEM, "failed to add the irq domain\n");
> +
> +	/* Disable and clear all interrupts */
> +	__raw_writel(0, base + AR71XX_RESET_REG_MISC_INT_ENABLE);
> +	__raw_writel(0, base + AR71XX_RESET_REG_MISC_INT_STATUS);
> =20
> -	ath79_misc_intc_domain_init(domain, irq);
> +	irq_set_chained_handler_and_data(irq, ath79_misc_irq_handler, domain);
>  	ath79_misc_domain =3D domain;
> +
>  	return 0;
>  }
> =20
> -static int __init ar7100_misc_intc_of_init(
> -	struct device_node *node, struct device_node *parent)
> +static int ar7100_misc_intc_probe(struct platform_device *pdev,
> +				  struct device_node *parent)
>  {
>  	ath79_misc_irq_chip.irq_mask_ack =3D ar71xx_misc_irq_mask;
> -	return ath79_misc_intc_of_init(node, parent);
> +	return ath79_misc_intc_probe(pdev);
>  }
> =20
> -IRQCHIP_DECLARE(ar7100_misc_intc, "qca,ar7100-misc-intc",
> -		ar7100_misc_intc_of_init);
> -
> -static int __init ar7240_misc_intc_of_init(
> -	struct device_node *node, struct device_node *parent)
> +static int ar7240_misc_intc_probe(struct platform_device *pdev,
> +				  struct device_node *parent)
>  {
>  	ath79_misc_irq_chip.irq_ack =3D ar724x_misc_irq_ack;
> -	return ath79_misc_intc_of_init(node, parent);
> +	return ath79_misc_intc_probe(pdev);
>  }
> =20
> -IRQCHIP_DECLARE(ar7240_misc_intc, "qca,ar7240-misc-intc",
> -		ar7240_misc_intc_of_init);
> +IRQCHIP_PLATFORM_DRIVER_BEGIN(ath79_misc_intc)
> +IRQCHIP_MATCH("qca,ar7100-misc-intc", ar7100_misc_intc_probe)
> +IRQCHIP_MATCH("qca,ar7240-misc-intc", ar7240_misc_intc_probe)
> +IRQCHIP_PLATFORM_DRIVER_END(ath79_misc_intc)

[Severity: High]
Does probing ath79_misc_intc at device_initcall time clobber
MISC_INT_MIPS_SI_TIMERINT_MASK in AR71XX_RESET_REG_MISC_INT_ENABLE on
QCA956x?

With IRQCHIP_DECLARE(), this driver ran during init_IRQ() before
time_init() -> plat_time_init() -> of_clk_init() called
qca956x_clocks_init():

arch/mips/ath79/clock.c:qca956x_clocks_init() {
	...
	/*
	 * QCA956x timer init workaround has to be applied right before setting
	 * up the clock. Else, there will be no jiffies
	 */
	u32 misc;

	misc =3D ath79_reset_rr(AR71XX_RESET_REG_MISC_INT_ENABLE);
	misc |=3D MISC_INT_MIPS_SI_TIMERINT_MASK;
	ath79_reset_wr(AR71XX_RESET_REG_MISC_INT_ENABLE, misc);
	...
}

Moving registration to IRQCHIP_PLATFORM_DRIVER_BEGIN() runs
ath79_misc_intc_probe() after time_init(), where the unconditional write of
0 to AR71XX_RESET_REG_MISC_INT_ENABLE clears MISC_INT_MIPS_SI_TIMERINT_MASK
and breaks the CPU timer interrupt on QCA956x, TP9343, and QCN550x SoCs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112224445.2133=
24-1-rosenp@gmail.com?part=3D3
