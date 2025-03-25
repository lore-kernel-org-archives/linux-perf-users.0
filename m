Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999F9A93D;
	Tue, 25 Mar 2025 00:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742862421; cv=none; b=MK/J1/g78NzXX7RI2zKudj/NvbtZFG/NkTKnRF4LM9UIqbMQTToFIMAKzJIFBhjl3hWy1RxC1PVUbCCbPXxIZNDwlAgxtVGUBZJAk1Y6y781d0wts/O460F93lyNwI5BaC2wi/Mt8CnHPBM/9Af1QLNA1gnENkZg+AvD/OXA5dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742862421; c=relaxed/simple;
	bh=gfq/3olj6WjXH89Yk7qnmiUkNX67f+uKPVncDNpWtq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlDmSxg19rjJ+7UfPWomdTbep67U4DskdJOHEAZ/tBCkBbOOZRsIqaBkk4bOQMXkd9No2WzmM6aQsSkYTmLDoYhvAU0OSCeTsM5HrnnbQEvFDvG5rb9ThGYrpiMHEx86EgZXSYwf8geaoG2J8JlsCXqbBbphPZS5Ehxx+o9ZqI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9oGh/01; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9oGh/01"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71DAC4CEDD;
	Tue, 25 Mar 2025 00:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742862421;
	bh=gfq/3olj6WjXH89Yk7qnmiUkNX67f+uKPVncDNpWtq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U9oGh/016nIqxt8qUDgE8McgrbraW1kHFqbU9U5kofxqiERKVd97WFYd3XUEDDxoP
	 3lMiJuuXQiXqKD00bq25Q0WR/qsZIN3HhT8iS8V0UxE1uJjR0z8SEAUqm/SfkIGu/A
	 qQKlUvgVZ0EmIun5vwJVha0zQx2Bk+7o2RAAXnChByZjBRn2ooq9tA/6/07xFuinni
	 C+Lke8HVl28NMo75Uca/Cun70iRyzteHTyFOZLG88/HUtCx24ZLkHrU8i+rkTVHrJA
	 8Sm8jztU40J59kue5tDu7Sv9XjC13XmwQRQYD+GSGTSDrs+gkO/UObYxqqcyekCtun
	 ous5ljlv/Wrow==
Date: Mon, 24 Mar 2025 17:26:59 -0700
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
Message-ID: <Z-H4U64qe17b4jrq@google.com>
References: <20250307080829.354947-1-namhyung@kernel.org>
 <Z9tjKcKvjYgbR6hb@google.com>
 <Z9vgt1pjiNbDBDbM@gmail.com>
 <Z9w_aFlzOkoCTSqK@google.com>
 <Z-EJnye74la1triY@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z-EJnye74la1triY@gmail.com>

On Mon, Mar 24, 2025 at 08:28:31AM +0100, Ingo Molnar wrote:
> 
> * Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > > 3)
> > > 
> > > It would also be nice to be able to Ctrl-C out of a 'perf top' instance 
> > > that freezes the output or so. Or prints a snapshot in ASCII. Anything 
> > > but what it does currently: it just exits and clears the xterm screen 
> > > of all useful information...
> > > 
> > > I have to use 'f' (how many people know about that feature?) and copy & 
> > > paste anything interesting from the screen the hard way.
> > 
> > Actually I was not aware of 'f' key. :)  I think you can use 'P' to save
> > the current screen to a file.
> 
> And I was not aware of the 'P' key. :-)
> 
> Would be nice if it also printed column and meta information, i.e. if 
> it included these lines:
> 
>   Samples: 1M of event 'cycles:P', 4000 Hz, Event count (approx.): 758731362801 lost: 0/0 drop: 0/0
>   Overhead  Shared Object            Symbol
> 
> or so?

Yep, maybe we can do the same as the stdio output.

  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 7  of event 'cycles'
  # Event count (approx.): 3641468
  #
  # Overhead  Command  Shared Object     Symbol                            
  # ........  .......  ................  ..................................
  #

> 
> BTW., the approximate 'event count' is a pretty uninformative value 
> these days, right? Might as well not clutter the screen with it.

Maybe.  I don't look at the number so far but also don't feel the need
for removal.

Thanks,
Namhyung

