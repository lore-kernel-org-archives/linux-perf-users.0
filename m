Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B219750276
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Feb 2026 00:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770423279; cv=pass; b=Klydtqtv45bTgLHP/lt53cG7Qbm6eprrkFLbCHsIxs7hRUv4TcRA/ToOpSy12tRaMXtS7Kmtr59wScxGAeG6NJUYH3YKjfIdSRiXmUbJSFDveIGg1S0T8KgaSZi0s651+VOSog8o7ehwQfb3cEUZBUWQxIqYvm6eEEwKnGBJp8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770423279; c=relaxed/simple;
	bh=sOjsfUu2VxYLtf+ZaJPcz2duz4QVZIAfNNSNOSlZoOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/40DEzLZpojh4duQksp2yV+aND2729nKZZw4nD5DmsYLP4tCM78iAar9pubE/iKJZc7CDZcypOWgy+UxH6R9gUyZUFG+1hSKw0Ppa5sSehARcWIPXJhtMKgqVW7FAVFYN06sLaxvnoHbxWkWbqr2Xoar3mLGo9OjH6frCWCLMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2tVsWTQo; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2tVsWTQo"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a8e4ae61a0so14575ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Feb 2026 16:14:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770423279; cv=none;
        d=google.com; s=arc-20240605;
        b=GXOkqyMuMNmGvxz3MWmuEKkbjAZ44tCmdYsvX9EtlnFrAJ52Ldw8sgEk/qWF+eJa9e
         ZluCaDotdXrixzbX776jfWNzgBcLFwJ9kEGBZRaspQdckhKa7EsAHjwvljkGMwuZCXMv
         xPW00nnbA7EvZgVwjay9e3DsVGpXF2253RNBD1++zoojuttChgLNOfkPPgDeBr2qWxxI
         +C3sGVwXGUPQLlajJUII6IdAksDkOY6SsOgXBV1ySeL/nhYOoEX7k0TOppmD9vnfNgaF
         0cBs+5AbHenQ7ectQ6cEFHBIRStiBF56lidFoCGH23P9kz248eSFmRFi/M8rEKHB2Hpq
         XsDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yRiFXf2aJURlXcmBPuQB87PEnL8EarqVHFAj2zc9i8Y=;
        fh=v6hhoews3hXm4ThW/zQWf2EGh2LxlQSx40QH26nT/C0=;
        b=MrpqxNUEX5a5GA36Zw/66Cb75ztfPKTg7woyTpqyDZ8u7wwPtjoip8PVmjUJ4I2fe2
         FrAXtr1XDyG1AA+cKshoiO/WY5F9JMOhUD9RPvB4kPTOfqgDh7T3COZ38bgNWyU0JMxs
         5tE2EVHYysYVfE++X2SPzUjI4SSR6xDvNaqMllLQwweLv9Dgk+Yw8QLvxPRkcXVBYyHV
         F5pWm3Rqc8CaY/xdpvHTZmM1xmgcWKPofTNtWU/24nMFBPCxRe1lg5Ouc6fnOL74L+m7
         nZZBaGD/0cuc80nMv1nGTk+IxJpii9kfru1TAzsphtTPWXYU/U18t+IC9aQIWpgdxmzX
         XW7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770423279; x=1771028079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRiFXf2aJURlXcmBPuQB87PEnL8EarqVHFAj2zc9i8Y=;
        b=2tVsWTQoXcmsl5Uj8dVksGRToL5PhIIyzgl6fcDYnGHWjNx9zW59m7kQXgDk5qtA9x
         SCJ22wi6u/VAXg8fNaHqTlvSB2xud8JOlAoaM1PB6gNJQBcN6Nj4VbGW2R+fTkG8JQHO
         NihS5FM9CBexm/2NXLzN9u++CKW3K1hPrkyCJW6XTkJOVa7SMB4awz9N0vbEbkUFAK8A
         5uQgFfxwfdSzSeJ+s9gzW1bSaa+guqIw4jqM4fcBzNWsjRtmMirzuwYng3WHI3iD/Bf6
         M3crwoM68bcADWGtRx6jkovALR5W0Sk/jwQPqlMBX1ofpQqFBbKgCfunz6XYthSKK3kk
         /Bgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770423279; x=1771028079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yRiFXf2aJURlXcmBPuQB87PEnL8EarqVHFAj2zc9i8Y=;
        b=hHGMX/jouIlwU3eRgjCpr6yuqckCqks7nB8SAG4f8Ut4udLGV3gayzmEEB7XwsrNnS
         151Zt8B+8PMGFd98rUJUPpz8oYH8UhnxUsz28rhi+/tBMtMkcN/RLux6zAFGdsVUBvLG
         ztR9O0f0Yw8cdJafBCZVfJ2KjnlJ12FtV386bWHkj3TLi44dwBtTFmhchldOots0/a8v
         0wxwY7LNbl9T5bovNXC0yxd04jabXiexQZFjd3+LpwMMozDEDl6V4deC/VNO5JB7iC5l
         +rUEXvzOuNqOneFs5KmJ3EBbHqeP3azm94Jew6K6Umbd8cNyYAUPZw9NE0oRznZa0gJP
         6+hg==
