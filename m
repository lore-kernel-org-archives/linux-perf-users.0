Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A732E2F0689
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 19:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763148787; cv=none; b=pN2T9griDqKtUvKm/LymJOx1XFJJerMu7kzo/aFK6qUYO4dRgr18BAHMiRLL7Zrv/k9eWYzEMGVJqvuRRk9rNheULBBzvah5u3iCQ2lntelUc79vLKmF6wz2t2P/T7dGiXUFciF35dKXmyQoTAeRG0CSw/h7ai+aHmnTsBItkFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763148787; c=relaxed/simple;
	bh=AzgRHbP33PqPkRJdeCiQzUVqCFvRamu4Yo0eILXSkC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=grMGzkczsBdlnfAg4yLe3O4NcgQvBmbIyFavRAVaHL3oHHVWl7wu1SqHYfB8w43Q5uN2ZAHL2tbsUbwlEr7Ce4N07MfjD29F1yTuHU6thwwYgIB98a207jmDsSpVWAJGT4YGW9+5YTb9SK3bpO20HEMCY+NWLWKQw2mV6hVHAdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TcFLtoVE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TcFLtoVE"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-297e13bf404so28965ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 11:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763148785; x=1763753585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EymQaHd+wafjHWNovMpB3YS06uy28uA+HRCwdW/mtaM=;
        b=TcFLtoVEgJ+0M/2EUgRo0kmCw6Es6MSzFWf/q1BS8Ll/UA7m9+wnPNcDQWfwPv8l2y
         3OaUpheAFD9fiMQedNB/xDaG5kQLo23JS8SNImUfIchlTGOQSx+m6zodIbY0jmWSgMpW
         lF2Y6+cygeB/zGamLAaCCqIxuNAy9SFi16AOCcoGllo0vTlRz9/ZbyAKuZnPqVri3QS5
         TWYmlYnHkADvsDwyhgLsP6wPUBKC5yu2yTHKq/rwim9cgFNx/5iv6C6QHeysISEeOs2p
         T4xu1zXtel+ZwR+0qD6bIxtfIQDifG6eurpA7ANBHx8zz1cCwKoEC+KRYXZTFH/oqCW5
         jQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763148785; x=1763753585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EymQaHd+wafjHWNovMpB3YS06uy28uA+HRCwdW/mtaM=;
        b=tzo8qNb4Fw0DRYOAr2aSLGbQW+fCLoKQW2703LUzOmxnLa1ZHSIXW09yyQWA2mnux5
         pzj8iEzMJKzRnQrDLHPAaGPr5Ru6jNyKecJjz7YiPQMa6MmuB0hQofPDgafT5kAaVYbg
         WP4Xw1jkJ/TmIyL3xNPjNArkcZFtdEVPClvvf5QOhOUH9JpZIfqBPdzEzLEe/B8kfQ9q
         oNfc3bmeNQGbW9gL6eSIpU1foLKzZBDZiFoV2hOuZ+MNsUR5NRlWfbdE5nfbna41onoJ
         U5sPdCHgzmlt2OfgiFMdr0fN3icHhs87g9ag8SpOFnp3dOV5PIPFw8ItI83EvkDZryOE
         OBgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPjrcNJLUa1NlDEv671raKLYceVuKWdVFwmSrI9aabMyk8CzYAjQ810My7NkssQYaqu9OKp2vGiRNWHDlmVHv2@vger.kernel.org
X-Gm-Message-State: AOJu0YyW5vpI9/HwITUKBtt/q0fy3gAn46nDyjlV8bRMtiR394YpF/jD
	jmoB9f1S7GZ9dHtGhwjLwt++iSFZKymgq1HfU4oqBxipkTw/Er49jCN6cdTXE9+qHU7DDp5PSC6
	XYt/+X8RZ37uie+RiFSFV4yzZMf3Io/oE0gBrM3yV
X-Gm-Gg: ASbGncvhsTNDHe20RbEdQm4jYAAVwa+puQV3YPM6a2+2jbpBUT4MfwQDUTmZxsmQSrO
	+syj4b+QQca7mamfbQqFWfgv65nT8h3V2yWdyeG33/b3Q/Dsk5fYOqODSaop+n0DFL4FHXal1Ry
	F70Mr75t2ULxSYpNLJmLAnDn8qsbx0j/EcOqcBZl3SbTnmvrP8RxymZcjcWFYF2ZEUf4C+YR84N
	8RnFqDHJphZN/C8Nl1j28xe+7WDSeR+SkiogHnOGVXvNK3oQs35xEGbvZcd1HTv8mm4AYHUQiem
	NblNQ7cTFCr6nB30XejtnPvRxkCy/B35QGFN3E223ZJ+yA==
X-Google-Smtp-Source: AGHT+IFvMxOSxc3obaMtan905PCC7x4peGJ09pwwT2f7KojFkE4+YJvMTp4vAyKsHbiUBD2elUSVhvzNx7/1Y3wXR6E=
X-Received: by 2002:a05:7022:38f:b0:119:e55a:8084 with SMTP id
 a92af1059eb24-11b80fc9c2bmr22780c88.1.1763148784310; Fri, 14 Nov 2025
 11:33:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114092914.217533-1-namhyung@kernel.org> <CAP-5=fWsFLkYGFFyzSrpZNdRLpjaTZAuW7-YVUr-zMVH5dk8eg@mail.gmail.com>
 <aRd7iJJxgT-0G8Ky@google.com>
