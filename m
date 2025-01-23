Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E731BD504;
	Thu, 23 Jan 2025 08:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737620252; cv=none; b=Kz3dbzXzQHUTkqkl9thJ+PEIn4PM5FWHgnDfJrcdGMlRLffpUZDdnqjJXqJNXSJ46INRFD0BMqskYHbR11gGpD6REf9d6PrBToJwzJKDA6ozgIsBItLm+ArPdTq2AeS6AFDCU6Qr89uNKIhjvKMCyMTSgODtvLlTgoZ9/SJf5Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737620252; c=relaxed/simple;
	bh=qI191ymjryCtEv09F06Gf9AAn7G59mLklPu/1nDbbks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVddJsjJZ+f7rpdhstuR1LHzOv17puF6B/7iV64DdiiqO/U7Oxc6JZXayDw/cmYWCGjfxZQR+X++wlDR+JZpYo9gb4PycnHwW78GUQL8yuy0UWrU8b56JUnZT+TR+OxzoLQcc9ZxIH+vF5z4DpkezdgecnBE9GNvJ/NFgxTjYJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Q5sN3eAA; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q5sN3eAA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1xeCQ7zxwSGxJj48FkflY7aPerKY9bGqRlZGIvphrZ0=; b=Q5sN3eAAKPkjeTReJChgRVcu/b
	BMYKNa7vpujQVErLBt0PTDJw0rbGSsenjZHauc1VhVOgvpINO3X85IOUXUmQMRBm+xt6SQtkHJeMi
	I2OUO8xqJYZn5mUB6iJLGKHrhKiXUk5lcOhDtjeSGFoY2gunloZDwAfKy8U+FGeg4sYjXEuHWYVpI
	mHNSfYGDlK7f2gsAckHDXLoy+h2D5bAl+Ak7BHxXpcJ/OWD9BBJnXub2OWwuBKO8ogpIYMH0eVhG3
	04VEjXTgGgj1g+XM/dqOOEYCAngNONm28mXVm7UZ2dAc1894gLI8GFsqmBqFIQOzqR0zKcSX6TpTX
	63WY/jxw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tasOt-0000000Dkt0-1hQf;
	Thu, 23 Jan 2025 08:17:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EF5E13006E6; Thu, 23 Jan 2025 09:17:18 +0100 (CET)
Date: Thu, 23 Jan 2025 09:17:18 +0100
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
Message-ID: <20250123081718.GC3808@noisy.programming.kicks-ass.net>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <6052e8487746603bdb29b65f4033e739092d9925.1737511963.git.jpoimboe@kernel.org>
 <20250122133730.GQ7145@noisy.programming.kicks-ass.net>
 <20250122141616.GU7145@noisy.programming.kicks-ass.net>
 <20250122225127.qhxmqamg7pnugnya@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122225127.qhxmqamg7pnugnya@jpoimboe>

On Wed, Jan 22, 2025 at 02:51:27PM -0800, Josh Poimboeuf wrote:
> On Wed, Jan 22, 2025 at 03:16:16PM +0100, Peter Zijlstra wrote:
> > On Wed, Jan 22, 2025 at 02:37:30PM +0100, Peter Zijlstra wrote:
> > > On Tue, Jan 21, 2025 at 06:31:20PM -0800, Josh Poimboeuf wrote:
> > > > +/*
> > > > + * The context cookie is a unique identifier which allows post-processing to
> > > > + * correlate kernel trace(s) with user unwinds.  The high 12 bits are the CPU
> > > 
> > > s/12/16/ ?
> > > 
> > > > + * id; the lower 48 bits are a per-CPU entry counter.
> > > > + */
> > > > +static u64 ctx_to_cookie(u64 cpu, u64 ctx)
> > > > +{
> > > > +	BUILD_BUG_ON(NR_CPUS > 65535);
> > > > +	return (ctx & ((1UL << 48) - 1)) | (cpu << 48);
> > > > +}
> > 
> > Also, I have to note that 0 is a valid return value here, which will
> > give a ton of fun.
> 
> The ctx_ctr is always incremented before calling this, so 0 isn't a
> valid cookie.

Right, so that's the problem. You're considering 0 an invalid cookie,
but ctx_to_cookie(0, 1<<48) will be a 0 cookie.

That thing *will* wrap.
