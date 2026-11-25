Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795599044;
	b=uydcJzXlNe7QWJE9YdepRyVP6YMdm5m5O9Pb8+pkNQfmey+bIlPp8X/5J5Qa45D9Zukp
	 2xsDBRqyTUGZmPQdFL/gh0xq4bGF1JvZiZo9eoxjwi1vQTIMnTbPFKWawpYDGIVxRnzpD
	 sgsYuapdI/5QhXt+j1roCEkQ414+SWS0RhFHuERxr0Q81+w7Q7hovzX/c6d2luIaflr9f
	 txkP9blVaf0945Sfe8MuDzdfZo/GUgKKPBj/KxCI9suU5CbZl4oXs7hMWgPx6ZD/UQN5a
	 GHuDOnCZyRIze+qA37/rwHWsQRcZ1PviQzU6nJao4KE5JLeFv2U4TlpxMu/g480GZKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599044;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=DIBUKxSI/z+N+2D00WXA/2rep7/Mub1GDKrW3QrmV88=;
	b=pnvmDP21UmxuRDCpA5EbdR18nxU7xUwjgGJTzSP4nbIEGAGXGeu+dDwYaNagaG8OOBp2
	 fy2wcaIkLAYeDqM61wmA2qA2C2HWNPeyGxmTl+PGmVD2zuvtkO/aylerTzhZMZZ5m7h16
	 j3BZUmKOa7nHnHpIiE1Qbi9mGOrhpRAd9fTqfOgNz8ZEqiMD1866VXEV7/0svJ6/o2wwZ
	 D9CiczBPx4EBwJHFpYvNbkH5EIHKVUO/vT5WyEn1+o5vHfE2Km/JnJ5aeiTCxL0hNn7oR
	 EnNvW3ZfDTFoWx7hKg9eV8DkLZvZOl1LpBF6IgWliWEsLICaRqtkip5vCVIjOG8Hg9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=aavwk520;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25876606A31E;
	Wed, 25 Nov 2026 09:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25876606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=aavwk520
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DIBUKxSI/z+N+2D00WXA/2rep7/Mub1GDKrW3QrmV88=; b=aavwk520T5VxyThKYa6yneM8tk
	MuGKDBpiblfINh4gr8FIz47V5CRGRdczgpb4YfLZb65XdSvows4Ws0FZm5b7twN9iKij/u2cFtBGy
	IN0DHmoKytP1xUAFyAumTt8Y7mtM9ppWJiwKXViY9wK2IJE39Psr2+dzKzxg2ZrAqe3prwgc5eWO6
	MputG4JeFfCHnv/2fQUqnlxkF5ttmvRfFVS1rdMT1iL5UnIEnrZFhuOLY/K4GIhzIc/b+sp9EU/rI
	GMpAkk4koliXyP6U+e3qPn8YIeZpu8jkd9B1aKzsXwrDeUi+5gycO5qLq2wY0PUVLvyVvdlLakr6t
	Ac4kKE6A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW9Km-00000005711-11yp;
	Wed, 25 Nov 2026 09:30:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9BBCD302186; Wed, 25 Nov 2026 10:30:34 +0100 (CET)
Date: Wed, 25 Nov 2026 10:30:34 +0100
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
Message-ID: <20261125093034.GN2669272@noisy.programming.kicks-ass.net>
References: <cover.1795053619.git.wutengda@huaweicloud.com>
 <55b1a2845b0ad34a874a7653644e34af9eb068d3.1795053619.git.wutengda@huaweicloud.com>
 <20261120173706.GC2668564@noisy.programming.kicks-ass.net>
 <20261120174606.GM2669272@noisy.programming.kicks-ass.net>
 <5507e48c-4e98-4e76-8d3f-4630a2655085@huaweicloud.com>
 <c9ff579b-a7eb-481f-bb8d-489a4469c397@huaweicloud.com>
 <20261125090809.GW2668804@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20261125090809.GW2668804@noisy.programming.kicks-ass.net>

On Wed, Nov 25, 2026 at 10:08:09AM +0100, Peter Zijlstra wrote:
> On Tue, Nov 24, 2026 at 04:42:34PM +0800, Tengda Wu wrote:
> 
> > From the stack, we can see:
> > 
> > perf_event_context_sched_out
> >         // fast path
> >         perf_ctx_enable(ctx, 0);
> >                 perf_pmu_enable
> >                         if (!--(*count))  // equals 0
> >                                 pmu->pmu_enable(pmu);
> >                                         __intel_pmu_enable_all.constprop
> >                                                 do_trace_write_msr
> >                                                         perf_tp_event
> > 
> > In perf_tp_event():
> >         if (perf_tp_event_match(event, &raw, regs)) {
> >                 if (!perf_pmu_enabled(event->pmu)) return 0; // not satisfied, continue downward
> >                 perf_swevent_event
> >                         __perf_event_overflow
> >                                 task_work_add  // event->ctx->task mismatches 'current'
> >         }
> > 
> > Because pmu_disable_count is already 0, the subsequent perf_tp_event_match()
> > cannot block it via perf_pmu_enabled(), so the problem can be reproduced.
> 
> Right, but at this point there isn't really a problem, all the pointers
> have been swapped already and state should be consistent again.
> 
> I *think* the problem is that task_work_add() is using current while it
> should be using ctx->task. In that case the above will enqueue on the
> next task, which is correct.
> 
> But also, we could probably write this to do:
> 
> 	if (*count == 1) {
> 		pmu->pmu_enable(pmu);
> 		barrier();
> 		(*count)--;
> 	}

Note that this on its own isn't going to help. All the event that happen
between perf_event_task_sched_out() and switch_to() will trip the same
problem.

> > Maybe my original nr_no_switch_fast approach is still worth considering.
> > -- it would account for sigtrap events at attach time and keep them off
> > the fast path entirely, rather than trying to filter the overflow after
> > the swap has already happened.
> 
> Disabling switch_fast really hurts performance; doing that should be a
> last resort. I think I can fix this. Let me try and see if the
> reproducer works for me so I can more easily poke at this.
> 
> 
