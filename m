Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795613771;
	b=x9vthkKQz9d/rrHYtwPBRKNI5+nDB7xQenD574Nc1lGkoAKQZ6e91OQFiurOrSHlgDJf
	 GIf8tW+8I/9BOeh8VUqzYYVzXt6dStEU3mJD0V7EJuQA1W1bg+1qCOosVA56nMoJ4QEg/
	 rkvASoepu6yIwgbUKDhK1O54DQVXQulcWOTJ4eB5Z8nl65J70MoqeAjDqWaAYzhgDHsiR
	 EmbQK0yV4XHCHQ3osNlMY56KaZiAM9PMq4MAfI590rbe324Vjf7d4HfjJHt8hc+pLhc0P
	 ClswnwO8MwWlaze5p+GFmFn1A7e8unNqo3eRsP/v92qedvB5+EeAr8DVT3yExAjpyog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795613771;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=xac7Xda8XST5oGr3eniqmlSUIz3iXQAqkq1h1P5Fu6Y=;
	b=mq08TmurInFzE4g9rReik7tF+XNBpLDiIHFEN4atw5sapyGuIsp7oKYMvt3UPHrwMyeB
	 aoWGJeNSbxHrXqCHWksi5jd68LW5ykV+lqhPGu2WrQNLK3B8Hp0DQsMj1PKKTn66YCjL4
	 tZiCNbnSc29LYRAuKjNowKwPts1pXoVRAlxiDvvB6QvxyfxbD5MVV2Rwb8PVYYgfgiRj0
	 KXZYMC21HAravvgugqIZMiKgozfwz3N4Oj0pjOSvLybFPfJJtAo/HJbYtJGYRtQjwFyVD
	 pkOI+4NsVWTgGZ7e48AZcrrsO3b+Bnsxirw0vNSB2wkVu4cUH+DqzVNoW6LEeJ4qkOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=nPWiAqHY;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E53606A33F;
	Wed, 25 Nov 2026 13:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19E53606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=nPWiAqHY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xac7Xda8XST5oGr3eniqmlSUIz3iXQAqkq1h1P5Fu6Y=; b=nPWiAqHYIaVGw8TmvvOdDm/fN5
	BXduJIxSo6y+zaUBZCLWhSbSN1mwsaTAfP7EnEryAHuMZCAiWZachgIQqRGhuWiWkQuF9suqZ5a8Y
	ktx948yOKg263LapQxmH05ue9S8hyj6HklFTqb88lvXatfEdEjix2EzuKR2OzzOulcgpHvgTvoMeH
	uHO0FbT0puAxdygLWfDuo3tkXjGffjJ/88OcTmpWf31JTJ1f6odlsTjKGgEmxMRngf97iCf6PxNuI
	GAZU+qsNoEOcPQVyf9FNBjGrkoXRnHQOm06psJv47OxAVzZmqScIg6RLwADsqckxtD9E++kHjErHR
	8hDrk3Mw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWDAI-0000000EpCf-1Ukb;
	Wed, 25 Nov 2026 13:36:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DCE6F302431; Wed, 25 Nov 2026 14:36:01 +0100 (CET)
Date: Wed, 25 Nov 2026 14:36:01 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] perf/core: Disable context fast-swap for sigtrap
 events
Message-ID: <20261125133601.GC2668804@noisy.programming.kicks-ass.net>
References: <55b1a2845b0ad34a874a7653644e34af9eb068d3.1795053619.git.wutengda@huaweicloud.com>
 <20261120173706.GC2668564@noisy.programming.kicks-ass.net>
 <20261120174606.GM2669272@noisy.programming.kicks-ass.net>
 <5507e48c-4e98-4e76-8d3f-4630a2655085@huaweicloud.com>
 <c9ff579b-a7eb-481f-bb8d-489a4469c397@huaweicloud.com>
 <20261125090809.GW2668804@noisy.programming.kicks-ass.net>
 <4d17dd3b-df73-45c0-8113-f4ca259d549b@huaweicloud.com>
 <20261125093836.GX2668804@noisy.programming.kicks-ass.net>
 <c9c2c4df-a748-4787-b686-1fe6bc6564db@huaweicloud.com>
 <6493eae2-9b36-4574-83ca-a139f4fbfb25@huaweicloud.com>
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
In-Reply-To: <6493eae2-9b36-4574-83ca-a139f4fbfb25@huaweicloud.com>

On Wed, Nov 25, 2026 at 06:09:04PM +0800, Tengda Wu wrote:

> >> Ah, I'm currently running it on an SPR Xeon; do I need to use
> >> non-default arguments or just run the thing in a loop and drink tea
> >> until it goes pop?
> > 
> > No need to pass any other arguments; running it as follows should be enough:
> > 
> >   for i {1..100}; do ./fast_swap ; done
> > 
> 
> Correction: for i in {1..100}

I used: while :; do ./perf-sigtrap-switch-poc; done

> One more detail: I also specified a boot parameter (which might make it
> easier to reproduce?):
>   
>   preempt=none

That option is no longer available.

Anyway, I've had it running for a few hours now; but no joy :-( -- this
is an unmodified tip/master kernel since I wanted to make sure I could
reproduce before trying to fix.

I'll just leave it running ...
