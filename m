Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8B4402B99
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779814797; cv=pass; b=HUkCRwe+juZeFnIdSJmK/7UOnhUg0jJEmS7q6puYro4HSWZZZemuxGti9In12n4CZtADk+sH3i9uSNpZQfUT8zYe/2TiH6cQgUZuBDKQTmuG/WLBlVCySXGZ2dKWykM4+8kCSrnZuN2CH5YxJ2i5M/6pqsWo4rTPp/CNwSbxGW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779814797; c=relaxed/simple;
	bh=WZkvs3bev0qC/nipB5HxUTgW5bQClI/7XG/939lcsKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hiETw0i9dp7xAbMNBFb2kHpuGpI7tDaFqkQcmtaIfZe1GTn7sXG3/ZuI1eXf0YA/4t61ETZaP+F9FrwsUNfUSPfPfoU+6sqP/XWqj0D6VkBvRSYmplS/yCMEqUy1uf6PEFwjwfJj8kDLMukcJE6UpdbKnL/kqB94uBHobnFFZ5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y4d9GhS3; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y4d9GhS3"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ba180a022dso1595ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 09:59:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779814793; cv=none;
        d=google.com; s=arc-20240605;
        b=YcutuhrkBx75/nrlXc+7sp+SFjes3czvPNq4y5vK8sCKbWdn6ORynl+2YmDqhlOr9k
         9VYBG1HlTGoorY5wLWcAsu+uRrK/KtQQar2PSw/ksSMOzgQDP5kMThjdWpkiG3W4t1bG
         /mnSf97D3wCdefuJRwxomSwitN8XOMD+tIhQ88Ettobi75Si5EnvYv45nsGX7+3LqAZK
         Ul7k1toEtm5MlxRWIbb0JCPkX3n8c89dwr5uP+zpRh9xHufxpKXZDmEd3zJ5xC1PARUb
         E0Pc37QqX+0Ft5ZBXIG+yHJFD22O0YKtAoP4eh1WSLS3+Ly2jiuwqtUvDWBP3unSsxLO
         kWYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vWiWq0NulcgqvDrKIIYI7AeTVlxrlXpp7vc3dk6gWPs=;
        fh=TbLvBSrBD5kmWuSJ4X2CadLvhMmccFNjulz/UP7B5h8=;
        b=FNhkr9DXK8L5N+x8i3WLI5G3M0nAw+/BneLYqXQClTMVLhwQNfuZliIuK80dOHUiu9
         +7qCL22LZ8p55frnuHyKX4hZ0fEqTAaJ2FW/VyZh+Zvjd1j4/DlFmQxlwF5iM1Z+22Vj
         5z/wYMo7GwUU0Ql0TtmiWYPEfJJMnIKsvuShE/oEOCOJTQL7tJ4p1+zVq77o281CKqDd
         ncA2f+pSbuGrAEuFl/kV/cvvwBnI323jTiYrhJSgeqP4NtqAJfkazoVXqoNb7brDMELT
         DJiVC7wpkQlkrboKbZQzhb+Ivz194XbVKDtASAUXj5u0uef3MRifTqEIrNGHCT6aWp6+
         CG7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779814793; x=1780419593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWiWq0NulcgqvDrKIIYI7AeTVlxrlXpp7vc3dk6gWPs=;
        b=Y4d9GhS3mVrbPzVXuaRRpQhX/8a2eqi/UZY333FrnaCXvItecW08cyOL61bnLe/onx
         ARHePvKnSAAAKF5t86yc1z2pfySwrKcL6ZYTk7WgDjPxoZ/hI/7eqURNeUZTxhfTnWNf
         3LSDU/GO7B72kjCUh5ErDZBpNA/waN7tsVkIHRzybDPe94WBW5HGhTUit162gDYzFvas
         xVmInqY/TrVGaJP+H45WyiUB3CR6eoBgcMhAgIkup8azaAlPxHYVMGSdifWW5rzJHczg
         Tw0sKmRr9BY6NgEue7fx209In+N9OBt1hqGWBCiZ/vhn2e3WqPhbNl0W6e3RUCZRQf1q
         5Sfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779814793; x=1780419593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vWiWq0NulcgqvDrKIIYI7AeTVlxrlXpp7vc3dk6gWPs=;
        b=DZb9uAnUae6jB1OP6/bGbTj/ScVR8p/ZUpJBV7LdB3zp0eoRl0ZE7sqF8I/2/81ia0
         OlBoTfojdHPZyLIiAIXUcnQepbcSbSq93hVMO1dbwcpgbj07rAXXZ2VU//Li0HJZ/Igc
         xZv489IIP0m4mr6GG/pJLaFm3is3yjDtgfosMlFaufzxhGC0yFV5WEh/ZiRuMBhg6rJm
         3Ou5LyDa46WhqulUJoPMwV1tlrdUxfWbnCW9HIoC1SATkP/swvXiWHH8d4SmWbDiy9vC
         SmWuW8DR0ovsJKEsjZ4QkYiBO8JII7n2HOKo6xIGtElYhTaEqR75UAE0ZAqFkrS+VU2H
         KejQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Dx5mQeN4iwmT3f/sAwmDpptftecRQ67gpWroukU2/TbF1LQFBNjKPp9rCjbAX8SgL0ryXFSjYe0S/fEu7W0kS@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs7H5GYUKbN8j9yGf9NUUeqnr9PtI0a7KukRDRpuL80LBZMGb6
	modeqoUqjI5AXHh64T1V5IWmDpQDJhtfEZp0bvPX822sMYwxDxTajrz8kZ5O9TuAoW+FuV9J4sF
	kCyWZk4waAUh0JrFVeHvdMWrk7TSCf5XEFwNvjnc5
