Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526111804A;
	Wed,  4 Jun 2025 07:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749020788; cv=none; b=YMZ+pc3G9F+SN8xrV6WgagmwQXrCbqCwToqhedjpWnMbySLx21GmGZFf/+XvtBXbamEnWqtDcwWPqA7TNFrhXsPN7XVNsLSXZi5DUNZ+3eTux2OVhsTdRQhm4SRrIb/uPDvJtITwHdAI6xsaAxRIRtJXTloKTsgmP96eNL3nhS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749020788; c=relaxed/simple;
	bh=fb1zYw1MePe7PLk0081SYUZmyHexhx+j73xIVztrCPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+nRArhgw1JexB3Uni3Dc3LNnWclWTnddLv4NAJM2/ZITDiWJVfaMEzUfooxI/20ThnzO44rozgRssspiwdFZHkpr7h+9k1IbnCnQiTBziTw42/INMM2wKL5tlDUyIeSLyR9WIZgdEXVL77S4RVzoi8fqhnenat99a1Qu6yXPE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cyiZiTxF; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cyiZiTxF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QZ0FDW05DYTrZxA8UqgPP+sc5Sgw/PwOAo8SMdhpEfY=; b=cyiZiTxFn9MYorh7AIQY0ppJkB
	Vx5yWnjV0uw3Q4xJxlsUz2sA+TaJ5W+vEMFxe6IpBJbLLPKrf+A4Jm+4wBQcopR1rq7bs2IsZ7skz
	IkkGvjA5t3v6IPTrzaVc7Yxo1u1e86qt+5UaJZva95FCG09ADLCe5JSVyXrkKI6JMmt8s7qWbAQMs
	eEYUpKYGaWYmFcwxqSTE/qCB6/X+BJ4JcyRbB4pYZVOj1jTNeOzw4Qhdeb9hwwUgQW0pGOAy9wBhi
	l7SwAg9ozODIhQ+WHR1pJRg6AGa+OZTRRzc9i4nM1G5sz9jLppNTs9EgJXChp6932quFXd1ws7Ub2
	FpU3eM7g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMiCP-00000000sDJ-1qmK;
	Wed, 04 Jun 2025 07:06:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B00C2300787; Wed,  4 Jun 2025 09:06:08 +0200 (CEST)
Date: Wed, 4 Jun 2025 09:06:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Leo Yan <leo.yan@arm.com>, mingo@redhat.com, mingo@kernel.org,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Wang <00107082@163.com>
Subject: Re: [PATCH 1/1] perf/core: fix dangling cgroup pointer in cpuctx
Message-ID: <20250604070608.GF38114@noisy.programming.kicks-ass.net>
References: <20250602184049.4010919-1-yeoreum.yun@arm.com>
 <20250603140040.GB8020@e132581.arm.com>
 <20250603144414.GC38114@noisy.programming.kicks-ass.net>
 <aD8R8Bke1KZifJDH@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD8R8Bke1KZifJDH@e129823.arm.com>

On Tue, Jun 03, 2025 at 04:17:04PM +0100, Yeoreum Yun wrote:
> 
> Hi Peter,
> 
> >
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -2120,18 +2120,6 @@ list_del_event(struct perf_event *event,
> >  	if (event->group_leader == event)
> >  		del_event_from_groups(event, ctx);
> >
> > -	/*
> > -	 * If event was in error state, then keep it
> > -	 * that way, otherwise bogus counts will be
> > -	 * returned on read(). The only way to get out
> > -	 * of error state is by explicit re-enabling
> > -	 * of the event
> > -	 */
> > -	if (event->state > PERF_EVENT_STATE_OFF) {
> > -		perf_cgroup_event_disable(event, ctx);
> > -		perf_event_set_state(event, PERF_EVENT_STATE_OFF);
> > -	}
> > -
> >  	ctx->generation++;
> >  	event->pmu_ctx->nr_events--;
> 
> JFYI, this removal should be not included when you backport to v6.15
> unless your patch backport together:
>   commit 90661365021a ("perf Unify perf_event_free_task() / perf_evenet_exit_task_context()")

Right. But lets just get the patch for the current tree right. Then we
can worry about backports :-)
