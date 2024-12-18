Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348201B423D;
	Wed, 18 Dec 2024 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541271; cv=none; b=SDmccvJhKRZPBxKBrKjgTGs0B/rLMKir2ScF+GdlHjUHWOTOf30VafNQvZyXr402LYM8WclR9YOFvN0++PvEvfuI4cE9deua9BdCbBLDjBuBLIeeeNJloAqjMZd0+U7DxxMr0ZNkwhZozK7lbNC3Ln2E8iNIZ/UH8thKDFmcbhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541271; c=relaxed/simple;
	bh=GC6kC2fksKdEZFSLLBys7XJWoU2V1qdJCrJipH3hyaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j09INukPYBqV3pyvXjGa4JLR4sZgP9O+eg8Y0rOHfLpiDVKOTHFVnFGbuZcyKfUHSDtLt4uWaR7rBZlTjCq5AWENMPZ1p9mUD1DvcoYXb3tBI+OELY6DloLCM14Pi6F/YFHp7xnkG+QKJR3V58XGD+ZbOajueGrb14OqYGWv7pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HMvKOfEY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HMvKOfEY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ItGB0I1SSRjVgo5hckHmEj0k3gRUv5haj3r5vJT5+To=; b=HMvKOfEYvmArq0coL0O7rJSuHC
	qM9aVN9jh4l+66WQ0a0gReEoBJ8BQLOPwX4GgERKFyYzH0LoNxDsIa1vhvVzUg6n3RblIRpeGRhAj
	dh9GoMff523QaNYrRdrPYrVuMwjqjxjWw6tInD6qgX/hakUw6zanup9/1lDHrKVWscL9+tUX5mwML
	kqv/tYsIBQs8o5+IDowp6PcMBQc44MhFeTYQ12bX6gL0PoQA6qQlc8/H8VjP1SHdOUZeZCJROJ/iX
	ysSMauCePT5OkW9GrUCfnC3bS+H4WQE7kuqzLuTyEzHTV2XwdBctKtHfOXH0YYpLMF8yqMPDKVY2z
	lWaKA9NQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNxQ0-00000000Jbp-1uT3;
	Wed, 18 Dec 2024 17:01:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7A0D130031E; Wed, 18 Dec 2024 18:01:04 +0100 (CET)
Date: Wed, 18 Dec 2024 18:01:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, ak@linux.intel.com,
	eranian@google.com, dapeng1.mi@linux.intel.com
Subject: Re: [PATCH V6 3/3] perf/x86/intel: Support PEBS counters snapshotting
Message-ID: <20241218170104.GM2354@noisy.programming.kicks-ass.net>
References: <20241218151643.1031659-1-kan.liang@linux.intel.com>
 <20241218151643.1031659-3-kan.liang@linux.intel.com>
 <20241218163249.GI2354@noisy.programming.kicks-ass.net>
 <3d63f8b2-c028-4cae-ad72-76378425c73a@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d63f8b2-c028-4cae-ad72-76378425c73a@linux.intel.com>

On Wed, Dec 18, 2024 at 11:55:53AM -0500, Liang, Kan wrote:
> 
> 
> On 2024-12-18 11:32 a.m., Peter Zijlstra wrote:
> > On Wed, Dec 18, 2024 at 07:16:43AM -0800, kan.liang@linux.intel.com wrote:
> > 
> >> To prevent the case that a PEBS record value might be in the past
> >> relative to what is already in the event, perf always stops the PMU and
> >> drains the PEBS buffer before updating the corresponding event->count.
> > 
> > Like I wrote here:
> > 
> >   https://lkml.kernel.org/r/20241218082404.GI11133@noisy.programming.kicks-ass.net
> > 
> > I don't think this is sufficient.
> 
> 
> I replied with an explanation this morning in the old V5 thread. I'm not
> sure if you got a chance to look at it.
> https://lore.kernel.org/all/5a4ab06e-8628-4e1d-addb-2af920deffad@linux.intel.com/

Bah, I actually checked there before replying and didn't see the email
-- it is there now.

> There will be a drain_pebs() right before handling A-overflow-PMI.
> 
>   B-assist			A=1
>   C				A=2
>   B-assist			A=3
>   		<- drain_pebs()
>   A-overflow-PMI		A=4
>   C-assist-PMI (DS buffer)	A=5
> 
> So the A-overflow-PMI will
>    - Process the DS. adjust A->count to 3
>    - adjust A->count to 4
> 
> Is it sufficient?

Yes, that will work. A bit yuck but perhaps good enough.

OK, I'll go stare at this new series tomorrow -- brain is about to give
out for the day.
