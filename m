Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A699C24A044
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 23:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764718348; cv=none; b=tFsL+0CaAq0QPmLJg0AjSbdYmvX0qRFGkf/09aKk0zWkbSRBAIIr1P1RoUTLY0izf3OilUkULyPeMNDi9RTZoFfRhwpo/U86uRBJmPG5AFfRyv/R+NnAx2zt+R1RHdDIC5Lv0ehVqcmN925gmuPUTt6s+WLafH8RwjwVCLBXazM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764718348; c=relaxed/simple;
	bh=rO7QKUQcoaMP04qWqUDhnA7MGA+kHFKmezmo8TR5S+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHYKgx2wFGM88tWeQBn7HQT45HtUfGSE3vFbG9/cI/sRwsTlL+J0UMfxQnSKXUMhx6FIuT5ywyMZ8Ew4ct5CDz4R2MFzg78C2sTP6+VnYwvhazXi+NKqCkSJyuu22lc6MyScMes1x1uDZIaU1KF2n30X0Si9KU5c+JGpN14sxiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YG4VtvuE; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YG4VtvuE"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-295c64cb951so81835ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 15:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764718346; x=1765323146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgijKpD1pvFrqfH6lxlFv4vNMYFDo3GsRowBpUJTQvs=;
        b=YG4VtvuEf9Xa4euP9JAZOUGGkU2VdNFo8oYEiXP5mwYj8zUfq2+/VHmCVBMLiSL2TY
         4LGlPyNhPGIl9jnxgwEVREd7TLMgwW9QRzJOY90sSEdEgBFqNIcLm0oHll3H/7+hMVmH
         pZ7qfC536dDQwF1f7jw2RSiDcJ2N8cOOyFmyCuDU9vcTV56FJucXYFNn5/WaUTR1UOn6
         bsd5yyT3EvmNT/TelkT6VSPGz58x+7U+Jp9zQ9+de5qmUpbZw6eTl48r/Kd7xBxn0+A2
         yPNWgmXrUhUQ3wrO9mOTWsvmANp9MMrlOYDkYuxUwtd3lWfiBUNSUJDFyXqEq75+IPYO
         qFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764718346; x=1765323146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WgijKpD1pvFrqfH6lxlFv4vNMYFDo3GsRowBpUJTQvs=;
        b=klw8Nx2ibz628Gd5wsHkbgbbM8V97WkJgRMdohvZRFmStxMSc1UtX5oW7IUyKJ0AlW
         qw38Nlg9FQeKPakX+iI5+V0vjixllVN+ti2p3dp8YZBkzFhm51Y1K2dr00Nz5t/NIJxI
         Dj0gch0blRd9DRpI65y3yTqznrfh6UrNrMA30lDxMTCHb12+RXxiBxmhYUtbiRXyV/hU
         8WBItLaGYmE5DbV0lxyIMTp2ISQ+2kMyqE7LEExX6oNUOY8L7wn3MOBtlNncXnVM255j
         b/55XghwT4BzLJ7cO12CelA7eiO0w+7M0gAEFokaFw/66ZcYx9ydLw5zKtnhx1fY2xpV
         N7Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWLMI8vyPV8YfYqGXDNkRdeIdh016VR4N+9cVrNrQ9sO39NAQ1+Ymu76mzXC6yQltRjdyjMEw+w5Z/UHA8WqrkJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ1SfRLM3gCoHOUb/l0WnWO1rV5xdzaOgY4qx2y++LYsNHeaRa
	LDZeHObH8ubfIwV/gOf9BmQHoJbWx4DvXOpemSFuTK98FCJqhdJrunO+nDOAwlnR5OJsFSSqSH7
	EtcWuF1yoojo0fx86VZJ1jQJ0polN0lytk7YfMYhC
X-Gm-Gg: ASbGncsbl9v6pmx0YcxD9H2JMLnyRd9MhHh2hUQUM1DCmhVIVBRIrlHQMEkJodIg6ll
	fNcOMSb/hpQIJS+RYrj/BJlrrSZIrcC+izktHU1610r5rRpJGti2a4KGsOS++pZ6ImG6UsdDmVb
	/jSUDRGCsHh6fKHxk9xTvXchaB3MK7/XfuIHvpwDP2lBkPTISWvu+abEeybB9/yFOaf/JMVVle4
	EYWSFmztPcsClvW+xOZmkh2nDzV7RNhbuq1LkCe16cYyhxavze5tnTTbyDdgXHpFotoim6MF7ky
	kZiRSf+/TBodBn2tE/Yar85Z
