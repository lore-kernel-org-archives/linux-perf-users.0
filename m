Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CFB474261
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 22:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790633114; cv=pass; b=QQ9gz8UvvKzbMmKRxvFBPEkTwI2uOHR1vpnll7YO9Qic+UX7Z5NcrMP2ouUPaLlLYfHiHrxvigXp+Cuzln1Fc87eqk5cQz3jBqipoi7taUHA+m92/ZFRF2GJDlDutdT1LVMmk91WFCEdPZ0UoGP+qvpYRRIwQOpm7VPovW5y08A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790633114; c=relaxed/simple;
	bh=f3tKnsCi9hJfFbJifSFha92to3XpZTWs/LpB5vXMPw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FJivfb3XcABGMM9zaQnVEb4VprlG8bVu+gUstJ0D97DkKv4qbxo9a1SX49nb5hlyvt1q9i2YzL8WVExTr+qdkfNGd++3Q/+LkvKwEItT61nTqmSskGAGzzGagevEueLWk2puc9V/QSgRtStJ3rP1rVcMn60nmw+RAWq2RUiojGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oac/TkV5; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oac/TkV5"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-533202fe429so110151cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 15:05:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790633112; cv=none;
        d=google.com; s=arc-20260327;
        b=gfD8jZGX+4H12hAtbGLqtNcCz0KLa3P9pYIrbZ40fEJNZVK7gDUSgvwxJEdOhn9m//
         /jkdoai55QwF3TUHIoQwLT+47EcKZ66tFvUoUtblDRq4qXiTh4Nhb4I9HpjUEKPWwZrB
         oVZKiFcPwv3zohbbGi5lNBnjlByUhENpw/nwbEvnzzim4/s7aR23QOHASHWCEG8uvyVm
         lY3ue1X0wCBsMgBOylZkxmrW7q1UpnYQgXsv8QwrN7aJD9DnNHM6es5jqKsrhLz1ywjO
         NFg2wLvKP9Jf+yTQXW0JcG+BMcL0I5hm33ItgOpOaxDGnLzY5sPiylDvcz/hOyNYAWfm
         +bYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kfBNTZeAncpILO1totwhYKiKnbMPiL6D3GS9AuR/h8Y=;
        fh=p5WcfwJEndXWQvXr4MVC0N1NlweNvl8Scqz/7cwBh4o=;
        b=k9CQT7wy7lGQRCr0nEYAO3STIlaIkk2fPRhe+R2KLKAskuvZuQs8OBWj8Ppg3XXEE9
         rp8oB1xbCPsbSgx/SXCmWimX1MdQ3JMTmYAXwyc4krnnzdnkAvD4V5R21CjDJ0eUQp8Z
         79daQe2UXJj/aeXzy52aqytVsExp2cV8g5QaejYSQ/DCy2W6kvOS6edaQm4jG14Z9iyR
         ful2plMiSKr3LFYK9OSONtoI8innU3jOZzQEYRmb7EYkJilqHnQ98bvAC4sTyUuIUhmF
         J3dSCx2O/xXlj94v+07kx8mAc/nB16Ouy3A52uXOrSpHYNMgFxuiQlGw5BSjAVQqG076
         383w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790633112; x=1791237912; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kfBNTZeAncpILO1totwhYKiKnbMPiL6D3GS9AuR/h8Y=;
        b=oac/TkV5UwKv07KHKkzjyxA1GStVW7rs6tlgjNZLqjEj+0J6aKfV/Fm477T43TFlcf
         3hY3SErBiCXwRStvWOSilxgkIG/kicFJndhaeR8sG6dztjSxDvlWBCKaaMeMrE56PTPA
         Ea0GeSJm8iL4U5r1qA+YKau/7/6cu0vFk5ayAc+7gcO4BAp9meXo9ijL7BP3k+qv+LwI
         2rRROT/4xw/oqW5sA5qu4X/eFNIPpbRnzV8/gCvmuC3F2iHiRLLzPlmvn3gf4PD7L92d
         MBb/TUHuXjaI+zoog6Ult3NOC7yNIzdvX3LQgSP0B/wNEFvaYXon11KkPHkstceRH/CL
         rbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790633112; x=1791237912;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kfBNTZeAncpILO1totwhYKiKnbMPiL6D3GS9AuR/h8Y=;
        b=SNtMj2oeQFcW6/tR7/xC7A+hO2sf5GPE2HwnPt5mrtyMLGD48UavlLfi+PhyM6aMLT
         w/XYruZj/koan/JfLpXmCWU7qJ03BnN9fvP4GGBWUaaBok58QaYtGYX8kc8Zzbo1SSbT
         pTFepjXDDIIL5CsN80liv7I16ct4J9VVe8TcCdH/drFaaeHIevNe7tLUNRY8n9KJ98CR
         gqQ2mN54ieLiSh8hZ8yWL4JAtZrARVhlmsjPLQwTXJTaCtLmgwDB1q5fo6tLqc7gEjKW
         Kfi1AmxzFlHprLwkSEr/0qHq0vgMx31SqtGMCKEVc7EgbEIp5s3vEb7wVKoIIXGWzhMy
         gVZw==
