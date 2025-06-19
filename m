Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4A0201269;
	Thu, 19 Jun 2025 16:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750351938; cv=none; b=i9wnjr9FBzRA2IHhOTWMpod0Yo+qNKYGLmdmPMB4dNFrKXoTo/8zl0vxCatbfjnUCcbXhU6GwPKzYjYtCXdr2Riur5wUcPZ3PnmzDz/ZfxNRIEiwtjj7lKpWa9sNngNTomtNriQUeoYP2gihyllDr5TEZNCmVKJI/eOYOnwiKtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750351938; c=relaxed/simple;
	bh=d9NTa5SIKGIx9CnHLIBhw8AJ74n2bGM2UGanGlNRRG8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIgds/c61ysNXrTIfcExEdoyFIrz9YgLnHlTjIE56Z42Y9KZWNd6IbMfvlEdfqMKEpU7BgWSvoHxZfmdZKRAHGS4WJ+H5zDGt7GFhTGQoqUV7TmV5N+MyMi6VcLrR1hO+6M4SCdXa545aYJTtUHAsOxJtKdMvx54B1m0xuhTWCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9649C113E;
	Thu, 19 Jun 2025 09:51:55 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14F5D3F58B;
	Thu, 19 Jun 2025 09:52:14 -0700 (PDT)
Date: Thu, 19 Jun 2025 17:52:13 +0100
From: Leo Yan <leo.yan@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Marco Elver <elver@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/aux: Properly launch pending disable flow
Message-ID: <20250619165213.GK794930@e132581.arm.com>
References: <20250522150510.2942814-1-leo.yan@arm.com>
 <20250609125759.GK8020@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609125759.GK8020@e132581.arm.com>

Hi Peter, Ingo,

On Mon, Jun 09, 2025 at 01:57:59PM +0100, Leo Yan wrote:
> On Thu, May 22, 2025 at 04:05:10PM +0100, Leo Yan wrote:
> > If an AUX event overruns, the event core layer intends to disable the
> > event by setting the 'pending_disable' flag. Unfortunately, the event
> > is not actually disabled afterwards.

Do you mind to check if this is a valid fix?  Thanks!

Leo.

> > Since commit ca6c21327c6a ("perf: Fix missing SIGTRAPs"), the
> > 'pending_disable' flag was changed to a boolean toggles. However, the
> > AUX event code was not updated accordingly. The flag ends up holding a
> > CPU number. If this number is zero, the flag is taken as false and the
> > IRQ work is never triggered.
> > 
> > Later, with commit 2b84def990d3 ("perf: Split __perf_pending_irq() out
> > of perf_pending_irq()"), a new IRQ work 'pending_disable_irq' was
> > introduced to handle event disabling. The AUX event path was not updated
> > to kick off the work queue.
> > 
> > To fix this issue, when an AUX ring buffer overrun is detected, call
> > perf_event_disable_inatomic() to initiate the pending disable flow.
> > 
> > Fixes: ca6c21327c6a ("perf: Fix missing SIGTRAPs")
> > Fixes: 2b84def990d3 ("perf: Split __perf_pending_irq() out of perf_pending_irq()")
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> 
> Gentle ping.  This would be an important fix for AUX trace.
> 
> Thanks,
> Leo
> 
> > ---
> >  kernel/events/ring_buffer.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> > index d2aef87c7e9f..aa9a759e824f 100644
> > --- a/kernel/events/ring_buffer.c
> > +++ b/kernel/events/ring_buffer.c
> > @@ -441,7 +441,7 @@ void *perf_aux_output_begin(struct perf_output_handle *handle,
> >  		 * store that will be enabled on successful return
> >  		 */
> >  		if (!handle->size) { /* A, matches D */
> > -			event->pending_disable = smp_processor_id();
> > +			perf_event_disable_inatomic(handle->event);
> >  			perf_output_wakeup(handle);
> >  			WRITE_ONCE(rb->aux_nest, 0);
> >  			goto err_put;
> > @@ -526,7 +526,7 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
> >  
> >  	if (wakeup) {
> >  		if (handle->aux_flags & PERF_AUX_FLAG_TRUNCATED)
> > -			handle->event->pending_disable = smp_processor_id();
> > +			perf_event_disable_inatomic(handle->event);
> >  		perf_output_wakeup(handle);
> >  	}
> >  
> > -- 
> > 2.34.1
> > 
> 
