Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4903385A8
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Dec 2025 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764611583; cv=none; b=tK6gc5jJYuWGhaOvFFtBygkUCAPZj/ShVUBEOekb8uHcKxIkwmRz45qhtq6TSjV+hP2pV3JSFCqJ7IozidO4mjoqcfHmTbuDCukmUlTPDLiGmYHrE36fnZwOV2RVpj8ydUN8uJmCx2j4dwZU721Pl0zp0XORotzLDQGHbO6Mmlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764611583; c=relaxed/simple;
	bh=hdwCk9VFWrqtniY0B9Z6UhbfUshqpaGjKBjiisJuCjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJ0QEjFzmCSRu7/QiK4CnEzMr9rORvTCCxgOLsW1XdpcRuIGviIoEIzliKKbhAPqArnwW8EHo54GYXX0w3qPUU8Smcx7vcqG9IvPMPSoBqSVoHVVDgem8eteh8hgLljsuOUEOKZBezzyTjnfR1Hl+ZV1Nyx+YeQzGk6IX+rcg+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BXjlLeXz; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BXjlLeXz"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29852dafa7dso792055ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Dec 2025 09:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764611582; x=1765216382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g85xxDVPrEX2/uWa+088LU1FkUIllsa6FEYs8bGA6ww=;
        b=BXjlLeXzP04PDz0VeANNyduQJWN/tYQX9ELnngmsB1Gbmdcsi4KcPH5498XeJKJwHe
         RTbpzVqLtWTgwPHGDreTXvfH4lF3E3CYe2kzR3mgGuljKdo7uUsi4cmyBkZWlJjtj7dh
         h9I0R9bLnVD1i6I1GVOSEJm6x9X5i6/i1rAZYGaHzoxGHJtjmtk0bRSYm22uFcg8Dxzf
         +BK3+UiKxlyYXpKyw6enwp9Lwea2FFjQ5+wt58XtheNC1zdRZuw/rXfzvETAcOvKhMi3
         TLxat30dEqyHpFitsfMotDgqqNnEj8VtVx3UAQXJCDhVVWKMFyHqlgmUoKCtUMDwA5WD
         uynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764611582; x=1765216382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g85xxDVPrEX2/uWa+088LU1FkUIllsa6FEYs8bGA6ww=;
        b=QTii26mfjcmLrthXd0HWWL3nC55mYAP1So7eBZqBVmCjSfre1sqvqtDbMfNndGzoRV
         iNkkZdj5wdprHfSn2RNcLtQZgzX4ibKggyAe9JReC+gln1c0SQ3N4gPOnclNQOvQS+Rq
         TUlqr+V2Jhxh0uqWVQTeZYV9uG/JrCXvBxhTnmHNlKxUd0P+x8Rq0ZZrhYyuVOdDMszW
         p2Qx9XQSywWJswXlvWBq6hYOvaeWsKtDgyEnNeK/qaKvVz2USFKolbowL7eI5divQm4U
         5FfUcQ8cE2kzIoMwSFTtfx6LguV2OTxDfBKISWJYVNDYW3kLqNGYlmOua1mS2giHe9wE
         ddbw==
X-Forwarded-Encrypted: i=1; AJvYcCVKNkKXShvJ3M3xb/vlvEpEZQa6SFFsJZw+pavOqnI09qGnWK6ZwgGqAQnak97uNUYlleUEtYV7tHCAab97/AMt@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4GRRSTdb5cIGqrKskVonR7+FYKVlme4ZjB0eDUdywAOFsskGl
	tOzwiItbbC4Hks1KGTQDe5DE6UcGC0n793PoJOZU9PgRjBiCGBvv9QGZkVIXEn3H16a2nOdizvr
	uOPJi83FAJn5XOU0QMCoDxZ8fE3f/x6B9Gy2fdaOe
