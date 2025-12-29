Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B5D18CC13;
	Mon, 29 Dec 2025 02:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766976626; cv=none; b=YvRU6UjpugWZvqS12O6C4h/pZOZUGxNmGADG7eWV6CwgtCfvtAxyTvtnhbmUwSOYtjYgF7UmjYnfU2Lz3HGaAO+GmIMCo1lZ70XXOJTW90PBomks9jDzB7rpL3gdTAjJc1JI84ldDndWRYjfLlx4UNTiuFpkiUViM9Lh5MohXdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766976626; c=relaxed/simple;
	bh=tEUU9KDTuNA8oyvyIc3IfREIjFjW8VKwcSqtRHWh6G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrPdsvIlzTQdr8yprysgNVQx7bM5Y28xdg6NhN2VJrghlVWk+EZ4mPrmzxOyMB9R4WLsgFS982iDkjBvPLa3P7nwoAcrneJvWTGDhDRA3zeC18j9yuyQ2qAC1/8AO3pt7viflpCFXB5mPOtKCdo2i5FmfH8yBfFt7AysFUAMRQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxjevTXB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxjevTXB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4B8C4CEFB;
	Mon, 29 Dec 2025 02:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766976625;
	bh=tEUU9KDTuNA8oyvyIc3IfREIjFjW8VKwcSqtRHWh6G0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pxjevTXBWePRefYXPAcmpg6nWB2PERBnaaSXxAnbcUgBOMdnZyQX3wguDIQTjkTPx
	 iIr2SHgja13dH7+zAsyRTx1dEEe0MuxihiN1J8NzChiVkpM/mHUZV71rwKN7m64YZj
	 ot3zhLFNeohvJx4F4Ae7tHq4obOz/vzWRClrMMd/6Qj2HcGx/o58w3gQP3iWbfsBRk
	 faP9iW0H1PLDsuKfnnLuNCf4Cu/+G7FZBOGVS9YA3BLLAd2OpHLlTPw2MOtPo+t/PM
	 NeMOxHRLOO1r9JwtjWi6DWiuC72pHznV8FI+CXX5FS8dAumnaNywC/nG5ezWbOIaFE
	 vU/V3Y80oUSMA==
Date: Mon, 29 Dec 2025 10:50:20 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Xu Yang <xu.yang_2@nxp.com>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: Re: [PATCH v3 5/6] arm64: dts: imx8qm: add ddr perf device node
Message-ID: <aVHsbK-HEfYqpS9G@dragon>
References: <20251103-qm_dts-v3-0-2bfda8ee14c2@nxp.com>
 <20251103-qm_dts-v3-5-2bfda8ee14c2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103-qm_dts-v3-5-2bfda8ee14c2@nxp.com>

On Mon, Nov 03, 2025 at 04:48:32PM -0500, Frank Li wrote:
> Add ddr perf monitor device node for i.MX8QM. Change imx8-ss-ddr.dtsi's
> compatible string to fsl,imx8qxp-ddr-pmu. i.MX8QM overwrite to
> fsl,imx8qm-ddr-pmu. All fallback to fsl,imx8-ddr-pmu.
> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!