X-Gm-Gg: Acq92OElOy6t/6wPv1S/BOa8ztEAACGmSR3sGmuISv6L5uU6br3MaAnHjk94R08Ugtd
	bTm+zvnMTHqEgNGrBghFNfjdMykwREPrwwyMY6VKZBtXoUkEWxFL6c0oHrWp81E/LlJ3ZuSpGl6
	4SrhU3NI4BnNn23Az37/R3G6QwPZc7D7+ppn6jWmu9d4lMmovGiHDhVJofKUAm162BSsEC9lChj
	o/XlKUsz3a57ppMy/tfERZ8MhyhrOcSit2YHxjgVnEhKtesxzZAgFnvIbvwTCUSUTiEVvHSTz1B
	sjCjo/ZmDH4karK4O5j/25NLy/+jZFopS71XixUiHEUPDTIS
X-Received: by 2002:a17:902:f706:b0:2bd:a61:8536 with SMTP id
 d9443c01a7336-2bebe9e94d5mr6474175ad.6.1779814792610; Tue, 26 May 2026
 09:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520125637.105681-1-japo@linux.ibm.com> <20260520130905.9C85D1F000E9@smtp.kernel.org>
 <ahJnMnOr4i9urrRk@x1> <ahV2XGx_6h7upuc3@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <CAP-5=fXGG5PR8neTkozvOUOH83m8_EyZXZ_A7Zyrsock5EqAiQ@mail.gmail.com> <ahXITNt0Z-n4NCaj@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
In-Reply-To: <ahXITNt0Z-n4NCaj@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 26 May 2026 09:59:41 -0700
X-Gm-Features: AVHnY4LmLJBzV1k9Go06SgxSrWFmnXJjBWXm4pXUs6_yao5GukFZwF_YTa1b5iI
Message-ID: <CAP-5=fXcpoXMsezy1FNBX7mhKmRgw+97QmKTg5Fr6G-cY+wGpg@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf build: Fix Python extension build with GCC 16 hardening
To: Jan Polensky <japo@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jens Remus <jremus@linux.ibm.com>, 
	sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 9:20=E2=80=AFAM Jan Polensky <japo@linux.ibm.com> w=
