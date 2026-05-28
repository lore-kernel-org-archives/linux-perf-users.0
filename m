Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3371A36728E
	for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 21:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780005317; cv=pass; b=G2yjxgvkaQe+J8fuOx+ih5Ze6hsGBQd9ubxBi8ApcBRTlcXlmaS8ETatfgsH4j2jXqwdEbWrEGBTGcQm/Dxszyql2DK7cMfj/lFoRANdJe3b2bQd4Tys7LI28PW9dI3jwmgSX4mFz3z+m4gFsqxm61LL+TPo5l+mhK0XeeGlir4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780005317; c=relaxed/simple;
	bh=6C1SkucgxIRgh8lt1DRB1Efmc3TWLp5H9wprnYVDIXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJi2nAa89RttkitLt7EDrE544NLFubAbp5jDLdPNP1d1S9xbgvNE2o/UJ0Pykn3L+2DqSb2mnPqBqrUvfarCKXXpQGK0AMLOzO57MdD13WBbxI/Mtq+tmZ45Ycw+GolnDwf+GIL4C7QeQHbk/ZArw/9oUtHT+760NowA9+8KBgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jsxwyb9Z; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jsxwyb9Z"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso95ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 14:55:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780005315; cv=none;
        d=google.com; s=arc-20240605;
        b=AxYLLESFKidz01vYqCwuF8+n/0JtoWsLK//vyuAGsC+ArPYdujsEgcOL8G6eCahCL1
         gZYeeXlSzQwJjyrV6zPH02RQZt1ETCCVFA/B9L3U+CjHPAxCgPp9Lji5A1ljcZa+3oeW
         DofQaFyGgNhHl1tX75ifTv7QgNMGvNGFUNjN7EFJv76QJRq06nDryJ8EdYiNQIY6YV2C
         5JBsSf9NwSgvEjuMk0zV3XRGNeOq6IAPfNs0Y7e7QT0vVuIT8+NeQxRyl26Bzgjcby8E
         Z7aw6ZeE4vKB0jTwYcbmxE7PgRa5nVczhHh//WTXIjGokotNDEJUsxL+495aA+t6JkK2
         QfxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ws7d69lMtPQ91m6dq3P8VaFiaUHwV7Nm0Cg3pImGu8Y=;
        fh=UTy2GX3uyst1tLoLiEOZAoYB5oPePxJlfJF5GdhzqIo=;
        b=iI+eW3r75andL4WUgtINN9FUhsl59YHFjcztlA6QKcpixhpC5qlPi+WTncG/GANt7Q
         47RIR7CxjfBt6z2r1RnrWMtW4vagmPa/xC6mgAy5Kz+FKbedcySwwSzmK1OY7aQ7LbFa
         QvxsDM9QwfpTDTazUYWA0SpEpwI+FYTSJ9FgL+G4nl7QXZUl3ufjkmPTgC/q2JFt3G8P
         YadxGDm+KEH3AxlgFPsq5fFDY4GUsfmfAh4vV+kue1+RzBxZNP5/CUec7Oyzo2QYXWag
         XQGpkvUaMduY+n1lXShoMLlHGJOGqXOwVpDHX3I/oQ1eBp+SbhGvVOnJSFn9JF79/VV/
         BKJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780005315; x=1780610115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ws7d69lMtPQ91m6dq3P8VaFiaUHwV7Nm0Cg3pImGu8Y=;
        b=Jsxwyb9ZB/2z0ggKwxN6FHMVsNtWZCJCx7WHWhy+NqD8isyZLpkEJplRDGOo9hCyir
         R0dlIhkRIuA056FM8lGP+Cjssvrj1L1HxZJhDP20gp1n/Cd2PFt0OeNvcOZoLW1YOyZ0
         2ebp3+WB6lzz5rRNq4JQLFNIIqJW3MfSWO7pooxUUKBh3e+V1SzWtL0fA4OreInDj6K+
         wHr+SXDp5yPVD32xzMIR6gWlinQLYTVZVQ4QjEZDgWhRojR0nMXyxV17AaL6mfdjCBRe
         fkplsRPnvBbwLTGfVgO8y17BWc03b8aYkn3TJ9R1yrJyPjMkCBDwQBGghWRI17ZHmIc+
         bphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780005315; x=1780610115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ws7d69lMtPQ91m6dq3P8VaFiaUHwV7Nm0Cg3pImGu8Y=;
        b=jAu9G3swtHmWyLNd97SowfiK8nzu+pu1gXw/KGoTWgsZi7JFSZ+uXGg+ij3yha2buW
         Evzl+8+Rm9sFyTXiQIP2ySIqAi4qP2kAWKDSmvFks4NRNzI5Onw8TGtIftJWZGzYtm1X
         GCit3SYtczct7L9yd53NIT9hS1q/nsKTDrmo/heTFZNH5oanou8qzrT1BfJ3j8GnMOyy
         nr3cD3moHN/pBY5nogGMc7O/9hqxBv4+oUcxcjaQdN4o1n35u7miGjuqpBz0GvKmjh7l
         QGGK3Q7pfyzRU3izAb9V4yVQXtMKLSAuqvs1zcSFiAYU9BxUon2xbUrmUkedST0zpYPk
         O7UQ==
