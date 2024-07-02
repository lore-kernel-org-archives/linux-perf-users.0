Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6E21A28B;
	Tue,  2 Jul 2024 09:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719910903; cv=none; b=WrpQoD8wdjXw0QdYijSB6zLy0ZQoCGtHg17ZFpo1bjSKX/P7EfBWpSuTvsqgfnI+fO06qBgYMSa6c2EUMI3U7yFc+gB8AY7852oHredDUs8b0/Gfq58BLrUXNLdlv+f+W4U8kZqQ2MJck78AzPRKiyxI5BTYTP33S7v7I1YdkTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719910903; c=relaxed/simple;
	bh=JSvBpoYTMU+BnklFQK4qQ9ZlPZrU+1AECF8SBZG5CkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+bhtSExSYnaW5Z3yICegD7AcD647wD1FmLV3QCt3CfjZvutsVY6w3anh+9RFGrXp1rMKoUQ0IQCbTN2wYTbTtUqorQ92vOsPH1+alsTl72IUJa55ybSRpDTNFG2Kjv+7OrexVE2VekJsDc+s70WIQWITA8hYevzFPkCHdCRxUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b41FRqXG; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b41FRqXG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VrVt3xdD2w85qiUsMcXszCZyj61d8nrVJq/I9tFIzgs=; b=b41FRqXGHRQyboVjKKMISFbMXJ
	zbeT5rUBoioDliviR1eksFT0fa7hAs0CnblRfJwQE04E3Q0aaKo2w27xr/Otghx0ZUUtkRfoqnrJu
	lRxCiaDg3WJE3RUMrUxz3aGb8eZc0GmqM5L6C4gvHTIf6/pVJv+b9ebeooBCfpitTMgvadu4q0y2S
	TmdNndgRDXm6KHVwLOr9JAUW/iXCY5f0uHmaHahDNk9ZI9R2IzGkqXENDEKtzRSN7NZT9lXIZzKuz
	z9ikTI/Th7FgqSkKDetmIyFkDSjV4Gz/m7PTj3WxLhc0+FdqMZhNS6JXlHkl5XLLxKkhsJ2Lu4Lyd
	2eqJkNeg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOZOD-00000009nE7-0QqI;
	Tue, 02 Jul 2024 09:01:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A9E09300694; Tue,  2 Jul 2024 11:01:28 +0200 (CEST)
Date: Tue, 2 Jul 2024 11:01:28 +0200
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
	Thomas Gleixner <tglx@linutronix.de>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v4 2/6] perf: Enqueue SIGTRAP always via task_work.
Message-ID: <20240702090128.GC11386@noisy.programming.kicks-ass.net>
References: <20240624152732.1231678-1-bigeasy@linutronix.de>
 <20240624152732.1231678-3-bigeasy@linutronix.de>
 <20240701122829.GE20127@noisy.programming.kicks-ass.net>
 <20240701132725.9_UHcpVA@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701132725.9_UHcpVA@linutronix.de>

On Mon, Jul 01, 2024 at 03:27:25PM +0200, Sebastian Andrzej Siewior wrote:
> On 2024-07-01 14:28:29 [+0200], Peter Zijlstra wrote:
> > On Mon, Jun 24, 2024 at 05:15:15PM +0200, Sebastian Andrzej Siewior wrote:
> > > @@ -9735,18 +9719,28 @@ static int __perf_event_overflow(struct perf_event *event,
> > >  
> > >  		if (regs)
> > >  			pending_id = hash32_ptr((void *)instruction_pointer(regs)) ?: 1;
> > > -		if (!event->pending_sigtrap) {
> > > -			event->pending_sigtrap = pending_id;
> > > +
> > > +		if (!event->pending_work &&
> > > +		    !task_work_add(current, &event->pending_task, TWA_RESUME)) {
> > > +			event->pending_work = pending_id;
> > >  			local_inc(&event->ctx->nr_pending);
> > 
> > task_work_add() isn't NMI safe, at the very least the
> > kasan_record_aux_stack() thing needs to go. But the whole
> > set_notify_resume() thing also needs an audit.
> 
> oh. I just peeked and set_notify_resume() wouldn't survive the audit.
> Would you mind adding task_work_add_nmi() which is task_work_add(,
> TWA_NONE) without kasan_record_aux_stack()? The signal part would need
> to be moved the irq_work() below in the NMI case.

Perhaps add TWA_NMI_CURRENT or somesuch. That would be descriptive and
the value can be used to elide the call to kasan*() and possibly also
include that self-IPI for the NMI-from-user case where we don't have a
return-to-user path.

It can also verify task == current, which ensures people don't try and
use it for other things.
