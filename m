Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C010286A8;
	Wed,  4 Sep 2024 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465159; cv=none; b=rmXe7UBjhEpDU3UPVGyJO+i6AyuvbMZYOyiaEF4sNIVj45CbKocWPL7SD26VLaebSmD/x3dqaQs3nZjwBW77jpjzrLqjZxN2QahybILXTjxohvTiBSHZsQU8e/mDjotYgSSa+V9T2zQVmqEMmmzgh5Fg7dJrw+2AlijRn4VNnI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465159; c=relaxed/simple;
	bh=lUY77zhKCX1hCMrkL0mkbTJCo8TnHEqNmN62M8lSMYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EIGFIOhS/QscUMQTV5E/hceNMR6g1yNbk/Sh34CCQl+S2p/g5U3veqw8qW3+yBzO02sz5Supehu6cpQT19pN/MciR2mDqRXBStZ3nQx3H8UapHJRMyuLRX3keKniSOEzE83Scfs7wicfUruOF+iFMJZ+0hv8N3yfiUiK+osIRCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d1daa2577bso4668944a91.2;
        Wed, 04 Sep 2024 08:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725465157; x=1726069957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRpCSa2dicAy71ZoCq3WWsHgrn4GYp+rcy53dep9/Ss=;
        b=mNqx5ks8IB/S6A4LS3E0Dv/iwzUE7t3VzXDxnbSFst28b/rGqgmCLJR5VLVNKBoAvU
         wduvbBZzgXKulo/SYYv0yjGQhyrbZkeagr02VUVBO3CQ4lqxnHB+Ku8psfj78vcb7pwg
         7OY/Lj4koy5dLqWkbvyIDf7xiE48vq3YX5aj0Usf9eHx9P7jA/4Pjt7tzU+hGHZUovjT
         ZCSscXSsxLae3SYGVH+NrdyetHEA9sVsBlLn+/7ghv70ysTZfXtUYZUW7XQSQGh1Vz47
         xWYdu3frUpeVmEvWbQaKW2lL6tKconZqfwJ48wuHXV0e8KKHaFj09ulsVD8/5jZDA3T1
         L7uA==
X-Forwarded-Encrypted: i=1; AJvYcCUgJUKLYmWu0s/0Apv7UMe8Np3CYGzWqN3nYFJ1LDm//lQccblY3BfAj18RrJCfCCO3rpOZzUsJMXEa+vk=@vger.kernel.org, AJvYcCWcZy8k7qlS6rXFvecbQwPX93zokNDest4HnlOHwQ+TBmyCq7nnhVYgM9kMfmNznGIVoiUyrnUIPGVa4f555NYqTw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6NPRo4274hrYV07gmsJCcq+bZSeOLWO1gmGu8nuOasU/mrudr
	R48LMvrNlweY8q8q7D2zgPJv5WLGBD/xOeto5dnS6bt7skcpIUbWMWei7MUsvbWLXVwpW4M59WK
	i111SVzhIUWm1+/2OoP0KsZazTBM=
X-Google-Smtp-Source: AGHT+IFX3MHyKkqzSL4Emt9nWckQqcoksiFJEqtX0Xv0KCxrxnSGvAy2zifePpZa0h15Uh8crIIJBtsc6riF/sEMqVI=
X-Received: by 2002:a17:90b:c12:b0:2d3:b49f:ace3 with SMTP id
 98e67ed59e1d1-2d85638576dmr21007154a91.28.1725465157361; Wed, 04 Sep 2024
 08:52:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904064131.2377873-1-namhyung@kernel.org> <20240904064131.2377873-8-namhyung@kernel.org>
 <8c47cb2a-2bea-422d-b16c-f304ab4ff470@linaro.org> <251acd21-7d0d-451c-b581-cdb74b4096ed@linaro.org>
In-Reply-To: <251acd21-7d0d-451c-b581-cdb74b4096ed@linaro.org>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 4 Sep 2024 08:52:24 -0700
Message-ID: <CAM9d7cgAuYwh+zaEAa3v6V86=6bWgsDpN_LM75OM3JkJ=ZQvaQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] perf tools: Add fallback for exclude_guest
To: James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Mark Rutland <mark.rutland@arm.com>, James Clark <james.clark@arm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Atish Patra <atishp@atishpatra.org>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Mingwei Zhang <mizhang@google.com>, 
	Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello James,

On Wed, Sep 4, 2024 at 6:36=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
>
>
> On 04/09/2024 2:28 pm, James Clark wrote:
> >
> >
> > On 04/09/2024 7:41 am, Namhyung Kim wrote:
> >> It seems Apple M1 PMU requires exclude_guest set and returns EOPNOTSUP=
P
> >> if not.  Let's add a fallback so that it can work with default events.
> >>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: James Clark <james.clark@linaro.org>
> >> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >> ---
> >>   tools/perf/util/evsel.c | 21 +++++++++++++++++++++
> >>   1 file changed, 21 insertions(+)
> >>
> >> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> >> index 0de0a72947db3f10..8c4d70f7b2f5b880 100644
> >> --- a/tools/perf/util/evsel.c
> >> +++ b/tools/perf/util/evsel.c
> >> @@ -3400,6 +3400,27 @@ bool evsel__fallback(struct evsel *evsel,
> >> struct target *target, int err,
> >>                 "to fall back to excluding hypervisor samples",
> >> paranoid);
> >>           evsel->core.attr.exclude_hv =3D 1;
> >> +        return true;
> >> +    } else if (err =3D=3D EOPNOTSUPP && !evsel->core.attr.exclude_gue=
st &&
> >> +           !evsel->exclude_GH) {
> >> +        const char *name =3D evsel__name(evsel);
> >> +        char *new_name;
> >> +        const char *sep =3D ":";
> >> +
> >> +        /* Is there already the separator in the name. */
> >> +        if (strchr(name, '/') ||
> >> +            (strchr(name, ':') && !evsel->is_libpfm_event))
> >> +            sep =3D "";
> >> +
> >> +        if (asprintf(&new_name, "%s%su", name, sep) < 0)
> >> +            return false;
> >> +
> >> +        free(evsel->name);
> >> +        evsel->name =3D new_name;
> >> +        /* Apple M1 requires exclude_guest */
> >> +        scnprintf(msg, msgsize, "trying to fall back to excluding
> >> guest samples");
> >> +        evsel->core.attr.exclude_guest =3D 1;
> >> +
> >>           return true;
> >>       }
> >
> > Not sure if this is working, for some reason it doesn't try the
> > fallback. With exclude guest made mandatory in the Arm PMU, then:
> >
>
> Looks like you change this, but it's not obvious why the stat behavior
> is different to perf record anyway:

Right, I think we should consolidate the open code to be used by
both perf record and perf stat.  I'll reorder my patchset to have
exclude_guest fallback first.

Anyway thanks for the test and the fix.  With this, perf stat and
perf record work well on your setup?

Thanks,
Namhyung

>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 8b9889873d3e..6f2ee3032f5f 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -639,7 +639,7 @@ static enum counter_recovery
> stat_handle_error(struct evsel *counter)
>           * (behavior changed with commit b0a873e).
>           */
>          if (errno =3D=3D EINVAL || errno =3D=3D ENOSYS ||
> -           errno =3D=3D ENOENT || errno =3D=3D EOPNOTSUPP ||
> +           errno =3D=3D ENOENT ||
>              errno =3D=3D ENXIO) {
>                  if (verbose > 0)
>                          ui__warning("%s event is not supported by the
> kernel.\n",
>
>
