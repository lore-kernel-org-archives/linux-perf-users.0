Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BA9224B14;
	Fri, 14 Nov 2025 07:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763104539; cv=none; b=eB+3LNpIki9tFfd5wrowMEu5HWpgBgp+KwRPO8GQspWFr1eQyE5DRJDq3UGrh3BMiGVTl7LoqScjsrN0qCHBzoS2q7yBY7+dM6Ni+IIISWCwCJBkn7deBqFNrZ96tqfhAVpK52ZpRnEOZwZernd86Ec+1EZfswi2v/pLt9BWsgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763104539; c=relaxed/simple;
	bh=aK95zP9P/bF5j9bwKJ/SG423/JvOT5qiz1XN4zrE9Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luzFomILt6R0HZcLusaOhF27QdclOw61KZK9pEhZLJJDLYg2mZkto6yR9u9iiLauNbbH/5eDdnTy5w+66L9XPjDjNE2bDFfKGdvZkkdv01D0ZnKFLmhaDCJSDyQdznHj9KFKWiX6d+O1NyG+hNInN5yaBkAXA+Ug44l8nuMoLt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WObA6PXS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WObA6PXS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A244C113D0;
	Fri, 14 Nov 2025 07:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763104539;
	bh=aK95zP9P/bF5j9bwKJ/SG423/JvOT5qiz1XN4zrE9Mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WObA6PXSsi2bfE5KjILjujJN0/mwq6rd8tNO/F2hUUnIXG6VmniWOv+w4vEAqQkiX
	 5/e1mYKgX6MHs9wj33Mlamo02r9aL+nPnVIv730UCLSI3ayrEVt0Y5A8/oJL5QMN95
	 98OUhjWLzFZnm9MlZ/rTbYlcb1YYr/JKrCoJnep0JCG/h9vnBhSVTYHiqhpC/P3AAq
	 GrloCqJPpeF78QWZ0LWazuMoYsDwHBCJro5P9oeMJ3iOoXu1YK/9vh4956Omh9fL3O
	 rEzsXpturj43VrpuA5tUic/B+b5g9/AU3fFscqN10jraf1LcFGeoqfUq/46QJbIS7s
	 tU/WuaapHJd6Q==
Date: Thu, 13 Nov 2025 23:15:37 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Tycho Andersen <tycho@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: Re: [PATCH 0/2] perf lock contention: Assorted fixes
Message-ID: <aRbXGQZecxeClOtI@google.com>
References: <20251113160124.2695-1-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251113160124.2695-1-ravi.bangoria@amd.com>

Hello,

On Thu, Nov 13, 2025 at 04:01:22PM +0000, Ravi Bangoria wrote:
> o Patch 1 resolves a segmentation fault in both "perf lock report"
>   and "perf lock contention".
> o Patch 2 repairs the perf-lock unit test.
> 
> Ravi Bangoria (2):
>   perf lock: Fix segfault due to missing kernel map
>   perf test: Fix lock contention test

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks for the fix!
Namhyung

> 
>  tools/perf/builtin-lock.c                 |  2 ++
>  tools/perf/tests/shell/lock_contention.sh | 14 +++++++++-----
>  2 files changed, 11 insertions(+), 5 deletions(-)
> 
> -- 
> 2.51.0
> 
