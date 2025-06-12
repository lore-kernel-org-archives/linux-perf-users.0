Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA841DE3C0
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Jun 2025 05:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749705170; cv=none; b=jmN0mrHwiwSa3lYAnM0J5bw/q4ZW5u1QjuVHwNU1VaJRO/wCZhQjqq7diTmyRjoTB/VLJ/KA5iOjJx1s7nPwcITYZXQ5E1XgAzIAAqxxpW/g5rz2ZJYyP+tnXtDyAw4htVcGnKc0apMOstgAOAQtiMvSTbz8jCCq18F56U3CC10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749705170; c=relaxed/simple;
	bh=/sgG9pRcws1VWtmd9KhrNh1csTV9VFQlk5VxX/ukZKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iEjdyC4pYzdAo8YlL4tBDjvZiOWmhpzCg799QM16XwVMZn3229tDWnc8dll9nnrMsBHPG2LxaAjee5691oscXbKtAsK9JKiZ5K1eH16vdpJsu+Nk7l2NBahvwqRIpB8RYI83YgZBS7a2FeeGvg3Ef6H1YU2LSrPsTN1LWfBjS+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Om4UnU45; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Om4UnU45"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3ddc10f09easo102935ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 22:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749705168; x=1750309968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdaN/Zgh6q1i4+rKiM1kwsO14T+bDrERR9qijvq+wi4=;
        b=Om4UnU4504nZwegqk9nTBvOZ27B01KeZlRLevlpHCEqpD804smTq55ypc44+eebCG/
         oB0OUxpmhV6M3Cet74/HLXHKq6ESYhT2Z/xifLIOP3S2OzJcJj97UhxonUGM85OQle1Y
         Z1Oqoa6igg4mWyFX6C7Ev1pXLer9CVUYdtaLc3cS1jR8Wf2o/t9u1h+Tyub9poE+8bH/
         AYovyhlxdOOrZ1TkUB05SAwIiSpAtJvvN292882ywj+VgREIxksz0yPf7BsR+t//LZul
         OFKCJ6raGv886kM1KkdlLZqflx3r5kle4Asw62IS03nWDkt06BBQ453RPmEgAoU8f0Kt
         J0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749705168; x=1750309968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdaN/Zgh6q1i4+rKiM1kwsO14T+bDrERR9qijvq+wi4=;
        b=kg2yhYaYbQN8KRAogLcyvqCcrSLZupwO3Yc54AQyDcvR9/TqAOwaK7wDEfWA0cJdmb
         8u+YQ3J8iIJs/VMN6Lr5ChSALkrLR1c7sk05DN7z3o+bm45zhYHu1WKyS53TXwIUvgGB
         kPP7lKldWvSCYjtlz9tnhcajUJXUIjXAePANDxr+mq/NusqHfKeYGfLwBgXnZ7XKPNPz
         GHBxLV4bK32SAZyukXzE7qVWfDXNArlvNX0ubb3fSXGYarsDVIaEzYcLLJ0RtU6R/g42
         L+MCR9GvBFQeJfrOiizRQexj10Mdh+n8SpkUj/vaMA/wjsxb8m03Sc+QgyTg8Y+gwtsn
         qktQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR8gZTjFdGvV2Tp7GWIRGNM30BFcfX0L25l3zu6uMUDDy97yX8QwXQE+obZ1RvaDlsV+E0AMVA0ms+6UapAni5@vger.kernel.org
X-Gm-Message-State: AOJu0YwT5MBi7x2gXkXhLzP3of0vX7yVwtLCujGKkSaDbWmZYz8FrFaZ
	QMvgQC/ZsQFSchw35XcW27J25RI4Kp4enGPQ9OFifrch5H0U0V1AUpDiF9L2Uz3E0u2U//iFVuz
	k1Ndro730Yf2R4Qj3mLTyHw+G17Gl+v5KS6r6A0Cp
X-Gm-Gg: ASbGnctcwp/jTvYKHzz02Rm+5gZ/TGcN1sZXwpgM4+taONlokBRxOpFALSfrCJ0YEv0
	55YRy7m5sUsCSQU6/PPOPG/GVO7oR80OhEA9hDNSU2KvOkl9fd9MBG3DAGSi5HWbezm+Jm43Jbg
	oEZ0zkTY8MF1V0LltbvJPvhc1uvjeLu5yTS/EW6i/EkRQqyFnb32xyug8=
X-Google-Smtp-Source: AGHT+IG7YxzZA6X011xjZW2PBmgUDfJs9/CtCASjV34NKdLBmJyQaRIPMD9oQB3I1YB0BhoqUYh7fuMjqztm0z7ZA4A=
X-Received: by 2002:a05:6e02:148d:b0:3dd:a562:ce54 with SMTP id
 e9e14a558f8ab-3ddfbef136dmr1182945ab.15.1749705167982; Wed, 11 Jun 2025
 22:12:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611233239.3098064-1-ctshao@google.com> <CAP-5=fXyB3H-msiSUGH_XqOntJNv-A2X7DtjvZO=nLzJgdTY+A@mail.gmail.com>
 <CAJpZYjVxs3yAS1-Uj_aQjkHGo+hRkHnwCbWxNsS4pT50-rvRPg@mail.gmail.com>
