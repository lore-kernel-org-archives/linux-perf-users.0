Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CD333711C;
	Fri,  7 Nov 2025 17:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762538085; cv=none; b=NRXATdhIV4F7/vAWSWzMa+5DYyp8iNmEljGsJGZLZjHDJjJ0BNnGjwo/QQvguOPbNeBSln730bm8QufHXyjQ1gRgWztAHvrvwuKYo9c42Uif/OWYLMDwY4wJ/+3dP6KZIFUgU5KHponbYMJu/MTvTJG7fD/fgyB5z8lI+OzH238=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762538085; c=relaxed/simple;
	bh=WU7NZ37QH/2z1O6WY2Xy4ePTQRdnSUSd/yHy/qMlRHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKlAB0Y2zZ0B5b3eB9egwNeDsAeJfjPnRSV0btaOYnhk0Qjpy4hfaPAmQtSvoEwT22bjEPYu1DZlXV3KiuNzgph5R0MhFeWHGE5AfQM4fn12AAOPiPkkIXDy0YU3FgTcxWXVl2Wdukzd4xMr6eNvSVpCuXebEA7iSiKeWB2VN30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dp9UCJ+Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dp9UCJ+Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C74BC4CEF8;
	Fri,  7 Nov 2025 17:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762538085;
	bh=WU7NZ37QH/2z1O6WY2Xy4ePTQRdnSUSd/yHy/qMlRHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dp9UCJ+Z/kBOTJt3aGLyKq1STWGqL4lxGta15RFcLRyICCUFoaK6Rq0sfjWgvZ+OT
	 n0sKB+wSxSUizC+aMLa7mcKpH+Rl8IdfwHrEX8ynDWNa5MI/7SnmknEgLwqGIiMRh4
	 GhmwTybgneQ8atuqnI/EOSiCGk9pNwwagw9qQDCde0LiI5a74a/oDI3IzoadSkdG9T
	 oIjHJeM7paDgpcjVrTlZLKGcJ4SIY0ZYk0rKJGk9fveb98CodKSuxZsA+KvK7uS83r
	 ZdIEs2wSLsdIbbEQVskAEUy2B9bI4SpU5py4QuSGE49ISXKdNEdvEtd7nB4numSoyC
	 dsMr8J3KiHOYg==
Date: Fri, 7 Nov 2025 09:54:42 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Frank Li <Frank.li@nxp.com>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	John Garry <john.g.garry@oracle.com>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 3/5] perf vendor events arm64:: Add i.MX94 DDR
 Performance Monitor metrics
Message-ID: <aQ4yYi05pYL9j-Mt@google.com>
References: <20250821-imx94-ddr-pmu-v2-0-052c6420605d@nxp.com>
 <20250821-imx94-ddr-pmu-v2-3-052c6420605d@nxp.com>
 <wlziowwtfqbhzsltffm4l3pxntev3lgjan44wfixztnk3gw5d7@z2selm5eczsq>
 <aQ1Pp6GF6svXDXoy@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aQ1Pp6GF6svXDXoy@google.com>

On Thu, Nov 06, 2025 at 05:47:19PM -0800, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Nov 04, 2025 at 02:33:08PM +0800, Xu Yang wrote:
> > Hi Namhyung,
> > 
> > Could you please take this one?
> 
> Yep, will add this patch to perf-tools-next soon.

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

