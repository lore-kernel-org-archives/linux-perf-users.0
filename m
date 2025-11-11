Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01568361DD6
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 20:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762894378; cv=none; b=hXYK9WM146mr3Focps7iTuREaTmLuVj6GW4EXzK2Ibn7vhWI6ZS270Rcd7Oft6W4U3HpKUF2lks5rKGecDbDP0+u5xCUuIR933yajkK2VvdCyv+RQh0i/Gy1Mpk5M/Rrw3z877BqOl63uvx+8UeVUUyjGJDXG6iQgbyOgmLaEQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762894378; c=relaxed/simple;
	bh=20fW040rhb53y55JF09naa+/dKCrt2hlbFDcMOkDPi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HxaIxOpBsrAHgimY9LgQOI0WFbeWkNs67JddtKW9/DIUFf2boKPAgi/fPjB8IKyIhPMvxSpP+7Jmon11Mg2fwlC9Y9OxnA9ho8/SkWkaV8TQf5+3QR/k73x/k16ic5bTGfeDrOBAbgd25/opIXpxELbSO2Bh/9K4HgFD8zEny8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h9ZMZVW9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h9ZMZVW9"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2959197b68eso5005ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 12:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762894376; x=1763499176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lB20FEz15VtCdLa08O1lBT4Wo59H+loRPzGbfYEV9zE=;
        b=h9ZMZVW9+kbzRIzRPp1EFrfz1QXoykzoS5GSxlT6a4X79wS99rBS5p5j8Ea5hynnHF
         d9aFG0nXe1iidsjU7c/P5SIwSc44e0iN+6fbBSt3oCjVBmMaMwrTiGGxfzGM6QjXT+Y2
         sZ9+T3vMJ+dSEVLg42mFwebAW53IyP/lrnUm8up00Q/4K5R5DG8xFlk5SUY4jcRUQuO6
         TvkrcuvtIn/sRB6PkmvNEjseE8CeHVsXtLOhbwAaA+GCyUuhdPOOdQ0jE80w/CIuhNfC
         B1w9TIIsG/WTuVhUDK+lpe/I5mZvdSHiOYzr4rembrfa1CfVxLuVs8cO8RQYROFLQoiO
         9hoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762894376; x=1763499176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lB20FEz15VtCdLa08O1lBT4Wo59H+loRPzGbfYEV9zE=;
        b=Qg0eIs4jcLFG7yMAad4yPP8eu0dUVm4XyrrohhkKCdLG18Hdb1Xypq6BdEV65Sd6pE
         LssYDOUYu6eNz0eWPcrsYJuPYKlpooqUcE3iZFlTtKskbWG2whYZKAq98/w8+35KFMWy
         m76wt4ZM0un+8nfjSfnM8+IznlJS5v/afU6csPIzZhm5gxq+SWymTFIDlj8aq4blMvIk
         hu35PbZAexZ2zuMFj5xcjuavYKdnkTMfUj/LGNikZAZnuU5/aVpGbemaiMaLamBK4Vjn
         ZJMmpj/reioyVnprOxizECWFnGXpKp7WuyAZNPa36V04XcKVN8sWMQj04OLunao9tQbE
         rJVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsk8Dm+7Ktm3+xpXEbDCYueYOYdOwlYyG0awA2TliWEGYKHnqIADqEggT1urmA1oFiMsGVDJRNS+N6bUdhohYH@vger.kernel.org
X-Gm-Message-State: AOJu0YzThWTcJn67jT14FwON+EZv+Qeg++xD3whhoG5HjL/ka5fQmc+I
	fH+T9z5lne2a9Y3K0CspjL4oF8aIGxmFUQN7BoJOEPTtc78zPsLsUEnhTJTq0p/ztkWN+5dg7gW
	ScWLVSEAXm3Yy9uZ/cyVq3Y4GdrFDTbXj4zsTQWLy
