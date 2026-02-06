Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046D535975
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Feb 2026 22:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770416199; cv=pass; b=WGCvLxLyvgtp9sxkYYy7X7xeRxdYqesyh+pGgTi7FmnoXDfXkAVv2VHJFZ9S8myTdwu6tKuMbTVIV9tuLTZ9gNLZiLo4WJM8MWz1U5psrhXIjFPbyL17ttZ22iPw+HSYY4FtS8ljq8SRD5pyqApIcMPvBdIcSBN4/r/+1sBCSbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770416199; c=relaxed/simple;
	bh=dit5lbshhnO0V+bp8dP+A4RhIQd5hhGTny768pMlP1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M39I3K/QRcG/9BJ8BQPtwSCvfAz5SpDz2hBncMrlr5zazDYpwRW9of9DGzoFV4eO3O8vbkybh9+znHcU+Sqy1j/krTU6Y59FriHoCteLd6QIKH5UcVPOK8mHoFYNCJn/ay6LwN5rI1EAsG+JdjvlDgNsBWy9rPV7GBZxwbDpOOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KAR5afLs; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KAR5afLs"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a76b39587aso8505ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Feb 2026 14:16:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770416198; cv=none;
        d=google.com; s=arc-20240605;
        b=VLEPzLqnq0yorD48+GPKVJsdCZhZqfW2cgnjxKArCUua14j9X1uhCfnYo1nW156u/0
         aMRcTW25AXe703LqxEsUZbZjwodIQ76s+fyHue/h8fCzVHiSo7Wxc0m2WAvREO8qkrz3
         blegM8DM6FuCamW+ylu2lZ2cj/gi6k9bJSDDmMeg/2a+CqsC/VhY7FInLA+2Nwxv4UnS
         jmJGTSJJvTKJ2HT8trBywcc9zXmy2WmyRiKGpV71jQK56mEJ/f3oQD4hKqXy62w1I2IM
         DfGKayRG0LmFI4hxzk1+wszhy2EmXkFuBXO3ZhhC+WVfMq9rguUTYduBFX3SGuhcbdLp
         tdGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o6oxrZnXZjssrAJLKm4rt1uzzsVCsTNkRCeBxE9yMj0=;
        fh=PQJZsjMwFBWcVNK4hzffe9SRTXZ/U64FGK41KVMpCWI=;
        b=RC9x/o5gnhUzr6DHO3B4UQHfcg45EIGO/2ul0m8Movq/WpMQhDFw3BBwTOXRZGiNYF
         hBP7XekyB5vntyfnAEglcp6aOzYgL12r0DzYiAwacQBtSzeMWzcoGW4Seh71+qiEQ60+
         ckXinbPzptLYosXciV5CDDs3IVECOmjDe4t8ar8htSCc1C5DU9/Fu6bJRYlN8t99QYZK
         QyzAzj+ByKfFptCqz/z/1hQ0LDGgdmpy6LJW8+VO9K5LnxD3UPGMc8T5SBf1bNQzbHih
         VXA+zsKMhmhQfhiY3XvplOrkIrVhtyD5ZJMZ/AScO34uwr06TWZCsvH9osXtTj6hnw2I
         kkhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770416198; x=1771020998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6oxrZnXZjssrAJLKm4rt1uzzsVCsTNkRCeBxE9yMj0=;
        b=KAR5afLs+4sDk/y+2OqWw8lCHsWTzhIHTnUvR0mrIHTBEEBtlt/g0fF3yV5hQXs3Uu
         7MZfqipeYOEb4wCP7zzpmjqUIz0VAuDbzhNinkMW8EHiWvTxOdMsDTK5c1kXcrBmEuJV
         boIAG/sL42QBNgwP/pV0kwmK/sUikoVbhEBG+5NnmJALEJngF4p+XwJHAbq4cdAlDEg9
         Nat64S+Ut0h0EioIfCKvg5n6FW85U2xxc8WWJ1MjFLHdBqGXP4ugW21KX/Kjc3nA0+WV
         nsz8OWd7c3rjEovlmU2fbLgX7kkzQ1fUKtryhnpX2aqUPbzM9sTyGLEvKYtc02yS/nPS
         ekBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770416198; x=1771020998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o6oxrZnXZjssrAJLKm4rt1uzzsVCsTNkRCeBxE9yMj0=;
        b=u3GqSJ3lT5ux8nblJ5B1le9dbxeHXC/ll+zPVN97gesgfBSiihbl07o9xI2l/Fqgc6
         SJpXUojYoTzGwk47DiiE7BuddHGmjJ4OHTN3kZBacOdZgh0XHRI+wpK8K2zNh97eyytG
         6M15AzIWCxFU9u6lCq9c12KHly4oNgs8SlDc1y/QXYDjlLd0BOMznXaTsbD8bAev8+V7
         f0t603zneDn542QCHS97n3SMTMf9GNxszJ6F8p5OC+Ca/TGQ8AWIrbkwFysYLp3bZ/3a
         ECikX+vHEQkpv4IO2BFKxtzfQFX0cA1U0nSQ/yHQmlxFmh+aAkvUAz2nqSi1+uPRpDqj
         zgPw==
X-Forwarded-Encrypted: i=1; AJvYcCUXAC9nl6kiCqFySCi7csb58dazZRr1KY6/0sOIMOCkJRalteXVql85zUaztP4iIWTzy66Bav2/oPQrx8ffq4xr@vger.kernel.org
X-Gm-Message-State: AOJu0YyFnbyk5zMEhZpJKlTu9UMP2+rZt+sTb01P5fvEjcqPI87v2tTm
	YXWn5YQ6MCXkFJuH9IYSN/bsaEXjJcaNeCrA69/e273mcPe2FOcAdWOz1RGsJKITP9BGRrNOxTB
	gdhCWDkbgu6eS8RKGDoM5QPbXD29Qog+VTrLodCYc
