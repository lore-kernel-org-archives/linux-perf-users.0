Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30801190041
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719424483; cv=none; b=RTXfIaasW6p1i7kpn2PqwGclh+F+TrR6dLlSig4/FIi+loWMUl0EsBWEwqUCpALufeUy8WzOWzhkUnSjGvslkGpgyJQZTf4227J9fpYqHFUY3umdgbquZe/mMzua7u+aCsxz3Mq5v/yeSFSyITxb0GBmVPVTRSkaY4Q0jQAk0ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719424483; c=relaxed/simple;
	bh=NpJ4BPBkKJdJw5Y/ot+EN82S5mgaVWnCyJLfXRZCT0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bHkSbEVCszwR21i5bf/4DiXpSiDWDqzYYSPTR0owEX6jMS1ndABKjgBBIV5M9/PF6xQIueHutopzfXAIybuAWY6NdST2N9i229Iv7bxI3NYFYZiy9+RtajzMsZqgJoxG6P/3vZmbhwRXVLyrUIp3Jr1ver8bMvARtANbn9Stl3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Whkfhyie; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Whkfhyie"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fa4b332645so14165ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 10:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719424481; x=1720029281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYtVsYGCKSGFp564m/cK3npuIheFgJEfN+GtE4ZdGYg=;
        b=WhkfhyieQcT1/BBTuIcGg0cAs1C0Oci1PDwWy4CI7Szwc/85Ev0awx2k0vVPYD7j+M
         +/pDmmgwYd/WqQ6bGf2HMMf4Vo6VCfbuMhgmwvVYsKxEE57a2wtSIbH6jR65eOVAqAul
         0xr/9UIE40K7ogR9YLYytEnz3VzBzRgD6fqnz4dpFea+07eUQ5SZJt1uVyaCZEGSFU0s
         IbFYQ5Ai5uSyHnHllc0keDSnCK3ojcqc/+xrRRooFsl2BZxqaex2oIXxqLTOVwkW8dEQ
         qyS5JEmGuenv0qhVX5l4r0SXKfJD7f6I0F2LSwUxWRP10so0TwLU04mDOhJxJZJ5fGye
         fB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719424481; x=1720029281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYtVsYGCKSGFp564m/cK3npuIheFgJEfN+GtE4ZdGYg=;
        b=SBnmLdgQRg44gMxkleIo8oDonVylF5f6Fncdd/HVXAAX8m0SSXcPRThnfQ0jFPSPPw
         o0qZT2c4FVeXo9enaQ2/2tITCgEEEELpGR5jTMXFSSL7WqDdIrp4neHTzauLV4JLSw4j
         +23L1afFFR1Htf2Fya+a+r+w3YGIMOVy9MyWABIGWIgdyfz0Qw1IqbIwv5+G02l1IWid
         B+eEId/6yoF9s5ZsKrNBvsMxwADOrqdfcjx5s9/8TUZo8Dp2iNg+HzhvFUy1sJbjiEuC
         5Nq6cCHPUSkh54yBJp7upojKrU83Bh0giAXLsFE0Y+Na4k75WpgoLDS53I2kuwgHus2Z
         se/Q==
X-Forwarded-Encrypted: i=1; AJvYcCULBx4qv0Nq9azeep/e2525Tee7bvLVcCerBknMGQqYE8tW4spKFBA6vqavR21C7WxacmMtx3doYGqmRoXZ80pVS47SrUxHTyDNFmDs8HKqaw==
X-Gm-Message-State: AOJu0YxHhdsKcGrQyQpZq9P3WgS2/ZhVfM/j+xcq7NalZHYz6GOGarak
	Ef2wAb6NTlsOR/SzQyFEmpl8fO2QPgeAbeg80kej30jeTXuRs8QKftF+8pr3KfUbLwY/50Myjwn
	lVVinEJo3b8k0VdTfqI/QdlEwJRslx8clixvL
X-Google-Smtp-Source: AGHT+IGieZVxei+XenSBSlW2OjSxqp5rr76yty+PEqZWIQyW0UvtPoeK77Fwl/PRbXsGS7q3Ie5pflexoGJ6ELa24xE=
X-Received: by 2002:a17:903:44c:b0:1f2:fefc:e8e7 with SMTP id
 d9443c01a7336-1faa98f034cmr351105ad.2.1719424480599; Wed, 26 Jun 2024
 10:54:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625172603.900667-1-irogers@google.com> <20240625172603.900667-23-irogers@google.com>
 <5db205f3-550f-4b9b-8bf4-aaa8054043aa@intel.com>
