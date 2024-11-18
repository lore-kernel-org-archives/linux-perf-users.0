Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC99D153BE4;
	Mon, 18 Nov 2024 23:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731971035; cv=none; b=YOfPfEAyxPCKbhulxR/O7dT910ZYMqowaqIIoJohEZCkDRa1B4/ATFM47YWD9orDJvPlGTxEJ6/iV4rQcxcDSG+5Tp2ClWLEitu2HTZO+Ha8nr3S9Gql9//O9P9eTmTqgSJbMt+vqmmV5IiwRC6gDQFryE2Ei+O6p5CAZU0QrsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731971035; c=relaxed/simple;
	bh=y5eJvZEKw6c/vP8EEPZ+YKx54VlZZ2cyAkOZGSc85ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXtqf6ktFxlSNSd6PPWhWJhvac4gmHXL6hCokzJ0TKutOEQcIDkOrO6ovLF8onUUpQCnux3w5vH/ioIVFuzuG+B+JdmRDm8nwgW16KbzWm9UJ3PLQOcaIWCAOUD1GLTMLjlll26i3bj7wSfdkSeW9hxUqTPnJdlVapO2ZvYNjAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlbRViDy; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlbRViDy"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e9f8dec3daso3442747b3.0;
        Mon, 18 Nov 2024 15:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731971033; x=1732575833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLGOlEVr1tSmo5mAOsdbIqpFPwvL8S5zsKZlb2YOAjE=;
        b=VlbRViDybb1ipThoDkUhyCPFFY0v4n2SaA+sKKE8nson9LsrAWX9tlk/vlflseaL6V
         LI8PH+7rlR28hKhvFAxGSJtkElDR/q9kjIDcNVg9mVMh5ThmuWRxuIQgLqHqW/fsWAVu
         LCP7TzS9Ky3xrN9rr4lYwXLCV1KDyb+RyuwblxhqynV/8DZhzeYd6dncM6MlRWMC7d3F
         2vhVD+oFSCLJ5pX64z8K9GcKqqYMZS3wIl7YrPwQvs4K/jimDB6u+aTgM0OskzpvsFzs
         uY91WPTjFFocYaPSrmQOX/FEJtOopCqNJ40NeqUgxwtRwQs+GCyVBpr/2k4KAgYb+adX
         lvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731971033; x=1732575833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLGOlEVr1tSmo5mAOsdbIqpFPwvL8S5zsKZlb2YOAjE=;
        b=af914IEclIUa7dboKviVWCO1NrWG+87K/sW2KRBPw+Rw4FldwrHHkG7A2q8MyGweKS
         f7e5s0kvh4D/m33fAxWu8YCTrXVC11oQ40a2RoL5g0ZNnJ2fc6DGMR2jXCk8tTdnvuZj
         yPz7ZsMsfaKRQ0JCjMo4p/oB6exdRcAw34BEcSwd0YjC2YeRk3OsnmZsS0StvuViXn+b
         7gtdlANTGY0tSVsEF4Qft7Vgl9V/gHOUG1P6Gd8TUOchfK2+TUBzxU0WAjHkEJEIj8Mt
         Joihn8hsMREg0G8vVVrFVw5I0S5U/VLraNy2q64doFz3CAXuMjZNuwayUNudpeRpNq3j
         avOg==
X-Forwarded-Encrypted: i=1; AJvYcCVk3yk6bMM6HKzqSlpf5O1MCMbyYtJKD1hoMMiSw5LqX7uqRM3Wc99iG2wijQIS+PYSntSnV5/fyRYr7TecEzeixw==@vger.kernel.org, AJvYcCW+fL9bKhI72YDfLbgoOfWxE0/MYnShdIy3lfcK2V1HKiq1V7s0pDbEop8uebPlQJCs5bpfxX7Yuz/UI5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNhPblQeSx+X2/lPyp7sxdgMYEBycnsbUE/SEwamQFAzVbe7HC
	sKnrJkoe8eDKm5nEJsl4wn8zSahvi8yoTOCs3KzwTBR7uRh3J+H/QRmkJSGkb33iX40sacZJGLH
	cZrGcoOkQCFbt5T9oJnD1BviJEvQEiR/0
X-Google-Smtp-Source: AGHT+IHKoqBVmNRIWiniQcXlArtto7smxYj78UZGvMfwkUBqetj7kPVtOb/o3T5992XSQF0rv9XkQAjmm4QjQMOBL9w=
X-Received: by 2002:a05:690c:62c7:b0:6ea:8dad:c3cf with SMTP id
 00721157ae682-6ee55a77fbcmr141106937b3.20.1731971032786; Mon, 18 Nov 2024
 15:03:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113002818.3578645-1-howardchu95@gmail.com>
 <20241113002818.3578645-2-howardchu95@gmail.com> <ZzutCSbEU-5UZXc3@google.com>
