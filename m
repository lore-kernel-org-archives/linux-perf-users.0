Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE6C27C157;
	Thu, 24 Apr 2025 12:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499479; cv=none; b=Upb6ShYWNFxTPbimnv9Onl6eJyIJJjzaodXxtaxdFQwJgoOhlJmZM0rpcOZ4EyU6wOocsPAvYL678BNTLRw2pfmIhEVPsUWdh3CNF424L6k5N54gJrfL6U9tIHtaOzeVhYSjJ7BIz6gRcU+QiXKjLiNMHXybLg2WoT0t/lBk0Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499479; c=relaxed/simple;
	bh=chL/+wBLJzxLBfkZiuStxa9DKawqEmU983emMwpUIWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iX50M4aaZlswRj3oBc+IT+XlcerqPckZPMNko3fk8WlCPWrNjXfse9hibeGWhzXdLaj0e2uPP7OoSj7l2C89kqvoz+paLgJcomBTiSj7+mB9xjxZndvPdxym9s5fBxC16IElZuJizT9GTkm4zDBg4BkMGF83hCQcI7nBuiK4jCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0j/JBJ+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0j/JBJ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA769C4CEE3;
	Thu, 24 Apr 2025 12:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745499478;
	bh=chL/+wBLJzxLBfkZiuStxa9DKawqEmU983emMwpUIWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z0j/JBJ+37reblhETvh1yLoRGIfPz9DnWRf8HLow95ZsKMir9X8+2DhcbJJ6FJ7ZH
	 7KazpvjbUrHiIouVtJNTUsYCc76I3sx9erPuJJ0rMmTahSXDLR9ZcQuDddXfNypUSQ
	 sEtcxMN2I4N28zfRqHprr+x0oLTn4wvrbrToFv3tj/y3s4fCGaP55xU4j2J7FThp+M
	 DUYBS3pFYPD0CVMeznshPvGsCkAj6mRFzYWHOLzPdgDCGSLvvXihdw1bwfzdB0pxts
	 ErIMATdcZvKv6rYnzwVxANNloMnYvlxPg4av/n2dtKGaFzzxRwJV2nHkfny5wp2pvJ
	 qEexqI77DUerQ==
Date: Thu, 24 Apr 2025 09:57:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Ian Rogers <irogers@google.com>, Stephane Eranian <eranian@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf tool_pmu: Fix aggregation on duration_time
Message-ID: <aAo1UxB0VqJLbPtz@x1>
References: <20250423050358.94310-1-irogers@google.com>
 <b05aa0fc-05ab-4784-90ab-2d91b78d152b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b05aa0fc-05ab-4784-90ab-2d91b78d152b@linaro.org>

On Wed, Apr 23, 2025 at 09:58:38AM +0100, James Clark wrote:
> > +++ b/tools/perf/util/tool_pmu.c
> > @@ -486,8 +486,14 @@ int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
> >   		delta_start *= 1000000000 / ticks_per_sec;
> >   	}
> >   	count->val    = delta_start;
> > -	count->ena    = count->run = delta_start;
> >   	count->lost   = 0;
> > +	/*
> > +	 * The values of enabled and running must make a ratio of 100%. The
> > +	 * exact values don't matter as long as they are non-zero to avoid
> > +	 * issues with evsel__count_has_error.
> > +	 */
> > +	count->ena++;
> > +	count->run++;
> >   	return 0;
> >   }
 
> Reviewed-by: James Clark <james.clark@linaro.org>

Thanks, applied to perf-tools-next,

- Arnaldo