X-Google-Smtp-Source: AGHT+IE4C8pFI8gAJk8i6qVZRz5NVHorPsLw5LtTPXNMtkoqcp7VJNXZDpLYP1bPSkJ0iMXy35vfEBqy5CtQ+lj0ZzE=
X-Received: by 2002:a17:902:ce90:b0:298:3544:aa72 with SMTP id
 d9443c01a7336-29d67f32d2amr605755ad.9.1764718345700; Tue, 02 Dec 2025
 15:32:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125080748.461014-1-namhyung@kernel.org> <20251125192943.GA3061247@google.com>
 <CAP-5=fXh82HpvLhPr9uFtq=HK5V+ZL3xntz7-gspEE5az2+7nw@mail.gmail.com>
 <20251126030452.GA85316@sol> <aSi_zXuT8isr8jEC@google.com>
 <20251127221822.GA2977@sol> <aS9gms3-xGaIpUnt@google.com> <20251202232746.GA2332605@google.com>
In-Reply-To: <20251202232746.GA2332605@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 2 Dec 2025 15:32:14 -0800
X-Gm-Features: AWmQ_bnTaLU1qbrhpLZ9AS3KlsbUgou8T5PcI2t5li58KhW50Rifr9E7SD40A40
Message-ID: <CAP-5=fVybJ9q0Ux6+DVopmqR_j=ZHcD2jqwJJOmax0Qh84zr7g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf jitdump: Add sym/str-tables to build-ID generation
To: Eric Biggers <ebiggers@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Pablo Galindo <pablogsal@gmail.com>, 
	Fangrui Song <maskray@sourceware.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 3:27=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> w=
rote:
>
> On Tue, Dec 02, 2025 at 01:56:42PM -0800, Namhyung Kim wrote:
> > On Thu, Nov 27, 2025 at 02:18:22PM -0800, Eric Biggers wrote:
> > > On Thu, Nov 27, 2025 at 01:17:01PM -0800, Namhyung Kim wrote:
> > > > Hello,
> > > >
> > > > On Tue, Nov 25, 2025 at 07:04:52PM -0800, Eric Biggers wrote:
> > > > > On Tue, Nov 25, 2025 at 06:55:39PM -0800, Ian Rogers wrote:
> > > > > > On Tue, Nov 25, 2025 at 11:29=E2=80=AFAM Eric Biggers <ebiggers=
@kernel.org> wrote:
> > > > > > >
> > > > > > > On Tue, Nov 25, 2025 at 12:07:46AM -0800, Namhyung Kim wrote:
> > > > > > > > It was reported that python backtrace with JIT dump was bro=
ken after the
> > > > > > > > change to built-in SHA-1 implementation.  It seems python g=
enerates the
> > > > > > > > same JIT code for each function.  They will become separate=
 DSOs but the
> > > > > > > > contents are the same.  Only difference is in the symbol na=
me.
> > > > > > > >
> > > > > > > > But this caused a problem that every JIT'ed DSOs will have =
the same
> > > > > > > > build-ID which makes perf confused.  And it resulted in no =
python
> > > > > > > > symbols (from JIT) in the output.
> > > > > > > >
> > > > > > > > Looking back at the original code before the conversion, it=
 used the
