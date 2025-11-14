Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155AD30BB86
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 23:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763164708; cv=none; b=K1ZeU3aJLpGGCfUKgljmyGXrhG6h4dQkQKvVDkKN/iOS/sndSK3EFJ2P1MAuqG0rsTzxd8eq+6I2rVwab5BrPzJx6GILnl+b+cRezKa4mnuWNsDSOKQ9Zol3Ud4k9ku+LG/xMVeSzdZ2Xw/B6nI7bS+o5khxWgwzoG6PxFzwaZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763164708; c=relaxed/simple;
	bh=MRQdsBHsyEu3nPxhDy9ym0PPhvnehuucqECBK78LWnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdJ9dawkMd6QXAyuyl1Ng2NNK7J0ilCUvNSuwCbQbEF8Yq6rEEoSNo4khbZ6S4srEwtK3Vfcrz9Ss9IaMS1afxExUcfVRObCP/i1lXzip4bi/4un2PRLEiPa+Mc9xFS8JsoUQDkSco7/fztkQv0Hf9vg2M4St5aBtv9FLUIK01Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H7Frv838; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H7Frv838"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2980343d9d1so42415ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 15:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763164706; x=1763769506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mGyicn36wATRenY0gnqN+aakOkORwD2CJtd26qTK3s=;
        b=H7Frv8382urrY2PJ9bpgYTVVQaIaz1QTqLnXcIlbBTBDQHRBiS7OhGu6T0J4wlgVX/
         +0eNr8SnErlGi+fk+AvftdyGouuyIsK4ntkqWmPEnt/XNTJuFCLEbAXjTuqkqw2z26BF
         Ag5jW4A28POm5BEjpZykxyao2OzPH82IS3pVP/ZOf2Z4hXH8NtFSCLJ/j7hmfoS+Axa9
         vAv4iLULaeZx3CjLUtIx62sGRIXXexD84MOa8QpjFMR2iTYMHTGYjfurfzRyLyLElPq7
         gWmNmJdqNrqFNTNUYVWYChoCPDJmLJAJRDrcnf7pibcOnNoOZFwCpcelz0gpsUFaOfUS
         C+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763164706; x=1763769506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/mGyicn36wATRenY0gnqN+aakOkORwD2CJtd26qTK3s=;
        b=m4dXDLFfSkGPAnIsRjR7fu/r5BHvDrAFKEtDkdz3mcIL/s4FSCtMSDCkgKkMiLmCeY
         kA0q6fitdwAiJTbH4gK/hJOH/L4SlGV1ixk/UsZ78dQ9xpXfyrVA6Sn+qvE4ImlQfc96
         S2bPW7LJaL738QwPKI1vEuTB4hbjx3lHWEgrBO+wTlt9nrwbibWsCIrOK/99cKgrEJxt
         FRsx+E/v7qIqDjlX81tJIL0Q3Rje6/gUjFZmCeuc2ikNB0QkjzoRiwH18dI3gZpCTtF7
         p1J9/pYaqYYEvR/X5O8/bPQzYTiv5SSn22AbmfxPvj/gAFXaToibXyyh76LV4crFL4lD
         opaA==
X-Forwarded-Encrypted: i=1; AJvYcCUjXsL6jXh8AECvpBKVlhhYBeKgsgQ5mRMiVYbCWxQYsVF2xcjj1ctwLaAmchNfcQOwNW3lRZ3Ly6tNguEFnEMB@vger.kernel.org
X-Gm-Message-State: AOJu0YxgdgI+ytV6e/0+5VzU+4pWNg30c+98wsvYtjteKSRJ+kGa2aR2
	x6ZjAho/iZgwZHq8+lmkjoCjw/lvgAl7ZT6BdFaUhT/jLxp8R4ehpj2HlE13smGhOTCc/JSDgPK
	Gc3Kpx+mPLetQFLOn8v/gnxHawdsrBd2WRPTFfXPB
X-Gm-Gg: ASbGncsrT24/qe4NjuqvGoua5CUlFxh4qIlvwyJzqHEFzuMP/dljZE0aoQCpmR3JZSb
	/41ugJRhj1Jjx5S5oI0umjN4dh6+TcSVqRjGBTmfRzZcbvPVRRkjZ7bonSFTOL9ZTH2BcWt7Yyy
	al9VBRb80f8Z6yaYVgOAZHO79qhQzng7edxk0jU5NAZW1D1SETiHCABVe0ex/9B64TGtYDrcDtJ
	wwRVJJ0LDrCRPJZn74qdErLw3KFvn7uXjHwX83Io+CwOW5e0z6V5/c8ySwCyQ2Xm1TH3eWB/JqE
	2Hlm2pZx/qhE8m4LtybfW9yc
X-Google-Smtp-Source: AGHT+IFa+Wpq6kYL6NLSQ6a04Li3fe+qxt1VBhyzh+FOPCQLgUZ2MqncC+sRe1ABv2uYCQf3zhuAycq1285FIpXjlQs=
X-Received: by 2002:a17:903:1a68:b0:295:5405:46be with SMTP id
 d9443c01a7336-299c6bb2635mr1048315ad.1.1763164706130; Fri, 14 Nov 2025
 15:58:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114092914.217533-1-namhyung@kernel.org> <CAP-5=fWsFLkYGFFyzSrpZNdRLpjaTZAuW7-YVUr-zMVH5dk8eg@mail.gmail.com>
 <aRd7iJJxgT-0G8Ky@google.com> <CAP-5=fUC88TVwnjTuTgU+s=LqqP0xOhNTG5hU27cSbaZRH7Jpg@mail.gmail.com>
 <aRe6PnZ1rk2oOz85@google.com>