X-Forwarded-Encrypted: i=1; AFNElJ+kUUYbfTZFyzIMBwmVUAGGfnIBdFTudvBZ7PQjZCeQRBeHzqjEBMxe0oJlVB2aJoaANyTYJ/+EfnhpYgMpcjut@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt6/AciOeE7hHkvO0kS4Lb5d4N3Eu+JZLb5PxnkIos+YKHKoov
	LkJe0cZ9N07A2rl+pd1yCFwWBQNSJOIQYgNvnOzs7x3IkLqNxGmvPCvOiWaNEHfAmPo04U8LeD8
	oVOMB03OI0PLA0e2k+dBV5MHYd4wyOn3OwdGxYQWRC5J/q2ghS4ulMIMGhfDJRA==
X-Gm-Gg: Acq92OF6LRtLynDfqJTHgk7gtGR8NE4LxOdc3J5rmiV2gsEPJGSceeXf1eBoaqoJLmO
	kWv0hyggYkPd5BvpG2xagURb0ydX4OAYUNcuRhTDQmLp2kwqYdfvTirwT1gVAXZB0JywZrZwG7w
	Smy5yvrLIh3146iOCZEgF/zfSItFPeJgMmt4mGT+XOCsRgVYf7t5hbu6BoObBUVzxqXk28YA5uR
	g8ihiPTGphYb59YTc1XafRdL4uu+QtWR3CG0F9RRBvvqW3w0sCEh8cjz0EiaY5QfWY6o5YCYyRU
	LSMMLYIhsZopYs+aHLA=
X-Received: by 2002:a17:902:e741:b0:2b9:a39a:e5db with SMTP id
 d9443c01a7336-2bf20d0caa8mr210575ad.7.1780005314900; Thu, 28 May 2026
 14:55:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520125637.105681-1-japo@linux.ibm.com> <20260520130905.9C85D1F000E9@smtp.kernel.org>
 <ahJnMnOr4i9urrRk@x1> <ahV2XGx_6h7upuc3@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <CAP-5=fXGG5PR8neTkozvOUOH83m8_EyZXZ_A7Zyrsock5EqAiQ@mail.gmail.com>
 <ahXITNt0Z-n4NCaj@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <CAP-5=fXcpoXMsezy1FNBX7mhKmRgw+97QmKTg5Fr6G-cY+wGpg@mail.gmail.com> <ahddRWPBk46HiR6x@google.com>