> > > > > > > > load_addr as well as the code section to distinguish each D=
SO.  But it'd
> > > > > > > > be better to use contents of symtab and strtab instead as i=
t aligns with
> > > > > > > > some linker behaviors.
> > > > > > > >
> > > > > > > > This patch adds a buffer to save all the contents in a sing=
le place for
> > > > > > > > SHA-1 calculation.  Probably we need to add sha1_update() o=
r similar to
> > > > > > > > update the existing hash value with different contents and =
use it here.
> > > > > > > > But it's out of scope for this change and I'd like somethin=
g that can be
> > > > > > > > backported to the stable trees easily.
> > > > > > > >
> > > > > > > > Fixes: e3f612c1d8f3945b ("perf genelf: Remove libcrypto dep=
endency and use built-in sha1()")
> > > > > > > > Cc: Eric Biggers <ebiggers@kernel.org>
> > > > > > > > Cc: Pablo Galindo <pablogsal@gmail.com>
> > > > > > > > Cc: Fangrui Song <maskray@sourceware.org>
> > > > > > > > Link: https://github.com/python/cpython/issues/139544
> > > > > > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > > > >
> > > > > > > That commit actually preserved the behavior of the existing v=
ariant of
> > > > > > > gen_build_id() that was under #ifdef BUILD_ID_SHA.  So I gues=
s that code
> > > > > > > was always broken, and it was just never noticed because the =
alternative
> > > > > > > variant of gen_build_id() under #ifdef BUILD_ID_MD5 was used =
instead?
> > > > > > >
> > > > > > > The MD5 variant of gen_build_id() just hashed the load_addr c=
oncatenated
> > > > > > > with the code.  That's not what this patch does, though.  So =
just to
> > > > > > > clarify, you'd actually like to go with a third approach rath=
er than
> > > > > > > just restoring the original hash(load_addr || code) approach?
> > > > > > >
> > > > > > > Also, I missed that you had actually changed the hash algorit=
hm.  I had
> > > > > > > assumed the perf folks were were pushing SHA-1 because they w=
ere already
> > > > > > > using it.  Given that the algorithm changed, there must not b=
e any
> > > > > > > backwards compatibility concerns here, and you should switch =
to a modern
> > > > > > > hash algorithm such as SHA-256 instead.
> > > > > > >
> > > > > > > I'd be glad to add an incremental API if you need it, but I'm=
 confused
> > > > > > > why you want SHA-1 and not a modern hash algorithm.
> > > > > >
> > > > > > Hi Eric,
> > > > > >
> > > > > > Thanks for the help with the hash functions! There's a bit more
> > > > > > context in this thread:
> > > > > > https://lore.kernel.org/linux-perf-users/CAP-5=3DfWLgaWsv82dcPa=
jVk=3DUmBbmwyEd7OVp6psZQ4TiXh-Meg@mail.gmail.com/
> > > > > >
> > > > > > So genelf is trying to take snippets of jitted code and create =
ELF
> > > > > > files from them for the purpose of symbolizing in perf. The bui=
ldid
> > > > > > hash being used is SHA1 and I think the MD5 support was removed=
 as
> > > > > > unnecessary. The problem this patch is addressing is that a JIT=
 may
> > > > > > create many identical stubs which then end up being deduplicate=
d into
> > > > > > the same buildid as only the code is hashed. The BFD linker see=
ms to
> > > > > > have the same issue (Fangrui filed a bug), gold and lld appear =
to hash
> > > > > > the symbols (which Namhyung adds to genelf here) but still yiel=
d
> > > > > > different build id for the same source assembly code. It is pos=
sible
> > > > > > to hash the address of the symbol rather than the symbol itself=
, but I
> > > > > > think the intent for the code should be to best match what a co=
mpiler
> > > > > > and linker would generate. The problem there is that this diffe=
rs for
> > > > > > every linker :-)
> > > > > >
> > > > > > Something that is unfortunate in the code now is copying/concat=
enating
> > > > > > all the build data for the sake of producing the hash. It would=
 be
> > > > > > nice if the code could incrementally build up the sha1 hash to =
avoid
> > > > > > the copying. I don't know if there is functionality for this
> > > > > > currently.
> > > > >
> > > > > Again, I can add support for incremental hashing if you need it. =
 But I
> > > > > don't understand why you want the hash function to be SHA-1.  Als=
o,
> > > > > given that this seems to be a regression fix, it's surprising tha=
t
> > > > > you're suddenly changing the inputs to the hash entirely, instead=
 of
> > > > > just going back to hashing load_addr concatenated with the code f=
or now.
> > > >
> > > > Historically MD5 or SHA1 was the only choice for build-ID in linker=
s.
> > > > I don't know if it's changed lately though.  But because of that we
> > > > support build-IDs up to 20 bytes and it's in the UAPI too (well.. i=
t's
> > > > implicit in PERF_RECORD_MMAP2).  I think we can support other hashs=
 if
> > > > they fit into it, but SHA-1 would be the right choice for now.
> > > >
> > > > About load_addr, I don't think it's the right fix.  We cannot have =
the
> > > > exactly same build-IDs as before since we already switched to SHA-1=
.
> > > > What we actually want is a way to generate unique IDs for each DSO.
> > > > For that purpose, it'd be nice to use sym/str-tables as Fangrui sai=
d
> > > > instead of using load_addr which seems to be a quick hack in the pa=
st.
> > > >
> > > > So I think I can merge this change for stable fix.  And add increme=
ntal
> > > > SHA-1 (thanks in advance!) and update the code to it later.
> > >
> > > If it needs to be 20 bytes, you should just use a truncated SHA-256.
> > >
> > > The only use for SHA-1 is backwards compatibility.  Which it seems yo=
u
> > > don't need.
> >
> > I think the linker (ld) --build-id still defaults to SHA-1.
>
> But generating exactly the same build IDs as the linker isn't a
> requirement, it sounds like?

I agree, I don't think it is required and every linker is generating
different build IDs from my experimentation. I think we can fix this
as a follow up though.

Thanks,
Ian

> - Eric
