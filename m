Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0249D4A11
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Jun 2025 03:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749698332; cv=none; b=HMeGVN6s06vHOQBjNFkd1kJRaNFndNwrShcdVOTSTbnMzH1yGbUbotiXmTIT8pVMQ9OfQUbLybtiyh8veAuvEHlp2ogCDYHzJLME6pTFoqfbEeReilYvBLrRuDSCKk2W6SFbQrobp1q1hW98VovnFQbAO9+hGmlc6at7zUKvT1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749698332; c=relaxed/simple;
	bh=oWbfHnwsDcvRiVIG47R2mARy4M+VrLkvjEzVd2T5AjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XDsT7WCj+LJbfl8X2weOv0I3K/1tr0L5B7mI5lxVYwGA4y/O1wV4xqmYWPfDahZb/RSVwx6tstqrgtAbExYlDB5EIam6YPOx2GmWklMnhHW+0Bbog80iC6jqbpGpQBiq3cipxYNDsaHXYOSclFlHNX/QGO4xmkJj+DrHGUnK35s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r9hxtVtG; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r9hxtVtG"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60867565fb5so723961a12.3
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 20:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749698329; x=1750303129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27e+okI1P/k74gjOKKGPL59BBptQM40JJvOeix/wj8E=;
        b=r9hxtVtG8999Fr0ziEUBUq13yRNkxwaIBgByEva/3ws1cu//72Xc9aKwro9kdOvc7i
         Pn3UBsu3W+cV4QXyftuSMDT2pNVbF+lbyzj7mVJZvSdoaLmYt0gLMi4hDugSxF28zsek
         A6knt3CHwa7TL/Ob+79EMIZ2m0ltoFxYm/WNRe6+8XTdX6/tWDtuX66qSRBsZ1nqvFrT
         IvfN8jaVWGl4GPsGfkGqLgYgAiCRYgSOYkEh6FuNExVqzbeoE6R3dor9tRUd/xo4Q04P
         C2LQR3YOUJkqH/x4Ng2niKm7KB3zNStNt8pMPnpMHe2GilZnYT4Jo0Ta2dD78Pts7u7D
         aSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749698329; x=1750303129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27e+okI1P/k74gjOKKGPL59BBptQM40JJvOeix/wj8E=;
        b=GUC0i2MbI04iyI7MXs2SZcaEAwUjN0Dhro5Y0eq3qs9XJQYhwy/hrEZD8jNl+D4Bte
         0FXjT6g2eRBBEmuf/JydhN+/jIo56YNrC2bsy8lNGCDdFi7dBEBAzVkNZlLMT/MJnoTz
         mq4A8Rj0vPxiSFCb0JmZVtqVNAdP3ka4A8pFWritdKN1CrbLf3VZ8dD1eQde5c39J11L
         DiWxHpf7vgKIOq8uJ8oWHEqf5DhDguWffjavG0j1qtcIUraspAxBIInb5l+SBUxvJY1H
         yYpXp+tdAeu6G8jMTKw3RZkMy8cB/gMU0CQeyWtPptB4JJcZ0MnzrkcC8uB2Fu+clG3w
         AjmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKABkiai26/zSINLPtE6mRPuYYEB+8YDpEvDMNNNL00KWtD82xUoG4CK3nJTa/I9oBwiaphjkEVVAExqOy1QkE@vger.kernel.org
X-Gm-Message-State: AOJu0YzIB9Tx6/bqGLaWtoI2lmOsCNcYutdsKz+4zFjCiQBbRu5O3htA
	UMMMl01oZy3/3+EsnG0kYbfb4jd/Je7ed2zznmqylihiDs1WKvgFjgr2TSKdPJhiH4s9i8nXr0a
	ooVdpPFOVLssWJlGdQGGQhhhX5xH8IGfF2HBfRlp5
X-Gm-Gg: ASbGnctN37lihxmCjjC7s7xplIeBIC9XrNJgbOc+mSwro+j3LY7XjuIPkZHmWEvr5Ti
	zu3BrUjvhKnZbD1lPmaKpEyAX1RWCn+/B8g+pAgTRB75MQLjS3UCk2024rPgtuHig/fXHzqZOeM
	hlzVQyAUA71wR5TOqevkcgM7rgSguMor7y0BpDGzFXDg==
