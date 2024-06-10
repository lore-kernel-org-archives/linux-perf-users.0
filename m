Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEA72E620;
	Mon, 10 Jun 2024 19:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718046138; cv=none; b=mb0zUikBtsWAoR+R/tyld4hu5FR1s34E5deyLKrjfOpOKqC4uvErl1FgNZfdjd05k8f2AlMjiTxshKAEFLS+ZEFb/HIq3ocvKNuZ+MaTIRo7vNel93xdigMZEzcrUOnrRA2lfH2mUu0vjznZCog85vXjeRCgrBPxCfVkMm1BRGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718046138; c=relaxed/simple;
	bh=HIxZJDBw8lvC6AgonODjlRnJnG+poyxOoaYJhz1KzqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O90EwdyMub7L1HGCLW3PxYHEY+evx/FDc3Aa1FOAW2qNglOKkjyPjjxAkv0+NBMQbw6FOpc3gnjlSSkGm60wp14ikTd+QU1ZH8aSVGMBUMcJnel3F4nbsRoOjXrE9awI+mcBokDKsm14GpYNNS0TuHxDLy92v9GJLa/BomKTE4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KBx0Ic5e; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KBx0Ic5e"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=s7Gyb9953r9ixu7af9wBM8hywUzKBl8Kmb/xfyNTRSg=; b=KBx0Ic5eGRnV/iKzQO1aiPoOB2
	BVinSNWUG8COIh+VgcALGirLNWYTUUJ4SBSUSgbdnL7X9BNTRmt2tIjFFiLAjHViVYHY866EjogIr
	fucVRg1upRTcTHZAkCXEtviW3XaPQR1Wu0cdtQOM4dRNv8fPSBZ3PxsDOieH4/YUigloV+reuxXP6
	bFisFazK7KSbFczNQkeI/c1Q0eCQp3OoKWrN3enEcVmTTozm5wWFeFSOEI/MgFzPtHHgO2jfMUOxQ
	ywgOf0A9/7Fs3VAGr/P2EvcM2Og8F24rtaK3plNMMun2YyWhRI36qLSl7Zj/iN0sbmt94e33KtB4E
	ArWrRwTQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGkGa-00000001cAp-2O4d;
	Mon, 10 Jun 2024 19:01:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1B245300439; Mon, 10 Jun 2024 21:01:19 +0200 (CEST)
Date: Mon, 10 Jun 2024 21:01:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ben Gainey <Ben.Gainey@arm.com>
Cc: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	Mark Rutland <Mark.Rutland@arm.com>,
	"acme@kernel.org" <acme@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	James Clark <James.Clark@arm.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"namhyung@kernel.org" <namhyung@kernel.org>,
	"irogers@google.com" <irogers@google.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/4] perf: Support PERF_SAMPLE_READ with inherit
Message-ID: <20240610190118.GV8774@noisy.programming.kicks-ass.net>
References: <20240606144059.365633-1-ben.gainey@arm.com>
 <20240606144059.365633-2-ben.gainey@arm.com>
 <20240607093254.GN8774@noisy.programming.kicks-ass.net>
 <451afb8eb03f1519c482a84a6c1cbd1e62222988.camel@arm.com>
 <20240607110214.GQ8774@noisy.programming.kicks-ass.net>
 <60ed550e8cb5e5aa4004fb2d3857a605ba1da23e.camel@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60ed550e8cb5e5aa4004fb2d3857a605ba1da23e.camel@arm.com>

On Fri, Jun 07, 2024 at 02:04:49PM +0000, Ben Gainey wrote:

> > IIRC they all originate in a single location around
> > perf_output_read(),
> > that already has the event and could easily 'correct' the semantic
> > meaning by doing the above once or so.
> > 
> 
> As far as I can tell, you can mix events in a group with inconsistent
> values of PERF_SAMPLE_READ which means that doing it at the top level
> introduces an inconsistency/confusing behaviour since it makes the
> "thread-local-ness" of the read_format values a property of the event
> that caused the sample, rather than of the specific event to which the
> value belongs. The current implementation makes it a property of the
> specific event not the sample event. Specifically, when
> perf_output_read_group reads a child event that does not have
> PERF_SAMPLE_READ, the sample event must have PERF_SAMPLE_READ, meaning
> the child event will give the thread-local value even though it was not
> created as inherit+PERF_SAMPLE_READ
> 
> I can either:
> 
>  * Keep it so that the perf_output_read_group uses per-event value for
> self

Having the lot be inconsistent seems bad.

>  * Rework the deliver_sample_value in session.c to base its decision on
> the sample event rather than the specific event

The code as it exists seems to use the read_format from the event that
actually triggers the sample -- which makes sense. I would expect this
new thing to follow that.

Mixing inherit between events in a group gets you crap, but that's what
you asked for I suppose :-) But otherwise let the sampling event set the
format.

>  * Forbid inconsistent PERF_SAMPLE_READ for events in a group

Not possible I think, you can have non-sampling events in a group.
