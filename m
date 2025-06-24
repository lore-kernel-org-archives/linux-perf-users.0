Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB433074AE
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Jun 2025 22:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750803906; cv=none; b=dAaGnY+ilOkXlRTdksqTi44I5CCuje4/2naaUfoFMKfd85X2HzT1HcTINS7Ku8+EyUbg8ns1Foyt9FqqJuvB48XGEFJaiA38CGqeQbsxyYan8fmeJXb3IrrmzCzcivqt9CFY1OzqwUEkw3b3UFngNeWE2J0c7d+k67HJu2USlNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750803906; c=relaxed/simple;
	bh=qxITTXfJl1bAofbweECFJWU5tEr7FOuNhaTeqFAv08w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ib4/6/gE27pcZ8Dlv+shmfNQ/wzgNj2eMbqigbAuKX0O6zGZRj0bTygWkb9UeWcpxsGhIoVgcjPzfAcaPbkfGhyhKSOrgdKvOnbYbkqo6rRrAm1DlB+11nufzJpVwr/EfmOADDTFySnml/c0eoEpyeFylwGiGYRyD4WDHLdMUFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DWmJthgy; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DWmJthgy"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60c3aafae23so694617a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Jun 2025 15:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750803902; x=1751408702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eN40yuRWbz23nB06NclW+rqusncs42Tkk2zTTzoDTuo=;
        b=DWmJthgyCHFsRTf4CmUb6f2UN88waoRp1AlmSeVusOnAwVhyyMdGKlNSNd2lp0KR8N
         isk/AkLoyAvTkMSn+Nudg1BzSdT7WK8KYdp5hvIZ1s1KT4te6et5H3fcG62pAsy2RDRm
         NqpKrHsb8Efe6MDVbAykRCXivNyySmHy+adBIUEjhReVhk45KBTtZ9NwNKkwDFhzUTM5
         +7JP3jzeu6owuA1u0rZC9NZjDIrjNH81J9MbTl04cPN2Ez0X6E8yg9Esl0aXcL8RtOIl
         pRhBcFJ7Ywnq413hisz4sA2enoLPe7QRIxl9ikGSDWRFJkA+e/99NvVNa/fM6H1qyGRG
         0LyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750803902; x=1751408702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eN40yuRWbz23nB06NclW+rqusncs42Tkk2zTTzoDTuo=;
        b=oEhnXRDvAzDAS09pOdCxdG0V33adMtANCvWxsBO9ERJH5Yd3GQqa3du0EpNsAq9yA1
         msoN/LWMl0DlJTitT+vHOnD4GJhsux/5og+e40PC6HA+bq0enMUBV9kRC6xzf9rsdrEZ
         7/gZt1XdPDHmzBcTAoHrPrz9nY0dZeIVdxHo+GrQCh0g3AgbSrG7irv8a0voWpUS8EiD
         613szGaY1m7Cb2/xoJcwERK4Yw43HLDPAC1BbNG8Tl4fIBtS8sU6WrhDhFplueMpU1kl
         8lFEcTlTzynSDpuyNCRD+VddC5y1LDQRTEWlujeivdx8JodgZEufsf6Turfj0qUzR8k5
         sfyA==
X-Forwarded-Encrypted: i=1; AJvYcCWzVE823NO/eS2xrpzDm+V/tAd8oiPbFQy/QVbDcEiaj+dK3tJOyRafO6d/6yxAAsfB2eIZ9+QGtcvXiwSOCIL+@vger.kernel.org
X-Gm-Message-State: AOJu0YwyOkAsNkd1Co2qLpTVcOGLtk7XLTtrDxRAi29H8iK+iFSnAS5b
	bki9XlQ4xMQWI0H2DIiufjK/fIiEe+r8nzSSv6ttumSqZrQhTYfjM5+vgzfjzcMQF66VFcvYmR2
	viKpnyFX2+oLgl70lV/t7k1iWT16cUExAwAZh+gVu
X-Gm-Gg: ASbGnctd+CqY7nzXtebJjtXHPOVArtqLSlSc17DA/QhfSsBHQNiITlkWfKZ0FjYUDiY
	Uy6qAE5cfQG3+ZOIk9AgN4bZ5mqNg/U4KM8cptCpKBR1BhVTpmml/Kz0f+P36aAhsxccG/3Gjz/
	qw5WbPwCMdsktsh4WU2C2LrSN4U/JpwuTib2Wmukj3oZFC0OR/qqRYe6tWs+xk1EdD5yvGsdxWP
	yAAX4UvIg==
