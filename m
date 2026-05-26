Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0E931ED83
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 15:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809022; cv=pass; b=sEJWWAakXrYKNlq/F2qPt3tv8KZXfdGSiPXmwuQ/No08DbznHisbMTrzqYtWkzIjUc9AfcOROJk/YWEMr94l0yWC4AgBTQFCcnm5R+One/d4Z+Rr8vJw7P7SOPfwr2g4OaZqYVVkFcSQBEKi+QWEV43ZCOPEDhdDOqJPJBP9gBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809022; c=relaxed/simple;
	bh=81jHrclHcNEk1Uew2qjVJVy48U26fGdbnf0gRavebwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFC2Fihwxsa7+/4YdNGUC6hKvPEjWQxy2Phs6Z1e3oHB+2IG5ezTjKwAjSk2Qnn5pVjrw6pOiiBRu0clDOye+vRHENo6VzCnhbftCPusd6Sp9q4HN+7mX3HAA7xLZcBmIFbQqb5qThcf8HF9AHcT4ckvFH90Bgahg6b3fYusE88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aKjugRjK; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aKjugRjK"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b46da8c48eso7185ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 08:23:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779809020; cv=none;
        d=google.com; s=arc-20240605;
        b=QejDYVqGhOh7VkvMtyQJEyF0V8SFeuXWdTXMomLnAHSIFPZSXzU4FSy3c9gniG2d8A
         y4UMq66B2ARAJdtMomAejOpCkGf/ypRLKp0J43LFS9zsoB18rtGQhM+oQq7OSzQ7EI7u
         +/6gZpvzuQrQGMJspe0q2cH2tzFhfNMMwCg+ZhgBgBC4XLRjY1qjPEvQbB005uIDfkSd
         G7uzdpT0b+K1bIIy8be4JHOKq92iz0gpg2HelgUKpyYL3S5/25CWndKd1ahyELWvCCkH
         L/pibCrbdX+a8jpsO0FicwKhAP4ItzXNvanv+yVgvVC7Vodd8pNmoWfzYaHWUaY35P94
         Yt4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7SuB02+nX8ZZ9Z+lHKLvIPcRImDZrWBNCcP7HnhCIJI=;
        fh=CvTK2pz/4iDpMm6rr6GzIQZK+VjN9hIDuOmdHAcdmXw=;
        b=b2WJ3/ZzWDMN75fTfdGiMobKhjA0vShhBsS/Cnk9ff3R5eSTialQJc6phe7U0u0Wqw
         WDWDJKHOXac07bOtDvyuFxEl/DHDyhZG4UzdgILEk2oZeQE0p3fx2EE8bckyyQkOrFEn
         4I1LlDLCebpv4DIjrEDKwq1CQ1ZhA0Iu++ZF2+opW7GcUtBRu7a8SJrUPI1bwzXkV/jI
         Cx4qGlRvahn0V7H0w92w0xUvtsh3iRshernuJEhu3rC346l/yhep/AmdZZ/HK3rtRbQC
         7cwS/RsiK2XCTUC6BLm6mq4C4DvgGKzdIptz005L05trp1PAQE35NevNMmGfubkjv6Jv
         PUpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779809020; x=1780413820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SuB02+nX8ZZ9Z+lHKLvIPcRImDZrWBNCcP7HnhCIJI=;
        b=aKjugRjKYlSM319JfpI5dF3bMaliHXUSj9ZE6FdWURACMYJuxsGMjmVxzvzPNKNn1x
         KVw9qV6lLaSozQm5E5mqKmVmDcZl4frgES8UyG2jU16PSoCSSDHyY/k6/CFDV4/KaDNl
         dxo30E8ME3nndiQcgabIMqARlekz5yQMT5J0ibdoqvqCtMsMjr2zDvf5g54jMJB3QJix
         U1wQIWEoVZQCtFiIxq/LEifnUEaPyzmm1QYWQxHzohtnrbfjzT5KOQRdwtBhA+sJJCju
         1UYGo7WXQzAj7UBqYcAWe6kXBCrtGt2CeIG8FtBt1g3eSCDcXZ/q0TKLkP7E0t/I4Szz
         ANeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779809020; x=1780413820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7SuB02+nX8ZZ9Z+lHKLvIPcRImDZrWBNCcP7HnhCIJI=;
        b=UtBpr9ampwyCAmHsCpbaNTi4QydS9Zxnt2dNbJlOJpQu18YIObtMwCWlvRsUKcyRKM
         zzkz9ukypZ9gkNUTbGprNE4FfW0Z5pRWYLU+oEUAY2ai+tEk118dtciGVidz6AJrgwrA
         q7XNdnglZBXTJYVANPdNa+/opSYHkkfOcsIxYWwl+gCQ5yeXP1WiRtDR4ZNwkQ3Qjo5j
         39jzcrAEX/NyMf4S9M6/nC02VktmbLDmBiYEIy0H+qth7eJsEbByol4+EqPf4MENxGJR
         K8VHm0l87M75kh7eaib34GAQoxpyrFZTCpYCcSM54Ij/t47fkRSc4YsW/a/M+LsMFkUz
         NyUQ==
