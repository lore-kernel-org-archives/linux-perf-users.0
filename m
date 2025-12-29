Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF4AEEB3;
	Mon, 29 Dec 2025 02:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766976653; cv=none; b=M199NqjGtYainOi+Ba3k87jnZwG6QwU/2fHHXaHQSFl1IQ85pDF9GFZPKLHdMWUNk33t9PsmcjkwsuMhusC10iX0AbWQdRahrrLBVtYHLs0PnrrtW1FEuvm0QZd/EJdWvsHFPKPgGHXYTFQJElOy1tMedDhj53Q7zsmZVeHF2r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766976653; c=relaxed/simple;
	bh=yX7/3mFH08YrJExkfGIoYVyNQTGTYRax+BrGZPlAAYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQVE6WGTQXxUY2R4lcxpOwJ8xM6iI24L9NmN1DbovkZVl+Q9A0TnaW4hT5BZEar1N15dwwDbe3eS2uNtPica7rOAoK8W9Ek62FyPVYJGB66R4YFRVFws0ERMpnfKCWTaxXXsa+EOQMgQi5otIhqwH285ukEoFyhX0hpveFbri7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oI3rPcoa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oI3rPcoa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE1FC4CEFB;
	Mon, 29 Dec 2025 02:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766976653;
	bh=yX7/3mFH08YrJExkfGIoYVyNQTGTYRax+BrGZPlAAYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oI3rPcoa1xH+lQ7hVZS9RVy5efBS0cVQnD4wC5Z0niim8Z8Thk9wRyKkL0mD0znYL
	 b5k9FbUogkRcRSHDbMjrfO6fw1S0d+/D2L+DEXGDmyOBDNfshFWGU7Hi+JG/6lagh3
	 jSWQ96C7QOErmpR4f9DEi6ijh5CIC3CSio/k+ZNak98D2gDYPDA8VdWKpehJwW/iyD
	 rSqs0l+25O1+UzVdFNDP4b5JHAvZFiO1MK6sb1Oka+S/xv5fIPvg6+vU9nmrJbQaGH
	 frBnT4An5I3w3/M+2hhRTyJU2y9UficmTCidBNmIMwKnoSWm3fG+uM5MqVsKCBpAQG
	 zmM1WIAxawSzA==
Date: Mon, 29 Dec 2025 10:50:41 +0800
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
	Jacky Bai <ping.bai@nxp.com>
Subject: Re: [PATCH v3 6/6] arm64: dts: imx8dxl-ss-ddr: Add DB (system
 interconnects) pmu support for i.MX8DXL
Message-ID: <aVHsgSN5-gzJ4jt0@dragon>
References: <20251103-qm_dts-v3-0-2bfda8ee14c2@nxp.com>
 <20251103-qm_dts-v3-6-2bfda8ee14c2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103-qm_dts-v3-6-2bfda8ee14c2@nxp.com>

On Mon, Nov 03, 2025 at 04:48:33PM -0500, Frank Li wrote:
> From: Jacky Bai <ping.bai@nxp.com>
> 
> Add DB pmu related nodes. This pmu is in DB (system interconnects).
> 
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!