X-Forwarded-Encrypted: i=1; AKwUvBzuoC7AQZ+U5vapdV/eVr1gTAG2e6+joWKrKSNLgesqDwJX/3xYsy4PhX48STxlzaVjB7k0azQw6GQ5rW9+t3ob@vger.kernel.org
X-Gm-Message-State: AFuF++nrgsu1RQZlZQG+REuSClvWPxiAQSnzN/lgIqyRZUnoajBK303/
	n893mJXkJ12R/Q5Ud77d7zSPA3PfxmORGbqXvAzKA/JkWBqPadtRf256Hv+PFuAwMERBR3U/qWn
	sWNAw8UQhsqF2gRWb18+O6xKbfk6a0ZclcikGPkH+akJ265rIH43b2nfym84=
X-Gm-Gg: AYBFou1HYUm6WpWAt8ZWceiF8NLpZcAT+I92TTbRzVvGcSti64DgGLmdw2K2saJbYcR
	uvwBqAUIorcUI7CzvbL0mxHaKAu6hqB1PPtbiWG2vs7tLsPgVqusq4l0XG+b9y8ur2aA3PQ2EXH
	zELNQhf1Hu0E5YP2Z4W15iAngNeoYWNsS1bP/Bj6NgBCqC/cy0zNiybNivlq//By3xzOIxn5h3l
	fwEmLsxTOaeJB1rohgEgLTuYzonxRHjDIacVj9E0w6i0Ua89k+jfOHW96CITwp6D3lSOtn73SBK
	1b8uJ+UNlwNlLY7k7QdCGsExxW8YI80CCdCSiKQnNW4JlnID6ZHDTyMVeamV9AA8Oy8anu6DEy6
	GeOXMMNK9hg==
X-Received: by 2002:a05:622a:1819:b0:531:16a:5a3d with SMTP id
 d75a77b69052e-5335a1f032amr1321061cf.12.1790633111445; Mon, 28 Sep 2026
 15:05:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928075237.3055101-1-irogers@google.com> <CA+w=M=R7vMK9-YZufh1ZW7efsVh=vCVkeh2_4rPSAsN=SH8MuQ@mail.gmail.com>
 <CAP-5=fUFWGxNSS+TW4iHqeWu+24-R2rq63oBX19VxkTXnqo+4A@mail.gmail.com> <arrhc_7jvX_W2uXS@google.com>
In-Reply-To: <arrhc_7jvX_W2uXS@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 28 Sep 2026 15:04:59 -0700
X-Gm-Features: AclHuK_htnD34uMf4P2yvFXVI_-906AbkfBwNGfpX8cxb5YUIQgE5dTKJuOd5kE
Message-ID: <CAP-5=fUuwXTN6kjDrSqygN-Dy3OFuWMH705_tsCXX=dbG747QA@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] perf symbol: Reference counting, flat array
 storage, and LRU shrinking
To: Namhyung Kim <namhyung@kernel.org>
Cc: Alireza Haghdoost <haghdoost@uber.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 2:51=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Mon, Sep 28, 2026 at 01:55:26PM -0700, Ian Rogers wrote:
> > On Mon, Sep 28, 2026 at 12:45=E2=80=AFPM Alireza Haghdoost <haghdoost@u=
ber.com> wrote:
> > >
> > > On Mon, Sep 28, 2026 at 12:52=E2=80=AFAM Ian Rogers <irogers@google.c=
om> wrote:
> > > >    annotations. Saves 48 bytes per struct symbol (two rb_nodes) and=
 provides