X-Forwarded-Encrypted: i=1; AFNElJ8l0nnWrZL5ClM5H8sYYsYB56zVmGFSikKg6gNXiZ/mRwmfPXmc+ECl+VqMgzJIMT3UwP+80NilHjI4geYpWhJF@vger.kernel.org
X-Gm-Message-State: AOJu0YwFNySv3U81EXcRf5zINCORrXZmst5/ZaRXjFJlCwlF8ogCk4Lg
	4ZLScGYmafwZlpwTc0iGq6AnRbCscYOGHdRrowdEVV+qfBIrOeQEK3B+jlziWqsyiA+O/dCkT/i
	d3Na6n8da58yqlnYqPgtmvlgtDr6Gip1wqt+7Zqrs
X-Gm-Gg: Acq92OGT6xffkr8xnnQ2Ct5EytYBSbFQzM16gXTCMh1m160ii1kO9Xpv/tpjRXwreYC
	t/AuJnWVjRgkJF86wBDWHFHurmqsJjfamvw2XsmwfwJNjHDFjAtJRbk2irIzGg9az/vsg74+o0q
	vrcCCDObwjMPKvdPpgTq0iCH41AiUhCjS+G48TuSAOY9xJZu76kOv4Ll9/28qu47vDER5GoEw6q
	FXM3bK9Ii/CFayAa5Mx7aLoBDg8cJ4wP+xzhDeqYEVk8uqmOeUuCVvi1YEmy33Dc7Oh+A5cGxAU
	Y5KvKZ69ddsGL+/e94tw3RaygfT5M5lto0vf4ur1BI5rEXoW
X-Received: by 2002:a17:902:e551:b0:2bd:7e8e:ad56 with SMTP id
 d9443c01a7336-2bebe9feb6emr5482865ad.6.1779809019695; Tue, 26 May 2026
 08:23:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520125637.105681-1-japo@linux.ibm.com> <20260520130905.9C85D1F000E9@smtp.kernel.org>
 <ahJnMnOr4i9urrRk@x1> <ahV2XGx_6h7upuc3@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
In-Reply-To: <ahV2XGx_6h7upuc3@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 26 May 2026 08:23:28 -0700
X-Gm-Features: AVHnY4JD2evbOkCcCI_ocjZapqW7Aw2CvontFdPBDRe3e5y1SWiU2I8bG81yW2w
Message-ID: <CAP-5=fXGG5PR8neTkozvOUOH83m8_EyZXZ_A7Zyrsock5EqAiQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf build: Fix Python extension build with GCC 16 hardening
To: Jan Polensky <japo@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jens Remus <jremus@linux.ibm.com>, 
	sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 3:35=E2=80=AFAM Jan Polensky <japo@linux.ibm.com> w=
