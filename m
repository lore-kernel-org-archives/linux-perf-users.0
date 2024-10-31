Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE5C1CC16B
	for <linux-perf-users@vger.kernel.org>; Thu, 31 Oct 2024 21:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730408443; cv=none; b=uq8dU24KkT5ImH6iwbJ9CCvN9XL8MQ5udGesIScVKG4AHJyVTQFknN4Emvz/2FezaONy3HeUnhPzHduEAvmK6Lq7ZDI1gglAG1dKJDy5dTrPpRHSR2hDBqBS4waVRPLJC1SVnTDStLa/KuWps9co7JcWHjgIdLvvt1sEpk8joig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730408443; c=relaxed/simple;
	bh=yrh0IbJWmE/SDvjrn89FK0yLCRVdpcCFuJ7Cz4CbP/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXB91GmmJtYk5D4jUp0jJosucLF3Eaa099VQI2dtuK50EPrGg3OccXgG/V+K7r/hmkybB/EZtSPnsqQbegIxzAa65EHomCiKE2I9Ms05ZWuQGdimASomn1wBdI4zuGeYE4nsZDJTBUad0tNNoC10URi8IcBJeqE8l6hLXdGCIK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I8UHixsH; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I8UHixsH"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-656d8b346d2so984321a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 31 Oct 2024 14:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730408437; x=1731013237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSkq3bj3+pAy/gZDSqj43W1LapD3B4u639cQdLu4St8=;
        b=I8UHixsH+byPFarayGP2H4wUlMhVengvMPXnW+qv4n4RCotcbnJf0rfU7tXV+iABvU
         EyUigyJntROwR1g/g229PCVziznmjsxKoAlJQJKC9wRMrkc1sQ+ovjGIJXWr0bYScuvd
         ImMMuXoP1wuT+DTXpBXCrDAcu7CXC5bZzklInKM4J8Ow9TmQc98K7iHH9xABK3zWqRLl
         PhF7xN7fy6VEJ18t81A0OIKdG4g78feZ8VZNpyiQzdRF6zqimBGG72zOluoD/+YGkusJ
         9+qh5dnd1jENJviWBVrl1YkfiFoqVC3CPwk0Gak4Ehsy4i2pdsRuJqKq0duE36S1+sXO
         qGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730408437; x=1731013237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSkq3bj3+pAy/gZDSqj43W1LapD3B4u639cQdLu4St8=;
        b=sWTxa0lEllIoRsizC2bpUDvXQExMIO0PluJ3u1xKhTlTWSOVBZM8JXOgMqVhiPDcPt
         VCsptJbJn0T7vaTb4nouLex/iNWd9FmPP/GpglTko3gpWRoVVatucMRqZFCxVjqbeA66
         S77+CheOfONCiIZTa/SZHtF4ZYFfeIHy2D7XWJ/l9YkhvT2aksn0nQ/b/yZim9w6YSqW
         +obeczLlLDjIA6fAu+yKC5UXAgPLOYRe3/JiLigBw0QPKgY6sF/mE2nUi8XmT85ai/S+
         GGiqaZUxdRmlyTLWD71Xu8Lg/7r2u4w/AR2p9JcQ0PmfAFWtsQxYDk1n6umOdaZLKzhj
         vxsA==
X-Forwarded-Encrypted: i=1; AJvYcCXpism+2dul5jTZJa8q+61GAvJPbHH2urBnF1n79VtIpYSo7Kh5GPGyCVqPCNqR+/C3uu2GrJYoSR2dzi708tOG@vger.kernel.org
X-Gm-Message-State: AOJu0YyHDy2zEGtpz7slIPZ3EfhcxaNdd/7EKXpELSlrGiZ86W1NjIC3
	xMYIRLxkUMxVYDMNHiNynQICX5AkZRFHMouNodpRb8/g8905SzjYb6Cl9tKNLcpdosmNMqF0qyz
	9OCGNTW0I5S6JB7ISHS3k/jczX2MuL+48IqSa
X-Google-Smtp-Source: AGHT+IEL8+W+Z1C0xOOPCRSi2hJJhzO7Ib1+CZea32cQtShRUM9YeK8I+VSn4y3/d4BSuhAUjYNQGbBeHtZ0/M6cuPE=
X-Received: by 2002:a17:90b:5306:b0:2e2:c15f:1ffe with SMTP id
 98e67ed59e1d1-2e94bdf49acmr1819149a91.0.1730408437329; Thu, 31 Oct 2024
 14:00:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730150953.git.jpoimboe@kernel.org> <42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
 <CAEf4BzY_rGszo9O9i3xhB2VFC-BOcqoZ3KGpKT+Hf4o-0W2BAQ@mail.gmail.com>
 <20241030055314.2vg55ychg5osleja@treble.attlocal.net> <CAEf4BzYzDRHBpTX=ED3peeXyRB4QgOUDvYSA4p__gti6mVQVcw@mail.gmail.com>
In-Reply-To: <CAEf4BzYzDRHBpTX=ED3peeXyRB4QgOUDvYSA4p__gti6mVQVcw@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 31 Oct 2024 14:00:24 -0700
Message-ID: <CAKwvOdmZYFhz0djG0_CgQ94BLaW8rUmdW+zaoZ0G+r76Esf2+Q@mail.gmail.com>
Subject: Re: [PATCH v3 09/19] unwind: Introduce sframe user space unwinding
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, 
	Indu Bhagat <indu.bhagat@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, 
	Jordan Rome <jordalgo@meta.com>, Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org, 
	Jens Remus <jremus@linux.ibm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Arthur Eubanks <aeubanks@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 1:57=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Oct 29, 2024 at 10:53=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.=
org> wrote:
> >
> > On Tue, Oct 29, 2024 at 04:32:40PM -0700, Andrii Nakryiko wrote:
> > > > +static int find_fde(struct sframe_section *sec, unsigned long ip,
> > > > +                   struct sframe_fde *fde)
> > > > +{
> > > > +       struct sframe_fde __user *first, *last, *found =3D NULL;
> > > > +       u32 ip_off, func_off_low =3D 0, func_off_high =3D -1;
> > > > +
> > > > +       ip_off =3D ip - sec->sframe_addr;
> > >
> > > what if ip_off is larger than 4GB? ELF section can be bigger than 4GB=
, right?
> >
> > That's baked into sframe v2.
>
> I believe we do have large production binaries with more than 4GB of
> text, what are we going to do about them? It would be interesting to
> hear sframe people's opinion. Adding such a far-reaching new format in
> 2024 with these limitations is kind of sad. At the very least maybe we
> should allow some form of chaining sframe definitions to cover more
> than 4GB segments? Please CC relevant folks, I'm wondering what
> they're thinking about this.

FWIW, Google has such large binaries, too.
https://llvm.org/devmtg/2023-10/slides/quicktalks/Eubanks-CompromisesWithLa=
rgeX86-64Binaries.pdf
--=20
Thanks,
~Nick Desaulniers
