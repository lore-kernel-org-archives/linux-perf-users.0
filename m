Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A859364EA4
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Apr 2026 17:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777312034; cv=pass; b=h1sEpBWjAlAldkHyfbGrsnwUlUR/vkxVGLPGYha9uZtX6hnpvQ5E2Yaki3zvGv/sfKTlkJEZHjhnaUCaBI7dlWjxryjs4kpjb8mpAOte2Mm5OLkLQKsKx92FXz2Zc9nMIskWx/v78VNCAh+Zd+Bws9en+nuiSgclwkG/XEflMwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777312034; c=relaxed/simple;
	bh=380UPs25Q3H3f+Uf+efXXTLNjkYACehYd9Kl16x15Iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ry0iOLhHT4ica6+Ht99JtwDtuBwHz9krlG48dq9WvBiT7lrHk39/baSCpfpn5sHKLkm6bgf4hfLnOZrzOnxdxZz45t/4NOpTRucBRlfJXO3muedKLBcs1q2opsDzTwudu2+Pd1iZQYBmCKriw1ryIGDXxPTD50j/yVZTSCP271M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CT4d6Xi3; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CT4d6Xi3"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1270f10a774so935c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Apr 2026 10:47:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777312032; cv=none;
        d=google.com; s=arc-20240605;
        b=RsXM5Ra6103hXEc8snjeZEduXy+wqa/M0JrSYcYTyChMHShAmxPzV3pH3uLxPpSzEJ
         Kf1RL1J3ctXRllT9bXL8qYbY3ZpdRBAJYwV6Cxk3PN1yxIVlKOTasPo0mbSpu63mmwMw
         b2QGsAAkfFtyZH0fxm8Xv7tH77jibHNtI1jHjFsokP1ddg2bGHP6j+zspLTO+lROSAqu
         VM/UZ3fQ4eN3NeuSHf0M6kez6ntGEXDWCXQB0ctaLu9TANI/SLEMI11n6vG8Nfs6FWed
         wnYwdBjP2kSZYBxL7hqOJoNVX3ItvqDKXM5nmFbcB4LwOLfgmFdgJ6Hn8TUAo7IICpCt
         w+EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FKZ5BDfUoGSXLU0w1MWPlV5LMvkb03z+QF+9r7Lf5mM=;
        fh=QuLW44E3EE58oLRdZJDs4xHqpwo+fWVvnuXz3DTPhyI=;
        b=WyTf3A1TWQ9M1xRvhuotdSK6+iIYMVNoYpXN7VPydnvc5R1ohYbH9t/pKmR1rBv6OB
         V1LUuhhsRgCQfd4It22q1qaWg01FTZuNRuZR7c/xD0ez0Swp/8sHk9GpugOkJPjAE+kQ
         PVQmYLt2yfdEh75aNI7nXITT24BkvZe0L9NpyrXDrvK6u+IReqnrq/z0n/wQg/AFfllA
         z1vRZ4Vwv+pGgZZJ3tm2EG0SVI7ixit8b5rwaSAwW35r3whnhRqK1oToO/Erk29eYJIW
         +ZKyFVyw8ZFvVSWz/PPbQtKdAG3qCz8YMel6sM7Z3HB5JjyghxfreY4hVqMsYMeCWpcD
         Tubg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777312032; x=1777916832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKZ5BDfUoGSXLU0w1MWPlV5LMvkb03z+QF+9r7Lf5mM=;
        b=CT4d6Xi3Esnk8a3z0EjRHQezCAEjWvpaZQNlpBz3tgT4EyDgx8ZudBbcT/e3UH0fAJ
         lrzRMpg2a/6RBpPeGEaqvbqgGln8ixEIzTm06mNauzKzeUNNDp04uFxhRWwb8dxQVHqF
         JIXB6VUD19iaa3LjLhHMFV4ExlcsBy/8CvxmeZ6v2skw9B9eVyKsVhJ3eC6VOKtJXleN
         Lm5o+JKPCmKt79N3Oq4/vs6qapoZ4hJtc7U3PD8w9HNBfVfvoYPXMLrHMvLGBVD6R2mr
         0KaNA34zS650KqNdaaYym7qMwTEMakcAJJbAgUAO4nf53JAUrPnUsI9V8Kg3cy2aZMN2
         Tb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777312032; x=1777916832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FKZ5BDfUoGSXLU0w1MWPlV5LMvkb03z+QF+9r7Lf5mM=;
        b=WXAP8l0mPOruqgSa96q4/R5VFce6AebflLfe2qNU+UUmiT5kaP0LEEsgdBadCDnBar
         +x5gFY/J1m1OK23ZaM3Lu1FWmFZ941Mq30hPIocBjRn1CLBXghSLdgBMsCyzA07It5rE
         nZWdPPa8y0cO+V97aLseJEfdTivKDS9hXPBT0wBTMiobGHMipngrV8brY/wM7x77t9E9
         Tp8lYS6/t0YRLbJsHqxDeUSRZdie57vWa4Hq9ZHwafZxHGGFcC9lt2Dv4Mz1x0DXy86i
         B1OtCZpism2hqcBiTCUcW8fHGbH9aP16EwAZwTU+wmpDN4A9vFTU24WzYMFsVSSqtFNX
         41CA==
