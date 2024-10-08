Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FB6216458
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Oct 2024 23:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728430433; cv=none; b=UonEgU+hWvWNi41kUxvXJ6v5bEe4ukllZp2sE7HVqKALf+xUC6FsEkn3cLHFlhkBKZ6FSdyYEZHX5EqK2UOaTHmFk7cm5ljyTi4fx7fhRyxASr6gLOd7dC4us7mLuwsywSWeWC2u4idwY20k36zTtQyL6gcFauw8XKLw3WmOmo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728430433; c=relaxed/simple;
	bh=d07x/Y6C1iI6lK99A3UROkBoeJl9oKGIPcEveOiNYnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VP3vQ7++PfgganrgLpVH1WZl0j9jAqC4rNHV4F4f9nRh5h+tZ9Nd7zDDtxUE71B74uY50EE1HGWhkYR4gZ6eT3gctU3lJ3PP7e1Lm5qr6nZc/+KAqzBg5t2C3a+RcEhj/fF25cM7l2ouG2gB1zE9pSFm8Brx1Jh0qWxhcaO8msE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DUhXOnud; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DUhXOnud"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4582fa01090so114211cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Oct 2024 16:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728430430; x=1729035230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aeLI0iUkXUyybbpSQG2xEHD5VlIOemulh+VGYKcugg0=;
        b=DUhXOnudkmDeBE7OsgvVckXpgefV6I1DOa4NuBZPO5eCv47mvFW6QTsTtApKY9PPBR
         cpEcb8K3liXIKvWNRCQ88PEBBWmXCmX1cJONEmlJkBmoFnFP59lTIDu48AQBZ4xiteiB
         hK4LTr2xmy+s97JaEYEhF/4kCWdpa1gVbbh5EFgeAy51tb9WMRw9ljsaiqntgEmEsqnn
         lAfTlU/e3hS7JJ3Dw63NiydsdQwfDvRSXVkdkimBDFYKcj+9HpuvS2Bp17S6MmBcAVqF
         oNbJYL2ODtYsyHZUgduJJDtgROP+PUPWqrb35bz8SOf/Q4iwl18QHyBbn61WNPU3HvgQ
         /y2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728430430; x=1729035230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aeLI0iUkXUyybbpSQG2xEHD5VlIOemulh+VGYKcugg0=;
        b=olfA0nLz7RXZWiRQlDoTDkhbO/3JKG2M8TBm88NLTqxLNiP7ROdGfbGQTrofXO1DHP
         t0IIzGSqjWbGnF6IlGxzF3MQTcQn1IrWcO3/icLwPq7nAkykjIEOR771puNrIwcfvDNF
         ZtZgaKhGxBTFduB8abN29p/gAs+qOBtHioAjhdHQc1mZQ4NKDmf3VvNBBy90NfzfW5MW
         +vthcQ5rIUFgMlE9yF5sZOBitJC7Iu6mzJbSRU6m8EsUDIpFBZIiKtAE1DaIO4QE+A2W
         ksAX3KuR1N73KdmJMXQwmn+bR1E/r3BcrQ0yGNk0vNLEsHVwAs/oVoQTyhwWKIRYnKXt
         bIdg==
X-Forwarded-Encrypted: i=1; AJvYcCX0ji82YusZ39RdzFsaICFBaJM5NxhJLQ4p3H9/QSdX+aQniXMorpuQ/3Wwqp4joEMF57Gdo3fOzvOoh6wF1vg1@vger.kernel.org
X-Gm-Message-State: AOJu0YwhPCQ0lfCaJ2IxmbXGpwbRb5AVX+9hE9ncZZT/jKfDiPutbekJ
	JxTbHV9kF+J76qfNyxCByRdZ0sdsmg1vuwtIp/UxqOoVKxXLf/WJKoSpwyoHJRSWrczOkiFBmfW
	jcE+UxMBCuePiwxxrpRytR6Sk1Fhu/+1xmsAr
X-Google-Smtp-Source: AGHT+IE6ZXXpGm9HDy2/sV1TQYVQsXPj3Jhbm2MOccl+vdMN9kP41dvo3cMMR+q6utFMzt8mGNzXn1zXooRiv72elYA=
X-Received: by 2002:a05:622a:47c9:b0:45e:fd06:1992 with SMTP id
 d75a77b69052e-45fc8c3e482mr617711cf.27.1728430430052; Tue, 08 Oct 2024
 16:33:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004234120.1495209-1-irogers@google.com> <20241004234120.1495209-5-irogers@google.com>
 <3fb7cc3fab054ad5b2af8a5ae5fd7dbdace774a2.camel@linux.intel.com>
In-Reply-To: <3fb7cc3fab054ad5b2af8a5ae5fd7dbdace774a2.camel@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 8 Oct 2024 16:33:36 -0700
Message-ID: <CAP-5=fWXsOTTuEcM+AnYHeEZEaiy1u4w21DoNO87HaXjjbTRwA@mail.gmail.com>
Subject: Re: [PATCH v1 4/8] perf stat: Drop metric-unit if unit is NULL
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Yicong Yang <yangyicong@hisilicon.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 4:27=E2=80=AFPM Tim Chen <tim.c.chen@linux.intel.com=
> wrote:
>
> On Fri, 2024-10-04 at 16:41 -0700, Ian Rogers wrote:
> > Avoid cases like:
> > ```
> > $ perf stat -a -M topdownl1 -j -I 1000
> > ...
> > {"interval" : 11.127757275, "counter-value" : "85715898.000000", "unit"=
 : "", "event" : "IDQ.MITE_UOPS", "event-runtime" : 988376123, "pcnt-runnin=
g" : 100.00, "metric-value" : "0.000000", "metric-unit" : "(null)"}
> > ...
> > ```
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/stat-display.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-disp=
lay.c
> > index e392ee5efb45..9b65968e37d1 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -470,8 +470,9 @@ static void print_metric_json(struct perf_stat_conf=
ig *config __maybe_unused,
> >       struct outstate *os =3D ctx;
> >       FILE *out =3D os->fh;
> >
> > -     fprintf(out, "\"metric-value\" : \"%f\", ", val);
> > -     fprintf(out, "\"metric-unit\" : \"%s\"", unit);
> > +     fprintf(out, "\"metric-value\" : \"%f\"", val);
> > +     if (unit)
> > +             fprintf(out, ", \"metric-unit\" : \"%s\"", unit);
>
> I think if there's no metric unit, we should skip printing metric value a=
s a metric
> of 0 has no meaning.

Makes sense to me too. It requires some test fixing to make work. I'll
take a look.

Thanks,
Ian

> >       if (!config->metric_only)
> >               fprintf(out, "}");
> >  }
>
