Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FDB2D5C68;
	Mon, 24 Nov 2025 19:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764011923; cv=none; b=HRB9FAUjJifz0StsGg0IEZEdsyOBXuQ2FyRqKKThsaOuEsLgf0LgGOPgkeWBVt0ZEUQ4+BmiAOrTSnzUt2tw4YDilsM+LilP8YKrMBgxWpwieTvh2CMvpRGRw3r/jkYaD/XAqw6tvYMa49ApMNmy1OjEMrGVOoFITdNX1pTZ1EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764011923; c=relaxed/simple;
	bh=Tx8AB1SA68OjpJGaBGshivP2neQNWcZSQoIkHV53Fdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W9Ss0SzMPmq/HpOtbPdbPV4MY9CI+zGRUIMoaZsj5Cp3h2ZtQBNZ1Oo1plxCc50sdl4j73MNyKVIzLKYq1phAfaFNc325pFz9NySPc76t+FmEfxN1yjFkIavxdtevR34pBTD4Kzd9uXRQM5YjZpfuqqT3+qASr9xG9/S2Itq1BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvE/K7+Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvE/K7+Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E117BC4CEF1;
	Mon, 24 Nov 2025 19:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764011923;
	bh=Tx8AB1SA68OjpJGaBGshivP2neQNWcZSQoIkHV53Fdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dvE/K7+Yx5Mgd0+r3X5BUhZ5lArb5ERUn2RxDc4De0sYovnYUBB0PHGcv5PBQ1A1v
	 be1PUQOAI7nJ3fbWzIiTbl4p+AS74dLMl/1LBZ4tJgs6wJoYlxeFZoaniybyT8ZsgU
	 bylxn5id1LvzAKZWdnmLsWlziCk/FyEETRZWw0mTeHF4j42QfI549aSdqLmCknFZrK
	 NLeX46GbzfxfHj7cZg8lxmD5z4KHgr6DNB9oBAwi3flWUci0tvO83nf1ybL/fYFiMy
	 R4/YFrw2sXVxC+yBrtjXXzHbJl2Q/mN+TAeHLf32dFBpq0LU9K0/Nc/QXjD9kUVYxd
	 DK3W/w55oHGTw==
From: Will Deacon <will@kernel.org>
To: Frank Li <Frank.li@nxp.com>,
	Xu Yang <xu.yang_2@nxp.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Frank Li <frank.li@nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joakim Zhang <qiangqing.zhang@nxp.com>,
	Jacky Bai <ping.bai@nxp.com>
Subject: Re: [PATCH v3 0/6] perf/imx_ddr: Add i.MX8QM and pmu in DB (system interconnects)
Date: Mon, 24 Nov 2025 19:18:30 +0000
Message-Id: <176399874665.521575.3051557105547982197.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251103-qm_dts-v3-0-2bfda8ee14c2@nxp.com>
References: <20251103-qm_dts-v3-0-2bfda8ee14c2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 03 Nov 2025 16:48:27 -0500, Frank Li wrote:
> dts: add soc specific compatible string for imx8qm, imx8qxp, imx8dxl in db.
> driver:
>  - did some cleanup
>  - add support for pmu in imx8dxl DB
> binding:
>  - add compatible string for imx8qm, imx8qxp, imx8dxl in db
> 
> [...]

Applied driver changes to will (for-next/perf), thanks!

[1/6] dt-bindings: perf: fsl-imx-ddr: Add compatible string for i.MX8QM, i.MX8QXP and i.MX8DXL
      https://git.kernel.org/will/c/de8209e55408
[2/6] perf/imx_ddr: Move ida_alloc() from ddr_perf_init() to ddr_perf_probe()
      https://git.kernel.org/will/c/66db99ffdfcb
[3/6] perf/imx_ddr: Get and enable optional clks
      https://git.kernel.org/will/c/037e8cf67178
[4/6] perf/imx_ddr: Add support for PMU in DB (system interconnects)
      https://git.kernel.org/will/c/11abb4e87b0e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
