Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5262D5B21A;
	Fri,  5 Jun 2026 23:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780702096; cv=none; b=ScJ+c2y7O2TZ/fOnKKfmsojwTk9uIPhYRs0P+ILkQD8cYQp8/AZpdhY7vNqGS5chA8i9g02RIoZ7913pMDaW0IiE+YpC900sCgmG50xisie34dAU3PukYFXBfz/s/+oAVSLny8znsoeOpJgi96QF66iChiP5NERKA0tLMHpR0Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780702096; c=relaxed/simple;
	bh=rWXUMxHNg0eiql+sQ7qli3PqRoS+5xd4oaVDfgHZhQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJ0K/gcE0a2eZailiwYvXmWHO6uVBphqOaMXpWlVoOf9U5wDs6wW4WW/TJsNFClSV44zrMASynODpUKtvyYjvCpFLIXiWjpWmIIjit6d9aZ84DUyOOiPqQt1yaZKgkilxvZt4igkDQEzIEUyBed5QXatDzviSxtTIZDFhvUNOoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBw/14Lk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBw/14Lk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5D91F00893;
	Fri,  5 Jun 2026 23:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780702094;
	bh=VTSEhLpmkQWEl3+5sjeoku4x3rqbqaHEnjW37hIkbqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VBw/14Lk4O4FRFXZbE3IC/p3P/tmBsIUw9Vv6pDz/Iv+Zpo1RCR684MNwbgkwAJB5
	 dnBG0FjsivJ/O64RdOqtt/AJ1xjkx/KjgitfKYixjF7EMInAwKPtAfGnKOGrO18mDx
	 KHPx81I9qB5w5TQmNHxIDVguIucvyQq96ePflsIbsS3J52Ni4qdhdq0wdawcQojViA
	 aXu4uqL4vOV3WMQpezp6At/7P8ne/lzPS6hjM5H18widZuX2exPOcsSA0cgY+5lHqt
	 zOC13cmqj7WKG6CC3nn3so6omGh5XUxEpCq8tt1cb0RrCTeTvVdZqCFJqpFxXhOKCN
	 wIAPVKPFLSHsA==
Date: Fri, 5 Jun 2026 16:28:13 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/4] perf timechart: Fix memory leaks
Message-ID: <aiNbjYgW2FFltUa8@google.com>
References: <20260605231155.2415760-1-namhyung@kernel.org>
 <aiNZcZosyvKQnQk1@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aiNZcZosyvKQnQk1@x1>

On Fri, Jun 05, 2026 at 08:19:13PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Jun 05, 2026 at 04:11:51PM -0700, Namhyung Kim wrote:
> > Hello,
> > 
> > This patchset fixes memory leaks in the perf timechart code.
> > I've extended and verified the timechart test with ASAN.
>  
> Hi Namhyung,
> 
> 	You submitted a series for timechart before, so I had to go on
> looking if this was a second version or a different series.

Right, this is a different series.  I believe they are independent.

> 
> 	I suggest you always have a version in the cover letter, i.e.:
> 
> [PATCH v1 0/4] perf timechart: Fix memory leaks
> 
> 	To avoid this brief distraction :-)

Ok, I'll do that if that helps. :)

Thanks,
Namhyung

