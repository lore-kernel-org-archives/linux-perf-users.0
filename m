Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97D81494A6
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Apr 2025 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743791163; cv=none; b=Nsq5u+GdMeI0ZnQHVZXVxyePHO8kamczaL7p3cGHV7uoqO/7WLD2qsP06G4p268CzN2OkiMlAIk+F67IAQ4XYKft1frjrzINUu2i8yf8HysrPaTPMVY3G6VvmAnO8Qbsf1q9GQS//QZM0PwpX0rf94hMajFcylxI6BiEQzVkeX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743791163; c=relaxed/simple;
	bh=Y2uxeTzBMmgRDGnP0Di5XrlP/dGHSDLyCP9iUWzFNXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7I/xlud67PL7tvcXIGL9Tbv2GrdvjYKikcMslLtquIvWUsR6tix2QgMShDR9am0/WrjB2lY+YAKu+1UvsL4Cq6NknHDoJmbsriLx34CFAZoS2aYUBI+DYb3tHzMeVNH1sGGI6Njt3nTnlUmIMCiWh+qHBoCHGXEP4x0oeYiwJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XItw80hX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XItw80hX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A450CC4CEDD;
	Fri,  4 Apr 2025 18:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743791163;
	bh=Y2uxeTzBMmgRDGnP0Di5XrlP/dGHSDLyCP9iUWzFNXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XItw80hXHeBTuFvEJX7+QJLHpLsiI2C4/rgV0We3Rm1Q5DFWdRYGhFZCuHZFnTtUM
	 fWIfzMFkqIm0y+79hTHrwCJHPgFCZHOJlEHemq7URJeEakAOb7UX7QaCS8DV5jqGW6
	 E9nwhX9H47o/4u+L+Kd+dEbJWziObvvH2APE/VsB3g85MaQ6fqFKVWQ36b8NT6sOzs
	 9mfM/ltKG5k53eb6in/GUyKEJtltm9TG+VXQNluKoC+n3QFMj6GutpObKaNH+sA538
	 LdNgTk3AJa+jNJPve9H1NhS0TwTjCltzDVDXaVesCaT5SrcSP1urUedW0RGVLdxHBV
	 woM1/2aVjpeiA==
Date: Fri, 4 Apr 2025 15:25:58 -0300
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
Message-ID: <Z_AkNkxLU-9eDrCm@x1>
References: <20250307080829.354947-1-namhyung@kernel.org>
 <Z9tjKcKvjYgbR6hb@google.com>
 <Z9vgt1pjiNbDBDbM@gmail.com>
 <Z9w_aFlzOkoCTSqK@google.com>
 <Z-EJnye74la1triY@gmail.com>
 <Z--pWmTHGb62_83e@gmail.com>
 <Z_AWpgne5108xqlc@google.com>
 <Z_AhOFo9mpFmT4Pd@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_AhOFo9mpFmT4Pd@x1>

On Fri, Apr 04, 2025 at 03:13:12PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Apr 04, 2025 at 10:28:06AM -0700, Namhyung Kim wrote:
> > > I cannot get the libunwind build-feature failure to go away:
>  
> > > ...                               libcrypto: [ on  ]
> > > ...                               libunwind: [ OFF ]
> > > ...                             libcapstone: [ on  ]
> > > ...                               llvm-perf: [ on  ]
>  
> > > I do have libunwind-dev installed:
>  
> > > ii  libunwind-dev:amd64                                         1.6.2-3.1                                           amd64        library to determine the call-chain of a program - development
> > > ii  libunwind8:amd64                                            1.6.2-3.1                                           amd64        library to determine the call-chain of a program - runtime
>  
> > > but it fails to link:
>  
> > >  kepler:~/tip/tools/build/feature> cat test-libunwind.make.output
> > >  /usr/bin/ld: /tmp/cc2BfaNM.o: in function `main':
> > >  test-libunwind.c:(.text+0x1c): undefined reference to `_Ux86_64_create_addr_space'
> > >  /usr/bin/ld: test-libunwind.c:(.text+0x44): undefined reference to `_Ux86_64_init_remote'
> > >  /usr/bin/ld: test-libunwind.c:(.text+0x6b): undefined reference to `_Ux86_64_dwarf_search_unwind_table'
> > >  collect2: error: ld returned 1 exit status
>  
> > > I tried to install the libunwind-19-dev package, I tried to 
> > > uninstall/reinstall - no combination seems to work.
>  
> > > perf is also totally unhelpful about resolving such issues - it used to 
> > > issue tips about what packages to install, but those tips are not 
> > > present anymore, for this one at least.
>  
> > Since v6.13, we switched to disable libunwind by default and used
> > unwinding in libdw.
>  
> > commit 13e17c9ff491 ("perf build: Make libunwind opt-in rather than opt-out")
>  
> > You need to pass LIBUNWIND=1 to build with it.
> 
> But we should have that spelled out in the output of the build where it
> appears marked as not being enabled even with the usual devel libraries
> being available.
> 
> Its back to change in behaviour that is not clearly marked in the tool
> output.

I just tried but realized that I have the libunwind devel files
available...

so get:

Auto-detecting system features:
...                                   libdw: [ on  ]
...                                   glibc: [ on  ]
...                                  libbfd: [ on  ]
...                          libbfd-buildid: [ on  ]
...                                  libelf: [ on  ]
...                                 libnuma: [ on  ]
...                  numa_num_possible_cpus: [ on  ]
...                                 libperl: [ on  ]
...                               libpython: [ on  ]
...                               libcrypto: [ on  ]
...                               libunwind: [ on  ]
...                             libcapstone: [ on  ]
...                               llvm-perf: [ on  ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                               get_cpuid: [ on  ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]



Nope, not really, I only have:

⬢ [acme@toolbox perf-tools-next]$ rpm -qa | grep unwind
libunwind-1.8.0-3.fc40.x86_64
⬢ [acme@toolbox perf-tools-next]$ rpm -e libunwind
error: Failed dependencies:
	libunwind.so.8()(64bit) is needed by (installed) gstreamer1-1.24.11-1.fc40.x86_64
⬢ [acme@toolbox perf-tools-next]$

So this is a bug...

There are no references to libunwind tools/build/feature/test-all.c and
it is building ok:

⬢ [acme@toolbox perf-tools-next]$ cat /tmp/build/perf-tools-next/feature/test-all.make.output 
⬢ [acme@toolbox perf-tools-next]$ 

and somehow libunwind devel files are being somehow detected as being present...

Investigating...

- Arnaldo

