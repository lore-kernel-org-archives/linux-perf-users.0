Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118482D0C7F;
	Tue, 15 Jul 2025 03:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752549441; cv=none; b=clNSKT1q/UVLInT7bfpHfwK0LVGbFEltBbU/HF+ioO34bD1DN/uu0OBYOmq2LUMCmxHHpovLRSlmsPCD2CSuWV1mfgrFlDcn1mPcMeBb/SskV886KNHm00iAzU2UiZ89W9MxXn4fNFkQw7OSSsrkgvmr4gbdu96IOi1WyokXEnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752549441; c=relaxed/simple;
	bh=HTtawzgAqQ5YOwB+NQpNjeTVyd8WRqp+ZD4g6gH58Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxabFhdXhaMKL7YqGEsGt0WG+bJDRwPgY6+CTV+5Rp/37VIER47IWLUrfaUWAOPKe2eW3CcMN9TcAqW9G93CkpO9Hwa4uvT3h3JLO5f6kfSDXkuzEDQi9jrILrKarCcH7S6hvnGUF7WITDpmYyO9qemX//ppy5WmE7pPO0/x2PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiSEOjDN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiSEOjDN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72792C4CEED;
	Tue, 15 Jul 2025 03:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752549438;
	bh=HTtawzgAqQ5YOwB+NQpNjeTVyd8WRqp+ZD4g6gH58Fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SiSEOjDNHhYoDZQ4MKAicWSMZ0G8HtCCla9dnikgDs90hfnGgyOloW6Q+SywPrIe9
	 HfYw/7VWPZi3LUUycotG/9lXaKXVUFjlM0Qu3eklGU0NqGGrEXhyuG3xeqmZLdLUoo
	 TT/QAA5YfMmtFMAzzUJRAlNP84SwaGbH/nmNdtmown9T/X/BaJ4rNBmOKjvDxEmc69
	 xcJjTMPHvQP1Z8s9XFiL5lwbxd6yLzO7vfCqtkSW13124agCEXl86ALj2l0pNxqJ5E
	 ux0Nmi+b0kc/b/e3wChw3gjl2iW3LcMiR0FAiaVxyjzrbAu0vkKGPjZotQaX7Kf7HS
	 WXBm/i/hn2a4Q==
Date: Mon, 14 Jul 2025 22:17:17 -0500
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
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 02/16] dt-bindings: stm32: stm32mp25: add
 `access-controller-cell` property
Message-ID: <20250715031717.GA4144523-robh@kernel.org>
References: <20250711-ddrperfm-upstream-v2-0-cdece720348f@foss.st.com>
 <20250711-ddrperfm-upstream-v2-2-cdece720348f@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250711-ddrperfm-upstream-v2-2-cdece720348f@foss.st.com>

On Fri, Jul 11, 2025 at 04:48:54PM +0200, Clément Le Goffic wrote:
> RCC is able to check the availability of a clock.
> Allow to query the RCC with a firewall ID.

If it is tied to a clock, do we need another provider? We have the 
"protected clocks" thing, but that might be a bit different.

> 
> Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
> ---
>  Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml b/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
> index 88e52f10d1ec..4d471e3d89bc 100644
> --- a/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
> @@ -31,6 +31,11 @@ properties:
>    '#reset-cells':
>      const: 1
>  
> +  '#access-controller-cells':
> +    const: 1
> +    description:
> +      Contains the firewall ID associated to the peripheral.
> +
>    clocks:
>      items:
>        - description: CK_SCMI_HSE High Speed External oscillator (8 to 48 MHz)
> @@ -123,6 +128,7 @@ required:
>    - reg
>    - '#clock-cells'
>    - '#reset-cells'
> +  - '#access-controller-cells'
>    - clocks
>  
>  additionalProperties: false
> @@ -136,6 +142,7 @@ examples:
>          reg = <0x44200000 0x10000>;
>          #clock-cells = <1>;
>          #reset-cells = <1>;
> +        #access-controller-cells = <1>;
>          clocks =  <&scmi_clk CK_SCMI_HSE>,
>                    <&scmi_clk CK_SCMI_HSI>,
>                    <&scmi_clk CK_SCMI_MSI>,
> 
> -- 
> 2.43.0
> 