In-Reply-To: <aRe6PnZ1rk2oOz85@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 14 Nov 2025 15:58:15 -0800
X-Gm-Features: AWmQ_blg0TOwNkM3Z7XKUpafvey5lrlMxhWtfQKveYxGt9c2QJMKbfSYn2zBSIY
Message-ID: <CAP-5=fV0=s6B=-m=iAwOzQrntG9vXn+jWeWhdQewGJhQBnqG6w@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf jitdump: Add load_addr to build-ID generation
To: Namhyung Kim <namhyung@kernel.org>
Cc: maskray@sourceware.org, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>, 
	Pablo Galindo <pablogsal@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 3:24=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Nov 14, 2025 at 11:32:52AM -0800, Ian Rogers wrote:
> > On Fri, Nov 14, 2025 at 10:57=E2=80=AFAM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > On Fri, Nov 14, 2025 at 09:33:29AM -0800, Ian Rogers wrote:
> > > > On Fri, Nov 14, 2025 at 1:29=E2=80=AFAM Namhyung Kim <namhyung@kern=
el.org> wrote:
> > > > >
> > > > > It was reported that python backtrace with JIT dump was broken af=
ter the
> > > > > change to built-in SHA-1 implementation.  It seems python generat=
es the
> > > > > same JIT code for each function.  They will become separate DSOs =
but the
> > > > > contents are the same.  Only difference is in the symbol name.
> > > > >
> > > > > But this caused a problem that every JIT'ed DSOs will have the sa=
me
> > > > > build-ID which makes perf confused.  And it resulted in no python
> > > > > symbols (from JIT) in the output.
> > > >
> > > > The lookup of a DSO involves the build ID and the filename. I'm
> > > > confused as to why things weren't deduplicated and why no symbols
> > > > rather than repeatedly the same symbol?
> > >
> > > I don't know, but that's the symptom in the original bug report in th=
e
> > > python github (see Links: below).  I guess the behavior is
> > > non-deterministic.
> > >
> > > >
> > > > > Looking back at the original code before the conversion, it used =
the
> > > > > load_addr as well as the code section to distinguish each DSO.  I=
 think
> > > > > we should do the same or use symbol table as an additional input =
for
> > > > > SHA-1.
> > > >
> > > > Hmm.. the build ID for the contents of the code should be a constan=
t.
> > > > As the build ID is a note for the entire ELF file then something is
> > > > wrong with the filename handling it seems.
> > >
> > > When it tries to load symbols from a DSO, it prefer reading from the
> > > build-ID cache than the file system since it trusts build-IDs more th=
an
> > > the path name.  See dso__load() and binary_type_symtab[].
> > >
> > > So having multiple DSO's with the same build-ID can be a problem if t=
hey
> > > are in the build-ID cache.  Normally `perf inject -j` won't add the n=
ew
> > > JIT-ed DSOs to the build-ID cache but it's still possible.
> >
> > +Fangrui
> >
> > I'm surprised that build IDs don't include symbol names but:
> > ```
> > $ cat a.s
> > .text
> > .global main
> > .global foo
> > main:
> > foo:
> >        ret
> > $ cat b.s
> > .text
> > .global main
> > .global bar
> > main:
> > bar:
> >        ret
> > $ gcc -Wl,--build-id a.s -o a.out
> > $ gcc -Wl,--build-id b.s -o b.out
> > $ readelf -n a.out
> > ...
> >    Build ID: 9dd0371b953db5d72929af5d98552e4ee1043616
> > ...
> > $ readelf -n b.out
> > ...
> >    Build ID: 9dd0371b953db5d72929af5d98552e4ee1043616
> > ...
> > ```
> > so ugh. Perhaps we need to have jitdump make a single object file (and
> > so 1 build ID) but with multiple unique symbols.
>
> Right, that'd be better.  But I'm afraid some JIT code could spread to
> many segments so it's not possible to create a map to cover all areas
> due to conflicts with other libraries.

I'm not familiar with any JITs doing this. JITs often have to run on
Windows where there is a reserve for the code cache and then commits
to actually use individual pages. On Linux you can do a large
PROT_NONE mmap and then mprotect pages within this code cache region
(we should have perf events on this). Apple has some optimizations
with the MAP_JIT mmap flag. SBCL has a code cache within the
executable itself. On x86 you could spread code around within +/-2GB,
on RISC it'd be a pain due to offset limitations.

Anyway, it sounds like something is off when we are writing the
executable and likely having too many of them. There is also something
off with dsos__find as it should only give a dso if the name and build
ID are matching. The sample should have an IP we turn into a map
within maps, the dso of the map should differ for each of the call
chain IPs (even though they are < page_size()) and the symbol lookup
should work.

If we're not going to maintain that jitdump build IDs behave like
build IDs then there is little point using a SHA-1 hash and patch
series like:
https://lore.kernel.org/lkml/20251016205126.2882625-1-irogers@google.com/
are even more tedious to land :-)

Thanks,
Ian