X-Forwarded-Encrypted: i=1; AFNElJ8ELGVCcqStirufh1xoAsu9Vc7ynecNVI9iUXfGagC/XlMGSO9F/f4V6I08yo/8mDOgZlC/tXhUkPiILWJwbjhT@vger.kernel.org
X-Gm-Message-State: AOJu0YxBQHQyBB+7+/ErNI30EuoMS1hBgtHKj5f/njJLvzWdHn/76utz
	tz1ARFThmM+TYTkFFBy+rm7XZ6pJhBj85FoopxLO7u2zXYQfGgKSN3CA5bMKB1L35SfCbucOAGP
	e+3SceJ0ryO2M3G0KJK+UXNOBmuhU0DpKNzOHP48C
X-Gm-Gg: AeBDiesKclpCfLyAfXGZ84XQUES12WTzkDKs424iId77ETS5oSxai+ltUg5duyAuTSp
	iFG7CfiReDxCGxSQ449qPssMVVcykcPgxeMIzQCO7nAPzCGo4KOZWs8KrHDGW0WByZ1f1I7sHg/
	lEezV1hs7qWKAuFr3+SFjeEwT0+LWEuM1UVT14hsvLr3JX8lV6UuMZTZ0CK0Tw3R7jAWxkTgdV6
	omYDxMnwtD+//dmtvco8LwKLw5OUaQ+lHR+TaMrwlxwpJbXVNUFaZW+jaff8xk+fEtxpN7gmOzZ
	qEh1blPtNnr1H/Ffi34gWJ7Jgd0xDskeN6EBOZrW2gpYjuoJTf4aeIm0Q86CZ+6ZUaBYZw==
X-Received: by 2002:a05:7022:ea33:b0:11a:2c18:9e70 with SMTP id
 a92af1059eb24-12ddd6543cbmr14886c88.11.1777312030880; Mon, 27 Apr 2026
 10:47:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224951.174663-1-irogers@google.com>
 <20260425224951.174663-2-irogers@google.com> <ae7-jS-TeQ-TUXSF@google.com>