In-Reply-To: <ZzutCSbEU-5UZXc3@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Mon, 18 Nov 2024 15:03:41 -0800
Message-ID: <CAH0uvoj5EY3mkgtduKV7VY8iTWCrhokCtuZimy=N7=3Ah9gGgw@mail.gmail.com>
Subject: Re: [PATCH v8 01/10] perf record --off-cpu: Add --off-cpu-thresh option
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, peterz@infradead.org, irogers@google.com, 
	mingo@redhat.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Mark Rutland <mark.rutland@arm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

On Mon, Nov 18, 2024 at 1:09=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello Howard,
>
> On Tue, Nov 12, 2024 at 04:28:09PM -0800, Howard Chu wrote:
> > Specify the threshold for dumping offcpu samples with --off-cpu-thresh,
> > the unit is us (microsecond). Default value is 500000us (500ms, 0.5s).
>
> I think it's better to add an option after you implemented the feature.
> Before that you may hardcode the threshold if necessary.
>
> Also it'd be a good practice to add an example for the option in the
> commit message.

Sure.

>
> >
> > Suggested-by: Ian Rogers <irogers@google.com>
> > Reviewed-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: James Clark <james.clark@linaro.org>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Link: https://lore.kernel.org/r/20241108204137.2444151-2-howardchu95@gm=
ail.com
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/builtin-record.c | 26 ++++++++++++++++++++++++++
> >  tools/perf/util/off_cpu.h   |  1 +
> >  tools/perf/util/record.h    |  1 +
>
> Please update the documentation if you add a new option.

Ok sure.

Thanks,
Howard
>
> Thanks,
> Namhyung
>
>
> >  3 files changed, 28 insertions(+)
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index f83252472921..c069000efe5c 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -3149,6 +3149,28 @@ static int record__parse_mmap_pages(const struct=
 option *opt,
> >       return ret;
> >  }
> >
> > +static int record__parse_off_cpu_thresh(const struct option *opt,
> > +                                     const char *str,
> > +                                     int unset __maybe_unused)
> > +{
> > +     struct record_opts *opts =3D opt->value;
> > +     char *endptr;
> > +     u64 off_cpu_thresh_us;
> > +
> > +     if (!str)
> > +             return -EINVAL;
> > +
> > +     off_cpu_thresh_us =3D strtoull(str, &endptr, 10);
> > +
> > +     /* threshold isn't string "0", yet strtoull() returns 0, parsing =
failed */
> > +     if (*endptr || (off_cpu_thresh_us =3D=3D 0 && strcmp(str, "0")))
> > +             return -EINVAL;
> > +     else
> > +             opts->off_cpu_thresh_us =3D off_cpu_thresh_us;
> > +
> > +     return 0;
> > +}
> > +
> >  void __weak arch__add_leaf_frame_record_opts(struct record_opts *opts =
__maybe_unused)
> >  {
> >  }
> > @@ -3342,6 +3364,7 @@ static struct record record =3D {
> >               .ctl_fd              =3D -1,
> >               .ctl_fd_ack          =3D -1,
> >               .synth               =3D PERF_SYNTH_ALL,
> > +             .off_cpu_thresh_us   =3D OFFCPU_THRESH,
> >       },
> >  };
> >
> > @@ -3564,6 +3587,9 @@ static struct option __record_options[] =3D {
> >       OPT_BOOLEAN(0, "off-cpu", &record.off_cpu, "Enable off-cpu analys=
is"),
> >       OPT_STRING(0, "setup-filter", &record.filter_action, "pin|unpin",
> >                  "BPF filter action"),
> > +     OPT_CALLBACK(0, "off-cpu-thresh", &record.opts, "us",
> > +                  "Dump off-cpu samples if off-cpu time reaches this t=
hreshold. The unit is microsecond (default: 500000)",
> > +                  record__parse_off_cpu_thresh),
> >       OPT_END()
> >  };
> >
> > diff --git a/tools/perf/util/off_cpu.h b/tools/perf/util/off_cpu.h
> > index 2dd67c60f211..c6edc0f7c40d 100644
> > --- a/tools/perf/util/off_cpu.h
> > +++ b/tools/perf/util/off_cpu.h
> > @@ -16,6 +16,7 @@ struct record_opts;
> >                             PERF_SAMPLE_PERIOD | PERF_SAMPLE_CALLCHAIN =
| \
> >                             PERF_SAMPLE_CGROUP)
> >
> > +#define OFFCPU_THRESH 500000ull
> >
> >  #ifdef HAVE_BPF_SKEL
> >  int off_cpu_prepare(struct evlist *evlist, struct target *target,
> > diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
> > index a6566134e09e..2ca74add26c0 100644
> > --- a/tools/perf/util/record.h
> > +++ b/tools/perf/util/record.h
> > @@ -79,6 +79,7 @@ struct record_opts {
> >       int           synth;
> >       int           threads_spec;
> >       const char    *threads_user_spec;
> > +     u64           off_cpu_thresh_us;
> >  };
> >
> >  extern const char * const *record_usage;
> > --
> > 2.43.0
> >
