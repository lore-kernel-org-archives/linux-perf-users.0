Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C600B3161B3;
	Thu, 18 Sep 2025 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758213819; cv=none; b=GxhrQLvEebbv+KWBaYbCoNKtYAXjBE588juZzHMm46HjuD97sy678gH+HfISWNy6LGYHIHi1qKfFrOoABcuOIKTzD5cE72W7Ol6wOg0TO+z89DruMqeMiXoV74eV6iSu+1NoW2JIei45TNC5GqloFBAuM1K53glkqyISPBQEYzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758213819; c=relaxed/simple;
	bh=qFtgFQc45qH6NI8BCfmuOT4L0z37VVKN0klbtf67YnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hK0xoOKXcvzaSVURYq8M8TsA+vQBJRuEp/EnkZdcRsRCJ/XwrMyp6Iw6gmC6awiQbhlG/Ei9JXkU3+5eNoV4uOAJ/F4saiRQwdPy2Kljtq7+0YXbDpKKLfyiQumCgGfoXKr3IXMYLvXBJSBRWdgcC2pwbdkIbhn75nrD6C9ky2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8hFiwiW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8hFiwiW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21495C4CEE7;
	Thu, 18 Sep 2025 16:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758213819;
	bh=qFtgFQc45qH6NI8BCfmuOT4L0z37VVKN0klbtf67YnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q8hFiwiWtw0hUG7YjuNfM7nuZGywpt1+gyDojeilUUUPtmmmWVyvgdfauJW+/hvnP
	 PpWXdWzALUFGC9hAGJh2MxtLazBVKNJxqMm9LvTOIrQ/wbcz1Rj1YqLC+oNaLzWke0
	 JuaSL3ovkaOhx9XlQO7U2QXEhQPU2g5V4NDQX8jgoEYfFk4W1Ke8/CVFkpH4vHNQrU
	 sJaWTSauMGgvU+5FbiBbBQEiMKTYsAYwj7kFHvBj3ef79ljQJYX/ZZlUhyoLGHtaEI
	 O42oZtalg3qihlhLN4/wVoXbgCEcA2yUQxm6tV3azdFnYNgeFcrbLyZ786BPj1RjqY
	 5Rs6f6knzNy6w==
From: Will Deacon <will@kernel.org>
To: Frank Li <Frank.li@nxp.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	John Garry <john.g.garry@oracle.com>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Xu Yang <xu.yang_2@nxp.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	Peng Fan <peng.fan@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 0/5] add imx94 DDR Performance Monitor support
Date: Thu, 18 Sep 2025 17:43:10 +0100
Message-Id: <175819950650.3462177.6226529699819628940.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250821-imx94-ddr-pmu-v2-0-052c6420605d@nxp.com>
References: <20250821-imx94-ddr-pmu-v2-0-052c6420605d@nxp.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 21 Aug 2025 19:01:48 +0800, Xu Yang wrote:
> The i.MX94 Soc has a DDR Performance Monitor Unit (PMU), this will
> add support for it.
> 

Applied drivers and bindings updates to will (for-next/perf), thanks!

You'll need to route the .dts and tools changes via their respective
trees.

[1/5] dt-bindings: perf: fsl-imx-ddr: Add a compatible string fsl,imx94-ddr-pmu for i.MX94
      https://git.kernel.org/will/c/f8cc02321bfc
[2/5] perf: imx_perf: add support for i.MX94 platform
      https://git.kernel.org/will/c/e4d9e8fb406b

[4/5] MAINTAINERS: include fsl_imx9_ddr_perf.c and some perf metric files
      https://git.kernel.org/will/c/2c599c68c43e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
