Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E2A3EB11C;
	Sun,  4 Oct 2026 07:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791099094; cv=none; b=uuOxdgpVErXGrA8pEf99/PbhybfUGJTKQqofcNwFaurnISEjw31+HZU7YpXRXNpSfvIwEa4cthTt6S5asLmqvnNyV/WwUVpPDt06KUR6QEdvdm+IUImsYlhzjimzV/3oX0HA9tWWeHp0VlOxV9BMR5uHN7NGzR3/rXx+uvs7PX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791099094; c=relaxed/simple;
	bh=fi/dxc6xXcysEzRvzxmtVHLd6IJ5+oazB8QjfsD7in8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MW7A9/KG92VW/wk2Prq66rfrJ05te7yD+jA727Tfj1HuEIE4HhJPaukq7JKQc9x2KTR2Ui62lQVPJbLbvvWsZqWxvo9zLBjkHyY5pJ/YNhusWhjIaMEEBskzaOBuXuksr3GJzd10XVw7VLEaP4empAZz/mtJLPYsoiZWI2r6x58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abDMitp5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abDMitp5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6014E1F000FF;
	Sun,  4 Oct 2026 07:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791099092;
	bh=AaALBH7KtyB3bx5d8xgg7P/JbOXz1TSQ5t12mUF5/lQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=abDMitp54FxhagYBgoG+kvko9jBduTfHfZ9zabX/y2DyVZjoF9Lqxvzehh2sf2f2u
	 3IgtZ7rkl1XKyYTdUWDuWgAe7hLdow+htO4bmUr1NCqCu72QJRCSfmbeHwlJkWmuP+
	 YNX9kd3C0ZdglEdiOwtj3JtUidmmDCCOcBLAO/y74lEZzn0g3RHpLjSgovnQR0xezg
	 Uu+QcStwHnFRlOE6675ZCRxJxibzbszAHN6B4bX/PmMmEF2LU7dy9JChygxbJXTi+/
	 EshXkc/ss7C7KfOO7QOkV4+Ez4128c62jJvEwRds2tbF6Pc5qLlX/xplSepOdn+mRp
	 JCw2atTLyD7kw==
Date: Sun, 4 Oct 2026 09:31:30 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	bcm-kernel-feedback-list@broadcom.com, Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Peter Robinson <pbrobinson@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 1/3] dt-bindings: perf: Add Broadcom Raspberry Pi AXI
 PMU definition
Message-ID: <20261004-tricky-eggplant-galago-baea94@quoll>
References: <20261002175738.3242646-1-irogers@google.com>
 <20261002175738.3242646-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261002175738.3242646-2-irogers@google.com>

On Fri, Oct 02, 2026 at 10:57:34AM -0700, Ian Rogers wrote:
> Add device tree bindings for the Broadcom Raspberry Pi AXI PMU block
> found on BCM2835, BCM2711, and BCM2712 SoCs.
> 
> Depending on the SoC and security configuration, these PMUs support
> either direct MMIO access for the System monitor or routing via the
> Raspberry Pi firmware mailbox IPC for the VideoCore VPU monitor.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---

I could not find lore links in your cover letter, changelog is cut (only
v13), so probably we are repeating. Please start using b4 if providing
entire changelog with links is too difficult.

>  .../bindings/perf/brcm,bcm2835-axiperf.yaml   | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml
> 
> diff --git a/Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml b/Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml
> new file mode 100644
> index 000000000000..fcffa5fc6c02
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/perf/brcm,bcm2835-axiperf.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BCM2835/2711/2712 AXI Performance Monitor
> +
> +maintainers:
> +  - Ian Rogers <irogers@google.com>
> +  - Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>

Drop

> +
> +description: |
> +  The Broadcom BCM2835 series (including BCM2711 and BCM2712) features hardware
> +  performance monitors on the AXI bus for evaluating memory bandwidth and
> +  system traffic. Depending on the SoC architecture, multiple monitors exist.
> +  The primary monitor evaluates the System fabric, while the secondary monitor
> +  evaluates the VideoCore VPU hardware.
> +
> +  Older silicon generally restricts direct MMIO access to the VPU endpoints,
> +  requiring them to be accessed over the Raspberry Pi firmware mailbox
> +  interface. If the VPU endpoints are memory-mapped, they are supplied as
> +  secondary resources.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - brcm,bcm2835-axiperf
> +      - brcm,bcm2711-axiperf

Why random order? Keep the list properly sorted by name.

> +      - brcm,bcm2712-axiperf
> +
> +  reg:
> +    minItems: 1
> +    items:
> +      - description: System monitor MMIO surface
> +      - description: VPU monitor MMIO surface
> +    description: |
> +      Memory-mapped I/O resource regions for the AXI PMU endpoints.
> +      Typically ordered as System monitor, followed by VPU monitor if directly
> +      mapped.
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
> +            enum:
> +              - brcm,bcm2712-axiperf
> +    then:
> +      properties:
> +        reg:
> +          maxItems: 1

Why brcm,bcm2835-axiperf has flexible number of addresses?

Best regards,
Krzysztof

