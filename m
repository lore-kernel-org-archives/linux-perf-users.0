Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E4511C83;
	Thu,  8 Aug 2024 04:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723089702; cv=none; b=S2ZNq65miqvDL9PJjtcPCMgxqfvvZS6m+5491f4oUHKFfoBrgiGTp1pQjOtuqKT9/JQvfTpw2EWyh1v7HkA2mkVxXP7J4abs9y6q6clTaQupwFVe82vhDV3ytlVaaWQOTnDnr4Jo+v5pm46Xj3jXG9vokfjXlh95wQ4NLaOnp9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723089702; c=relaxed/simple;
	bh=soBJ2nd2MTISL5ysYCgSFPOeQSxTVU/1vjGXsiZVKrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0ZVqq2I57FimGlDp9amSHzaz32YH1RODs8idZGmeH+Ip9NmTWnqtx8Vjbe67yDUCDq3OxF26LrK8aTEFLqDnZifGE2tzOwr1j2oC1OvWpd8OUknMbTpaSA7XCGxlz8WAQf3uMl249QzBrMxIKY6T8bgkY9w4IVJ//1r6S8zWn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVKD0ww5; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVKD0ww5"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e0ea24477f0so58051276.2;
        Wed, 07 Aug 2024 21:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723089700; x=1723694500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEcurEw+W3Hs5LT2+2YRDTBDXRPvHW6k7rbHq/j8KGo=;
        b=MVKD0ww5NRB1kcpeBS6rzVwkoWJoXaLobZTXrMfKJeLh2z185trKEduL49y3HJx0tR
         x1krDi4IhOadA1nTlrY2dOl5OfQpQfHm8/r7PKlH7YLYuX4Q7Ni9uEInq/7R5Ye3p7ZT
         uuyxVUdq8Ovp/JOv5um/eGdoW2CO8qgmA6hbB0uVPUG/GaozknC2YRNpsIrWg2scWsF+
         5IMSAhbAaTyYq0BXjr3B8HoFW+uxEfEx7Iu2guP38mghvBxXjUSyZgsRMLi+ghADx9Qc
         lyZIb8RT3pb3fbbiZGe1j5MtfXmfJCtcQYBU9p2qCfU+i9YJQ8oipTwVWs6omvnIBeLj
         9H4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723089700; x=1723694500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEcurEw+W3Hs5LT2+2YRDTBDXRPvHW6k7rbHq/j8KGo=;
        b=gFShUrXHAJ/fliGnR/WzqEcX2u+KOI3NHVrLY7JgOzu092/kH66JmrmxC8fnwmbyRd
         Ey6+N4oaYBN0ijD+Cm3hyaFN2BfKglTWekm90H+SrxiaLJAjuQKtYaCE1QmWbdpvyf3m
         rhHV4ZzjU/xN5T+vJ/MJsgzochOeSC2K0ODCu6ZcMK/fj5Dz7J4QkCePRMxR4V1gwtVK
         gxcszlMtsKL6espu8HTX0dL6s8lFgB7GNLn+uyxMvl+7zUoX6piT46m3FoQNWqM4buCG
         GVuuYLgFbolrv78MLL6pMCUI0ug1N6GGjJ51hBtJ2Z3iT30AWiPc55wM+xdH2DDvDazi
         dWwg==
X-Forwarded-Encrypted: i=1; AJvYcCXsl1AAa0SpV8ADEtYsfBIBuagm1QxvetXKmXZhbGGlEIqjk7mitPP7JXO0484TPfZGrdEOhRywnd8US24FI3NpxG//YpIRYFdq8pB0qFF6q3Yk+rIAWjLcYJ6Rh2ps7uyIGZ+CQ/RBJB4pQ/fV7Q==
X-Gm-Message-State: AOJu0YxyQD6ktijomGEVit6sVdHDngb6BBgFQ+N+a2iZ7v0Rm1fEqyCu
	Z/A04SrTOPf6RPvDo7eC0oqrbfmm4UP5f4FLrTybx9DmYAtEwzZLYfWciqi6NzHBeoiXmv3Iwgr
	uQ90NEf8SQHPEmB/8KxEkjHw3yiY=
X-Google-Smtp-Source: AGHT+IEssCyu+Xbpaj6PQnk9jDryOpE5jmQJ3NU7yvzMFdJ6D677l/y6xz4cmO7mGEQ+/72qBTy/1+AvWDEkMigz8wA=
X-Received: by 2002:a05:6902:2b0c:b0:e0e:88fc:edd5 with SMTP id
 3f1490d57ef6-e0e9dbf590bmr755786276.52.1723089700292; Wed, 07 Aug 2024
 21:01:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807153843.3231451-1-howardchu95@gmail.com>
 <20240807153843.3231451-3-howardchu95@gmail.com> <ZrQBsmfS-RcXmncw@google.com>
