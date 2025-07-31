Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259BA2D0C82;
	Thu, 31 Jul 2025 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753970084; cv=none; b=MoK0eedM3cvf1ugFDQwNU95gaVmpxfha0OSxaoypL/g1ZqbVCqnHd0hbA+EKxseA2zSKp4DxJ3V2QpOMpZwsuw9ssswUCtpwEoWrRCi0/GZ8TEl0+ph8scGQae1BUh2/n9Gwft9VqLT01kFb+XvW3LlLSUXu41+I4P9j0Vmjqww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753970084; c=relaxed/simple;
	bh=eMaB/jC7BQOujSeVyd65hlSZ/jJUt5A5InXdWSnL42Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWnAAnRXeiDsecs05YMPlGBOZTpgVQ4OqRqTZgxfnFMWMU9KYxEFY8PWyWED5JLMipOyKSXXIQQ8B4tcyp7Z4CWbjNsyqoTyc2dRUhpFnA8PTU/fU6mkI997H9X6tcRCO1eiq/u/c4FaoUkiHXE+Xqr1mxPczmC/oPIJcn0iqTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfD/b5JD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfD/b5JD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B785C4CEEF;
	Thu, 31 Jul 2025 13:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753970083;
	bh=eMaB/jC7BQOujSeVyd65hlSZ/jJUt5A5InXdWSnL42Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LfD/b5JDEM4tfHtFXQ7drTEt8aleNybYQzijLgWsq+p+xNnv2CcV45z6g8k5blx1h
	 LJf5RQXMtCD81I18Q730/r1cE/tRooUKRse/MQ/98Qlo+4ZFt5C5W6s1FmE+UiT+fF
	 fGCKKTUwxi15kn0RnwXrfshq0blX42oaFLSpFa3U91GiH3JSQOhvC16wow3IWEPPzg
	 +pTr7wJssZyyxv0p2wNtIHbABvZknQz/dtOcZFP113btCZgTq6Cw9xoAYeYBAp1nma
	 sfJnJs0Bctps/fzgTBSZSILD6YtS6wqLAFG+Uucid+jkpoas5T2SOHxJMNGtmE2Wsc
	 MbABvN8U+VXfA==
Date: Thu, 31 Jul 2025 08:54:42 -0500
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?Cl=E9ment?= Le Goffic <clement.legoffic@foss.st.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Gatien Chevallier <gatien.chevallier@foss.st.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Le Goffic <legoffic.clement@gmail.com>,
	Julius Werner <jwerner@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 12/20] dt-bindings: perf: stm32: introduce DDRPERFM
 dt-bindings
Message-ID: <20250731135442.GA2139000-robh@kernel.org>
References: <20250728-ddrperfm-upstream-v5-0-03f1be8ad396@foss.st.com>
 <20250728-ddrperfm-upstream-v5-12-03f1be8ad396@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250728-ddrperfm-upstream-v5-12-03f1be8ad396@foss.st.com>

On Mon, Jul 28, 2025 at 05:29:43PM +0200, Clément Le Goffic wrote:
> DDRPERFM is the DDR Performance Monitor embedded in STM32MPU SoC.
> It allows to monitor DDR events that come from the DDR Controller
> such as read or write events.
> 
> Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
> ---
>  .../devicetree/bindings/perf/st,stm32-ddr-pmu.yaml | 94 ++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/perf/st,stm32-ddr-pmu.yaml b/Documentation/devicetree/bindings/perf/st,stm32-ddr-pmu.yaml
> new file mode 100644
> index 000000000000..1d97861e3d44
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/perf/st,stm32-ddr-pmu.yaml
> @@ -0,0 +1,94 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/perf/st,stm32-ddr-pmu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +maintainers:
> +  - Clément Le Goffic <legoffic.clement@gmail.com>
> +
> +title: STMicroelectronics STM32 DDR Performance Monitor (DDRPERFM)
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: st,stm32mp131-ddr-pmu
> +      - items:
> +          - enum:
> +              - st,stm32mp151-ddr-pmu
> +          - const: st,stm32mp131-ddr-pmu
> +      - items:
> +          - const: st,stm32mp251-ddr-pmu

This and the 1st entry can be a single enum.

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  access-controllers:
> +    minItems: 1
> +    maxItems: 2
> +
> +  memory-channel:
> +    description:
> +      The memory channel this DDRPERFM is attached to.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: st,stm32mp131-ddr-pmu
> +    then:
> +      required:
> +        - clocks
> +        - resets
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: st,stm32mp251-ddr-pmu
> +    then:
> +      required:
> +        - access-controllers
> +        - memory-channel
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/stm32mp1-clks.h>
> +    #include <dt-bindings/reset/stm32mp1-resets.h>
> +
> +    perf@5a007000 {
> +        compatible = "st,stm32mp151-ddr-pmu", "st,stm32mp131-ddr-pmu";
> +        reg = <0x5a007000 0x400>;
> +        clocks = <&rcc DDRPERFM>;
> +        resets = <&rcc DDRPERFM_R>;
> +    };
> +
> +  - |
> +    ddr_channel: sdram-channel-0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        compatible = "jedec,ddr4-channel";
> +        io-width = <16>;
> +    };
> +
> +    perf@48041000 {
> +      compatible = "st,stm32mp251-ddr-pmu";
> +      reg = <0x48041000 0x400>;
> +      access-controllers = <&rcc 104>;
> +      memory-channel = <&ddr_channel>;
> +    };
> 
> -- 
> 2.43.0
> 