X-Google-Smtp-Source: AGHT+IElwl0aDd0Uk8fCh2ZxSPYn3SVDjO3AL+oVXGCLjxmyTSVNi4dOOHXrmLvZaEfRwBcBRdoFc2JVBaMRqm9Buco=
X-Received: by 2002:a17:907:7857:b0:ad8:e448:6c64 with SMTP id
 a640c23a62f3a-ae0a74421e7mr369640566b.24.1750803901625; Tue, 24 Jun 2025
 15:25:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611233239.3098064-1-ctshao@google.com> <CAP-5=fXyB3H-msiSUGH_XqOntJNv-A2X7DtjvZO=nLzJgdTY+A@mail.gmail.com>
 <CAJpZYjVxs3yAS1-Uj_aQjkHGo+hRkHnwCbWxNsS4pT50-rvRPg@mail.gmail.com>
 <CAP-5=fWvnALUJiHrb_xzHXjseD88HF7LExs4N_Okg+UguuXsXg@mail.gmail.com>
 <CAJpZYjWUUbnNyBYXNSu_mmUrYLhNHHmdro8r08Xe0tN7nAanxg@mail.gmail.com>
 <aFXctF683XlLmiRy@google.com> <CAP-5=fW39O4=fu4CkcZSJWMA-5gkPaixGhWZecqMnrQt_vYsCg@mail.gmail.com>
 <aFnj29spuj3mKZLc@google.com>
In-Reply-To: <aFnj29spuj3mKZLc@google.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Tue, 24 Jun 2025 15:24:50 -0700
X-Gm-Features: Ac12FXxli0aIVnI8rb_8dSJp5GUmTP7_33PL1ROUnI2Ctifz4fioRZToSRtDyHU
Message-ID: <CAJpZYjUHfU0WF=xf1LRoXKmtHwRsMTxNngbz60kH_qP=rcu1XQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf stat: Fix uncore aggregation number
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your suggestions, Namhyung and Ian. I submitted v3 patch:
https://lore.kernel.org/linux-perf-users/20250624221545.1711008-1-ctshao@go=
ogle.com

BTW, I just realized the --metric-only option makes the output
unaligned. It is hard to show in an email but if you try:
`perf stat -M uncore_frequency,uncore_frequency --metric-only -I 1000
--per-socket`
You would see the problem. I will take a look once I have a chance.

-CT



On Mon, Jun 23, 2025 at 4:31=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Jun 23, 2025 at 11:17:20AM -0700, Ian Rogers wrote:
> > On Fri, Jun 20, 2025 at 3:12=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > Hi CT,
> > >
> > > On Thu, Jun 12, 2025 at 03:55:59PM -0700, Chun-Tse Shao wrote:
> > > > Hi Ian, I actually renamed it to `aggr_nr` in v2 patch so it should=
 be
> > > > better aligned to json mode, which is using `aggregate-nunber`. But
> > > > anyway I think any name other than `cpus` is better.
> > > > v2 patch: lore.kernel.org/20250612225324.3315450-1-ctshao@google.co=
m
> > >
> > > I think "aggregation-count" is a better name, maybe abbreviated to
> > > "ag_cnt".  Can we rename the JSON as well?  I'm not sure if it's
> > > documented somewhere.
> >
> > Fwiw, I still think "counters" is a clearer, more intention revealing
> > definition than "aggregation count" or "aggregation number". The term
> > counter appears in the perf-stat and perf_event_open man page. In the
> > perf-stat man page we have a pattern of:
> >
> >        --per-XXX
> >            Aggregate counts per XXX for system-wide mode measurements. =
This is a
> >            useful mode to .... To enable this mode, use --per-XXX
> >            in addition to -a. (system-wide). The output includes the ..=
.
> >           This is useful to gauge the amount of aggregation.
> >
> > It seems that the aggregated value of the counters could be confused
> > for being an "aggregation count" or "aggregation number" given the man
> > page definition. I think "counters" to some extent avoids this, we
> > giving the number of counters aggregated. The perf-stat man page could
> > certainly be clearer :-)
>
> I'm fine with "counters" (and "ctrs").
>
> Thanks,
> Namhyung
>
> > > >
> > > > On Wed, Jun 11, 2025 at 10:12=E2=80=AFPM Ian Rogers <irogers@google=
.com> wrote:
> > > > >
> > > > > On Wed, Jun 11, 2025 at 8:18=E2=80=AFPM Chun-Tse Shao <ctshao@goo=
gle.com> wrote:
> > > > > >
> > > > > > Thanks for your test, Ian!
> > > > > >
> > > > > > I wonder if `nr_pmus` makes sense, since the column would be sh=
ared
> > > > > > with multiple different pmus. WDYT?
> > > > >
> > > > > So each PMU in sysfs has a cpumask that specifies which CPUs perf
> > > > > should pass to perf_event_open. For example, on a two socket mach=
ine
> > > > > the cpumask will typically have the first CPU of each socket. If =
the
> > > > > cpumask (or cpus) file isn't present then the cpumask is implicit=
ly
> > > > > all online CPUs. Given that the aggregation number is the number =
of
> > > > > CPUs in the cpumask multiplied by the number of PMUs, I think the=
 most
