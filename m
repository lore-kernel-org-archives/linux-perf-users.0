Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD5315E5D2;
	Mon,  1 Jul 2024 13:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719840450; cv=none; b=KOMIqxKzipZ/3oAEBoQi8Ji3oXYgCGG4DTmI+hDGl1SPH0r7LAbg+q+QDM/clHGJfpfjw/SnDeC1pJMr12YW8t0Cm7uedP0PTn8M/epNJkcMkHJkuzG/IdKAu5Xpqc9Zb7Szj827+l0YHj7kSq9PpScxFlt6WbjsuVF6+2EDKuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719840450; c=relaxed/simple;
	bh=XFseOVSjpwnaT1ZVAH2sByCNDyn2H2MigdIsn0urecw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZlbq0n0KLPGa9Eo7rjuQzPp/RvBF1K7+zqwWGC2l/kXBE0gi7q3CFuOQcMVPK/odpx7JMpWqcLVHSi8bCkwtVOkLOms/P7xy27gvT73iEYGUFaX+x63TQTKVOEF0OSEGRybQ3vVjWgcGfV4cDn7LHRwtaGObVAxgwMVWr3zIYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QuBfoSgI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cFbegVUV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QuBfoSgI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cFbegVUV"
Date: Mon, 1 Jul 2024 15:27:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719840447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G5XhOnJAUUZRe8BHp4cEmQJvWpVeKRgpNdY1SzN+EFM=;
	b=QuBfoSgIj4C/P54oaLhZum9IL8/k6IseZj7jIO2NtyQWn0rZ1X5QFwfz1W3823hdMESq8x
	jxF/bWuifhzy7bzPTo306orujH/4jPkrVtaIbDsRwVUz4bzYt3ElaAGcKMQyndeHjB1zIs
	smmp84tG9mGY8lt2am4Pe9mrvrO6BpwZ5Lqy+hsuXoXwaojHl3N8HnzLqqQw/RcigXKOu+
	OLTRjBvjtnBOL9h8wlQQSDG/y+loTANapAIICQg+f0Bx1B6LjQ0CN/LvcNagwkRkjVIrlR
	Z5dgru2ztvcUd319i4eZZ4JVSQ20pSbpWh2XLfiQ8UQlLZmY+CDSwceCuWYpLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719840447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G5XhOnJAUUZRe8BHp4cEmQJvWpVeKRgpNdY1SzN+EFM=;
	b=cFbegVUVkKcCA0U80m0dl1nv2AXp2k1orDr7uuBrIHTzKcMTrrPOksPq7KQyA+69GnV/Z5
	aBitI/W+YwTD+pAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
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
	Thomas Gleixner <tglx@linutronix.de>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v4 2/6] perf: Enqueue SIGTRAP always via task_work.
Message-ID: <20240701132725.9_UHcpVA@linutronix.de>
References: <20240624152732.1231678-1-bigeasy@linutronix.de>
 <20240624152732.1231678-3-bigeasy@linutronix.de>
 <20240701122829.GE20127@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240701122829.GE20127@noisy.programming.kicks-ass.net>

On 2024-07-01 14:28:29 [+0200], Peter Zijlstra wrote:
> On Mon, Jun 24, 2024 at 05:15:15PM +0200, Sebastian Andrzej Siewior wrote:
> > @@ -9735,18 +9719,28 @@ static int __perf_event_overflow(struct perf_event *event,
> >  
> >  		if (regs)
> >  			pending_id = hash32_ptr((void *)instruction_pointer(regs)) ?: 1;
> > -		if (!event->pending_sigtrap) {
> > -			event->pending_sigtrap = pending_id;
> > +
> > +		if (!event->pending_work &&
> > +		    !task_work_add(current, &event->pending_task, TWA_RESUME)) {
> > +			event->pending_work = pending_id;
> >  			local_inc(&event->ctx->nr_pending);
> 
> task_work_add() isn't NMI safe, at the very least the
> kasan_record_aux_stack() thing needs to go. But the whole
> set_notify_resume() thing also needs an audit.

oh. I just peeked and set_notify_resume() wouldn't survive the audit.
Would you mind adding task_work_add_nmi() which is task_work_add(,
TWA_NONE) without kasan_record_aux_stack()? The signal part would need
to be moved the irq_work() below in the NMI case.

Sebastian
