Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5512472B6;
	Thu,  4 Jun 2026 20:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604993; cv=none; b=rcZjabje0egbsVCouz9P8VRai7dNoR2li8jyYskQpMTZbMWwcJ3M8C0E6D2Dp2O9e8I+3Mz5eFxHdQfhHnj6yo6e/fJZ98LQaTPJoKlmE+GA2pLEqK+2cVp2ysHiNZm8UPBJ1CAWqwqlyhoTloMWicbsHmVrthTQH5kzXWyrkBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604993; c=relaxed/simple;
	bh=7wv5NEnh1iYigDfBPsbFvsMDHIIIJFnsQzqUuN22mBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1Fl7RlbA3HlHkT1Kt6RJTdbN0QfuvdYIYlZpk0Ok8T+QlvJ+RVoYfL99aCP2vNMxsYQpBYxeiBInuT/IgjOkCPQV1ZWIp9Bnou/pdF9gp2OLzdFQUhvbUvV1oO4pE7a8N3KTmFdvK5zp7UUcjE0Q6FmbCvcYoE5/MA6PLxVJZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQna8sE2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQna8sE2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6450B1F00898;
	Thu,  4 Jun 2026 20:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780604992;
	bh=m76a07sgvFnLO6a/fVyVwEcOwxuexhyOw4gFdIkx5vo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OQna8sE2avL8iVRlX6aem1+N9+jXJ1QuXfXm03bmURNcWx3lQmA4wV/6MGx5j6tcJ
	 FTM2Zv/5Dl7/pEu1UkkR0qsHL6RSAoLM4h2BAK/r/I/14cehT2eqzuXIlOX/h4cwBi
	 eyqtUbCIciwYKYhGC50n4IqTwseWuuDonqjnMLCMDXyNUn0cAfutq1sMmD1XHP9wgf
	 mkuOglaD6/Be4Re88fxy6AHNREnsvBybK9z+oCdm2P3IuYr5ecufX5yXdTDmrKs99o
	 thXI6EMguuFumawydXZNIHgPowXZvdLQedd1HHhxI6EePz1cUPRCEY+vBeY1M6piU4
	 hFp07ASig3Slw==
Date: Thu, 4 Jun 2026 17:29:48 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Suchit Karunakaran <suchitkarunakaran@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, james.clark@linaro.org,
	tycho@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] perf/lock: enable end-timestamp accounting for
 cgroup aggregation
Message-ID: <aiHgPNEztk-eALlN@x1>
References: <20260530195940.78700-1-suchitkarunakaran@gmail.com>
 <aiF_gZBqoajF1xXe@x1>
 <aiGoUxZvM46QiAUA@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiGoUxZvM46QiAUA@google.com>

On Thu, Jun 04, 2026 at 09:31:15AM -0700, Namhyung Kim wrote:
> On Thu, Jun 04, 2026 at 10:37:05AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Sun, May 31, 2026 at 01:29:40AM +0530, Suchit Karunakaran wrote:
> > > update_lock_stat() handles lock contentions that start but never reach a
> > > contention_end event (e.g., locks still held when profiling stops), but
> > > previously treated LOCK_AGGR_CGROUP as a no-op due to missing cgroup
> > > context in userspace.
> > > 
> > > Fix this by adding a cgroup_id field to struct tstamp_data, recording it
> > > at contention_begin using get_current_cgroup_id() when aggr_mode is
> > > LOCK_AGGR_CGROUP. Capturing it at contention_begin is semantically
> > > correct, the contention cost is incurred by the task that had to wait,
> > > not by whatever task happens to be running at contention_end. It is also
> > > preferable from a performance standpoint, as contention_end runs just
> > > before the task enters the critical section.
> > > 
> > > Update contention_end to use pelem->cgroup_id instead of calling
> > > get_current_cgroup_id() dynamically, ensuring both complete and
> > > incomplete contention events attribute the wait time to the cgroup at
> > > wait-start time consistently.
> > 
> > Namhyung, can you provide an Acked-by or Reviewed-by?
> 
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
