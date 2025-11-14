Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6078E34D4D3
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 18:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763143968; cv=none; b=SryOOFBUOliL/ZRfuFP+XKsHa7l6Aat94GI0tAPYqHdo7uYRldEusJKZ9NFDqmYwD2xR7RGn0kifSRqb/irDcWAsF9O3LGnNSK25ebQt2vUjA4qxAoLUBdycKBlGRcwqWTQYIqLCfvDP9p/cocGBMtUslLszcp/gwGWJ95t1vUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763143968; c=relaxed/simple;
	bh=EQupp+04ELD6HQsXX6MzzyyC59DMMJpf+/oH4iZVPtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhupX3XaXU9z6kswLjTUFNMlubPpwMrnVT5gvIP1PLY1flgQSFM4LbXOJ+3Ll6UvWJ6D6HhoxvdcsTepRYcfpWU+AlRpEL4jJRGHUKAgr7hNznc2u04VyYV0+aMGFil6Tj08/M3F0gh0BAdumbLfQpyAGOM05Qr005UJH+5dW1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H701eza6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H701eza6"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-297e13bf404so11915ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 10:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763143966; x=1763748766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGQ3t09Vqky40RisUTfak9sVzJBgZBZXHsje53VwQQE=;
        b=H701eza6QUy7axiivZEn4dc7Q1IWsx4vEl4fvzvX1xD5KaK/risQFWYGJceCw1Y3Tm
         KiYes6QFpmXJd55TDwZ4OEnmHU2sysHAusr8FOy7IRJDM7xCZq+DQQFWAvRO/SPJj+8f
         de4tLLdZEEfRfN+5TMCnx0e8u90abAt1jjSxzyM4rUunHK32s40TYSPAmWGAjf0059rW
         /E2LxAOT9wLyk4ZtBl/n9ur5w/eYaQd2L38+bG61ehMH+M2tTtT3qHKdnpIiTJ7PvGf4
         D6D9imVUyjQZ6R9N/MxZ3NntdfF99ybATQVQUMmmnrF8f9V7PyyBFoNLoVB/TMC/u23w
         Aw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763143966; x=1763748766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DGQ3t09Vqky40RisUTfak9sVzJBgZBZXHsje53VwQQE=;
        b=xTt4xVm5VfHqd4xMC1X3AWhY+w/AcNrWTYlsloRZZstk71w4VzA9pE8qD3xozCvilo
         XgCV/JKb4YsxL4hAP2QEEmgG3aCuGIx4oPKAgT8t3yhvRL5NlAV0PnFQmPbVxspKTBW7
         4JsXXiG5gTBY1f549yDzSoS48qKT33v3Wr6XdnKgGnOVwXQo+6npNZ8nDvrwlvV9GupX
         +XsMdtXD8H+2c/I0Wv3zcGRtFREZrPDtE7UtBsiTzOLGYfQYajyT26OvU65C41V50QHa
         SRu4i71csxozP1aqLdVDwoXhQ3IxTRsPl+2rK/rqon6o96Ip1xoa+WKgT6u772ZMJLg3
         LFOA==
X-Forwarded-Encrypted: i=1; AJvYcCUZTrV98kTA78o2Db8YLCKcs4TUBCokwT8Fo11HTOvaDcWBD0vyf5AZX9/IFbvLvl5567AS64mTwOR0YKwk4o5j@vger.kernel.org
X-Gm-Message-State: AOJu0YyNQ28qJaZdjQUVkdx+pFq7uVRGAwqvEhjDfalpeNsfuA7WpkOH
	p2xg5EvEJquKBtn1mmwipBOSNBqodfJV79D+vvm2NUOnlqSENVip/jkex45t+1trQDkc9xQoErL
	TuZ2xVU0wpG+Nln1D1sth0mFwH+QBhVQMsPe1RPRd
X-Gm-Gg: ASbGncs4vKV5alYTcrgeokD88xqFEge2R2g6wVPBWUbKehY7pwYrJrqTbMVWsBM8hzY
	6SuoMNGadHQ6piJaCK2DJuw6AS5W9ov5FoV3rrRWt2eNt3lkogHy/RMAuc9z1uHDApUMPYecc0x
	0JV3lX6IMQtWXP2UQ55McvYAchp6Pbh4YaQyYgXt6qDS6p3JmvFR46E+KG4n8+IEd/qyUymqj8b
	pxjgzSBpE0N1v625pDwmt2+kBvOflcVbPk3l4q82cYRVYiGG16OcKLMBCp4igpkCpzOsrKZDz3y
	COTwXJqkcaKSZIv1F0Vvsg8C
