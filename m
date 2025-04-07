Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13FC1FF601;
	Mon,  7 Apr 2025 19:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055319; cv=none; b=mmBKMuegsGBmfr9uEoXZTFgG2XJZ84Zd9jhOjqYjm2MUgL3v+nW2pxbP+B1t5xjNlreyI+a2cV5ALJfgyTdXk7DuSKHjkD5UxdA7IXkLGQYCJbzRYNZtrVKHnaLEn25IATJFMp8OnG6B1yBUCbPHkLtooL576swkSveqahCPs0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055319; c=relaxed/simple;
	bh=+ZYKBdAranbwNoxwux+o6rZCHzd6BxSH29D67hR39vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0xRocLkUVOt2DL9su/c0+NQOwQyydciCuy7Ok2OF43VzAMre6aTVUoWtiZ2FM2E0Wac//3331mEdtku94vrPHYFnuj6p6z1CUhz3gV0CuYxncR7xr7kpQw9lxX34znm9TI6Kb4NXyxvcPTmzsnJy0ECd1ayOszckahBxl+Qscw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m461zOi9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m461zOi9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88E0C4CEDD;
	Mon,  7 Apr 2025 19:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744055318;
	bh=+ZYKBdAranbwNoxwux+o6rZCHzd6BxSH29D67hR39vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m461zOi9ssBbfZ4QVe5iU1LFvrwO+i29ieJCttdc8W0BWGma2vd6vuvRJowp0eUzz
	 K6tIkVxejjAjgDDjAI/4jBRPxOVu21gM8UUfvkv2G5STZ/IEqNl7JbtMI468kbX1hk
	 roe+1LApPYZ+chJZgHoRqsKfVGqorvZNuTIQJUe50Np6h4bNuSPCFRaFUBIBKCRtBN
	 G8wAJWVYoLQOdz+gxQzrUolrUQwS0hrv0qFVM3FMWOsHYIrXuz/Q2W4Jd8j+uIIauE
	 3goqJufgzcouBSRE7g9VsWPQKMwkYhKmww1wr2/3mMQ1YmrbvZCUKd5d+RiLxxpeAH
	 siFxoVvZ5uGMA==
Date: Mon, 7 Apr 2025 16:48:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
	Dmitry Vyukov <dvyukov@google.com>, Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] tools build: Don't set libunwind as available if
 test-all.c build succeeds
Message-ID: <Z_QsE-1nI8vX-0EZ@x1>
References: <Z_ArFrHU7hMNUOv3@x1>
 <Z_BBVgJ1nZB_0klZ@z2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_BBVgJ1nZB_0klZ@z2>

On Fri, Apr 04, 2025 at 01:30:14PM -0700, Namhyung Kim wrote:
> On Fri, Apr 04, 2025 at 03:55:18PM -0300, Arnaldo Carvalho de Melo wrote:
> > The tools/build/feature/test-all.c file tries to detect the expected,
> > most common set of libraries/features we expect to have available to
> > build perf with.
> > 
> > At some point libunwind was deemed not to be part of that set of
> > libraries, but the patches making it to be opt-in ended up forgetting
> > some details, fix one more.
> > 
> > Testing it:
> > 
> >   $ rm -rf /tmp/build/$(basename $PWD)/ ; mkdir -p /tmp/build/$(basename $PWD)/
> >   $ rpm -q libunwind-devel
> >   libunwind-devel-1.8.0-3.fc40.x86_64
> >   $ make -k LIBUNWIND=1 CORESIGHT=1 O=/tmp/build/$(basename $PWD)/ -C tools/perf install-bin |& grep unwind && ldd ~/bin/perf | grep unwind
> >   ...                               libunwind: [ on  ]
> >     CC      /tmp/build/perf-tools-next/arch/x86/tests/dwarf-unwind.o
> >     CC      /tmp/build/perf-tools-next/arch/x86/util/unwind-libunwind.o
> >     CC      /tmp/build/perf-tools-next/util/arm64-frame-pointer-unwind-support.o
> >     CC      /tmp/build/perf-tools-next/tests/dwarf-unwind.o
> >     CC      /tmp/build/perf-tools-next/util/unwind-libunwind-local.o
> >     CC      /tmp/build/perf-tools-next/util/unwind-libunwind.o
> > 	  libunwind-x86_64.so.8 => /lib64/libunwind-x86_64.so.8 (0x00007f615a549000)
> > 	  libunwind.so.8 => /lib64/libunwind.so.8 (0x00007f615a52f000)
> >   $ sudo rpm -e libunwind-devel
> >   $ rm -rf /tmp/build/$(basename $PWD)/ ; mkdir -p /tmp/build/$(basename $PWD)/
> >   $ make -k LIBUNWIND=1 CORESIGHT=1 O=/tmp/build/$(basename $PWD)/ -C tools/perf install-bin |& grep unwind && ldd ~/bin/perf | grep unwind
> >   Makefile.config:653: No libunwind found. Please install libunwind-dev[el] >= 1.1 and/or set LIBUNWIND_DIR
> >   ...                               libunwind: [ OFF ]
> >     CC      /tmp/build/perf-tools-next/arch/x86/tests/dwarf-unwind.o
> >     CC      /tmp/build/perf-tools-next/arch/x86/util/unwind-libdw.o
> >     CC      /tmp/build/perf-tools-next/util/arm64-frame-pointer-unwind-support.o
> >     CC      /tmp/build/perf-tools-next/tests/dwarf-unwind.o
> >     CC      /tmp/build/perf-tools-next/util/unwind-libdw.o
> >   $
> > 
> > Should be in a separate patch, but tired now, so also adding a message
> > about the need to use LIBUNWIND=1 in the output when its not available,
> > so done here as well.
> > 
> > So, now when the devel files are not available we get:
> > 
> >   $ make -k LIBUNWIND=1 CORESIGHT=1 O=/tmp/build/$(basename $PWD)/ -C tools/perf install-bin |& grep unwind && ldd ~/bin/perf | grep unwind
> >   Makefile.config:653: No libunwind found. Please install libunwind-dev[el] >= 1.1 and/or set LIBUNWIND_DIR and set LIBUNWIND=1 in the make command line as it is opt-in now
> >   ...                               libunwind: [ OFF ]
> >   $
> > 
> > Fixes: 13e17c9ff49119aa ("perf build: Make libunwind opt-in rather than opt-out")
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Dmitry Vyukov <dvyukov@google.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: James Clark <james.clark@linaro.org>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Link: https://lore.kernel.org/lkml/Z_AnsW9oJzFbhIFC@x1
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/build/Makefile.feature | 1 -
> >  tools/perf/Makefile.config   | 4 +++-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> > index 1931b6321314684c..54c8adfb94662c03 100644
> > --- a/tools/build/Makefile.feature
> > +++ b/tools/build/Makefile.feature
> > @@ -87,7 +87,6 @@ FEATURE_TESTS_BASIC :=                  \
> >          libtracefs                      \
> >          libcpupower                     \
> >          libcrypto                       \
> > -        libunwind                       \
> >          pthread-attr-setaffinity-np     \
> >          pthread-barrier     		\
> >          reallocarray                    \
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index eea95c6c0c71f76e..8ff1d8ade73fc061 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -624,6 +624,8 @@ endif
> >  ifndef NO_LIBUNWIND
> >    have_libunwind :=
> >  
> > +  $(call feature_check,libunwind)
> > +
> >    $(call feature_check,libunwind-x86)
> >    ifeq ($(feature-libunwind-x86), 1)
> >      $(call detected,CONFIG_LIBUNWIND_X86)
> > @@ -648,7 +650,7 @@ ifndef NO_LIBUNWIND
> >    endif
  
