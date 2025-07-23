Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FBB8F58;
	Wed, 23 Jul 2025 13:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278110; cv=none; b=HpYv5UkPUkYYvsZmzS+ivwf5zKK1iSryVEdfe4B78wTXI11ofH3qPC2x/71Vq9iIklG0G+ZKsWzQ70t10nKSb00QzSyh34qiLgkqaMiY7iLRRi1LlNWj8Eq340FPgq/BUyRnc0CDHgEd2xq8ZT8jOcT7wtKMmUTVIzjYVA+OwKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278110; c=relaxed/simple;
	bh=zxxC/wQlJmLxLa47Q7NNudHjnXvG/vCvKPONP/39QCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9XLCCby8Zb0AdDah6bPznl6pd84WwpjTwHlf2AM6/YDb8zoS8j9FsKeFS+iTIj7wMR/luRDVlKklgFGKYIEPy72/09HpGdN8LUWL84nNA06sGTOhC03j32YPAybqlX1XePnrbJvn8k9dGrRlCLLV0wik4yhtfNuE4GFI50lf9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmuG7qTl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmuG7qTl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DD9C4CEE7;
	Wed, 23 Jul 2025 13:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753278109;
	bh=zxxC/wQlJmLxLa47Q7NNudHjnXvG/vCvKPONP/39QCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PmuG7qTl4sg7/QMBKgyBmArSjY7MW6zMzETCIkWyLdi81B49I4VHdhuWfDtD85keA
	 s1bLp3unFlREP9Un4fUUX5JziSZMKwf4Hw/KgMn4VmYohw3DYwp/XXVUfyBh5wkyD3
	 R09TNEfWqkjGMY/LeDVi0f9DYMrxS2enzACUqqbvhnTzVcHNryjALifb57fyVeXAHb
	 L1ILoKBkyV+Sg2NQ8JbJ+iBlFG6RrkLTutCNyS6FMTUcZyOmERe66AVfkM7t7YxQvS
	 J5Dx9ktAMD/94OEX5E4E6anz65xzMbxXPuCU2irBMH4pS5JuXICjJt5QYIrsV2r6ZK
	 GQzPzDIu1LfKg==
Date: Wed, 23 Jul 2025 08:41:48 -0500
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
Subject: Re: [PATCH v4 02/20] dt-bindings: stm32: stm32mp25: add
 `access-controller-cell` property
Message-ID: <20250723134148.GA2136293-robh@kernel.org>
References: <20250723-ddrperfm-upstream-v4-0-1aa53ca319f4@foss.st.com>
 <20250723-ddrperfm-upstream-v4-2-1aa53ca319f4@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250723-ddrperfm-upstream-v4-2-1aa53ca319f4@foss.st.com>

On Wed, Jul 23, 2025 at 03:05:46PM +0200, Clément Le Goffic wrote:
> RCC is able to check the availability of a clock.
> Allow to query the RCC with a firewall ID.

The subject is wrong. There is no such "access-controller-cell" 
property.
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
