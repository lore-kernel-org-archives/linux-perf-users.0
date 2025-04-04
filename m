Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C433188580
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Apr 2025 17:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743787689; cv=none; b=qWwOXuLDjcrfUihEedQrd+5+T8qLMwh1NsStAWBvcrW2ebrhxlab0BCS4J+oKE2/jPnOagFdoBmyiSXmbF4Dh1YR6UAvjBTbgBgMu5zyGDSjbbrsDERW98Xf3HhqziZCsJ3vON9QIVTJtQDTL/W9zMwXbezIzc7j+BmbD1Pa9so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743787689; c=relaxed/simple;
	bh=ST0EDhO0Qxg5UJPiqj4Kwgm3MZyl8QtUrH5NxGholfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JejK4nbz/PpnxljItxxMIvkBTn9PPsVvWkuNjuLssba1/O/vdwOa1zyVxCcUw2k4QzpPgPTsnoAMuPmSqY1nxYiZa06BUCAzN4VSqE69vbyNozSqMYdnpp1eAnqHSiETnmu3GJFWO8XPKDEX5oi3YdmuOjUNPjLdgI1Jizz1vnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPfmalgz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPfmalgz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A52C4CEE8;
	Fri,  4 Apr 2025 17:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743787688;
	bh=ST0EDhO0Qxg5UJPiqj4Kwgm3MZyl8QtUrH5NxGholfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hPfmalgzpSZou3vvhOgI4n8vPfbJk7FZcVbBmbfQ2jX29oXbmhr8BRq7JBK6xCNML
	 AqXI6BrC2zX4Cq6KHiIcJLIS+4aBAMArdtT9wMVh4cWqFIY4PK93Ar1k+r4ESt4sYu
	 snTaCI7rjfaJCx6/LLZKpze4TTRSRoY6CTxHLpOpXuvmv6hy0OADs2Pcy6X+S1zpEg
	 wKp3tZSmdjIKqc5H2YPe0Pcm8XZ9MRQWhzfNxIdq3kZcKDem8U72vMVdw0PDjYLGca
	 Nr/cAVw/J9kR5wgjxlH9jaQy75vVdP5CGIoOHUjLZXlGmWgHYVvulk1iSU3i2iG7fq
	 959m8CATrcvXQ==
Date: Fri, 4 Apr 2025 10:28:06 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [perf top] annotation doesn't work, libunwind doesn't seem to be
 working either
Message-ID: <Z_AWpgne5108xqlc@google.com>
References: <20250307080829.354947-1-namhyung@kernel.org>
 <Z9tjKcKvjYgbR6hb@google.com>
 <Z9vgt1pjiNbDBDbM@gmail.com>
 <Z9w_aFlzOkoCTSqK@google.com>
 <Z-EJnye74la1triY@gmail.com>
 <Z--pWmTHGb62_83e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z--pWmTHGb62_83e@gmail.com>

Hi Ingo,

On Fri, Apr 04, 2025 at 11:41:46AM +0200, Ingo Molnar wrote:
> 
> BTW., here's a few other 'perf' annoyances I have, if anyone's 
> listening :-)

Thanks for the report.  Glad to hear from you.

> 
> 
> 1)
> 
> I cannot get the libunwind build-feature failure to go away:
> 
> ...                               libcrypto: [ on  ]
> ...                               libunwind: [ OFF ]
> ...                             libcapstone: [ on  ]
> ...                               llvm-perf: [ on  ]
> 
> I do have libunwind-dev installed:
> 
> ii  libunwind-dev:amd64                                         1.6.2-3.1                                           amd64        library to determine the call-chain of a program - development
> ii  libunwind8:amd64                                            1.6.2-3.1                                           amd64        library to determine the call-chain of a program - runtime
> 
> but it fails to link:
> 
>  kepler:~/tip/tools/build/feature> cat test-libunwind.make.output
>  /usr/bin/ld: /tmp/cc2BfaNM.o: in function `main':
>  test-libunwind.c:(.text+0x1c): undefined reference to `_Ux86_64_create_addr_space'
>  /usr/bin/ld: test-libunwind.c:(.text+0x44): undefined reference to `_Ux86_64_init_remote'
>  /usr/bin/ld: test-libunwind.c:(.text+0x6b): undefined reference to `_Ux86_64_dwarf_search_unwind_table'
>  collect2: error: ld returned 1 exit status
> 
> I tried to install the libunwind-19-dev package, I tried to 
> uninstall/reinstall - no combination seems to work.
> 
> perf is also totally unhelpful about resolving such issues - it used to 
> issue tips about what packages to install, but those tips are not 
> present anymore, for this one at least.

Since v6.13, we switched to disable libunwind by default and used
unwinding in libdw.

commit 13e17c9ff491 ("perf build: Make libunwind opt-in rather than opt-out")

You need to pass LIBUNWIND=1 to build with it.

> 
> 2)
> 
> More annoyingly, I cannot get source code annotation of the kernel to 
> work - this might be related to the libunwind build failure (or not).

I don't think it's related.  Anyway do you see the same for user
binaries or is it only for the kernel?

> 
> Within 'perf top' I go into a function, and I press 's', which is 
> supposed to toggle the source code annotation ... but nothing happens.
> 
> 'nothing happens' is perhaps the most passive-aggressive reaction a 
> tool can give to a user. I'd prefer a *crash* to ignoring the keypress 
> ...

Oh ok.  I prefer a warning. :)

> 
> There's no error printed anywhere - just the color of the hexadecimal 
> labels changes, nothing else.
> 
> 'perf top' won't annotate kernel functions (despite me having a 
> DEBUGINFO kernel package installed and booted), nor will it even 
> annotate its own functions within 'perf', in a similar fashion.

I see.  So the problem is not specific to the kernel.

> 
> It's similar for 'perf report' too, although that's not a surprise, 
> they share much of the codebase.

Yep, of course.

> 
> 'perf annotate --stdio' only shows an objdump --disassemble style 
> output, but without any source annotations either.
> 
> This is a rather frustrating user experience. :-/

Sorry about that.  I suspect that I made a mistake when I was working on
the data type profiling.  I'll take a look.

Thanks,
Namhyung

