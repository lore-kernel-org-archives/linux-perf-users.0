Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446DA1AAA3D;
	Fri,  3 Jan 2025 22:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735944312; cv=none; b=sqxPiSpeB4UcsLj/F6MGCjj6/e2nLdSkr4PXvKM1Ir0F4lBISn9Q2ppYXqlbHaek0Q57B3NkhF0wBkkyGodSOhENlcDIb2/H5ftkCkuOijFe5Bgjn88RnOmTKDEEiM+cgPF12H6BVva0w2mozyI6S52aCawbPYb5YBktXJbWOFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735944312; c=relaxed/simple;
	bh=Q/DaSiESjGtpFhy27n7ZlGMDfUDTC0jqUYc7sOcgvzU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Trs40ztDaIJbUDNRV5ra19ayugZo+77eRrcsGRrfx19nr6uvjPUUc4+l0LmmIlSAESeDvhJ5J70cbDu2ur3GUEEbFOn/sCP5xX9v4sJVMGRlwRQhdVUxEofzU4SQtQA5J2gQRrIOH+GWxJ4JmWQjWGckUkMEsI3Amb2OWMIaCcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsF85MXt; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsF85MXt"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385eed29d17so6030794f8f.0;
        Fri, 03 Jan 2025 14:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735944308; x=1736549108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boMl+pQfQXmWyNrT8S/sXSE44nQ4kGiKGrjt5KgwhTg=;
        b=TsF85MXtMUNfq1iEIDm3pi4c5Red6mDjmKdnd+NJ6jHyKUwPD86wvWeYorltT4FBTG
         br1HdehDXYdG232w4EgAAAuxFcWMrizjiQBrgblT/0X1knZmxqShatB5FkgD+c/bnOky
         fv5JsuJ68obh+I2my0seZ7Y/hOx6kC+oqdTpMmoRhT8WCK0RpHC7KiTZRekodrie0Do7
         lziyTHeriyv908UJ01dqc0SafsYHC3uLvlKu70njJaD+YZeoGZd1TnUfiReAbw9ZfrEg
         Nh/Lnyh+mrhnWZDAb1HfjB6KH9j3fT2f4iUdskjoRWTW27ypOvcX4xRv2Si1KakdX0Qy
         qjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735944308; x=1736549108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=boMl+pQfQXmWyNrT8S/sXSE44nQ4kGiKGrjt5KgwhTg=;
        b=r99imP7SN/LCE56gk51JphAsg06RY/OcYZYC74y3tZVxVfVoY1dqXzKMXF7E4F806F
         uzmiEd6YdQfxEdzb5/X8l8E3JXMqvcE1vuPQsvrjZuNiypUCq9ywwM5g8fvo3/ExMcWz
         t/0EzPormnkXATfJp0WgeFaaWnY/j999+7fDeJ0v4UxIxy4N0lH1PGVYEmYYEKj3KaIs
         3JR4E3SIYDuCh8TZ7DkHzToDFMmhUx+qTihghQ2sw4f1yMh/x6yg3WDYmEsWRHuLZI3t
         gQ6jOkoGBaUFg8xX0nzWejild0I3Vw2HsEEwBbEuHe/cu0hRrlGHfRuN+WLQdsbiM5ON
         qX/Q==
X-Forwarded-Encrypted: i=1; AJvYcCULWH6PKHH0b/0Jt94oWL2bUj5ibewCAF3/QL/13jl4jvCv9ZnMUdCk7W340mFI/ypE1zpBWrOt+mIFG9FCzUq1lw==@vger.kernel.org, AJvYcCXMtdWwQr+MNdiNyKMHlPD006FR+F5JhqllXTBbEhwpzfkA+z52I48MPAWyGTk+KgFOpO/iXetAD2UuFlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4bM/WWkIRi3sH0TfTADZ5KMcFt4ytoTd/N3T13io3sDk8W20g
	gA6lZ93Ncm7JgXpPXJ037+GmvDBAIXwLp+DyxbtJWOlb+9zEj2L2
X-Gm-Gg: ASbGncusYKiCmiSkcJIF/R8jnN8RiWFgHP/Knpc2D9Fvg1BeDr6Cj3D1yUA8F8ZEtOH
	ZsTJNtC0eJEnYhT2tGfl7JrgsUFs4KDLrWDoiQaYVYVvPXjMAbMAvKXK8XVNH+IjGbLdkI4XX70
	DO2lsr5fw1bcikW+3ZmrCyD7x415rQ8zcnEOGMjmyFLzLSL+GUy42/JtxGEpOJgj7rCtN6SP7ho
	9q3DsPXkKS8nMF0JEcPTrdRzQOg5zqZ+GjWdm7Atp3/cby7wtPJmBIWrYA+edkHcwQrKiknmg/F
	erWZfdi2NTbuItqAybk=
