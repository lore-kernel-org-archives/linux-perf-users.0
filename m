Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EC91A83FC
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 19:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736450757; cv=none; b=mx+1Lb5aUXHa+M0GnGbuifNTDkzKLX/DRrSXDmFcpY+Uj1M2hrupiuOHyeqoZ6BWFhjgXUMOCXDRoHYT+E+cbqlGz1FGyKPmygHTpjanIDh6xwn8xJErvZNI1d4O8M8bOkpsG2Nne6RWZf2hL1oIrTdYSMDJySI6fiMAP49kjbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736450757; c=relaxed/simple;
	bh=8y8rPj1HPXQJlGxk2iuEatNE4+rzLguUtzYmbUEtiIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cdylefKmqm2ngXuUFN8j+VGmLSMkoirugVFM8gUJeTeG2rZ1IgOfSEcRSNfkTxbEuIYcogqcpXiXBwOAL5fty6CcTU+YszJo0FjPaGsArl3Y7mSDUORA8yKt+oy2wtquMldWRf567Mbyc8utZ2Dw7C41qOm7su+XnK4ZfX6FtnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v2GrDf+5; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v2GrDf+5"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso13325ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jan 2025 11:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736450755; x=1737055555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o97cphqMRuA0N5pUtABtgtXAHKHyrvUg0DRTlLTMtFY=;
        b=v2GrDf+5hylxBL1WHUODK9cwzwMArOmr+4EG321eTKBBW0Y2KvKe2XpSHC5bM4pYmR
         dx3Hoje6YoRIhFNakHjSBVPtQYlfcYMtOxN/ZYbOyL06IloA2jNUxQMc6R2Zx0ojp02P
         MWuPAmecM61AK3NlzAKChzKzB3+UwqsTfrEynhTkdVDP6jArWRs5UH1SrCZP7Av6/bhh
         MswkZeVsaN+ku1noQ3VUZOc6XEQDT8xoj3ELCN8SeyUOtOaccm1If8ptGSigyAhEx2h6
         ta+Hp0MXb88jJTc5mPn0delZJ07LTSaV418R4VTVv+FWgGnZwnULCGYLR2/CJEhfhWgk
         498Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736450755; x=1737055555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o97cphqMRuA0N5pUtABtgtXAHKHyrvUg0DRTlLTMtFY=;
        b=aidakqTxbzdU+jO02pNtMP1qIWsw/R/P1xYuaTBpJXnLZ3mYjRer9/aS+6Ty/5+TIG
         yxDrSs1PGfUOHr+OBijhSKrq6gFGrxsRBvGYwO9VKthFUDQ9kI41h0ue1Am+yisoJwRj
         jbVKxKi7x3UOC5k4bAQb9WKrk6h27yHN3H11kpcN0es8IkpdB7SsX20J9YHnrpzIdhSS
         2A/zSyZHrzCyMl07Z79GONHDmd2EvoPWaBMAH9kZK9DHevzCEue82xqlq1ZATywFrl7q
         JT4DQ9/JaEYvu0Uv55p47l6TP94mqP+jC4Y27XcueyGLVZhK817HMG3oH+Kcw8nslCZP
         vf2w==
X-Forwarded-Encrypted: i=1; AJvYcCXVYggm6GD4hf1CpZ5gwFbhyL1DC69vCmnQ2pH85Yl8lCyQNUTDMQmyiyuzsRqtye83CobrMtheC7SanK1lI456@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7XROtJcXemg7oIHxenUio6XZd5S6jIe3Ol5VPzFdzS7GPJ2d4
	KYrVUDOXy5ZmIzwcfNkJ54EGXihKBEv2a5iLDT9F9mlLUlT4Xp0vHBgWWJnWFgxnxdJChCxlZT0
	pXti/zG7vTk89CjHC1qrt9bg81okTlP89K9Tq0olm0eu5v6OIjwKy
