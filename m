Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3792E2C0323
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 21:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757021618; cv=none; b=JJm3Ba5ScDBzlgdngW/QjFur8+uq1qaT2jtymylUVyWfjwNqk/1V+QYi8bub3KXql3p/e8iPO87oxnmEE57rH33fq+BqAywHi6zsKdg1pgZA+xED1xj4xd/iJLvLrJs9zK517lwP8FVcrpkWJEXGRtnNNi7tsTHGVpW9UlBtp9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757021618; c=relaxed/simple;
	bh=PqVLHo5CPSR85HHC5DHtcCHy8ewqDlEjk0LgdeCzP3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sMqDna/ed56YMd7xNA4W5VU75goMFFjv/ZG+Q0uFQZbYxgrF6QhJ+FIC9QigxK08P+oUUhx+zzRCunCQIDhaCfoQX22mMJkDsaFpL+EAKysxe/JCzbKWhQFwvvfDQyMujzq1vOTHwftuK36SOr1716Pdq/oLiBMXfTlLu1as764=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=skSKxo/0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="skSKxo/0"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24cf5bcfb60so45725ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Sep 2025 14:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757021616; x=1757626416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zG76W1jomTU5mpaT41jEFnyrs6Anr9kT/wRqoSffro=;
        b=skSKxo/0CNUr/rlxUl5R1ZShJnPzHPUcR7N9RkX0q9FoXnoPdMpYqgEQ7sgz2EepHd
         YDzslYLk44vGzcUMzp2j+OI+ATJVsI+1+wKu6MIA+wQXtOWjvhzlp/32kozGtYAy8QCf
         bMAVWsfWXAuDzblK9N36/KmUqlqOkqM16rYhXjAjxWxzzD3NT+az1jD+TmuL/t1Zt+U5
         JuA/AAt6KZj5PEhjfeX9XW7gLwFmkYqcNGvxKufdi1nZbUVjn9ZNE44Eii5OVuKU6XCW
         mYW64zvxojkr2JGAFTbjvFMxz6NuDca62ZwOdB0404KRyTkIPhq3lNREn/YDbCB10cXL
         Hm0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757021616; x=1757626416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6zG76W1jomTU5mpaT41jEFnyrs6Anr9kT/wRqoSffro=;
        b=Pd5KCugvnosc5h3XIQQHkV8+Zhhj1YymKX1TfIqs2tcuE87xknpYbObzk+Sy6d2Jdf
         2tr0uLD6ne9X5iC4Z/QOPwDHi9dxKetY7Oel4CrdXEfEyQF52lqsnITuGOxHV/nfQGty
         J48tYq41f8WX1oQVZIjW3YR+o+hqdXssVKdY5Q8VwrPuAtDdwL6k6MOsZ0lwFzvMF9SN
         O5/ZZj9CkFdRO51XKaw00i38nLKfYw95n8cpcBpQcR9HzKTvdaD+kqvfDeSWolNkO01V
         5V24pRn7oKZCDXgXTud9gdFocfE2F6eZNpJbbTLB4lF4bBiJaxR2LTKF3EsEf1USDwJF
         TDdw==
X-Forwarded-Encrypted: i=1; AJvYcCVtF3KFDfcBVnYUaVCOc0rye9Jx0k6k1WV2onLuRhtsSj9WqnXAVOsCc8VHBCX7ioGCFwI/gtaFEp78VlJmkoc6@vger.kernel.org
X-Gm-Message-State: AOJu0YzCHYsS31yJDvGta/l3LvsDfJwrvpGL8rvN7h2GYXDmGEvTDjNu
	pVRfXrw4mIbS3KvIR2csK/xAias6vC89/j0PlymNQJHo2eIg7pTvMQST/YpiETvh0pT9zZzTa2Q
	yyEU+qQT06cavnwqCs6MDJabis0N+dGT/P2nLPlDA
X-Gm-Gg: ASbGncugMgMTy7pKS03I1zduRL8nvR7t+a/wdYiMb7EScx29BC3KTV8z79Wy23AfQ8W
	FgwnRLXLSM5JwwHNyKUnXd6WTrzDPFPfs3fJnPvc9DitQdvgMOxcC+KGdLTJRECHBYPIi9x8NGg
	4IV71p464QGSMskCDmDIW58QjF1wYlJsSbhICTx2IUTy95TwSOChO4xzS/MY/w/3gwwOEw7OE2t
	8Eyt8QH/KWsymKwnNEnCbMq6uTitHY/egGOIfIEmO6i0V6zhvUVmho=
