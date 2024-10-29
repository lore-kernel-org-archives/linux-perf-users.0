Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8DD4AEE0;
	Tue, 29 Oct 2024 18:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730226048; cv=none; b=tZotqXLz72mFIuDh8/Xy6Pa/vSk7kXURDNPs00XdzgPwndTBi7T2odL0+JUKvcRIYv3xiGLruHh9Azxp+ATShH0UfLaofbT+9+NnH8uszu5l2LZFu2iXvfuCR5YX46M1xpDXJ4uqNeLlqKeJeOQNjFd8fbfCTGSfudsXbQacT+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730226048; c=relaxed/simple;
	bh=9QlywTxz18eV83YAElNzhD2u1lNwHMuOi09lu9IMPdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IY0ZW2VI88VWLEqYsXybFa2rGzYrAYmK0JaDL8zRi8NnMGizU4di5jh/XdwW3BURlflH5uM5T/wqalzoFFfuXh6KArzwSuivGLERTwEzUU1dOD8c0nMdTvSrihOzc5eLvfvNg7uM/xPl4tdMBs0hAXqaa73FUw4XqjHuWN0Dg60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hbwc2291; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hbwc2291"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UKpn77lFR+sPspRB6+Qubz/7GXsOHdMVp4S3gWsBZ+E=; b=hbwc2291faCHeiGyZybQY9DVqZ
	SA9u9havyq1BZVT9fU+HfJx068/6pwZUvqm5LcQwNH4Fhz84vRN6IBXsy1Za8+uSxZ6uGAuBG4Ych
	L6zCjh0hwjCFFxJBjYBMlFCCX/ZjFPz9PrskQ3J2L+YhbuEbpCTZvQWHUC4tPpt+qwRXugZrk5Bvb
	OP2xMBRVLXY2YCqsfcyY7XhE31aLX09bThQJIi68vsPi9CJUPS73FswQVG5kP/PEi6T2pN6Ilski+
	VwhDF13DRy095GrANBkxuz7gmRdo/RR7iR5JugljiMpGyA7we++HIFIf9O7fWrwye+EB5Eexza7Uu
	soLh77Bg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t5qpV-00000009ylU-06rL;
	Tue, 29 Oct 2024 18:20:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 40B0E30073F; Tue, 29 Oct 2024 19:20:32 +0100 (CET)
Date: Tue, 29 Oct 2024 19:20:32 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
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
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 11/19] unwind: Add deferred user space unwinding API
Message-ID: <20241029182032.GI14555@noisy.programming.kicks-ass.net>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <a94eb70a80c4a13dedb2655b7848304a992cb1b0.1730150953.git.jpoimboe@kernel.org>
 <20241029135617.GB14555@noisy.programming.kicks-ass.net>
 <20241029171752.4y67p3ob24riogpi@treble.attlocal.net>
 <bcd11a07-45fb-442b-a25b-5cadc6aac0e6@efficios.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcd11a07-45fb-442b-a25b-5cadc6aac0e6@efficios.com>

On Tue, Oct 29, 2024 at 01:47:59PM -0400, Mathieu Desnoyers wrote:
> On 2024-10-29 13:17, Josh Poimboeuf wrote:
> > On Tue, Oct 29, 2024 at 02:56:17PM +0100, Peter Zijlstra wrote:
> > > On Mon, Oct 28, 2024 at 02:47:38PM -0700, Josh Poimboeuf wrote:
> > > 
> > > > + * The only exception is when the task has migrated to another CPU, *and* this
> > > > + * is called while the task work is running (or has already run).  Then a new
> > > > + * cookie will be generated and the callback will be called again for the new
> > > > + * cookie.
> > > 
> > > So that's a bit crap. The user stack won't change for having been
> > > migrated.
> > > 
> > > So perf can readily use the full u64 cookie value as a sequence number,
> > > since the whole perf record will already have the TID of the task in.
> > > Mixing in this CPU number for no good reason and causing trouble like
> > > this just doesn't make sense to me.
> > > 
> > > If ftrace needs brain damage like this, can't we push this to the user?
> > > 
> > > That is, do away with the per-cpu sequence crap, and add a per-task
> > > counter that is incremented for every return-to-userspace.
> > 
> > That would definitely make things easier for me, though IIRC Steven and
> > Mathieu had some concerns about TID wrapping over days/months/years.
> > 
> > With that mindset I suppose the per-CPU counter could also wrap, though
> > that could be mitigated by making the cookie a struct with more bits.
> > 
> 
> AFAIR, the scheme we discussed in Prague was different than the
> implementation here.
> 
> We discussed having a free-running counter per-cpu, and combining it
> with the cpu number as top (or low) bits, to effectively make a 64-bit
> value that is unique across the entire system, but without requiring a
> global counter with its associated cache line bouncing.
> 
> Here is part where the implementation here differs from our discussion:
> I recall we discussed keeping a snapshot of the counter value within
> the task struct of the thread. So we only snapshot the per-cpu value
> on first use after entering the kernel, and after that we use the same
> per-cpu value snapshot (from task struct) up until return to userspace.
> We clear the task struct cookie snapshot on return to userspace.
> 
> This way, even if the thread is migrated during the system call, the
> cookie value does not change: it simply depends on the point where it
> was first snapshotted (either before or after migration). From that
> point until return to userspace, we just use the per-thread snapshot
> value.
> 
> This should allow us to keep a global cookie semantic (no need to
> tie this to tracer-specific knowledge about current TID), without the
> migration corner cases discussed in the comment above.

The 48:16 bit split gives you uniqueness for around 78 hours at 1GHz.

But seriously, perf doesn't need this. It really only needs a sequence
number if you care to stitch over a LOST packet (and I can't say I care
about that case much) -- and doing that right doesn't really take much
at all.