X-Forwarded-Encrypted: i=1; AJvYcCXMMyST1c75IlLPtugt9o8v+p0ZkZ1HYIDcvCXM1RFBsAkkFJbf2Rcn0qROUdiP1c7mgMwmHOWgxlk2Ltv41TU4@vger.kernel.org
X-Gm-Message-State: AOJu0Yzniy8/GPp3MxykD9qRt7Lu4pVmSSk3BAp9QO5ZMdJeQzKxDkI2
	AOi8qFLIbrsumGUYbqQrRDqb9LadaERrtJLDC5R6w6RyZhFbRod4UjkeFopgVY+qDF40Qhr1bh3
	pUEhJdeBPro2iJ+1kXpTkHitahCMnpZdXn+brbTux
X-Gm-Gg: AZuq6aKNTqz98RCmrVh2zRhv6034AnAnoY0/CU7s3Da+J0I+AFWyF6CaTUSsXNsloMG
	SwmqB3n8oD5dcqUonwqtNHoC/ydclQNXZIgx75FBz73SiQnvY4JjgMLY4xW0OguX+DdOOlmBujT
	BHsxrrqBXLJiT4zW2U/Q5r0J1stt2miNfWA5VTmOl3GnACJAontgBAQbvesXtT+kRPc+t/OvaKp
	VHkv0Y+l+jw2qWTFZzFBohMzIAspeMuL4qJGvncJWiZoJZPt00Rix1F4O7KrKtmtTgP73JmFS2j
	SyO933al
X-Received: by 2002:a17:903:1a0b:b0:2a0:7fac:c031 with SMTP id
 d9443c01a7336-2a961ec790cmr1169725ad.14.1770423278739; Fri, 06 Feb 2026
 16:14:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205183603.459363-1-irogers@google.com> <20260205183603.459363-2-irogers@google.com>
 <20260206104543.GE3529712@e132581.arm.com> <20260206123310.GF3529712@e132581.arm.com>
 <CAP-5=fV8ofWn2oYDip3pOX7+Cx0GyKckq_o0Q6qahuoqgydN7w@mail.gmail.com>
 <20260206215001.GJ3529712@e132581.arm.com> <CAP-5=fXzG6QOvkUqaJABJzvLkWXx4Wgtv5rG59GtvF1tE65e-w@mail.gmail.com>
In-Reply-To: <CAP-5=fXzG6QOvkUqaJABJzvLkWXx4Wgtv5rG59GtvF1tE65e-w@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 6 Feb 2026 16:14:27 -0800
X-Gm-Features: AZwV_QjPUDKbrECGVyk7PkXcY0e1hAkucGXPj8K2GtsLKxa58ldGhOqFqdgw5bs
Message-ID: <CAP-5=fXPsOuqr+4DZmscoWGr1VHHJci4jRGxbOtJyy_Mp9Oa9w@mail.gmail.com>
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