> > > >    cache-friendly binary search (bsearch) and callback-based iterat=
ion.
> > >
> > > Hi Ian,
> > >
> > > Thanks for posting this and for Cc'ing me. I built it on edd8a9fe2eca=
0,
> > > the same base as the v3 series I sent last week, and compared it with
> > > v3 in eager mode (today's behavior) and with --lazy-load-symbols.
> > >
> > > All runs use perf script --no-inline --max-stack 127
> > > -F comm,tid,time,ip,sym,dso, with one warm-up and three runs; the
> > > median is shown below. Peak anon is the maximum RssAnon from
> > > /proc/PID/status, sampled every 10 ms.
> > >
> > > 1) Production: 120 s cgroup profile of a storage service on an 80-CPU
> > >    host (perf record -a -g -F 99 -G <cgroup>). 54k samples, 11 DSOs,
> > >    5% of lines [unknown].
> > >
> > >                   time     max RSS    peak anon
> > >    v3 eager      4.5 s    386 MiB     314 MiB
> > >    v3 lazy       3.7 s    151 MiB      80 MiB
> > >    this series  95.9 s    309 MiB     275 MiB
> > >
> > > 2) A sample fixture from my v3 cover letter, a worst case with 73% of
> > >    lines [unknown]:
> > >
> > >                   time     max RSS
> > >    v3 eager      3.2 s    334 MiB
> > >    v3 lazy       1.9 s    106 MiB
> > >    this series 205.3 s    449 MiB
> > >
> > > Most of the time goes to reloading. On the fixture, a profile shows i=
t
> > > under map__find_symbol() -> dso__load() -> dso__load_sym(). After eac=
h
> > > shrink, the first miss in a shrunk DSO re-parses its whole symtab, an=
d
> > > addresses that resolve to [unknown] miss every time.
> > >
> > > The peak is still set by dso__load(), since the whole symtab is
> > > materialized before a shrink can run. That is the main blocker for us
> > > running perf script at scale: we can't bound how much memory it will
> > > use, so we have to contain it with memory.max, and then the profiling
> > > job fails with an OOM kill instead of degrading.
> >
> > Hi Alireza, and thanks for the feedback! I'll see what can be done
> > about dso__load in v2.
>
> Thanks for the patches and the analysis.
>
> I think many of this memory overhead come from the symbol string.
> Probably we don't use most of them.  Then would it be nice if we can
> lazy-load the strings?  Then it'd have an union of a pointer and a file
> offset for symbol strings.  The find-by-name API is used rarely for
> user DSOs and the kernel symbols should be fully loaded anyway.
>
> Without the string (and the priv part), now it has a fixed size so it
> should be saved in an array directly.  Probably we can add a limit there
> and print it with offset when it doesn't have the name.
>
> I'm a bit skeptical about the refcount approach here.  It may be hard to
> determine when it reclaims memory.  I guess the lazy-load strings with
> an array would give similar savings like Alireza's work.

Thanks Namhyung. Without reference counting we lack a good way to
discard symbols; we must either assume they always exist as in the
current code or implement reference counting. I don't see a way around
it. Alireza's patches introduced an "unknown" state for when a symbol
limit was hit, but I think that'd be frustrating in practice. We could
use it after trying to shrink memory use, in my opinion.

Fwiw, I never like switching the rbtree to an array. The issue is that
the rbtree has references that really should be managed by a reference
count. Doing that is a challenge in the current code and a sorted
array offers similar performance while simplifying the reference
counting.

We load all symbols instead of lazily because we need the end of a
symbol, which we can only determine by processing the entire symbol
table as the end of one symbol is the start of the next. We generally
translate one address in a DSO into a symbol, so loading all symbols
is overkill. I think we can do better by loading only symbols within a
certain address window rather than loading all symbols in a DSO. We
can then expand this window as more symbols are needed. This at least
bounds the number of symbols but isn't quite lazy loading.

Alireza also made good points about how symbols not being found or
being shrunk leads to thrashing patterns. I think we can fix this by
maintaining extra state in the DSO. I'm working to add this into v2.

Thanks,
Ian

> Thanks,
> Namhyung
>
