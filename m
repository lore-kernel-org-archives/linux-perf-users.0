Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC82266560;
	Fri, 12 Sep 2025 21:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757713871; cv=none; b=Y5P5NtyY/O1ciUlWLBBVu8xSctuZwExqs79/0DR05ZJ4GbC1imLdRcXCYoQdep2wA9xrbTQGevoIha4NYw8Ye+QHSDDuuLMArNH/x+lX7dpkzPkgIva62juDsHxTwIITMeLMfAFsCqGKJyNu5lqLqPePyWpE0f1bppoEdyZk4CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757713871; c=relaxed/simple;
	bh=kq9Qy/ReIsL5+dL9blCg5wnsGkdDjsgPnch4pg4aGYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLXoSdlZLU7DWaV5KL0+rHS4aV1u4ihofMxJxEvAVIlAI0EUN22HC08x2/fogM/USFD7TivLYAGMy8yr3YNmKw/C+gMSmmpYlGfXNg9x0ZD7ZOLuK900/EO8W46p2m/s2iRcb+Rmf0b89RTNM5r/sbuH5PDz39Zx84LBZrGyQxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fABOgf3w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fABOgf3w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0C3C4CEF1;
	Fri, 12 Sep 2025 21:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757713870;
	bh=kq9Qy/ReIsL5+dL9blCg5wnsGkdDjsgPnch4pg4aGYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fABOgf3wl0Kyo9Ywz2M8Wh7rLcJJlE9GmH1cgoo87S/WvFDgcjGbY8WUUJia/nM4z
	 evej0jD4TwOJ/eFT/6elfeJ66d0FhyQvaA/9oOb3yZkRVo8rsES3N19lJRQKs4tCiI
	 OObscnD4iKqTDUqQqRe2RWdbb1RsnlcQLgBM7xv9IQey2zErOLWYE1RdRuhhfgvckb
	 QEQK/xKAE/Jf+bFRt9ufMZZH4LDNulfyz75r+JK+OHENuR4In0sd/TtfVc2+z4bNOB
	 OTfkf+OqVnJC/rJglRNNX4qUTdjPTWG2WWIdfPrIXaxjwAx3+nIrMCN7SUQtOyfgWy
	 jbrMAn4rdO4Ow==
Date: Fri, 12 Sep 2025 18:51:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Gautam Menghani <gautam@linux.ibm.com>, peterz@infradead.org,
	mingo@redhat.com, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf auxtrace: Avoid redundant NULL check in
 auxtrace_mmap_params__set_idx()
Message-ID: <aMSVy3Y7GV1CAZDV@x1>
References: <20250804110602.23422-1-gautam@linux.ibm.com>
 <e2cc8ea1-28b1-4dab-aa42-b6aca486dbd7@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2cc8ea1-28b1-4dab-aa42-b6aca486dbd7@intel.com>

On Mon, Aug 04, 2025 at 03:08:33PM +0300, Adrian Hunter wrote:
> On 04/08/2025 14:06, Gautam Menghani wrote:
> > Since commit eead8a011477 ("libperf threadmap: Don't segv for index 0 for the
> > NULL 'struct perf_thread_map' pointer"), perf_thread_map__pid() can
> > check for a NULL map and return -1 if idx is 0. Cleanup
> > auxtrace_mmap_params__set_idx() and remove the redundant NULL check.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> 
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied to perf-tools-next,

- Arnaldo
 
> > ---
> >  tools/perf/util/auxtrace.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> > index ebd32f1b8f12..5e437133c753 100644
> > --- a/tools/perf/util/auxtrace.c
> > +++ b/tools/perf/util/auxtrace.c
> > @@ -185,10 +185,7 @@ void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
> >  
> >  	if (per_cpu) {
> >  		mp->cpu = perf_cpu_map__cpu(evlist->core.all_cpus, idx);
> > -		if (evlist->core.threads)
> > -			mp->tid = perf_thread_map__pid(evlist->core.threads, 0);
> > -		else
> > -			mp->tid = -1;
> > +		mp->tid = perf_thread_map__pid(evlist->core.threads, 0);
> >  	} else {
> >  		mp->cpu.cpu = -1;
> >  		mp->tid = perf_thread_map__pid(evlist->core.threads, idx);
