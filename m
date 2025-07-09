Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F196272E7C;
	Wed,  9 Jul 2025 14:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069703; cv=none; b=gKKvwp2q9tLD97v4YoeFhdjG3y7LF3FfLeDgaUze62+4TJtxTLElTmRdclZZSgIPprBZcQx7a7j1XVx+539tWoQEUJUAmw+NajUJdBxRyqIFMgvacK++jZ0llvtQpIWjEoQpQJ0Y8OgHOyBSsMsnuF+qFMR0mZuM31NjJHBCX5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069703; c=relaxed/simple;
	bh=NjF/I4wdgHCjk0VazPx1Rna6CqDY2c1+JUJEJS/Be9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZxngoGpzhA4jDedDtoyDq/qXZnq/vVJv4czhNJIPYpy9HOpYYsTtEf5tT3MaTxzzzDMKUbx21z8GtQwJXjwSFNxhUTOXYRbq61v2ufxaPB13tWZoH/Cw76b6PdWStN3RrB6L24R+zIEorZVbq1Xa8O1tqANzyaFCWsp9IjSr8YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doBggYFf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doBggYFf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6ECC4CEEF;
	Wed,  9 Jul 2025 14:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069703;
	bh=NjF/I4wdgHCjk0VazPx1Rna6CqDY2c1+JUJEJS/Be9s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=doBggYFf/++Nkqdxc3Q7xFjFV/QwdwU5eJOfW6//7LAFYowWhufJiQsrusCUOyfqy
	 sf/+bBeGsQz2X2HYHB+wnWN6K2WV0kJQBRRm1je0Tz8WREAla21dWrkTYJ7RPOIGMZ
	 tlFreFS9fovTT2HK6ynl5R3Aq3Jq47nvUanuW3vig06E3AzEfCB9+0PLtpoUyhbdk3
	 NCE72IgKc5Vp+8BrPaZ8gzuYZdjxFp2LzQKTQQhUSI+S7+bVrgKSn+Pn/Mz0dpQPf4
	 q4g67EqiFz5lsSLjAUiruqjsj5A5RE60dVQuW0T+/Y6bjoARpkJAmlzhWmc6wenCSw
	 XCdfzawtJU22w==
Message-ID: <1a47145a-5f6b-4610-b1db-9df18adb77fa@kernel.org>
Date: Wed, 9 Jul 2025 16:01:36 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] dt-bindings: perf: Add devicetree binding for custom
 PPMU
To: Vivek Yadav <vivek.2311@samsung.com>, pankaj.dubey@samsung.com,
 ravi.patel@samsung.com, shradha.t@samsung.com, mturquette@baylibre.com,
 sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 will@kernel.org, mark.rutland@arm.com, s.nawrocki@samsung.com,
 cw00.choi@samsung.com, alim.akhtar@samsung.com, linux-fsd@tesla.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-samsung-soc@vger.kernel.org
References: <20250708103208.79444-1-vivek.2311@samsung.com>
 <CGME20250708103237epcas5p1c4c5d7a5f43c0c88317e74d2f2458a1b@epcas5p1.samsung.com>
 <20250708103208.79444-4-vivek.2311@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250708103208.79444-4-vivek.2311@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/07/2025 12:32, Vivek Yadav wrote:
> Add the dt-binding documentation for the Samsung specific
> Platform Performance Monitoring Unit (PPMU) driver which provides
> performance statistics for AXI bus masters such as MFC.

A nit, subject: drop second/last, redundant "devicetree bindings". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

> 
> Signed-off-by: Ravi Patel <ravi.patel@samsung.com>
> Signed-off-by: Vivek Yadav <vivek.2311@samsung.com>
> ---
>  .../bindings/perf/samsung,ppmu-v2.yaml        | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/samsung,ppmu-v2.yaml
> 
> diff --git a/Documentation/devicetree/bindings/perf/samsung,ppmu-v2.yaml b/Documentation/devicetree/bindings/perf/samsung,ppmu-v2.yaml
> new file mode 100644
> index 000000000000..d137d06b7034
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/perf/samsung,ppmu-v2.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/perf/samsung,ppmu-v2.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung PPMU (Platform Performance Monitoring Unit)
> +
> +maintainers:
> +  - Vivek Yadav <vivek.2311@samsung.com>
> +  - Ravi Patel <ravi.patel@samsung.com>
> +
> +description:
> +  PPMU (Platform Performance Monitoring Unit) provides performance statistics
> +  such as bandwidth, read and write request, transactions count for AXI masters
> +  like MFC.
> +
> +properties:
> +  compatible:
> +    const: samsung,ppmu-v2

What is wrong with existing bindings? Anyway, this must be SoC specific.

> +
> +  reg:
> +    maxItems: 1
> +    description: Memory-mapped register address
> +
> +  clocks:
> +    items:
> +      - description: AXI bus clock
> +      - description: Peripheral clock
> +
> +  clock-names:
> +    items:
> +      - const: aclk
> +      - const: pclk
> +
> +  interrupts:
> +    items:
> +      - description: Overflow interrupt for Counters
> +      - description: Conditional Interrupt Generation (CIG)
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/fsd-clk.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    ppmu@12840000 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +        compatible = "samsung,ppmu-v2";
> +        reg = <0x12840000 0x1000>;
> +        interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clock_mfc MFC_PPMU_MFCD0_IPCLKPORT_ACLK>,
> +                 <&clock_mfc MFC_PPMU_MFCD0_IPCLKPORT_PCLK>;
> +        clock-names = "aclk", "pclk";
> +     };


Best regards,
Krzysztof
