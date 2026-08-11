Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3105B32FA3C
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786458754; cv=none; b=BEjEcWc3m9f3nV367+2jgXhHe1NvuqwqClKPr83GY7Qb/tDNyVOxyP6OnFK+CEzNatJJE10zqr9OD8dAhWvjPItdsId3rvYvUDX6pAzT1zMd2573uxmSdBdU6sTzHTfBa2GKWhAo2PjD3x9JbU+HJ2CaDAtu73cP9CnR0waBs7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786458754; c=relaxed/simple;
	bh=EUOJQATf1Sqs/yNNBxtjKuUimovRxPsj2TIuF6X06OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYljSfTBd3Jdwz8A8rhc/6INxEDJvp9PyOML0LbK2P9b3a+fegfFBzaa3Dq53QkVXMXGOgJHvh6WoAUmeDLiqtzjC1WqmJtg4jmw7GW2dgMPm6wnr+P7eM402Zdi8Bm/h3H4lsMz9otpNky9XTJW8finziVQ7CPAvh1WUeaWA9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ave1Kfnb; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ave1Kfnb"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4954df200ddso21774805e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 07:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786458751; x=1787063551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lHv35RE6bkUtOImGbmK9Yom6+E0SECjA/P0mDcNGrZY=;
        b=ave1KfnbQevvxubWKA5bwL9TgORGTlC7qWFpQvk8UrN+JMtnFcpisy/yY0mYtB3ekE
         NezfEoE5r7uR6+JbPvU51EDKzWTqO2cGM28gdG2DwrgWcV7xvElBtTjYM8C7hc2XpQPX
         ml2yP77HDiheTgWsDjKuly8R+K+L2gKcoXGW5h1cFEVZ9y3lFpZpR6BgJ60SXARbKVQX
         YjSHoijKn87mQVwg9N1L69JdQU7MJ2RW9MQlg6zccW0gDQcFir8OzYOu1hpOrq1RjK3a
         CHXDvpd2Z7/rWoOiHlmiY1mGWl5bBRZdupHHooqAtu8jvAcgbJ4vRjePkrMZH39A2jgk
         /g/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786458751; x=1787063551;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lHv35RE6bkUtOImGbmK9Yom6+E0SECjA/P0mDcNGrZY=;
        b=KUlsRMU3QqPaBWqlRnr/87/oWuo4zFDN4SQHZVMbZkTU2hEFY1VO4GC5c3r6XMLzuV
         oQd9g2RT83aQrW/eEPo7nOMDVHbwUGyrTrGz2J9btZ4xQt8f57umOvaJULKCcefhjgmD
         R4lWytp+tq6kP0IdbHxU8qEGdz69TVeBE95pzSIGLg9D4IXksU4sBpWnpaVLFLcq0r0S
         Qd9/c1WIGzkuc34r72KwsUxU/nhBr0FNu8Vtq3A0ojPpP5OO/fkqoYPJS0gScAuD0NpL
         M3cezGkTSQQehsDthDuQFwIwUN1YNYvx2Hva6OwMvvdUBbbAiz+F5Z72Ct6spFQ6nfqc
         Ar9w==
X-Forwarded-Encrypted: i=1; AHgh+RrXCvXhvHU5C3q703se8ecWsuFp4WNRi/oxlYlNyNBLPAUgYNsVluAzszRWTTXHTtxFEpnrSuKINNcqyo1AoUuM@vger.kernel.org
X-Gm-Message-State: AOJu0YwAWoXC+tMqM+TSzfojSgwHJnXi8tkzkLSr+Fo2lMkEzRkaNUHy
	xC6OWmBRGN0rC3Fim/zo6Lnszc17xdaYAM8BGKktM4mNRlnAT6kI4gComnRRu9hfvh0=
