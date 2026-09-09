Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011DE4766BF;
	Wed,  9 Sep 2026 08:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788941483; cv=none; b=NP/PN5sGf/+8N2hi0bcxWZIjLLZ44rKK7a3EJERhVFnnK3rehwbYdMq5AqEBgLbOc+ZnYFD7UMXJ3u0Elzt3/TmsxE/vrh05Xju+8BctBrcNSh8uzohbdzZos+lf1/notkJXMkbbEQptyuJpj266xsSaSEZStJc1r/QeuoU4xqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788941483; c=relaxed/simple;
	bh=YF6FUyNL8hVQ+dIR8Zrr5vQjbpWebhdEiRG7jyN1SSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5GncbdPH30AltOk8HRDvd7CmMzE8Ca9X6vOCVQV6psjbhIP0yL1hF1WtgHEQRrhtVKXDYUuFHQkpwpNlSFijszhWS6qIIY3FEf1iVMSu7bA1JLLS/ZXGmrvNT7RP511NW22rC7D7YEASglRYtFr11KGrScBLU2qLutoVjnp77w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kQhywArT; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kQhywArT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=eHB0Nf1xfgtREpHnA9gnjy2hVoSWAV9y7zVXfbdUlQc=; b=kQhywArTNsTHVDFQQTi8u05Ckj
	8dQXL929MmJce4OG/G9A+LiNgrF2Ix92v81HpGpARRoHuNifKJkMp88Pg/0nHk33m3jSWGhDPH4Q5
	rw3OEV2/LAB112uzEXUXBlg+FAK3+eno49EY1eFthAThzTnfV9a53gqsM8tFo2O5C8wgJSu+zYOgv
	Myz4EeLCn+WONbdcEG7nW0vgSt4mIDadfQBl6pvqF+pMpKFMqBA5GyQGxHUvMZfDI7S7spHCt0sEN
	WH7HJWyDwF/SL9D7SQ7VGPcX31fPKXMaORizCA+Xq7PdsUc4ejiqULRcBOLRX73KnTJVS9EBAOv3e
	adyVdObQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x4DOZ-00000000tIe-2xhe;
	Wed, 09 Sep 2026 08:11:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C40CD30036F; Wed, 09 Sep 2026 10:11:01 +0200 (CEST)
Date: Wed, 9 Sep 2026 10:11:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ian Rogers <irogers@google.com>
Cc: Andi Kleen <ak@linux.intel.com>,
	"Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Gennady Kupava <gennady.kupava@gmail.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH 2/2] perf/x86: Disable precise sampling for
 PERF_SAMPLE_STACK_USER
Message-ID: <20260909081101.GS4121339@noisy.programming.kicks-ass.net>
References: <20260908075102.540715-1-dapeng1.mi@linux.intel.com>
 <20260908075102.540715-2-dapeng1.mi@linux.intel.com>
 <20260908084906.GO4121339@noisy.programming.kicks-ass.net>
 <1691a05c-49a6-4b16-8bad-cb3c004ed07c@linux.intel.com>
 <20260908101914.GQ4121339@noisy.programming.kicks-ass.net>
 <aqAlddsFPYJvRhFr@tassilo>
 <CAP-5=fWbSNYpt8p3e+pqjY+xhqs8WrzsBfPaKB1NLBm88mH8Yg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWbSNYpt8p3e+pqjY+xhqs8WrzsBfPaKB1NLBm88mH8Yg@mail.gmail.com>

On Tue, Sep 08, 2026 at 01:56:56PM -0700, Ian Rogers wrote:
> On Tue, Sep 8, 2026 at 8:10 AM Andi Kleen <ak@linux.intel.com> wrote:
> >
> > > That's what we already do, no? I have distinct memories of making the
> > > stack unwind use the NMI regs rather then the PEBS regs.
> > >
> > > > In my opinion, it could even make the thing worse. User
> > > > requires to get precise samplings, but perf silently returns imprecise
> > > > records, this would mislead user.
> > >
> > > Mostly just the unwind might be off a little, the rest is accurate. This
> > > has been the case 'forever'. Performance analysis isn't for silly
> > > people, if they can't deal with a little fuzz then perhaps they're in
> > > the wrong business.
> >
> > Is the main problem that the stack doesn't agree? Perhaps there
> > could be a check for regs->rsp == pebs->user rsp (if in user space)
> > to detect problematic samples.
> >
> > The question is how to report it and who should do the checking.
> >
> > It may need new fields in the ABI either to communicate the extra PEBS RSP
> > or a bit to indicate that there might be a mismatch.
> >
> > I guess checking in the kernel and reporting an error might be simpler
> > and maybe cleaner, but it would likely limit more advanced recovery
> > possibilities.
> >
> > Are there other mismatches that break the unwinding? Perhaps the same
> > for RBP?
> 
> For DWARF unwinding any register may be the source of a frame pointer
> (e.g. the OpenSSL library would use R11 rather than RBP).
> 
> There is redundancy on x86 you can sample the PERF_REG_X86_IP register
> in the user register and there is PERF_SAMPLE_IP in the sample event
> itself.
> 
> My understanding is that IBS can only sample IP and so for precise
> samples we can use PERF_SAMPLE_IP as the precise location and the user
> register PERF_REG_X86_IP as the interrupt IP - this would match the
> other register values in the interrupt.
> 
> In DWARF unwinding, we initialize the register state using the sampled
> user registers:

Oh, I had trouble reading yesterday :/ This is about USER_STACK, not
CALLCHAIN.

I think we should try very hard to not use USER_STACK, it is an
abomination. Instead we really should improve CALLCHAIN to be more
useful. There are a pile of patches for kernel based unwinders,
including for .eh_frame (if only I had time to actually go look at
them).

And we should probably look at doing a shadow stack based unwinder as
well.

This USER_STACK is really the absolute worst possible option. And
perhaps refusing PEBS+USER_STACK makes sense.
