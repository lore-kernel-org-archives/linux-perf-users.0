Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF6B199BC;
	Sun,  1 Jun 2025 18:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748804111; cv=none; b=VNl3DtMbXocUDjBLtn0QV6x+FsuJ9a3xjkWjg363prUOJKnFy/N/SRCTc8CTq/vH1p/ee5djrOaDipL9H8rqO2WIXnJkk4HOQgba8ucb+ArltgDh04VOl7AF4EbJRJ2b96KTjsGNd3ohaHYAGPnalHgbpwKsPp02uRvsB26M/0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748804111; c=relaxed/simple;
	bh=OX4yvUON3tISGUsgbOemPrVvgvCC4QWKwQAy9TZhFdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CCy0nIUaiJEgRhTLH60PfvlQ34mBLXsAxDGjCT4gMFSZSgjgrRTSy5M+iZEfWEi+/KSm2S/W/0CNR9HdoDfJPXoH4htTjdR0fb0Z/VAnG9H5RK6WP8mpYtuqdCF8tIYXKSVaxZUeDj9hrc6F0yDdsV2xV5YWSxogT7ZqHSACguY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1BRP2b5; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1BRP2b5"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6049431b409so6550143a12.3;
        Sun, 01 Jun 2025 11:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748804108; x=1749408908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g+rZXeg2h8FFJjzzSKXnu2tsAZmNScsbIa1AmfrMPH8=;
        b=A1BRP2b566xKrxpSyegbyIO/gyNWsL2vG10MYaR0S2S6IO7AMJuq9I2j34Rcs2f908
         THGDIbiduFmTTTR/GvPej83WVkLRP1xqPIGYcOzQX2JBCU9j/aodh4e96OnNJjFaNDxI
         Y3Lnknj1hSzwSL5al+LCSWk6QL5vYJYRja6adjwdHsKId6A3t6RL/Kd7iC85/SPat6QI
         cIrB2edngE27ehIhL+F0i4MLLIkonDuEXwLbEOqLrt6/ZfTz+12I6mwP8O8frlmVK8kC
         KxiBAT5CWj4Jd7lYkZzrE7bbICcb5oHD0IAruEOH88+ljHZGyOoFylFhbV0qg7lGraTS
         Fgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748804108; x=1749408908;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+rZXeg2h8FFJjzzSKXnu2tsAZmNScsbIa1AmfrMPH8=;
        b=N8uCJypWyu2hUUwZvuduxwpYjAWgcFrGlc9/mOn9jkhhEuUmFDQtwnkP61R+kQE3Sl
         XhP3huFXlpRXB+Murjw7qCx25jju7e0NEuNeMPqxtaoJ1CtDq0T0yynRL+X9/inYMbyu
         oqxz9emI03uSKteWH73uv9rZQQofjBUB1f6qZKToGJSlIMaR0Q3YP7oCkVOvhRJIrH9k
         jif92Nmg4R39pQPvKOMPP5QtyLgOfqpKowHaHCNUK1GA3VuqSIB0XVkvoeBZ0jTl8zqD
         vWxqo6PlGqtK99drlrHK1CKBoBuGW53tO+Kfyu9ldpJmYphPQ63f6UwKTkVDbkjB31sM
         ViIg==
X-Forwarded-Encrypted: i=1; AJvYcCV45bTxWOJPQeOQedaYHzaS9yOBsPpWqKMOWGMW/upxn7ORE3cODWzSdQcUNIuwLsVP2PJowqdUqLfO@vger.kernel.org, AJvYcCXPVfAfdnv9UBlNaTawKEkWp/p/8xMIdJ6ve8BG4s+l6P05tq80A6iKWL7Fpv+s+a7jW+Z1aJL0fV+r3+Ad@vger.kernel.org, AJvYcCXqHVQNsFA30Aiu6LMxFu0scJrWr0mtbZWXWJGMZIMM25ACE0kPvL89jh1ZWu95sDVfpvbA9P5bKq9qAbGbmsLuFA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzn47x6lpd+pSVagUVUknOvDWOHed9m3sGrZAM1xPQgaZoRHTE
	dDOVa6MSDvRB8akuB2+gwgbZs5mueHyOANL6q0G2Da4DFo3vU8EZDrdA
X-Gm-Gg: ASbGncv2oSV7RYSwHD1zQQKZ63kVC4Ecuq4qX2H0pD5YMVp9AYYXDrzeIfNEIZbkmqC
	L+Wxz0fIDT6Ra5TXc2T7jNUj1kXDlgUuymMv0spaVnZ0GrMSd0nCzV//rLWZN4TOM3xsxOHzkkJ
	Hdvuv9O5TLeRktzo20GquQ/gdQSq/DPmcdtC999ZVJb+XVi46ugvJtLosUFVlMMWBxARt3h1ohV
	bXuo5zUho3Tykym/sMYSovE4LXmpr5Qo5FWCcmOsUnTHmdNcquL01RzqOAsi4/KZfzQSa7IYTV+
	XnIhnvHUU/G8um5vi23b/AqfZNjenl2EDbzrdqVlYsMi7o5WNzmgCpvs7OPo3ccBlnoJwYwaRYB
	SOZIZRPP58SBxUHQfP28UCnfwJ3QPjQ==
X-Google-Smtp-Source: AGHT+IFp/ARVXyjA6tzOC4tGnmBvidx5QlpVw7FOMafdXAdEPbHMfgPxKJm7amG7iCl+8q+ttzGUoQ==
X-Received: by 2002:a17:907:7f93:b0:ad8:976e:533e with SMTP id a640c23a62f3a-adb494bd4demr514846066b.34.1748804107861;
        Sun, 01 Jun 2025 11:55:07 -0700 (PDT)
Received: from [192.168.1.105] (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d7fee1esm682786366b.25.2025.06.01.11.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Jun 2025 11:55:07 -0700 (PDT)
Message-ID: <c27311d7-8fa3-4ee2-a751-154517cf7d68@gmail.com>
Date: Sun, 1 Jun 2025 21:55:05 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/21] drivers/perf: apple_m1: Add Apple A8/A8X support
Content-Language: en-US
To: Nick Chan <towinchenmi@gmail.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org,
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250510-apple-cpmu-v7-0-bd505cb6c520@gmail.com>
 <20250510-apple-cpmu-v7-9-bd505cb6c520@gmail.com>
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
In-Reply-To: <20250510-apple-cpmu-v7-9-bd505cb6c520@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/10/25 18:10, Nick Chan wrote:
> Add support for the CPU PMU found on the Apple A8, A8X SoCs.
>
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---

Tested-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>

>  drivers/perf/apple_m1_cpu_pmu.c | 124 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 124 insertions(+)
>
...
> +
>  static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
>  {
>  	cpu_pmu->name = "apple_icestorm_pmu";
> @@ -912,6 +1035,7 @@ static const struct of_device_id m1_pmu_of_device_ids[] = {
>  	{ .compatible = "apple,blizzard-pmu",	.data = m2_pmu_blizzard_init, },
>  	{ .compatible = "apple,icestorm-pmu",	.data = m1_pmu_ice_init, },
>  	{ .compatible = "apple,firestorm-pmu",	.data = m1_pmu_fire_init, },
> +	{ .compatible = "apple,typhoon-pmu",	.data = a8_pmu_typhoon_init, },
>  	{ .compatible = "apple,cyclone-pmu",	.data = a7_pmu_cyclone_init, },
>  	{ },
>  };
>

