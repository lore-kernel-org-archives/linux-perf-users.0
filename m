Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B5615ADAB;
	Wed, 16 Oct 2024 04:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729053230; cv=none; b=fRDAAhqNAKUGvaX0TyLAjcN7R0uQIpfsTUG28K/61zAv57eagMornZK9G5zjsgF4+dgb7U2fgJJT7228hT29Jxr/uPIaNZJt5fXKskNP8beZKhv9WWeCJNJqKoStS30bNRdVmjiaCQLJzWXrjYn80vcYxhlCYV6Dhbnn3Y2pMDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729053230; c=relaxed/simple;
	bh=mxN1mIPcd+XN1WgRJWJbfYMuGgJol8BgcGHoph5JMJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gfgm1edVds2Qxs9jX+bNNFHB1wTj7PjT2C0/MjVXy0r5tCEtcMmWJasGbVyBWeclaa2N6c7LxXA8488rrC5xHTtr/oSB7mnmqv194knDLfQ4mG/WxG69LXCOVVFFEqJbVvRYTNFn/JYOopTnKB42cdbKDXRHDuuIv6A0aNKiQqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqhVFIMN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqhVFIMN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E59C4CEC5;
	Wed, 16 Oct 2024 04:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729053230;
	bh=mxN1mIPcd+XN1WgRJWJbfYMuGgJol8BgcGHoph5JMJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KqhVFIMNlP5lAvTRuKZFD6YdhXUdMHgY9l9RKh+pvC293g77AICr4X8HFWzPvS1mZ
	 dzT4Cn2ADbd7dBwK7PkgBqZk3f8QRnBKdZM/oXBBPeknl0mi70nmS5++Mc8/NZgiRh
	 XUmoXGBpa2wEKVaCLNYY7f2xlcbh7j8Lz3mYTu45qoQR0LxbkOam2C6qS748Tu/IH3
	 5wvR7n9elpahHidxVf42a2zwRBLPtVFsLj+MyyAp2ZWXhLOQ5wXM+NQZqVp3gAmmfv
	 g9YSMOGTNfrz2LeCAITMNNnNdCRKSfrfzd86JhvbfI2/xPQToMMFs3QrSjh2/m8+tl
	 KilOYEMmL5Jeg==
Date: Tue, 15 Oct 2024 21:33:47 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>
Subject: Re: [PATCH 7/8] perf tools: Check fallback error and order
Message-ID: <Zw9CK2mS6fHoxnKf@google.com>
References: <20241001002027.1272889-1-namhyung@kernel.org>
 <20241001002027.1272889-8-namhyung@kernel.org>
 <CAP-5=fVBhLfb3Md1b6NZqmOh4q4_S5=g8hA7p6UzuPJG2GfPiQ@mail.gmail.com>
 <ZvxrQsHML0A1kF1P@google.com>
 <CAP-5=fUAqmvA+pzE15Lmk4Aakj6tOzrqYFhYb43UX9B3E3Odmg@mail.gmail.com>
 <Zv7O_XJZcSIS9I_i@google.com>
 <CAP-5=fUVLEo0f5ygccnf11J2zdZbFmoGF5UatAb+E8T9vwbeAg@mail.gmail.com>
 <Zv8cyZN1p7EI08XA@google.com>
 <Zw1vcnX-HdnmJMU1@google.com>
 <bbffa9eb-0102-4c35-8b1a-4e26634aa878@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bbffa9eb-0102-4c35-8b1a-4e26634aa878@amd.com>

Hello Ravi,

On Tue, Oct 15, 2024 at 09:51:50AM +0530, Ravi Bangoria wrote:
> > @@ -2366,9 +2403,6 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
> >  	return 0;
> >  
> >  try_fallback:
> > -	if (evsel__precise_ip_fallback(evsel))
> > -		goto retry_open;
> > -
> >  	if (evsel__ignore_missing_thread(evsel, perf_cpu_map__nr(cpus),
> >  					 idx, threads, thread, err)) {
> >  		/* We just removed 1 thread, so lower the upper nthreads limit. */
> > @@ -2385,11 +2419,15 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
> >  	if (err == -EMFILE && rlimit__increase_nofile(&set_rlimit))
> >  		goto retry_open;
> >  
> > -	if (err != -EINVAL || idx > 0 || thread > 0)
> > -		goto out_close;
> > +	if (err == -EOPNOTSUPP && evsel__precise_ip_fallback(evsel))
> > +		goto retry_open;
> 
> This will change the behavior of events like instructions:P on AMD.
> 
> Without patch:
>   $ ./perf record -e instructions:P -- true
>   [ perf record: Woken up 2 times to write data ]
>   [ perf record: Captured and wrote 0.009 MB perf.data (9 samples) ]
> 
> With the patch:
> 
>   $ ./perf record -e instructions:P -- true
>   Error:
>   The instructions:Pu event is not supported.

Thanks for the test, it should support other events too.  I've noticed
it returns -ENOENT for non-IBS events with precise_ip > 0.  Will handle
them as well.

Thanks,
Namhyung

