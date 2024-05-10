Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75363CA6F
	for <linux-perf-users@vger.kernel.org>; Fri, 10 May 2024 06:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715321815; cv=none; b=IwIeHXvf37MnXbdpe3h6CuNKowx+4VN7kl3kfAtrrqFtpzzJZ1DYvdijsKcSKH91M8Nna/OBaDk5oF039OUzWd6JW64Zlnjx+pp9GUzddle4h7b7eHEYBy+2uiFX3Q14Ttm3JCG0eR/ISh5XArQhCEmLcOJEqvKJg/3pXQ6UyfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715321815; c=relaxed/simple;
	bh=6feafTWRKD/pFfv6a7aXeKx22UNSWKArlBNWuqJ7QgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bbb0V7bEEW1q+Qd8E1ddvbcB4BZsCerJe1t5nuqzUmeCskXSp0O1BQfCTgoTzCWIMQUeAfAKm53bhSoVQ4WjBCxo5ZSNbpb73xl547ECEY9NsJEekX6FqM02Gtao+RnnojTVIi/nPuG0gBwADTt3VcK2SOql3dDT3mfJjDwN1Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4ZQ91omp; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4ZQ91omp"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-43df9ac3ebcso193961cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 09 May 2024 23:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715321812; x=1715926612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P013eBlgxlZ/UL/3+JN87mWVkNfsmaCM+AjZob2UWLs=;
        b=4ZQ91ompuwz0icugSg63hINIrh511TEMRTYeqxW/IVdOhuLI7HrgVTs0QH+Egx23qS
         v8d8up62e+FgUEtqBR3Ex17p1Q53CnB9RE+mEbCrQegUfgMaeVxs/KRv4kiJALiyU6rT
         Ss2UqUwet5nmTSCDk2M2oz3ootlGgZcjRtULAlzo0XcAQqfwb1JcJc5iAmIh9IQBkRKi
         D/9YoIbs38SwyNEIE0vrdPyIXHt0NNfzw/t2hlbkAxQsKPSTbz100HY5FfcKRF3mwGI6
         JbfudLTqFdroJ+QXdVbhDQeQxf+kFgGnL4MuTPrrdBQd33uI2N7iY3ain/kvnnl2BWbG
         RDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715321812; x=1715926612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P013eBlgxlZ/UL/3+JN87mWVkNfsmaCM+AjZob2UWLs=;
        b=nhOqJUVR2VbCK+Rrt3RVNfxD24UnluJNkVnc9epl8tmob0V56jf3L3w+8FKrWJZY0Y
         0DnyyvujENZV3MjpTJIRC8KmDYWE9dudXAxjxwPf8jnWq8z9mOsNfJTzMinlPtrML69Y
         8pH9Ns2qUvRx/3aNH+l43v5NNZdMOdcKNt34x1iY0a9sn5ZJ9qNtO9KA4ZaziRbod/WA
         xYR2OHVE3389h1uVC/LOiif7WDbFVHg0lT69PKp0iyQpmW1tnGR/NMLpa9wiJOAQtLSG
         KqYqh26Fo3rm1Y/I2Kpso+G4mmooPH1WbgEl7GRsGUGCo/U/iMlYkLjiwIY5NK6iBowx
         VQEw==
X-Forwarded-Encrypted: i=1; AJvYcCVBeOFEQIehHp0NWF7n4YQ8i29e1j3w+ydFRm1GQqaDx2pipw2QF6dwoTy0l/wjEuYFQqWdmoJOc6DtBN6k01za0UNdldrGkomMre13v9rY4g==
X-Gm-Message-State: AOJu0Yycj/wW5M9rOBeRyY0/cRVIENeDO0uYr7NMh7eHpwZ+Rut67rzL
	OyGtsDXBLyUAHaWTSIkcT3/V7hzCG8u8oN3C6ErzepRfnNf1oygdccc1WzRro/x943VVfk8TQOg
	h2u+IyB7sVFFGwb52Jc5A0sIVRYz4BfYn+sEb
X-Google-Smtp-Source: AGHT+IFj8uz5shdiGB57AmNqO93sQ2qQyODvVTabB80D4SoJl0+JOBpTmDZ919M9UNY8Ync9DaLF5pxcLW3G9qyMVeo=
X-Received: by 2002:a05:622a:5292:b0:43a:bcee:eaa2 with SMTP id
 d75a77b69052e-43dfdce7f5dmr1976371cf.20.1715321812281; Thu, 09 May 2024
 23:16:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510024729.1075732-1-justin.he@arm.com> <20240510024729.1075732-3-justin.he@arm.com>
In-Reply-To: <20240510024729.1075732-3-justin.he@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 9 May 2024 23:16:40 -0700
Message-ID: <CAP-5=fVGD-pK1igABj0wiq6-KVM+Z4i7rnRhM=Vy7bFHW4pLQA@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf pmu: Fix num_events calculation
To: Jia He <justin.he@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 7:47=E2=80=AFPM Jia He <justin.he@arm.com> wrote:
>
> When pe is NULL in the function perf_pmu__new_alias(), the total number
> of events is added to loaded_json_aliases. However, if pmu->events_table
> is NULL and cpu_aliases_added is false, the calculation for the events
> number in perf_pmu__num_events() is incorrect.
>
> Then cause the error report after "perf list":
> Unexpected event smmuv3_pmcg_3f062/smmuv3_pmcg_3f062/transaction//
>
> Fix it by adding loaded_json_aliases in the calculation under the
> mentioned conditions.
>
> Test it also with "perf bench internals pmu-scan" and there is no
> regression.
>
> Fixes: e6ff1eed3584 ("perf pmu: Lazily add JSON events")
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>  tools/perf/util/pmu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index a1eef7b2e389..a53224e2ce7e 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1639,6 +1639,8 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
>                  nr +=3D pmu->loaded_json_aliases;
>         else if (pmu->events_table)
>                 nr +=3D pmu_events_table__num_events(pmu->events_table, p=
mu) - pmu->loaded_json_aliases;
> +       else
> +               nr +=3D pmu->loaded_json_aliases;

Thanks for working on this! The "struct pmu_event *pe" in new_alias is
an entry from the json data, and "pmu->events_table" should NULL if
there is no json data. I believe the code is assuming that these lines
aren't necessary as it shouldn't be possible to load json data if the
json events table doesn't exist for the PMU - if there is no json data
then loaded_json_aliases should be 0 and no addition is necessary. I'm
wondering why this case isn't true for you.

Thanks,
Ian

>
>         return pmu->selectable ? nr + 1 : nr;
>  }
> --
> 2.34.1
>