X-Google-Smtp-Source: AGHT+IHDTDwgoKmLeGkpy0Sf/1ZA31hWe2lctTrRIm2bk7mmJZBogd+fXeg7f70/HB+SavQtHbPE7f+h3XdZV5hiDsc=
X-Received: by 2002:a17:902:ea0e:b0:265:e66:6c10 with SMTP id
 d9443c01a7336-299c6a9873fmr36405ad.4.1763143965090; Fri, 14 Nov 2025 10:12:45
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114070018.160330-1-namhyung@kernel.org> <20251114070018.160330-4-namhyung@kernel.org>
 <CAP-5=fVEuYXw+P-+Z7bU7Z-+7dsHPPfABh5pdnPtfvH-23u4Qw@mail.gmail.com> <CAP-5=fU33sEARn0tc1hSMahBVCvs0cy+Cu-J6+BG0Cm-nuwKnA@mail.gmail.com>
In-Reply-To: <CAP-5=fU33sEARn0tc1hSMahBVCvs0cy+Cu-J6+BG0Cm-nuwKnA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 14 Nov 2025 10:12:34 -0800
X-Gm-Features: AWmQ_blmMIv0tlMTFyMW28bW9JAIo4EBPq5KJFNtE_1gspX1QPJ3s5vKmq9bH-A
Message-ID: <CAP-5=fVptEdzt363LpuZzzm=BJFFkB_xkOLW=x-2-TZa+cvS0g@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] perf record: Enable defer_callchain for user callchains
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, Jens Remus <jremus@linux.ibm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 10:09=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Fri, Nov 14, 2025 at 9:59=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Thu, Nov 13, 2025 at 11:01=E2=80=AFPM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > And add the missing feature detection logic to clear the flag on old
> > > kernels.
> > >
> > >   $ perf record -g -vv true
> > >   ...
> > >   ------------------------------------------------------------
> > >   perf_event_attr:
> > >     type                             0 (PERF_TYPE_HARDWARE)
> > >     size                             136
> > >     config                           0 (PERF_COUNT_HW_CPU_CYCLES)
> > >     { sample_period, sample_freq }   4000
> > >     sample_type                      IP|TID|TIME|CALLCHAIN|PERIOD
> > >     read_format                      ID|LOST
> > >     disabled                         1
> > >     inherit                          1
> > >     mmap                             1
> > >     comm                             1
> > >     freq                             1
> > >     enable_on_exec                   1
> > >     task                             1
> > >     sample_id_all                    1
> > >     mmap2                            1
> > >     comm_exec                        1
> > >     ksymbol                          1
> > >     bpf_event                        1
> > >     defer_callchain                  1
> > >     defer_output                     1
> > >   ------------------------------------------------------------
> > >   sys_perf_event_open: pid 162755  cpu 0  group_fd -1  flags 0x8
> > >   sys_perf_event_open failed, error -22
> > >   switching off deferred callchain support
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/util/evsel.c | 24 ++++++++++++++++++++++++
> > >  tools/perf/util/evsel.h |  1 +
> > >  2 files changed, 25 insertions(+)
> > >
> > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > index 244b3e44d090d413..f5652d00b457d096 100644
> > > --- a/tools/perf/util/evsel.c
> > > +++ b/tools/perf/util/evsel.c
> > > @@ -1061,6 +1061,14 @@ static void __evsel__config_callchain(struct e=
vsel *evsel, struct record_opts *o
> > >                 }
> > >         }
> > >
> > > +       if (param->record_mode =3D=3D CALLCHAIN_FP && !attr->exclude_=
callchain_user) {
> > > +               /*
> > > +                * Enable deferred callchains optimistically.  It'll =
be switched
> > > +                * off later if the kernel doesn't support it.
> > > +                */
> > > +               attr->defer_callchain =3D 1;
> > > +       }
> >
> > If a user has requested frame pointer call chains why would they want
> > deferred call chains? The point of deferral to my understanding is to
> > allow the paging in of debug data, but frame pointers don't need that
> > as the stack should be in the page cache.
> >
> > Is this being done for code coverage reasons so that deferral is known
> > to work for later addition of SFrames? In which case this should be an
> > opt-in not default behavior. When there is a record_mode of
> > CALLCHAIN_SFRAME then making deferral the default for that mode makes
> > sense, but not for frame pointers IMO.
>
> Just to be clear. I don't think the behavior of using frame pointers
> should change. Deferral has downsides, for example:
>
>   $ perf record -g -a sleep 1
>
> Without deferral kernel stack traces will contain both kernel and user
> traces. With deferral the user stack trace is only generated when the
> system call returns and so there is a chance for kernel stack traces
> to be missing their user part. An obvious behavioral change. I think
> for what you are doing here we can have an option something like:
>
>   $ perf record --call-graph fp-deferred -a sleep 1
>
> Which would need a man page update, etc. What is happening with the
> other call-graph modes and deferral? Could the option be something
> like `--call-graph fp,deferred` so that the option is a common one and
> say stack snapshots for dwarf be somehow improved?

