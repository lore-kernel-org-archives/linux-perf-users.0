Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51C5BA36;
	Tue, 22 Jul 2025 17:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753203680; cv=none; b=nQDwgk0cdG9lRBSEOSNl5zEShffj9Qhz5ovdoA1Lno8VfGwmXKVQuuNkUpn4SBf34AELpnzKlm4tTXZyLTT1FjZAru4lYPnRxoCH/MtD/FqdFTGRnelm2uL7rhQ0WuXptvDUp1mCUTG3NPNZipZC4QVdWVAy0iqCpgYYQO2Reg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753203680; c=relaxed/simple;
	bh=4ExxWF210EVKXVfZ8XRUE1perdO4miFY1lWLlDpGXyE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Jeg4NF2gNFA7FslF+KBiq1EG581MzfwRU6vkOYK1IWey1EuqUoLvaQAdWvJSvJOvJWuoSMewa7tXdYleyH783nS3Yn6vZY0U4Zbq5g61tvr0m5gLekTA9MoSRa0BijDxMh7F3pgbkkOzp6ld7hB7cIZDtK0d0U/U34s2IYZ0rGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1qzI20y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1qzI20y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034DDC4CEEB;
	Tue, 22 Jul 2025 17:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753203680;
	bh=4ExxWF210EVKXVfZ8XRUE1perdO4miFY1lWLlDpGXyE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=o1qzI20yrVdhUnbNKS9chhnWZwfsufwiVXUoOBR5Nzqdw4VuznVLUtui48AqcvckC
	 dksJVF+i5y4kslxWQZQSbXWGchZw/2Vnydl1hmZ8MCBw3tTb7lKjvZ80/jWQKNNGzF
	 PxTgOs34OjapDTx9a2Y80Wk4bp7d1/jrUPkELzwhXxJn6f8UrfOIX0PIPqIVfqO2Df
	 CJHRsHhmxBuI6EjTWH+DSFGpZpqzQ559K9Vt3euNX2h57Hoqhp123HjpkZUmQHGvrl
	 OaieU6ya2bzCTb4dzFod3SamD0A9iFYEGl0+ELuDNjUWsaLEWupl7EPr1vj26f83VY
	 MM1BiQ/ZB1Qbg==
Date: Tue, 22 Jul 2025 12:01:19 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Will Deacon <will@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 linux-arm-kernel@lists.infradead.org, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Gatien Chevallier <gatien.chevallier@foss.st.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Michael Turquette <mturquette@baylibre.com>, devicetree@vger.kernel.org, 
 Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 linux-clk@vger.kernel.org, linux-doc@vger.kernel.org, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Conor Dooley <conor+dt@kernel.org>, linux-perf-users@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, Julius Werner <jwerner@chromium.org>, 
 Le Goffic <legoffic.clement@gmail.com>, 
 linux-stm32@st-md-mailman.stormreply.com, Stephen Boyd <sboyd@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
To: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
In-Reply-To: <20250722-ddrperfm-upstream-v3-11-7b7a4f3dc8a0@foss.st.com>
References: <20250722-ddrperfm-upstream-v3-0-7b7a4f3dc8a0@foss.st.com>
 <20250722-ddrperfm-upstream-v3-11-7b7a4f3dc8a0@foss.st.com>
Message-Id: <175320367908.42297.8460265656019241171.robh@kernel.org>
Subject: Re: [PATCH v3 11/19] dt-bindings: perf: stm32: introduce DDRPERFM
 dt-bindings


On Tue, 22 Jul 2025 16:03:28 +0200, Clément Le Goffic wrote:
> DDRPERFM is the DDR Performance Monitor embedded in STM32MPU SoC.
> It allows to monitor DDR events that come from the DDR Controller
> such as read or write events.
> 
> Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
> ---
>  .../devicetree/bindings/perf/st,stm32-ddr-pmu.yaml | 94 ++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/perf/st,stm32-ddr-pmu.example.dtb: /example-1/ddr3-channel: failed to match any schema with compatible: ['jedec,ddr3-channel']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250722-ddrperfm-upstream-v3-11-7b7a4f3dc8a0@foss.st.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

