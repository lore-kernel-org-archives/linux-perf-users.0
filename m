Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FFD38736E;
	Mon, 14 Sep 2026 18:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789412202; cv=none; b=QBLQ+O+px4LXw0p1yTupcfzyfJuRYPJB5DAC1DcMHVC2DmDqJSpWawAHcylaodpLTO0pW/OItvD+iM2CnoHSVz11QZ0OcceI0Xo6ZN6yQqPkuxa3do/Q7rNHE5/2QPs75u5sRB3SJVbBFuUOLZOjzqIbAxX4DOrGVLhC68F4CbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789412202; c=relaxed/simple;
	bh=aTcX3MS6XL0q4pKVu/kwA01cXUXb8G69cMwwQgte+Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5KSzoTuRsfhOMRTxW5qR9ioZSrJ0Y1fhlahk0U6xBa9OJx3+B3tSIxdwSYi5Tf7u3jzc2HRfyKy7dAPUT3H7B+IWGpvSo7D58Bj5H4JPzyA9uxr8MxKXu+R9xEWriQqIroDnYsECMPKJRVGZDMfNUDI8E9+NWPcy8eo08xV6LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKi1kdLY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKi1kdLY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE6C1F00893;
	Mon, 14 Sep 2026 18:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789412201;
	bh=ByebtW0YL7USnNwtGYu97U5Ya6awVMbwopxJ21gvg1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bKi1kdLYxxj9Zjlzna0l5nZpPXqmbmgPu1klanMu/cG0RGXnus3CqG5Ctvj/r9nf7
	 w7DaVL+RTilUIrm9Ez5J6ttvYHZUJ9qiK09yK/3dGIpx+QX8d4FGl33YBibWrvCk4V
	 /biUZf53OdXFV2ENgwD5wlEDajyoWTZA92G4zaVv+fLkGZFdCXRMrUiUliVqzYidWg
	 N16qDVJYshvleBTPeMG8lNADyPgnZLs8pUHAE9zPbVuzMWKFa8NOqd8jI+ZFYe0Cg7
	 nPs+bkez8rrjG8I3RT0chnmfUTrjPXOC4fFsUinGPqADQvsC97AuOOPJ+y+xbz11VH
	 270/2QrdlqW7w==
Date: Mon, 14 Sep 2026 15:56:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
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
Message-ID: <aqhDYxJ9qf_gE5KC@x2>
References: <20260914064535.1671939-1-namhyung@kernel.org>
 <20260914064535.1671939-2-namhyung@kernel.org>
 <201cf528-d07c-4052-b0b0-11e5f9de97e4@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201cf528-d07c-4052-b0b0-11e5f9de97e4@huaweicloud.com>

On Mon, Sep 14, 2026 at 08:22:06PM +0800, Tengda Wu wrote:
> On 2026/9/14 14:45, Namhyung Kim wrote:
> > The type histogram maintains sample counts and periods per offset.  Use
> > a hashmap instead of an array to reduce the memory overhead.

> > No functional changes intended.
<SNIP>
> > -	struct type_hist **histograms;
> > +	struct type_hist *histograms;
> >  };
 
> >  extern struct annotated_data_type unknown_type;
 
> Reviewed-by: Tengda Wu <wutengda@huaweicloud.com>

I'm cherry picking this first patch, as I'll need to rebase my branch on
top of it and thus testing it as I go developing it, sashiko found no
problems and Tengda reviewed it.

Thanks,

- Arnaldo
