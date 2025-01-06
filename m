Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653041DF73B
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jan 2025 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736186504; cv=none; b=SaXTXeF7ApQlNfnY5AU0LE3JtmrJw8GkcjZckD9qD2R6sG99dTSJznjIOAwjsc6ipCNfgJWS6BeV7MJ2tnWZOn0soYJKUEYCNGGHVXWrK+0g+XTkU5DgaYynHp7qpb985XRNpHf8lDaSV+gVY5mW21/MSTdD1E7idz/zD7Ip7ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736186504; c=relaxed/simple;
	bh=VEmpKgiLFkHmcuvbkHrYltRv7LL/0uYsocAAO5N1bLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FkzCKoJm0VmBdNEDlr3IWTDSh1MH71bQB6+BizJriLC/P9QsoQ/uix3EdTFv8+dq97Iy0q6QyVvgaUrzfQB4aUlmVO1AfzDRubykkoyhUb4EaB8Pqu0z42sJLsolmdm1z4VOjXaQEUP8ZehV/7EamorQ3sN+ZUksx/PhnI79TsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y302YNDx; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y302YNDx"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso3295ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Jan 2025 10:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736186499; x=1736791299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9ExCRUKaMxVm5q21rCSDjNd/prjUMadlExNpIOMS9s=;
        b=Y302YNDxJZ2NFX+AImrJiBVsrJRgFlG8xD327ada6woTo+etD2cbG0VdAOcO8XTS4h
         YusR2tcSBjqbKcwq1v+RvGDbNUAS+vNE3tFJ+ZDKD6c+UWXJ3oh/TCrt6p6hrjK27tTy
         7bev7dwWPAjKEA85+2k31F4uhOeZw08M2H6o7Hkpu6kTLesDd/ANPaS+B3cVwixO/VV2
         BHsxPK25lIRBQFZfVxtT+9LpOHcEKAbiOPPaWh6wvVnK+qv7e0GyPsz7cYQ6GxgM4u8C
         pAFH9M6xVcT3qahqncVH+eTv0WdxuZaRgunhC7d8KvVZ1Q7tUA9Qe/5lWkESPUsVzojl
         lUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736186499; x=1736791299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9ExCRUKaMxVm5q21rCSDjNd/prjUMadlExNpIOMS9s=;
        b=A7Dc+Kp2ATd/ql+C+R5zlhMOsTecE4lC8kcW9fVuA2e1/UpvUe6IzumgmNYhG7k70K
         c1SaTbDqv2U7c/AIM2Y5kX2S6Wz7HjmSN9IqD3RtknPBnjojzetYx9SShVn1fTVcY5sz
         Ky9SDQFC/kPQXzb632//+ycsAVum3ZE7MNgApMrqyAhKjxNPhU1V/MinPOY/rpWFJNvb
         X7EWcxnt4MhL/E5m8aBoU043L4O5HWno9aTe9dxPyrLMMGrqVIp3EX/XvOCREwm3A3fd
         TxuXTI7MQ/MpJ4dEGInR8YkLIrM0RN00kwVOnvX/fHSLBSH12GIdnktTIen4zsJF5w+H
         38tw==
X-Forwarded-Encrypted: i=1; AJvYcCXi5eDAElf21GZSXvmMr1RCHNtsWZ/5aj1bG87Fmnc4la8NNAFOln+g3dniqFN+ptVJPa01klBtHImLNaR45KQv@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5ZqWDHoIt8nbKf2g4Tiy0NQbIHQBm8gsV/K3m0WtQXId8J5Ba
	AbpamCg+Tyee7UU4EfGpvITY0FKGnhgoQBKdmwX6g8PUMtDq7A2dyaP1vYetUIT+SSu/V2UISgz
	t1lIVI7wy3DmYhOrfoSPcg3Jdt68HfQ07dYvd
X-Gm-Gg: ASbGncsYQX6q+lvpfI8tWLq6i/+KO2mJ9kikqkqWlepz5GPXdzhDE5R+d4Cp3lmMNXx
	GXKnyvHHfYMbLyahOSNYv0r2K8YRJbQos/gSW5eLsGTrvWhFgwGRbln7Cad71HagET81J
X-Google-Smtp-Source: AGHT+IGeia4Wmr7kMezB274EXk1rZJDxEdI35O1eghK8xWpY26UmgWQ4UqOiTmY6WhdA2lFAMP4gDlm6Y4PxMvnECq4=
X-Received: by 2002:a05:6e02:1a89:b0:3a7:6126:ca3 with SMTP id
 e9e14a558f8ab-3cddc015a81mr6204955ab.24.1736186499209; Mon, 06 Jan 2025
 10:01:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241220185207.106161-1-irogers@google.com> <20250103182532.GB781381@e132581.arm.com>
 <20250103224506.185cc746@pumpkin>