Also, making deferral the norm will generate new perf events that
tools, other than perf, processing perf.data files will fail to
consume. So this change would break quite a lot of stuff, so it should
not just be made the default.

Thanks,
Ian

> Thanks,
> Ian
>
> > Thanks,
> > Ian
> >
> > > +
> > >         if (function) {
> > >                 pr_info("Disabling user space callchains for function=
 trace event.\n");
> > >                 attr->exclude_callchain_user =3D 1;
> > > @@ -1511,6 +1519,7 @@ void evsel__config(struct evsel *evsel, struct =
record_opts *opts,
> > >         attr->mmap2    =3D track && !perf_missing_features.mmap2;
> > >         attr->comm     =3D track;
> > >         attr->build_id =3D track && opts->build_id;
> > > +       attr->defer_output =3D track;
> > >
> > >         /*
> > >          * ksymbol is tracked separately with text poke because it ne=
eds to be
> > > @@ -2199,6 +2208,10 @@ static int __evsel__prepare_open(struct evsel =
*evsel, struct perf_cpu_map *cpus,
> > >
> > >  static void evsel__disable_missing_features(struct evsel *evsel)
> > >  {
> > > +       if (perf_missing_features.defer_callchain && evsel->core.attr=
.defer_callchain)
> > > +               evsel->core.attr.defer_callchain =3D 0;
> > > +       if (perf_missing_features.defer_callchain && evsel->core.attr=
.defer_output)
> > > +               evsel->core.attr.defer_output =3D 0;
> > >         if (perf_missing_features.inherit_sample_read && evsel->core.=
attr.inherit &&
> > >             (evsel->core.attr.sample_type & PERF_SAMPLE_READ))
> > >                 evsel->core.attr.inherit =3D 0;
> > > @@ -2473,6 +2486,13 @@ static bool evsel__detect_missing_features(str=
uct evsel *evsel, struct perf_cpu
> > >
> > >         /* Please add new feature detection here. */
> > >
> > > +       attr.defer_callchain =3D true;
> > > +       if (has_attr_feature(&attr, /*flags=3D*/0))
> > > +               goto found;
> > > +       perf_missing_features.defer_callchain =3D true;
> > > +       pr_debug2("switching off deferred callchain support\n");
> > > +       attr.defer_callchain =3D false;
> > > +
> > >         attr.inherit =3D true;
> > >         attr.sample_type =3D PERF_SAMPLE_READ | PERF_SAMPLE_TID;
> > >         if (has_attr_feature(&attr, /*flags=3D*/0))
> > > @@ -2584,6 +2604,10 @@ static bool evsel__detect_missing_features(str=
uct evsel *evsel, struct perf_cpu
> > >         errno =3D old_errno;
> > >
> > >  check:
> > > +       if ((evsel->core.attr.defer_callchain || evsel->core.attr.def=
er_output) &&
> > > +           perf_missing_features.defer_callchain)
> > > +               return true;
> > > +
> > >         if (evsel->core.attr.inherit &&
> > >             (evsel->core.attr.sample_type & PERF_SAMPLE_READ) &&
> > >             perf_missing_features.inherit_sample_read)
> > > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > > index 3ae4ac8f9a37e009..a08130ff2e47a887 100644
> > > --- a/tools/perf/util/evsel.h
> > > +++ b/tools/perf/util/evsel.h
> > > @@ -221,6 +221,7 @@ struct perf_missing_features {
> > >         bool branch_counters;
> > >         bool aux_action;
> > >         bool inherit_sample_read;
> > > +       bool defer_callchain;
> > >  };
> > >
> > >  extern struct perf_missing_features perf_missing_features;
> > > --
> > > 2.52.0.rc1.455.g30608eb744-goog
> > >
> > >
