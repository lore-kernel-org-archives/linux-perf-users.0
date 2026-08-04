Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEDC449EC2
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Aug 2026 21:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785877803; cv=pass; b=I5xfyZa82a+nYpTV5XBWhRUhrI5y+L5/P+rE4kjWnxgOSHfw2oWJ3p/xLh9RK6wYsnZa02AesmpDFz404SkA42Ot8sDGzuZGgbIq1ktY3R9JLK3FMBECP/8eV32/9zBcqk26ATssA37iLUzsi9f11/Y5dx6a6My0ET9JOsK8b80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785877803; c=relaxed/simple;
	bh=oM6MWlSz2H9anELO3jNp57msCnTEhD0kLk4MQb1nb3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uRTi/fV1RYqNHmug6hMQKcHKhxm5ihKtcVXmHSi2G3WzsLDyiW5w9PWhBYa7NZ5NzLJLplq1+0cINR9NhDZ6AkG77TcdWan1y+UqvOMMwNWerroEx3/bOqXsfWZvha0/fWSZiEhtmUqy3JfmG4gb85rTRka4bIkzGEA6RYcOY5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y9uINX2q; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y9uINX2q"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so303243a91.3
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Aug 2026 14:10:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785877799; cv=none;
        d=google.com; s=arc-20260327;
        b=kuZ8U1tx1UL4rucu8ytS+u5KX4lgzuAjJmupD49LhL5JIllfoUUZYTl8qfk4QbDsCn
         spQIVZav/lkRqnqyVCIh9e5Y/6UbkjERA6Gd3PYK0GL/e6U2/axhBwNqjiQBV7RG5IFt
         EpeHHBgkhvzFQorzjh9WMXv49n61jM0mxf5+sHgPbkMMFDp7B+YaryFmpO9WkbV0N9bu
         QrCJQSD+SJ7ptbxrtY0hU2LX59Mai8R/Y+yuxRBhk8O8i+LsVdxfs9+Imbe4QDC16PMb
         6AsooyKOK5NSloyb3L4a3ljGMajqoX5TadbIjl5aqIod5Yyw1iGX7VH9KfoC5PG7s85D
         uPKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fu4LE192jSvU1r4OOL9+TsH68J29zyG+w9TlNIlg5ag=;
        fh=CFUAolqwdQdjbeEWSdT1KE0idZWBjhh62HEdNDe+QfE=;
        b=jXKm9IcTLloBjpRepgB6F53ck2LBaGrI4HENTcOCIGN3RlMNa5Jncc2LmXnKEzX3xa
         T8Unlb8fYVzhU3tU2Px4wTKph8i+wDodNX+vpdDB1iCE56U6iw1ks8LoZ10RjPa+2iNK
         nilcgPzP1WT+H5darRwR6a69GuekeVncHYL7SDu1W9pga73YPF/deN1JjelI/X6i3f9A
         kISvpMYx+nyoKlngfZh0JQNwjtRzNAySHkn6c8LPjzxudxqO3mSUikKlGqZzRBKLc1dC
         hT1RApK525dP4gpnoXwM/3PA+bROWpbx2AwvsoHn0qbiZSqzoujKTvNJ7uEuSQBUYTos
         gInQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785877799; x=1786482599; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fu4LE192jSvU1r4OOL9+TsH68J29zyG+w9TlNIlg5ag=;
        b=Y9uINX2q5/F4iwZMmXou8CFNwfj8BoCvtdJhBqYwR/ucR+znYEAfvXy2O32kCChmLb
         PEAZ7rzT67fZ4BWb2YHpCi8Ome6nFKNyDy4RANaMDoXaTSURjncn2iKeoR/sH2GTxnbG
         wRuZysLffh9wQYc4t1ghlJkJ8GBJJlkex69RNrFHGB29J+xAIqj7QRVvWfUjct7eDg+f
         cxsblPT5xRC92cU1vmYLqeySc2j9k1lXg6sGyP2cLdSUVjZXLgTEXCzvuS905slkI1Bi
         fVw1R/Dunw1D/7wTuH47mC1/Zr7xTPSh8uOxR/4wX0ofKCf+mvpArgIi9mMurh14LrA3
         AdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785877799; x=1786482599;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fu4LE192jSvU1r4OOL9+TsH68J29zyG+w9TlNIlg5ag=;
        b=fbpGA64xyPa50ce9HWahGmj2J+M0astx0cMNaxyWv1RBXk98JlpHlKspzm/ElLfaWW
         d5X+14ZZjiGbuYlhYUTlTJV9NmhdYtl67LonEJVyZws/meMZvr8Gl6PRpgj5ZBo8R0HK
         K/nJsDL0boYcovmXuhHb6KIL4O7pqOgRessLIs65EyaNLpgKlQUfzLEL+vP2ZmoEZJOq
         HFXUM3orWo44BUdx30i4jmHrGGf9tiqmg75htZHZOx8FgQzJPqdsGmyA4I43iDCMEWWl
         qWFLKqZUShHZEnUHxsI3ksN7kA1mbLE5XRrB+yLYievbVE8qDL/R6tC4jYX5HPD27kyI
         oh4Q==
