Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804830;
	b=JQJf/qzEzn1LaI6d589bsRNukyQPF0zrHDEh0mQc1LRus/x8zxImAG07E3cdXa1dEiYZ
	 ziVWrast1wLic8vSGTnhK9S2oLTZxjUk3QL7Cs6pGXWJnDWvMTDYUifxla0W26TWyMTW/
	 BF5IeXisUJiaXLzdnYWM3wk/C0kPpc+T5JDu+utM775yNQbLMG50d6ox6E0MQYmP9KyG8
	 r6k8kWVQC3Cogiypkrr4EuBbPMsCP70ljv0uL3aXwpE4sv91o9zr3NL1bvtRxl2fmtLy6
	 tvn78lxPxPHjJEThYkb6afuQQePPf1JHTKdtKWmHQCoapQYjcg+t1brVqW8bXi9xrwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804830;
	h=Received:DKIM-Signature:Date:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:From:Cc:To:In-Reply-To:References:Message-Id:Subject;
	bh=IF5JmCW1BC4BgBsc5mQFMDf74ipcvoOsW/SYkFaxrng=;
	b=krkXSFjP0z8a84HhX0kXTlyTVJVDroSj6yKoowFaaa8OFF3GGsv/GnwRww/b8W0y+faV
	 cnRPpG8oaLIDVJOswCeEWQxARRbX4t5Qy2esj8q7sZemKq3FQqDmpwz6jLa/V86wGb2YQ
	 63ri+hOw8XftbWVudOIwRwdFuE+6cEfZykE+myI3EdVDWM5/ttV7jwb5oO+/a11jpkEM8
	 tC65DeKCWEufzDzvuDi4cZrWCI/hKgaRjLMWJK66hNHyrFDWKFx49qgUj2sEmNlULihsd
	 D/P6FDkfsrQZ5njCrju4eU3tCLOlPBHNj90mGqSHsitk5n1WIqdWnIN/377FXUlTVJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZc30TXs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BD8606A326;
	Wed,  4 Nov 2026 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZc30TXs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8953D1F00A20;
	Wed,  4 Nov 2026 15:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793804829;
	bh=IF5JmCW1BC4BgBsc5mQFMDf74ipcvoOsW/SYkFaxrng=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=BZc30TXslnJqS4sHCg405QqTCny7j/2zxR/saesz+OqWOde9X+qFA0WELQX4/T0bT
	 pm8RDbnBJ0dpNfuQFDd5WaFBighRep8V5vPi/UZ881BzFwaenZ3ugzJrqvicsjJEkN
	 onxcrMOVAg5oLbhFuuW7076Y2/kIMF4E6Tcrsb/1hK8H3Cy9vo0IPqx6smG2KxjSe6
	 fCvYuWZ7tV3eRNcCdLhcAvMLv1DKR9ML1vJIbR/B/zjZ60wvSEMmAPfrD2aMKynRLm
	 dkm+4Y/STrsPEU2IJXXf35CxR8Jsv3YVisRphf5ZYDY3OwKSSeBH9Dy7G74pOUESn4
	 dSq16UKUy/IVg==
Date: Wed, 04 Nov 2026 09:07:07 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-rpi-kernel@lists.infradead.org, 
 Conor Dooley <conor+dt@kernel.org>, Dom Cobley <popcornmix@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Stefan Wahren <wahrenst@gmx.net>, Scott Branden <sbranden@broadcom.com>, 
 bcm-kernel-feedback-list@broadcom.com, Mark Rutland <mark.rutland@arm.com>, 
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Ray Jui <rjui@broadcom.com>, Will Deacon <will@kernel.org>
To: Ian Rogers <irogers@google.com>
In-Reply-To: <20261104030300.1140180-2-irogers@google.com>
References: <20261104030300.1140180-1-irogers@google.com>
 <20261104030300.1140180-2-irogers@google.com>
Message-Id: <179380478743.1076165.493810572910679874.robh@kernel.org>
Subject: Re: [PATCH v17 1/3] dt-bindings: perf: Add Broadcom Raspberry Pi
 AXI PMU definition


On Tue, 03 Nov 2026 19:02:58 -0800, Ian Rogers wrote:
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

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml:15:58: [error] syntax error: mapping values are not allowed here (syntax)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml: ignoring, error parsing file
./Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml: error loading YAML: mapping values are not allowed here
  in "./Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml", line 15, column 58
./Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml:15:58: mapping values are not allowed here
make[2]: *** Deleting file 'Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.example.dts'
Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml:15:58: mapping values are not allowed here
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/linux-dt-review/Makefile:1726: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20261104030300.1140180-2-irogers@google.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

