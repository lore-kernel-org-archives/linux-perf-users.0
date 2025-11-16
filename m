Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA9A1917ED
	for <linux-perf-users@vger.kernel.org>; Sun, 16 Nov 2025 07:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763277713; cv=none; b=NvXGtMA5fLsTiojlpV1xbaW/gw+m1zJ/P39Ik/9/A26Vrg376bnk9e9wAUSn+tBYsB3lVX1KlAsPWduW4uB9flLGPqHex5vgP3wH57QryxpyAx/4BvGTDhGbW4P97NdZuhq3U/+mr0qE48P6GYfaMRNq3zSZKK7i8z7NY78Bt6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763277713; c=relaxed/simple;
	bh=fSHL3sd9Gbbrp1gQtngQIUSDsPeVMgQ7JrxPCW2iXqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqUFJUMMOafPiuoLJdpvrDCfAh14ucdUMaWcmvkEFBHOB85Bnlemv8KJh/i0jdlH+koFvkp80yMjX9rZ9MU8GtTgvyRXOH4/Y/CVx/8adRXLRs0r0LWc1IZMRLYpsHQTRkx6b5dN+MvF8cn3jCalY54e23TzHWMZGcAVP0cyofA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5dfb5fcf063so986664137.1
        for <linux-perf-users@vger.kernel.org>; Sat, 15 Nov 2025 23:21:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763277709; x=1763882509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hqg0bjLSAES7daJaMwwXzpjllo/mE++1WP9GUNGDNAI=;
        b=RL/JUuSISYAuoKgL0kA3nL967iw1I3DwZ1lnIsOvqDVMchT93h6kJXBSpKHbGEEQcH
         AaD+SSSLBZ2IC408Q3xe5ntwHcZ2u5t/yfBG6rIPSycx4YDGlX+ZlxOrjjFGELJ9iBWh
         7O8KUXZ74+O3KRe8EyrqoPsZBPzUsJzAmT+ONg9THqGnTrPgKwWbkg0X1yloCYN3u0RK
         7XBhJukR7QTcHp+kFmWBtPI2pzV2Aark8Ngz2Val/HhUQ3lp5JKKAcoM5iHQItsDWmVW
         VRlXc3HokwBmLXupSRyhElj/8tspUOROKKX62J7POEHYzOStwdHh4HZF5KkaE7gwo8Wm
         s6rw==
X-Forwarded-Encrypted: i=1; AJvYcCWqh0o9LfQoZjHZHIiM7BqWpFNjJegSCI0uit/DtcqT4EKGfNACiVdeIOn/tAzIrVypjeOBUdn4jfoqROFYch6l@vger.kernel.org
X-Gm-Message-State: AOJu0YxlpT2JjyefCmzMZVtZiXLZJvkWwSiApq7VfsnVOrd/g0DUkpAH
	Q4QEzxSyuk9qhXH83asPmJWb6otR5XEEAZIgUkV+JlOCTCVg/3qTgAV+OYH4rQ==
X-Gm-Gg: ASbGnctE8YI70u+lfm9SQ6oIq51OxLoyKcVhCdpBloR3vkPGtcvnIVoPQvVjmY0tTLe
	xtiHKnrphA4PmG7tnqukqWklQgc+bjubfrimeX9XdvTBWc/TtppqYdKAjMUFs0TRoJIbyamX2ib
	v6w+VpXGTo4sYFFtr6UCuvaPPQbZdebM5H81TYh6612lllYx2wfM4bLq8V6UoUngqk4k1VVRaHa
	MeFJOBwPPPUhwPJ2a8VQdOiEz9iEVSr9ZXq+8teeq0ElxPZQ5UyJkCV66XGaFqcsVfV5mDFHsIN
	VcAgtg7SmTrY5aC6pQ6tZkwU2DXZwMYGe45F2B6u0RE5I7pqeE4ss6jpM6W1D94yhUPu43+an3+
	3b7CuhAxZZxY3IlRbmqRBpgc1zIlJ/yvcXlm7/FzqQQMhTlcgo4qtdgwc4LA+BTFfFIS9TZd+2f
	CZbm1aGe6TvxUVUPIXcNv9bI5BN2+9KVMKdKuUZcgNBJQujPWUWYo=
