Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA26215F41
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Nov 2024 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730999997; cv=none; b=i49PGUfImj1DocJpqAQmrKDlUOXLDXVdaZKSK9xZDR6wYUWzsgwmLfQCz3Muq0lOdQR8hAX+zCpLJ1slZx11Yx1THnZVJSC+LjG8Ue/muF/z/q7R+M3TeioNjBgczW8SNC3mXT+uE7+qRPcD677PMhBDVsMeikvhrA9ymhsf9Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730999997; c=relaxed/simple;
	bh=JTPuW4PZyq89fLpBrtc/ssCzFTqf4qKDjVoaJe+kTjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YTJPvtJBOHFGSza2AHNfytPKZe3lRVZRB+R14asFjJPUevOBOrYwb6l1+fi94Pu8C8ILTLx/EVt2ivYqIdOMEhcCEA9fRJmmWjzOM0LPaWyV5EveAWhoLlLo59Sw4ZjyshWM766m1zUqumrIk8LnS80LEnw32HLCRUI8GEau7vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GpO/v9Fa; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GpO/v9Fa"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a6c3bdbebcso283935ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Nov 2024 09:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730999995; x=1731604795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8Pmfgs/0v+XbFp50mKYzJUI7uvNg0hCPjGC3BVtEAA=;
        b=GpO/v9FanojaJuAsqtiJFY6mfw8nLcexTTjKwehuwQ47T88iMukAegThvTeFa4kgGF
         j44alqTmQvobQ5qKWG3s1jIy34dg9jCgMDIjYFZTH5kSggh2c7Y8RlsWbXoRBXlI857l
         87AmDOzRRqTGgH5dXqU3lMd/FqpOZL3h9W7+Tl2xLSObePltYOLHzr+IZ6DuL+AqDyLn
         UpEmBWC3Ibs7u/k4DaxOBL8r+82WGUxlsIt2jybqlRhd7yfsKSSilcafk1tBpAuBTg2w
         Fhq/GbjLto3IYy/W4UPamJPL//Royqi5GyIqBHOtLdnPFDmKLAeK37aXov3Srbvqptr/
         wVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730999995; x=1731604795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8Pmfgs/0v+XbFp50mKYzJUI7uvNg0hCPjGC3BVtEAA=;
        b=ctkNWfIXzBRvG3fAD2osKQKIuyk2BLONXBp/G7eYRb9KeP2dUjpHee8GY2Wh0inO7a
         hTdg0PeCXXjYvButJU4tTpb3KQ+J/oWRSvrWXhAGu2FfUh2u7wdRrGy4Z4CpW/f2+Jyw
         I+cZDF0pGV1Dejhds34MEVCz+vesVCEfywKxERwIeKF4WYz2DjVIjL+eTFrr7GYAqs5z
         IrYBwM32ihW9Pr6Ir5kmsQP8lHbyOelD94rsNoGbh/R+3T9AqNIWVNNm1gcszdWbR7D1
         vr72s3gOEUJ5AM7y8HkoH0MGcdAiki2CciNSgO6EFPpeesbycfajGVIPjL5kTiFpJ+i9
         E2/g==
X-Forwarded-Encrypted: i=1; AJvYcCV+Ay4MQNnG9YdITWIWVAFGFEQxuJpV2iXtE5pMr0oJ0RkXCMN3c57UIhhuxRvC63kkDhLrWL4T/Acfo72p8/57@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp9wCg/eJ4ma8C+Wh4L9wmBFXJRx035O0Nm6CbEe53QL6fLKUF
	dQHbcOjuHLYOQof2MTrUXVXKoFVGr27JfkwF9hpwV8FuuZj6yTUtjq4egxtb+7dPPdesP0/Dkt+
	M9sx18w32/GDi34eglNTebQe2nHtSGeZ+HzhA
X-Gm-Gg: ASbGncuQiouj2CFd45EFW2WqAGez9X+RpMG50VudV2jGHlmHbTpWWY2YTs/t6ttG7Ii
	XNNjHntHZukaqx8Ylsh3tL0GtAKSDssXPJ3dtZ56vbPWODHU/m7UuwV8toWsztM4=
X-Google-Smtp-Source: AGHT+IHaS+JTHy0Vg1p9y3j9GDZO2w//PgmlhtK3jCyBjRM3bvzSq0AhNH1Xb/EebLokRXndkUGOf1Q+DpZInOKxiXI=
X-Received: by 2002:a05:6e02:20ce:b0:3a0:9ffd:2b7a with SMTP id
 e9e14a558f8ab-3a6e7a2daf7mr5600235ab.9.1730999994915; Thu, 07 Nov 2024
 09:19:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com> <20240926175035.408668-8-irogers@google.com>
 <20a6d424-c3a5-4fa9-b5d4-bcbe684a4a6f@linux.intel.com>
