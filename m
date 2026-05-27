Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1D428D8DB;
	Wed, 27 May 2026 21:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779916105; cv=none; b=JePXb3cD55oeoUrV67/ZLtHFj1uHq9n7lOH7KGX0yRrj30sLaVfMXqsXMeRqzvBtB14qy0Lpb/T5KLKnz606r6JTHAHbggey+gDW57d+Xp7qnVjwLAzYzt7GdJewPtfIVUuVebMPLycPHDgKPkgUEi1zoW222ncaJJcQtVyjomE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779916105; c=relaxed/simple;
	bh=rC8dl9cmpQ+jSua5GxOd5FPAbRai9UEGvZa/u/6fpZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dX3RePqW5BCyd1kvhDMhMkBONuUFhMV302ItraJFdzquIkjxi/P3Minxx5Vj5juCeYj1maPic/s5Kllj04zec2v4Y7DkI8eQykJMlFnPukWOEat8WbV8sCwbNbIO6Ek3gq77pMd/ialn4oj1XO8B7RBpVEgr46Z9yHogrl1i9uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzifS0IB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzifS0IB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C921F000E9;
	Wed, 27 May 2026 21:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779916103;
	bh=PHSP1Bu8qMEMxj4q0ongEzlQh2xcnPeIEY2kWNZAMCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WzifS0IBV7dwzDdiz8UwGETemNMBYPvohAMOMxcO/PTxw0N7ppU0BySI5IHMcZsnU
	 jCcIr8EPYMaO2lg1RG7Nx4MoDNYgefWOspvWHKEwRYgpXmh/i9YlkpXAhqHFoor1p/
	 LxnyCGo3zXt4hUJSYTUjuD3hvKKL0vntpPJdv2AFVlQL1RSWSKmvdjMLxgfOrsFeHM
	 ri4vAJfaYxJZMalbOTmYtVGv9qqTGmCAKUI7fi6iiOVONN2z1t2EHl/xruRo3FyHWz
	 nj1vUzQ3BKJA6AekQLhkrqoHdkhfdSoL0TtoFP0RQH30jWE9ZwwxleBhH0pNjAvR/d
	 qnmTuo6zL9bvw==
Date: Wed, 27 May 2026 14:08:21 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Jan Polensky <japo@linux.ibm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jens Remus <jremus@linux.ibm.com>, sashiko-reviews@lists.linux.dev,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] perf build: Fix Python extension build with GCC 16
 hardening
Message-ID: <ahddRWPBk46HiR6x@google.com>
References: <20260520125637.105681-1-japo@linux.ibm.com>
 <20260520130905.9C85D1F000E9@smtp.kernel.org>
 <ahJnMnOr4i9urrRk@x1>
 <ahV2XGx_6h7upuc3@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <CAP-5=fXGG5PR8neTkozvOUOH83m8_EyZXZ_A7Zyrsock5EqAiQ@mail.gmail.com>
 <ahXITNt0Z-n4NCaj@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <CAP-5=fXcpoXMsezy1FNBX7mhKmRgw+97QmKTg5Fr6G-cY+wGpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXcpoXMsezy1FNBX7mhKmRgw+97QmKTg5Fr6G-cY+wGpg@mail.gmail.com>