In-Reply-To: <ae7-jS-TeQ-TUXSF@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 27 Apr 2026 10:46:58 -0700
X-Gm-Features: AVHnY4LsDRkfVepD4FyKV2U7rVGw6tRg639K826XHLiE37CUsM_mU6g0pS_Z9Ow
Message-ID: <CAP-5=fXRa5qbdG81Ws_+KfsaH9BCYUgJ-HgRhdRjtEF4s4tvUQ@mail.gmail.com>
Subject: Re: [PATCH v7 01/59] perf inject: Fix itrace branch stack synthesis
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, tmricht@linux.ibm.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 26, 2026 at 11:13=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hi Ian,
>
> On Sat, Apr 25, 2026 at 03:48:53PM -0700, Ian Rogers wrote:
> > When using "perf inject --itrace=3DL" to synthesize branch stacks from
> > AUX data, several issues caused failures:
> >
> > 1. The synthesized samples were delivered without the
> >    PERF_SAMPLE_BRANCH_STACK flag if it was not in the original event's
> >    sample_type. Fixed by using sample_type | evsel->synth_sample_type
> >    in intel_pt_deliver_synth_event.
> >
> > 2. The record layout was misaligned because of inconsistent handling
> >    of PERF_SAMPLE_BRANCH_HW_INDEX. Fixed by explicitly writing nr and
> >    hw_idx in perf_event__synthesize_sample.
> >
> > 3. Modifying evsel->core.attr.sample_type early in __cmd_inject caused
> >    parse failures for subsequent records in the input file. Fixed by
> >    moving this modification to just before writing the header.
> >
> > 4. perf_event__repipe_sample was narrowed to only synthesize samples
> >    when branch stack injection was requested, and restored the use of
> >    perf_inject__cut_auxtrace_sample as a fallback to preserve
> >    functionality.
>
> Looks like it does a lot of things in a patch.  I think these are
> independent fixes from this series.  How about moving this out to a
> separate series?

