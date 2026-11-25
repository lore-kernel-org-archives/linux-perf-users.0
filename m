Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604151;
	b=XTS5CJARYDZeWUTckFnTWWzYw7hKE+dGVdJszBGgVfZvlA7jd/VGh4pMGPynDwzhRYR8
	 8EGUe+o0vs9p4Uwy0Zfl/VPn6nh8mnD6Pl1uBdpfkOTcIlSlUvGLwcXXYJ3a29hEeGnnT
	 jWliaNIiIP5Ccg65s88GEUIIZdBPM3g5FwzmqbRhmdUPUVE0j6ufksencEtQGadYLB7mo
	 wn28JIPUSJtM5rnKptqjnjf8B2Nq1csDYGJXitKpvjc2gX1HlNeXRzIgvGHXubWulBwna
	 uK4zBmTJ7rivBzG6kKTdFCN1t2m/ysmFGqoyG55chuAVyYESrcQ1QJCRWn1ETPuBNoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604151;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=nVvhMLnO7Qtxe5uti7YVs0cSjnqxnVQm/aXuRYRap4c=;
	b=eXBT3mJY0ef7bXSAl8rSfO0yfNhGY5RoDDRe32rvxGgLtkhc3uaIdNlVEoRzDoWFYXq/
	 A3t2HyoD13OSwL73Tz90NC4zkFJBl6tlT7iZOyX0NP7Ew/UljHzycjqDHD0i7GzZRTgQC
	 bW/Tjzg9nlFmYvWCuXH26Ol57TL/in/Hziujs0DEcInQx2Hj8VELb4QLL7dDe3TrWvpvm
	 shkhAgV2ea2pu31jL5iMmk/jo4Kxqg4uDyEGuY/Sug4Di3NLIy+ASSjMBerv1LMwRw6aM
	 YHXjZipEL1l1Sl3Ru0WJ7kRikeLATV4HnXFXTbEtqxi9ODco+DYe/AQ0fvjTNWntXXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=EATSTtMo;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Fmwu+ZRP;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C73D606A321;
	Wed, 25 Nov 2026 10:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C73D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=EATSTtMo;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Fmwu+ZRP
Date: Wed, 25 Nov 2026 11:55:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795604148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nVvhMLnO7Qtxe5uti7YVs0cSjnqxnVQm/aXuRYRap4c=;
	b=EATSTtMo3vIDcVQn90dklYod97Po1/19DlKkJnXBQR1jL7ffILoBT23t/L/I7w1ufNKYI4
	Z3UWMBL1W0zjuy5E2wzY/i3a4MwU9dlxqWfgP7hjtiyr+Kw8vZfTbZ1fUdEmCNRxoZXYEg
	pzK7g6c8D7QkjccH1WganJTnI20Gpp1Lj5z7mzQ22KZ4f8qehAzXYSKsX/wH3ppOQ6Ta/k
	fq3YvzMj5wrj4IkBdWpC+EiRMlDKH/PJdNC0EklFtpYq/8MqriVJvrGAoCHP/zN9qxFvkt
	wvmExd0x/jYFiApAYu4NxwRJmQjYcP7ptAZOXBVPBLxkExWiRsXgDd1q5+s9lA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795604148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nVvhMLnO7Qtxe5uti7YVs0cSjnqxnVQm/aXuRYRap4c=;
	b=Fmwu+ZRPKgwtNxC4sAs04tBU+x+lY4Uf6VathHl1FPkZoq/geGCMqcVslltdyRHtHWqiPV
	MLE/IsTKdl3dHMDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tengda Wu <wutengda@huaweicloud.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] perf/core: Prevent duplicate sigtrap task work
 enqueue
Message-ID: <20261125105547.WBO5iSOJ@linutronix.de>
References: <cover.1795053619.git.wutengda@huaweicloud.com>
 <45bd71c976aea1a0e8bf5762dd6b6552e6009439.1795053619.git.wutengda@huaweicloud.com>
 <20261120154457.GZ2668564@noisy.programming.kicks-ass.net>
 <20261120154959.zw08JC0V@linutronix.de>
 <20261120160140.GR2668804@noisy.programming.kicks-ass.net>
 <20261120162604.GL2669272@noisy.programming.kicks-ass.net>
 <20261120172831.5XwELZY5@linutronix.de>
 <20261120174942.GU2668804@noisy.programming.kicks-ass.net>
 <20261123080004.MKzgHQ3W@linutronix.de>
 <20261125082711.GV2668804@noisy.programming.kicks-ass.net>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261125082711.GV2668804@noisy.programming.kicks-ass.net>

On 2026-11-25 09:27:11 [+0100], Peter Zijlstra wrote:
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -7776,8 +7776,8 @@ static void perf_pending_task(struct callback_head *head)
> >  	rctx = perf_swevent_get_recursion_context();
> >  
> >  	if (event->pending_work) {
> > -		event->pending_work = 0;
> >  		perf_sigtrap(event);
> > +		WRITE_ONCE(event->pending_work, 0);
> >  		local_dec(&event->ctx->nr_no_switch_fast);
> >  	}
> >  	put_event(event);
> > 
> > To ensure the ::pending_work is reset after perf_sigtrap() is done?
> 
> task_work_add() can be used while inside task_work; so I do not see why
> this would matter.

Because perf_sigtrap() uses event->pending_addr, ->orig_type and
->attr.sig_data. So if an event is enqueued before this is consumed it
can overwrite the former content and report the latter twice.

Sebastian
