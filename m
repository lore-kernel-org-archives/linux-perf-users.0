Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF48B1CD5A3
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719599705; cv=none; b=IX0VT1xsVQfTXqUbzEZBT85TfjrGaXvb+iz+Ibxzrz5Aso5dv+QEliAcebsSaXGg0hSN6MtVkfHtRowBgEOGQio5DrD/WWODGf+p1dRox2h5evBGlOCZ8msDWSCXgdCb7PM9P5OLUclItGG+j7ZXc/Zx7jnp3GijCaTnfosz9oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719599705; c=relaxed/simple;
	bh=CWKbXU0lGz+a/Ni71N8hM4X8U1qu9QQEnCLECfVKaT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVJcdLHBXM4Su9zRQRmZlSiZ3rdTeF3e1BJBkAGDDM5+6LVlPnVej4OZxPBrfc2UcT8dP49AfTyFHcK12xQlu9DPjof8AhJCHEW4qT7siZ6CHsryoRf+GMcnpIChznIDvZyU2zBpVh26BZInEbA7qRGw3JKlvdNKJtvHuu+HnUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vtBWGWKx; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vtBWGWKx"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f70ec6ff8bso23245ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 11:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719599703; x=1720204503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ok6cRHQFo/sSbN8VpEhgxlnh0lJa3fRDL/F3J0mwY0=;
        b=vtBWGWKxVlGwyIlcatxfw/onHgfIibuX5xra0nJa7JQXycBMbFJ6kV5FGDN21llDTr
         lUk0/gUw944seuJow+dthB4uEjr0Um06M4RxSMVo6iNyP3/+PJ3dBTy3zOHxbtKMkh5j
         twblNttJHS4mrmHTgKY4DwbLDFFCSQNjcY6u9QGmWBJmf8sM2embcBTM4Id79i8e631y
         Ia83RTh0X6Hhz9tXJYQKyaPHTJevN+7/RAIAjWDFYUoRBM1yMlO2TQ5WSBp3OKeSiAuV
         WGeDSclzbLp2i5/Zoeiu1XHSBEFGqHCeX/JMY0hCzhfOPNrDgz7nJ/SXybblXwKB5jiN
         tALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719599703; x=1720204503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ok6cRHQFo/sSbN8VpEhgxlnh0lJa3fRDL/F3J0mwY0=;
        b=L5EHeJPBwaHzD0rAsCJI9vSct89kag6IU7oWaIub0HjZrXaSEUP5KtIWiv7X8W4ae8
         hGDOPP/oV4fOoqCrnHZem5rie+qTTUaTB7GOYdvI0HGMN4987RbY6O2n0mMEoPeZ10v5
         ldJKypKzucZPZSNfhH07eG53qTtPnS/Cq6qnTyZXlw4M0t0XtlZao2vKyIGa37LV2FCk
         rU5ctXZfgiCZN8+n9aF3GQOV+LcOLyesB016BjK2h8NokhedHF0rc3nIhX4IbShNzPty
         qfiOrxBkbfSKJfUYuKmKw556uLCx0ZlfhYZXkq1iJ86b5HgWsc+Sm1MWWKpQcm+1BIln
         wzLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWksZMkrc1qzGoDWhYc+buHsHSYrX1s8SSpJBnQw+DzepbyAZrRg7PpehIT4KXaGFaggoTF9F9FwIHJJ2vNJo9tuuQO0NQFVOPCYDe+0pvV6w==
X-Gm-Message-State: AOJu0YxCplg6p4baTp7oXW7CUinwccUzXQwi25vE1yTFQp4RLvs/S+fe
	FZbeVhMSpvpb8dn9DSmX1NSza4URJtfs7oudFZZsHJ2mWyWPFjNYck/Vqe58EGVHH6Gfky/zJwX
	qcgxOT1IxHWNaFYGJhq2D2283Rk1w9tMZEiSZ
X-Google-Smtp-Source: AGHT+IF+YaAb75KFyh2laL4Zn4owsbIgw3VejBchQEsNH6l87JSPVR6VZhNui6Vm3I/JoPqKrzwlL6E5KHgH3YdCYYA=
X-Received: by 2002:a17:902:6e01:b0:1f6:567f:3c1f with SMTP id
 d9443c01a7336-1fad831dd43mr158655ad.3.1719599702614; Fri, 28 Jun 2024
 11:35:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com> <20240626203630.1194748-2-irogers@google.com>
 <d36acf6a-1505-459d-b392-be0fc952ad08@intel.com>
