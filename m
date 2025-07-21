Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EB621FF3E;
	Mon, 21 Jul 2025 20:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753128568; cv=none; b=dkdJZwL2Mo2gpxmDZSHCBleD4Yyq4ofaHaeyZaggLSmz4Mm5V09FIKNoJhbwuBhUUsLEoCH/Y82Ey185Nz6/DFyZ0ejfamVI1UiTNXMConu5bn51ctO8fwDD40AmY/aoVzwNOjBZc0w2XyRa5tGiq2WXqRImCMPIcMZcXy2NP+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753128568; c=relaxed/simple;
	bh=0tI7Ckz46vRExgHt7/KrtPSDrZcdVJNbVoF8HN/Bt+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtuPoHWwgyApaRHoWVJEyD7VhKJI6Z5qJ10OtkC/Pb0rp7XDoWFtzozYLhVU1Iep23TnOBCWnbMbrfuJWtzdgwQWYiK5smbtRcgAy0Byo83kvE2w22orn08CXdKCbs91C6UVlLkpPce42e8u1upH+K0d9tCUQCRCiCI9iqd+/FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLNm4FZ5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLNm4FZ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3ACC4CEED;
	Mon, 21 Jul 2025 20:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753128567;
	bh=0tI7Ckz46vRExgHt7/KrtPSDrZcdVJNbVoF8HN/Bt+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DLNm4FZ5DqGkI0BU+e1MbrutQHnfbD5PddxRwA7qx8WwP7lB0AdvIUP/ThYm8iPFN
	 SzXrVa8azY5hs/h1p1uGNUckSDkGI+j5pLuDgpF1xTD27zOPveIAn/U3TNhXOWxkLh
	 iNa+jVUmuI78lSAg9urGHTuq+UnDFppKmiIM3TgHmxCbNwxN4OAcF8blVRSMn3Q9s2
	 XdaY67ZvK907ChVjCXl2eRgw1fNC/xfInBrQmQYfBSlo30m6JyPTesbV1rgE9LbDoF
	 a2gUXEOWrFnK/RNCSniPEmuDVSgcZIEkvoH+3R7565JMM81xzjMZ8u4JVPdN9I0rkv
	 FLJoxRcsCc4sw==
Date: Mon, 21 Jul 2025 15:09:26 -0500
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
Subject: Re: [PATCH v2 05/16] dt-bindings: memory: add jedec,ddr[3-4]-channel
 binding
Message-ID: <20250721200926.GA1179079-robh@kernel.org>
References: <20250711-ddrperfm-upstream-v2-0-cdece720348f@foss.st.com>
 <20250711-ddrperfm-upstream-v2-5-cdece720348f@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250711-ddrperfm-upstream-v2-5-cdece720348f@foss.st.com>

On Fri, Jul 11, 2025 at 04:48:57PM +0200, Clément Le Goffic wrote:
> Introduce as per jedec,lpddrX-channel binding, jdec,ddr[3-4]-channel
> binding.
> 
> Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
> ---
>  .../memory-controllers/ddr/jedec,ddr-channel.yaml  | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,ddr-channel.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,ddr-channel.yaml
> new file mode 100644
> index 000000000000..31daa22bcd4a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,ddr-channel.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,ddr-channel.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: DDR channel with chip/rank topology description
> +
> +description:
> +  A DDR channel is a logical grouping of memory chips that are connected
> +  to a host system. The main purpose of this node is to describe the
> +  overall DDR topology of the system, including the amount of individual
> +  DDR chips.
> +
> +maintainers:
> +  - Clément Le Goffic <legoffic.clement@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - jedec,ddr3-channel
> +      - jedec,ddr4-channel
> +
> +  io-width:
> +    description:
> +      The number of DQ pins in the channel. If this number is different
> +      from (a multiple of) the io-width of the DDR chip, that means that
> +      multiple instances of that type of chip are wired in parallel on this
> +      channel (with the channel's DQ pins split up between the different
> +      chips, and the CA, CS, etc. pins of the different chips all shorted
> +      together).  This means that the total physical memory controlled by a
> +      channel is equal to the sum of the densities of each rank on the
> +      connected DDR chip, times the io-width of the channel divided by
> +      the io-width of the DDR chip.
> +    enum:
> +      - 8
> +      - 16
> +      - 32
> +      - 64
> +      - 128

This is duplicating what's in jedec,lpddr-channel.yaml. Refactor or add 
to it rather than duplicating.

Is there some reason regular DDR3/4 doesn't have ranks? I'm pretty sure 
it can...

Rob
