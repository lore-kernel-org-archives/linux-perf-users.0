Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDE58632C;
	Sun, 30 Mar 2025 05:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743314060; cv=none; b=ZTPaZJsiDvSjnFQvfXHf2yjPl3BobVLUO16yFcpTISY4H28dN5DnsQTqmbirpPwCyL/0aYYP6pv3shxU/gGA3iFvPkUMpiSKVqhPbKsM4XKbuqEUa/CdUEB3WhjwxzV9Ote8UItSJgaINbKOZVSZhyrTaOGKXon3NxH7Gu6pbwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743314060; c=relaxed/simple;
	bh=f/AenSlhfMnCT25RFDW+6en6R4m+nQS9Aw3y5vxVcBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLv78ouMfPjlR+hTULpfOksAxq8++ktq0e2pziL/UTSZQfOl9uGrGe89G78pK0+kPCAfA4dLOSsoa6VdI1vMkZ2zeAjLdgrn/Lu3OI10yv4PdTpj4NMYJ3wAYiM0G56ADCYi97gcGD2ZHM3BOu7eHtzvLlrIIHZZ4pGHL4cjcV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJ3TzpsC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJ3TzpsC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848F3C4CEDD;
	Sun, 30 Mar 2025 05:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743314058;
	bh=f/AenSlhfMnCT25RFDW+6en6R4m+nQS9Aw3y5vxVcBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DJ3TzpsClhWYy3lqUkINLa1GUFedz31yZydVOXx0xuncx7FHy/h/wL+DoWTBnvc5Q
	 lRv6E4xIjwbzwYMBfwTL6rTsEDN3PsSLl1k7mrWfznDnjOdi5B1WznbrJ4vkRnjSz6
	 ileKLtkHY9cGh8wiKBfb/+qB142UvincelDHJUpSBfi+Jw8LVgezCqUXX1AAQ3AYal
	 cUUNFTdhNZwqoUlPtQvbCV6e5CPoJLdiLdgfSxRaIfcmOPkPmpIKZHiZZ9VJOzUTHK
	 H5VwTF6zPYcnW+xZaTEkuZxPtGMuf7dt0wk/rxQJK5eqg3WZlz58SPJJseuvmyzGjY
	 ftzOcSTJW/0sQ==
Date: Sat, 29 Mar 2025 22:54:17 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 1/3] perf sort: Keep output fields in the same level
Message-ID: <Z-jcifdq7GP2cD4k@z2>
References: <20250307080829.354947-1-namhyung@kernel.org>
 <Z9tjKcKvjYgbR6hb@google.com>
 <Z9vgt1pjiNbDBDbM@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9vgt1pjiNbDBDbM@gmail.com>

On Thu, Mar 20, 2025 at 10:32:39AM +0100, Ingo Molnar wrote:
> 
> * Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > On Fri, Mar 07, 2025 at 12:08:27AM -0800, Namhyung Kim wrote:
> > > This is useful for hierarchy output mode where the first level is
> > > considered as output fields.  We want them in the same level so that it
> > > can show only the remaining groups in the hierarchy.
> > > 
> > > Before:
> > >   $ perf report -s overhead,sample,period,comm,dso -H --stdio
> > >   ...
> > >   #          Overhead  Samples / Period / Command / Shared Object
> > >   # .................  ..........................................
> > >   #
> > >      100.00%           4035
> > >         100.00%           3835883066
> > >            100.00%           perf
> > >                99.37%           perf
> > >                 0.50%           ld-linux-x86-64.so.2
> > >                 0.06%           [unknown]
> > >                 0.04%           libc.so.6
> > >                 0.02%           libLLVM-16.so.1
> > > 
> > > After:
> > >   $ perf report -s overhead,sample,period,comm,dso -H --stdio
> > >   ...
> > >   #    Overhead       Samples        Period  Command / Shared Object
> > >   # .......................................  .......................
> > >   #
> > >      100.00%          4035    3835883066     perf
> > >          99.37%          4005    3811826223     perf
> > >           0.50%            19      19210014     ld-linux-x86-64.so.2
> > >           0.06%             8       2367089     [unknown]
> > >           0.04%             2       1720336     libc.so.6
> > >           0.02%             1        759404     libLLVM-16.so.1
> > > 
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > 
> > Ping!  Anybody interested in this change? :)
> 
> Oh yes, all such pieces of intelligent organization of textual output 
> of profiling data are worth their weight in gold in my book. :-)
> 
>   Acked-by: Ingo Molnar <mingo@kernel.org>
> 
> 1)
> 
> On a related note, does anyone know why perf stat output alignment 
> sucks so much these days:
> 
>   starship:~/tip> perf stat --null --repeat 20 perf stat --null --repeat 3 perf bench sched messaging 2>&1 | grep elapsed
>            0.11620 +- 0.00327 seconds time elapsed  ( +-  2.81% )
>           0.120813 +- 0.000570 seconds time elapsed  ( +-  0.47% )
>           0.122280 +- 0.000443 seconds time elapsed  ( +-  0.36% )
>           0.119813 +- 0.000752 seconds time elapsed  ( +-  0.63% )
>            0.12190 +- 0.00134 seconds time elapsed  ( +-  1.10% )
>           0.119862 +- 0.000542 seconds time elapsed  ( +-  0.45% )
>           0.120075 +- 0.000608 seconds time elapsed  ( +-  0.51% )
>           0.120350 +- 0.000273 seconds time elapsed  ( +-  0.23% )
>            0.12203 +- 0.00114 seconds time elapsed  ( +-  0.93% )
>            0.12229 +- 0.00114 seconds time elapsed  ( +-  0.93% )
>            0.12032 +- 0.00115 seconds time elapsed  ( +-  0.95% )
>           0.121241 +- 0.000463 seconds time elapsed  ( +-  0.38% )
>           0.119404 +- 0.000333 seconds time elapsed  ( +-  0.28% )
>           0.119945 +- 0.000766 seconds time elapsed  ( +-  0.64% )
>           0.121215 +- 0.000879 seconds time elapsed  ( +-  0.72% )
>            0.12001 +- 0.00109 seconds time elapsed  ( +-  0.91% )
>            0.12193 +- 0.00182 seconds time elapsed  ( +-  1.49% )
>           0.119184 +- 0.000794 seconds time elapsed  ( +-  0.67% )
>           0.120062 +- 0.000439 seconds time elapsed  ( +-  0.37% )
>           0.120834 +- 0.000760 seconds time elapsed  ( +-  0.63% )
>           0.369473 +- 0.000992 seconds time elapsed  ( +-  0.27% )
> 
> ... see how the vertical alignment of the output goes randomly wacko - 
> I presume because there's a trailing zero in the output number and the 
> code for some inexplicable reason decides to shorten it to make the 
> life of developers harder? ;-)

