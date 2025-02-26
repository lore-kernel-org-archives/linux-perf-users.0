Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A9A25CC62;
	Wed, 26 Feb 2025 22:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740608420; cv=none; b=Sfelj9XUCg+PBc9IrQhGakvETuq0XOU0OAOGQVA2FhJeiHMJV/S6BeTPOu8Iz9odtPjj+lMG9APCLdXoGbmwaSHkdgg27HfX8YTu0ZHWECpWk8ZH6MNgLda1F+rgAiafEkSvtNT0X2n0iKKGot0OrrMuSgmgA99Q/bC9jABOGd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740608420; c=relaxed/simple;
	bh=07qZhyJhISYX9/vYcEeK3yIoNGlDFfoBl+hGuICMjrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yk+Df6pyq7DbmsiscB6G6Tg1h03vzhBWcD9/DV5YKlSbOocv04aHwp1/601CJf5tGFLRcLjisTR51W4QmdzASM+par4lyoNoU93MbHAIleE1jK/yfS3RsBHBZWQpA3Vz8CGiRRt6Ps9gQE6FGQyvssV8nLVLYd7bO7iRfEESG0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+Wjd9c4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+Wjd9c4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B654C4CED6;
	Wed, 26 Feb 2025 22:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740608419;
	bh=07qZhyJhISYX9/vYcEeK3yIoNGlDFfoBl+hGuICMjrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l+Wjd9c4BiW7MdyTWgmca97572+fy0U6HdAnAGyr2Z+yZkQQJHeX62OnuERZ5Esa6
	 eoniR6IvEgvy+PqwmvVV/Kl+0NP5ZQw7v3tCi9J2zRP9il6omYW4kT2JLStu/WGBJu
	 R18h1QSnFRto3uSg4fzdVc+IZP9dWG7rq9HG7Aovu1z6xFNC+gu65sgNuZ8GmmV/nB
	 Ig97sN5CMs+3DqmGfD7uzQabu1v2FVbEWWFSOEdHMKWwwycAoa9+2x/P8p1nKFf/Y8
	 mgDulYmPPW+Cq7pBzQXsZfySR/U6p5mZPyQUuPQCumenUF4BmwU8pFO00/ZjtdrTg8
	 eBIJfCLH03+SA==
Date: Wed, 26 Feb 2025 14:20:17 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Song Liu <song@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	James Clark <james.clark@linaro.org>
Subject: Re: [PATCH] perf tools: Skip BPF sideband event for userspace
 profiling
Message-ID: <Z7-ToRjLenCgO2G7@google.com>
References: <20250226203039.1099131-1-namhyung@kernel.org>
 <CAP-5=fVh2tTD22sFrPt37OJAhOsggvt2AVwf45p_pxTa=pnVKA@mail.gmail.com>
 <CAPhsuW46wuwoXSf-Vq5Y78b3GeGspA3PqtNMm8GTHXAMmnRNbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW46wuwoXSf-Vq5Y78b3GeGspA3PqtNMm8GTHXAMmnRNbA@mail.gmail.com>

Hello,

On Wed, Feb 26, 2025 at 02:00:36PM -0800, Song Liu wrote:
> On Wed, Feb 26, 2025 at 12:59 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Wed, Feb 26, 2025 at 12:30 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > The BPF sideband information is tracked using a separate thread and
> > > evlist.  But it's only useful for profiling kernel and we can skip it
> > > when users profile their application only.
> >
> > nit: It may be worth noting that profiling an application implicitly
> > excludes the kernel samples.
> >
> > > It seems it already fails to open the sideband event in that case.
> > > Let's remove the noise in the verbose output anyway.
> > >
> > > Cc: Song Liu <song@kernel.org>
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>

Thanks for your review!

> >
> > I wonder if the second evlist could be avoided similar to Howard's
> > off-CPU sample events?
> > I also wonder if we should make the evlist responsible for BPF and
> > dummy/sideband events. Having unnecessary events increases the list
> > size iterated over when creating sideband data, and so has a runtime
> > cost. Having the logic separated in places like builtin-top and
> > builtin-record feels suboptimal.
> 
> It appears we can indeed put this logic in evlist.

Ok, I'll give it a spin.

Thanks,
Namhyung