X-Google-Smtp-Source: AGHT+IEAi1buQEt6c6lTvS9UBO9bvlQdRmjUWdOf0PquuTMedsYvCLBFG+qnF2Bhz7XgAVg01cR8YHV0rKomIqlJA68=
X-Received: by 2002:a17:902:ea08:b0:234:bfa1:da3e with SMTP id
 d9443c01a7336-24d3ae4107emr381405ad.5.1757021615914; Thu, 04 Sep 2025
 14:33:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904174430.1414548-1-irogers@google.com> <20250904204117.GC4067720@noisy.programming.kicks-ass.net>
 <20250904205924.GO4068168@noisy.programming.kicks-ass.net>
In-Reply-To: <20250904205924.GO4068168@noisy.programming.kicks-ass.net>
From: Ian Rogers <irogers@google.com>
Date: Thu, 4 Sep 2025 14:33:24 -0700
X-Gm-Features: Ac12FXw6DScmpvcc6457h5dDGfQuEEAVlaaKR7yJzp_tmfqCgA-SjzzYwDjCYrk
Message-ID: <CAP-5=fXneV5fawTncLH13p_8-9OAxwpTERXk5ty=8m0s8U1ANg@mail.gmail.com>
Subject: Re: [PATCH v1] perf build: Revert "enable -fno-strict-aliasing"
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 1:59=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Thu, Sep 04, 2025 at 10:41:17PM +0200, Peter Zijlstra wrote:
> > On Thu, Sep 04, 2025 at 10:44:30AM -0700, Ian Rogers wrote:
> > > This reverts commit 55a18d2f3ff7 ("perf build: enable
> > > -fno-strict-aliasing"). With (get|put)_unaligned_* using memcpy
> > > -fno-strict-aliasing is no longer necessary as memcpys are assumed to
> > > possibly alias.
> >
> > I don't think this is a good idea. Much of tools/ includes kernel
> > headers and various kernel code, all of which is written in the
> > understanding that this (often called broken) C language feature does
> > not exist.
> >
> > As such, I would strongly suggest all of tools is built with
> > -fno-strict-aliasing.
>
> Similarly I would strongly suggest having -fwrapv on all code that
> includes kernel headers.

Given we can build and run with sanitizers, ubsan covers fwrapv and
type sanitizer is in development to detect strict aliasing violations.
So we can have correct code without hamstringing the compiler.

There's lots wrong with C, a particular favorite of mine is:
```
void foo(const int *p) {
   int x =3D *p;
   if (x =3D=3D 10) {
      mutex_lock(&global_mutex);
      if (x =3D=3D 10) {
          // Code should always run ...
```
The compiler can save registers by re-loading from p in the code
above, meaning the second "if" may not always run.

Anyway, the intent with adding -fno-strict-aliasing was that it was
temporary as part of removing the libcrypto dependency and when the
unaligned code landed we'd do this revert.

Wrt the kernel headers, I think we may be better breaking away from
them. I can see sense in using stdint types rather than __u32 or u32,
using stdatomic.h rather than linux/atomic.h, etc. This wasn't an
option 15 years ago, but things have progressed a little since then.

Thanks,
Ian

> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > > This patch needs:
> > > https://lore.kernel.org/lkml/20250722215754.672330-1-irogers@google.c=
om/
> > > which have been merged into the tip timers/vdso branch.
> > > ---
> > >  tools/perf/Makefile.config | 4 ----
> > >  1 file changed, 4 deletions(-)
> > >
> > > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > > index 5a5832ee7b53..306b8334b788 100644
> > > --- a/tools/perf/Makefile.config
> > > +++ b/tools/perf/Makefile.config
> > > @@ -19,10 +19,6 @@ detected_var =3D $(shell echo "$(1)=3D$($(1))" >> =
$(OUTPUT).config-detected)
> > >  CFLAGS :=3D $(EXTRA_CFLAGS) $(filter-out -Wnested-externs,$(EXTRA_WA=
RNINGS))
> > >  HOSTCFLAGS :=3D $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
> > >
> > > -# This is required because the kernel is built with this and some of=
 the code
> > > -# borrowed from kernel headers depends on it, e.g. put_unaligned_*()=
.
> > > -CFLAGS +=3D -fno-strict-aliasing
> > > -
> > >  # Enabled Wthread-safety analysis for clang builds.
> > >  ifeq ($(CC_NO_CLANG), 0)
> > >    CFLAGS +=3D -Wthread-safety
> > > --
> > > 2.51.0.355.g5224444f11-goog
> > >
