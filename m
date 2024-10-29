Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050F918130D;
	Tue, 29 Oct 2024 18:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730225421; cv=none; b=Ime6slyI2IvkVmRnXngEG8ulMRwpYK8XN0Qe4QYgI/BqkDk5enIXKKqhEZN8KFIc6LLjE5fS0YOwjpSn/f7njsao/ixQGQsDAoAxZQMbgb/j4rbJVYOW2srdEaHBwbtCMwAJ3oaTS0HUwtrmpQ8nHWdCjl3dGm9uXzIUaUevfOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730225421; c=relaxed/simple;
	bh=rSEPCwo3+FNPhGsdt6dt/oTNiBavhSDE5Kcuve0mHNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAXowjSnxIVXJT1u9lIn+KWq/ZdoVdS88jr9Elk/lAw1DrHAVa2B2HOw+6pv6Hom8+0h9ZlRKgIHTG/JuocLgBxg8rNcWrbBUdUeGJSTfFxI7vC9QRLqUyjiK62aLLVkTnTJvlnq1GA+4pofq9RrFe/ZiajZ8N9v+sXmruBO/Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IYV4OxWf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IYV4OxWf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4RFd0kI+7YFYqaFoPNrQ859Edbrzs6npcu3fCsS77ac=; b=IYV4OxWfDSGXniyTxmIA+Nqksi
	hfZn8Oc3qb8GtSkRZU0K7BEIlHRG/TensNiDi2gV892TFHRMPcJD6EYSCENxkvSK1Nbr1VSxvb2rX
	KkuXw5pESy/mFQO2wPPs6mrUcwUbVvAKdcxUDoYqmuEA9b+UCQ13AF5P1XY1WGQclSRugUjN4qTj1
	3FebFZCqrrj4s1qNBKRqqD4SZXMB/3+YUcMHy9OqkRn6zvawxuZ1uiyILgTnkQoDq6M7c8ihtqj4b
	9Tx0+cTJ9Hv6tAUM/RPEVkNhuOI4GeVa+EyKTNn5+4++IURZPYhKQNiIlYmAwhz3WDWYJnWZLU2Ba
	dCz7KS5A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t5qfQ-0000000ABZ4-1mBv;
	Tue, 29 Oct 2024 18:10:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AA8FF30073F; Tue, 29 Oct 2024 19:10:08 +0100 (CET)
Date: Tue, 29 Oct 2024 19:10:08 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 09/19] unwind: Introduce sframe user space unwinding
Message-ID: <20241029181008.GG14555@noisy.programming.kicks-ass.net>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
 <20241029132709.GY14555@noisy.programming.kicks-ass.net>
 <20241029165018.r4l5wix24s3f22c6@treble.attlocal.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029165018.r4l5wix24s3f22c6@treble.attlocal.net>

On Tue, Oct 29, 2024 at 09:50:18AM -0700, Josh Poimboeuf wrote:
> On Tue, Oct 29, 2024 at 02:27:09PM +0100, Peter Zijlstra wrote:
> > > +int sframe_add_section(unsigned long sframe_addr, unsigned long text_start,
> > > +		       unsigned long text_end)
> > > +{
> > > +	struct mm_struct *mm = current->mm;
> > > +	struct vm_area_struct *sframe_vma;
> > > +
> > > +	mmap_read_lock(mm);
> > 
> > DEFINE_GUARD(mmap_read_lock, struct mm_struct *,
> > 	     mmap_read_lock(_T), mmap_read_unlock(_T))
> > 
> > in include/linux/mmap_lock.h ?
> 
> Will do.
> 
> > > @@ -2784,6 +2785,16 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
> > >  	case PR_RISCV_SET_ICACHE_FLUSH_CTX:
> > >  		error = RISCV_SET_ICACHE_FLUSH_CTX(arg2, arg3);
> > >  		break;
> > > +	case PR_ADD_SFRAME:
> > > +		if (arg5)
> > > +			return -EINVAL;
> > > +		error = sframe_add_section(arg2, arg3, arg4);
> > > +		break;
> > > +	case PR_REMOVE_SFRAME:
> > > +		if (arg3 || arg4 || arg5)
> > > +			return -EINVAL;
> > > +		error = sframe_remove_section(arg2);
> > > +		break;
> > >  	default:
> > >  		error = -EINVAL;
> > >  		break;
> > 
> > So I realize that mtree has an internal lock, but are we sure we don't
> > want a lock around those prctl()s?
> 
> Not that I can tell?  It relies on the mtree internal locking for
> atomicity.
> 
> For sframe_remove_section() it uses srcu to delay the freeing until all
> sframe_find()'s have completed.

Yeah it does all that. But I was sorta looking at all that kmalloc and
copy from user stuff, but I suppose you can race that without problem.