In-Reply-To: <CAJpZYjVxs3yAS1-Uj_aQjkHGo+hRkHnwCbWxNsS4pT50-rvRPg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 11 Jun 2025 22:12:34 -0700
X-Gm-Features: AX0GCFtelBAVo2RzU2KvezCSYDyFJZNOtQ7A2u-EB7jcv8cHPKsueu0CQDYublg
Message-ID: <CAP-5=fWvnALUJiHrb_xzHXjseD88HF7LExs4N_Okg+UguuXsXg@mail.gmail.com>
Subject: Re: [PATCH v1] perf stat: Fix uncore aggregation number
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 8:18=E2=80=AFPM Chun-Tse Shao <ctshao@google.com> w=
rote:
>
> Thanks for your test, Ian!
>
> I wonder if `nr_pmus` makes sense, since the column would be shared
> with multiple different pmus. WDYT?

So each PMU in sysfs has a cpumask that specifies which CPUs perf
should pass to perf_event_open. For example, on a two socket machine
the cpumask will typically have the first CPU of each socket. If the
cpumask (or cpus) file isn't present then the cpumask is implicitly
all online CPUs. Given that the aggregation number is the number of
CPUs in the cpumask multiplied by the number of PMUs, I think the most
neutral name is probably "counters" possibly shortened down to "ctrs".
I suspect others have better suggestions :-)

Thanks,
Ian

> -CT
>
> On Wed, Jun 11, 2025 at 5:16=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Wed, Jun 11, 2025 at 4:36=E2=80=AFPM Chun-Tse Shao <ctshao@google.co=
m> wrote:
> > >
> > > Follow up:
> > > lore.kernel.org/CAP-5=3DfVDF4-qYL1Lm7efgiHk7X=3D_nw_nEFMBZFMcsnOOJgX4=
Kg@mail.gmail.com/
> > >
> > > The patch adds unit aggregation during evsel merge the aggregated unc=
ore
> > > counters.
> > >
> > > Tested on a 2-socket machine with SNC3, uncore_imc_[0-11] and
> > > cpumask=3D"0,120"
> > > Before:
> > >   perf stat -e clockticks -I 1000 --per-socket
> > >   #           time socket cpus             counts unit events
> > >        1.001085024 S0        1         9615386315      clockticks
> > >        1.001085024 S1        1         9614287448      clockticks
> > >   perf stat -e clockticks -I 1000 --per-node
> > >   #           time node   cpus             counts unit events
> > >        1.001029867 N0        1         3205726984      clockticks
> > >        1.001029867 N1        1         3205444421      clockticks
> > >        1.001029867 N2        1         3205234018      clockticks
> > >        1.001029867 N3        1         3205224660      clockticks
> > >        1.001029867 N4        1         3205207213      clockticks
> > >        1.001029867 N5        1         3205528246      clockticks
> > > After:
> > >   perf stat -e clockticks -I 1000 --per-socket
> > >   #           time socket cpus             counts unit events
> >
> > I wonder if there is a better column heading than "cpus" given that
> > these are imc PMUs.
> >
> > >        1.001022937 S0       12         9621463177      clockticks
> > >        1.001022937 S1       12         9619804949      clockticks
> > >   perf stat -e clockticks -I 1000 --per-node
> > >   #           time node   cpus             counts unit events
> > >        1.001029867 N0        4         3206782080      clockticks
> > >        1.001029867 N1        4         3207025354      clockticks
> > >        1.001029867 N2        4         3207067946      clockticks
> > >        1.001029867 N3        4         3206871733      clockticks
> > >        1.001029867 N4        4         3206199005      clockticks
> > >        1.001029867 N5        4         3205525058      clockticks
> > >
> > > Suggested-by: Ian Rogers <irogers@google.com>
> > > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
>
> Added Namhyung's ack from the previous email.
> Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> >
> > Tested-by: Ian Rogers <irogers@google.com>
> >
> > Thanks,
> > Ian
> >
> > > ---
> > >  tools/perf/util/stat.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> > > index 355a7d5c8ab8..52266d773353 100644
> > > --- a/tools/perf/util/stat.c
> > > +++ b/tools/perf/util/stat.c
> > > @@ -527,6 +527,7 @@ static int evsel__merge_aggr_counters(struct evse=
l *evsel, struct evsel *alias)
> > >                 struct perf_counts_values *aggr_counts_b =3D &ps_b->a=
ggr[i].counts;
> > >
> > >                 /* NB: don't increase aggr.nr for aliases */
> > > +               ps_a->aggr[i].nr +=3D ps_b->aggr[i].nr;
> > >
> > >                 aggr_counts_a->val +=3D aggr_counts_b->val;
> > >                 aggr_counts_a->ena +=3D aggr_counts_b->ena;
> > > --
> > > 2.50.0.rc1.591.g9c95f17f64-goog
> > >
