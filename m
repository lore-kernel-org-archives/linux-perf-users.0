Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5B128369F;
	Wed, 28 May 2025 13:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748437737; cv=none; b=lQ4KZs8O3ptj1ct36tj4ROOQf682PD86cUSsclEL2e1jB/fxSdRO2FzQiKsDmBD1fMjIK6/R4fGS4A5SZbJjkfx3Sx6qxD/n6KRQoTrpyqwFhsnd/5qF/0UvnYhYIcd2a9RaoLO4VvuWtDaESb01Z1g5SgcEKvtMgO21sFd6GWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748437737; c=relaxed/simple;
	bh=Mk5F2XnA3g8hN7duqFGxmuou7OdhCtgoPWCpS5amOi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGJn+H2HvtYFJkZ6/ytZ1Qa/+nachhziUJ05vhJQF91rkUFvgAWE5bKqYV5x0mwZn8kMTjkryxcN5b9pidtiM63IINs70Y2PPzRRSJ9Hg3fZBRcftqcRV7SI2BUg01avMzY2MalOT0VRnze2l0BuGtKJ6AdyjA3bLFOQ4evAB/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Np/WK2Ga; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Np/WK2Ga"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143D5C4CEE7;
	Wed, 28 May 2025 13:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748437736;
	bh=Mk5F2XnA3g8hN7duqFGxmuou7OdhCtgoPWCpS5amOi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Np/WK2GabatE2gne2mHHy4kvHMSkTY5j9zZW/VAFLl5C8mOQIBcZGfgdrkdVt4DI9
	 akDQqxkSnZvD8qEg/4i4P5w/B3uk4xXgDuE35ML1BL+TCD/rQb98JapJKaoMsiwHu4
	 7Q20Rw/ilgKfg/kds48n+6mBq7in2AOCKkChq0LoTkwbmGtdQ+KOuT20jvu1lD4OMr
	 9BJ/wyWuhoHwjIHdUQ91HPlGrhJu5s7Mr6FgIt01rIALediM07eAuP5NYJPXWMOjnL
	 HNHE/5wMfsIOuswUJIImO1b3YggxEd/KjU7O2msmrw7iCLJXf14scVavqoc8mh2Fxm
	 s/ClZMgtHWDaA==
Date: Wed, 28 May 2025 10:08:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tests switch-tracking: Fix timestamp comparison
Message-ID: <aDcK5arEEsccWsJC@x1>
References: <20250331172759.115604-1-leo.yan@arm.com>
 <aC_Vn95vYqcXul03@x1>
 <aC_WFRe_4HjVPUrM@x1>
 <20250523081036.GB2566836@e132581.arm.com>
 <aDCsmjb7Fex1ccOW@x1>
 <20250527094924.GF2566836@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527094924.GF2566836@e132581.arm.com>

On Tue, May 27, 2025 at 10:49:24AM +0100, Leo Yan wrote:
> On Fri, May 23, 2025 at 02:12:58PM -0300, Arnaldo Carvalho de Melo wrote:
 
> [...]
 
> > Thanks for the extra info, I'll add it to the commit log message, and
> > perhaps we could make this test exclusive and use stress-ng to generate
> > some background noise in the form of a good number of processes, see:

> > root@x1:~# stress-ng --switch $(($(nproc) * 2)) --timeout 30s & for a in $(seq 50) ; do perf test switch ; done
 
> Thanks for sharing the test command.
> 
> > Now with your patch it also fails, so its for another reason:

> > --- start ---
> > test child forked, pid 1777071
> > Using CPUID GenuineIntel-6-BA-3
> > mmap size 528384B
> > 45221 events recorded
> > Missing comm events
> > ---- end(-1) ----
> > 113: Track with sched_switch                                         : FAILED!
> > 
> > Lots of short lived processes makes it fail as well :-\
 
> I searched internal CI record, we also occasionally saw the error:
 
>   Missing cycles events
 
> I will find time to check if anything in test can be improved.  Seems
> to me, the test is fragile if system has background activities.

Great!
 
> > Your patch is correct, so I'll probably just add your comments and go
> > with it.
 
> Thanks!  Also thanks Ian's suggestion for the iteration command.

You're welcome, thanks for your work on improving perf, really
appreciated!

- Arnaldo