In-Reply-To: <ahddRWPBk46HiR6x@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 28 May 2026 14:55:02 -0700
X-Gm-Features: AVHnY4IA1udd9CKlt7OwwwKYErhkcRNEplR1SwPtHxf_eYO0aLv-Kyup0y7a4b8
Message-ID: <CAP-5=fU8HLj73_FJJfzAF2pVnu8KentCWe4cLWbrjJa5ihRGfg@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf build: Fix Python extension build with GCC 16 hardening
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jan Polensky <japo@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Jens Remus <jremus@linux.ibm.com>, sashiko-reviews@lists.linux.dev, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 2:08=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, May 26, 2026 at 09:59:41AM -0700, Ian Rogers wrote:
> > On Tue, May 26, 2026 at 9:20=E2=80=AFAM Jan Polensky <japo@linux.ibm.co=
m> wrote:
> > >
> > > On Tue, May 26, 2026 at 08:23:28AM -0700, Ian Rogers wrote:
> > > > On Tue, May 26, 2026 at 3:35=E2=80=AFAM Jan Polensky <japo@linux.ib=
m.com> wrote:
> > > > >
> > > > > On Sat, May 23, 2026 at 11:49:22PM -0300, Arnaldo Carvalho de Mel=
o wrote:
> > > > > > On Wed, May 20, 2026 at 01:09:05PM +0000, sashiko-bot@kernel.or=
g wrote:
> > > > > > > Thank you for your contribution! Sashiko AI review found 1 po=
tential issue(s) to consider:
> > > > > > > - [Medium] The patch explicitly allows text relocations in th=
e Python extension shared object (`perf.so`) by adding `-Wl,-z,notext`, mas=
king the root cause of missing `-fPIC` flags and breaking W^X (Write XOR Ex=
ecute) security protections.
> > > > > > > --
> > > > > > >
> > > > > > > commit f3832fb0ad0d1f9c2e69039b2a5110f77d220d5e
> > > > > > > Author: Jan Polensky <japo@linux.ibm.com>
> > > > > > >
> > > > > > > perf build: Fix Python extension build with GCC 16 hardening
> > > > > > >
> > > > > > > This commit addresses a build failure in the Python extension=
 caused by GCC 16
> > > > > > > stricter security policies regarding dynamic relocations in r=
ead-only segments.
> > > > > > > It adds the -Wl,-z,notext flag to the linker to explicitly al=
low text
> > > > > > > relocations in the Python extension shared object.
> > > > > > >
> > > > > > > > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile=
.perf
> > > > > > > > index 76b35ac19acbf..eea170d6576db 100644
> > > > > > > > --- a/tools/perf/Makefile.perf
> > > > > > > > +++ b/tools/perf/Makefile.perf
> > > > > > > > @@ -749,7 +749,7 @@ all: shell_compatibility_test $(ALL_PRO=
GRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
> > > > > > > >  $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)pyt=
hon')
> > > > > > > >
> > > > > > > >  $(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): util/pytho=
n.c util/setup.py $(PERFLIBS_PY)
> > > > > > > > - $(QUIET_GEN)LDSHARED=3D"$(CC) -pthread -shared" \
> > > > > > > > + $(QUIET_GEN)LDSHARED=3D"$(CC) -pthread -shared -Wl,-z,not=
ext" \
> > > > > > >
> > > > > > > [Severity: Medium]
> > > > > > > Does adding -Wl,-z,notext mask the root cause of the GCC 16 l=
inker error?
> > > > > > >
> > > > > > > The error regarding dynamic relocations in a read-only segmen=
t usually
> > > > > > > indicates that non-position-independent code from the static =
libraries
> > > > > > > is being linked into the shared library.
> > > > > > >
> > > > > > > Using -Wl,-z,notext suppresses this error by allowing text re=
locations, which
> > > > > > > forces the dynamic linker to map the executable text segment =
as writable at
> > > > > > > load time. This breaks W^X security protections and weakens t=
he security of
> > > > > > > any Python process loading the extension.
> > > > > > >
> > > > > > > Should the required object files be compiled with -fPIC inste=
ad to properly
> > > > > > > resolve the linker error without compromising security?
> > > > > >
> > > > > > So I asked Claude about this and he suggests doing like other p=
arts of
> > > > > > perf and using -fPIC, can you try to do that?
> > > > > >
> > > > > > ---------------------------------------
> > > > > >
> > > > > > =E2=97=8F Sashiko is right. -Wl,-z,notext is a band-aid that we=
akens security =E2=80=94
> > > > > >   it makes the text segment writable at load time, defeating W^=
X.
> > > > > >
> > > > > >   The root cause is that PERFLIBS_PY (the static libraries link=
ed into
> > > > > >   the Python .so) are compiled without -fPIC. When you link non=
-PIC .a
> > > > > >   archives into a shared library, the linker needs text relocat=
ions. GCC
> > > > > >   16 correctly rejects this by default.
> > > > > >
> > > > > >   The proper fix is to build the static libraries that go into =
the
> > > > > >   Python extension with -fPIC. The perf build system already ha=
s
> > > > > >   precedent for this =E2=80=94 look for how libperf and libsubc=
md handle PIC
> > > > > >   builds. The Python extension's dependencies need a parallel -=
fPIC
> > > > > >   build, or the existing objects need to be compiled with -fPIC=
 when the
