Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ED621128D;
	Wed, 30 Jul 2025 21:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753909912; cv=none; b=eDsdenz1jdGKu/70krksL7NnWzmQYkvDrO7z/Fb66qfL6JMgrot7CeUbe0MwO8QQYsg7aqTpfqXgigPconuuH5h53SMQVohkFbtkm1dLWnUOzGvQMu1esE/DhuAFN+wTfnh0wEPL+iEG3OeJJtNS+r0ekRABHO83N6UYDEs8sxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753909912; c=relaxed/simple;
	bh=sFIpHKRKR7Q2Kj3ofVG6atyA9wvqpFYGRwPhKFIISFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dR5TBVRkoujU6EmsBi6FOXPsncyZKKEly0meSjOWImrv5cKLA81Cb3VcrHusAhERgfRPNNRjX+ESOv6xfVPqkzacfbrhbjF4WQcmGI5mx3z+npixfA2BZblGntA1lVZNWZBZlHvAfLaUDZpwWzQpFs4eZUmWmHmyv3o7T9bMT3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3xABHcP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3xABHcP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2041AC4CEE3;
	Wed, 30 Jul 2025 21:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753909912;
	bh=sFIpHKRKR7Q2Kj3ofVG6atyA9wvqpFYGRwPhKFIISFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n3xABHcPFOX3yvig7wmxjCuJPhi6RshxouhCDUYXPm3K6kFZz8yT/qMOan4XHRzh8
	 gnHZ/FwNJiZkBmERRghPasQypZc8mRk7jASMb8Gi+qRcJQp06eIDLHe62Hc0ftkqQV
	 usOByMpMJJ/qTgGgcOA0oMF7S94yAncpaSzEaDUhIrIP0LfctdsGFUw7yj9sC8q6n2
	 aJiZjJ7+r/H1d51rWcYuVBBWfS5TP0CUPO6qIKHP+dElSAlSsO+EtUJzmL0kN/lUib
	 hglSWftmmXtsFcN1/9fWViL13nc9pcqqKxAxv+Ko7NPxEilIU/v88wQ6ffVblg7KrU
	 TETD/8/Y/SwOQ==
Date: Wed, 30 Jul 2025 16:11:51 -0500
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
Subject: Re: [PATCH v5 06/20] dt-bindings: memory: introduce DDR4
Message-ID: <20250730211151.GA1749004-robh@kernel.org>
References: <20250728-ddrperfm-upstream-v5-0-03f1be8ad396@foss.st.com>
 <20250728-ddrperfm-upstream-v5-6-03f1be8ad396@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250728-ddrperfm-upstream-v5-6-03f1be8ad396@foss.st.com>

On Mon, Jul 28, 2025 at 05:29:37PM +0200, Clément Le Goffic wrote:
> Introduce JEDEC compliant DDR bindings, that use new memory-props binding.
> 
> Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
> ---
>  .../memory-controllers/ddr/jedec,ddr4.yaml         | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,ddr4.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,ddr4.yaml
> new file mode 100644
> index 000000000000..f457066a2f8b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,ddr4.yaml
> @@ -0,0 +1,34 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,ddr4.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: DDR3 SDRAM compliant to JEDEC JESD79-4D
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzk@kernel.org>
> +
> +allOf:
> +  - $ref: jedec,sdram-props.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - pattern: "^ddr4-[0-9a-f]{2},[0-9a-f]{1}$"

Shouldn't this be 'jedec,ddr4-...'

> +      - const: jedec,ddr4
> +
> +required:
> +  - compatible
> +  - density
> +  - io-width
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    ddr {
> +        compatible = "ddr4-ff,f", "jedec,ddr4";
> +        density = <8192>;
> +        io-width = <8>;
> +    };
> 
> -- 
> 2.43.0
> 