X-Forwarded-Encrypted: i=1; AHgh+RphcjGjvXJhidG8ciit3ilM/2rba6Z0Fnwa01qmBk8IZtDHFHBEeTLAhMsqUjsnNVS3Pi26M6MdMN82zniLXY8l@vger.kernel.org
X-Gm-Message-State: AOJu0Yxby0WwZC8O46L21HrABAPbSpDaoyxp9PSZjpT6TgV4YlaCDTJm
	vSLgJ7YMAjp30i8PPUOGVtFS6mNSktY+6Wt3/UX2aFL2jiv4aGjYKpS/waaz8HUGhq+lKQ9e5Go
	G8JJQDiwqDt2XVpHQOevMKBDCrcsyUG6Mh07r4gwL
X-Gm-Gg: AR+sD11xj9VKEsj/ePBgNZ+q13Klh7pKwR6adMoDG7EaAK0cNsbiWfQ4QfsiCCYeTj6
	0v+6m8cfgpIdBcHtd3TUWz6ud0DC3tyiwCe+7zqdervcjzKsEAp4KfSl6pxMrdlXqYXI4FKXR7m
	7SnfmHdEdNJ+dEtLnX17Ng2MLN2Eq53J2amuCGeCbZEA3VtmlACfmp/+Hwx8mpU3pLE/GzRUYa3
	6vCPItZugs7yKXKK+dYC9aIgsReZ2rhFetvP3bKzBaNj4f0kD8zr7boGKnP46LqV5FynDWwp1ka
	M4PLFXskJokRTTzy9de+irvcmQqQZECrudXb8Xt5cj23wq9STYhGxqXBEWO/JNIEzXO3zGd0eQI
	=
X-Received: by 2002:a17:90b:5484:b0:37f:c69d:ce69 with SMTP id
 98e67ed59e1d1-3903c581f08mr1946363a91.10.1785877797913; Tue, 04 Aug 2026
 14:09:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729170416.41904-1-ctshao@google.com> <20260729171742.24ABB1F000E9@smtp.kernel.org>
 <am0sWLrB5tNyTJQK@google.com>
In-Reply-To: <am0sWLrB5tNyTJQK@google.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Tue, 4 Aug 2026 14:09:21 -0700
X-Gm-Features: AUfX_myhTeJ4ugAZtdx6HhCnO8mpaOcT2gGkqaQGqvM0OuHHLxd9R4TEhUTlwQg
Message-ID: <CAJpZYjW3L-E6rhxLg8etDJYbg2XbZ--aH8pP131Gv4WECaDxLg@mail.gmail.com>
Subject: Re: [PATCH v3] perf stat: Include PMU name and split uncore events
 per PMU in metric-only JSON output
To: Namhyung Kim <namhyung@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 4:14=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Jul 29, 2026 at 05:17:41PM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [Medium] Flawed line-split transition logic causes spurious empty JSO=
N objects and incorrect PMU attribution for tool events.
> > --
> >
> > --- Patch [1]: [PATCH v3] perf stat: Include PMU name and split uncore =
events per PMU in metric-only JSON output ---
> > commit 20e3cd08fd5e415b458343262ee76bc1f5f6ce85
> > Author: Chun-Tse Shao <ctshao@google.com>
> >
> > perf stat: Include PMU name and split uncore events per PMU in metric-o=
nly JSON output
> >
> > This commit modifies perf stat JSON output in --metric-only and -A mode=
 to