> > > > > >   Python binding is enabled.
> > > > > >
> > > > > >   The -Wl,-z,notext approach would also cause issues on distros=
 that
> > > > > >   enforce RELRO + BIND_NOW hardening, and some package builders=
 would
> > > > > >   reject the resulting .so outright.
> > > > > >
> > > > > > - Arnaldo
> > > > >
> > > > > Hi Arnaldo,
> > > > >
> > > > > thanks for the pointer. I double-checked this on s390x and did so=
me reduced-link
> > > > > testing for the ET_DYN / Python-extension case.
> > > > >
> > > > > The failure is not triggered by the perf Python binding object al=
one.
> > > > >
> > > > > A reduced reproducer succeeds when linking:
> > > > >   python.o
> > > > >   + libapi.a
> > > > >   + libperf.a
> > > > >   + libsubcmd.a
> > > > >   + libsymbol.a
> > > > >   + libbpf.a
> > > > >   + libperf-ui.a
> > > > >
> > > > > The link starts to fail with:
> > > > >   /usr/bin/ld.bfd: error: read-only segment has dynamic relocatio=
ns
> > > > >
> > > > > as soon as libperf-util.a is added.
> > > > >
> > > > > In my tree, libperf-util.a currently contains only perf-util-in.o=
, and replacing
> > > > > the archive with that single object still reproduces the same fai=
lure.
> > > > >
> > > > > Reduced reproducer:
> > > > >
> > > > >   gcc -pthread -shared \
> > > > >     -Wl,-z,noexecstack \
> > > > >     -o /tmp/try-perf-util-only.so \
> > > > >     /root/linux/tools/perf/python_ext_build/tmp/root/linux/tools/=
perf/util/python.o \
> > > > >     -Wl,--whole-archive \
> > > > >       /root/linux/tools/perf/libapi/libapi.a \
> > > > >       /root/linux/tools/perf/libperf/libperf.a \
> > > > >       /root/linux/tools/perf/libsubcmd/libsubcmd.a \
> > > > >       /root/linux/tools/perf/libsymbol/libsymbol.a \
> > > > >       /root/linux/tools/perf/libbpf/libbpf.a \
> > > > >       /root/linux/tools/perf/libperf-ui.a \
> > > > >     -Wl,--no-whole-archive \
> > > > >     /root/perf-util-one/perf-util-in.o \
> > > > >     -lpython3.14 -lpthread -ldl -lm -lutil
> > > > >
> > > > > Inspection of perf-util-in.o on s390x shows many direct R_390_PC3=
2DBL
> > > > > relocations from .text against .data.rel.ro, .data.rel.ro.local,
> > > > > .data.rel.local, .bss, and .rodata.
> > > > >
> > > > > Representative examples include:
> > > > >
> > > > >   arm64__associate_instruction_ops:
> > > > >     larl %r6  -> R_390_PC32DBL .data.rel.ro+0x2
> > > > >
> > > > >   loongarch__associate_ins_ops:
> > > > >     larl %r9  -> R_390_PC32DBL .data.rel.ro+0x22
> > > > >     larl %r9  -> R_390_PC32DBL .data.rel.ro+0x42
> > > > >
> > > > >   check_ppc_insn:
> > > > >     larl %r4  -> R_390_PC32DBL .data.rel.local+0x4c2
> > > > >     larl %r2  -> R_390_PC32DBL .data.rel.ro.local+0x22
> > > > >     larl %r1  -> R_390_PC32DBL .data.rel.local+0x2
> > > > >     larl %r2  -> R_390_PC32DBL .data.rel.ro.local+0x2
> > > > >
> > > > >   s390__associate_ins_ops:
> > > > >     larl %r10 -> R_390_PC32DBL .data.rel.ro+0x732
> > > > >     larl %r10 -> R_390_PC32DBL .data.rel.ro+0x752
> > > > >
> > > > > So from my reproducer, I don't think we can describe this simply =
as
> > > > > "all Python-extension dependency archives are missing -fPIC".
> > > > >
> > > > > The issue narrows down much more specifically to perf-util-in.o i=
n the ET_DYN
> > > > > link of the Python extension, and the direct text-to-data section=
 relocations
