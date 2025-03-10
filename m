Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC36EC5;
	Mon, 10 Mar 2025 20:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741638169; cv=none; b=XfMmsF9ro3uGb6gp0gRkG6VT9mPp/bSE3vz5kzdob7paIx8X7dT/3fIz7LF/aOT3lHNNIfjLHqHTm2b+EBqxK9MPoXMebb50WMSeNe/p4T46dI0IVBdpU7h9F/tKBJHyPIKURSiIyERIwHc8059/uKIvBqFQzC14yqCG6tKniVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741638169; c=relaxed/simple;
	bh=noq37JP5Rq9ToLD7jW58TWDFFnYeTxmbxxmcOmoeV9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JhA29IQomRGNGe0YF2SS59MgCIGyNM+6hPoWFmk/Tsut7W4wfTsC1F9wscjIrmK6s2pH5+NSOxGkoSvhqzA3VnCOF0Xsyqx0D4F8zIy59LLgvl89P/+sLj6s1F/4VK1f+GM+XKdEWcYB60Ux31XU0LRfRN0bbAKE0qn9cRQ8B8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJtkWd7+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJtkWd7+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EEEC4CEE5;
	Mon, 10 Mar 2025 20:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741638169;
	bh=noq37JP5Rq9ToLD7jW58TWDFFnYeTxmbxxmcOmoeV9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YJtkWd7+EwPayk6jsXmO+CurZdbvE2c4S2Ehd7xua7TmbrwgoaaS0+FD+CaGXACXO
	 EaJRFhfcXdOYvy/Zg/7YLkAegKg4ume8Uly/OAS3y80R7TqV5vddApjKUfhKuGQDgs
	 eeQ5tXBoDtEbOj2e2nL68i8sKlj987qpAr+2nB6d64flX2EE3+czs3x7wOswhoDu92
	 RpOC6eDqN0qesYBR8jc9qni0Fo8asVuovJfiMfRZtgQeUo9wkVMvqtFYZ300LcG5qq
	 cfVUja+4xXC1Yi5ffuZkG3vpyv4ELTedK4omB/FXOGXPgMlcdmNSKGWQEJNAm6I+f7
	 TBLYSz8IJ7Q2g==
Date: Mon, 10 Mar 2025 17:22:44 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	James Clark <james.clark@linaro.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: Re: [PATCH v2 01/11] perf debug: Avoid stack overflow in recursive
 error message
Message-ID: <Z89KFNVbh__UXjEg@x1>
References: <20250228222308.626803-1-irogers@google.com>
 <20250228222308.626803-2-irogers@google.com>
 <Z89J9cBUR6NCMaaj@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z89J9cBUR6NCMaaj@x1>

On Mon, Mar 10, 2025 at 05:22:16PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Feb 28, 2025 at 02:22:58PM -0800, Ian Rogers wrote:
> > In debug_file, pr_warning_once is called on error. As that function
> > calls debug_file the function will yield a stack overflow. Switch the
> > location of the call so the recursion is avoided.
> > 
> > Reviewed-by: Howard Chu <howardchu95@gmail.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Good to add this so that stable picks it:
> 
> Fixes: ec49230cf6dda704 ("perf debug: Expose debug file")

Forgot to add:

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
 
- Arnaldo
> 
> > ---
> >  tools/perf/util/debug.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
> > index 995f6bb05b5f..f9ef7d045c92 100644
> > --- a/tools/perf/util/debug.c
> > +++ b/tools/perf/util/debug.c
> > @@ -46,8 +46,8 @@ int debug_type_profile;
> >  FILE *debug_file(void)
> >  {
> >  	if (!_debug_file) {
> > -		pr_warning_once("debug_file not set");
> >  		debug_set_file(stderr);
> > +		pr_warning_once("debug_file not set");
> >  	}
> >  	return _debug_file;
> >  }
> > -- 
> > 2.48.1.711.g2feabab25a-goog