On Tue, May 26, 2026 at 09:59:41AM -0700, Ian Rogers wrote:
> On Tue, May 26, 2026 at 9:20 AM Jan Polensky <japo@linux.ibm.com> wrote:
> >
> > On Tue, May 26, 2026 at 08:23:28AM -0700, Ian Rogers wrote:
> > > On Tue, May 26, 2026 at 3:35 AM Jan Polensky <japo@linux.ibm.com> wrote:
> > > >
> > > > On Sat, May 23, 2026 at 11:49:22PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > On Wed, May 20, 2026 at 01:09:05PM +0000, sashiko-bot@kernel.org wrote:
> > > > > > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > > > > - [Medium] The patch explicitly allows text relocations in the Python extension shared object (`perf.so`) by adding `-Wl,-z,notext`, masking the root cause of missing `-fPIC` flags and breaking W^X (Write XOR Execute) security protections.
> > > > > > --
> > > > > >
> > > > > > commit f3832fb0ad0d1f9c2e69039b2a5110f77d220d5e
> > > > > > Author: Jan Polensky <japo@linux.ibm.com>
> > > > > >
> > > > > > perf build: Fix Python extension build with GCC 16 hardening
> > > > > >
> > > > > > This commit addresses a build failure in the Python extension caused by GCC 16
> > > > > > stricter security policies regarding dynamic relocations in read-only segments.
> > > > > > It adds the -Wl,-z,notext flag to the linker to explicitly allow text
> > > > > > relocations in the Python extension shared object.
> > > > > >
> > > > > > > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > > > > > > index 76b35ac19acbf..eea170d6576db 100644
> > > > > > > --- a/tools/perf/Makefile.perf
> > > > > > > +++ b/tools/perf/Makefile.perf
> > > > > > > @@ -749,7 +749,7 @@ all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
> > > > > > >  $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
> > > > > > >
> > > > > > >  $(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): util/python.c util/setup.py $(PERFLIBS_PY)
> > > > > > > - $(QUIET_GEN)LDSHARED="$(CC) -pthread -shared" \
> > > > > > > + $(QUIET_GEN)LDSHARED="$(CC) -pthread -shared -Wl,-z,notext" \
> > > > > >
> > > > > > [Severity: Medium]
> > > > > > Does adding -Wl,-z,notext mask the root cause of the GCC 16 linker error?
> > > > > >
> > > > > > The error regarding dynamic relocations in a read-only segment usually
> > > > > > indicates that non-position-independent code from the static libraries
> > > > > > is being linked into the shared library.
> > > > > >
> > > > > > Using -Wl,-z,notext suppresses this error by allowing text relocations, which
> > > > > > forces the dynamic linker to map the executable text segment as writable at
> > > > > > load time. This breaks W^X security protections and weakens the security of
> > > > > > any Python process loading the extension.
> > > > > >
> > > > > > Should the required object files be compiled with -fPIC instead to properly
> > > > > > resolve the linker error without compromising security?
> > > > >
> > > > > So I asked Claude about this and he suggests doing like other parts of
> > > > > perf and using -fPIC, can you try to do that?
> > > > >
> > > > > ---------------------------------------
> > > > >
> > > > > ● Sashiko is right. -Wl,-z,notext is a band-aid that weakens security —
> > > > >   it makes the text segment writable at load time, defeating W^X.
> > > > >
> > > > >   The root cause is that PERFLIBS_PY (the static libraries linked into
> > > > >   the Python .so) are compiled without -fPIC. When you link non-PIC .a
> > > > >   archives into a shared library, the linker needs text relocations. GCC
> > > > >   16 correctly rejects this by default.
> > > > >
> > > > >   The proper fix is to build the static libraries that go into the
> > > > >   Python extension with -fPIC. The perf build system already has
> > > > >   precedent for this — look for how libperf and libsubcmd handle PIC
> > > > >   builds. The Python extension's dependencies need a parallel -fPIC
> > > > >   build, or the existing objects need to be compiled with -fPIC when the
> > > > >   Python binding is enabled.
> > > > >
> > > > >   The -Wl,-z,notext approach would also cause issues on distros that
> > > > >   enforce RELRO + BIND_NOW hardening, and some package builders would
> > > > >   reject the resulting .so outright.
> > > > >
> > > > > - Arnaldo
> > > >
> > > > Hi Arnaldo,
> > > >
> > > > thanks for the pointer. I double-checked this on s390x and did some reduced-link
> > > > testing for the ET_DYN / Python-extension case.
> > > >
> > > > The failure is not triggered by the perf Python binding object alone.
> > > >
> > > > A reduced reproducer succeeds when linking:
> > > >   python.o
> > > >   + libapi.a
> > > >   + libperf.a
> > > >   + libsubcmd.a
> > > >   + libsymbol.a
> > > >   + libbpf.a
> > > >   + libperf-ui.a
> > > >
> > > > The link starts to fail with:
> > > >   /usr/bin/ld.bfd: error: read-only segment has dynamic relocations
> > > >
> > > > as soon as libperf-util.a is added.
> > > >
> > > > In my tree, libperf-util.a currently contains only perf-util-in.o, and replacing
> > > > the archive with that single object still reproduces the same failure.
> > > >
> > > > Reduced reproducer:
> > > >
> > > >   gcc -pthread -shared \
> > > >     -Wl,-z,noexecstack \
> > > >     -o /tmp/try-perf-util-only.so \
> > > >     /root/linux/tools/perf/python_ext_build/tmp/root/linux/tools/perf/util/python.o \
> > > >     -Wl,--whole-archive \
> > > >       /root/linux/tools/perf/libapi/libapi.a \
> > > >       /root/linux/tools/perf/libperf/libperf.a \
> > > >       /root/linux/tools/perf/libsubcmd/libsubcmd.a \
> > > >       /root/linux/tools/perf/libsymbol/libsymbol.a \
> > > >       /root/linux/tools/perf/libbpf/libbpf.a \
> > > >       /root/linux/tools/perf/libperf-ui.a \
> > > >     -Wl,--no-whole-archive \
> > > >     /root/perf-util-one/perf-util-in.o \
> > > >     -lpython3.14 -lpthread -ldl -lm -lutil
> > > >
> > > > Inspection of perf-util-in.o on s390x shows many direct R_390_PC32DBL
> > > > relocations from .text against .data.rel.ro, .data.rel.ro.local,
> > > > .data.rel.local, .bss, and .rodata.
> > > >
> > > > Representative examples include:
> > > >
> > > >   arm64__associate_instruction_ops:
> > > >     larl %r6  -> R_390_PC32DBL .data.rel.ro+0x2
> > > >
> > > >   loongarch__associate_ins_ops:
> > > >     larl %r9  -> R_390_PC32DBL .data.rel.ro+0x22
> > > >     larl %r9  -> R_390_PC32DBL .data.rel.ro+0x42
> > > >
> > > >   check_ppc_insn:
> > > >     larl %r4  -> R_390_PC32DBL .data.rel.local+0x4c2
> > > >     larl %r2  -> R_390_PC32DBL .data.rel.ro.local+0x22
> > > >     larl %r1  -> R_390_PC32DBL .data.rel.local+0x2
> > > >     larl %r2  -> R_390_PC32DBL .data.rel.ro.local+0x2
> > > >
> > > >   s390__associate_ins_ops:
> > > >     larl %r10 -> R_390_PC32DBL .data.rel.ro+0x732
> > > >     larl %r10 -> R_390_PC32DBL .data.rel.ro+0x752
> > > >
> > > > So from my reproducer, I don't think we can describe this simply as
> > > > "all Python-extension dependency archives are missing -fPIC".
> > > >
> > > > The issue narrows down much more specifically to perf-util-in.o in the ET_DYN
> > > > link of the Python extension, and the direct text-to-data section relocations
> > > > above look like the most relevant candidates.
> > > >
> > > > So I agree that -Wl,-z,notext is only a workaround. I'd prefer to understand
> > > > and fix the underlying relocation pattern in perf-util-in.o rather than merge
> > > > that as-is.
> > > >
> > > > If useful, I can send the relevant readelf/objdump snippets in a follow-up.
> > >
> > > Hi Jan,
> > >
> > > I wonder about two tests:
> > > 1) adding V=1 JOBS=1 to your make command to switch on single
> > > threading and build verbosity. This may make it possible to identify
> > > the gcc command that is missing -fPIC. For example, I see -fPIC on
> > > x86:
> > >   gcc -Wp,-MD,/tmp/perf4/util/annotate-arch/.annotate-arm64.o.d
> > > -Wp,-MT,/tmp/perf4/util/annotate-arch/annotate -arm64.o
> > > -Wbad-function-cast -Wdeclaration-after-statement -Wformat-security
> > > -Wformat-y2k -Winit-self -Wmissin g-declarations -Wmissing-prototypes
> > > -Wno-system-headers -Wold-style-definition -Wpacked -Wredundant-decls
> > > -Wst rict-prototypes -Wswitch-default -Wswitch-enum -Wundef
> > > -Wwrite-strings -Wformat -Wno-type-limits -Wstrict-alia sing=3
> > > -Wshadow -fno-strict-aliasing -I/tmp/perf4/arch/x86/include/generated
> > > -DHAVE_ARCH_X86_64_SUPPORT -Werro r -g -fno-omit-frame-pointer -Wall
> > > -Wextra -std=gnu11 -funsigned-char -fstack-protector-all
> > > -D_LARGEFILE64_SOU RCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE
> > > -I~/linux/tools/perf/util/include
> > > -I~/linux/tools/perf/arch/x86/include
> > > -I/usr/local/google/home/irogers/re pos/linux4/tools/include/
> > > -I~/linux/tools/arch/x86/include/uapi -I/usr/loc
> > > al/google/home/irogers/repos/linux4/tools/include/uapi
> > > -I~/linux/tools/arc h/x86/include/ -I~/linux/tools/arch/x86/
> > > -I/tmp/perf4//util -I/tmp/perf4/ -I~/linux/tools/perf/util
> > > -I~/linux/to ols/perf -DHAVE_PTHREAD_ATTR_SETAFFINITY_NP
> > > -DHAVE_PTHREAD_BARRIER -DHAVE_EVENTFD_SUPPORT -DHAVE_GETTID -DHAVE
> > > _FILE_HANDLE -DHAVE_AIO_SUPPORT -DHAVE_SCANDIRAT_SUPPORT
> > > -DHAVE_SCHED_GETCPU_SUPPORT -DHAVE_SETNS_SUPPORT -DHA VE_ZLIB_SUPPORT
> > > -DHAVE_LIBELF_SUPPORT -DHAVE_ELF_GETPHDRNUM_SUPPORT
> > > -DHAVE_GELF_GETNOTE_SUPPORT -DHAVE_ELF_GET SHDRSTRNDX_SUPPORT
> > > -DHAVE_DEBUGINFOD_SUPPORT -DHAVE_LIBDW_SUPPORT -DHAVE_LIBBPF_SUPPORT
> > > -DHAVE_SDT_EVENT -DHAV E_JITDUMP -DHAVE_LIBOPENSSL_SUPPORT
> > > -DHAVE_BPF_SKEL -DHAVE_DWARF_UNWIND_SUPPORT -DHAVE_SLANG_SUPPORT
> > > -DHAVE_TI MERFD_SUPPORT -fPIC -DHAVE_LIBLLVM_SUPPORT
> > > -I/usr/lib/llvm-19/include -D_GNU_SOURCE -D__STDC_CONSTANT_MACROS
> > > -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS
> > > -DHAVE_CXA_DEMANGLE_SUPPORT -DHAVE_LZMA_SUPPORT -DHAVE_ZSTD_SUPPORT
> > > -DHAVE_BACKTRACE_SUPPORT -DHAVE_LIBNUMA_SUPPORT
> > > -DHAVE_PERF_READ_VDSO32 -DHAVE_LIBBABELTRACE_SUPPORT -DHAVE_
> > > LIBCAPSTONE_SUPPORT -DHAVE_JVMTI_CMLR -DHAVE_LIBPFM
> > > -DHAVE_LIBTRACEEVENT -I/usr/include/traceevent -DLIBTRACEE
> > > VENT_VERSION=67072 -DHAVE_RUST_SUPPORT -I/tmp/perf4/libapi/include
> > > -I/tmp/perf4/libbpf/include -I/tmp/perf4/li bsubcmd/include
> > > -I/tmp/perf4/libsymbol/include -I/tmp/perf4/libperf/include
> > > -I/tmp/perf4/ -D"BUILD_STR(s)=#s" -c -o
> > > /tmp/perf4/util/annotate-arch/annotate-arm64.o
> > > util/annotate-arch/annotate-arm64.c
> > >
> > > 2) adding EXTRA_CFLAGS="-fPIC" to your make command. This should force
> > > this option wherever it might be missing.
> > >
> > > Thanks,
> > > Ian
> > >
> > > > Best regards,
> > > > Jan
> > > >
> > Hi Ian,
> >
> > I tested both suggestions the second in the beginning of my research:
> >
> > EXTRA_CFLAGS="-fPIC" - Does NOT work. Same error:
> >
> > /usr/bin/ld.bfd: error: read-only segment has dynamic relocations
> > collect2: error: ld returned 1 exit status
> >
> > The issue is s390x-specific R_390_PC32DBL relocations in perf-util-in.o
> > (from `larl` instructions) that persist even with -fPIC.
> >
> > Current options:
> > 1. Use -Wl,-z,notext (security issue)
> > 2. Refactor code to avoid these relocations
> > 3. Disable Python extension on s390x (not an option)
> >
> > Thoughts?
> 
> So it appears that part of the problem is declaring arrays and structs
> to be const. Making things non-const I think is also not an option.
> Would  EXTRA_CFLAGS="-fvisibility=hidden" help?
> 
> It would we interesting to build with -Wl,-z,notext and then look for
> the symbol the linker is fighting with:
>   eu-findtextrel perf.cpython....so
> or
>   readelf -d perf.so | grep TEXTREL
>   readelf -r perf.so

I'm curious if it's s390 specific.  I don't know what code patterns make
it relocatable.  Is taking an address of struct ins_ops variable a
problem?  Does it matter being a static variable?

Thanks,
Namhyung

