Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795599523;
	b=TGZeCvm/OR0d6GuXMhBgs2jHCwIeawVFB0sW+YxgdoRp0uzIMW0ilMPzLsA+EhojBsFm
	 MN75GOwavOJRTG/NuLjp55v2Od/tmTOTiBOs+7CirklQrG2OZr3fqA25mfijN6KPqruw8
	 0FO36DMFyfl/cIobODUNui1JJ7O+Pa1DS1ly6SufGE/GIkezql8e1Lnr3DYujpp2IT9RN
	 7efQ+lfOFhS6DMXDcMemfVKAuzUmve1DeecWXQYyK7AF+zlnRmzsSbu0iG9TulWdcFO4W
	 ViEtv0a16QSm1RDGGNeJf+tx5NVy++boO0cDH3MpbBLey7SGHQvFyxtt5y5rG7atKXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599523;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=m3eVgzUZlwp75/fzUdsc3RQgqJEC+CR7cinxZk1znh0=;
	b=Bp6pjTMSMaw5xnMhALLxVqpKvkhm0ZFIITlrh2fm95nTgdmqQp9qGpzDCoI1T4l6chXq
	 Aw3gG7Dk4Fjtc/9615SOiKvbMaPnkYiXMXSKMH2FpCaPccj8oVcHOMlsBb5Ui1mBBGX2t
	 xVhgP6efBk+2ZqMzCoDLPuaZYAEr+5ZJ5drjE7M8qEe4fUY3mSjYEKm7SxOvWNcrtygag
	 eGcHYhJuFNiC+3reSijFt+w+eJ7zUbfBg690j6G3WV1zd8dPnCKTligAamj9+X317iVos
	 h1+aNakuRmHk0LYtPiNFUWxlzlUJrqyradmbS9secM8C3y5hjO4uEmYZt8v066FV15g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=M3URgmOE;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2132A606A321;
	Wed, 25 Nov 2026 09:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2132A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=M3URgmOE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=m3eVgzUZlwp75/fzUdsc3RQgqJEC+CR7cinxZk1znh0=; b=M3URgmOE8LZagvHpObWdy70cEx
	DLT4EPDt6iOu2h4YmE6++CQshmO9GsiY56zoEcPAP2QJ+ctXdv9VZwUlowaEs3EwpZJ6DNlaYzSCz
	kc3/mPaBi4jcB6eN/QXzvw3SjWdeyRAZ7Ur7g0ut1ZZLbxxd2HXQ3kke5LaZ+Y+BCsATJMIdmYOw5
	dE0YQTAUYFqs2nDhbgwroFifUSPaEs8Ei2HAFO8ewMquuVp/hZjCMjO8fpAV3h8Vw4GmRDw91tDXT
	LK6g18AoY3MMS3PNCZLT7xM6q+EWLJimw19e+0iFC1WfeKstszLuTWBVa6INnTos0vL1bL6wqe40V
	5nQ382gw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW9SX-000000057in-3U6x;
	Wed, 25 Nov 2026 09:38:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CAA92300446; Wed, 25 Nov 2026 10:38:36 +0100 (CET)
Date: Wed, 25 Nov 2026 10:38:36 +0100
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
Message-ID: <20261125093836.GX2668804@noisy.programming.kicks-ass.net>
References: <cover.1795053619.git.wutengda@huaweicloud.com>
 <55b1a2845b0ad34a874a7653644e34af9eb068d3.1795053619.git.wutengda@huaweicloud.com>
 <20261120173706.GC2668564@noisy.programming.kicks-ass.net>
 <20261120174606.GM2669272@noisy.programming.kicks-ass.net>
 <5507e48c-4e98-4e76-8d3f-4630a2655085@huaweicloud.com>
 <c9ff579b-a7eb-481f-bb8d-489a4469c397@huaweicloud.com>
 <20261125090809.GW2668804@noisy.programming.kicks-ass.net>
 <4d17dd3b-df73-45c0-8113-f4ca259d549b@huaweicloud.com>
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
In-Reply-To: <4d17dd3b-df73-45c0-8113-f4ca259d549b@huaweicloud.com>

On Wed, Nov 25, 2026 at 05:29:38PM +0800, Tengda Wu wrote:
> 
> 
> On 2026/11/25 17:08, Peter Zijlstra wrote:
> > On Tue, Nov 24, 2026 at 04:42:34PM +0800, Tengda Wu wrote:
> > 
> >> From the stack, we can see:
> >>
> >> perf_event_context_sched_out
> >>         // fast path
> >>         perf_ctx_enable(ctx, 0);
> >>                 perf_pmu_enable
> >>                         if (!--(*count))  // equals 0
> >>                                 pmu->pmu_enable(pmu);
> >>                                         __intel_pmu_enable_all.constprop
> >>                                                 do_trace_write_msr
> >>                                                         perf_tp_event
> >>
> >> In perf_tp_event():
> >>         if (perf_tp_event_match(event, &raw, regs)) {
> >>                 if (!perf_pmu_enabled(event->pmu)) return 0; // not satisfied, continue downward
> >>                 perf_swevent_event
> >>                         __perf_event_overflow
> >>                                 task_work_add  // event->ctx->task mismatches 'current'
> >>         }
> >>
> >> Because pmu_disable_count is already 0, the subsequent perf_tp_event_match()
> >> cannot block it via perf_pmu_enabled(), so the problem can be reproduced.
> > 
> > Right, but at this point there isn't really a problem, all the pointers
> > have been swapped already and state should be consistent again.
> > 
> > I *think* the problem is that task_work_add() is using current while it
> > should be using ctx->task. In that case the above will enqueue on the
> > next task, which is correct.
> > 
> 
> I considered this before, but it involves the issue of whether the count
> overflow in the sched_out stage should be attributed to the current or next
> task, and I wasn't very confident about it, so I didn't adopt it.

All of switch_fast suffers that problem. Mostly we've ignored it since
kernel events around a context switch are hard to attribute to any one
particular task, so a little fuzz left or right of the switch doesn't
matter too much, as long as its consistent.

> > Disabling switch_fast really hurts performance; doing that should be a
> > last resort. I think I can fix this. Let me try and see if the
> > reproducer works for me so I can more easily poke at this.
> > 
> 
> OK. Just a reminder that the PoC I provided needs to be run in an Intel
> environment, so that the tracepoint can be hit when pmu_enable is executed.

Ah, I'm currently running it on an SPR Xeon; do I need to use
non-default arguments or just run the thing in a loop and drink tea
until it goes pop?
