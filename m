Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB9D577E4E;
	Wed,  9 Sep 2026 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963303; cv=none; b=OZHywotCy+ctNIEYIwDNAhNbvy1a7pTLKDflzbp6fZFzdruDpyM4GSiq52C73kK25izT5KyKVoAxnKphZxJQPG5/MgmNvan6XoGdu/yGhvLrqykhkShypSJZFO7Nz24bQpT+HMrJ8Wa37/oUX5ayfKRK3pTPGB00zy9WQMpi6P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963303; c=relaxed/simple;
	bh=XRII96xTVW3zFT9oYMBI25SY9w8xHd6efZetmEu2H1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgCjmnnJKaVfBYjr+HVr5rZv7kvMrsJzogtU+OHE8hCBX4KYwetIhrJT9ikbnUo+ZWbtbOoXgPYYLaL7InYp9K4eKsGH/YT4IKcHeMW30JpS4gwTCGOD+TGOrR6o36hRdkLMN+IQO//Ul3rGaTco/va2c3wtP3UavUiSV3Q0u2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvletEha; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvletEha"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792551F00A3A;
	Wed,  9 Sep 2026 14:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963301;
	bh=/OniCvkCuZhep7Dm5VZzuIT7ePpQGUA0n6SAlx9Bc8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VvletEhaFCak6ywKLnRFrGMJ7b8MMyP8MmrTP4XG8MKFdtZi82kxWxr/syaGLcGE7
	 Ql5FfgHegVuBGGKhOP5b6L6AskrJRO2K2AuWZSbk0lkozm4lzUb7oWpvLuTsFL0xa4
	 ra+RKJkTgdCsur0k6gzEzy8RGza5rjBUzRTfXlyeHdyPXoke3FYxrY5X1i9t0Qk1W4
	 vD+rKZve6yVmCZa0yHLbxffb/gh/twU5dfvJ9QKOAgPzTRsVofwgKI2OEV+dx+tVDg
	 bt7nwM8agbFn8F8iQHr+ubcbZzrmzKw/G+ZpXNsGvBtYUEmkBpOl1Sy8F1k9pT5RDg
	 OPObMoM97btcQ==
Date: Wed, 9 Sep 2026 10:14:58 -0400
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>,
	"Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Message-ID: <aqFp4oa7o2JxZAMi@google.com>
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

Hello,

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
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/unwind-libdw.c?h=perf-tools-next#n270
> and on x86 we sample all registers for DWARF unwinding:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/arch/x86/include/perf_regs.h?h=perf-tools-next#n20
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/perf-regs-arch/perf_regs_x86.c?h=perf-tools-next#n238
> 
> Having PERF_SAMPLE_IP be precise and the user registers from the
> interrupt I believe works for AMD IBS and ARM SPE, but for Intel PEBS
> there is the ability to use the PEBS register samples for other
> non-redundant registers. In the x86 driver could we disable PEBS
> sampling for these registers when doing user stack sampling, so that
> the sampled user registers match the stack sample? We can keep the
> PERF_SAMPLE_IP precise, and make all the registers precise when there
> is no stack sampling.

+1.

I think it's better to keep PERF_SAMPLE_IP precise as requested and pick
appropriate registers based on PERF_SAMPLE_USER_STACK.

Thanks,
Namhyung

