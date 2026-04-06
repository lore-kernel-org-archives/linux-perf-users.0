Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E0438E5EB;
	Mon,  6 Apr 2026 18:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775499492; cv=none; b=OUDX5wFA2X7pwIm4eoYBcMgxXkx5p3K5eIOB02PXoP5DDvoA5nhIXa4aLYY2Cu6VeapLTM3YE+/EnFo4SI31OChgvQrWFGhgEpozKYFzpiOk2egrPHPGO+cOZmj4IH56GpgYiGFtwexZ6arEtLRG9s4ksi81WNP7MXXiCIDh79s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775499492; c=relaxed/simple;
	bh=+jNcEeJCB0s1TuZwaY9HBVQLpAwN4rI0/P/O0NrQfHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEtfKtYdXGycd8vTrkQV4MLfLjx8IUc60ktCADVk2Ku+UvGHeIBug4mUA6hgKVyu9zgv+x9wm7u+nrsrbpuLLvfF9RupgJcR1Gx33sxbBt3d6FVCkutamUA4h4GXo9KpYfVillC+xZo16cyzkq8pfbTBrkVvnp8rrIx4gLAIfJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pp8NSska; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pp8NSska"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D995C4CEF7;
	Mon,  6 Apr 2026 18:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775499491;
	bh=+jNcEeJCB0s1TuZwaY9HBVQLpAwN4rI0/P/O0NrQfHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pp8NSskaS5bqEU5b1lBjt+AswPtIWTg/v5wR/9yrI+7Y9oRYLT3oNuRT3Zd37bDkX
	 PUqRkRPJDHUWW9GiCDH+KmmAZBacea+Z4Cl/Z7frE3MIxe+BM+WLPnU/vZhrOGA29t
	 R1YA4v/CdsqvH5G5hjNOrESt2KVNEPzcsoBWWM9ylYBlAGNpveWEP0RLpdnpUPY2F/
	 R4DgAyfBatCu8TyrYf3Z1IBHN+3zgKCOu8m7Bj79KXrpCxQogzpSPmOMHLECaCkP7n
	 bSgExsL2YLK+HzF0a0jm4Kaq0CussiEPpIuRFRlxcvOTLaYVwwHVsesc2WLkqVFRtV
	 WFQ6arp9LYmxA==
Date: Mon, 6 Apr 2026 11:18:09 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Al Grant <al.grant@arm.com>, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] perf arm_spe: Dump IMPDEF events
Message-ID: <adP44THdD-HBB8cY@google.com>
References: <20260401-james-spe-impdef-decode-v1-0-ad0d372c220c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260401-james-spe-impdef-decode-v1-0-ad0d372c220c@linaro.org>

Hi James,

On Wed, Apr 01, 2026 at 03:25:48PM +0100, James Clark wrote:
> In the Arm SPE raw data dump, IMPDEF events aren't printed. Add the
> ability to add names for some known events or print the raw event number
> for unknown events.
> 
> For example:
> 
>   $ perf report -D
> 
>   ... ARM SPE data: size 0xd000 bytes
>   00000000: b0 18 c6 32 80 00 80 ff a0  PC 0xff80008032c618 el1 ns=1
>   00000009: 64 e7 42 00 00              CONTEXT 0x42e7 el1
>   0000000e: 00 00 00 00 00              PAD
>   00000013: 49 00                       LD GP-REG
>   00000015: 52 16 10               	EV RETIRED L1D-ACCESS TLB-ACCESS
> 
> On N1 the event line becomes:
> 
>   00000015: 52 16 10                    EV RETIRED L1D-ACCESS TLB-ACCESS LATE-PREFETCH
> 
> Or on other cores it becomes:
> 
>   00000015: 52 16 10                    EV RETIRED L1D-ACCESS TLB-ACCESS IMPDEF:12
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
> James Clark (4):
>       perf arm_spe: Make a function to get the MIDR
>       perf arm_spe: Turn event name mappings into an array
>       perf arm_spe: Decode Arm N1 IMPDEF events
>       perf arm_spe: Print remaining IMPDEF event numbers

Will you send v2 or do you think it's ok to merge v1?

Thanks,
Namhyung

> 
>  tools/perf/util/arm-spe-decoder/Build              |   2 +
>  .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     | 147 ++++++++++++++-------
>  .../util/arm-spe-decoder/arm-spe-pkt-decoder.h     |   5 +-
>  tools/perf/util/arm-spe.c                          |  49 ++++---
>  4 files changed, 135 insertions(+), 68 deletions(-)
> ---
> base-commit: 74e2dbe7be5037a5e5eed6bc1ad562747ac88566
> change-id: 20260331-james-spe-impdef-decode-d944f4fdcff7
> 
> Best regards,
> -- 
> James Clark <james.clark@linaro.org>
> 
