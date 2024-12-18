Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A99136671;
	Wed, 18 Dec 2024 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734518585; cv=none; b=JRhY9pLSgYF2zWMnOZI2jeclqc5QHHJcQELKecsC4dRcn2hBWBrmOR3nErYpWmU6jZcEr+U3VdvU2MrjRJxkg6/zQy328JuevCerDO4PlE/E+4DCIX3DFfcx1hJ/BlvPR+Nbddu21baUHcy60rwNWCnwpeTN9ME8RiJXnqy+6eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734518585; c=relaxed/simple;
	bh=trMnjCsu/7ib3eLW8ZvoZxeuuoNBsq8wXpmWWX1+02o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwxtolUbCclVCOu24Wbiw14VVWjAmad9h0ynq8I36plJpBq4nlEF8mvd/mnrr56L5KYH0W0WrJHKc66gM9mgsIF+gluT0yNE8zyPqDynLtEo36/XxptIpxbBhTVMPUYD6s6fMgV3ARkFXc0ZbzzjGJKDFzAvW+SovSkXifseV6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i0vuTNos; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i0vuTNos"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VGJtUMWRlobdEHWR36/nLrPpWS28B8YJIsm8adf42gE=; b=i0vuTNos3Rf8m84diqgcVEAczh
	sncjVxTgUOQlONiGv/jqrvdZFhoVnCTI4ihP0BnXcv1enXX+ieXcOPenm+s00SrOYcvnvGHtTSl4b
	70O58YkIPckzjCYCbg/WJt/jLSUbkz6aUP0jyJiCJjXsFFrkql4fTXXNqykmXWsjj+2aFtvfeiVqO
	pC50LyR3LBCu22A1Vcv10SsAUTIHcx2ciOiAKPxsW5dAiOJ/7gVv745Bm5VdLqIa9Ht1coZEqcviS
	zkJQCf0ybsCaxCQ+zxWXR3yxDIypAV5VK+AOpoaft+7QAopYMDBJmWbO54jut/CeNhmKw/9Lh3q9S
	ZQC2KGOg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNrW4-0000000AeZ1-2XKH;
	Wed, 18 Dec 2024 10:42:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BC36E3002A0; Wed, 18 Dec 2024 11:42:55 +0100 (CET)
Date: Wed, 18 Dec 2024 11:42:55 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: mingo@redhat.com, acme@kernel.org, amhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, james.clark@linaro.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	nd@arm.com
Subject: Re: [PATCH 1/1] events/core: fix error run/enable ratio display
Message-ID: <20241218104255.GE2484@noisy.programming.kicks-ass.net>
References: <20241218084656.609764-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218084656.609764-1-yeoreum.yun@arm.com>


git log --oneline kernel/events/core.c 

Compare result with your subject.

On Wed, Dec 18, 2024 at 08:46:56AM +0000, Yeoreum Yun wrote:
> when runs below command (with core pmu) sometime perf prints error
> ratio for each perf.
> 
> sudo ./perf stat -vvv -e armv8_pmuv3_0/event=0x08/ -e armv8_pmuv3_1/event=0x08/ -- stress-ng --pthread=2 -t 2s
> ...
> armv8_pmuv3_0/event=0x08/: -1: 1081702126 2289429840 2174835740
> armv8_pmuv3_1/event=0x08/: -1: 794080238 1950025700 847648440
> armv8_pmuv3_0/event=0x08/: 1138698008 2289429840 2174835740
> armv8_pmuv3_1/event=0x08/: 1826791390 1950025700 847648440
> 
>  Performance counter stats for 'stress-ng --pthread=2 -t 2s':
> 
>      1,138,698,008      armv8_pmuv3_0/event=0x08/                                               (94.99%)
>      1,826,791,390      armv8_pmuv3_1/event=0x08/                                               (43.47%)

At this point I've no idea what the error is. You start by saying there
is an error, but then give no clue.

> This happens because of missing total_enable_time of inactivate event.
> it's enabled time doesn't update at the event_sched_out() because state
> isn't PERF_EVENT_STATE_ACTIVE but PERF_EVENT_STATE_INACTIVE.

time tracking doesn't happen at sched calls -- you'll find a grand total
of 0 perf_event_update_time() calls in them.

Also, things like group_sched_out() don't even call into
event_sched_out() when !ACTIVE.

So why is event_sched_out() the right place to change here?

Also, I've still no clue under what condition all this is supposed to
have happened :/

> For example, Suppose there're two events:
>     e0: with pmu0 which supports only cpu0
>     e1: with pmu1 which supports only cpu1.
> then
> 
>                CPU0                  CPU1                     CPU0
>           |  in | out |       | in | out     |       | in      | out (exit)   |
> ------------------------------------------------------------------------------
> ctx->time |  0  | t1  |       | t1 | t1 + t2 |       | t1 + t2 | t1 + t2 + t3 |
> ------------------------------------------------------------------------------
> e0->ena   |  0  | t1  |       | t1 | t1      |       | t1 + t2 | t1 + t2 + t3 |
> ------------------------------------------------------------------------------
> e0->run   |  0  | t1  |       | t1 | t1 + t2 |       | t1 + t2 | t1 + t3      |
> ------------------------------------------------------------------------------
> e1->ena   |  0  | 0   |       | t1 | t1 + t2 |       | t1 + t2 | t1 + t2      |
> ------------------------------------------------------------------------------
> e1->run   |  0  | 0   |       | 0  | t2      |       | t1 + t2 | t2           |
> ------------------------------------------------------------------------------
> 
> at the CPU0, state of e1 is PERF_EVENT_STATE_INACTIVE since it doesn't
> support on CPU0. So when event_sched_out() it failed to update its
> total_enable_time and it makes error print of run/ena ratio.

Sorry, I have no idea what you're saying. I can't relate the table to
the text in any meaningful way.