Doesn't seem unreasonable. We can have the itrace=3DL fix for `perf
inject` be one patch and then other patches for the issues sashiko has
detected around this problem.

I think `perf inject --itrace=3DL` being broken is out of scope for
sashiko to detect a regression in the intel-PT testing. Care is needed
to ensure we merge the `perf inject --itrace=3DL` fixes before these
changes to avoid introducing a known regression.

Thanks,
Ian


> Thanks,
> Namhyung
>
> >
> > Assisted-by: Gemini:gemini-3.1-pro-preview
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> > Issues fixed in v2:
> >
> > 1. Potential Heap Overflow in perf_event__repipe_sample : Addressed by
> >    adding a check that prints an error and returns -EFAULT if the
> >    calculated event size exceeds PERF_SAMPLE_MAX_SIZE , as you
> >    requested.
> >
> > 2. Header vs Payload Mismatch in __cmd_inject : Addressed by narrowing
> >    the condition so that HEADER_BRANCH_STACK is only set in the file
> >    header if add_last_branch was true.
> >
> > 3. NULL Pointer Dereference in intel-pt.c : Addressed by updating the
> >    condition in intel_pt_do_synth_pebs_sample to fill sample.
> >    branch_stack if it was synthesized, even if not in the original
> >    sample_type .
> >
> > 4. Unsafe Reads for events lacking HW_INDEX in synthetic-events.c :
> >    Addressed by using the perf_sample__branch_entries() macro and
> >    checking sample->no_hw_idx .
> >
> > 5. Size mismatch in perf_event__sample_event_size : Addressed by
> >    passing branch_sample_type to it and conditioning the hw_idx size on
> >    PERF_SAMPLE_BRANCH_HW_INDEX .
> > ---
> >  tools/perf/bench/inject-buildid.c  |  9 ++--
> >  tools/perf/builtin-inject.c        | 77 ++++++++++++++++++++++++++++--
> >  tools/perf/tests/dlfilter-test.c   |  8 +++-
> >  tools/perf/tests/sample-parsing.c  |  5 +-
> >  tools/perf/util/arm-spe.c          |  7 ++-
> >  tools/perf/util/cs-etm.c           |  6 ++-
> >  tools/perf/util/intel-bts.c        |  3 +-
> >  tools/perf/util/intel-pt.c         | 13 +++--
> >  tools/perf/util/synthetic-events.c | 25 +++++++---
> >  tools/perf/util/synthetic-events.h |  6 ++-
> >  10 files changed, 129 insertions(+), 30 deletions(-)
> >
> > diff --git a/tools/perf/bench/inject-buildid.c b/tools/perf/bench/injec=
t-buildid.c
> > index aad572a78d7f..bfd2c5ec9488 100644
> > --- a/tools/perf/bench/inject-buildid.c
> > +++ b/tools/perf/bench/inject-buildid.c
> > @@ -228,9 +228,12 @@ static ssize_t synthesize_sample(struct bench_data=
 *data, struct bench_dso *dso,
> >
> >       event.header.type =3D PERF_RECORD_SAMPLE;
> >       event.header.misc =3D PERF_RECORD_MISC_USER;
> > -     event.header.size =3D perf_event__sample_event_size(&sample, benc=
h_sample_type, 0);
> > -
> > -     perf_event__synthesize_sample(&event, bench_sample_type, 0, &samp=
le);
> > +     event.header.size =3D perf_event__sample_event_size(&sample, benc=
h_sample_type,
> > +                                                        /*read_format=
=3D*/0,
> > +                                                        /*branch_sampl=
e_type=3D*/0);
> > +     perf_event__synthesize_sample(&event, bench_sample_type,
> > +                                   /*read_format=3D*/0,
> > +                                   /*branch_sample_type=3D*/0, &sample=
);
> >
> >       return writen(data->input_pipe[1], &event, event.header.size);
> >  }
> > diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> > index f174bc69cec4..88c0ef4f5ff1 100644
> > --- a/tools/perf/builtin-inject.c
> > +++ b/tools/perf/builtin-inject.c
> > @@ -375,7 +375,59 @@ static int perf_event__repipe_sample(const struct =
perf_tool *tool,
> >
> >       build_id__mark_dso_hit(tool, event, sample, evsel, machine);
> >
> > -     if (inject->itrace_synth_opts.set && sample->aux_sample.size) {
> > +     if (inject->itrace_synth_opts.set &&
> > +         (inject->itrace_synth_opts.last_branch ||
> > +          inject->itrace_synth_opts.add_last_branch)) {
> > +             union perf_event *event_copy =3D (void *)inject->event_co=
py;
> > +             struct branch_stack dummy_bs =3D { .nr =3D 0 };
> > +             int err;
> > +             size_t sz;
> > +             u64 orig_type =3D evsel->core.attr.sample_type;
> > +             u64 orig_branch_type =3D evsel->core.attr.branch_sample_t=
ype;
> > +
> > +             if (event_copy =3D=3D NULL) {
> > +                     inject->event_copy =3D malloc(PERF_SAMPLE_MAX_SIZ=
E);
> > +                     if (!inject->event_copy)
> > +                             return -ENOMEM;
> > +
> > +                     event_copy =3D (void *)inject->event_copy;
> > +             }
> > +
> > +             if (!sample->branch_stack)
> > +                     sample->branch_stack =3D &dummy_bs;
> > +
> > +             if (inject->itrace_synth_opts.add_last_branch) {
> > +                     /* Temporarily add in type bits for synthesis. */
> > +                     evsel->core.attr.sample_type |=3D PERF_SAMPLE_BRA=
NCH_STACK;
> > +                     evsel->core.attr.branch_sample_type |=3D PERF_SAM=
PLE_BRANCH_HW_INDEX;
> > +                     evsel->core.attr.sample_type &=3D ~PERF_SAMPLE_AU=
X;
> > +             }
> > +
> > +             sz =3D perf_event__sample_event_size(sample, evsel->core.=
attr.sample_type,
> > +                                                evsel->core.attr.read_=
format,
> > +                                                evsel->core.attr.branc=
h_sample_type);
> > +
> > +             if (sz > PERF_SAMPLE_MAX_SIZE) {
> > +                     pr_err("Sample size %zu exceeds max size %d\n", s=
z, PERF_SAMPLE_MAX_SIZE);
> > +                     return -EFAULT;
> > +             }
> > +
> > +             event_copy->header.type =3D PERF_RECORD_SAMPLE;
> > +             event_copy->header.size =3D sz;
> > +
> > +             err =3D perf_event__synthesize_sample(event_copy, evsel->=
core.attr.sample_type,
> > +                                                 evsel->core.attr.read=
_format,
> > +                                                 evsel->core.attr.bran=
ch_sample_type, sample);
> > +
> > +             evsel->core.attr.sample_type =3D orig_type;
> > +             evsel->core.attr.branch_sample_type =3D orig_branch_type;
> > +
> > +             if (err) {
> > +                     pr_err("Failed to synthesize sample\n");
> > +                     return err;
> > +             }
> > +             event =3D event_copy;
> > +     } else if (inject->itrace_synth_opts.set && sample->aux_sample.si=
ze) {
> >               event =3D perf_inject__cut_auxtrace_sample(inject, event,=
 sample);
> >               if (IS_ERR(event))
> >                       return PTR_ERR(event);
> > @@ -464,7 +516,8 @@ static int perf_event__convert_sample_callchain(con=
st struct perf_tool *tool,
> >       sample_type &=3D ~(PERF_SAMPLE_STACK_USER | PERF_SAMPLE_REGS_USER=
);
> >
> >       perf_event__synthesize_sample(event_copy, sample_type,
> > -                                   evsel->core.attr.read_format, sampl=
e);
> > +                                   evsel->core.attr.read_format,
> > +                                   evsel->core.attr.branch_sample_type=
, sample);
> >       return perf_event__repipe_synth(tool, event_copy);
> >  }
> >
> > @@ -1100,7 +1153,8 @@ static int perf_inject__sched_stat(const struct p=
erf_tool *tool,
> >       sample_sw.period =3D sample->period;
> >       sample_sw.time   =3D sample->time;
> >       perf_event__synthesize_sample(event_sw, evsel->core.attr.sample_t=
ype,
> > -                                   evsel->core.attr.read_format, &samp=
le_sw);
> > +                                   evsel->core.attr.read_format,
> > +                                   evsel->core.attr.branch_sample_type=
, &sample_sw);
> >       build_id__mark_dso_hit(tool, event_sw, &sample_sw, evsel, machine=
);
> >       ret =3D perf_event__repipe(tool, event_sw, &sample_sw, machine);
> >       perf_sample__exit(&sample_sw);
> > @@ -2434,12 +2488,25 @@ static int __cmd_inject(struct perf_inject *inj=
ect)
> >                * synthesized hardware events, so clear the feature flag=
.
> >                */
> >               if (inject->itrace_synth_opts.set) {
> > +                     struct evsel *evsel;
> > +
> >                       perf_header__clear_feat(&session->header,
> >                                               HEADER_AUXTRACE);
> > -                     if (inject->itrace_synth_opts.last_branch ||
> > -                         inject->itrace_synth_opts.add_last_branch)
> > +
> > +                     evlist__for_each_entry(session->evlist, evsel) {
> > +                             evsel->core.attr.sample_type &=3D ~PERF_S=
AMPLE_AUX;
> > +                     }
> > +
> > +                     if (inject->itrace_synth_opts.add_last_branch) {
> >                               perf_header__set_feat(&session->header,
> >                                                     HEADER_BRANCH_STACK=
);
> > +
> > +                             evlist__for_each_entry(session->evlist, e=
vsel) {
> > +                                     evsel->core.attr.sample_type |=3D=
 PERF_SAMPLE_BRANCH_STACK;
> > +                                     evsel->core.attr.branch_sample_ty=
pe |=3D
> > +                                             PERF_SAMPLE_BRANCH_HW_IND=
EX;
> > +                             }
> > +                     }
> >               }
> >
> >               /*
> > diff --git a/tools/perf/tests/dlfilter-test.c b/tools/perf/tests/dlfilt=
er-test.c
> > index e63790c61d53..204663571943 100644
> > --- a/tools/perf/tests/dlfilter-test.c
> > +++ b/tools/perf/tests/dlfilter-test.c
> > @@ -188,8 +188,12 @@ static int write_sample(struct test_data *td, u64 =
sample_type, u64 id, pid_t pid
> >
> >       event->header.type =3D PERF_RECORD_SAMPLE;
> >       event->header.misc =3D PERF_RECORD_MISC_USER;
> > -     event->header.size =3D perf_event__sample_event_size(&sample, sam=
ple_type, 0);
> > -     err =3D perf_event__synthesize_sample(event, sample_type, 0, &sam=
ple);
> > +     event->header.size =3D perf_event__sample_event_size(&sample, sam=
ple_type,
> > +                                                        /*read_format=
=3D*/0,
> > +                                                        /*branch_sampl=
e_type=3D*/0);
> > +     err =3D perf_event__synthesize_sample(event, sample_type,
> > +                                         /*read_format=3D*/0,
> > +                                         /*branch_sample_type=3D*/0, &=
sample);
> >       if (err)
> >               return test_result("perf_event__synthesize_sample() faile=
d", TEST_FAIL);
> >
> > diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sampl=
e-parsing.c
> > index a7327c942ca2..55f0b73ca20e 100644
> > --- a/tools/perf/tests/sample-parsing.c
> > +++ b/tools/perf/tests/sample-parsing.c
> > @@ -310,7 +310,8 @@ static int do_test(u64 sample_type, u64 sample_regs=
, u64 read_format)
> >               sample.read.one.lost  =3D 1;
> >       }
> >
> > -     sz =3D perf_event__sample_event_size(&sample, sample_type, read_f=
ormat);
> > +     sz =3D perf_event__sample_event_size(&sample, sample_type, read_f=
ormat,
> > +                                        evsel.core.attr.branch_sample_=
type);
> >       bufsz =3D sz + 4096; /* Add a bit for overrun checking */
> >       event =3D malloc(bufsz);
> >       if (!event) {
> > @@ -324,7 +325,7 @@ static int do_test(u64 sample_type, u64 sample_regs=
, u64 read_format)
> >       event->header.size =3D sz;
> >
> >       err =3D perf_event__synthesize_sample(event, sample_type, read_fo=
rmat,
> > -                                         &sample);
> > +                                         evsel.core.attr.branch_sample=
_type, &sample);
> >       if (err) {
> >               pr_debug("%s failed for sample_type %#"PRIx64", error %d\=
n",
> >                        "perf_event__synthesize_sample", sample_type, er=
r);
> > diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> > index e5835042acdf..c4ed9f10e731 100644
> > --- a/tools/perf/util/arm-spe.c
> > +++ b/tools/perf/util/arm-spe.c
> > @@ -484,8 +484,11 @@ static void arm_spe__prep_branch_stack(struct arm_=
spe_queue *speq)
> >
> >  static int arm_spe__inject_event(union perf_event *event, struct perf_=
sample *sample, u64 type)
> >  {
> > -     event->header.size =3D perf_event__sample_event_size(sample, type=
, 0);
> > -     return perf_event__synthesize_sample(event, type, 0, sample);
> > +     event->header.type =3D PERF_RECORD_SAMPLE;
> > +     event->header.size =3D perf_event__sample_event_size(sample, type=
, /*read_format=3D*/0,
> > +                                                        /*branch_sampl=
e_type=3D*/0);
> > +     return perf_event__synthesize_sample(event, type, /*read_format=
=3D*/0,
> > +                                          /*branch_sample_type=3D*/0, =
sample);
> >  }
> >
> >  static inline int
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index 8a639d2e51a4..1ebc1a6a5e75 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -1425,8 +1425,10 @@ static void cs_etm__update_last_branch_rb(struct=
 cs_etm_queue *etmq,
> >  static int cs_etm__inject_event(union perf_event *event,
> >                              struct perf_sample *sample, u64 type)
> >  {
> > -     event->header.size =3D perf_event__sample_event_size(sample, type=
, 0);
> > -     return perf_event__synthesize_sample(event, type, 0, sample);
> > +     event->header.size =3D perf_event__sample_event_size(sample, type=
, /*read_format=3D*/0,
> > +                                                        /*branch_sampl=
e_type=3D*/0);
> > +     return perf_event__synthesize_sample(event, type, /*read_format=
=3D*/0,
> > +                                          /*branch_sample_type=3D*/0, =
sample);
> >  }
> >
> >
> > diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
> > index 382255393fb3..0b18ebd13f7c 100644
> > --- a/tools/perf/util/intel-bts.c
> > +++ b/tools/perf/util/intel-bts.c
> > @@ -303,7 +303,8 @@ static int intel_bts_synth_branch_sample(struct int=
el_bts_queue *btsq,
> >               event.sample.header.size =3D bts->branches_event_size;
> >               ret =3D perf_event__synthesize_sample(&event,
> >                                                   bts->branches_sample_=
type,
> > -                                                 0, &sample);
> > +                                                 /*read_format=3D*/0, =
/*branch_sample_type=3D*/0,
> > +                                                 &sample);
> >               if (ret)
> >                       return ret;
> >       }
> > diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> > index fc9eec8b54b8..2dce6106c038 100644
> > --- a/tools/perf/util/intel-pt.c
> > +++ b/tools/perf/util/intel-pt.c
> > @@ -1731,8 +1731,12 @@ static void intel_pt_prep_b_sample(struct intel_=
pt *pt,
> >  static int intel_pt_inject_event(union perf_event *event,
> >                                struct perf_sample *sample, u64 type)
> >  {
> > -     event->header.size =3D perf_event__sample_event_size(sample, type=
, 0);
> > -     return perf_event__synthesize_sample(event, type, 0, sample);
> > +     event->header.type =3D PERF_RECORD_SAMPLE;
> > +     event->header.size =3D perf_event__sample_event_size(sample, type=
, /*read_format=3D*/0,
> > +                                                        /*branch_sampl=
e_type=3D*/0);
> > +
> > +     return perf_event__synthesize_sample(event, type, /*read_format=
=3D*/0,
> > +                                          /*branch_sample_type=3D*/0, =
sample);
> >  }
> >
> >  static inline int intel_pt_opt_inject(struct intel_pt *pt,
> > @@ -2486,7 +2490,7 @@ static int intel_pt_do_synth_pebs_sample(struct i=
ntel_pt_queue *ptq, struct evse
> >               intel_pt_add_xmm(intr_regs, pos, items, regs_mask);
> >       }
> >
> > -     if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
> > +     if ((sample_type | evsel->synth_sample_type) & PERF_SAMPLE_BRANCH=
_STACK) {
> >               if (items->mask[INTEL_PT_LBR_0_POS] ||
> >                   items->mask[INTEL_PT_LBR_1_POS] ||
> >                   items->mask[INTEL_PT_LBR_2_POS]) {
> > @@ -2557,7 +2561,8 @@ static int intel_pt_do_synth_pebs_sample(struct i=
ntel_pt_queue *ptq, struct evse
> >               sample.transaction =3D txn;
> >       }
> >
> > -     ret =3D intel_pt_deliver_synth_event(pt, event, &sample, sample_t=
ype);
> > +     ret =3D intel_pt_deliver_synth_event(pt, event, &sample,
> > +                                        sample_type | evsel->synth_sam=
ple_type);
> >       perf_sample__exit(&sample);
> >       return ret;
> >  }
> > diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synth=
etic-events.c
> > index 85bee747f4cd..2461f25a4d7d 100644
> > --- a/tools/perf/util/synthetic-events.c
> > +++ b/tools/perf/util/synthetic-events.c
> > @@ -1455,7 +1455,8 @@ int perf_event__synthesize_stat_round(const struc=
t perf_tool *tool,
> >       return process(tool, (union perf_event *) &event, NULL, machine);
> >  }
> >
> > -size_t perf_event__sample_event_size(const struct perf_sample *sample,=
 u64 type, u64 read_format)
> > +size_t perf_event__sample_event_size(const struct perf_sample *sample,=
 u64 type, u64 read_format,
> > +                                  u64 branch_sample_type)
> >  {
> >       size_t sz, result =3D sizeof(struct perf_record_sample);
> >
> > @@ -1515,8 +1516,10 @@ size_t perf_event__sample_event_size(const struc=
t perf_sample *sample, u64 type,
> >
> >       if (type & PERF_SAMPLE_BRANCH_STACK) {
> >               sz =3D sample->branch_stack->nr * sizeof(struct branch_en=
try);
> > -             /* nr, hw_idx */
> > -             sz +=3D 2 * sizeof(u64);
> > +             /* nr */
> > +             sz +=3D sizeof(u64);
> > +             if (branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX)
> > +                     sz +=3D sizeof(u64);
> >               result +=3D sz;
> >       }
> >
> > @@ -1605,7 +1608,7 @@ static __u64 *copy_read_group_values(__u64 *array=
, __u64 read_format,
> >  }
> >
> >  int perf_event__synthesize_sample(union perf_event *event, u64 type, u=
64 read_format,
> > -                               const struct perf_sample *sample)
> > +                               u64 branch_sample_type, const struct pe=
rf_sample *sample)
> >  {
> >       __u64 *array;
> >       size_t sz;
> > @@ -1719,9 +1722,17 @@ int perf_event__synthesize_sample(union perf_eve=
nt *event, u64 type, u64 read_fo
> >
> >       if (type & PERF_SAMPLE_BRANCH_STACK) {
> >               sz =3D sample->branch_stack->nr * sizeof(struct branch_en=
try);
> > -             /* nr, hw_idx */
> > -             sz +=3D 2 * sizeof(u64);
> > -             memcpy(array, sample->branch_stack, sz);
> > +
> > +             *array++ =3D sample->branch_stack->nr;
> > +
> > +             if (branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX) {
> > +                     if (sample->no_hw_idx)
> > +                             *array++ =3D 0;
> > +                     else
> > +                             *array++ =3D sample->branch_stack->hw_idx=
;
> > +             }
> > +
> > +             memcpy(array, perf_sample__branch_entries((struct perf_sa=
mple *)sample), sz);
> >               array =3D (void *)array + sz;
> >       }
> >
> > diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synth=
etic-events.h
> > index b0edad0c3100..8c7f49f9ccf5 100644
> > --- a/tools/perf/util/synthetic-events.h
> > +++ b/tools/perf/util/synthetic-events.h
> > @@ -81,7 +81,8 @@ int perf_event__synthesize_mmap_events(const struct p=
erf_tool *tool, union perf_
> >  int perf_event__synthesize_modules(const struct perf_tool *tool, perf_=
event__handler_t process, struct machine *machine);
> >  int perf_event__synthesize_namespaces(const struct perf_tool *tool, un=
ion perf_event *event, pid_t pid, pid_t tgid, perf_event__handler_t process=
, struct machine *machine);
> >  int perf_event__synthesize_cgroups(const struct perf_tool *tool, perf_=
event__handler_t process, struct machine *machine);
> > -int perf_event__synthesize_sample(union perf_event *event, u64 type, u=
64 read_format, const struct perf_sample *sample);
> > +int perf_event__synthesize_sample(union perf_event *event, u64 type, u=
64 read_format,
> > +                               u64 branch_sample_type, const struct pe=
rf_sample *sample);
> >  int perf_event__synthesize_stat_config(const struct perf_tool *tool, s=
truct perf_stat_config *config, perf_event__handler_t process, struct machi=
ne *machine);
> >  int perf_event__synthesize_stat_events(struct perf_stat_config *config=
, const struct perf_tool *tool, struct evlist *evlist, perf_event__handler_=
t process, bool attrs);
> >  int perf_event__synthesize_stat_round(const struct perf_tool *tool, u6=
4 time, u64 type, perf_event__handler_t process, struct machine *machine);
> > @@ -97,7 +98,8 @@ void perf_event__synthesize_final_bpf_metadata(struct=
 perf_session *session,
> >
> >  int perf_tool__process_synth_event(const struct perf_tool *tool, union=
 perf_event *event, struct machine *machine, perf_event__handler_t process)=
;
> >
> > -size_t perf_event__sample_event_size(const struct perf_sample *sample,=
 u64 type, u64 read_format);
> > +size_t perf_event__sample_event_size(const struct perf_sample *sample,=
 u64 type,
> > +                                  u64 read_format, u64 branch_sample_t=
ype);
> >
> >  int __machine__synthesize_threads(struct machine *machine, const struc=
t perf_tool *tool,
> >                                 struct target *target, struct perf_thre=
ad_map *threads,
> > --
> > 2.54.0.545.g6539524ca2-goog
> >
