Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76B22AF10;
	Tue, 13 May 2025 19:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747164869; cv=none; b=HnFdAb4JoV11oIXekeifUsb3mugb15YSEvuv9UY96mVrP+VPEZpauVQJ8T+/1h7jXdoCa0RZDCLS02+sEmrw+6CNoEdWVe9Myj7SZFQjPKMiZgP6nt2ZIy/AGuFEJO67kQM2W7cmMMvSN14uODGry1mgUrWpSghRxGYzM6RGxpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747164869; c=relaxed/simple;
	bh=KYnC36TQkZP1AvnrNNz9vqgyvOyQ7HJ7m1kyyu3CnkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i37QmfMAo6ojZzICUCMFRs9cRqiicmruNNFqklrIZQr6WDVIJDkSx0aD5ws223tqW94V+MQWMq7bqD2tal/AW/ZJyeu36CMJDKluMuqnx8XYATz7hlsuFvJyq7Urog5/0pjFZUwHKc/e/f+SyE6PjmZj2VznNkJP3NrChOLy3+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bT/97jqS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bT/97jqS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63AFC4CEE4;
	Tue, 13 May 2025 19:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747164868;
	bh=KYnC36TQkZP1AvnrNNz9vqgyvOyQ7HJ7m1kyyu3CnkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bT/97jqShn9UhEPB9VANVMzCtvvJQsJx8KFMU32D1jsDIzHdOsHg4Elii0JzkMxdX
	 oGkON8OLJ1exewVYni6c+XC14MjNmCo9uMSVEk2cIVnlKsc8qSOs99Di8ThH7iIxvp
	 t3IdVIyCQZfhqT/lwgfkCwfDKNxHW3Q5p/6e7bg0hDtvAwlDW0+VQYBte8As15Oofh
	 +oEUx+YvulmFpsyKobuaF1UtLDrgWuPQfjEAEoM/chL3QZVu1JXath5lRdDsp4+bN1
	 dQH+BI4tqZ72MDyGwvVhQMpSCaiNX++Kd+A769ruRC45ZQnCUM2AqYJyLVi54xGUKf
	 Ukv/CGDzPg6/w==
Date: Tue, 13 May 2025 16:34:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>,
	John Garry <john.g.garry@oracle.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Weilin Wang <weilin.wang@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] Metric related performance improvements
Message-ID: <aCOewZobRD1dPrl4@x1>
References: <20250410044532.52017-1-irogers@google.com>
 <Z_dp7E2wtSek-KHo@z2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_dp7E2wtSek-KHo@z2>

On Wed, Apr 09, 2025 at 11:49:16PM -0700, Namhyung Kim wrote:
> Hi Ian,
> 
> On Wed, Apr 09, 2025 at 09:45:29PM -0700, Ian Rogers wrote:
> > The "PMU JSON event tests" have been running slowly, these changes
> > target improving them with an improvement of the test running 8 to 10
> > times faster.
> > 
> > The first patch changes from searching through all aliases by name in
> > a list to using a hashmap. Doing a fast hashmap__find means testing
> > for having an event needn't load from disk if an event is already
> > present.
> > 
> > The second patch switch the fncache to use a hashmap rather than its
> > own hashmap with a limited number of buckets. When there are many
> > filename queries, such as with a test, there are many collisions with
> > the previous fncache approach leading to linear searching of the
> > entries.
> > 
> > The final patch adds a find function for metrics. Normally metrics can
> > match by name and group, however, only name matching happens when one
> > metric refers to another. As we test every "id" in a metric to see if
> > it is a metric, the find function can dominate performance as it
> > linearly searches all metrics. Add a find function for the metrics
> > table so that a metric can be found by name with a binary search.
> > 
> > Before these changes:
> > ```
> > $ time perf test -v 10
> >  10: PMU JSON event tests                                            :
> >  10.1: PMU event table sanity                                        : Ok
> >  10.2: PMU event map aliases                                         : Ok
> >  10.3: Parsing of PMU event table metrics                            : Ok
> >  10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
> >  10.5: Parsing of metric thresholds with fake PMUs                   : Ok
> > 
> > real    0m18.499s
> > user    0m18.150s
> > sys     0m3.273s
> > ```
> > 
> > After these changes:
> > ```
> > $ time perf test -v 10
> >  10: PMU JSON event tests                                            :
> >  10.1: PMU event table sanity                                        : Ok
> >  10.2: PMU event map aliases                                         : Ok
> >  10.3: Parsing of PMU event table metrics                            : Ok
> >  10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
> >  10.5: Parsing of metric thresholds with fake PMUs                   : Ok
> > 
> > real    0m2.338s
> > user    0m1.797s
> > sys     0m2.186s
> > ```
> 
> Great, I also see the speedup on my machine from 32s to 3s.
> 
> Tested-by: Namhyung Kim <namhyung@kernel.org>

I'm collecting this for v2 as well, ok? Holler if you disagree.

- Arnaldo
