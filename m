Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5831DF977;
	Mon, 23 Jun 2025 07:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750663749; cv=none; b=MmybN9LnyROu2UBLCQdGVWllY7zWjquU5CHePKk/Wcq+m8YADiVa2NCQSKYT7Jkn6tOQTgVE/Kfjj1XJgQnsF6frCnHlX00Hv0lmBkaIoX5UPY1dVXSdsYhGyPZ+w3LCORxDQaipjXtySSjng32k5TphPBz8/x7rvNuiiiC+BE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750663749; c=relaxed/simple;
	bh=iEb75kedDK9jzJl5dTiD94gugQWpx62MxDwqDUBI3/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRmWqG1RDHDBNJGHTuwtCfKfF9IOOs8UAGXrafKwnbXKEyi/LVqiXc/lT3Z01iENSMQgquHZ5Ap0zcvXgQ+7Ytu90C+dNTshJ/2ZsMJ/230nbMErI4Z42gcs96g+7frFewMhqt5lHju3P49vKyoLqa4542ysKHNKMLjlMYNPrY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IiwqaWvc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IiwqaWvc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=y8zZNptWeMcyuRRjVCidTkh+/C4Axx/FweDvXPEv1zk=; b=IiwqaWvc+U6spOy3Zsyt06wiOm
	rnwmhnqbMfi3rXuLXuOIZQ2DUpsNCTb1wkO9OOTruAdnln1AkvA36Yv8iDk0WL/vu7nH/M8xhgw6U
	FUG7ulpXfAziDBWBw1kbWKEgR9BYsP9uhcl6y8PceslBg+PhLOo0r2DhU98cdbxVkd767+U21KLjl
	9eSmlYLDOqetEiohs81QqJ3b+UekKJaLkGCyli4A9QfP+Dq5vrsfRsPbPGlWLNzp7DzvCD0z/ZOvl
	kTTMiQINJw5BD6C7vRnb+rUQEKLp/IxnbPIwGO5dZju63GKyvAe2UjGavyvCA76dz6QbOhf1EloGG
	jqzmOT0w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTbbo-00000002gbf-0CZN;
	Mon, 23 Jun 2025 07:28:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F16C3301C34; Mon, 23 Jun 2025 09:28:50 +0200 (CEST)
Date: Mon, 23 Jun 2025 09:28:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [Patch v4 07/13] perf/x86/intel: Allocate arch-PEBS buffer and
 initialize PEBS_BASE MSR
Message-ID: <20250623072850.GN1613200@noisy.programming.kicks-ass.net>
References: <20250620103909.1586595-1-dapeng1.mi@linux.intel.com>
 <20250620103909.1586595-8-dapeng1.mi@linux.intel.com>
 <20250621092001.GT1613376@noisy.programming.kicks-ass.net>
 <8f6effaf-0a4b-411e-8e12-57f3c83069c2@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f6effaf-0a4b-411e-8e12-57f3c83069c2@linux.intel.com>

On Mon, Jun 23, 2025 at 09:17:23AM +0800, Mi, Dapeng wrote:
> 
> On 6/21/2025 5:20 PM, Peter Zijlstra wrote:
> > On Fri, Jun 20, 2025 at 10:39:03AM +0000, Dapeng Mi wrote:
> >
> >> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> >> index b6eface4dccd..72b925b8c482 100644
> >> --- a/arch/x86/events/intel/ds.c
> >> +++ b/arch/x86/events/intel/ds.c
> >> @@ -625,13 +625,22 @@ static int alloc_pebs_buffer(int cpu)
> >>  	int max, node = cpu_to_node(cpu);
> >>  	void *buffer, *insn_buff, *cea;
> >>  
> >> -	if (!x86_pmu.ds_pebs)
> >> +	if (!intel_pmu_has_pebs())
> >>  		return 0;
> >>  
> >> -	buffer = dsalloc_pages(bsiz, GFP_KERNEL, cpu);
> >> +	/*
> >> +	 * alloc_pebs_buffer() could be called by init_arch_pebs_buf_on_cpu()
> >> +	 * which is in atomic context.
> >> +	 */
> >> +	buffer = dsalloc_pages(bsiz, preemptible() ? GFP_KERNEL : GFP_ATOMIC, cpu);
> >>  	if (unlikely(!buffer))
> >>  		return -ENOMEM;
> > Here we go again.. that is CPU_STARTING context, that has IRQs disabled
> > and as such no allocation is allowed. Not even GFP_ATOMIC -- this will
> > break PREEMPT_RT.
> 
> Thanks. So we could have to follow what current legacy PEBS does and defer
> the PEBS buffer allocation until creating perf events
> (x86_reserve_hardware()). 

The normal way to do this kind of thing is allocate in prepare, use in
starting, and the reverse on down, stop using in dying and free in dead.

Specifically we have the callbacks:

CPUHP_PERF_X86_PREPARE  -> x86_pmu.cpu_prepare()   / x86_pmu.cpu_dead()
CPUHP_PERF_X86_STARTING -> x86_pmu.cpu_starting()  / x86_pmu.cpu_dying()

to arrange for just such a setup.
