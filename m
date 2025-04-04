Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02A21ACEAF
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Apr 2025 09:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743759711; cv=none; b=hB/jAqyf/y4LNlhY40RYB88z83Ca+6Z319gNsP5wQAIj+EAor3UX8uu0ALjrirWa4TqDGe/DEpC78LsiunSFV2SynrBp+ut0s0EBIiqFLksbW/GObDFTcXyfoALkYf5h5bc4k2NNIRXu1HR7jIhn7S7AMtcoPNw4fKVrOPhALBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743759711; c=relaxed/simple;
	bh=WSaKWPVykFgAN579KG6427N+YbW9Z75CnLnQrCQHyYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHjL0WpW6cz6ECSdwxZ6GrlEab2xphi4VtrOCa4j2yIYW+8RXBs/ZXZamaeHbyoKQEzWD9JwiUbbcXLzhTP6oe5Cofc0GyzAQFaRnTnXX41PmEFBqRjXEEnldKSu7MDOi0h1WH6BhZfZsFM0zNnY7h3O9gYVUrWksw1qxj5OIB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4tKG5vc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4tKG5vc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF147C4CEE5;
	Fri,  4 Apr 2025 09:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743759711;
	bh=WSaKWPVykFgAN579KG6427N+YbW9Z75CnLnQrCQHyYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q4tKG5vcQXx2f/VFNEBZisLanO+iBcOdK3naFzM1I+qZzFEKOHHO5DAfvd8LY8xui
	 b2ruBGFt7xFxVgOJ0nI7plpTiItPVoppVoLnCQLrqGYC5efJ7vn/daE7VyTaqjRk1A
	 9uoTqU5V65G1S/DBgZoaqFei/qioAo6FMmsVE6lOObBGG1648teIIgtFfwXRL1w/QE
	 dNQUMq4bY/eQtaFwo+fvNsoU0bKGTx1BlcyhxwKNRtlnhR5ht8GNDheA71bP/W0HGu
	 Cew6u7kDHOenVu5aBYJHcgMTZetZS0VQp8PpYpk+m3hU4AEQYy6PHoazPOYEEl9qW9
	 rSUMAl2emXUDg==
Date: Fri, 4 Apr 2025 11:41:46 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: [perf top] annotation doesn't work, libunwind doesn't seem to be
 working either
Message-ID: <Z--pWmTHGb62_83e@gmail.com>
References: <20250307080829.354947-1-namhyung@kernel.org>
 <Z9tjKcKvjYgbR6hb@google.com>
 <Z9vgt1pjiNbDBDbM@gmail.com>
 <Z9w_aFlzOkoCTSqK@google.com>
 <Z-EJnye74la1triY@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-EJnye74la1triY@gmail.com>


BTW., here's a few other 'perf' annoyances I have, if anyone's 
listening :-)


1)

I cannot get the libunwind build-feature failure to go away:

...                               libcrypto: [ on  ]
...                               libunwind: [ OFF ]
...                             libcapstone: [ on  ]
...                               llvm-perf: [ on  ]

I do have libunwind-dev installed:

ii  libunwind-dev:amd64                                         1.6.2-3.1                                           amd64        library to determine the call-chain of a program - development
ii  libunwind8:amd64                                            1.6.2-3.1                                           amd64        library to determine the call-chain of a program - runtime

but it fails to link:

 kepler:~/tip/tools/build/feature> cat test-libunwind.make.output
 /usr/bin/ld: /tmp/cc2BfaNM.o: in function `main':
 test-libunwind.c:(.text+0x1c): undefined reference to `_Ux86_64_create_addr_space'
 /usr/bin/ld: test-libunwind.c:(.text+0x44): undefined reference to `_Ux86_64_init_remote'
 /usr/bin/ld: test-libunwind.c:(.text+0x6b): undefined reference to `_Ux86_64_dwarf_search_unwind_table'
 collect2: error: ld returned 1 exit status

I tried to install the libunwind-19-dev package, I tried to 
uninstall/reinstall - no combination seems to work.

perf is also totally unhelpful about resolving such issues - it used to 
issue tips about what packages to install, but those tips are not 
present anymore, for this one at least.

2)

More annoyingly, I cannot get source code annotation of the kernel to 
work - this might be related to the libunwind build failure (or not).

Within 'perf top' I go into a function, and I press 's', which is 
supposed to toggle the source code annotation ... but nothing happens.

'nothing happens' is perhaps the most passive-aggressive reaction a 
tool can give to a user. I'd prefer a *crash* to ignoring the keypress 
...

There's no error printed anywhere - just the color of the hexadecimal 
labels changes, nothing else.

'perf top' won't annotate kernel functions (despite me having a 
DEBUGINFO kernel package installed and booted), nor will it even 
annotate its own functions within 'perf', in a similar fashion.

It's similar for 'perf report' too, although that's not a surprise, 
they share much of the codebase.

'perf annotate --stdio' only shows an objdump --disassemble style 
output, but without any source annotations either.

This is a rather frustrating user experience. :-/

Thanks,

	Ingo
