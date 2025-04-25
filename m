Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D35233728;
	Fri, 25 Apr 2025 07:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745565243; cv=none; b=LRpRfEuRtCO2LKaWoeBXzq6oUESce+yldCI/Dze0qFK+emSBY8C27GPvh1kRnvMQ5pQHq/25uFdEZ5/dffNZmYTwW/bBUQxilrH3BUKnLak7Klea6A7slEdcaI2SEbTQf5EEAl+bEP96PJjMDmRsksLSlw+ElmysqPAAMQbBP0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745565243; c=relaxed/simple;
	bh=+ctObHH1pb3kS3cIi40xiXuXpl2mjHb3Jdgh7xJnkbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icJciQ8wwhd66pqb2i+8r6VxViqjJkS1chBySPG/xUzpp6pEaCzDwitm5iIIeK6gOUof+E+4jplzhVfVRTTeQx6fH/j/r94f5iuvRlBAc6uBRN/BS757c6jGwA/pBQemH8JKRUcDBYtSrSbasyKXM5mu4EL3Sii/2DAg2H3agIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e7himNVO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e7himNVO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4lmsAT3MghLxXHYhqFb6fJfOdNWGEgo/7wDZBEzOx4U=; b=e7himNVO2CGBbHxziwQwEd8jyB
	2aeJtIakiLvV6UbndOvwrVra/cBTXt/M6YAIyhM78v7Pko/k0bLLVizrXWdZp8lyrQ1a2yAZ7Qu97
	aUmrM8Fr+6kEEN46U+41RgKKan2diAmtDRpHTPngoaGwlBt1DnSCqKPPs7zHsi3vyi07+gX8QDyms
	75brC7OSpI4Zr0jcQPJCiJgXGMa2IVK9RW/s9zmNsiaofuqLHqgc70+Xi9l8ZREXuMuamzKw0mdYc
	IsjI90JiWUCKJOpqjQonXvejbG+BcH5tTnJ9qoYMPN0eGxIrFSsHfEMjnSJlIzocP39EE37NbmAPu
	vVTx7fIw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8DFj-0000000Dz5S-3xrJ;
	Fri, 25 Apr 2025 07:13:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 80FA5300583; Fri, 25 Apr 2025 09:13:39 +0200 (CEST)
Date: Fri, 25 Apr 2025 09:13:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>, Weinan Liu <wnliu@google.com>,
	Blake Jones <blakejones@google.com>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>
Subject: Re: [PATCH v5 11/17] perf: Simplify get_perf_callchain() user logic
Message-ID: <20250425071339.GJ18306@noisy.programming.kicks-ass.net>
References: <20250424162529.686762589@goodmis.org>
 <20250424162633.048002581@goodmis.org>
 <20250424163607.GE18306@noisy.programming.kicks-ass.net>
 <20250424132800.49160c2e@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424132800.49160c2e@gandalf.local.home>

On Thu, Apr 24, 2025 at 01:28:00PM -0400, Steven Rostedt wrote:
> On Thu, 24 Apr 2025 18:36:07 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > +++ b/kernel/events/callchain.c
> > > @@ -246,22 +246,20 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
> > >  
> > >  	if (user) {
> > >  		if (!user_mode(regs)) {
> > > -			if  (current->mm)
> > > -				regs = task_pt_regs(current);
> > > -			else
> > > -				regs = NULL;
> > > +			if (!current->mm)
> > > +				goto exit_put;
> > > +			regs = task_pt_regs(current);  
> > 
> > I'm thinking this might be one of those is-kthread test written as
> > has-mm, and they're broken.
> > 
> > Notably things like the io-uring kthreads do have mm.
> 
> Would there ever be a case where:
> 
> 	current->mm == NULL && !(current->flags & PF_KTHREAD)
> 
> ?
> 
> That is, do we still need to check for current->mm if it's not a kernel
> thread, or can we assume it exists?

IIRC just checking PF_KTHREAD should be sufficient.