> > > > > above look like the most relevant candidates.
> > > > >
> > > > > So I agree that -Wl,-z,notext is only a workaround. I'd prefer to=
 understand
> > > > > and fix the underlying relocation pattern in perf-util-in.o rathe=
r than merge
> > > > > that as-is.
> > > > >
> > > > > If useful, I can send the relevant readelf/objdump snippets in a =
follow-up.
> > > >
> > > > Hi Jan,
> > > >
> > > > I wonder about two tests:
> > > > 1) adding V=3D1 JOBS=3D1 to your make command to switch on single
> > > > threading and build verbosity. This may make it possible to identif=
y
> > > > the gcc command that is missing -fPIC. For example, I see -fPIC on
> > > > x86:
> > > >   gcc -Wp,-MD,/tmp/perf4/util/annotate-arch/.annotate-arm64.o.d
> > > > -Wp,-MT,/tmp/perf4/util/annotate-arch/annotate -arm64.o
> > > > -Wbad-function-cast -Wdeclaration-after-statement -Wformat-security
> > > > -Wformat-y2k -Winit-self -Wmissin g-declarations -Wmissing-prototyp=
es
> > > > -Wno-system-headers -Wold-style-definition -Wpacked -Wredundant-dec=
ls
> > > > -Wst rict-prototypes -Wswitch-default -Wswitch-enum -Wundef
> > > > -Wwrite-strings -Wformat -Wno-type-limits -Wstrict-alia sing=3D3
> > > > -Wshadow -fno-strict-aliasing -I/tmp/perf4/arch/x86/include/generat=
ed
> > > > -DHAVE_ARCH_X86_64_SUPPORT -Werro r -g -fno-omit-frame-pointer -Wal=
l
> > > > -Wextra -std=3Dgnu11 -funsigned-char -fstack-protector-all
> > > > -D_LARGEFILE64_SOU RCE -D_FILE_OFFSET_BITS=3D64 -D_GNU_SOURCE
> > > > -I~/linux/tools/perf/util/include
> > > > -I~/linux/tools/perf/arch/x86/include
> > > > -I/usr/local/google/home/irogers/re pos/linux4/tools/include/
> > > > -I~/linux/tools/arch/x86/include/uapi -I/usr/loc
> > > > al/google/home/irogers/repos/linux4/tools/include/uapi
> > > > -I~/linux/tools/arc h/x86/include/ -I~/linux/tools/arch/x86/
> > > > -I/tmp/perf4//util -I/tmp/perf4/ -I~/linux/tools/perf/util
> > > > -I~/linux/to ols/perf -DHAVE_PTHREAD_ATTR_SETAFFINITY_NP
> > > > -DHAVE_PTHREAD_BARRIER -DHAVE_EVENTFD_SUPPORT -DHAVE_GETTID -DHAVE
> > > > _FILE_HANDLE -DHAVE_AIO_SUPPORT -DHAVE_SCANDIRAT_SUPPORT
> > > > -DHAVE_SCHED_GETCPU_SUPPORT -DHAVE_SETNS_SUPPORT -DHA VE_ZLIB_SUPPO=
RT
> > > > -DHAVE_LIBELF_SUPPORT -DHAVE_ELF_GETPHDRNUM_SUPPORT
> > > > -DHAVE_GELF_GETNOTE_SUPPORT -DHAVE_ELF_GET SHDRSTRNDX_SUPPORT
> > > > -DHAVE_DEBUGINFOD_SUPPORT -DHAVE_LIBDW_SUPPORT -DHAVE_LIBBPF_SUPPOR=
T
> > > > -DHAVE_SDT_EVENT -DHAV E_JITDUMP -DHAVE_LIBOPENSSL_SUPPORT
> > > > -DHAVE_BPF_SKEL -DHAVE_DWARF_UNWIND_SUPPORT -DHAVE_SLANG_SUPPORT
> > > > -DHAVE_TI MERFD_SUPPORT -fPIC -DHAVE_LIBLLVM_SUPPORT
> > > > -I/usr/lib/llvm-19/include -D_GNU_SOURCE -D__STDC_CONSTANT_MACROS
> > > > -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS
> > > > -DHAVE_CXA_DEMANGLE_SUPPORT -DHAVE_LZMA_SUPPORT -DHAVE_ZSTD_SUPPORT
> > > > -DHAVE_BACKTRACE_SUPPORT -DHAVE_LIBNUMA_SUPPORT
> > > > -DHAVE_PERF_READ_VDSO32 -DHAVE_LIBBABELTRACE_SUPPORT -DHAVE_
> > > > LIBCAPSTONE_SUPPORT -DHAVE_JVMTI_CMLR -DHAVE_LIBPFM
> > > > -DHAVE_LIBTRACEEVENT -I/usr/include/traceevent -DLIBTRACEE
> > > > VENT_VERSION=3D67072 -DHAVE_RUST_SUPPORT -I/tmp/perf4/libapi/includ=
e
> > > > -I/tmp/perf4/libbpf/include -I/tmp/perf4/li bsubcmd/include
> > > > -I/tmp/perf4/libsymbol/include -I/tmp/perf4/libperf/include
> > > > -I/tmp/perf4/ -D"BUILD_STR(s)=3D#s" -c -o
> > > > /tmp/perf4/util/annotate-arch/annotate-arm64.o
> > > > util/annotate-arch/annotate-arm64.c
> > > >
> > > > 2) adding EXTRA_CFLAGS=3D"-fPIC" to your make command. This should =
force
> > > > this option wherever it might be missing.
> > > >
> > > > Thanks,
> > > > Ian
> > > >
> > > > > Best regards,
> > > > > Jan
> > > > >
> > > Hi Ian,
> > >
> > > I tested both suggestions the second in the beginning of my research:
> > >
> > > EXTRA_CFLAGS=3D"-fPIC" - Does NOT work. Same error:
> > >
> > > /usr/bin/ld.bfd: error: read-only segment has dynamic relocations
> > > collect2: error: ld returned 1 exit status
> > >
> > > The issue is s390x-specific R_390_PC32DBL relocations in perf-util-in=
.o
> > > (from `larl` instructions) that persist even with -fPIC.
> > >
> > > Current options:
> > > 1. Use -Wl,-z,notext (security issue)
> > > 2. Refactor code to avoid these relocations
> > > 3. Disable Python extension on s390x (not an option)
> > >
> > > Thoughts?
> >
> > So it appears that part of the problem is declaring arrays and structs
> > to be const. Making things non-const I think is also not an option.
> > Would  EXTRA_CFLAGS=3D"-fvisibility=3Dhidden" help?
> >
> > It would we interesting to build with -Wl,-z,notext and then look for
> > the symbol the linker is fighting with:
> >   eu-findtextrel perf.cpython....so
> > or
> >   readelf -d perf.so | grep TEXTREL
> >   readelf -r perf.so
>
> I'm curious if it's s390 specific.  I don't know what code patterns make
> it relocatable.  Is taking an address of struct ins_ops variable a
> problem?  Does it matter being a static variable?