X-Gm-Gg: ASbGnctm0qtVczyYsTnSwkenEB5HJajxw07C5DMBO+5orEm7tVMVFdciS1ZL9j8iO0s
	4WhTtG1EvBD0XKvQJGc+R+5u7fuo205aMX5FScoAnxmISvd2yUkPffhzY6s6+Ezej1jQaB+Ivqx
	okpIpTkDeHVI9m90ElbNSdrFMRS8RqryaQheuMr+DvZgf2Fop3D/coMOvoL/UDuKg4IaH4WMhS3
	jWRLYCRIibspoFDZefZ4f1Z1t/tQaZoumjZtWlcuhvxyLPukwHFbpH0lJ2iohQqV/T5UykT8AaG
	KecBVec1X0D3vWE9kIbim9rk8f9z02SKOu17
X-Google-Smtp-Source: AGHT+IGILWK3Sees47bVwnkZffzKZ3iRj1UHlgzsog5iRfACCsge4YpukstXKacIcop6wyt7zQWQtjZn/9WH5sg+Wl8=
X-Received: by 2002:a17:902:dace:b0:294:f745:fe7b with SMTP id
 d9443c01a7336-2984f836f94mr862465ad.6.1762894375985; Tue, 11 Nov 2025
 12:52:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111040417.270945-1-irogers@google.com> <20251111040417.270945-7-irogers@google.com>
 <aRLeyoCQVG46KKEv@google.com>
In-Reply-To: <aRLeyoCQVG46KKEv@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 11 Nov 2025 12:52:45 -0800
X-Gm-Features: AWmQ_blA26dOnpW1ob14QsjySoD5F96dB3XzLqSOWaLQfqP9XTUOou5f3uryFBk
Message-ID: <CAP-5=fX8yMXKVbV8_TKaP0_jP3YC9AawgOtUsM+++JC9R0-VAQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/18] perf script: Change metric format to use json metrics
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 10:59=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Mon, Nov 10, 2025 at 08:04:05PM -0800, Ian Rogers wrote:
> > The metric format option isn't properly supported. This change
> > improves that by making the sample events update the counts of an
> > evsel, where the shadow metric code expects to read the values.  To
> > support printing metrics, metrics need to be found. This is done on
> > the first attempt to print a metric. Every metric is parsed and then
> > the evsels in the metric's evlist compared to those in perf script
> > using the perf_event_attr type and config. If the metric matches then
> > it is added for printing. As an event in the perf script's evlist may
> > have >1 metric id, or different leader for aggregation, the first
> > metric matched will be displayed in those cases.
> >
> > An example use is:
> > ```
> > $ perf record -a -e '{instructions,cpu-cycles}:S' -a -- sleep 1
> > $ perf script -F period,metric
> > ...
> >      867817
> >          metric:    0.30  insn per cycle
> >      125394
> >          metric:    0.04  insn per cycle
> >      313516
> >          metric:    0.11  insn per cycle
> >          metric:    1.00  insn per cycle
> > ```
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> [SNIP]
> > @@ -2150,23 +2296,72 @@ static void perf_sample__fprint_metric(struct p=
erf_script *script,
> >                        },
> >               .force_header =3D false,
> >       };
> > -     struct evsel *ev2;
> > -     u64 val;
> > +     struct perf_counts_values *count, *old_count;
> > +     int cpu_map_idx, thread_map_idx, aggr_idx;
> > +     struct evsel *pos;
> > +
> > +     if (!init_metrics) {
> > +             /* One time initialization of stat_config and metric data=
. */
> > +             struct script_find_metrics_args args =3D {
> > +                     .evlist =3D evsel->evlist,
> > +                     /* TODO: Determine system-wide based on evlist.. =
*/
> > +                     .system_wide =3D true,
>
> Probably you can check if the thread_map has an entry for -1.

Thanks, done. In testing this I found that the CPU map index lookup
can fail and so I added the same thread map index workaround of just
aggregating into the first count.

> > +             };
> > +             if (!stat_config.output)
> > +                     stat_config.output =3D stdout;
> > +
> > +             if (!stat_config.aggr_map) {
> > +                     /* TODO: currently only global aggregation is sup=
ported. */
> > +                     assert(stat_config.aggr_mode =3D=3D AGGR_GLOBAL);
>
> IIUC there's no option or config to set different aggregation mode for
> perf script.

Right. I don't think this patch needs to do everything given the prior
behavior wasn't working. We can add an aggregation mode. It probably
makes more sense to work on this in the context of perf stat report.

Thanks,
Ian