X-Google-Smtp-Source: AGHT+IFFrd5x46A32+GRn/bpo1XGzsy5FxdKG2YKZxoWs+k/y00AumfHpzBiu4Isnsq0SoiwDgSKGw==
X-Received: by 2002:a05:6102:d92:b0:5db:23ed:3840 with SMTP id ada2fe7eead31-5dfc5a5e77fmr2580264137.37.1763277709408;
        Sat, 15 Nov 2025 23:21:49 -0800 (PST)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-937610ce60bsm2926289241.3.2025.11.15.23.21.49
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Nov 2025 23:21:49 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5dde4444e0cso1168396137.0
        for <linux-perf-users@vger.kernel.org>; Sat, 15 Nov 2025 23:21:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUA2mgFf9GksJO9d1v+eFnnuHabGYPsI7pYQkAMtrbRPljU7E578KOnMryxno135/vB+bjk4CcQJ6owpp5s7b+g@vger.kernel.org
X-Received: by 2002:a05:6102:3596:b0:5b1:15:1986 with SMTP id
 ada2fe7eead31-5dfc55371b4mr2501850137.15.1763277709074; Sat, 15 Nov 2025
 23:21:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114092914.217533-1-namhyung@kernel.org> <CAP-5=fWsFLkYGFFyzSrpZNdRLpjaTZAuW7-YVUr-zMVH5dk8eg@mail.gmail.com>
 <aRd7iJJxgT-0G8Ky@google.com> <CAP-5=fUC88TVwnjTuTgU+s=LqqP0xOhNTG5hU27cSbaZRH7Jpg@mail.gmail.com>
In-Reply-To: <CAP-5=fUC88TVwnjTuTgU+s=LqqP0xOhNTG5hU27cSbaZRH7Jpg@mail.gmail.com>
From: Fangrui Song <maskray@sourceware.org>
Date: Sat, 15 Nov 2025 23:22:04 -0800
X-Gmail-Original-Message-ID: <CAN30aBHWef0kKWPkvx9NZ4nJjdz97PJ7s_68h-ddZ3e8VzYW3A@mail.gmail.com>
X-Gm-Features: AWmQ_bm5hukHAbV38L3RXVaN5pYjuZWE37O-ylgNz3OdGsdQI_siuDB0gtH03t0
Message-ID: <CAN30aBHWef0kKWPkvx9NZ4nJjdz97PJ7s_68h-ddZ3e8VzYW3A@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf jitdump: Add load_addr to build-ID generation
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, maskray@sourceware.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>, 
	Pablo Galindo <pablogsal@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 11:33=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Fri, Nov 14, 2025 at 10:57=E2=80=AFAM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> >
> > On Fri, Nov 14, 2025 at 09:33:29AM -0800, Ian Rogers wrote:
> > > On Fri, Nov 14, 2025 at 1:29=E2=80=AFAM Namhyung Kim <namhyung@kernel=
.org> wrote:
> > > >
> > > > It was reported that python backtrace with JIT dump was broken afte=
r the
> > > > change to built-in SHA-1 implementation.  It seems python generates=
 the