I found this commit. :)  I think it didn't consider nested perf stat
with --repeat options.

commit bc22de9bcdb2249150fb5b3c48fdc4f6bedd3ad7
Author: Jiri Olsa <jolsa@kernel.org>
Date:   Mon Apr 23 11:08:20 2018 +0200

    perf stat: Display time in precision based on std deviation
    
    Ingo suggested to display elapsed time for multirun workload (perf stat
    -e) with precision based on the precision of the standard deviation.
    
    In his own words:
    
      > This output is a slightly bit misleading:
    
      >  Performance counter stats for 'make -j128' (10 runs):
      >      27.988995256 seconds time elapsed                  ( +-  0.39% )
    
      > The 9 significant digits in the result, while only 1 is valid, suggests accuracy
      > where none exists.
    
      > It would be better if 'perf stat' would display elapsed time with a precision
      > adjusted to stddev, it should display at most 2 more significant digits than
      > the stddev inaccuracy.
    
      > I.e. in the above case 0.39% is 0.109, so we only have accuracy for 1 digit, and
      > so we should only display 3:
    
      >        27.988 seconds time elapsed                       ( +-  0.39% )
    
    Plus a suggestion about the output, which is small enough and connected
    with the above change that I merged both changes together.
    
      > Small output style nit - I think it would be nice if with --repeat the stddev was
      > also displayed in absolute values, besides percentage:
      >
      >       27.988 +- 0.109 seconds time elapsed   ( +- 0.39% )
    
    The output is now:
    
       Performance counter stats for './perf bench sched pipe' (5 runs):
       SNIP
               13.3667 +- 0.0256 seconds time elapsed  ( +-  0.19% )
    
    Suggested-by: Ingo Molnar <mingo@kernel.org>
    Signed-off-by: Jiri Olsa <jolsa@kernel.org>
    Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Andi Kleen <ak@linux.intel.com>
    Cc: David Ahern <dsahern@gmail.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Link: http://lkml.kernel.org/r/20180423090823.32309-7-jolsa@kernel.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

> 
> 2)
> 
> It's also incredibly hard to Ctrl-C a 'perf stat --repeat' instance:
> 
>  starship:~/tip> perf stat --null --repeat 20 perf stat --null --repeat 3 perf bench sched messaging
>  # Running 'sched/messaging' benchmark:
>  # 20 sender and receiver processes per group
>  # 10 groups == 400 processes run
> 
>  ...
>  Ctrl-C
> 
>  # Running 'sched/messaging' benchmark:
>  perf: pollperf: perf: pollperf: pollpollperf: pollperf: pollperf: : Interrupted system call
>  : Interrupted system call
>  poll: Interrupted system call
>  perf: pollperf: : Interrupted system call
>  perf: pollperf: pollpollperf: : Interrupted system call
>  pollperf: pollperf: perf: perf: pollpollpollperf: : Interrupted system call
>  pollperf: poll: Interrupted system call
>  : Interrupted system call
>  : Interrupted system call
>  : Interrupted system call
>  perf: poll: Interrupted system call
>  perf: perf: pollpoll: Interrupted system call
>  : Interrupted system call
>  perf: perf: perf: perf: perf: perf: : Interrupted system call
>  pollpollpollpollpollpoll: Interrupted system call
>  : Interrupted system call
>  : Interrupted system call
>  perf: perf: pollperf: perf: perf: perf: perf: perf: pollperf: : Interrupted system call
>  pollpollpoll: Interrupted system call
> 
> Note how the perf stat instance actually *hangs*. I have to Ctrl-Z it, 
> and kill -9 %1 it the hard way to clean up:

It looks like the problem is in the perf bench sched messaging not in
perf stat.  If the signal delivered before all groups are created, it
may wait for children indefinitely.

Thanks,
Namhyung

> 
>  pollpollpoll: Interrupted system call
>  �
>  [1]+  Stopped                 perf stat --null --repeat 20 perf stat --null --repeat 3 perf bench sched messaging
>  starship:~/tip> kill -9 %1
> 
>  [1]+  Stopped                 perf stat --null --repeat 20 perf stat --null --repeat 3 perf bench sched messaging
>  starship:~/tip> kill -9 %1
> 
> Does anyone use this thing for actual benchmarking work? ;-)
