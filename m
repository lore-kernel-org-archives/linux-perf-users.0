Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5933E1720;
	Wed, 27 May 2026 08:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779871522; cv=none; b=FdR/BSlgw5tJbVEgA1FluaSxXS4BJxX+rsx5ESmdkQAjHxr3jm84mZiH0xPwqD3c+D8MX4CLJuPyXGwKMq+Y7Af3XK+WxzY6YMfMk+rzHp7UGZqqtQVbnoh9GNBzYRkUcKzdlR5zgjq5d4Vr2kyCtrLWYFXrGr/E7OFvPM3H2YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779871522; c=relaxed/simple;
	bh=w+DLE+GeSHpDuq4ZaFpzrPwbfVNn/738OqZhq1TDZNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIAVzC3fq5DdZhRJATMCN9KLu1gkF/Vs7ItezDchJymPnPohd1dJCRdzdQIqhKO1OpLgbKH00zQdvHQmy3XsFfUFOq3tU6WdSSekOrqyo7qJ9ycemykHK+sd66HGEZyvjZ6Dcd+HItE+2WWbCoa3Vs92nbHJ/C6OcAwsvMI/I94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQOC9cFu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQOC9cFu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546901F00ADE;
	Wed, 27 May 2026 08:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779871520;
	bh=4fwiisoH+O10cDKs9SXUnzu9+RWmKRkE9L4Uzj4ctHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HQOC9cFuUcgCMXNBo6VkwORPXpnIugUKP/csgboHOPNzfgseAadNARfktDGu04yVj
	 DYV2JlKt5GvM3gS5zbgt0O2Xo+UAcgDgsrQLtG9MUWQSo+S6yzmhrCuzD0N44HWq89
	 fdcJaHjeFGnnzZChGdZxBjy0Umt0KZ56DJUN9coeOVUag+xs/pSXi0DP4/4G/1qqod
	 DiA0jN2ZepWFKzBDhTBIWRezNqSorYSnjSiQMs246enKuPcIW0s4uUoVQfRZWiVSzd
	 Z9SIADgHxI18lB64dN++7w9iWu0xtTG1GHO0ky6122YxD6ZG+ZeV5UbvpUcI+XrVUM
	 tRj/44c1eMJXw==
Date: Wed, 27 May 2026 10:45:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, mark.rutland@arm.com, 
	will@kernel.org, krzk+dt@kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: perf: marvell: Extend CN10K DDR PMU
 binding for CN20K
Message-ID: <20260527-wise-cobra-of-feminism-2720a6@quoll>
References: <20260526164330.23878-1-gakula@marvell.com>
 <20260526164330.23878-2-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260526164330.23878-2-gakula@marvell.com>

On Tue, May 26, 2026 at 10:13:29PM +0530, Geetha sowjanya wrote:
> Marvell CN20K SoCs integrate a DDR Performance Monitoring Unit (PMU)
> associated with the DDR controller. The block provides hardware counters
> to monitor DDR traffic and performance events and is accessed via a
> dedicated MMIO region.
> 
> The CN20K DDR PMU is functionally equivalent to the CN10K DDR PMU, with
> minor register offset differences.
> 
> Changes in v6:
> - dt-bindings: Document CN20K in the existing marvell-cn10k-ddr.yaml;
>   add maintainer, description, compatible enum entry, and a CN20K example
>   with unit-address aligned to reg.

Changelog is not part of commit msg, but changelog area, so after ---.

> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> ---
>  .../bindings/perf/marvell-cn10k-ddr.yaml       | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml b/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml
> index a18dd0a8c43a..79fae9fdb6f1 100644
> --- a/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml
> +++ b/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml
> @@ -4,16 +4,22 @@
>  $id: http://devicetree.org/schemas/perf/marvell-cn10k-ddr.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Marvell CN10K DDR performance monitor
> +title: Marvell CN10K / CN20K DDR performance monitor
> +
> +description:
> +  Performance Monitoring Unit (PMU) for the DDR controller on Marvell
> +  CN10K and CN20K SoCs. The block is accessed via a dedicated MMIO region.
>  
>  maintainers:
>    - Bharat Bhushan <bbhushan2@marvell.com>
> +  - Geetha sowjanya <gakula@marvell.com>
>  
>  properties:
>    compatible:
>      items:
>        - enum:
>            - marvell,cn10k-ddr-pmu
> +          - marvell,cn20k-ddr-pmu
>  
>    reg:
>      maxItems: 1
> @@ -35,3 +41,13 @@ examples:
>              reg = <0x87e1 0xc0000000 0x0 0x10000>;
>          };
>      };
> +  - |
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pmu@c20000000000 {
> +            compatible = "marvell,cn20k-ddr-pmu";
> +            reg = <0xc200 0x00000000 0x0 0x100000>;

No need for a new example.

Best regards,
Krzysztof

