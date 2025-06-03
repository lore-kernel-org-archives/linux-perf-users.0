Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935C81E519;
	Tue,  3 Jun 2025 12:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748955292; cv=none; b=WXcb9FNvHJeafa+zV0ICMnTInlNu/ZETAYFS23z8UVu7pnl72p+gDW6AT0yJhRwmksQVj9EMCcViDzo1tg9TO/NbY+O/5zSzXJyrbsVA0M5zSiosfyt5VSwO+XoEZB0SYnMsY5LZNMm+vwepsfvalEfPzn6ZaD80HEi3IWtfu3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748955292; c=relaxed/simple;
	bh=0zZTn88nHJTp3sqZm1uVAtQ8D7IKSdaaPX/1s7Jv4LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okwcdlqI2k4HGLstilS2gmeUh05r0kOtwR7uB6OVeycSdpj3hevi34Y+zIE2uOeqYfvjhHEoKR6NSYKPEfUUg8ekO+1ZG4BiWIuNOQlqB9Uk2z3Fjz9JL+ypNwAxzTxH20RY/die4qVBkYm62MB1e1GmULHiiMXWi6Oyp5Ts7mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XlOKoDoy; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XlOKoDoy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gscpRI9+8A+XFtOn6r3eBXEQkaguajPtulDYPqJTeZQ=; b=XlOKoDoy4rxmsVQ5M6pIDDA1lm
	E9+ci176+hoWKgTz95R8pfYymvCrb/2F2yuueTlrfFOqB89VhKr/G3semOngiK54N3h5KPxw5pz+z
	Yv7uLHRyxQRIt1mgBLGQdj5QV3gm2Tavit5Z5LPyTy6oOVWujTQd7OSvFSs0+rJjONCrcEllMJxJ1
	tMlsz2S/jrsKFZIY+qJCG/UFMkNW46kV7rU9umwVb6ZbX0z5BS00B2wzuzDCCqyc7Wqkt8om+6/1f
	Y2hlfZ+ly0PhW9Bb1OydTjXT05Qn1qDycsbxNqmm5axzy121RapW5yRHgZHaFwGcwd49++HWEQFFK
	/+0/qVpQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMRA9-00000000l1q-2jXA;
	Tue, 03 Jun 2025 12:54:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5C728300781; Tue,  3 Jun 2025 14:54:40 +0200 (CEST)
Date: Tue, 3 Jun 2025 14:54:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: David Wang <00107082@163.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mingo@kernel.org, yeoreum.yun@arm.com, leo.yan@arm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf/core: restore __perf_remove_from_context when
 DETACH_EXIT not set
Message-ID: <20250603125440.GA35970@noisy.programming.kicks-ass.net>
References: <20250603032651.3988-1-00107082@163.com>
 <20250603083304.34132-1-00107082@163.com>
 <20250603091352.GJ21197@noisy.programming.kicks-ass.net>
 <2633d43d.ae30.1973564f5e5.Coremail.00107082@163.com>
 <20250603125056.GI39944@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603125056.GI39944@noisy.programming.kicks-ass.net>

On Tue, Jun 03, 2025 at 02:50:56PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 03, 2025 at 06:44:58PM +0800, David Wang wrote:
> 
> 
> > (As yeoreum.yun@arm.com pointed out,  the change in perf_remove_from_context() made
> > perf_event_set_state() happened before list_del_event(), resulting in perf_cgroup_event_disable()
> > not called.)
> 
> Aah, d'0h. Let me see what we should do there.

Does this help? This way event_sched_out() will call
perf_cgroup_event_disable().


diff --git a/kernel/events/core.c b/kernel/events/core.c
index f34c99f8ce8f..adbb0372825f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2494,9 +2494,9 @@ __perf_remove_from_context(struct perf_event *event,
 	if (flags & DETACH_REVOKE)
 		state = PERF_EVENT_STATE_REVOKED;
 	if (flags & DETACH_DEAD) {
-		event->pending_disable = 1;
 		state = PERF_EVENT_STATE_DEAD;
 	}
+	event->pending_disable = 1;
 	event_sched_out(event, ctx);
 	perf_event_set_state(event, min(event->state, state));
 