rote:
>
> On Sat, May 23, 2026 at 11:49:22PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, May 20, 2026 at 01:09:05PM +0000, sashiko-bot@kernel.org wrote:
> > > Thank you for your contribution! Sashiko AI review found 1 potential =
issue(s) to consider:
> > > - [Medium] The patch explicitly allows text relocations in the Python=
 extension shared object (`perf.so`) by adding `-Wl,-z,notext`, masking the=
 root cause of missing `-fPIC` flags and breaking W^X (Write XOR Execute) s=
ecurity protections.
> > > --
> > >
> > > commit f3832fb0ad0d1f9c2e69039b2a5110f77d220d5e
> > > Author: Jan Polensky <japo@linux.ibm.com>
> > >
> > > perf build: Fix Python extension build with GCC 16 hardening
> > >
> > > This commit addresses a build failure in the Python extension caused =
by GCC 16
> > > stricter security policies regarding dynamic relocations in read-only=
 segments.
> > > It adds the -Wl,-z,notext flag to the linker to explicitly allow text
> > > relocations in the Python extension shared object.
> > >
> > > > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > > > index 76b35ac19acbf..eea170d6576db 100644
> > > > --- a/tools/perf/Makefile.perf
> > > > +++ b/tools/perf/Makefile.perf
> > > > @@ -749,7 +749,7 @@ all: shell_compatibility_test $(ALL_PROGRAMS) $=
(LANG_BINDINGS) $(OTHER_PROGRAMS)
> > > >  $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
> > > >
> > > >  $(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): util/python.c util=
/setup.py $(PERFLIBS_PY)
> > > > - $(QUIET_GEN)LDSHARED=3D"$(CC) -pthread -shared" \
> > > > + $(QUIET_GEN)LDSHARED=3D"$(CC) -pthread -shared -Wl,-z,notext" \
> > >
> > > [Severity: Medium]
> > > Does adding -Wl,-z,notext mask the root cause of the GCC 16 linker er=
ror?
> > >
> > > The error regarding dynamic relocations in a read-only segment usuall=
y
> > > indicates that non-position-independent code from the static librarie=
s
> > > is being linked into the shared library.
> > >
> > > Using -Wl,-z,notext suppresses this error by allowing text relocation=
s, which
> > > forces the dynamic linker to map the executable text segment as writa=
ble at
> > > load time. This breaks W^X security protections and weakens the secur=
ity of
> > > any Python process loading the extension.
> > >
> > > Should the required object files be compiled with -fPIC instead to pr=
operly
> > > resolve the linker error without compromising security?
> >
> > So I asked Claude about this and he suggests doing like other parts of
> > perf and using -fPIC, can you try to do that?
> >
> > ---------------------------------------
> >
> > =E2=97=8F Sashiko is right. -Wl,-z,notext is a band-aid that weakens se=
curity =E2=80=94
> >   it makes the text segment writable at load time, defeating W^X.
> >
> >   The root cause is that PERFLIBS_PY (the static libraries linked into
> >   the Python .so) are compiled without -fPIC. When you link non-PIC .a
> >   archives into a shared library, the linker needs text relocations. GC=
C
> >   16 correctly rejects this by default.
> >
> >   The proper fix is to build the static libraries that go into the
> >   Python extension with -fPIC. The perf build system already has
> >   precedent for this =E2=80=94 look for how libperf and libsubcmd handl=
e PIC
> >   builds. The Python extension's dependencies need a parallel -fPIC
> >   build, or the existing objects need to be compiled with -fPIC when th=
e
> >   Python binding is enabled.
> >
> >   The -Wl,-z,notext approach would also cause issues on distros that
> >   enforce RELRO + BIND_NOW hardening, and some package builders would
> >   reject the resulting .so outright.
> >
> > - Arnaldo
>
> Hi Arnaldo,
>
> thanks for the pointer. I double-checked this on s390x and did some reduc=
ed-link
> testing for the ET_DYN / Python-extension case.
>
> The failure is not triggered by the perf Python binding object alone.
>
> A reduced reproducer succeeds when linking:
>   python.o
>   + libapi.a
>   + libperf.a
>   + libsubcmd.a
>   + libsymbol.a
>   + libbpf.a
>   + libperf-ui.a
>
> The link starts to fail with:
>   /usr/bin/ld.bfd: error: read-only segment has dynamic relocations
>
> as soon as libperf-util.a is added.
>
> In my tree, libperf-util.a currently contains only perf-util-in.o, and re=
placing
> the archive with that single object still reproduces the same failure.
>
> Reduced reproducer:
>
>   gcc -pthread -shared \
>     -Wl,-z,noexecstack \
>     -o /tmp/try-perf-util-only.so \
>     /root/linux/tools/perf/python_ext_build/tmp/root/linux/tools/perf/uti=
l/python.o \
>     -Wl,--whole-archive \
>       /root/linux/tools/perf/libapi/libapi.a \
>       /root/linux/tools/perf/libperf/libperf.a \
>       /root/linux/tools/perf/libsubcmd/libsubcmd.a \
>       /root/linux/tools/perf/libsymbol/libsymbol.a \
>       /root/linux/tools/perf/libbpf/libbpf.a \
>       /root/linux/tools/perf/libperf-ui.a \
>     -Wl,--no-whole-archive \
>     /root/perf-util-one/perf-util-in.o \
>     -lpython3.14 -lpthread -ldl -lm -lutil
>
> Inspection of perf-util-in.o on s390x shows many direct R_390_PC32DBL
> relocations from .text against .data.rel.ro, .data.rel.ro.local,
> .data.rel.local, .bss, and .rodata.
>
> Representative examples include:
>
>   arm64__associate_instruction_ops:
>     larl %r6  -> R_390_PC32DBL .data.rel.ro+0x2
>
>   loongarch__associate_ins_ops:
>     larl %r9  -> R_390_PC32DBL .data.rel.ro+0x22
>     larl %r9  -> R_390_PC32DBL .data.rel.ro+0x42
>
>   check_ppc_insn:
>     larl %r4  -> R_390_PC32DBL .data.rel.local+0x4c2
>     larl %r2  -> R_390_PC32DBL .data.rel.ro.local+0x22
>     larl %r1  -> R_390_PC32DBL .data.rel.local+0x2
>     larl %r2  -> R_390_PC32DBL .data.rel.ro.local+0x2
>
>   s390__associate_ins_ops:
>     larl %r10 -> R_390_PC32DBL .data.rel.ro+0x732
>     larl %r10 -> R_390_PC32DBL .data.rel.ro+0x752
>
> So from my reproducer, I don't think we can describe this simply as
> "all Python-extension dependency archives are missing -fPIC".
>
> The issue narrows down much more specifically to perf-util-in.o in the ET=
_DYN
> link of the Python extension, and the direct text-to-data section relocat=
ions
> above look like the most relevant candidates.
>
> So I agree that -Wl,-z,notext is only a workaround. I'd prefer to underst=
and
> and fix the underlying relocation pattern in perf-util-in.o rather than m=
erge
> that as-is.
>
> If useful, I can send the relevant readelf/objdump snippets in a follow-u=
p.

