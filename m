Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BB24A06;
	Mon,  8 Sep 2025 21:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757366207; cv=none; b=SFUElmQrsEu9mPQ0pJQIWRKKM0gRqg+h/G0uBPEBkmBSPgXM3UF/LHlYu2Gp9hzPp5rFb/ZehXy/pTnBJIErxYSxAGo7K5iWgWkPWSZRoRGOVG5usKY0Fh3PQgxOsmVV6RtckvKFJtAzV5bZNVnyVB7NHXo6elLn9ClC0HnY4YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757366207; c=relaxed/simple;
	bh=J5y9anpPbcZnzbPgCVt9jP6JmKsctgV7OtX+n3Hj8X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0onkwdQhkFT3rQMlcob75ewZFVp6Xqd4yVO8+VLJEmFc4tZw0rMgrBi0JbD/mfUURHQ+vcBikQeES9xgW1GdWNoCKW196gFGqDaujFsQ0Zlw1/K2SWkX8FkYlkUV7piqfVWC3CEVDj/5ylwDITog1yvghshzS/Ixa40aCH0MwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rf9r8XOh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rf9r8XOh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96706C4CEF7;
	Mon,  8 Sep 2025 21:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757366207;
	bh=J5y9anpPbcZnzbPgCVt9jP6JmKsctgV7OtX+n3Hj8X8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rf9r8XOhD3mO2RluD/ZLcZMFnqDiIyrxGHxxsMC3onceoyCLbXetm8qjOAWzQ+D3r
	 edoqlwKMbjHlFHq0Fvatii33cblSIErw94ODgYtQnvqHA7gomIgPEg9WvECGewxGM5
	 89pxeGbis1brBj6vkZAEXreXiL6zuU9oqYkpsne+n2QkkRCLWioh0Tdgx2FSbWzz4D
	 lCDlDiHAcLkhjEHSR3RtzLoX1tTuMORw+V2lvOl0eNKC3iUGIJ+s8r3/VgEKkFgfu5
	 b/kgWh6FYD7SEPW9++bpDdPcPs7j4vPcTZ2BT+FYRN6UDXCbHGzOnRIfsFN0JlNPG0
	 yGQaKEu7jhnaA==
Date: Mon, 8 Sep 2025 18:16:44 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	George Wort <George.Wort@arm.com>,
	Graham Woodward <Graham.Woodward@arm.com>,
	Ben Gainey <Ben.Gainey@arm.com>,
	Michael Williams <Michael.Williams@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] perf arm-spe: Improve --itrace options
Message-ID: <aL9HvOl-n_IM0qiB@x1>
References: <20250908-james-perf-spe-period-v1-0-7ccd805af461@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908-james-perf-spe-period-v1-0-7ccd805af461@linaro.org>

On Mon, Sep 08, 2025 at 01:10:17PM +0100, James Clark wrote:
> Most people also want all the SPE samples (instructions group), not just
> the flagged samples that are put into the various memory groups. These
> should have been shown by default but weren't because the default
> interval type wasn't supported.
> 
> Also when looking at this, it appears that the downsampling was behaving
> in a way that would discard samples from one group but not another.
> Improve that and the warning messages.
> 
> I don't want to put fixes tags on these because it's only changing the
> defaults and the behavior, but I don't think the previous behavior was
> incorrect necessarily, just copied from tracing techs but not ideal for
> SPE.

I keep trying to find some hardware to have in my homelab to test these
series, but till then I depend on people having access to such hardware
for acks or better, tested-by, so waiting a bit for those to appear.

- Arnaldo
 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
> James Clark (4):
>       perf arm-spe: Show instruction sample types by default
>       perf arm-spe: Downsample all sample types equally
>       perf arm-spe: Display --itrace period warnings for all sample types
>       perf docs: Update SPE doc to include default instructions group
> 
>  tools/perf/Documentation/perf-arm-spe.txt | 14 +++++---
>  tools/perf/util/arm-spe.c                 | 53 ++++++++++++++++---------------
>  2 files changed, 37 insertions(+), 30 deletions(-)
> ---
> base-commit: 75a7b9d29215c5aa813b9620f3c56817918f9f8c
> change-id: 20250908-james-perf-spe-period-4711a566cba4
> 
> Best regards,
> -- 
> James Clark <james.clark@linaro.org>
> 