rote:
>
> On Tue, May 26, 2026 at 08:23:28AM -0700, Ian Rogers wrote:
> > On Tue, May 26, 2026 at 3:35=E2=80=AFAM Jan Polensky <japo@linux.ibm.co=
m> wrote:
> > >
> > > On Sat, May 23, 2026 at 11:49:22PM -0300, Arnaldo Carvalho de Melo wr=
ote:
> > > > On Wed, May 20, 2026 at 01:09:05PM +0000, sashiko-bot@kernel.org wr=
ote:
> > > > > Thank you for your contribution! Sashiko AI review found 1 potent=
ial issue(s) to consider:
> > > > > - [Medium] The patch explicitly allows text relocations in the Py=
thon extension shared object (`perf.so`) by adding `-Wl,-z,notext`, masking=
 the root cause of missing `-fPIC` flags and breaking W^X (Write XOR Execut=
e) security protections.
> > > > > --
> > > > >
> > > > > commit f3832fb0ad0d1f9c2e69039b2a5110f77d220d5e
> > > > > Author: Jan Polensky <japo@linux.ibm.com>
> > > > >
> > > > > perf build: Fix Python extension build with GCC 16 hardening
> > > > >
> > > > > This commit addresses a build failure in the Python extension cau=
sed by GCC 16
> > > > > stricter security policies regarding dynamic relocations in read-=
only segments.
> > > > > It adds the -Wl,-z,notext flag to the linker to explicitly allow =
text
> > > > > relocations in the Python extension shared object.
> > > > >
> > > > > > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.per=
f
> > > > > > index 76b35ac19acbf..eea170d6576db 100644
> > > > > > --- a/tools/perf/Makefile.perf
> > > > > > +++ b/tools/perf/Makefile.perf
> > > > > > @@ -749,7 +749,7 @@ all: shell_compatibility_test $(ALL_PROGRAM=
S) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
> > > > > >  $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python'=
)
> > > > > >
> > > > > >  $(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): util/python.c =
util/setup.py $(PERFLIBS_PY)
> > > > > > - $(QUIET_GEN)LDSHARED=3D"$(CC) -pthread -shared" \
> > > > > > + $(QUIET_GEN)LDSHARED=3D"$(CC) -pthread -shared -Wl,-z,notext"=
 \
> > > > >
> > > > > [Severity: Medium]
> > > > > Does adding -Wl,-z,notext mask the root cause of the GCC 16 linke=
r error?
> > > > >
> > > > > The error regarding dynamic relocations in a read-only segment us=
ually
> > > > > indicates that non-position-independent code from the static libr=
aries
> > > > > is being linked into the shared library.
> > > > >
> > > > > Using -Wl,-z,notext suppresses this error by allowing text reloca=
tions, which
> > > > > forces the dynamic linker to map the executable text segment as w=
ritable at
> > > > > load time. This breaks W^X security protections and weakens the s=
ecurity of
> > > > > any Python process loading the extension.
> > > > >
> > > > > Should the required object files be compiled with -fPIC instead t=
o properly
> > > > > resolve the linker error without compromising security?
> > > >
> > > > So I asked Claude about this and he suggests doing like other parts=
 of
> > > > perf and using -fPIC, can you try to do that?
> > > >
> > > > ---------------------------------------
> > > >
> > > > =E2=97=8F Sashiko is right. -Wl,-z,notext is a band-aid that weaken=
s security =E2=80=94
> > > >   it makes the text segment writable at load time, defeating W^X.
> > > >
> > > >   The root cause is that PERFLIBS_PY (the static libraries linked i=
nto
> > > >   the Python .so) are compiled without -fPIC. When you link non-PIC=
 .a
