Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8568B18B03;
	Thu, 12 Dec 2024 07:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733987336; cv=none; b=HcsWuVFa9/a7+XUQLp36zJN7jMKi3/03VNSPo8eDhjYwRExc64PoGTmAEHatw88EsYmZh8eZ7Y2SO05eDETb2HzZT+5E1hp+cfCDHol68Arg5H+TR3pVz8HCeC64QBj03ekzmWORzwec2JFLdHZa7s5rKcIS58nDohSXRGoB/ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733987336; c=relaxed/simple;
	bh=XiVsMC9AOIlXzvb2+9UZNN0fj2CBGPWDzRzevng4FsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3HYdO5BoMOpLGknh9GIYi24RqkqvaY5BxUeuoOhsGkYWxLT6BWzP3SvwutCvWVtnHUmtRajs/gj/d3+kZXb+0cnL7NLH00A11UQYCdbEu2lRlk8dNNDz5ut2z2oFAV2H9BfJ1EpZJXXwhzu+B13SBmwzi/FOzzyXMhQZ+J5iV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlBY0TYx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlBY0TYx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CACAC4CECE;
	Thu, 12 Dec 2024 07:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733987336;
	bh=XiVsMC9AOIlXzvb2+9UZNN0fj2CBGPWDzRzevng4FsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RlBY0TYxxfipaytpfGP5v3efqmLGzKcYrzvrNoIncNxpM0/3NNHRlMqI6Hc2oLMxS
	 RhPr+c31Fc9jmQojmuKmkXqbOkln7OKzvDu8sJZa5dO1YLYwgnxE2JZH7MrJTZBuyT
	 fApBcNfWDsu8spUy12BYVecqrihg7tt2aqABzI7UVbxQdGKq7YxImzURtb3BV4KdAy
	 HIM0VTbJMHfOwgjmYcl2OUM7Ea/HWhMOiUd12wifecj/3AdfxDPUJ12gVBjAKPCyjG
	 x8DJjstqZ7A9ORTLmRFXG/9ocNzideQOunZaICVE9q85MQUSqwNahSiPoAnaS3lxde
	 aCaY+nFGeNDjQ==
Date: Wed, 11 Dec 2024 23:08:53 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
	mhiramat@kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>,
	Dima Kogan <dima@secretsauce.net>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf probe: Fix uninitialized variable
Message-ID: <Z1qMBSkp7Ry0LEOd@google.com>
References: <20241211085525.519458-1-james.clark@linaro.org>
 <20241211085525.519458-2-james.clark@linaro.org>
 <Z1mQcsDCw0d8djjx@x1>
 <Z1nJdd3YF5YGvlqp@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z1nJdd3YF5YGvlqp@google.com>

On Wed, Dec 11, 2024 at 09:18:45AM -0800, Namhyung Kim wrote:
> Hello,
> 
> On Wed, Dec 11, 2024 at 10:15:30AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, Dec 11, 2024 at 08:55:23AM +0000, James Clark wrote:
> > > Since the linked fixes: commit, err is returned uninitialized due to the
> > > removal of "return 0". Initialize err to fix it.
> > > 
> > > This fixes the following intermittent test failure on release builds:
> > > 
> > >  $ perf test "testsuite_probe"
> > >  ...
> > >  -- [ FAIL ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -L foo -V bar (output regexp parsing)
> > >  Regexp not found: \"Error: switch .+ cannot be used with switch .+\"
> > >  ...
> > 
> > So Namhyung, this one should go to perf-tools, I can pick the second on
> > perf-tools-next, so that we keep perf-tools as small as possible.
> 
> Sure, will replace and force-push.

Applied patch 1 to perf-tools, thanks!

Best regards,
Namhyung

