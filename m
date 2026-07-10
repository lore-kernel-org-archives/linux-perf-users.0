Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764F63CB2DC;
	Fri, 10 Jul 2026 21:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783720171; cv=none; b=hBYUO8NnbUZDz+NNqloucDHK93YQWsztwI3rXB7WY4XKyQZ++CB/ispA/lQMNHFoOq4+Es4KVb6DIb+qXD7r4R89bfsQ//rijQx0dRNv2gUJPAvNeyjYzA1pOFrAGtSkj3WVWbUPnt4rpmg/OURusArKzhPNseoIgAxLJKvAZwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783720171; c=relaxed/simple;
	bh=WHu0PeLwGPFhhuyAt9+CbqQmSL81S2JOt0ZOXeRkhJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enIl8nhJ9o8BIqaNF2iwFP+salfoKHSS7wfpvbWN6+1vCuTkUiQuWMmnACfnTMvTQooI3+5myYlJdmk1ueB83NiF5FRHMmiMvqk1jpew5gptu4pRaAJsvkEyN5KvhNLB9BSvJN00VFcTRqB77O3K7QdUffIh5I9QViHujxevpYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbeg43FZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbeg43FZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C7B1F00A3A;
	Fri, 10 Jul 2026 21:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783720170;
	bh=CTY9K5S6ZwpYPh7TKeN0acL59vEp6+U4ctqjqRJAw5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gbeg43FZPtCay+vQ2D09zQAavr8xvnkx0oABBPZJwU2HTJhsLmU/oS9xcrqt4vMM3
	 swGPUml8E3ZMhdVo9refNk5oM302Du3sCt9dlSD6S6gfZ2bCv/89vKXocf8ETJrmGO
	 l9GGjdcDilNS5MDeqlTB2Rkxp0fGj5pN3ddNObvFTEqc5uHk0YEIdsD8iFfc9EWoql
	 PZVKB3wlK/w6U3TENFY6bsKQeO0pbJMYJEpfFDBKnXGgjnv4gKrfrujdUfVMJAcjq5
	 +Ow+fTf6yQqX1Rxoq7duEJi906qF168mbhfeXLnkExKpi3hk+O1lcilbq3bdMXer3F
	 z9ySGb/gcLhYw==
Date: Fri, 10 Jul 2026 14:49:28 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: james.clark@linaro.org, xueshuai@linux.alibaba.com,
	Li Huafei <lihuafei1@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v3 01/21] perf capstone: Fix kernel map reference count
 leak
Message-ID: <alFo6AV1XkTDtznm@google.com>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-2-wutengda@huaweicloud.com>
 <ak84NFSWQXz3r46x@z2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ak84NFSWQXz3r46x@z2>

On Wed, Jul 08, 2026 at 10:57:08PM -0700, Namhyung Kim wrote:
> On Wed, Jul 01, 2026 at 03:53:35AM +0000, Tengda Wu wrote:
> > In print_capstone_detail(), maps__find() is used to locate the kernel
> > map. This function increments the reference count of the found map
> > object. However, the current implementation fails to call map__put()
> > after the map is no longer needed, leading to a reference count leak.
> > 
> > Fix this by adding a map__put(map) call to properly release the
> > reference after use.
> > 
> > Fixes: 92dfc59463d5 ("perf annotate: Add symbol name when using capstone")
> > Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> 
> I'll pick this up separately.

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
