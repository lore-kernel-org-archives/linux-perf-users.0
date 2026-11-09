Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235874;
	b=fXrGAyrnORyKSBWhWPdFOk/zzmlnlyQSLzipGRStb43h+ViaLKQ2aDgH0ugaVYkK8pp8
	 2d2BZg3Tok53KCrsL9Hc3xSdnxJeIF7olyEfh1EF6e3VJVWOYdnW1dEza9zPfbmZMSc7J
	 LVaZBNmEJJ+jYXemFwoeEjjewnPOF65kt7QyWocE8kW83t4w0uVtqkulRwxqlzX6Uy3VY
	 EGOhRvufKk2etc1EYgnVphLdcwrxdwldFR4AH3ksWJwQbp6sJSzCgnblc4dAyNTUqIYhz
	 rQFS9BoI98vHEpAEvdNb2/4O4T3eX6iftb2w8eqIJQEcFbLcu6Ai8NPbeO/yKoT91Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235874;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=pM4LipmI99ts7wfLn3qsR8+LD0Ifz71Ahhr5FYGBQ4s=;
	b=cgR2UmX0Pmzh8NXk5o7ZnXtFfaa3IpDc5MntHOQ/vbUv5UhAc2CZ5tIxBRMGqRLU5XCW
	 zv6GHU03afh49aMXT2LC49OZ8TdmbnC5+PWEXEyLnPLHzHcLNzk2CL2AecWA8g6Gy8D97
	 YhwsDiF/xi05C6ks28q85mXtLoon5M/cYkKax0wFjGRfUtGXY54fZAiCe0hDgIgXkEqqa
	 GEJ1DZ9JnE4FyUqhYz1A/Oxl+WqNai/Z/a2uartHW0/ZyzXm+9YEXAj2KYD4OBLmfoBMX
	 DIuuB7Tihr53FbyYDPaSrx3IlLVi39N1AQ7HKTkiiz9orRLunjDQJwEIN+mScrY1qrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aOf0s6xz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32508606A321;
	Mon,  9 Nov 2026 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aOf0s6xz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3DF1F0089F;
	Mon,  9 Nov 2026 14:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794235873;
	bh=pM4LipmI99ts7wfLn3qsR8+LD0Ifz71Ahhr5FYGBQ4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aOf0s6xzsne0Ce67KvbSWi7+yFLYuu1UzCT0NV+sxtYUffj01d8FsQNIe51ES0kRb
	 LOJ4pdgQq/lgMjCqu5tI0L29yl1+Qgn5Mrvhat02h1C20iJ4FvTqg8lQrKdSILLt7T
	 WCj1uKdtbPgBeFSKKPshOCIhtTntUQ7HeMyqvfC1E7/Z6irjzK8ztlQkC/8Qrk2bkD
	 clTQSOvYjj6C91uMNFJ8jtQfMAykBfYua4hjI6QRJcwLUbp3EwWuvKsGGZvhclkV79
	 QRCxIEWJ8Mdm0YdmdvZ2t5cWjrKz14AYMh8WevL9vinjtueLthPC9rnqJfdCO3/l+x
	 v+CcpGxp0V/Gw==
Date: Mon, 9 Nov 2026 08:51:10 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	Dom Cobley <popcornmix@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Uwe Kleine-Koenig <u.kleine-koenig@baylibre.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v19 1/3] dt-bindings: perf: Add Broadcom Raspberry Pi AXI
 PMU definition
Message-ID: <179423587020.3133545.6594248101575070050.robh@kernel.org>
References: <20261109080126.417161-1-irogers@google.com>
 <20261109080126.417161-2-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109080126.417161-2-irogers@google.com>


On Mon, 09 Nov 2026 00:01:24 -0800, Ian Rogers wrote:
> Add device tree bindings for the Broadcom Raspberry Pi AXI PMU block
> found on BCM2835, BCM2711, and BCM2712 SoCs.
> 
> The hardware exposes two MMIO register blocks: the primary monitor
> evaluates the System fabric and the secondary monitor evaluates the
> VideoCore VPU fabric.
> 
> Co-developed-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  .../bindings/perf/brcm,bcm2835-axiperf.yaml   | 44 +++++++++++++++++++
>  MAINTAINERS                                   |  7 +++
>  2 files changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

