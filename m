Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5468C1EB2A;
	Mon,  1 Jul 2024 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719839449; cv=none; b=WNagWfPH1sHgNC51b13+OpD78oAr/CVm84k2hkw0HdsFJGJpj26wE9mjZNjD/ZCd8fVh6ZrYD4o6ddGnf4sD21ptnS0YG3DWxZpV4s89evUiuyr9VnS4irV2Q8SxbQGkalmQv/bDf1VJam1j9aDnXStHrZaHLtgFg7Afkz1ICzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719839449; c=relaxed/simple;
	bh=UnvrbNHA9qVkLQXl9c1oLB+e16vBOEbjWXuOIvHqrLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiX0iGuwQFtIoZjrL4jhgGxG6mET/JHPCTLjsa69i/caBf4H+ddVxkZBmr+xAQAzNS1aF+ShVQDTXP5w8SlJrEQylf7J/XZpRLzD05yYjXxu7jvx3K7aMNHGT5tgyGVAjUJUxVBGTbFd/34E8ryqMbJD/nt/HbmocWMOuUkfA+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HVvxQPmi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HVvxQPmi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=E5JjfaIv1KrikLtSEFbxIeS9392fEMU5QGlYFRiD4U4=; b=HVvxQPmi9YosMd7pFA5nExXVwb
	h7HV9srr8+hl97rUB59YADSSDCckXMBYx9bC0XeKCBOO7jf4NnBxWKE4zSZtaXPrEfUvLG440bsxo
	jdRcl28PfuSvVRX15dAGJtrV4yVtu92hCbaY0UzLxV238zaT5JLwgZvvJsd+J11G9wNNKvCoeZCoP
	oxfQxK3l2ESO6lzuUC5c1RKOoTs+QDq8A4oOa6AaRBNkxoJekMc3HIWXO7tioq+TcgMSyb6g+iN4G
	rz6/+fXyOmAV+WCm5Y25D4f2S/3CRV4QlHPNwH4jtT1VBpWlv9VXzUHcyYNp1p9B+/ifR5nGBuZuZ
	EnVS2exw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOGnp-0000000HMAS-02eL;
	Mon, 01 Jul 2024 13:10:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A0687300694; Mon,  1 Jul 2024 15:10:40 +0200 (CEST)
Date: Mon, 1 Jul 2024 15:10:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 3/6] perf: Shrink the size of the recursion counter.
Message-ID: <20240701131040.GJ20127@noisy.programming.kicks-ass.net>
References: <20240624152732.1231678-1-bigeasy@linutronix.de>
 <20240624152732.1231678-4-bigeasy@linutronix.de>
 <20240701123137.GF20127@noisy.programming.kicks-ass.net>
 <20240701125643.kqJWwrhW@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701125643.kqJWwrhW@linutronix.de>

On Mon, Jul 01, 2024 at 02:56:43PM +0200, Sebastian Andrzej Siewior wrote:
> On 2024-07-01 14:31:37 [+0200], Peter Zijlstra wrote:
> > On Mon, Jun 24, 2024 at 05:15:16PM +0200, Sebastian Andrzej Siewior wrote:
> > > There are four recursion counter, one for each context. The type of the
> > > counter is `int' but the counter is used as `bool' since it is only
> > > incremented if zero.
> > > 
> > > Reduce the type of the recursion counter to an unsigned char, keep the
> > > increment/ decrement operation.
> > 
> > Does this actually matter? Aren't u8 memops encoded by longer
> > instructions etc..
> 
> The goal here isn't to reduce the opcodes but to add it to task_struct
> without making it larger by filling a hole.

Changelog failed to mention this crucial fact.