In-Reply-To: <ZrQBsmfS-RcXmncw@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 8 Aug 2024 12:01:29 +0800
Message-ID: <CAH0uvoghMwhokAro0ouqfBG6ccbGxjEKodU+GCnj7XLHhkxWRg@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] perf record --off-cpu: Add --off-cpu-thresh
To: Namhyung Kim <namhyung@kernel.org>
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	jolsa@kernel.org, kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 7:22=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Wed, Aug 07, 2024 at 11:38:36PM +0800, Howard Chu wrote:
> > Add the --off-cpu-thresh argument to specify the off-cpu time threshold=
.
> > If the off-cpu time exceeds this threshold, dump the off-cpu data
> > directly.
> >
> > Suggested-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > ---
> >  tools/perf/builtin-record.c            | 26 ++++++++++++++++++++++++++
> >  tools/perf/util/bpf_off_cpu.c          |  2 ++
> >  tools/perf/util/bpf_skel/off_cpu.bpf.c |  2 ++
> >  tools/perf/util/record.h               |  1 +
> >  4 files changed, 31 insertions(+)
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 72345d1e54b0..60c6fe7b4804 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -3133,6 +3133,28 @@ static int record__parse_mmap_pages(const struct=
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
> > +     u64 off_cpu_thresh;
> > +
> > +     if (!str)
> > +             return -EINVAL;
> > +
> > +     off_cpu_thresh =3D strtoul(str, &endptr, 10);
> > +
> > +     /* threshold isn't string "0", yet strtoull() returns 0, parsing =
failed. */
> > +     if (*endptr || (off_cpu_thresh =3D=3D 0 && strcmp(str, "0")))
> > +             return -EINVAL;
> > +     else
> > +             opts->off_cpu_thresh =3D off_cpu_thresh;
> > +
> > +     return 0;
> > +}
> > +
> >  void __weak arch__add_leaf_frame_record_opts(struct record_opts *opts =
__maybe_unused)
> >  {
> >  }
> > @@ -3326,6 +3348,7 @@ static struct record record =3D {
> >               .ctl_fd              =3D -1,
> >               .ctl_fd_ack          =3D -1,
> >               .synth               =3D PERF_SYNTH_ALL,
> > +             .off_cpu_thresh      =3D OFF_CPU_THRESH_DEFAULT,
>
> Where is it defined?

Poor formatting, sorry.

It's in [PATCH v4 5/9] perf record --off-cpu: Dump total off-cpu time at th=
e end

+#define OFF_CPU_THRESH_DEFAULT 500000ull

Thanks,
Howard
>
> Thanks,
> Namhyung
>
>
> >       },
> >       .tool =3D {
> >               .sample         =3D process_sample_event,
> > @@ -3560,6 +3583,9 @@ static struct option __record_options[] =3D {
> >       OPT_BOOLEAN(0, "off-cpu", &record.off_cpu, "Enable off-cpu analys=
is"),
> >       OPT_STRING(0, "setup-filter", &record.filter_action, "pin|unpin",
> >                  "BPF filter action"),
> > +     OPT_CALLBACK(0, "off-cpu-thresh", &record.opts, "us",
> > +                  "Dump off-cpu samples if off-cpu time reaches this t=
hreshold. The unit is microseconds. (default: 500000)",
> > +                  record__parse_off_cpu_thresh),
> >       OPT_END()
> >  };
> >
> > diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cp=
u.c
> > index 6af36142dc5a..1e0e454bfb5e 100644
> > --- a/tools/perf/util/bpf_off_cpu.c
> > +++ b/tools/perf/util/bpf_off_cpu.c
> > @@ -272,6 +272,8 @@ int off_cpu_prepare(struct evlist *evlist, struct t=
arget *target,
> >               }
> >       }
> >
> > +     skel->bss->offcpu_thresh =3D opts->off_cpu_thresh * 1000ull;
> > +
> >       err =3D off_cpu_bpf__attach(skel);
> >       if (err) {
> >               pr_err("Failed to attach off-cpu BPF skeleton\n");
> > diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/b=
pf_skel/off_cpu.bpf.c
> > index d877a0a9731f..cca1b6990a57 100644
> > --- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
> > +++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> > @@ -96,6 +96,8 @@ const volatile bool uses_cgroup_v1 =3D false;
> >
> >  int perf_subsys_id =3D -1;
> >
> > +__u64 sample_id, sample_type, offcpu_thresh;
> > +
> >  /*
> >   * Old kernel used to call it task_struct->state and now it's '__state=
'.
> >   * Use BPF CO-RE "ignored suffix rule" to deal with it like below:
> > diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
> > index a6566134e09e..3c11416e6627 100644
> > --- a/tools/perf/util/record.h
> > +++ b/tools/perf/util/record.h
> > @@ -79,6 +79,7 @@ struct record_opts {
> >       int           synth;
> >       int           threads_spec;
> >       const char    *threads_user_spec;
> > +     u64           off_cpu_thresh;
> >  };
> >
> >  extern const char * const *record_usage;
> > --
> > 2.45.2
> >