X-Gm-Gg: AZuq6aKr6MtFHmSP6KW1+4u5gA7VZHy978uPbpCtKOy8ME+43v/uTwVRV3/oEQoYDOV
	+oqRSWgMjsoip0kv5BPBR8vlu07Qto5h8aHZSKERyQ8dp+gswusSc8bKyTkqE1g++yd1WQcmOKy
	9IKZFJsufKOpy6AY/AuY6OdnGYgt8UfPpzVd5/XPCNY+XhIC3X9rAbl/O3KwWVgByKk/yvFe8JY
	vjt5DANqopGcqc4aJF3KgKX0s28XXQ2TZyN7gTdSXkQoKQymTHaoNtQvlCm2aDGhjxKdpPQ
X-Received: by 2002:a17:903:19ee:b0:2a3:ccfa:c41f with SMTP id
 d9443c01a7336-2a9630fcab5mr267545ad.1.1770416198038; Fri, 06 Feb 2026
 14:16:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205183603.459363-1-irogers@google.com> <20260205183603.459363-2-irogers@google.com>
 <20260206104543.GE3529712@e132581.arm.com> <20260206123310.GF3529712@e132581.arm.com>
 <CAP-5=fV8ofWn2oYDip3pOX7+Cx0GyKckq_o0Q6qahuoqgydN7w@mail.gmail.com> <20260206215001.GJ3529712@e132581.arm.com>
In-Reply-To: <20260206215001.GJ3529712@e132581.arm.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 6 Feb 2026 14:16:26 -0800
X-Gm-Features: AZwV_Qg0Ixi8RGtRltfX2hC16dDzvAvYr8A4-Q9qIqGJ384GmznELnPvMlOOCiI
Message-ID: <CAP-5=fXzG6QOvkUqaJABJzvLkWXx4Wgtv5rG59GtvF1tE65e-w@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf metricgroup: Don't early exit if no CPUID
 table exists
To: Leo Yan <leo.yan@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 1:50=E2=80=AFPM Leo Yan <leo.yan@arm.com> wrote:
>
> On Fri, Feb 06, 2026 at 10:57:54AM -0800, Ian Rogers wrote:
>
> [...]
>
> > > > >  bool metricgroup__has_metric_or_groups(const char *pmu, const ch=
ar *metric_or_groups)
> > > > >  {
> > > > > -   const struct pmu_metrics_table *tables[2] =3D {
> > > > > -           pmu_metrics_table__find(),
> > > > > -           pmu_metrics_table__default(),
> > > > > -   };
> > > > > +   const struct pmu_metrics_table *table =3D pmu_metrics_table__=
find();
> > > >
> > > > Here should be:
> > > >
> > > >   const struct pmu_metrics_table *table =3D pmu_metrics_table__defa=
ult();
> > >
> > > Or, I think you should not change metricgroup__has_metric_or_groups()=
.
> > > The change only in metricgroup__parse_groups() can fix my issue.
> >
> > This is wrong and the patch I tested I believe to be correct.
>
> It is very likely you are not working on the issue same as mine.
>
> > The table here is CPUID associated table and all the metric code will
>
> As you said, the key point is CPUID.  On my board, as no corresponding
> json file to support the CPU variant, it fails to find any table based
> on the CPUID and pmu_metrics_table__find() always returns NULL.
>
> The failure flow is:
>
>   add_default_events()
>     if (!metricgroup__has_metric_or_groups(pmu, default_metricgroup_names=
[i]))
>         continue;
>      ^^^
>      Always return false
>
> As a result, metricgroup__parse_groups() has no chance to be invoked
> and no any events are added to the ev list.
>
> This is why I suggested to keep default table in
> metricgroup__has_metric_or_groups(), it can rallback to find default
> table when CPUID is not supported.
>
> > bottom out in metricgroup__for_each_metric where the CPUID table is
> > the table parameter (its a parameter because of testing where we force
> > the machine/model to "testarch"):
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/util/metricgroup.c?h=3Dperf-tools-next#n430
> > ```
> > int metricgroup__for_each_metric(const struct pmu_metrics_table
> > *table, pmu_metric_iter_fn fn, void *data)
> > {
> > ...
> > const struct pmu_metrics_table *tables[2] =3D {
> >     table,
> >     pmu_metrics_table__default(),
> > };
> >
> > for (size_t i =3D 0; i < ARRAY_SIZE(tables); i++) {
> >     int ret;
> >
> >     if (!tables[i])
> >         continue;
> > ```
> > If you make the table here the default table then you will process the
> > default table twice in metricgroup__for_each_metric which will mean
> > double metric look ups, etc.
>
> In my case, it will not have double metric issue, as
> pmu_metrics_table__find() cannot find any table, a NULL table pointer
> will be passed to metricgroup__for_each_metric(), then only
> pmu_metrics_table__default() will be used.

Which is the table you want to be used to such an extent that you are
proposing changing this patch to put it twice in the tables array in
the snippet of code above. Also note that the code skips the NULL,
failed to look up table, which is why this patch just needs to avoid
the early return on a missing table to address the problem of the
default table not being considered.

> As a side question, using a single CPUID to look up metrics can be
> error-prone on asymmetric systems (such as Arm big.LITTLE).  Since only
> the first CPU ID is used to search the metrics table, could this cause
> issues for other CPU variants?

There's logic to use the PMU for the cpumask and then to get the CPUID
for the ARM CPU associated with the CPUs in the cpumask. It is likely
bitrotten, but the problem has had some work on it in the past. It is
untested, to my knowledge.

Thanks,
Ian

> Thanks,
> Leo