> > > > same JIT code for each function.  They will become separate DSOs bu=
t the
> > > > contents are the same.  Only difference is in the symbol name.
> > > >
> > > > But this caused a problem that every JIT'ed DSOs will have the same
> > > > build-ID which makes perf confused.  And it resulted in no python
> > > > symbols (from JIT) in the output.
> > >
> > > The lookup of a DSO involves the build ID and the filename. I'm
> > > confused as to why things weren't deduplicated and why no symbols
> > > rather than repeatedly the same symbol?
> >
> > I don't know, but that's the symptom in the original bug report in the
> > python github (see Links: below).  I guess the behavior is
> > non-deterministic.
> >
> > >
> > > > Looking back at the original code before the conversion, it used th=
e
> > > > load_addr as well as the code section to distinguish each DSO.  I t=
hink
> > > > we should do the same or use symbol table as an additional input fo=
r
> > > > SHA-1.
> > >
> > > Hmm.. the build ID for the contents of the code should be a constant.
> > > As the build ID is a note for the entire ELF file then something is
> > > wrong with the filename handling it seems.
> >
> > When it tries to load symbols from a DSO, it prefer reading from the
> > build-ID cache than the file system since it trusts build-IDs more than
> > the path name.  See dso__load() and binary_type_symtab[].
> >
> > So having multiple DSO's with the same build-ID can be a problem if the=
y
> > are in the build-ID cache.  Normally `perf inject -j` won't add the new
> > JIT-ed DSOs to the build-ID cache but it's still possible.
>
> +Fangrui
>
> I'm surprised that build IDs don't include symbol names but:
> ```
> $ cat a.s
> .text
> .global main
> .global foo
> main:
> foo:
>        ret
> $ cat b.s
> .text
> .global main
> .global bar
> main:
> bar:
>        ret
> $ gcc -Wl,--build-id a.s -o a.out
> $ gcc -Wl,--build-id b.s -o b.out
> $ readelf -n a.out
> ...
>    Build ID: 9dd0371b953db5d72929af5d98552e4ee1043616
> ...
> $ readelf -n b.out
> ...
>    Build ID: 9dd0371b953db5d72929af5d98552e4ee1043616
> ...
> ```
> so ugh. Perhaps we need to have jitdump make a single object file (and
> so 1 build ID) but with multiple unique symbols.
>
> Thanks,
> Ian

Looks like a GNU ld issue. Other linkers should give different build IDs.

 .symtab/.strtab/.shstrtab are special sections and BFD seem to skip
their content for the build ID.
Raised  https://sourceware.org/bugzilla/show_bug.cgi?id=3D33633 ("ld
--build-id does not use symtab/strtab content")

>
>
>
> > Thanks,
> > Namhyung
> >
> > >
> > > > This patch is a quick-and-dirty fix just to add each byte of the
> > > > load_addr to the first 8 bytes of SHA-1 result.  Probably we need t=
o add
> > > > sha1_update() or similar to update the existing hash value and use =
it
> > > > here.  I'd like something that can be backported to the stable tree=
s
> > > > easily.
> > > >
> > > > Fixes: e3f612c1d8f3945b ("perf genelf: Remove libcrypto dependency =
and use built-in sha1()")
> > > > Cc: Eric Biggers <ebiggers@kernel.org>
> > > > Cc: Pablo Galindo <pablogsal@gmail.com>
> > > > Link: https://github.com/python/cpython/issues/139544
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > ---
> > > >  tools/perf/util/genelf.c | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > >
> > > > diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
> > > > index 591548b10e34ef6a..a412e6faf70e37f3 100644
> > > > --- a/tools/perf/util/genelf.c
> > > > +++ b/tools/perf/util/genelf.c
> > > > @@ -395,6 +395,15 @@ jit_write_elf(int fd, uint64_t load_addr __may=
be_unused, const char *sym,
> > > >          * build-id generation
> > > >          */
> > > >         sha1(code, csize, bnote.build_id);
> > > > +       /* FIXME: update the SHA-1 hash using additional contents *=
/
> > > > +       bnote.build_id[0] +=3D (load_addr >> 0) & 0xff;
> > > > +       bnote.build_id[1] +=3D (load_addr >> 8) & 0xff;
> > > > +       bnote.build_id[2] +=3D (load_addr >> 16) & 0xff;
> > > > +       bnote.build_id[3] +=3D (load_addr >> 24) & 0xff;
> > > > +       bnote.build_id[4] +=3D (load_addr >> 32) & 0xff;
> > > > +       bnote.build_id[5] +=3D (load_addr >> 40) & 0xff;
> > > > +       bnote.build_id[6] +=3D (load_addr >> 48) & 0xff;
> > > > +       bnote.build_id[7] +=3D (load_addr >> 56) & 0xff;
> > > >         bnote.desc.namesz =3D sizeof(bnote.name); /* must include 0=
 termination */
> > > >         bnote.desc.descsz =3D sizeof(bnote.build_id);
> > > >         bnote.desc.type   =3D NT_GNU_BUILD_ID;
> > > > --
> > > > 2.52.0.rc1.455.g30608eb744-goog
> > > >