X-Gm-Gg: ASbGnctcMLwylUnYTzye0mdAQoF4kuyuBqA5NDtTyCYo51Y0bBFN2wrU1MOEk/6A5hk
	vT1l80Au0apO3dbDMW3FQ8l32IZqtCEBBvtIHRmA8MSitnomABnuHLRk75D1s+QTrZctkOg==
X-Google-Smtp-Source: AGHT+IFWMzYn03wR28jz0rEWW3WMqjbJoAY+XPuG729q8xQo6OT4RPJMn6AETQNIN8zLwXoNL3IqUPQJEscJwP+nSDI=
X-Received: by 2002:a92:c563:0:b0:3a7:9082:50f6 with SMTP id
 e9e14a558f8ab-3ce56ddc0f1mr219365ab.22.1736450754756; Thu, 09 Jan 2025
 11:25:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108053428.1724490-1-irogers@google.com> <20250108053428.1724490-3-irogers@google.com>
 <Z37Vzk_-x-nE34fL@google.com>
In-Reply-To: <Z37Vzk_-x-nE34fL@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 9 Jan 2025 11:25:43 -0800
X-Gm-Features: AbW1kvZtECNkd8R0t2rOeRr2cNm5J_Gm84ooQIXlEdKsmbdDgJK0BMXM2iSvx8Q
Message-ID: <CAP-5=fWuusi=H5w80b1VstAOz_yEAyVe+pSMGcuRoV_kTxuwOQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] perf stat: Use counter cpumask to skip zero values
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Leo Yan <leo.yan@arm.com>, Yoshihiro Furudera <fj5100bi@fujitsu.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 11:45=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Jan 07, 2025 at 09:34:26PM -0800, Ian Rogers wrote:
> > When a counter is 0 it may or may not be skipped. For uncore counters
> > it is common they are only valid on 1 logical CPU and all other CPUs
> > should be skipped. The PMU's cpumask was used for the skip
> > calculation, but that cpumask may not reflect user overrides.
>
> It's not clear to me how uncore PMU works with CPU overrides.
> I thought it's ignored and the kernel changed the CPU internally
> using the cpumask.  But it may be transparent to userspace and
> we can think it works as what we expect.
>
> Anyway, the commit dd15480a3d67b9cf ("perf stat: Hide invalid uncore
> event output for aggr mode") added the code and the concern was like
>
>   $ sudo ./perf stat -a --per-core -e power/energy-pkg/ sleep 1
>
> So it should be fine as long as the output remains the same.

Confirmed the output remains the same:
```
$ perf stat -a --per-core -e energy-pkg sleep 1

 Performance counter stats for 'system wide':

S0-D0-C0              1              22.94 Joules energy-pkg

       1.000934566 seconds time elapsed
```

> > Similarly a counter on a core PMU may explicitly not
> > request a CPU be gathered. If the counter on this CPU's value is 0
> > then the counter should be skipped as it wasn't requested. Switch from
> > using the PMU cpumask to that associated with the evsel to support
> > these cases.
>
> Do you mean hybrid PMUs?  I guess they won't open events on not
> supported/requested CPUs in the first place, right?

Right. The notion of uncore on a PMU is not the opposite of the notion
of core, it's all a bit of a muddle because of the kernel PMU drivers.
The previous code always shows 0 when `!pmu->is_uncore` and is_uncore
is set when a PMU has a `/sys/devices/<pmu name>/cpumask` file - core
PMUs should either have no cpumask or a cpus file instead. In general
the evsel cpumask should match the PMU cpumask. The change here is
that we will use the cpumask regardless of the PMU having or not
having the `/sys/devices/<pmu name>/cpumask` file, where not having
the file may reflect hybrid, a single core PMU, a PMU driver bug,
different core PMUs like AMD IBS and ARM SPE, etc. The output change
from this could be that a 0 on a `!pmu->is_uncore` PMU was previously
shown but now it is not. For that to happen the aggregation would need
to skip that CPU and as you say that shouldn't happen.

Thanks,
Ian