X-Google-Smtp-Source: AGHT+IGT1nq+v77NrogwC2vPW2rtS/9YmduwTQIuRku0gKjRxiTwDFKSBdaGdBr+aOmizt1RnUe062KnCvjThW3LkfM=
X-Received: by 2002:a17:906:7308:b0:ad5:59ef:7f56 with SMTP id
 a640c23a62f3a-ade8979c4b6mr652471566b.48.1749698329198; Wed, 11 Jun 2025
 20:18:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611233239.3098064-1-ctshao@google.com> <CAP-5=fXyB3H-msiSUGH_XqOntJNv-A2X7DtjvZO=nLzJgdTY+A@mail.gmail.com>
In-Reply-To: <CAP-5=fXyB3H-msiSUGH_XqOntJNv-A2X7DtjvZO=nLzJgdTY+A@mail.gmail.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Wed, 11 Jun 2025 20:18:36 -0700
X-Gm-Features: AX0GCFtprLsA0M2y1ufqbSz5pPgmEtShGMa5HqQdjZurUUQoPCjBD3meKiFjhuM
Message-ID: <CAJpZYjVxs3yAS1-Uj_aQjkHGo+hRkHnwCbWxNsS4pT50-rvRPg@mail.gmail.com>
Subject: Re: [PATCH v1] perf stat: Fix uncore aggregation number
To: Ian Rogers <irogers@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your test, Ian!

I wonder if `nr_pmus` makes sense, since the column would be shared
with multiple different pmus. WDYT?

-CT

On Wed, Jun 11, 2025 at 5:16=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Jun 11, 2025 at 4:36=E2=80=AFPM Chun-Tse Shao <ctshao@google.com>=
 wrote:
> >
> > Follow up:
> > lore.kernel.org/CAP-5=3DfVDF4-qYL1Lm7efgiHk7X=3D_nw_nEFMBZFMcsnOOJgX4Kg=
@mail.gmail.com/
> >
> > The patch adds unit aggregation during evsel merge the aggregated uncor=
e
> > counters.
> >
> > Tested on a 2-socket machine with SNC3, uncore_imc_[0-11] and
> > cpumask=3D"0,120"
> > Before:
> >   perf stat -e clockticks -I 1000 --per-socket
> >   #           time socket cpus             counts unit events
> >        1.001085024 S0        1         9615386315      clockticks
> >        1.001085024 S1        1         9614287448      clockticks
> >   perf stat -e clockticks -I 1000 --per-node
> >   #           time node   cpus             counts unit events
> >        1.001029867 N0        1         3205726984      clockticks
> >        1.001029867 N1        1         3205444421      clockticks
> >        1.001029867 N2        1         3205234018      clockticks
> >        1.001029867 N3        1         3205224660      clockticks
> >        1.001029867 N4        1         3205207213      clockticks
> >        1.001029867 N5        1         3205528246      clockticks
> > After:
> >   perf stat -e clockticks -I 1000 --per-socket
> >   #           time socket cpus             counts unit events
>
> I wonder if there is a better column heading than "cpus" given that
> these are imc PMUs.
>
> >        1.001022937 S0       12         9621463177      clockticks
> >        1.001022937 S1       12         9619804949      clockticks
> >   perf stat -e clockticks -I 1000 --per-node
> >   #           time node   cpus             counts unit events
> >        1.001029867 N0        4         3206782080      clockticks
> >        1.001029867 N1        4         3207025354      clockticks
> >        1.001029867 N2        4         3207067946      clockticks
> >        1.001029867 N3        4         3206871733      clockticks
> >        1.001029867 N4        4         3206199005      clockticks
> >        1.001029867 N5        4         3205525058      clockticks
> >
> > Suggested-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>

Added Namhyung's ack from the previous email.
Acked-by: Namhyung Kim <namhyung@kernel.org>

>
> Tested-by: Ian Rogers <irogers@google.com>
>
> Thanks,
> Ian
>
> > ---
> >  tools/perf/util/stat.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> > index 355a7d5c8ab8..52266d773353 100644
> > --- a/tools/perf/util/stat.c
> > +++ b/tools/perf/util/stat.c
> > @@ -527,6 +527,7 @@ static int evsel__merge_aggr_counters(struct evsel =
*evsel, struct evsel *alias)
> >                 struct perf_counts_values *aggr_counts_b =3D &ps_b->agg=
r[i].counts;
> >
> >                 /* NB: don't increase aggr.nr for aliases */
> > +               ps_a->aggr[i].nr +=3D ps_b->aggr[i].nr;
> >
> >                 aggr_counts_a->val +=3D aggr_counts_b->val;
> >                 aggr_counts_a->ena +=3D aggr_counts_b->ena;
> > --
> > 2.50.0.rc1.591.g9c95f17f64-goog
> >
