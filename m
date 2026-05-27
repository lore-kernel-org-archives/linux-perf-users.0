Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1B32D3EEB;
	Wed, 27 May 2026 05:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779859383; cv=none; b=PnG2zvNbTEqQl0XHA3DqOp18ZfNySqkEneDANZZSfVXeAHYvhpY5pGIyNDdbkkMJru6jj8Pp3TkdVIik2FeuNX0gGQoHUdK1g40nZ8Q8B+FSUAl3jb1BDrPpD82wBqJei4r5NfQcNbODp/9j6ap8VJ4Cg3z8vRHLWOpBO+i7QIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779859383; c=relaxed/simple;
	bh=oLeOZoKtbgVvPpct5Nfmac1WqVX6VF6XbNN68DdO/wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5V1Q0YwDWOCGH/iocxY5fzVfkkHCe/05y6r66Ghl/dU+I9CYRAnhRaX/jqyU/yPMoAPJ38KiRucfy3/Kik66BabDUYBubfa+Aw20QCT4SGB9Vu0RdmMxef2MEomgG6bk8A0mlBoibevTvMUR47gWNT7pAqhUre54Qsyzn8Ecao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTYKE0kE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTYKE0kE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AE21F000E9;
	Wed, 27 May 2026 05:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779859382;
	bh=Bm3s4ePDaenze67k2mji9CpBs36IDLFInYw3LIfuKEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZTYKE0kEuk7ZGMiTasUgn0ft4NtSZK9fxHEgJSgWLF82+3q5EUaH70DobkLPKNQoD
	 3oAuRoz9GlozGjLJBk7+m7h1OXQvFK++1ecw53qdhqJG4fGLotuAdTg7qO10UqmHKT
	 yiHgXySAQO7V+rizZcW0/2sU6DWQNpEgJjP3v3JKGRU3FTYBTJBNTGexXM2dcnokiA
	 fiYPu8Fg/yy0wmhSdy7US0zuQRK477FvGxiDnXWfaELeKNApdkVVz3yU1m9Q9GWzez
	 wFQ/8l6ZUQbO5eXJT2m/BDYd9e6CiyB3KQKS6Rl8Pt+53YljLzAGZOc+LRnf44SoYV
	 NoIih+mN8U+lA==
Date: Tue, 26 May 2026 22:22:58 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2] perf bench: add --write-size option to sched pipe
Message-ID: <ahZ_sr1bzkoul_tq@google.com>
References: <20260521-perf_bench_pipe-v2-1-720b6ff7f0fa@debian.org>
 <ahUCyRwNPKV1VAZ8@google.com>
 <ahXWIrGvsC3_gIkC@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahXWIrGvsC3_gIkC@gmail.com>

On Tue, May 26, 2026 at 06:55:33PM +0100, Breno Leitao wrote:
> hello Namhyung,
> 
> On Mon, May 25, 2026 at 09:17:45PM +0000, Namhyung Kim wrote:
> > On Thu, May 21, 2026 at 09:15:37AM -0700, Breno Leitao wrote:
> > > +		ret = write(td->pipe_write, td->buf, write_size);
> > > +		BUG_ON(ret < 0 || (unsigned int)ret != write_size);
> > >  		ret = read_pipe(td);
> > > -		BUG_ON(ret != sizeof(int));
> > > +		BUG_ON(ret < 0 || (unsigned int)ret != write_size);
> > 
> > Is it possible to return smaller values than required due to signal or
> > something?
> 
> I tested this on a VM with the patch applied, running the ping-pong with
> write_size from 4 B up to 1 MiB, including multi-process and single-CPU
> contention runs (millions of iterations). I observed zero short reads or short
> writes.
> 
> Looking at fs/pipe.c, this matches the kernel behavior for this access pattern:
> the bench has a single writer per pipe and the pipe capacity is set to
> write_size, so the writer never has to sleep mid-write, and the kernel does a
> sync wake of the reader only after the full payload is queued.
> 
> EINTR is also not reachable today because the bench installs no signal
> handlers and nothing in the call chain delivers signals to the workers
> 
> At the same time, I understand the concern and If you'd still prefer defensive
> handling (short-return loop + EINTR retry) I can add it in v3 — happy to either
> way.

Thanks for looking into it.  I think it's better to go defensive for any
unexpected behavior or changes.

Thanks,
Namhyung

