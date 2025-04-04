Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF9F21B9C1
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Apr 2025 18:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743790396; cv=none; b=B4qIoqnM6Q9IJSrB3PlPQbQKrxIj0KPkPiKxeTw1HYxtKVsx+nY6qish64nLgu2Wk5ytj28dWxQNr3tBh0u3OGa93i9iqA+jZfaY8I1Okbvm7PVAuQ0pu0eW9yslpKX9G54411ejCvaEK2p/wWD4fwuBMAb/jsWNytTvlji/5Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743790396; c=relaxed/simple;
	bh=/prELkTDpxmQtL38VMSCaSaIh7899rBH5emBNpMTl/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZQPxKDCbNm77rAQv5FS5hLNyRw8lK5iPBkelylH6fjIlz26XbbAxQintq/jCLLREKHgORv6+BMCH9Ph9vXt5EBxlmxtM8/6ZEm9A0DhjLFboH+6Cg1dTUE36uJM3bmh8hWs7YqP5G4yD3r0NIMeyf76AJQzH01eyEUrs7aQnAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcBEcUXu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcBEcUXu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BF9C4CEE9;
	Fri,  4 Apr 2025 18:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743790395;
	bh=/prELkTDpxmQtL38VMSCaSaIh7899rBH5emBNpMTl/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IcBEcUXu1xm/BmaQGm8Mas3g3whErMVISAeoz2gS+fsMOJS5oWl8coeBRG83m2axB
	 Aywuui6xzmvlgpsSkII0CHXVx4xPeYq38WWwzug3vEKcc3QWvImwr6VPPUk72wkjg5
	 SCfJfd1PtEqYnjMtrSNP928Ss2Vya/qSRNCs1YxKPJ+hCAtEqQDhXejt/pFn3siP+F
	 UsaaGn0KogX0y73nhxKkefZBxB2UReuLVb5YQrP8Du7K7Rxl6ehXIl/KIdvIv5PYsK
	 hm7V6xHggnfK95q8FnFkkWjnHV0YTuZGTOFN+gipRBkjroXc1jrGnbVcYs5fUBV0zz
	 GfNB/c7UN/PIQ==
Date: Fri, 4 Apr 2025 15:13:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [perf top] annotation doesn't work, libunwind doesn't seem to be
 working either
Message-ID: <Z_AhOFo9mpFmT4Pd@x1>
References: <20250307080829.354947-1-namhyung@kernel.org>
 <Z9tjKcKvjYgbR6hb@google.com>
 <Z9vgt1pjiNbDBDbM@gmail.com>
 <Z9w_aFlzOkoCTSqK@google.com>
 <Z-EJnye74la1triY@gmail.com>
 <Z--pWmTHGb62_83e@gmail.com>
 <Z_AWpgne5108xqlc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_AWpgne5108xqlc@google.com>

On Fri, Apr 04, 2025 at 10:28:06AM -0700, Namhyung Kim wrote:
> Hi Ingo,
 
> On Fri, Apr 04, 2025 at 11:41:46AM +0200, Ingo Molnar wrote:
 
> > BTW., here's a few other 'perf' annoyances I have, if anyone's 
> > listening :-)
 
> Thanks for the report.  Glad to hear from you.

Ditto, always a pleasure to get reports from power users, and I don't
mind if its complaints, its feedback, and that is what we need to hear
to fix things and improve the experience.
 
> > 1)
 
> > I cannot get the libunwind build-feature failure to go away:
 
> > ...                               libcrypto: [ on  ]
> > ...                               libunwind: [ OFF ]
> > ...                             libcapstone: [ on  ]
> > ...                               llvm-perf: [ on  ]
 
> > I do have libunwind-dev installed:
 
> > ii  libunwind-dev:amd64                                         1.6.2-3.1                                           amd64        library to determine the call-chain of a program - development
> > ii  libunwind8:amd64                                            1.6.2-3.1                                           amd64        library to determine the call-chain of a program - runtime
 
> > but it fails to link:
 
> >  kepler:~/tip/tools/build/feature> cat test-libunwind.make.output
> >  /usr/bin/ld: /tmp/cc2BfaNM.o: in function `main':
> >  test-libunwind.c:(.text+0x1c): undefined reference to `_Ux86_64_create_addr_space'
> >  /usr/bin/ld: test-libunwind.c:(.text+0x44): undefined reference to `_Ux86_64_init_remote'
> >  /usr/bin/ld: test-libunwind.c:(.text+0x6b): undefined reference to `_Ux86_64_dwarf_search_unwind_table'
> >  collect2: error: ld returned 1 exit status
 
> > I tried to install the libunwind-19-dev package, I tried to 
> > uninstall/reinstall - no combination seems to work.
 
> > perf is also totally unhelpful about resolving such issues - it used to 
> > issue tips about what packages to install, but those tips are not 
> > present anymore, for this one at least.
 
> Since v6.13, we switched to disable libunwind by default and used
> unwinding in libdw.
 
> commit 13e17c9ff491 ("perf build: Make libunwind opt-in rather than opt-out")
 
> You need to pass LIBUNWIND=1 to build with it.

But we should have that spelled out in the output of the build where it
appears marked as not being enabled even with the usual devel libraries
being available.

Its back to change in behaviour that is not clearly marked in the tool
output.
 
> > 2)
 
> > More annoyingly, I cannot get source code annotation of the kernel to 
> > work - this might be related to the libunwind build failure (or not).
 
> I don't think it's related.  Anyway do you see the same for user
> binaries or is it only for the kernel?

Also now we have multiple ways of doing that feature, perhaps there is a
bug in enabling it, that is in this description:

https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a6e8a58de6294578195447596fb975a9027b4d2c

I'm checking...
 
> > Within 'perf top' I go into a function, and I press 's', which is 
> > supposed to toggle the source code annotation ... but nothing happens.

> > 'nothing happens' is perhaps the most passive-aggressive reaction a 
> > tool can give to a user. I'd prefer a *crash* to ignoring the keypress 
> > ...

> Oh ok.  I prefer a warning. :)

Agreed.
 
> > There's no error printed anywhere - just the color of the hexadecimal 
> > labels changes, nothing else.
 
> > 'perf top' won't annotate kernel functions (despite me having a 
> > DEBUGINFO kernel package installed and booted), nor will it even 
> > annotate its own functions within 'perf', in a similar fashion.
 
> I see.  So the problem is not specific to the kernel.

I didn't see it in my tests, but I've been away, travelling, will check,
this should be caught by CI systems using 'perf test'.
 
> > It's similar for 'perf report' too, although that's not a surprise, 
> > they share much of the codebase.
 
> Yep, of course.
 
> > 'perf annotate --stdio' only shows an objdump --disassemble style 
> > output, but without any source annotations either.

> > This is a rather frustrating user experience. :-/
 
> Sorry about that.  I suspect that I made a mistake when I was working on
> the data type profiling.  I'll take a look.

We need to continue improving the 'perf test' infrastructure and get
help from people doing CI, perf has way too many features and
dependencies, we need to continue testing what is great and pruning
dependencies that drag us down while not helping with features used by
most people.

- Arnaldo