In-Reply-To: <20250103224506.185cc746@pumpkin>
From: Ian Rogers <irogers@google.com>
Date: Mon, 6 Jan 2025 10:01:27 -0800
Message-ID: <CAP-5=fUFhRYMp6kaRYS5oHfRjsLrw9PEN4qks6PnESU63n63jA@mail.gmail.com>
Subject: Re: [PATCH v2] perf cpumap: Reduce cpu size from int to int16_t
To: David Laight <david.laight.linux@gmail.com>, Leo Yan <leo.yan@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kyle Meyer <kyle.meyer@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 2:45=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Fri, 3 Jan 2025 18:25:32 +0000
> Leo Yan <leo.yan@arm.com> wrote:
>
> > On Fri, Dec 20, 2024 at 10:52:07AM -0800, Ian Rogers wrote:
> > >
> > > Fewer than 32k logical CPUs are currently supported by perf. A cpumap
> > > is indexed by an integer (see perf_cpu_map__cpu) yielding a perf_cpu
> > > that wraps a 4-byte int for the logical CPU - the wrapping is done
> > > deliberately to avoid confusing a logical CPU with an index into a
> > > cpumap. Using a 4-byte int within the perf_cpu is larger than require=
d
> > > so this patch reduces it to the 2-byte int16_t. For a cpumap
> > > containing 16 entries this will reduce the array size from 64 to 32
> > > bytes. For very large servers with lots of logical CPUs the size
> > > savings will be greater.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> > > ---
> > > v2. Rebase and tweak commit message.
> > > ---
> > >  tools/lib/perf/include/perf/cpumap.h |  3 ++-
> > >  tools/perf/util/cpumap.c             | 13 ++++++++-----
> > >  tools/perf/util/env.c                |  2 +-
> > >  3 files changed, 11 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/in=
clude/perf/cpumap.h
> > > index 188a667babc6..8c1ab0f9194e 100644
> > > --- a/tools/lib/perf/include/perf/cpumap.h
> > > +++ b/tools/lib/perf/include/perf/cpumap.h
> > > @@ -4,10 +4,11 @@
> > >
> > >  #include <perf/core.h>
> > >  #include <stdbool.h>
> > > +#include <stdint.h>
> > >
> > >  /** A wrapper around a CPU to avoid confusion with the perf_cpu_map'=
s map's indices. */
> > >  struct perf_cpu {
> > > -       int cpu;
> > > +       int16_t cpu;
> > >  };
> > >
> > >  struct perf_cache {
> > > diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> > > index 27094211edd8..85e224d8631b 100644
> > > --- a/tools/perf/util/cpumap.c
> > > +++ b/tools/perf/util/cpumap.c
> > > @@ -427,7 +427,7 @@ static void set_max_cpu_num(void)
> > >  {
> > >         const char *mnt;
> > >         char path[PATH_MAX];
> > > -       int ret =3D -1;
> > > +       int max, ret =3D -1;
> > >
> > >         /* set up default */
> > >         max_cpu_num.cpu =3D 4096;
> > > @@ -444,10 +444,12 @@ static void set_max_cpu_num(void)
> > >                 goto out;
> > >         }
> > >
> > > -       ret =3D get_max_num(path, &max_cpu_num.cpu);
> > > +       ret =3D get_max_num(path, &max);
> > >         if (ret)
> > >                 goto out;
> > >
> > > +       max_cpu_num.cpu =3D max;
> >
> > I am concerned for the data conversion from int type to int16_t type.
> >
> > The GCC option "-Wconversion" is not enabled in perf Makefile, unsafe
> > data conversion is allowed.  A better way is to update argument type fo=
r
> > get_max_num() for reading CPU number with int16_t type.
>
> Or just avoid passing &int_var by using the return value instead.
> It'll generate smaller, faster code.

Thanks Leo and David. Changing the argument to get_max_num isn't
possible as the function is used by set_max_node_num and the %d
modifier would need to be different for each, etc. Changing the return
type would have implications as the function uses the int encoding
either 0 as success or a negative value encoding -errno, so there's
the potential for collision between read values from the path and
error numbers. Performance isn't hugely critical here too. I'll send
out a v3 to add a bound check to the int to int16_t assignment, which
hopefully addresses Leo's Wconversion worry.

Thanks,
Ian