In-Reply-To: <5db205f3-550f-4b9b-8bf4-aaa8054043aa@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 26 Jun 2024 10:54:07 -0700
Message-ID: <CAP-5=fVK6w3Ck_F0gEPrSt6-UuAVUruLmnutJa=LbMO+MxazNg@mail.gmail.com>
Subject: Re: [PATCH v1 22/26] perf auxevent: Add explicit dummy tool initialization
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

On Tue, Jun 25, 2024 at 11:59=E2=80=AFPM Adrian Hunter <adrian.hunter@intel=
.com> wrote:
>
> On 25/06/24 20:25, Ian Rogers wrote:
> > Ensure tool is initialized to avoid lazy initialization pattern so
> > that more uses of struct perf_tool can be made const.
>
> This does not look necessary.
>
> The dummy tool is not used, and is not subject to lazy initialization,
> so the existing initialization to zero is fine.

Thanks, I wonder if we should try to save space in this case with
something like:

```
struct intel_pt_synth {
  struct perf_session *session;
  struct perf_tool dummy_tool[0];
};
```

I'll play around while dropping the initialization calls.

Thanks,
Ian

> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/arm-spe.c     | 1 +
> >  tools/perf/util/cs-etm.c      | 1 +
> >  tools/perf/util/intel-bts.c   | 1 +
> >  tools/perf/util/intel-pt.c    | 2 +-
> >  tools/perf/util/s390-cpumsf.c | 1 -
> >  5 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> > index 70bad18c4a0d..06a198b2f483 100644
> > --- a/tools/perf/util/arm-spe.c
> > +++ b/tools/perf/util/arm-spe.c
> > @@ -1097,6 +1097,7 @@ static int arm_spe_synth_event(struct perf_sessio=
n *session,
> >
> >       memset(&arm_spe_synth, 0, sizeof(struct arm_spe_synth));
> >       arm_spe_synth.session =3D session;
> > +     perf_tool__init(&arm_spe_synth.dummy_tool, /*ordered_events=3D*/f=
alse);
> >
> >       return perf_event__synthesize_attr(&arm_spe_synth.dummy_tool, att=
r, 1,
> >                                          &id, arm_spe_event_synth);
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index 231cd833c012..02eb5b3eed14 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -1619,6 +1619,7 @@ static int cs_etm__synth_event(struct perf_sessio=
n *session,
> >
> >       memset(&cs_etm_synth, 0, sizeof(struct cs_etm_synth));
> >       cs_etm_synth.session =3D session;
> > +     perf_tool__init(&cs_etm_synth.dummy_tool, /*ordered_events=3D*/fa=
lse);
> >
> >       return perf_event__synthesize_attr(&cs_etm_synth.dummy_tool, attr=
, 1,
> >                                          &id, cs_etm__event_synth);
> > diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
> > index 779982c478e0..ae97109542be 100644
> > --- a/tools/perf/util/intel-bts.c
> > +++ b/tools/perf/util/intel-bts.c
> > @@ -761,6 +761,7 @@ static int intel_bts_synth_event(struct perf_sessio=
n *session,
> >
> >       memset(&intel_bts_synth, 0, sizeof(struct intel_bts_synth));
> >       intel_bts_synth.session =3D session;
> > +     perf_tool__init(&intel_bts_synth.dummy_tool, /*ordered_events=3D*=
/false);
> >
> >       return perf_event__synthesize_attr(&intel_bts_synth.dummy_tool, a=
ttr, 1,
> >                                          &id, intel_bts_event_synth);
> > diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> > index bed35029e1f6..48ed60e521ed 100644
> > --- a/tools/perf/util/intel-pt.c
> > +++ b/tools/perf/util/intel-pt.c
> > @@ -3687,7 +3687,7 @@ static int intel_pt_synth_event(struct perf_sessi=
on *session, const char *name,
> >
> >       memset(&intel_pt_synth, 0, sizeof(struct intel_pt_synth));
> >       intel_pt_synth.session =3D session;
> > -
> > +     perf_tool__init(&intel_pt_synth.dummy_tool, /*ordered_events=3D*/=
false);
> >       err =3D perf_event__synthesize_attr(&intel_pt_synth.dummy_tool, a=
ttr, 1,
> >                                         &id, intel_pt_event_synth);
> >       if (err)
> > diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpums=
f.c
> > index 5834bad6ac0f..eb835e531cd6 100644
> > --- a/tools/perf/util/s390-cpumsf.c
> > +++ b/tools/perf/util/s390-cpumsf.c
> > @@ -953,7 +953,6 @@ s390_cpumsf_process_event(struct perf_session *sess=
ion,
> >  }
> >
> >  struct s390_cpumsf_synth {
> > -     struct perf_tool cpumsf_tool;
> >       struct perf_session *session;
> >  };
> >
>
