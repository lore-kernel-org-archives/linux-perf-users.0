Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2A849F130;
	Mon, 14 Sep 2026 20:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789418532; cv=none; b=aRDZ427fo/RJGY5TXD3DgXZtIXhIxfbzyEGWnXlTdbUZQCO92WM8ZsT6Pc5SSZMe+6dy2MgP6wQYVjB0z/ftQgWc9A/JuQ5PobAU2e6TLmkX6S88iSJ9Mkk16mS/Bqf2pjx3Kt2s9M1X7QGSKXD1PgJ9++JO97cDC+cYeASW0sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789418532; c=relaxed/simple;
	bh=eOOIv/OsmlSmYxEqa3qRxMsZ4HZj8ii6y1dUDWYfC4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nB1CFA1dPB2P+qtFd9wVtwqNKNCWT58PfdYGN5N3UbTj3TzE0DIWs4yiSbucju19pGJejPJcdNLnqwt9sGnJwZjp/YuYCKDXAxBcxrATZ2TyFMmPz3Ih1Wps0B5JCKiXphkCqjOiRXHtithyVjjPXZMU6vebQXWGT4jAnWjGy2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzEcW3jJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzEcW3jJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1005E1F00893;
	Mon, 14 Sep 2026 20:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789418529;
	bh=7GB2jjMKZ5j4wNAac9G1bk23M1GI2bDlsfoiz1Mb/hM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VzEcW3jJ80fYPea7giJ57hO/tuRvn/RbSjfDfRVZiC1K5bG0tm7nNfPr8ccWmx2Fy
	 8H+GIiSR6I1zsUi5rGYQlgTYuxgbtt9COvjLKfI2MkZI5Ks6AvwCzP5xY7UjFXu8H+
	 4mnMGxnuBj6JNX9WxEZnkQLy1jVbNkL4Snxt6logVQFLKiWpIjlE7Fb6nxhQfqJlmZ
	 solWrBjGsHZmksezt7xi7gVtfjt2t0WRMVladPfnelX50RQmSL7Gtwk0MVJfHXts7Z
	 1wYudx/B1CpLCwrWv8GTI08GKVoDuVdcq/Y0uwh2WboNt3IJblZsELID9tIwS0E4Y5
	 O7YnEQor8cTHA==
Date: Mon, 14 Sep 2026 13:42:07 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Tengda Wu <wutengda@huaweicloud.com>, Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Zecheng Li <zli94@ncsu.edu>,
	Yanbo Zhao <yzhao62@ncsu.edu>,
	Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v2 1/4] perf annotate-data: Convert type histogram to
 hashmap
Message-ID: <aqhcH3wzXfyL7_8V@google.com>
References: <20260914064535.1671939-1-namhyung@kernel.org>
 <20260914064535.1671939-2-namhyung@kernel.org>
 <201cf528-d07c-4052-b0b0-11e5f9de97e4@huaweicloud.com>
 <aqhDYxJ9qf_gE5KC@x2>
 <aqhJjtWljIoMKfI_@x2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aqhJjtWljIoMKfI_@x2>

On Mon, Sep 14, 2026 at 04:22:54PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Sep 14, 2026 at 03:56:35PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, Sep 14, 2026 at 08:22:06PM +0800, Tengda Wu wrote:
> > > On 2026/9/14 14:45, Namhyung Kim wrote:
> > > > The type histogram maintains sample counts and periods per offset.  Use
> > > > a hashmap instead of an array to reduce the memory overhead.
> > 
> > > > No functional changes intended.
> > <SNIP>
> > > > -	struct type_hist **histograms;
> > > > +	struct type_hist *histograms;
> > > >  };
> >  
> > > >  extern struct annotated_data_type unknown_type;
> >  
> > > Reviewed-by: Tengda Wu <wutengda@huaweicloud.com>
> > 
> > I'm cherry picking this first patch, as I'll need to rebase my branch on
> > top of it and thus testing it as I go developing it, sashiko found no
> > problems and Tengda reviewed it.
> 
> It is now in tmp.perf-tools-next, will do the usual set of containerized
> build tests and push,

Thanks a lot, Arnaldo!

Namhyung