Hi Jan,

I wonder about two tests:
1) adding V=3D1 JOBS=3D1 to your make command to switch on single
threading and build verbosity. This may make it possible to identify
the gcc command that is missing -fPIC. For example, I see -fPIC on
x86:
  gcc -Wp,-MD,/tmp/perf4/util/annotate-arch/.annotate-arm64.o.d
-Wp,-MT,/tmp/perf4/util/annotate-arch/annotate -arm64.o
-Wbad-function-cast -Wdeclaration-after-statement -Wformat-security
-Wformat-y2k -Winit-self -Wmissin g-declarations -Wmissing-prototypes
-Wno-system-headers -Wold-style-definition -Wpacked -Wredundant-decls
-Wst rict-prototypes -Wswitch-default -Wswitch-enum -Wundef
-Wwrite-strings -Wformat -Wno-type-limits -Wstrict-alia sing=3D3
-Wshadow -fno-strict-aliasing -I/tmp/perf4/arch/x86/include/generated
-DHAVE_ARCH_X86_64_SUPPORT -Werro r -g -fno-omit-frame-pointer -Wall
-Wextra -std=3Dgnu11 -funsigned-char -fstack-protector-all
-D_LARGEFILE64_SOU RCE -D_FILE_OFFSET_BITS=3D64 -D_GNU_SOURCE
-I~/linux/tools/perf/util/include
-I~/linux/tools/perf/arch/x86/include
-I/usr/local/google/home/irogers/re pos/linux4/tools/include/
-I~/linux/tools/arch/x86/include/uapi -I/usr/loc
al/google/home/irogers/repos/linux4/tools/include/uapi
-I~/linux/tools/arc h/x86/include/ -I~/linux/tools/arch/x86/
-I/tmp/perf4//util -I/tmp/perf4/ -I~/linux/tools/perf/util
-I~/linux/to ols/perf -DHAVE_PTHREAD_ATTR_SETAFFINITY_NP
-DHAVE_PTHREAD_BARRIER -DHAVE_EVENTFD_SUPPORT -DHAVE_GETTID -DHAVE
_FILE_HANDLE -DHAVE_AIO_SUPPORT -DHAVE_SCANDIRAT_SUPPORT
-DHAVE_SCHED_GETCPU_SUPPORT -DHAVE_SETNS_SUPPORT -DHA VE_ZLIB_SUPPORT
-DHAVE_LIBELF_SUPPORT -DHAVE_ELF_GETPHDRNUM_SUPPORT
-DHAVE_GELF_GETNOTE_SUPPORT -DHAVE_ELF_GET SHDRSTRNDX_SUPPORT
-DHAVE_DEBUGINFOD_SUPPORT -DHAVE_LIBDW_SUPPORT -DHAVE_LIBBPF_SUPPORT
-DHAVE_SDT_EVENT -DHAV E_JITDUMP -DHAVE_LIBOPENSSL_SUPPORT
-DHAVE_BPF_SKEL -DHAVE_DWARF_UNWIND_SUPPORT -DHAVE_SLANG_SUPPORT
-DHAVE_TI MERFD_SUPPORT -fPIC -DHAVE_LIBLLVM_SUPPORT
-I/usr/lib/llvm-19/include -D_GNU_SOURCE -D__STDC_CONSTANT_MACROS
-D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS
-DHAVE_CXA_DEMANGLE_SUPPORT -DHAVE_LZMA_SUPPORT -DHAVE_ZSTD_SUPPORT
-DHAVE_BACKTRACE_SUPPORT -DHAVE_LIBNUMA_SUPPORT
-DHAVE_PERF_READ_VDSO32 -DHAVE_LIBBABELTRACE_SUPPORT -DHAVE_
LIBCAPSTONE_SUPPORT -DHAVE_JVMTI_CMLR -DHAVE_LIBPFM
-DHAVE_LIBTRACEEVENT -I/usr/include/traceevent -DLIBTRACEE
VENT_VERSION=3D67072 -DHAVE_RUST_SUPPORT -I/tmp/perf4/libapi/include
-I/tmp/perf4/libbpf/include -I/tmp/perf4/li bsubcmd/include
-I/tmp/perf4/libsymbol/include -I/tmp/perf4/libperf/include
-I/tmp/perf4/ -D"BUILD_STR(s)=3D#s" -c -o
/tmp/perf4/util/annotate-arch/annotate-arm64.o
util/annotate-arch/annotate-arm64.c

2) adding EXTRA_CFLAGS=3D"-fPIC" to your make command. This should force
this option wherever it might be missing.

Thanks,
Ian

> Best regards,
> Jan
>
