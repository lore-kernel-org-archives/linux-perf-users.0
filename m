Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A285D1E25FA;
	Mon, 10 Mar 2025 21:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741641409; cv=none; b=a+UJ0tVdRLM4opuKD59t6muuEV8fcpAqF5iUFUgLpeBbt5L8t/rxG4aaMQ04BOxNnJNjDBXWMR7C7ZbPLWKIHbJPcknxs1WzS+l1AVgYT6QjTJMk5db1EmHEN2+Gbqn+cAQ2EqwA6XYd8TtTm/o6XoNM5dDUI1qRc5vhocOEUnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741641409; c=relaxed/simple;
	bh=xRXrFGP7wUOfOAsju49eTehADOAhAi/aD4jCXZc/fc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1KwKJzeALzzoGyehnDY6komx09a6Xfi5s5KkPXvK4TwiSmttCWCXq6f5VjBvpJoDhk5J3J1XrHWt9Ck0lzTPywz9exMCHTC587zm27veIQ77Ni/mzz3szW4rBpi1MkQL8YKMbzY5VeS/q6wvktvadgrduFZBZp2p32xxSgxSmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntPv6AwQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntPv6AwQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C584BC4CEED;
	Mon, 10 Mar 2025 21:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741641409;
	bh=xRXrFGP7wUOfOAsju49eTehADOAhAi/aD4jCXZc/fc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ntPv6AwQDjqogtSL39In3AGRiH3y5DqAFy/6jxfBY8vqRtpGi5RslnakwzwiUHna5
	 M5Y0soL8+SXr02nfuXZRivPJdFc/0j63EbgbWitkomUP0Tr1AIt3eHQ7d+0cwQTSYZ
	 qyn6/gPh6r7on4K6HgcRBAzft3r17ElZZDodAluA63WyBCGlFlfee5aJPmSZuiSKJA
	 MtOzJjIDcFkOZm0tYlz4bfKgMbkleBRr1NQMATNHHSlbULI0U10wo97leFsczHyBf2
	 WTTeK/KMmH5BVBo3+MTHITjLtdaZ8KEkYSJOtA/GCrgRIHblzo0zbCfhjxfeyvFWnc
	 tzQDvt9wFBlUQ==
Date: Mon, 10 Mar 2025 18:16:45 -0300
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
Subject: Re: [PATCH v2 11/11] perf python tracepoint: Switch to using
 parse_events
Message-ID: <Z89WvaIVyF7klGp6@x1>
References: <20250228222308.626803-1-irogers@google.com>
 <20250228222308.626803-12-irogers@google.com>
 <Z89We45bGpeJvO9C@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z89We45bGpeJvO9C@x1>

On Mon, Mar 10, 2025 at 06:15:42PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Feb 28, 2025 at 02:23:08PM -0800, Ian Rogers wrote:
> > Rather than manually configuring an evsel, switch to using
> > parse_events for greater commonality with the rest of the perf code.
> > 
> > Reviewed-by: Howard Chu <howardchu95@gmail.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Now will all in place I'm trying to test it and I am getting some
> strange results:
> 
> root@number:/home/acme/git/perf-tools-next# tools/perf/python/tracepoint.py
> <SNIP lots of seemingly ok lines>
> time 78318710956557 prev_comm=sudo prev_pid=3133818 prev_prio=120 prev_state=0x1 ==> next_comm=swapper/14 next_pid=0 next_prio=120
> time 78318720082300 prev_comm=swapper/16 prev_pid=0 prev_prio=120 prev_state=0x0 ==> next_comm=kworker/u112:8 next_pid=1752774 next_prio=120
> time 78318706232435 prev_comm=kworker/u112:17 prev_pid=1551246 prev_prio=120 prev_state=0x80 ==> next_comm=swapper/21 next_pid=0 next_prio=120
> time 78318708202121 prev_comm=sudo prev_pid=3133818 prev_prio=120 prev_state=0x2 ==> next_comm=swapper/25 next_pid=0 next_prio=120
> time 78318748346989 prev_comm=swapper/26 prev_pid=0 prev_prio=120 prev_state=0x0 ==> next_comm=gnome-terminal- next_pid=3551 next_prio=120
> Traceback (most recent call last):
>   File "/home/acme/git/perf-tools-next/tools/perf/python/tracepoint.py", line 47, in <module>
>     main()
>   File "/home/acme/git/perf-tools-next/tools/perf/python/tracepoint.py", line 42, in main
>     event.next_comm,
>     ^^^^^^^^^^^^^^^
> AttributeError: 'perf.sample_event' object has no attribute 'next_comm'
> root@number:/home/acme/git/perf-tools-next# 
> 
> But it shouldn't get there as there is this check:
> 
>             if not isinstance(event, perf.sample_event):
>                 continue
> 
> 
> :-\
> 
> Trying to debug that...

And it doesn't seem related to your series, I checked and v6.13 has the
same problem, I nuked the build dir, etc.

- Arnaldo
