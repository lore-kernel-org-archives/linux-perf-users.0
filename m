Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5B7329E4E;
	Tue, 13 Jan 2026 21:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768338909; cv=none; b=pj3E9HSHyKurr2s0qoDqH17+ZfQjMlhd1dRDv6RrvVsKk2g2bKNE2vz+OIWkYUYxQMjlX3Sk7FAE26Tl9P1LPpMeU4fI9NjBUKVI816PyfiNTHH784ZDRblkZPEq37+RmJyspa8Kxdg26GLjVKgAZe3osFFcMVGIjR3fS+HnBqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768338909; c=relaxed/simple;
	bh=/JKpKicwMPQU90mh5v66sMDEWtTSXmOiwWFfgCCfMm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oi8qaieCxMFJAhT7naC9L4cghXxoptA6rKM4ArHpTS3GY4VFgI1KW1gwkzLLZoC+xHeK68NYa54EYmKmhX0bL5DZ2io9EpV7vBl6GV855+EbgLG7CqVLiH2LRjFg3yebqM7H1qT4xrkgZctbKnsOf6PBSXeqdYU7Hqg2J5kIQKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9rl87Ro; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9rl87Ro"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431E0C116C6;
	Tue, 13 Jan 2026 21:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768338908;
	bh=/JKpKicwMPQU90mh5v66sMDEWtTSXmOiwWFfgCCfMm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D9rl87RozNolrcwddXBBDsBUXM1NNWJk1Dlhix5i0aJdj1sZsnGIz1BTxq93e5RBh
	 De3X0Ei1I/QgWqniHn1Jy5sRNb3LasRFrAgXYza5X3MWdJdiXEZcnf7AQHUPtZpz9K
	 LmJCC95O6xMMlww7fEuUVy4KjfRqmRfj6gcRB48icapYx0dfgqB6xaQUKT0X33SRF0
	 reEFCoTZZ6TOTEAYGy7NJJZcQEMqErUb7LBcDw4u5J5/b+u1BZw+16CXvTFTtZw3Jn
	 DJwyio/YEktKaicjKyvto+TJRk+A2R2pO9/myg+ak4FkFEJadTzYRPGMQE2JrzOZ6N
	 jek+j2EV1achw==
Date: Tue, 13 Jan 2026 13:15:06 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf inject: Add --convert-callchain option
Message-ID: <aWa12lGzx5ulhvIs@google.com>
References: <20260110011715.1642869-1-namhyung@kernel.org>
 <aWafN6WpmaBJsIGP@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aWafN6WpmaBJsIGP@x1>

Hi Arnaldo,

On Tue, Jan 13, 2026 at 04:38:31PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Jan 09, 2026 at 05:17:14PM -0800, Namhyung Kim wrote:
> > There are applications not built with frame pointers, so DWARF is needed
> > to get the stack traces.  So `perf record --call-graph dwarf` saves the
> > stack and register data for each sample to get the stacktrace offline.
> > But sometimes those data may have sensitive information and we don't
> > want to keep them in the file.
> > 
> > This perf inject --convert-callchain option parses the callchains and
> > discard the stack and register after that.  This will save storage space
> > and processing time for the new data file.  Of course, users should
> > remove the original data file. :)
> 
> This made me think for a while to finally realize this is not a general
> purpose "convert callchain" option, but one that converts to ip-based
> callchains specificaly, useful and probably can stay with this name, or
> maybe we could use --resolve-callchains as we use
> thread__resolve_callchain() for that anyway?

IIUC resolving callchain is to get DSO/map and symbol from raw data.
But I admit the name is general but have no other idea. :)

Thanks,
Namhyung

