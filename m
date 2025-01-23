Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113A91EEE0;
	Thu, 23 Jan 2025 08:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737621106; cv=none; b=Hku8gPbnAZgzYObvYIQVT4QG/pThCgS9e80d6kC0/O/ZW67q/tdWgRMIk9S0uirMVE8dYC8Hsxkn4qmgy+RtkcvREubpDQG5wNqFuBdSzy91611x3b0hl69APmovktCBYovGpFsbYl/JUWHjIbOQW5IZz4jgEOaIJIPoJVvNqrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737621106; c=relaxed/simple;
	bh=cqr96AADxibyyX3p/cVeDDk/k56CpzyDZ/1wk0Dn9I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIluIZJCsIkykr/fiXDKAAlC+BzSW8BN4vgDgu0IXeM49EByKPWFewPDfnu9qqMrnfvxUk6J7RWkZftPOUUUA96+HsNDADOUeNHjkFQcpGLSh7ZmBHhhGk4fl6A8ppriaY1Eil6KXPH6/wtibGt1FF5yvgql6Z3IJaF9eA8v7A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ifE6EVqM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ifE6EVqM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CYbLtkDMy8imrbdEZKVeQ069gtxllANmIxz8jkAWZ9k=; b=ifE6EVqMIqyD2ZcJvi2hCg2rwb
	6sRwDNqKFBJQcrAKABblJfz03TK3WkmfL8LZFegBc9SI9W7dn1OWgiBCRvvdLiugXbGwGC0UYPi1q
	cbFcQuLDstg2O8tTjvPGKvATIQfvPhok1FukpGW0fYr5UsVbEa0o03YBkhQfwMkJEN5gcLRGs/QIv
	K0rzesmsl3TxmXpGdWkjJXe57t+aXm9+vnzAMZIZxnjAFBzQLTSJ2VZzUZHVgYew8vvvdqnxKtLpQ
	x8rxFrcZ4UVfyJKvbJvGplNQIKlRcjFDp2+INI4py1NXFWH5E+LOQvirbKKP4DaQKtLb7DlskI0QS
	HkMPSpBA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tascd-00000008jNl-3Mrn;
	Thu, 23 Jan 2025 08:31:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 60FFB3006E6; Thu, 23 Jan 2025 09:31:31 +0100 (CET)
Date: Thu, 23 Jan 2025 09:31:31 +0100
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
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 29/39] unwind_user/deferred: Add unwind cache
Message-ID: <20250123083131.GE3808@noisy.programming.kicks-ass.net>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <51855c0902486060cd6e1ccc6b22fd092a2e676d.1737511963.git.jpoimboe@kernel.org>
 <20250122135700.GS7145@noisy.programming.kicks-ass.net>
 <20250122223625.aibbrh43pjkzve6c@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122223625.aibbrh43pjkzve6c@jpoimboe>

On Wed, Jan 22, 2025 at 02:36:25PM -0800, Josh Poimboeuf wrote:
> On Wed, Jan 22, 2025 at 02:57:00PM +0100, Peter Zijlstra wrote:
> > On Tue, Jan 21, 2025 at 06:31:21PM -0800, Josh Poimboeuf wrote:
> > > Cache the results of the unwind to ensure the unwind is only performed
> > > once, even when called by multiple tracers.
> > > 
> > > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > > ---
> > >  include/linux/unwind_deferred_types.h |  8 +++++++-
> > >  kernel/unwind/deferred.c              | 26 ++++++++++++++++++++------
> > >  2 files changed, 27 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
> > > index 9749824aea09..6f71a06329fb 100644
> > > --- a/include/linux/unwind_deferred_types.h
> > > +++ b/include/linux/unwind_deferred_types.h
> > > @@ -2,8 +2,14 @@
> > >  #ifndef _LINUX_UNWIND_USER_DEFERRED_TYPES_H
> > >  #define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
> > >  
> > > -struct unwind_task_info {
> > > +struct unwind_cache {
> > >  	unsigned long		*entries;
> > > +	unsigned int		nr_entries;
> > > +	u64			cookie;
> > > +};
> > 
> > If you make the return to user path clear nr_entries you don't need a
> > second cookie field I think.
> 
> But if the NMI happens late in the exit-to-user path, with IRQs
> disabled, right before nr_entries gets cleared, the cache won't get
> used in the task work.
> 
> However I think we can clear it on entry-from-user.

Return to user runs with interrupts disabled, if an NMI hits that, it
will have to set TIF_NOTIFY_RESUME again and queue the IRQ work thing.
That self-IPI will hit the moment we do IRET (which is what re-enables
interrupts) and we're going back into the kernel.

Anyway, I suppose that is a long way of saying that you should be able
to do this on return to user.

But yes, enter-from-user should work too.