In-Reply-To: <aRd7iJJxgT-0G8Ky@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 14 Nov 2025 11:32:52 -0800
X-Gm-Features: AWmQ_bmSocfwHpc6VGh1hUTC9RWhQy_fbMcs8lGlIiWqEs1LZrONQj-0s9l2GUk
Message-ID: <CAP-5=fUC88TVwnjTuTgU+s=LqqP0xOhNTG5hU27cSbaZRH7Jpg@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf jitdump: Add load_addr to build-ID generation
To: Namhyung Kim <namhyung@kernel.org>, maskray@sourceware.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Eric Biggers <ebiggers@kernel.org>, Pablo Galindo <pablogsal@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 10:57=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Fri, Nov 14, 2025 at 09:33:29AM -0800, Ian Rogers wrote:
> > On Fri, Nov 14, 2025 at 1:29=E2=80=AFAM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > It was reported that python backtrace with JIT dump was broken after =
the
> > > change to built-in SHA-1 implementation.  It seems python generates t=
he
> > > same JIT code for each function.  They will become separate DSOs but =
the
> > > contents are the same.  Only difference is in the symbol name.
> > >
> > > But this caused a problem that every JIT'ed DSOs will have the same
> > > build-ID which makes perf confused.  And it resulted in no python
> > > symbols (from JIT) in the output.
> >
> > The lookup of a DSO involves the build ID and the filename. I'm
> > confused as to why things weren't deduplicated and why no symbols
> > rather than repeatedly the same symbol?
>
> I don't know, but that's the symptom in the original bug report in the
> python github (see Links: below).  I guess the behavior is
> non-deterministic.
>
> >
> > > Looking back at the original code before the conversion, it used the
> > > load_addr as well as the code section to distinguish each DSO.  I thi=
nk
> > > we should do the same or use symbol table as an additional input for
> > > SHA-1.
> >
> > Hmm.. the build ID for the contents of the code should be a constant.
> > As the build ID is a note for the entire ELF file then something is
> > wrong with the filename handling it seems.
>
> When it tries to load symbols from a DSO, it prefer reading from the
> build-ID cache than the file system since it trusts build-IDs more than
> the path name.  See dso__load() and binary_type_symtab[].
>
> So having multiple DSO's with the same build-ID can be a problem if they
> are in the build-ID cache.  Normally `perf inject -j` won't add the new
> JIT-ed DSOs to the build-ID cache but it's still possible.

+Fangrui

I'm surprised that build IDs don't include symbol names but:
```
$ cat a.s
.text
.global main
.global foo
main:
foo:
       ret
$ cat b.s
.text
.global main
.global bar
main:
bar:
       ret
$ gcc -Wl,--build-id a.s -o a.out
$ gcc -Wl,--build-id b.s -o b.out
$ readelf -n a.out
...
   Build ID: 9dd0371b953db5d72929af5d98552e4ee1043616
...
$ readelf -n b.out
...
   Build ID: 9dd0371b953db5d72929af5d98552e4ee1043616
...
```
so ugh. Perhaps we need to have jitdump make a single object file (and
so 1 build ID) but with multiple unique symbols.

Thanks,
Ian




> Thanks,
> Namhyung
>
> >
> > > This patch is a quick-and-dirty fix just to add each byte of the
> > > load_addr to the first 8 bytes of SHA-1 result.  Probably we need to =
add
> > > sha1_update() or similar to update the existing hash value and use it
> > > here.  I'd like something that can be backported to the stable trees
> > > easily.
> > >
> > > Fixes: e3f612c1d8f3945b ("perf genelf: Remove libcrypto dependency an=
d use built-in sha1()")
> > > Cc: Eric Biggers <ebiggers@kernel.org>
> > > Cc: Pablo Galindo <pablogsal@gmail.com>
> > > Link: https://github.com/python/cpython/issues/139544
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/util/genelf.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
> > > index 591548b10e34ef6a..a412e6faf70e37f3 100644
> > > --- a/tools/perf/util/genelf.c
> > > +++ b/tools/perf/util/genelf.c
> > > @@ -395,6 +395,15 @@ jit_write_elf(int fd, uint64_t load_addr __maybe=
_unused, const char *sym,
> > >          * build-id generation
> > >          */
> > >         sha1(code, csize, bnote.build_id);
> > > +       /* FIXME: update the SHA-1 hash using additional contents */
> > > +       bnote.build_id[0] +=3D (load_addr >> 0) & 0xff;
> > > +       bnote.build_id[1] +=3D (load_addr >> 8) & 0xff;
> > > +       bnote.build_id[2] +=3D (load_addr >> 16) & 0xff;
> > > +       bnote.build_id[3] +=3D (load_addr >> 24) & 0xff;
> > > +       bnote.build_id[4] +=3D (load_addr >> 32) & 0xff;
> > > +       bnote.build_id[5] +=3D (load_addr >> 40) & 0xff;
> > > +       bnote.build_id[6] +=3D (load_addr >> 48) & 0xff;
> > > +       bnote.build_id[7] +=3D (load_addr >> 56) & 0xff;
> > >         bnote.desc.namesz =3D sizeof(bnote.name); /* must include 0 t=
ermination */
> > >         bnote.desc.descsz =3D sizeof(bnote.build_id);
> > >         bnote.desc.type   =3D NT_GNU_BUILD_ID;
> > > --
> > > 2.52.0.rc1.455.g30608eb744-goog
> > >