X-Gm-Gg: AR+sD11ne2PHsptz9MejMpKdPXqvBh1VRMVdirJAsEeKH484syCXaWXTF716XDUiJBK
	cL+y9pGQC843JaRPid9fNrYtA+DoNuOaN6ndTO36KIEzIQsLyRnYS5dJgK+FEh1+Is3k7HWyJAH
	PYhXG2jXuW/WeukbG/jK6r63rzdGdxETdxWOGr8jdlh/JFkrrkTZF97evW/6qEZWUX3/ID3T7lp
	ReeWY3JxyDRKQmLjDIOmP4OPJcHV3KmuWVJsOjAq4Gz9PefCmqPTGLnjM+V31yAhntGSpesd2DJ
	mhibJmhvQSgpdo2I+HXlxLCUoVe07UikZBu5CssEsOY6a0ki/oC5RpLGhuXdrMryJtsIW7U/EMM
	g2YF8vUl4YwYsC9CYi/zzhA4y7suyVWuo9urz1qTkh+5CTm6Nm2O+RhA2gwy7aVqdt7Lv88isHU
	nf+Ke/KmRU0msH59mF+RokaQ9NdXs+ogM45oNAo943pTn9VGY94JL+C0GKaClob4QJEj+d5X8St
	HfeSWmyPZwSvI2DQpRhi8n4w3MjY5iy1vuLqYMqrgPuUf9eKq3w
X-Received: by 2002:a05:600c:45d5:b0:499:740c:3428 with SMTP id 5b1f17b1804b1-49978446b35mr52841945e9.8.1786458751348;
        Tue, 11 Aug 2026 07:32:31 -0700 (PDT)
Received: from localhost (p200300f65f017104853c3975fdcddd6f.dip0.t-ipconnect.de. [2003:f6:5f01:7104:853c:3975:fdcd:dd6f])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-499788f13cbsm60543725e9.9.2026.08.11.07.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 07:32:30 -0700 (PDT)
Date: Tue, 11 Aug 2026 16:32:29 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Ian Rogers <irogers@google.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/2] perf: Add Raspberry Pi BCM2835 AXI PMU driver
Message-ID: <ansxmIcZnC9G6QN8@monoceros>
References: <20260811083828.2057695-1-irogers@google.com>
 <20260811083828.2057695-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v6zicwwmtxhswzvi"
Content-Disposition: inline
In-Reply-To: <20260811083828.2057695-2-irogers@google.com>


--v6zicwwmtxhswzvi
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v1 1/2] perf: Add Raspberry Pi BCM2835 AXI PMU driver
MIME-Version: 1.0

Hello,

On Tue, Aug 11, 2026 at 01:38:26AM -0700, Ian Rogers wrote:
> +#include <linux/mod_devicetable.h>
> [...]
> +#include <linux/platform_device.h>

Please rely on <linux/platform_device.h> to provide the definition of
of_device_id and drop <linux/mod_devicetable.h>. The latter will go away
soon.

> +/* Devices matching this driver in Device Tree */
> +static const struct of_device_id rpi_axi_pmu_match[] = {
> +	{
> +		.compatible = "brcm,bcm2835-axiperf",
> +		.data = (void *)CHIP_BCM2835,
> +	},
> +	{
> +		.compatible = "brcm,bcm2711-axiperf",
> +		.data = (void *)CHIP_BCM2835,
> +	},
> +	{},

Please use

	{ }

as list terminator (that is, add a space and drop the comma).

Also if the data is the same for all variants, maybe better drop the
assigment to .data and hardcode the value accordingly.

> +};
> +
> +MODULE_DEVICE_TABLE(of, rpi_axi_pmu_match);

Usually there is no empty line between the device_id struct and the
MODULE_DEVICE_TABLE macro.


--v6zicwwmtxhswzvi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmp7MnoACgkQj4D7WH0S
/k7XeggAsjqD6ZSGHh7fLT4aPVs7BB3P+0clSg1PcXCLwXSRHnoaYx6bqyH/8Qt0
7ijosmeazKiJosSTI0Y2Fcv9Q+Jh8Ea23UKmlrbEq7IQlFB6o48YchhKSW0vl/KQ
fHoXhe8mwuQyey/HX9NkiN0jysztfEaSW/w3XQYJ/68rZZbKqidb2LFM1CB4ZXkO
K0zPSSZztOuQnwef12ELvWi5J9pgBaeSuu/P5V8XSwLXLP2iYOU3kgyM6iHWKrQ7
5C4K9hBWBuX72UCoZQ6NlLPRVNpmRyC3Uf2YHFlqSwFgz+3p/cgGfAYkB6RsQ542
HJCKnzijvQbI1BVGQWwauSIZrUyLTw==
=6EO1
-----END PGP SIGNATURE-----

--v6zicwwmtxhswzvi--