In-Reply-To: <d36acf6a-1505-459d-b392-be0fc952ad08@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 28 Jun 2024 11:34:51 -0700
Message-ID: <CAP-5=fU6eUUJeoKTsO0nv=yFvG=Wu_z_1VVpyyWNx42h+BpSKQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/27] perf auxevent: Zero size dummy tool
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 10:45=E2=80=AFAM Adrian Hunter <adrian.hunter@intel=
.com> wrote:
>
> In subject: "auxevent" -> "auxtrace"

Ack.

> On 26/06/24 23:36, Ian Rogers wrote:
> > The dummy tool is passed as a placeholder to allow a container_of to
> > get additional parameters. As the tool isn't used, make it a zero
> > sized array saving 320 bytes on an x86_64 build.
> >
> > s390-cpumsf's dummy tool struct was unused, so remove.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/arm-spe.c     | 6 +++---
> >  tools/perf/util/cs-etm.c      | 6 +++---
> >  tools/perf/util/intel-bts.c   | 6 +++---
> >  tools/perf/util/intel-pt.c    | 7 +++----
> >  tools/perf/util/s390-cpumsf.c | 5 -----
> >  5 files changed, 12 insertions(+), 18 deletions(-)
> >
> > diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> > index afbd5869f6bf..ee0d5064ddd4 100644
> > --- a/tools/perf/util/arm-spe.c
> > +++ b/tools/perf/util/arm-spe.c
> > @@ -1074,8 +1074,8 @@ static void arm_spe_print_info(__u64 *arr)
> >  }
> >
> >  struct arm_spe_synth {
> > -     struct perf_tool dummy_tool;
> >       struct perf_session *session;
> > +     struct perf_tool dummy_tool[0];
>
> [] is preferred to [0]
>
> >  };
> >
> >  static int arm_spe_event_synth(struct perf_tool *tool,
> > @@ -1084,7 +1084,7 @@ static int arm_spe_event_synth(struct perf_tool *=
tool,
> >                              struct machine *machine __maybe_unused)
> >  {
> >       struct arm_spe_synth *arm_spe_synth =3D
> > -                   container_of(tool, struct arm_spe_synth, dummy_tool=
);
> > +                   container_of(tool, struct arm_spe_synth, dummy_tool=
[0]);
> >
> >       return perf_session__deliver_synth_event(arm_spe_synth->session,
> >                                                event, NULL);
> > @@ -1098,7 +1098,7 @@ static int arm_spe_synth_event(struct perf_sessio=
n *session,
> >       memset(&arm_spe_synth, 0, sizeof(struct arm_spe_synth));
> >       arm_spe_synth.session =3D session;
> >
> > -     return perf_event__synthesize_attr(&arm_spe_synth.dummy_tool, att=
r, 1,
> > +     return perf_event__synthesize_attr(arm_spe_synth.dummy_tool, attr=
, 1,
>
> Passing a pointer to an object that doesn't exist there is NAK IMO

Not disagreeing but I think it is at least more intention revealing
and efficient than passing a struct that isn't initialized because we
know the tool won't be used.

> It would be better to just write another version of
> perf_event__synthesize_attr().

I think we've gotten ourselves into this mess because we're doing poor
man's OO and we're trying to pass values via a tools/container_of
rather than just pass a value. I'm not keen on making this change
larger but I'll see if this can be done and we just explicitly pass
some "void* data" like value.

Thanks,
Ian

> >                                          &id, arm_spe_event_synth);
> >  }
> >
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index 32818bd7cd17..9fd2967d4e3f 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -1596,8 +1596,8 @@ static int cs_etm__synth_branch_sample(struct cs_=
etm_queue *etmq,
> >  }
> >
> >  struct cs_etm_synth {
> > -     struct perf_tool dummy_tool;
> >       struct perf_session *session;
> > +     struct perf_tool dummy_tool[0];
> >  };
> >
> >  static int cs_etm__event_synth(struct perf_tool *tool,
> > @@ -1606,7 +1606,7 @@ static int cs_etm__event_synth(struct perf_tool *=
tool,
> >                              struct machine *machine __maybe_unused)
> >  {
> >       struct cs_etm_synth *cs_etm_synth =3D
> > -                   container_of(tool, struct cs_etm_synth, dummy_tool)=
;
> > +                   container_of(tool, struct cs_etm_synth, dummy_tool[=
0]);
> >
> >       return perf_session__deliver_synth_event(cs_etm_synth->session,
> >                                                event, NULL);
> > @@ -1620,7 +1620,7 @@ static int cs_etm__synth_event(struct perf_sessio=
n *session,
> >       memset(&cs_etm_synth, 0, sizeof(struct cs_etm_synth));
> >       cs_etm_synth.session =3D session;
> >
> > -     return perf_event__synthesize_attr(&cs_etm_synth.dummy_tool, attr=
, 1,
> > +     return perf_event__synthesize_attr(cs_etm_synth.dummy_tool, attr,=
 1,
> >                                          &id, cs_etm__event_synth);
> >  }
> >
> > diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
> > index ec1b3bd9f530..fb8fec3a3c36 100644
> > --- a/tools/perf/util/intel-bts.c
> > +++ b/tools/perf/util/intel-bts.c
> > @@ -738,8 +738,8 @@ static bool intel_bts_evsel_is_auxtrace(struct perf=
_session *session,
> >  }
> >
> >  struct intel_bts_synth {
> > -     struct perf_tool dummy_tool;
> >       struct perf_session *session;
> > +     struct perf_tool dummy_tool[0];
> >  };
> >
> >  static int intel_bts_event_synth(struct perf_tool *tool,
> > @@ -748,7 +748,7 @@ static int intel_bts_event_synth(struct perf_tool *=
tool,
> >                                struct machine *machine __maybe_unused)
> >  {
> >       struct intel_bts_synth *intel_bts_synth =3D
> > -                     container_of(tool, struct intel_bts_synth, dummy_=
tool);
> > +                     container_of(tool, struct intel_bts_synth, dummy_=
tool[0]);
> >
> >       return perf_session__deliver_synth_event(intel_bts_synth->session=
,
> >                                                event, NULL);
> > @@ -762,7 +762,7 @@ static int intel_bts_synth_event(struct perf_sessio=
n *session,
> >       memset(&intel_bts_synth, 0, sizeof(struct intel_bts_synth));
> >       intel_bts_synth.session =3D session;
> >
> > -     return perf_event__synthesize_attr(&intel_bts_synth.dummy_tool, a=
ttr, 1,
> > +     return perf_event__synthesize_attr(intel_bts_synth.dummy_tool, at=
tr, 1,
> >                                          &id, intel_bts_event_synth);
> >  }
> >
> > diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> > index d6d7b7512505..b8b90773baa2 100644
> > --- a/tools/perf/util/intel-pt.c
> > +++ b/tools/perf/util/intel-pt.c
> > @@ -3660,8 +3660,8 @@ static int intel_pt_queue_data(struct perf_sessio=
n *session,
> >  }
> >
> >  struct intel_pt_synth {
> > -     struct perf_tool dummy_tool;
> >       struct perf_session *session;
> > +     struct perf_tool dummy_tool[0];
> >  };
> >
> >  static int intel_pt_event_synth(struct perf_tool *tool,
> > @@ -3670,7 +3670,7 @@ static int intel_pt_event_synth(struct perf_tool =
*tool,
> >                               struct machine *machine __maybe_unused)
> >  {
> >       struct intel_pt_synth *intel_pt_synth =3D
> > -                     container_of(tool, struct intel_pt_synth, dummy_t=
ool);
> > +                     container_of(tool, struct intel_pt_synth, dummy_t=
ool[0]);
> >
> >       return perf_session__deliver_synth_event(intel_pt_synth->session,=
 event,
> >                                                NULL);
> > @@ -3687,8 +3687,7 @@ static int intel_pt_synth_event(struct perf_sessi=
on *session, const char *name,
> >
> >       memset(&intel_pt_synth, 0, sizeof(struct intel_pt_synth));
> >       intel_pt_synth.session =3D session;
> > -
> > -     err =3D perf_event__synthesize_attr(&intel_pt_synth.dummy_tool, a=
ttr, 1,
> > +     err =3D perf_event__synthesize_attr(intel_pt_synth.dummy_tool, at=
tr, 1,
> >                                         &id, intel_pt_event_synth);
> >       if (err)
> >               pr_err("%s: failed to synthesize '%s' event type\n",
> > diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpums=
f.c
> > index 6fe478b0b61b..4ec583e511af 100644
> > --- a/tools/perf/util/s390-cpumsf.c
> > +++ b/tools/perf/util/s390-cpumsf.c
> > @@ -952,11 +952,6 @@ s390_cpumsf_process_event(struct perf_session *ses=
sion,
> >       return err;
> >  }
> >
> > -struct s390_cpumsf_synth {
> > -     struct perf_tool cpumsf_tool;
> > -     struct perf_session *session;
> > -};
>
> Should really be a separate patch
>
> > -
> >  static int
> >  s390_cpumsf_process_auxtrace_event(struct perf_session *session,
> >                                  union perf_event *event __maybe_unused=
,
>