On Fri, Feb 6, 2026 at 2:16=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Fri, Feb 6, 2026 at 1:50=E2=80=AFPM Leo Yan <leo.yan@arm.com> wrote:
> >
> > On Fri, Feb 06, 2026 at 10:57:54AM -0800, Ian Rogers wrote:
> >
> > [...]
> >
> > > > > >  bool metricgroup__has_metric_or_groups(const char *pmu, const =
char *metric_or_groups)
> > > > > >  {
> > > > > > -   const struct pmu_metrics_table *tables[2] =3D {
> > > > > > -           pmu_metrics_table__find(),
> > > > > > -           pmu_metrics_table__default(),
> > > > > > -   };
> > > > > > +   const struct pmu_metrics_table *table =3D pmu_metrics_table=
__find();
> > > > >
> > > > > Here should be:
> > > > >
> > > > >   const struct pmu_metrics_table *table =3D pmu_metrics_table__de=
fault();
> > > >
> > > > Or, I think you should not change metricgroup__has_metric_or_groups=
().
> > > > The change only in metricgroup__parse_groups() can fix my issue.
> > >
> > > This is wrong and the patch I tested I believe to be correct.
> >
> > It is very likely you are not working on the issue same as mine.
> >
> > > The table here is CPUID associated table and all the metric code will
> >
> > As you said, the key point is CPUID.  On my board, as no corresponding
> > json file to support the CPU variant, it fails to find any table based
> > on the CPUID and pmu_metrics_table__find() always returns NULL.
> >
> > The failure flow is:
> >
> >   add_default_events()
> >     if (!metricgroup__has_metric_or_groups(pmu, default_metricgroup_nam=
es[i]))
> >         continue;
> >      ^^^
> >      Always return false
> >
> > As a result, metricgroup__parse_groups() has no chance to be invoked
> > and no any events are added to the ev list.
> >
> > This is why I suggested to keep default table in
> > metricgroup__has_metric_or_groups(), it can rallback to find default
> > table when CPUID is not supported.
> >
> > > bottom out in metricgroup__for_each_metric where the CPUID table is
> > > the table parameter (its a parameter because of testing where we forc=
e
> > > the machine/model to "testarch"):
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-n=
ext.git/tree/tools/perf/util/metricgroup.c?h=3Dperf-tools-next#n430
> > > ```
> > > int metricgroup__for_each_metric(const struct pmu_metrics_table
> > > *table, pmu_metric_iter_fn fn, void *data)
> > > {
> > > ...
> > > const struct pmu_metrics_table *tables[2] =3D {
> > >     table,
> > >     pmu_metrics_table__default(),
> > > };
> > >
> > > for (size_t i =3D 0; i < ARRAY_SIZE(tables); i++) {
> > >     int ret;
> > >
> > >     if (!tables[i])
> > >         continue;
> > > ```
> > > If you make the table here the default table then you will process th=
e
> > > default table twice in metricgroup__for_each_metric which will mean
> > > double metric look ups, etc.
> >
> > In my case, it will not have double metric issue, as
> > pmu_metrics_table__find() cannot find any table, a NULL table pointer
> > will be passed to metricgroup__for_each_metric(), then only
> > pmu_metrics_table__default() will be used.
>
> Which is the table you want to be used to such an extent that you are
> proposing changing this patch to put it twice in the tables array in
> the snippet of code above. Also note that the code skips the NULL,
> failed to look up table, which is why this patch just needs to avoid
> the early return on a missing table to address the problem of the
> default table not being considered.
>
> > As a side question, using a single CPUID to look up metrics can be
> > error-prone on asymmetric systems (such as Arm big.LITTLE).  Since only
> > the first CPU ID is used to search the metrics table, could this cause
> > issues for other CPU variants?
>
> There's logic to use the PMU for the cpumask and then to get the CPUID
> for the ARM CPU associated with the CPUs in the cpumask. It is likely
> bitrotten, but the problem has had some work on it in the past. It is
> untested, to my knowledge.

Ah, the issue is that metricgroup__has_metric_or_groups is using
pmu_metrics_table__for_each_metric and not
metricgroup__for_each_metric:
 ```
-       return pmu_metrics_table__for_each_metric(table,
-
metricgroup__has_metric_or_groups_callback,
-                                                 &data)
+       return metricgroup__for_each_metric(table,
+
metricgroup__has_metric_or_groups_callback,
+
```
I'll send this out.

Thanks,
Ian

> Thanks,
> Ian
>
> > Thanks,
> > Leo