> > > > > neutral name is probably "counters" possibly shortened down to "c=
trs".
> > > > > I suspect others have better suggestions :-)
> > > > >
> > > > > Thanks,
> > > > > Ian
> > > > >
> > > > > > -CT
> > > > > >
> > > > > > On Wed, Jun 11, 2025 at 5:16=E2=80=AFPM Ian Rogers <irogers@goo=
gle.com> wrote:
> > > > > > >
> > > > > > > On Wed, Jun 11, 2025 at 4:36=E2=80=AFPM Chun-Tse Shao <ctshao=
@google.com> wrote:
> > > > > > > >
> > > > > > > > Follow up:
> > > > > > > > lore.kernel.org/CAP-5=3DfVDF4-qYL1Lm7efgiHk7X=3D_nw_nEFMBZF=
McsnOOJgX4Kg@mail.gmail.com/
> > > > > > > >
> > > > > > > > The patch adds unit aggregation during evsel merge the aggr=
egated uncore
> > > > > > > > counters.
> > > > > > > >
> > > > > > > > Tested on a 2-socket machine with SNC3, uncore_imc_[0-11] a=
nd
> > > > > > > > cpumask=3D"0,120"
> > > > > > > > Before:
> > > > > > > >   perf stat -e clockticks -I 1000 --per-socket
> > > > > > > >   #           time socket cpus             counts unit even=
ts
> > > > > > > >        1.001085024 S0        1         9615386315      cloc=
kticks
> > > > > > > >        1.001085024 S1        1         9614287448      cloc=
kticks
> > > > > > > >   perf stat -e clockticks -I 1000 --per-node
> > > > > > > >   #           time node   cpus             counts unit even=
ts
> > > > > > > >        1.001029867 N0        1         3205726984      cloc=
kticks
> > > > > > > >        1.001029867 N1        1         3205444421      cloc=
kticks
> > > > > > > >        1.001029867 N2        1         3205234018      cloc=
kticks
> > > > > > > >        1.001029867 N3        1         3205224660      cloc=
kticks
> > > > > > > >        1.001029867 N4        1         3205207213      cloc=
kticks
> > > > > > > >        1.001029867 N5        1         3205528246      cloc=
kticks
> > > > > > > > After:
> > > > > > > >   perf stat -e clockticks -I 1000 --per-socket
> > > > > > > >   #           time socket cpus             counts unit even=
ts
> > > > > > >
> > > > > > > I wonder if there is a better column heading than "cpus" give=
n that
> > > > > > > these are imc PMUs.
> > > > > > >
> > > > > > > >        1.001022937 S0       12         9621463177      cloc=
kticks
> > > > > > > >        1.001022937 S1       12         9619804949      cloc=
kticks
> > > > > > > >   perf stat -e clockticks -I 1000 --per-node
> > > > > > > >   #           time node   cpus             counts unit even=
ts
> > > > > > > >        1.001029867 N0        4         3206782080      cloc=
kticks
> > > > > > > >        1.001029867 N1        4         3207025354      cloc=
kticks
> > > > > > > >        1.001029867 N2        4         3207067946      cloc=
kticks
> > > > > > > >        1.001029867 N3        4         3206871733      cloc=
kticks
> > > > > > > >        1.001029867 N4        4         3206199005      cloc=
kticks
> > > > > > > >        1.001029867 N5        4         3205525058      cloc=
kticks
> > > > > > > >
> > > > > > > > Suggested-by: Ian Rogers <irogers@google.com>
> > > > > > > > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > > > > >
> > > > > > Added Namhyung's ack from the previous email.
> > > > > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > > > > >
> > > > > > >
> > > > > > > Tested-by: Ian Rogers <irogers@google.com>
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Ian
> > > > > > >
> > > > > > > > ---
> > > > > > > >  tools/perf/util/stat.c | 1 +
> > > > > > > >  1 file changed, 1 insertion(+)
> > > > > > > >
> > > > > > > > diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.=
c
> > > > > > > > index 355a7d5c8ab8..52266d773353 100644
> > > > > > > > --- a/tools/perf/util/stat.c
> > > > > > > > +++ b/tools/perf/util/stat.c
> > > > > > > > @@ -527,6 +527,7 @@ static int evsel__merge_aggr_counters(s=
truct evsel *evsel, struct evsel *alias)
> > > > > > > >                 struct perf_counts_values *aggr_counts_b =
=3D &ps_b->aggr[i].counts;
> > > > > > > >
> > > > > > > >                 /* NB: don't increase aggr.nr for aliases *=
/
> > > > > > > > +               ps_a->aggr[i].nr +=3D ps_b->aggr[i].nr;
> > > > > > > >
> > > > > > > >                 aggr_counts_a->val +=3D aggr_counts_b->val;
> > > > > > > >                 aggr_counts_a->ena +=3D aggr_counts_b->ena;
> > > > > > > > --
> > > > > > > > 2.50.0.rc1.591.g9c95f17f64-goog
> > > > > > > >
