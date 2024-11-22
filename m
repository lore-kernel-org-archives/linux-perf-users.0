Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1555C1D7E4A;
	Fri, 22 Nov 2024 11:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732274397; cv=none; b=P0hfYD6mUGCeLurlFwRJjhfJwx+ZfiNcht/VS0tpYExX6XJ2kYDus3zrjHOTZxGyYqb/lQxREL9l3EcCFG+v61Y3aqVGflGbrxCgsxkgQlZZJ7ity9TbQzQDWRmLRulRnABw+Pc8RLPb5nyqL5WNOFJ07y8e8br36DlVBu/wPMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732274397; c=relaxed/simple;
	bh=0rmC9afjYnxya0c+eb7NX5ABOO28jdizJ4yfcclXlIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umvluf5/ADJ8CEydYzRyUO1Im5EyeZeYPhsLEOEclh7/tFb6DYIJCy1l/fXsMoGY6gf9gZi9VXKOhIQEGbGAXNj6gqnrZkc/GNPTwblfScYf/Hd0AqQYNakGBkN+YnZZBmwM/Caz/DJWczspZp2xF0mckSQvXLAHB/ydwoOBXJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j5WaJOO7; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j5WaJOO7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Rsa2zO/oU1XywCRCkVED6a7NQrlxk0KKRr3BJt33v68=; b=j5WaJOO7FB6HAeIZZfPFV7GTGO
	l3y7TIgVe9OyYSIXcwU+29pblwBMsLqM2LTCmiYNdiOMqZZF7qZ/HUQ9a6rP25WIxZQmxyWBWCVw5
	pJ/IURWvMzXKfksP/3JK5Wik67J7vOb/coH6SDy79q5zIUyTCeL++bR//0AzbKhiGCpbh56qAq94l
	utw0uKbX8TbhKMdHfA6m550fS/j//NRoQZBNggkIXcQbae6tuPtGUr4wpgtaD/Zb+gMPrJ8J9p5+v
	gei0sSRW1hZ3H77T1XbIqzVrxa+pIYEmqlkhWR83/7vBdT7GuZuOMyDm1DQXLUD/6SCPf2cX37PeH
	vv9Wjg+Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tERhW-00000000hKk-3hgo;
	Fri, 22 Nov 2024 11:19:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 84F1230066A; Fri, 22 Nov 2024 12:19:50 +0100 (CET)
Date: Fri, 22 Nov 2024 12:19:50 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: mingo@redhat.com, rui.zhang@intel.com, irogers@google.com,
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.dei,
	gautham.shenoy@amd.com, kprateek.nayak@amd.com,
	ravi.bangoria@amd.com, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/10] Add RAPL core energy counter support for AMD
 CPUs
Message-ID: <20241122111950.GT24774@noisy.programming.kicks-ass.net>
References: <20241115060805.447565-1-Dhananjay.Ugwekar@amd.com>
 <20241119122021.GE2328@noisy.programming.kicks-ass.net>
 <e4a2c5f3-4bd3-4ce9-a872-d9e3d7b58f54@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4a2c5f3-4bd3-4ce9-a872-d9e3d7b58f54@amd.com>

On Fri, Nov 22, 2024 at 12:04:25PM +0530, Dhananjay Ugwekar wrote:
> On 11/19/2024 5:50 PM, Peter Zijlstra wrote:
> > On Fri, Nov 15, 2024 at 06:07:56AM +0000, Dhananjay Ugwekar wrote:
> >>
> >> Dhananjay Ugwekar (9):
> >>   perf/x86/rapl: Remove the unused get_rapl_pmu_cpumask() function
> >>   perf/x86/rapl: Remove the cpu_to_rapl_pmu() function
> >>   perf/x86/rapl: Rename rapl_pmu variables
> >>   perf/x86/rapl: Make rapl_model struct global
> >>   perf/x86/rapl: Add arguments to the init and cleanup functions
> >>   perf/x86/rapl: Modify the generic variable names to *_pkg*
> >>   perf/x86/rapl: Remove the global variable rapl_msrs
> >>   perf/x86/rapl: Move the cntr_mask to rapl_pmus struct
> >>   perf/x86/rapl: Add core energy counter support for AMD CPUs
> >>
> >> K Prateek Nayak (1):
> >>   x86/topology: Introduce topology_logical_core_id()
> >>
> >>  Documentation/arch/x86/topology.rst   |   4 +
> >>  arch/x86/events/rapl.c                | 414 ++++++++++++++++----------
> >>  arch/x86/include/asm/processor.h      |   1 +
> >>  arch/x86/include/asm/topology.h       |   1 +
> >>  arch/x86/kernel/cpu/debugfs.c         |   1 +
> >>  arch/x86/kernel/cpu/topology_common.c |   1 +
> >>  6 files changed, 272 insertions(+), 150 deletions(-)
> > 
> > Thanks, I'll stick them in a tree post -rc1.
> 
> Thanks Peter!, there was a bug reported by Peter Jung, it is fixed by a diff that 
> I posted as a reply, could you please squash the diff into the last patch of the 
> series before merging or let me know if you prefer me to post the squashed patch 
> separately.

Already squashed. Thanks!