X-Gm-Gg: ASbGnct2yKf/FnGfVHM1ofgGpRKwTROvxP4wjZSA+3ya9+omegk+MaHgoAFmW/dEQ7v
	SSAQ7ljh5szMPLnui4lAJDVEKQuSDSIeQN4px5OIplhRjXEoWFX6fNyVhxrXpQJ4NZec23JMr4w
	EujJTUPdV3mf/LWeKhv5aA2Kx1zUJUx9BOi+dTKDhF0nAnUGmV6YUDk3Yt4DIA/C0vooD00mkWz
	vnPyLPRewdJI5yKEPOsjN3asTD6uFKGJSJmJEDq/D56j4NUD/NucpsA7x2zr5k0FdabZr1Q0Pba
	WYhuLPsm3SDha5SuIgGLYPFHzA==
X-Google-Smtp-Source: AGHT+IHF1fBlxNFlEmyMJmTOvTO3ecjUH0vPoAy9UgPKgCNjlYARvAD1oKJ9R4qqT4ZPKLusRVU2SjNO6uwt7KV/Ro4=
X-Received: by 2002:a17:903:1251:b0:298:4819:f4d9 with SMTP id
 d9443c01a7336-29bc91862a5mr7761525ad.8.1764611581395; Mon, 01 Dec 2025
 09:53:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122081929.7588-1-irogers@google.com> <20251122081929.7588-7-irogers@google.com>
 <aS3M6_T-_UIr6eiU@x1>
In-Reply-To: <aS3M6_T-_UIr6eiU@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 1 Dec 2025 09:52:49 -0800
X-Gm-Features: AWmQ_bnRxQuUOCJC3Mg9OaAPauIZBWBaFmb335t8Vg98ctxSugCpN0xUy2BX_w8
Message-ID: <CAP-5=fUayM2OY5rV==dpWSQkbPO4pOLs+RtzUC1W2LexnTNc_A@mail.gmail.com>
Subject: Re: [PATCH v1 06/17] perf hist: In init, ensure mem_info is put on
 error paths
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Collin Funk <collin.funk1@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Thomas Falcon <thomas.falcon@intel.com>, Leo Yan <leo.yan@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 9:14=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Sat, Nov 22, 2025 at 12:19:18AM -0800, Ian Rogers wrote:
> > Rather than exit the internal map_symbols directly, put the mem-info
> > that does this and also lowers the reference count on the mem-info
> > itself otherwise the mem-info is being leaked.
>
> Shouldn't this have a:
>
> Fixes: 56e144fe98260a0f ("perf mem_info: Add and use map_symbol__exit and=
 addr_map_symbol__exit")

I don't mind the fixes tag. The change in that patch was:
```
        if (he->mem_info) {
-               map__put(he->mem_info->iaddr.ms.map);
-               map__put(he->mem_info->daddr.ms.map);
+               map_symbol__exit(&he->mem_info->iaddr.ms);
+               map_symbol__exit(&he->mem_info->daddr.ms);
       }
```
and so technically the memory leak predated that change.

Thanks,
Ian

> Other than that:
>
> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> - Arnaldo
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/hist.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> > index 64ff427040c3..ef4b569f7df4 100644
> > --- a/tools/perf/util/hist.c
> > +++ b/tools/perf/util/hist.c
> > @@ -608,10 +608,8 @@ static int hist_entry__init(struct hist_entry *he,
> >               map_symbol__exit(&he->branch_info->to.ms);
> >               zfree(&he->branch_info);
> >       }
> > -     if (he->mem_info) {
> > -             map_symbol__exit(&mem_info__iaddr(he->mem_info)->ms);
> > -             map_symbol__exit(&mem_info__daddr(he->mem_info)->ms);
> > -     }
> > +     if (he->mem_info)
> > +             mem_info__zput(he->mem_info);
> >  err:
> >       map_symbol__exit(&he->ms);
> >       zfree(&he->stat_acc);
> > --
> > 2.52.0.rc2.455.g230fcf2819-goog
> >
