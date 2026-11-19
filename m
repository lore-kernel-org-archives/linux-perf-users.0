Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795080002;
	b=kwz6DQdHbibxAkNLMRCkn60cklUtCau0NShuOjESr9PrylWDxb+pjxZFSzLd+yf5ymjd
	 bRSjSN0AzlxqckUstkxNCEGwTsDOANSA94ax4H5NEclyx34LqUKQZd4AumOPQHx896L5u
	 afwhqMp3KKvymqGi97CV9gEE6R4LPCqRiS6iFiNV8gIHpnBB8vPgZDCeJVhJ5b4M3awXL
	 QNsbXHimdgUi2ApOEurt+QZEyzzSY3fpr9Nz9lsO119inmN5Iru7JZp/lKBt2iGDPSS/E
	 t9lfQbL8gl1bLgGfgANK6vTTgJRjhll6RF48ANZR4qq7TeHJAlPRQH1JVR8uwfRKKuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795080002;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=92SCv6E05mY9m+J+ZgiCJ1m1WUCj4u+zBtG/e2wkxTA=;
	b=1uU8d/5yu3Hv6cXKSpf2C1y+pRaeKHPM349UkIq239N6f865dubKfeE7H1f3dsX/bhAW
	 VpL4tbOhsm2dfL6XKWDPMFO4B1jCz3ooNeDLDqACGbbCzcrke/TUzDEIVJ8MDGwlWyWpX
	 b/t7X640yNyu2gKWt3APHC0ipJQq7VT0nSnPqwXdY1+d4brNjH9mtKGKZUWjMwB53E/rz
	 n5capOhWAUciNjwKNBr6csLYhDLfYVVLZ9eG8em2oByThoOTGw/afrdGawr6mZ3qXhrf+
	 C8rGXXUpyaZyCxWiLT9r8hhZ9RbGm+aBP1tFDxq/WeiC49wPxY88/f38CuHRc9JPkHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=N5jamnPP;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E428A606A33B;
	Thu, 19 Nov 2026 09:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E428A606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=N5jamnPP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=92SCv6E05mY9m+J+ZgiCJ1m1WUCj4u+zBtG/e2wkxTA=; b=N5jamnPP/DSJzvrKZbo8gy+UW2
	SYft1vmQqkBEzJhyHypbc2T5OWbsUxvz2K3M+AVFPcwNj1BUelonPPtRLz1e3L3h5YKjNB0/591TS
	OXwqRkZI8bJeTqPA55pQ5GA16YCeIKDPeMkZk2DUSD3oUxbP6dKA9G7LKiUvUhbTOg639n5CWMOaz
	ggdgd9doAzfOSN7vCMt5hvt3xxstb19yTtg1D+rO1AmdDynF+jAMcnAC+DNGYbLiIgFsO3dx54mPZ
	8ibbCJ1e1FXrg+vHbD9iwL0aCucvas7+TPzBl105dFqfTuqw+sxuxQkXafZewpYQ375xLZeGgdrJI
	R9UZ/81A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTyIx-00000004q86-0TM5;
	Thu, 19 Nov 2026 09:19:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 35FA630072F; Thu, 19 Nov 2026 10:19:42 +0100 (CET)
Date: Thu, 19 Nov 2026 10:19:42 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Aditya Chillara <aditya.chillara@oss.qualcomm.com>
Cc: Daniel Wade <danjwade95@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Kyle Zeng <kylebot@openai.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf: Reject group leaders detached by CPU hot-unplug
Message-ID: <20261119091942.GP2668804@noisy.programming.kicks-ass.net>
References: <20261119014730.2074-1-danjwade95@gmail.com>
 <06758809-6748-4f7b-b7e6-c862936a961c@oss.qualcomm.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06758809-6748-4f7b-b7e6-c862936a961c@oss.qualcomm.com>

On Thu, Nov 19, 2026 at 02:24:19PM +0530, Aditya Chillara wrote:

>                           task already asleep in poll()   a fresh poll()
>   before your patch       stays asleep                    no data
>   your patch              stays asleep                    EPOLLHUP
>   your patch + wakeup     woken, sees EPOLLHUP            EPOLLHUP
> 
> perf_event_exit_event() kicks perf_poll() with perf_event_wakeup() after
> moving events to EXIT, but this path doesn't, so a task already sleeping
> in poll() is not woken and only sees EPOLLHUP when its timeout runs out.
> 
> Deferring the wakeup to the event's irq_work, as merge_sched_in() does,
> seems enough. Something like this, on top of your patch:
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index c1f3e1f013ec..885b6594139a 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -15350,6 +15350,9 @@ static void __perf_event_exit_context(void *__info)
>  	list_for_each_entry(event, &ctx->event_list, event_entry) {
>  		__perf_remove_from_context(event, cpuctx, ctx,
>  					   (void *)(DETACH_EXIT | DETACH_GROUP));
> +		/* Kick perf_poll() for is_event_hup(). */
> +		event->pending_wakeup = 1;
> +		irq_work_queue(&event->pending_irq);
>  	}
>  	raw_spin_unlock(&ctx->lock);
>  }

Yeah, I suppose that makes sense.
