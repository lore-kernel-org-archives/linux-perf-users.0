Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC9E30568B;
	Mon, 17 Aug 2026 06:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786947799; cv=none; b=ICX//oinKzUaO5j2eO0UbA4n+ZBhUEqI9RQJYXACKPVLLQyUaFn5ZJ0sz9/FmOGfjMOCHmU49qYI59xAWIVhjmj06UMezN86Q4476I6cyWPUHl9Tnypu8Nc1mDtVZf2jQMmxwfYH342k2QIDHxwM6Zq6+ejXOutMBpGkoZdIJYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786947799; c=relaxed/simple;
	bh=sIyThNWYWnlWHpUxaSlXTe6JeQIRE+fhcjoMqfYf4xg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=avA7/o9qC3myvA9zx/VM0f5Gcezeg7HR6N7aRAsaqdcOBF7K4OZMxDZBkZnjfJVzqapxOuqP5ni2a39x7pk5ouL5ModooS7iLksuB3aBMs5ITKowdC4hvl/BYhUDTUm42ZH19LjmhiY+cUGWAFSqv/NBXTwsesmfjoIa9Qqk/Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNwPL6Qm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNwPL6Qm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999F31F000E9;
	Mon, 17 Aug 2026 06:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786947797;
	bh=jOw+j1q+Tq+Mexz//qGGI8SqaRBLcQGBThbcAl9p1Go=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=YNwPL6QmU5C3HJm060nzfgtL+xf0UOxLnRJdelGugZbuMDrb5lip493qGL9lQgExP
	 tl2Ti6fXt1XPb8c2fg2Z12VDvqf+cGwYZuKa0JcBTHt9LGDSV2LPM5EgXacy+7/Opr
	 NjeuGrnxORsx2Ibg0lLhpjAJnfoK+6sVs3zMvxxwYcD3lbFkPYJOwsM9k0kt4iP71N
	 U9r6/fCJ4ZMPQfRHmFe9MFHN0Q4QZ35hgVGsHdVP8GhPrlrcam0o3yqMQ1hAZvVYuF
	 vt26w5nKTwR0coqYQj2p/aDjPnqWOnPGnJ6C9qhniNQBQxj2UYkiHFa/TduuYW5Jf6
	 nvydrMdKvWwww==
Message-ID: <bca067e2-bbd7-43cf-9198-32bf4de35a7a@kernel.org>
Date: Mon, 17 Aug 2026 08:23:13 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 1/3] dt-bindings: perf: Add Broadcom Raspberry Pi AXI
 PMU definition
To: Ian Rogers <irogers@google.com>, florian.fainelli@broadcom.com,
 linux-perf-users@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 pbrobinson@gmail.com
References: <20260815082048.4043217-1-irogers@google.com>
 <20260815172712.50119-1-irogers@google.com>
 <20260815172712.50119-2-irogers@google.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20260815172712.50119-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/08/2026 19:27, Ian Rogers wrote:
> Add Device Tree bindings for the Broadcom AXI PMU hardware blocks present
> in the Raspberry Pi SoC line (BCM2835, BCM2711, BCM2712).
> 
> Depending on the SoC and security configuration, these PMUs support either
> direct MMIO access or routing via the Raspberry Pi firmware Mailbox IPC.
> The bindings support defining 1 or 2 backing MMIO regions natively map
> the system and VPU control surfaces.
> 
> Assisted-by: Antigravity:gemini-3.6-flash
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  .../bindings/perf/brcm,bcm2835-axiperf.yaml   | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml
> 
> diff --git a/Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml b/Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml
> new file mode 100644
> index 000000000000..8a4857aa448c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml
> @@ -0,0 +1,77 @@
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
> +
> +description: |
> +  The Broadcom BCM2835 series (including BCM2711 and BCM2712) features hardware
> +  performance monitors on the AXI bus for evaluating memory bandwidth and
> +  system traffic. Depending on the SoC architecture, multiple monitors exist.
> +  The primary
> +  monitor evaluates the System fabric, while the secondary monitor evaluates the
> +  VideoCore VPU hardware.
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
> +      - brcm,bcm2712-axiperf
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +    description: |
> +      Memory-mapped I/O resource regions for the AXI PMU endpoints.
> +      Typically ordered as System monitor, followed by VPU monitor if directly
> +      mapped.
> +
> +  firmware:
> +    $ref: /schemas/types.yaml#/definitions/phandle

This was already rejected.

https://lore.kernel.org/all/?q=broadcom+firmware

> +    description: |
> +      Phandle to the Raspberry Pi firmware node. Required on older silicon
> +      (BCM2835-BCM2711) where VideoCore VPU endpoints are exclusively accessed
> +      via firmware mailbox IPC.


Best regards,
Krzysztof
