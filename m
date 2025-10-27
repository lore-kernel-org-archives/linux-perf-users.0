Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3EF230D35;
	Mon, 27 Oct 2025 18:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588293; cv=none; b=GnNk56wvyZL9ZI+MfJCx1QB+lOBEpOblYDLtp452mrTj1D/zmU0xWaPArXmbFDUI91mQImDSRfA6RBouAjk0fvxlV7Ib56gkrGqPl0X7IRWbc1vBMJ+MrCzgq/4IhSVZnPwBc7bRkm++NGI5kQ78sAsBCmTOHuBg3S+mZxneNds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588293; c=relaxed/simple;
	bh=wC3dF4Z/2TLP6nYVtiNgty+OuO6sR3fKRJSKrIGVSQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJnGdNMLY1sGloi0A4419PNkTgWKGbSFmzaa/Sxov3evNW0EygaTsBtxcsmg/atCGLfIoS/ES6RCjurykVZkgGbLn0G85+/nMeUOGHRY3mD46pDfuOHS2KDKqHrwII1F+jwd5mioWyo1TbzgtLxh4S1eit6rjb2WP/YDGGAD6t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7SlGX81; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7SlGX81"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB18C4CEF1;
	Mon, 27 Oct 2025 18:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761588290;
	bh=wC3dF4Z/2TLP6nYVtiNgty+OuO6sR3fKRJSKrIGVSQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e7SlGX81jMR6yj1IeJWwwVYQ3+3tPTmCK831vU1PnUIt/iyPj3GDmL9XiYKXpNDQ2
	 Z/LRHnTrpEIFm63gcu23hvDSaBvb82i2geNIvK4sey3zIvfbtoBKF2HX15Mb64mP1H
	 81WWYU6T9B1ikykq2fnt3FSFoX+2h0A+ih/98aLlfjn6aGOO2h1g7gGYFT/6Q7aTAw
	 oILKlawFztGueWsy1Fqu1lVYO9XvG15dNOuHf4Hm5aGkdfStrLGi39FfRz6paFKUvk
	 sjbjjOs/5XEoKmxLLxO7nuYcFWMhILxQe6vS5CFaSHHqsyg8dqQL681CX7/X9jaXPs
	 Aikt7gxqowQ4A==
Date: Mon, 27 Oct 2025 13:04:49 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.li@nxp.com>,
	Frank Li <frank.li@nxp.com>, imx@lists.linux.dev,
	Xu Yang <xu.yang_2@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: perf: fsl-imx-ddr: Add compatible
 string for i.MX8QM, i.MX8QXP and i.MX8DXL
Message-ID: <176158828675.1280181.1101688513107475187.robh@kernel.org>
References: <20251024-qm_dts-v2-0-7a7e07022ed6@nxp.com>
 <20251024-qm_dts-v2-1-7a7e07022ed6@nxp.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024-qm_dts-v2-1-7a7e07022ed6@nxp.com>


On Fri, 24 Oct 2025 14:17:11 -0400, Frank Li wrote:
> Add compatible string fsl,imx8qm-ddr-pmu, fsl,imx8qxp-ddr-pmu, which
> fallback to fsl,imx8-ddr-pmu and fsl,imx8dxl-db-pmu (for data bus fabric).
> 
> Add clocks, clock-names for fsl,imx8dxl-db-pmu and keep the same
> restriction for existing compatible strings.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> changes in v2
> - move fsl,imx8qm-ddr-pmu, fsl,imx8qxp-ddr-pmu under enum
> ---
>  .../devicetree/bindings/perf/fsl-imx-ddr.yaml      | 29 +++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