In-Reply-To: <20a6d424-c3a5-4fa9-b5d4-bcbe684a4a6f@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 7 Nov 2024 09:19:43 -0800
Message-ID: <CAP-5=fVwdaACaYCG8Jn-w+wHDNugcon8OiN9-mOAcXisVV5N0w@mail.gmail.com>
Subject: Re: [PATCH v4 07/22] perf jevents: Add br metric group for branch
 statistics on Intel
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 6:35=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
>
>
> On 2024-09-26 1:50 p.m., Ian Rogers wrote:
> > The br metric group for branches itself comprises metric groups for
> > total, taken, conditional, fused and far metric groups using json
> > events. Conditional taken and not taken metrics are specific to
> > Icelake and later generations, so the presence of the event is used to
> > determine whether the metric should exist.
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/pmu-events/intel_metrics.py | 138 +++++++++++++++++++++++++
> >  1 file changed, 138 insertions(+)
> >
> > diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-ev=
ents/intel_metrics.py
> > index 58e243695f0a..09f7b7159e7c 100755
> > --- a/tools/perf/pmu-events/intel_metrics.py
> > +++ b/tools/perf/pmu-events/intel_metrics.py
> > @@ -123,6 +123,143 @@ def Tsx() -> Optional[MetricGroup]:
> >    ], description=3D"Breakdown of transactional memory statistics")
> >
> >
> > +def IntelBr():
> > +  ins =3D Event("instructions")
> > +
> > +  def Total() -> MetricGroup:
> > +    br_all =3D Event ("BR_INST_RETIRED.ALL_BRANCHES", "BR_INST_RETIRED=
.ANY")
> > +    br_m_all =3D Event("BR_MISP_RETIRED.ALL_BRANCHES",
> > +                     "BR_INST_RETIRED.MISPRED",
> > +                     "BR_MISP_EXEC.ANY")
> > +    br_clr =3D None
> > +    try:
> > +      br_clr =3D Event("BACLEARS.ANY", "BACLEARS.ALL")
> > +    except:
> > +      pass
>
> There is no guarantee to the event name. It could be changed later.
> The renaming already occurred several times, even for architectural event=
s.
>
> I think we should test all events' presence, not just a few of them.

So the idea with the Event names is that we look for each name in turn
in the json, stopping with the first one we find. If none are found
then an exception is thrown. This means a typo can cause issues so we
also check that the event name exists in some json somewhere:
https://github.com/googleprodkernel/linux-perf/blob/google_tools_master/too=
ls/perf/pmu-events/metric.py#L89
I agree it isn't super perfect, we're dealing with strings, things can
be fragile..

> There could be some effort in the future to sync with the event list for
> each new generation and check if there is a renaming.

So the worst case is that a metric isn't present in a new generation,
then we update the script for a new event name and things will be
fixed. I think testing can keep this in check.

Thanks,
Ian

> Thanks,
> Kan
> > +
> > +    br_r =3D d_ratio(br_all, interval_sec)
> > +    ins_r =3D d_ratio(ins, br_all)
> > +    misp_r =3D d_ratio(br_m_all, br_all)
> > +    clr_r =3D d_ratio(br_clr, interval_sec) if br_clr else None
> > +
> > +    return MetricGroup("br_total", [
> > +        Metric("br_total_retired",
> > +               "The number of branch instructions retired per second."=
, br_r,
> > +               "insn/s"),
> > +        Metric(
> > +            "br_total_mispred",
> > +            "The number of branch instructions retired, of any type, t=
hat were "
> > +            "not correctly predicted as a percentage of all branch ins=
trucions.",
> > +            misp_r, "100%"),
> > +        Metric("br_total_insn_between_branches",
> > +               "The number of instructions divided by the number of br=
anches.",
> > +               ins_r, "insn"),
> > +        Metric("br_total_insn_fe_resteers",
> > +               "The number of resync branches per second.", clr_r, "re=
q/s"
> > +               ) if clr_r else None
> > +    ])
> > +
> > +  def Taken() -> MetricGroup:
> > +    br_all =3D Event("BR_INST_RETIRED.ALL_BRANCHES", "BR_INST_RETIRED.=
ANY")
> > +    br_m_tk =3D None
> > +    try:
> > +      br_m_tk =3D Event("BR_MISP_RETIRED.NEAR_TAKEN",
> > +                      "BR_MISP_RETIRED.TAKEN_JCC",
> > +                      "BR_INST_RETIRED.MISPRED_TAKEN")
> > +    except:
> > +      pass
> > +    br_r =3D d_ratio(br_all, interval_sec)
> > +    ins_r =3D d_ratio(ins, br_all)
> > +    misp_r =3D d_ratio(br_m_tk, br_all) if br_m_tk else None
> > +    return MetricGroup("br_taken", [
> > +        Metric("br_taken_retired",
> > +               "The number of taken branches that were retired per sec=
ond.",
> > +               br_r, "insn/s"),
> > +        Metric(
> > +            "br_taken_mispred",
> > +            "The number of retired taken branch instructions that were=
 "
> > +            "mispredicted as a percentage of all taken branches.", mis=
p_r,
> > +            "100%") if misp_r else None,
> > +        Metric(
> > +            "br_taken_insn_between_branches",
> > +            "The number of instructions divided by the number of taken=
 branches.",
> > +            ins_r, "insn"),
> > +    ])
> > +
> > +  def Conditional() -> Optional[MetricGroup]:
> > +    try:
> > +      br_cond =3D Event("BR_INST_RETIRED.COND",
> > +                      "BR_INST_RETIRED.CONDITIONAL",
> > +                      "BR_INST_RETIRED.TAKEN_JCC")
> > +      br_m_cond =3D Event("BR_MISP_RETIRED.COND",
> > +                        "BR_MISP_RETIRED.CONDITIONAL",
> > +                        "BR_MISP_RETIRED.TAKEN_JCC")
> > +    except:
> > +      return None
> > +
> > +    br_cond_nt =3D None
> > +    br_m_cond_nt =3D None
> > +    try:
> > +      br_cond_nt =3D Event("BR_INST_RETIRED.COND_NTAKEN")
> > +      br_m_cond_nt =3D Event("BR_MISP_RETIRED.COND_NTAKEN")
> > +    except:
> > +      pass
> > +    br_r =3D d_ratio(br_cond, interval_sec)
> > +    ins_r =3D d_ratio(ins, br_cond)
> > +    misp_r =3D d_ratio(br_m_cond, br_cond)
> > +    taken_metrics =3D [
> > +        Metric("br_cond_retired", "Retired conditional branch instruct=
ions.",
> > +               br_r, "insn/s"),
> > +        Metric("br_cond_insn_between_branches",
> > +               "The number of instructions divided by the number of co=
nditional "
> > +               "branches.", ins_r, "insn"),
> > +        Metric("br_cond_mispred",
> > +               "Retired conditional branch instructions mispredicted a=
s a "
> > +               "percentage of all conditional branches.", misp_r, "100=
%"),
> > +    ]
> > +    if not br_m_cond_nt:
> > +      return MetricGroup("br_cond", taken_metrics)
> > +
> > +    br_r =3D d_ratio(br_cond_nt, interval_sec)
> > +    ins_r =3D d_ratio(ins, br_cond_nt)
> > +    misp_r =3D d_ratio(br_m_cond_nt, br_cond_nt)
> > +
> > +    not_taken_metrics =3D [
> > +        Metric("br_cond_retired", "Retired conditional not taken branc=
h instructions.",
> > +               br_r, "insn/s"),
> > +        Metric("br_cond_insn_between_branches",
> > +               "The number of instructions divided by the number of no=
t taken conditional "
> > +               "branches.", ins_r, "insn"),
> > +        Metric("br_cond_mispred",
> > +               "Retired not taken conditional branch instructions misp=
redicted as a "
> > +               "percentage of all not taken conditional branches.", mi=
sp_r, "100%"),
> > +    ]
> > +    return MetricGroup("br_cond", [
> > +        MetricGroup("br_cond_nt", not_taken_metrics),
> > +        MetricGroup("br_cond_tkn", taken_metrics),
> > +    ])
> > +
> > +  def Far() -> Optional[MetricGroup]:
> > +    try:
> > +      br_far =3D Event("BR_INST_RETIRED.FAR_BRANCH")
> > +    except:
> > +      return None
> > +
> > +    br_r =3D d_ratio(br_far, interval_sec)
> > +    ins_r =3D d_ratio(ins, br_far)
> > +    return MetricGroup("br_far", [
> > +        Metric("br_far_retired", "Retired far control transfers per se=
cond.",
> > +               br_r, "insn/s"),
> > +        Metric(
> > +            "br_far_insn_between_branches",
> > +            "The number of instructions divided by the number of far b=
ranches.",
> > +            ins_r, "insn"),
> > +    ])
> > +
> > +  return MetricGroup("br", [Total(), Taken(), Conditional(), Far()],
> > +                     description=3D"breakdown of retired branch instru=
ctions")
> > +
> > +
> >  def main() -> None:
> >    global _args
> >
> > @@ -150,6 +287,7 @@ def main() -> None:
> >        Rapl(),
> >        Smi(),
> >        Tsx(),
> > +      IntelBr(),
> >    ])
> >
> >
>
