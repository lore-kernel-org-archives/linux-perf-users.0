Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793697900;
	b=onOYPNNmvoj7VRTayZ0ky56Y1jojvm80heCtxT2iRObiC3ZHkMfr/LGm0APoJuc5akd2
	 fW5029BGkOrXJN4SWYmzjPZWipvslz4UXNY+s3MKvqjTo1igGPrjSSYTuszqYnwQiH4cj
	 cuLJpu5xsRke+T9SpFLXZKV/36aDf1Lzm8YXy8FKgMvNgN+c+e/jLoFW1MJW6E4HvVGYd
	 MtFmagJBI32YrZCoSVbGeuUJkeedWlbDS/ycXIAmAqWHwiJWkJJqi0zUYlZC7t/Dxdkqh
	 PCBfH6VXmzdcYepHBpV83Bb3ZMPme8obnq52ystMtnyZLekbrKehd2Jhlo4BiYfjHuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697900;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Y53QIYpD7wjqmJYR8fzWA4+4yo7uKK86RU2Kss38ssY=;
	b=YRpQdlqeYPni/McJJusRZPtG97f0u1U3WfEXgQtkJfoob6cSpgwu/Sg3FYNEERCZBB4+
	 xKxU1W46zy33hNaw9yhNuZuk3xgp2kZjSHFGm3oo080CrkOIOLX6twX+Z16dU8R+ZH2hD
	 8UwQwr3S2KZOb5ktP70ZzaWpKvPUacX9HmCHfT956AkgvyAAMsl+ISP3zD1o4Z2F8MQ/b
	 Wqca4okiOksTuK/KbqvXTHI/CYamgPuviTrXfws/gtNZu/7FAJ4nhHSvpXNL0MQy1vJbc
	 NrHOvIDgGMFTGXn+dHFUd+fzod6iUVj8nx/fjIFfAy8abL78xHpMEqpHIC8H8GeUvBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K3yrovMq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458C6606A324;
	Tue,  3 Nov 2026 09:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K3yrovMq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21911F000C1;
	Tue,  3 Nov 2026 09:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793697899;
	bh=Y53QIYpD7wjqmJYR8fzWA4+4yo7uKK86RU2Kss38ssY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K3yrovMqdy6HhmOPbm4Ti0es2kgNpyacjrgDG2XoZVRiiVLu0G5H2da3S8d05b9/8
	 F25G+k7Hbws5INlfoVJyodRN8+tqKBgNLv3xBa+p6v3ZjY4D8UNwFiBVhzAW7We/Oo
	 iInPY9idqDd596i70NbQkSZBL+/tooOLc5y681PjOKaXIog/+gKNpeOagk/tD4jWPB
	 moTQRizAWIp3QwGwCqxy/DiIlWUwNdR/dC6z0ZYnz3e3LvbfUcmsCH7qkmWX+N2ndV
	 fT2z2TPd6EXmtl1JAzKEs2ouxyltBOCHOEL5U3B8c1TCOyqGFSnowgZXDcbjVxycrW
	 54WNB0JVOz8Hg==
Date: Tue, 3 Nov 2026 10:24:56 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Dom Cobley <popcornmix@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, Stefan Wahren <wahrenst@gmx.net>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, 
	linux-perf-users@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 1/3] dt-bindings: perf: Add Broadcom Raspberry Pi AXI
 PMU definition
Message-ID: <20261103-electronic-teal-kraken-5ebcec@quoll>
References: <20261103041416.2940213-1-irogers@google.com>
 <20261103041416.2940213-2-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103041416.2940213-2-irogers@google.com>

On Mon, Nov 02, 2026 at 08:14:14PM -0800, Ian Rogers wrote:
> Add device tree bindings for the Broadcom Raspberry Pi AXI PMU block
> found on BCM2835, BCM2711, and BCM2712 SoCs.
> 
> Depending on the SoC and security configuration, these PMUs support
> either direct MMIO access for the System monitor or routing via the
> Raspberry Pi firmware mailbox IPC for the VideoCore VPU monitor.

In such case, where is mboxes property?

> 
> Co-developed-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  .../bindings/perf/brcm,bcm2835-axiperf.yaml   | 50 +++++++++++++++++++
>  MAINTAINERS                                   |  7 +++
>  2 files changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml

...

> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The Broadcom BCM2835 series (including BCM2711 and BCM2712) features hardware
> +  performance monitors on the AXI bus for evaluating memory bandwidth and
> +  system traffic. Two monitor register blocks are present: the primary monitor
> +  evaluates the System fabric, while the secondary monitor evaluates the
> +  VideoCore VPU fabric. This block is distinct from the BCM5301X AXI Trace
> +  Module.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - brcm,bcm2711-axiperf
> +      - brcm,bcm2712-axiperf
> +      - brcm,bcm2835-axiperf
> +
> +  reg:
> +    items:
> +      - description: System monitor registers
> +      - description: VPU monitor registers
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pmu@7e009800 {
> +        compatible = "brcm,bcm2835-axiperf";
> +        reg = <0x7e009800 0x100>,
> +              <0x7ee08000 0x100>;
> +    };
> +  - |
> +    pmu@7c012800 {
> +        compatible = "brcm,bcm2712-axiperf";
> +        reg = <0x7c012800 0x100>,
> +              <0x7ee00000 0x100>;
> +    };

Drop the second example, redundant. They are the same.

Best regards,
Krzysztof