So what I think the problem is that:

  arm64__associate_instruction_ops:
    larl %r6  -> R_390_PC32DBL .data.rel.ro+0x2

points at the arm64__associate_instruction_ops code:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/annotate-arch/annotate-arm64.c?h=3Dperf-tools-next#n=
79
```c
static const struct ins_ops *arm64__associate_instruction_ops(struct
arch *arch, const char *name)
{
struct arch_arm64 *arm =3D container_of(arch, struct arch_arm64, arch);
const struct ins_ops *ops;
regmatch_t match[2];

if (!regexec(&arm->jump_insn, name, 2, match, 0))
ops =3D &jump_ops;
```

jump_ops is declared extern in disasm.h:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/disasm.h?h=3Dperf-tools-next#n117
```c
tools/perf/util/disasm.h:extern const struct ins_ops jump_ops;
```

Since `jump_ops` is declared `extern` and would be patchable in a
shared DSO (i.e., the Python module), GCC is creating relocations
within .text that fails W^X checking in the linker. To prevent
jump_ops from being patchable in this situation we can change its
declaration to:
```c
__attribute__((visibility("hidden"))) extern const struct ins_ops jump_ops;
```

but it is probably easier and more generic to add -fvisibility=3Dhidden
to the CFLAGS in Makefile.config. I asked about this behavior as an
EXTRA_CFLAGS option, but I'm not sure if Jan has tested it yet?

Thanks,
Ian

> Thanks,
> Namhyung
>
