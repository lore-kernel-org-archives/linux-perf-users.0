Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C3937700
	for <linux-perf-users@vger.kernel.org>; Mon, 13 May 2024 18:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715625112; cv=none; b=rGVnoF1DuecEciYKpOLLr3dOXYZYuZmM5RPi9B9wIaL454jcAK+zqTILfruEOaCuNaDbNA4DhPXaMz050YG72PeGagHjvXF2iZRYqg9FMm5MCiEaln7/ByPvowfYxblGG+Xl96+NFjbspqpBY31nXYo4WFW4e/5EzYqpG1aGbA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715625112; c=relaxed/simple;
	bh=3ZwAB8Y8ZUIyGagmA9bMT/46c3bkaZgO1OCbdjLIhQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QL+/S6SMtGIw8aBkeYDkV9ztFBo22lLQE2urh/Mqvi84iJFwZJrr0qeimW/YtRivvuJDOTOAzR1kLWJ6NC4zZ7TFzA4Ez28skX1732Ch42V/iglH5jKilM7oSjJWP8OI4t6QhdMAPDER0ra02gUo1SehpcHCtfbFqkA0mAPUPWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e7elEJH7; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e7elEJH7"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso20473a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 May 2024 11:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715625107; x=1716229907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dp4o1bBP9g8nSA2c4EpHf9/XklxFDXV2HdHmWJKkIqw=;
        b=e7elEJH7NOwhPMOzmp2ISWNlOFIKZWQBH6O7f+CBhbdgjXHnDT53uh1VqoCJxStsxV
         FLUdMPezoowxy5UPF4fY1DKDHalQPgNCH5kc3tmcjnK9AXGdQ4SNf/N/ENGIhmsy3mcX
         wGPqDNgobmMVZzQaU6C1rAUf16YaQy29ZzCPpZI5LvdP7Zuj8zxuF4ojMtj/3KzUqrlI
         YbYv0F1fC0D48FBi95iys9tTQPNT/fB7aEmdfLiTRQtCBTIi2zNntR0TZ/z9snMIfOPw
         7mYccyYxVEzvQXWtcsHweUE8B5s6aKSgWfvxP6juK+3L/4MJ6dIbnhR6abjwntYhiU/F
         LkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715625107; x=1716229907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dp4o1bBP9g8nSA2c4EpHf9/XklxFDXV2HdHmWJKkIqw=;
        b=wHJ6Oo2fJ649EYn+o4JDg3S/8uLZ9IN+oLa6LZ6r9pN8d05XZ9Wja2cVJFAqdcN4aT
         hOJ782aU/sbfdYqHYlLJgP+igmPCVThXpE0KERSWkiAPk9YC8/hUy88SIL54QKLRzikN
         2dLEIHiKy2ZokhlvnRjH2UaTLaP6vEWV1HYNFWGgVB5aNlqlP88Rsx/GqEka5rw4KxKG
         gqupPflwQXloFp8Lt0+Wv7vKsALEU2GdKlvx0pmMS7MC+AViNDA/Fx1kNFq+EA3SXlDp
         Jb983h36Zu4Dap4CCOeEfZdd5Sfri4316LAqJpGH6krqYlfH2Q1TAr12bbG8F2XzZmI8
         ZCxw==
X-Forwarded-Encrypted: i=1; AJvYcCXM8JsxonE4jeKbXAHD1sCbDlEWwMVSeb813fUesNxw4cFOioFCVCKyr8EWyjOxj9WzeLFXChaOyBNJrp+Xlm9IoYPqL9WKrMVaYB3r25/xvQ==
X-Gm-Message-State: AOJu0Ywce5qtFVJE0LMWh6k6KDHdRAAJxmmZAVDdHGmv402FA3xrD5Yg
	m8twfsKAF/xbtWI0baJlN3CyvI8slZB0X56k53VYUyFaTGk+u7jKCX3g7xL4Sbd28WKi91VmAXS
	C9SC2iOCDlebMLFsYAlzl8+5HTtnYTD7by0o=
X-Google-Smtp-Source: AGHT+IFt9WAWEm8QsBb4sEg9CQQRW3buM/TQvs364N6oHJq9eMGxek+5D8VmJE/YX1MybjfvRdmV3Zq5jL/uB0Qx6C4=
X-Received: by 2002:a50:cc0c:0:b0:572:9eec:774f with SMTP id
 4fb4d7f45d1cf-57421846490mr416314a12.0.1715625106955; Mon, 13 May 2024
 11:31:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510191423.2297538-1-yabinc@google.com> <20240510191423.2297538-4-yabinc@google.com>
 <CAM9d7chNz8-84m28q5qSLjUjZ=Ni1CA_JzbB_P+YJooLQd85YA@mail.gmail.com>
In-Reply-To: <CAM9d7chNz8-84m28q5qSLjUjZ=Ni1CA_JzbB_P+YJooLQd85YA@mail.gmail.com>
From: Yabin Cui <yabinc@google.com>
Date: Mon, 13 May 2024 11:31:34 -0700
Message-ID: <CALJ9ZPP_2=X7XNQrLCV1pQUVH-pnHbW=Kz75ugSy+kda9Xwmpg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] perf/core: Check sample_type in perf_sample_save_brstack
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