X-Google-Smtp-Source: AGHT+IHnRR/++feo4NRrs4NGA9okrxH82KblpUqEIW50prBNz1R/GTZcDSGawtloXg6ammwWdwMceg==
X-Received: by 2002:a5d:6f01:0:b0:386:3dad:8147 with SMTP id ffacd0b85a97d-38a221f9ed6mr36147508f8f.32.1735944308341;
        Fri, 03 Jan 2025 14:45:08 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436611fc762sm493424935e9.11.2025.01.03.14.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 14:45:07 -0800 (PST)
Date: Fri, 3 Jan 2025 22:45:06 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Leo Yan <leo.yan@arm.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Kan Liang
 <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, Tim Chen
 <tim.c.chen@linux.intel.com>, Yicong Yang <yangyicong@hisilicon.com>, Ravi
 Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kyle Meyer <kyle.meyer@hpe.com>
Subject: Re: [PATCH v2] perf cpumap: Reduce cpu size from int to int16_t
Message-ID: <20250103224506.185cc746@pumpkin>
In-Reply-To: <20250103182532.GB781381@e132581.arm.com>
References: <20241220185207.106161-1-irogers@google.com>
	<20250103182532.GB781381@e132581.arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 Jan 2025 18:25:32 +0000
Leo Yan <leo.yan@arm.com> wrote:

> On Fri, Dec 20, 2024 at 10:52:07AM -0800, Ian Rogers wrote:
> > 
> > Fewer than 32k logical CPUs are currently supported by perf. A cpumap
> > is indexed by an integer (see perf_cpu_map__cpu) yielding a perf_cpu
> > that wraps a 4-byte int for the logical CPU - the wrapping is done
> > deliberately to avoid confusing a logical CPU with an index into a
> > cpumap. Using a 4-byte int within the perf_cpu is larger than required
> > so this patch reduces it to the 2-byte int16_t. For a cpumap
> > containing 16 entries this will reduce the array size from 64 to 32
> > bytes. For very large servers with lots of logical CPUs the size
> > savings will be greater.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> > ---
> > v2. Rebase and tweak commit message.
> > ---
> >  tools/lib/perf/include/perf/cpumap.h |  3 ++-
> >  tools/perf/util/cpumap.c             | 13 ++++++++-----
> >  tools/perf/util/env.c                |  2 +-
> >  3 files changed, 11 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
> > index 188a667babc6..8c1ab0f9194e 100644
> > --- a/tools/lib/perf/include/perf/cpumap.h
> > +++ b/tools/lib/perf/include/perf/cpumap.h
> > @@ -4,10 +4,11 @@
> > 
> >  #include <perf/core.h>
> >  #include <stdbool.h>
> > +#include <stdint.h>
> > 
> >  /** A wrapper around a CPU to avoid confusion with the perf_cpu_map's map's indices. */
> >  struct perf_cpu {
> > -       int cpu;
> > +       int16_t cpu;
> >  };
> > 
> >  struct perf_cache {
> > diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> > index 27094211edd8..85e224d8631b 100644
> > --- a/tools/perf/util/cpumap.c
> > +++ b/tools/perf/util/cpumap.c
> > @@ -427,7 +427,7 @@ static void set_max_cpu_num(void)
> >  {
> >         const char *mnt;
> >         char path[PATH_MAX];
> > -       int ret = -1;
> > +       int max, ret = -1;
> > 
> >         /* set up default */
> >         max_cpu_num.cpu = 4096;
> > @@ -444,10 +444,12 @@ static void set_max_cpu_num(void)
> >                 goto out;
> >         }
> > 
> > -       ret = get_max_num(path, &max_cpu_num.cpu);
> > +       ret = get_max_num(path, &max);
> >         if (ret)
> >                 goto out;
> > 
> > +       max_cpu_num.cpu = max;  
> 
> I am concerned for the data conversion from int type to int16_t type.
> 
> The GCC option "-Wconversion" is not enabled in perf Makefile, unsafe
> data conversion is allowed.  A better way is to update argument type for
> get_max_num() for reading CPU number with int16_t type.

Or just avoid passing &int_var by using the return value instead.
It'll generate smaller, faster code.

	David

