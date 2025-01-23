Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307051ADC62;
	Thu, 23 Jan 2025 21:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737669505; cv=none; b=qe1vi83XaD02vwynqCwEh7ofSTTBxpFo/G6pFti/4xBELYJi4TPd4oHo7zYJbnstm0xJtXr2Xid+UAhzhnJ83AsQlu57pN3IGGRFMe7RF3JKV6+gLHb2CcQZG7uZXw+dTu7lhDEXxi/MD/s7p099Ol3PjH8hIgQcShD9FVUL8Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737669505; c=relaxed/simple;
	bh=9rcbE/tWYx4kR1XtsKMPoeF25ePGaY1BnaIUIBuqQ7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKMgTHVQ8k4PvxaGK3EdT0AFu1WQhtCxrZ8kGhEHm+2c+ONmWNEDcmLWPkoRJuvFlD/7hGEvzR8iahmnzl427Dvwva8v9Kcg9h12qMn99yPdlgB9n842D250q7xLXybycJyKxiD+xRQSlBqStZyEzvgCvdwaWI3cu/IgIePFAWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mo2EBC+U; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mo2EBC+U"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=A1EUQwEK7MhhTZh75brMkm+Qa6CkxTUSPyD4hyyealM=; b=mo2EBC+UmMcR4kB37B3laxOgR4
	SUPokGDHhmyjBalpwTl/AK0WIAnZBeFicrMQXomW05hSUZuR0UJM6H/JtMXypQY61alP23/KegON8
	nlfG4JEE9sytFrtTvX2UU2vtzsDIbzlbaVdWK1acfLAlW6HNHvKcyR5LrKIKDDUoHYqQJm/4cFDdp
	VUdV/6qp0/y6PozZ7Y/70x/e6f/tB+Y8Nd5aUDtiuJjP65ubFCFWd6R/NTSnOKH2bOv8vN15ZNl+/
	3ijNSrsUHYZFMdzwbzG3X08B5NbBPvJ3gSmUIFMPPGXFH3UJARFmI9HiYStEXyOKYCPzWzHPeX+b2
	X4oVKzzQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tb5DD-0000000B5kK-115y;
	Thu, 23 Jan 2025 21:58:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CAB913006E6; Thu, 23 Jan 2025 22:58:06 +0100 (CET)
Date: Thu, 23 Jan 2025 22:58:06 +0100
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
Subject: Re: [PATCH v4 28/39] unwind_user/deferred: Add deferred unwinding
 interface
Message-ID: <20250123215806.GC969@noisy.programming.kicks-ass.net>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <6052e8487746603bdb29b65f4033e739092d9925.1737511963.git.jpoimboe@kernel.org>
 <20250122133730.GQ7145@noisy.programming.kicks-ass.net>
 <20250122141616.GU7145@noisy.programming.kicks-ass.net>
 <20250122225127.qhxmqamg7pnugnya@jpoimboe>
 <20250123081718.GC3808@noisy.programming.kicks-ass.net>
 <20250123183056.rnl4nbihml6pxx2n@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123183056.rnl4nbihml6pxx2n@jpoimboe>

On Thu, Jan 23, 2025 at 10:30:56AM -0800, Josh Poimboeuf wrote:
> On Thu, Jan 23, 2025 at 09:17:18AM +0100, Peter Zijlstra wrote:
> > On Wed, Jan 22, 2025 at 02:51:27PM -0800, Josh Poimboeuf wrote:
> > > On Wed, Jan 22, 2025 at 03:16:16PM +0100, Peter Zijlstra wrote:
> > > The ctx_ctr is always incremented before calling this, so 0 isn't a
> > > valid cookie.
> > 
> > Right, so that's the problem. You're considering 0 an invalid cookie,
> > but ctx_to_cookie(0, 1<<48) will be a 0 cookie.
> > 
> > That thing *will* wrap.
> 
> Well, yes, after N years of sustained very high syscall activity on CPU
> 0, with stack tracing enabled, in which multiple tracer unwind requests
> happen to occur in the same entry context where ctx_ctr wrapped, one of
> the tracers might get an invalid cookie.
> 
> I can double-increment the counter when it's (1UL << 48) - 1).  Or use
> some other bit for "cookie valid".

Right, steal one bit from counter and make it always 1. 47 bit wrap
around should be fine.
