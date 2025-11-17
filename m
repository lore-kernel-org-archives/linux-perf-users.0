Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6CD2C0F8F
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Nov 2025 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398724; cv=none; b=npVJSGAdfN+aSE2YYp+tt9RRjAMY7MHwmoCK/6rT0uYwSwbSzG3jVB/paR/8nAKPm0/Mul28kYt7AFIeEc3RKjn5S159rFR7xDBusk4CfSamrCx0R/qyXZGaO/a5npmU78OsvYt1c15v3z8PtSY0b9LSig+b8QGT04fFA0OlyZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398724; c=relaxed/simple;
	bh=0igi0uBjo4mPlicmHb7JQkD968dogq4AL/NWf3JH/2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6fTxO6W4Y/2Ny5rs3iBEQM+1uYrogVCR51e2PTE0WHUpjd1ntjPfCcnE3WmF1dptAMkjM2vZgkS8t9OvbJQGx176djHsDnei/Bidfst7rwJ3xZpTi44ceMiznoqUNBrKM1BwcpKeZX6+UL42hoftqd4dfowaXrvuU0K0eM4i6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nAP+9j/U; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nAP+9j/U"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-297e13bf404so425605ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Nov 2025 08:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763398722; x=1764003522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdQsHUq0IRjBbKrQVOpN/5nCRNMx3J7xk+QqtvmRmhc=;
        b=nAP+9j/U0Dg6MiWm1xKyCdAGp2LLegFpcv/ViVue3cRo2nxGBt+4O7I1LtVqRG3yH0
         bRrUkFFxgfc2HFkzTUJl8LyNWGo3fx2NCp9BX5rsASBX1II8oy9tppM/JULLvLjlUH6T
         3JTUg2kD4QLbXqJovhucTHzIA3R42LFXjOedYVUk1V7uxEv2oxCzp9RVpA1rr06/NiRf
         IeiOwc263w23XOx9GVm2/0gm9ENy/9rr3WdIqfGsDzmKII6xFdtRQiMoft6sDbGt7waj
         Ak9cnpSk8NIVaznUTG68dnQ18HA9HId4REcJ3v7Udr9W4TZKKDd+0T1jpin5LDZh0iy6
         okPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763398722; x=1764003522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OdQsHUq0IRjBbKrQVOpN/5nCRNMx3J7xk+QqtvmRmhc=;
        b=ROdUvL2M4o5kx6FaugOTuxkNvJVZ+/eQLwLaPXDdwqLrESBIJvcC13UQvtiH8f6qyy
         y/ATehvgmRpF/tp3zhEQcvtwJguNkvwluJ/YwjttxEb4ZKeaHNyq0b/HG6DW6q0+k3mm
         6MxF79MDHx2ZT+tZ3txdNORcB4ImBmjnHhNKWEu2uYULyFyqsxnKZVfYIIzhpo3+6sHF
         CR8N1hWRLEXOPo1H8s2UzoF+d4t1noTe/3lSsY0kswBz1QjK3N1KADlsjt7fYVoT5isT
         W/7yn2oxiir2D1iml932ecbWgQ76nG8MrAvPIDUCBkg4gkOFbr29lvbyravB2PfDMZav
         8YGA==
X-Forwarded-Encrypted: i=1; AJvYcCWTEUsSp1DhTEw++1UKA1zu7Y8pwpXd1jMLKybQO2NanImdmn/120c+4KtO16XKoQzIsrldDA55PhFbvhaaNFPP@vger.kernel.org
X-Gm-Message-State: AOJu0YxqFt8Jtf2ZI9nAMCV+fh9ZtHS4F+VgX6Te5DPrFJo8qkajaKaJ
	9xdKBUkhbj6noTTRrQ6iXOuxfdHMpfNchJJ4e0hxzSbyabJfJRCFdcmWI3Ov4hrzSdsgkbJ+YW+
	zqkGw6hCEDI0+S9zJSAgUdyW0VfEtTC1miqBS1wdn
X-Gm-Gg: ASbGnctuOu+a3yu7zn5XNEAZDkgzkPkpQ6xR06T0gbTvw6xNZaRkTHYrfpC9uawK4j7
	mRhb5OjHWYLpcOiw35/rO0g8KHYzuKhhGxym7d05+j18tXudNeNB+8BUoQIBwlR4ER0yscJKRty
	/6+qyd/I5IaONHxmSQ40MbkKE9C1MZgE+FZQPycDAxjqyeFE64i4BtBSc0rfi7BYbSj7pE15VhV
	Le2dR2zYiCMFlrqXN2XwOvOqeeTFgqZr1cuywwNpr7VrKWKJGRadK+UeOv+WPnoAhpXMzufGSxX
	XgM7xERctgjiFTJO8ys7C0+sTqILZ7qZIjkZnmJ/Ch3QLAg=