> >    ifneq ($(feature-libunwind), 1)
> > -    $(warning No libunwind found. Please install libunwind-dev[el] >= 1.1 and/or set LIBUNWIND_DIR)
> > +    $(warning No libunwind found. Please install libunwind-dev[el] >= 1.1 and/or set LIBUNWIND_DIR and set LIBUNWIND=1 in the make command line as it is opt-in now)
 
> I think this message is only visible if users already give LIBUNWIND=1.

Doh, indeed, I got confused with that NO_LIBUNWIND=1 thing.

In the end the way we made libunwind opt-in is confusing, I cooked up a
patch for 'perf -vv'  (that is a shorthand for 'perf version
--build-options, to tell the user, while we don't completely remove
libunwind support from perf, as the one present in elfutils is better.

Not to confuse people that were used to having it enabled and try to
enable it we need something like:

⬢ [acme@toolbox perf-tools-next]$ perf -vv | grep libunwind
             libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT ( tip: Deprecated, use LIBUNWIND=1 and install libunwind-dev[el] to use with it )
⬢ [acme@toolbox perf-tools-next]$ perf version --build
perf version 6.15.rc1.g113e3df8ccc5
                   aio: [ on  ]  # HAVE_AIO_SUPPORT
                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
         bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
            debuginfod: [ OFF ]  # HAVE_DEBUGINFOD_SUPPORT
                 dwarf: [ on  ]  # HAVE_LIBDW_SUPPORT
    dwarf_getlocations: [ on  ]  # HAVE_LIBDW_SUPPORT
          dwarf-unwind: [ on  ]  # HAVE_DWARF_UNWIND_SUPPORT
              auxtrace: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT
           libcapstone: [ on  ]  # HAVE_LIBCAPSTONE_SUPPORT
             libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
    libdw-dwarf-unwind: [ on  ]  # HAVE_LIBDW_SUPPORT
                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
               libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
            libopencsd: [ on  ]  # HAVE_CSTRACE_SUPPORT
               libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
               libpfm4: [ on  ]  # HAVE_LIBPFM
             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
         libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
             libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT ( tip: Deprecated, use LIBUNWIND=1 and install libunwind-dev[el] to use with it )
                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                  zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
⬢ [acme@toolbox perf-tools-next]$

This should be done for the other cases as when that feature isn't
present.

Now looking how to wire this up with the messages emitted at build time,
i.e. here:

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
...                               libunwind: [ OFF ]
...                             libcapstone: [ on  ]
...                               llvm-perf: [ on  ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                               get_cpuid: [ on  ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]

  INSTALL libsubcmd_headers

- Arnaldo