> > > >   archives into a shared library, the linker needs text relocations=
. GCC
> > > >   16 correctly rejects this by default.
> > > >
> > > >   The proper fix is to build the static libraries that go into the
> > > >   Python extension with -fPIC. The perf build system already has
> > > >   precedent for this =E2=80=94 look for how libperf and libsubcmd h=
andle PIC
> > > >   builds. The Python extension's dependencies need a parallel -fPIC
> > > >   build, or the existing objects need to be compiled with -fPIC whe=
n the
> > > >   Python binding is enabled.
> > > >
> > > >   The -Wl,-z,notext approach would also cause issues on distros tha=
t
> > > >   enforce RELRO + BIND_NOW hardening, and some package builders wou=
ld
> > > >   reject the resulting .so outright.
> > > >
> > > > - Arnaldo
> > >
> > > Hi Arnaldo,
> > >
> > > thanks for the pointer. I double-checked this on s390x and did some r=
educed-link
> > > testing for the ET_DYN / Python-extension case.
> > >
> > > The failure is not triggered by the perf Python binding object alone.
> > >
> > > A reduced reproducer succeeds when linking:
> > >   python.o
> > >   + libapi.a
> > >   + libperf.a
> > >   + libsubcmd.a
> > >   + libsymbol.a
> > >   + libbpf.a
> > >   + libperf-ui.a
> > >
> > > The link starts to fail with:
> > >   /usr/bin/ld.bfd: error: read-only segment has dynamic relocations
> > >
> > > as soon as libperf-util.a is added.
> > >
> > > In my tree, libperf-util.a currently contains only perf-util-in.o, an=
d replacing
> > > the archive with that single object still reproduces the same failure=
.
> > >
> > > Reduced reproducer:
> > >
> > >   gcc -pthread -shared \
> > >     -Wl,-z,noexecstack \
> > >     -o /tmp/try-perf-util-only.so \
> > >     /root/linux/tools/perf/python_ext_build/tmp/root/linux/tools/perf=
/util/python.o \
> > >     -Wl,--whole-archive \
> > >       /root/linux/tools/perf/libapi/libapi.a \
> > >       /root/linux/tools/perf/libperf/libperf.a \
> > >       /root/linux/tools/perf/libsubcmd/libsubcmd.a \
> > >       /root/linux/tools/perf/libsymbol/libsymbol.a \
> > >       /root/linux/tools/perf/libbpf/libbpf.a \
> > >       /root/linux/tools/perf/libperf-ui.a \
> > >     -Wl,--no-whole-archive \
> > >     /root/perf-util-one/perf-util-in.o \
> > >     -lpython3.14 -lpthread -ldl -lm -lutil
> > >
> > > Inspection of perf-util-in.o on s390x shows many direct R_390_PC32DBL
> > > relocations from .text against .data.rel.ro, .data.rel.ro.local,
> > > .data.rel.local, .bss, and .rodata.
> > >
> > > Representative examples include:
> > >
> > >   arm64__associate_instruction_ops:
> > >     larl %r6  -> R_390_PC32DBL .data.rel.ro+0x2
> > >
> > >   loongarch__associate_ins_ops:
> > >     larl %r9  -> R_390_PC32DBL .data.rel.ro+0x22
> > >     larl %r9  -> R_390_PC32DBL .data.rel.ro+0x42
> > >
> > >   check_ppc_insn:
> > >     larl %r4  -> R_390_PC32DBL .data.rel.local+0x4c2
> > >     larl %r2  -> R_390_PC32DBL .data.rel.ro.local+0x22
> > >     larl %r1  -> R_390_PC32DBL .data.rel.local+0x2
> > >     larl %r2  -> R_390_PC32DBL .data.rel.ro.local+0x2
> > >
> > >   s390__associate_ins_ops:
> > >     larl %r10 -> R_390_PC32DBL .data.rel.ro+0x732
> > >     larl %r10 -> R_390_PC32DBL .data.rel.ro+0x752
> > >
> > > So from my reproducer, I don't think we can describe this simply as
> > > "all Python-extension dependency archives are missing -fPIC".
> > >
> > > The issue narrows down much more specifically to perf-util-in.o in th=
e ET_DYN
> > > link of the Python extension, and the direct text-to-data section rel=
ocations
> > > above look like the most relevant candidates.
> > >
> > > So I agree that -Wl,-z,notext is only a workaround. I'd prefer to und=
erstand
> > > and fix the underlying relocation pattern in perf-util-in.o rather th=
an merge
> > > that as-is.
> > >
> > > If useful, I can send the relevant readelf/objdump snippets in a foll=
ow-up.
> >
> > Hi Jan,
> >
> > I wonder about two tests:
> > 1) adding V=3D1 JOBS=3D1 to your make command to switch on single
> > threading and build verbosity. This may make it possible to identify
> > the gcc command that is missing -fPIC. For example, I see -fPIC on
> > x86:
> >   gcc -Wp,-MD,/tmp/perf4/util/annotate-arch/.annotate-arm64.o.d
> > -Wp,-MT,/tmp/perf4/util/annotate-arch/annotate -arm64.o
> > -Wbad-function-cast -Wdeclaration-after-statement -Wformat-security
> > -Wformat-y2k -Winit-self -Wmissin g-declarations -Wmissing-prototypes
> > -Wno-system-headers -Wold-style-definition -Wpacked -Wredundant-decls
> > -Wst rict-prototypes -Wswitch-default -Wswitch-enum -Wundef
> > -Wwrite-strings -Wformat -Wno-type-limits -Wstrict-alia sing=3D3
> > -Wshadow -fno-strict-aliasing -I/tmp/perf4/arch/x86/include/generated
> > -DHAVE_ARCH_X86_64_SUPPORT -Werro r -g -fno-omit-frame-pointer -Wall
> > -Wextra -std=3Dgnu11 -funsigned-char -fstack-protector-all
> > -D_LARGEFILE64_SOU RCE -D_FILE_OFFSET_BITS=3D64 -D_GNU_SOURCE
> > -I~/linux/tools/perf/util/include
> > -I~/linux/tools/perf/arch/x86/include
> > -I/usr/local/google/home/irogers/re pos/linux4/tools/include/
> > -I~/linux/tools/arch/x86/include/uapi -I/usr/loc
> > al/google/home/irogers/repos/linux4/tools/include/uapi
> > -I~/linux/tools/arc h/x86/include/ -I~/linux/tools/arch/x86/
> > -I/tmp/perf4//util -I/tmp/perf4/ -I~/linux/tools/perf/util
> > -I~/linux/to ols/perf -DHAVE_PTHREAD_ATTR_SETAFFINITY_NP
> > -DHAVE_PTHREAD_BARRIER -DHAVE_EVENTFD_SUPPORT -DHAVE_GETTID -DHAVE
> > _FILE_HANDLE -DHAVE_AIO_SUPPORT -DHAVE_SCANDIRAT_SUPPORT
> > -DHAVE_SCHED_GETCPU_SUPPORT -DHAVE_SETNS_SUPPORT -DHA VE_ZLIB_SUPPORT
> > -DHAVE_LIBELF_SUPPORT -DHAVE_ELF_GETPHDRNUM_SUPPORT
> > -DHAVE_GELF_GETNOTE_SUPPORT -DHAVE_ELF_GET SHDRSTRNDX_SUPPORT
> > -DHAVE_DEBUGINFOD_SUPPORT -DHAVE_LIBDW_SUPPORT -DHAVE_LIBBPF_SUPPORT
> > -DHAVE_SDT_EVENT -DHAV E_JITDUMP -DHAVE_LIBOPENSSL_SUPPORT
> > -DHAVE_BPF_SKEL -DHAVE_DWARF_UNWIND_SUPPORT -DHAVE_SLANG_SUPPORT
> > -DHAVE_TI MERFD_SUPPORT -fPIC -DHAVE_LIBLLVM_SUPPORT
> > -I/usr/lib/llvm-19/include -D_GNU_SOURCE -D__STDC_CONSTANT_MACROS
> > -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS
> > -DHAVE_CXA_DEMANGLE_SUPPORT -DHAVE_LZMA_SUPPORT -DHAVE_ZSTD_SUPPORT
> > -DHAVE_BACKTRACE_SUPPORT -DHAVE_LIBNUMA_SUPPORT
> > -DHAVE_PERF_READ_VDSO32 -DHAVE_LIBBABELTRACE_SUPPORT -DHAVE_
> > LIBCAPSTONE_SUPPORT -DHAVE_JVMTI_CMLR -DHAVE_LIBPFM
> > -DHAVE_LIBTRACEEVENT -I/usr/include/traceevent -DLIBTRACEE
> > VENT_VERSION=3D67072 -DHAVE_RUST_SUPPORT -I/tmp/perf4/libapi/include
> > -I/tmp/perf4/libbpf/include -I/tmp/perf4/li bsubcmd/include
> > -I/tmp/perf4/libsymbol/include -I/tmp/perf4/libperf/include
> > -I/tmp/perf4/ -D"BUILD_STR(s)=3D#s" -c -o
> > /tmp/perf4/util/annotate-arch/annotate-arm64.o
> > util/annotate-arch/annotate-arm64.c
> >
> > 2) adding EXTRA_CFLAGS=3D"-fPIC" to your make command. This should forc=
e
> > this option wherever it might be missing.
> >
> > Thanks,
> > Ian
> >
> > > Best regards,
> > > Jan
> > >
> Hi Ian,
>
> I tested both suggestions the second in the beginning of my research:
>
> EXTRA_CFLAGS=3D"-fPIC" - Does NOT work. Same error:
>
> /usr/bin/ld.bfd: error: read-only segment has dynamic relocations
> collect2: error: ld returned 1 exit status
>
> The issue is s390x-specific R_390_PC32DBL relocations in perf-util-in.o
> (from `larl` instructions) that persist even with -fPIC.
>
> Current options:
> 1. Use -Wl,-z,notext (security issue)
> 2. Refactor code to avoid these relocations
> 3. Disable Python extension on s390x (not an option)
>
> Thoughts?

So it appears that part of the problem is declaring arrays and structs
to be const. Making things non-const I think is also not an option.
Would  EXTRA_CFLAGS=3D"-fvisibility=3Dhidden" help?

It would we interesting to build with -Wl,-z,notext and then look for
the symbol the linker is fighting with:
  eu-findtextrel perf.cpython....so
or
  readelf -d perf.so | grep TEXTREL
  readelf -r perf.so

Thanks,
Ian

> Best regards,
> Jan