X-Google-Smtp-Source: AGHT+IFoacNqqikVqojgwWfTtercchN/gNTONEbUR+A7TOqQH+zgtRinEN/vk8zS+/Lh+oVA3Z5KOy+Jb4CMXLc5zjE=
X-Received: by 2002:a17:902:e542:b0:298:45b1:6ef4 with SMTP id
 d9443c01a7336-299f521053bmr205135ad.12.1763398721724; Mon, 17 Nov 2025
 08:58:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114092914.217533-1-namhyung@kernel.org> <CAP-5=fWsFLkYGFFyzSrpZNdRLpjaTZAuW7-YVUr-zMVH5dk8eg@mail.gmail.com>
 <aRd7iJJxgT-0G8Ky@google.com> <CAP-5=fUC88TVwnjTuTgU+s=LqqP0xOhNTG5hU27cSbaZRH7Jpg@mail.gmail.com>
 <CAN30aBHWef0kKWPkvx9NZ4nJjdz97PJ7s_68h-ddZ3e8VzYW3A@mail.gmail.com>
In-Reply-To: <CAN30aBHWef0kKWPkvx9NZ4nJjdz97PJ7s_68h-ddZ3e8VzYW3A@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Nov 2025 08:58:29 -0800
X-Gm-Features: AWmQ_bmB9WHRuzN7o3zIZrVn-SU-tHxm99ZGHhi5t8Y2loCI5uAs6Ie8s3N852s
Message-ID: <CAP-5=fWLgaWsv82dcPajVk=UmBbmwyEd7OVp6psZQ4TiXh-Meg@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf jitdump: Add load_addr to build-ID generation
To: Fangrui Song <maskray@sourceware.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>, 
	Pablo Galindo <pablogsal@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 11:21=E2=80=AFPM Fangrui Song <maskray@sourceware.o=
rg> wrote:
>
> On Fri, Nov 14, 2025 at 11:33=E2=80=AFAM Ian Rogers <irogers@google.com> =
wrote:
> >
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
> >
> > Thanks,
> > Ian
>
> Looks like a GNU ld issue. Other linkers should give different build IDs.
>
>  .symtab/.strtab/.shstrtab are special sections and BFD seem to skip
> their content for the build ID.
> Raised  https://sourceware.org/bugzilla/show_bug.cgi?id=3D33633 ("ld
> --build-id does not use symtab/strtab content")

Thanks Fangrui!

I repeated my test above and found for GNU ld and bfd the build IDs
didn't vary, but for gold and lld they do vary.

So it looks like in perf we need to update the sha1 calculation:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/genelf.c?h=3Dperf-tools-next#n397
to include at least the symbol information.

I don't know if it is specified how the build ID should be calculated.
It seems like it should be a specified thing to stop tampering with
files, but I also see each linker produce a different value for my
test. I'm wondering if the sha1 calculation should really be including
other sections in the jitdump generated ELF files? For example, the
.eh_frame could be useful as that has unwinding implications.

Thanks,
Ian

> >
> >
> >
> > > Thanks,
> > > Namhyung
> > >
> > > >
> > > > > This patch is a quick-and-dirty fix just to add each byte of the
> > > > > load_addr to the first 8 bytes of SHA-1 result.  Probably we need=
 to add
> > > > > sha1_update() or similar to update the existing hash value and us=
e it
> > > > > here.  I'd like something that can be backported to the stable tr=
ees
> > > > > easily.
> > > > >
> > > > > Fixes: e3f612c1d8f3945b ("perf genelf: Remove libcrypto dependenc=
y and use built-in sha1()")
> > > > > Cc: Eric Biggers <ebiggers@kernel.org>
> > > > > Cc: Pablo Galindo <pablogsal@gmail.com>
> > > > > Link: https://github.com/python/cpython/issues/139544
> > > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > > ---
> > > > >  tools/perf/util/genelf.c | 9 +++++++++
> > > > >  1 file changed, 9 insertions(+)
> > > > >
> > > > > diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
> > > > > index 591548b10e34ef6a..a412e6faf70e37f3 100644
> > > > > --- a/tools/perf/util/genelf.c
> > > > > +++ b/tools/perf/util/genelf.c
> > > > > @@ -395,6 +395,15 @@ jit_write_elf(int fd, uint64_t load_addr __m=
aybe_unused, const char *sym,
> > > > >          * build-id generation
> > > > >          */
> > > > >         sha1(code, csize, bnote.build_id);
> > > > > +       /* FIXME: update the SHA-1 hash using additional contents=
 */
> > > > > +       bnote.build_id[0] +=3D (load_addr >> 0) & 0xff;
> > > > > +       bnote.build_id[1] +=3D (load_addr >> 8) & 0xff;
> > > > > +       bnote.build_id[2] +=3D (load_addr >> 16) & 0xff;
> > > > > +       bnote.build_id[3] +=3D (load_addr >> 24) & 0xff;
> > > > > +       bnote.build_id[4] +=3D (load_addr >> 32) & 0xff;
> > > > > +       bnote.build_id[5] +=3D (load_addr >> 40) & 0xff;
> > > > > +       bnote.build_id[6] +=3D (load_addr >> 48) & 0xff;
> > > > > +       bnote.build_id[7] +=3D (load_addr >> 56) & 0xff;
> > > > >         bnote.desc.namesz =3D sizeof(bnote.name); /* must include=
 0 termination */
> > > > >         bnote.desc.descsz =3D sizeof(bnote.build_id);
> > > > >         bnote.desc.type   =3D NT_GNU_BUILD_ID;
> > > > > --
> > > > > 2.52.0.rc1.455.g30608eb744-goog
> > > > >
