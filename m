Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746591D26EE
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036920; cv=none; b=It+h7+6oL8/6rrqYlsa++kbKjpybE4ibcSVo2icB2zGDVSrmcU94lsGXf2ApjJBsSJ/4Aur1ECKSV0YckSXFBdgesapE3DNyKdysT8TeQgqqNFkiqtlrbWvk68aSQ1i1mP6adyam0FvASUKTvBopJccq9PPzT0shrg5LdsDupnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036920; c=relaxed/simple;
	bh=jUbGqhU4IcWQ47Upw7So1paU0kwKyS7PtxOQBEEQIyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X5tkdRReUIW7TOmrAJfPGv7NLf817DedFPKYwzNW+Zw1bseg5Rm+2THlqCXypKZIVRpf58ON48t/alWD5NnQDSAkNHQ14ZjocOhp/CxMAC8nwIflAwzc1hAefQRZK/G8zbG6GsfAmiWF7xRNFyzePUYwmXAFfZoBjv3X18H7Yz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=38KrU0Ow; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="38KrU0Ow"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a4e4776f79so161795ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 09:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732036917; x=1732641717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ym27viqWCynFMgUePVJBvA+AKoLrFWIBj+HlgFOU3xo=;
        b=38KrU0OwaX/fhOqt1WmUMG+wahmbdPQIAVarVbGjXiOWnvmAreKSxLRjUJpUEdpdbL
         /ehK3GS3mcUhkE4JVtc3CRBVQBMvqfPiVyvlZ44Co7K5TTLMIEyx9PoSqqI7D0geYU2O
         4C6YOfmx+qDzVN4DQ3yVOeO6oZJz1Z/U/U8+wnI1liBLGYt02JESdys+YCuGoB17PdhB
         q/op25G5MbIqY/+bfg1xWkUVpRWl6zY8Cp48t+EmGiX8MO2a3euFSQO0zajxNLBEiDXQ
         EsgLI+HDw+ihoWf5EhWY1d8UmZ18pHtV/wZ+3ObPC6lzOZRdo+dW3zdBQlBcqy7yNFaG
         y+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732036917; x=1732641717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ym27viqWCynFMgUePVJBvA+AKoLrFWIBj+HlgFOU3xo=;
        b=jLJyUSDHb22z8xbpNoObkji1wYmADIQsaYivQF+rOT3NBoI8MGva87H3gs9sfq6Hbm
         A8eiFptB7vfxFJTbHqKQ1PkgXbVGp/S0bZOFFNyNz8CUvTZL/Sci+jxDryFsNsKWI9JN
         SqV79uKsAB+pkbs+t3l0tmgNBQi1rMgKiyek6EbczzeSAOfnvFIjYdlmXMgFpsxG0l4c
         AChf7eEYbEs7GSl93S7t404DNy55VulmIvunobNqQsqzoPkkY84Zq6K5EKMC8feYJTd5
         RZGYMmjVPZu+mzfw8zN2LxeNqMj8TpiHKmFRVkWswC2lLS1IVxF++qgNSVxLqOcgTTk9
         /H+A==
X-Forwarded-Encrypted: i=1; AJvYcCVlJjjMZ9/PgdtFVacd+PZgTMOFe2lmeeZybjGDVwgnKeDUKIGpOVMmkVxSe6Ay90E8/k9Lei+Q2PUIM65nGqfD@vger.kernel.org
X-Gm-Message-State: AOJu0YzF6qPD7V8ZORE/fm27WpMKN7Rkl+NmTGYYYGllKqt+HjjFzThl
	LnhvAG/Vy7MeFcEwXaV8+DNLrGVylXP/Dmz/A+hD/YXGwsy/CNY7SZUpGUpUmOdA1Q9O9qsMprg
	JljX3X4vSlgsjxQ7nUONCyNrx7GMW6POPO8NH
X-Gm-Gg: ASbGncumcakVmH97wZqlOlwaoPOWs3o8R9ugWHh6l4UT4uXbvqYe6L35mcjBFqp0dum
	iSO83fSfZEQ4mzBm+19ML/6y4ahk8Hv9ksuH02OIHDVWrF1+I6EqMlVw+5rxlOvA=
X-Google-Smtp-Source: AGHT+IG2lc/1S4Yi4C7ZdwGmt5Z0NQfYIt7fA6X5TFQsCkCJnUS2Yow8s9UiCYpcKeIv40KVGhZCSa5tSAm9W85+oDU=
X-Received: by 2002:a05:6e02:12cb:b0:3a7:4e30:4884 with SMTP id
 e9e14a558f8ab-3a779fb1222mr3180675ab.17.1732036917367; Tue, 19 Nov 2024
 09:21:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109061809.811922-1-irogers@google.com> <20241109061809.811922-16-irogers@google.com>
 <Zzvac4IeX9nDDitm@google.com> <CAP-5=fUPksNCJ-NqUbJMDpfS7kkmXGsCVhvALkts8HDv42NUyg@mail.gmail.com>
 <ZzzEE_kAjmXnvwtj@google.com>
In-Reply-To: <ZzzEE_kAjmXnvwtj@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 19 Nov 2024 09:21:46 -0800
Message-ID: <CAP-5=fWiL0iBLue0fbCR3zgrCrX8j09ZSk5nkDr4pBsRGJUY0A@mail.gmail.com>
Subject: Re: [PATCH v6 15/22] perf lock: Move common lock contention code to
 new file
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 9:00=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Nov 18, 2024 at 05:03:41PM -0800, Ian Rogers wrote:
> > On Mon, Nov 18, 2024 at 4:23=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> [SNIP]
> > > On Fri, Nov 08, 2024 at 10:18:02PM -0800, Ian Rogers wrote:
> > > > +#ifndef HAVE_BPF_SKEL
> > > > +int lock_contention_prepare(struct lock_contention *con __maybe_un=
used)
> > > > +{
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +int lock_contention_start(void)
> > > > +{
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +int lock_contention_stop(void)
> > > > +{
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +int lock_contention_finish(struct lock_contention *con __maybe_unu=
sed)
> > > > +{
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +int lock_contention_read(struct lock_contention *con __maybe_unuse=
d)
> > > > +{
> > > > +     return 0;
> > > > +}
> > > > +#endif  /* !HAVE_BPF_SKEL */
> > >
> > > I still think it's the convention to have them in a header file as
> > > static inline functions and reduce the #ifdef in the .c file.
> >
> > Shouldn't minimizing ifdefs, and associated cognitive load, in header
> > files be the priority given they are #included many times while the .c
> > file is only compiled once?
> > Shouldn't a goal of the header file be to abstract away things like
> > HAVE_BPF_SKEL?
> > I'm not clear what the goal of having the functions in the header
> > files is, performance? The code isn't going to run anyway. I feel
> > lock_contention.h is smaller and easier to read like this but I also
> > don't care enough to fight. I did this change here as
> > lock_contention.h was being brought into python.c for the sake of
> > stubbing out functions that the header file was also subbing out for
> > !BPF_HAVE_SKEL. A single stub felt like progress.
>
> I think it may have the empty functions in the binary if we keep the
> functions in the .c file whereas compilers would optimize away them if
> they are static inline functions.

The functions will be 1 or 2 bytes and can all be deduplicated, the
linker can also garbage collect them. It is better to optimize code
for readability rather than for wins like this.

Thanks,
Ian