arch/powerpc/perf/core-book3s.c checks sample_type, see
   if (event->attr.sample_type & PERF_SAMPLE_BRANCH_STACK) {
     ...
     perf_sample_save_brstack(&data, event, &cpuhw->bhrb_stack, NULL);
  }
So I think we don't need the "fixes:" line.

On Fri, May 10, 2024 at 2:30=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, May 10, 2024 at 12:14=E2=80=AFPM Yabin Cui <yabinc@google.com> wr=
ote:
> >
> > Check sample_type in perf_sample_save_brstack() to prevent
> > saving branch stack data when it isn't required.
> >
> > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Yabin Cui <yabinc@google.com>
>
> It seems powerpc has the similar bug, then you need this:
>
> Fixes: eb55b455ef9c ("perf/core: Add perf_sample_save_brstack() helper")
>
> Thanks,
> Namhyung
>
> > ---
> >  arch/x86/events/amd/core.c |  3 +--
> >  arch/x86/events/core.c     |  3 +--
> >  arch/x86/events/intel/ds.c |  3 +--
> >  include/linux/perf_event.h | 13 ++++++++-----
> >  4 files changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> > index 985ef3b47919..fb9bf3aa1b42 100644
> > --- a/arch/x86/events/amd/core.c
> > +++ b/arch/x86/events/amd/core.c
> > @@ -967,8 +967,7 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *re=
gs)
> >                 if (!x86_perf_event_set_period(event))
> >                         continue;
> >
> > -               if (has_branch_stack(event))
> > -                       perf_sample_save_brstack(&data, event, &cpuc->l=
br_stack, NULL);
> > +               perf_sample_save_brstack(&data, event, &cpuc->lbr_stack=
, NULL);
> >
> >                 if (perf_event_overflow(event, &data, regs))
> >                         x86_pmu_stop(event, 0);
> > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > index 5b0dd07b1ef1..ff5577315938 100644
> > --- a/arch/x86/events/core.c
> > +++ b/arch/x86/events/core.c
> > @@ -1702,8 +1702,7 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
> >
> >                 perf_sample_data_init(&data, 0, event->hw.last_period);
> >
> > -               if (has_branch_stack(event))
> > -                       perf_sample_save_brstack(&data, event, &cpuc->l=
br_stack, NULL);
> > +               perf_sample_save_brstack(&data, event, &cpuc->lbr_stack=
, NULL);
> >
> >                 if (perf_event_overflow(event, &data, regs))
> >                         x86_pmu_stop(event, 0);
> > diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> > index c2b5585aa6d1..f25236ffa28f 100644
> > --- a/arch/x86/events/intel/ds.c
> > +++ b/arch/x86/events/intel/ds.c
> > @@ -1754,8 +1754,7 @@ static void setup_pebs_fixed_sample_data(struct p=
erf_event *event,
> >         if (x86_pmu.intel_cap.pebs_format >=3D 3)
> >                 setup_pebs_time(event, data, pebs->tsc);
> >
> > -       if (has_branch_stack(event))
> > -               perf_sample_save_brstack(data, event, &cpuc->lbr_stack,=
 NULL);
> > +       perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
> >  }
> >
> >  static void adaptive_pebs_save_regs(struct pt_regs *regs,
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index 8617815456b0..ecfbe22ff299 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -1269,6 +1269,11 @@ static inline void perf_sample_save_raw_data(str=
uct perf_sample_data *data,
> >         data->sample_flags |=3D PERF_SAMPLE_RAW;
> >  }
> >
> > +static inline bool has_branch_stack(struct perf_event *event)
> > +{
> > +       return event->attr.sample_type & PERF_SAMPLE_BRANCH_STACK;
> > +}
> > +
> >  static inline void perf_sample_save_brstack(struct perf_sample_data *d=
ata,
> >                                             struct perf_event *event,
> >                                             struct perf_branch_stack *b=
rs,
> > @@ -1276,6 +1281,9 @@ static inline void perf_sample_save_brstack(struc=
t perf_sample_data *data,
> >  {
> >         int size =3D sizeof(u64); /* nr */
> >
> > +       if (!has_branch_stack(event))
> > +               return;
> > +
> >         if (branch_sample_hw_index(event))
> >                 size +=3D sizeof(u64);
> >         size +=3D brs->nr * sizeof(struct perf_branch_entry);
> > @@ -1665,11 +1673,6 @@ extern void perf_bp_event(struct perf_event *eve=
nt, void *data);
> >  # define perf_arch_bpf_user_pt_regs(regs) regs
> >  #endif
> >
> > -static inline bool has_branch_stack(struct perf_event *event)
> > -{
> > -       return event->attr.sample_type & PERF_SAMPLE_BRANCH_STACK;
> > -}
> > -
> >  static inline bool needs_branch_stack(struct perf_event *event)
> >  {
> >         return event->attr.branch_sample_type !=3D 0;
> > --
> > 2.45.0.118.g7fe29c98d7-goog
> >