> > group metrics by PMU. It achieves this by adding a "pmu" key to the JSO=
N
> > output and starting a new JSON line when the underlying PMU instance ch=
anges.
> >
> > > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-di=
splay.c
> > > index b337cc23f4131..6785e2c442bd7 100644
> > > --- a/tools/perf/util/stat-display.c
> > > +++ b/tools/perf/util/stat-display.c
> >
> > [ ... ]
> >
> > > @@ -1146,13 +1149,34 @@ static void print_no_aggr_metric(struct perf_=
stat_config *config,
> > >                             if (config->aggr_map->map[aggr_idx].cpu.c=
pu =3D=3D cpu.cpu)
> > >                                     break;
> > >                     }
> > > +                   if (aggr_idx >=3D config->aggr_map->nr)
> > > +                           continue;
> > >
> > >                     os->evsel =3D counter;
> > >                     os->id =3D aggr_cpu_id__cpu(cpu, /*data=3D*/NULL)=
;
> > > -                   if (first) {
> > > -                           print_metric_begin(config, evlist, os, ag=
gr_idx);
> > > -                           first =3D false;
> > > +
> > > +                   if (config->metric_only) {
> > > +                           struct perf_pmu *pmu =3D counter->pmu;
> > > +
> > > +                           if (!evsel__is_tool(counter)) {
> > > +                                   if (config->json_output && line_o=
pen &&
> > > +                                       (!last_pmu || pmu !=3D last_p=
mu)) {
> >
> > [Severity: Medium]
> > Does this line-split transition logic handle tool events correctly depe=
nding
> > on their order in the event list?
> >
> > If a tool event is processed first, line_open becomes true, but last_pm=
u
> > remains NULL. When the next event (a PMU event) is processed, the condi=
tion
> > (!last_pmu || pmu !=3D last_pmu) evaluates to true. This prematurely cl=
oses
> > the line and creates a spurious empty JSON object for the tool event.
>
> Something like this?
>
>   $ sudo ./perf stat -aA -e user_time -M insn_per_cycle -j --metric-only =
true
>   {"cpu" : "0", "pmu" : "tool"}
>   {"cpu" : "0", "pmu" : "cpu_core", "instructions  insn_per_cycle" : "0.8=
"}
>   {"cpu" : "1", "pmu" : "tool"}
>   {"cpu" : "1", "pmu" : "cpu_core", "instructions  insn_per_cycle" : "0.1=
"}
>   {"cpu" : "2", "pmu" : "tool"}
>   {"cpu" : "2", "pmu" : "cpu_core", "instructions  insn_per_cycle" : "0.5=
"}
>   {"cpu" : "3", "pmu" : "tool"}
>   {"cpu" : "3", "pmu" : "cpu_core", "instructions  insn_per_cycle" : "0.3=
"}
>   ...
>
> Thanks,
> Namhyung

Thanks for the test, I sent the v4 patch for fixing this problem:
lore.kernel.org/20260804210659.112192-1-ctshao@google.com

Test:
  $ perf stat -aA -e user_time -M insn_per_cycle -j --metric-only true
  {"cpu" : "0", "instructions  insn_per_cycle" : "0.9"}
  {"cpu" : "1", "instructions  insn_per_cycle" : "0.6"}
  {"cpu" : "2", "instructions  insn_per_cycle" : "0.2"}
  {"cpu" : "3", "instructions  insn_per_cycle" : "0.1"}
  {"cpu" : "4", "instructions  insn_per_cycle" : "0.2"}
  {"cpu" : "5", "instructions  insn_per_cycle" : "0.1"}
  {"cpu" : "6", "instructions  insn_per_cycle" : "0.1"}
  {"cpu" : "7", "instructions  insn_per_cycle" : "0.1"}
  {"cpu" : "8", "instructions  insn_per_cycle" : "0.1"}
  {"cpu" : "9", "instructions  insn_per_cycle" : "0.1"}
  ...

-CT
>
> >
> > Conversely, if a tool event comes after a PMU event, the else-if block =
below
> > is taken because !evsel__is_tool(counter) evaluates to false. This bypa=
sses
> > the line-splitting check entirely, causing the tool event to silently m=
erge
> > into the preceding PMU's JSON object and incorrectly inherit its PMU
> > attribution.
> >
> > > +                                           print_metric_end(config, =
os);
> > > +                                           line_open =3D false;
> > > +                                   }
> > > +                                   if (!line_open) {
> > > +                                           print_metric_begin(config=
, evlist, os,
> > > +                                                              aggr_i=
dx, counter);
> > > +                                           line_open =3D true;
> > > +                                   }
> > > +                                   last_pmu =3D pmu;
> > > +                           } else if (!line_open) {
> > > +                                   print_metric_begin(config, evlist=
, os,
> > > +                                                      aggr_idx, coun=
ter);
> > > +                                   line_open =3D true;
> > > +                           }
> > >                     }
> >
> > --
> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729170416.=
41904-1-ctshao@google.com?part=3D1
