Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2941F1CF99
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 02:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709086390; cv=none; b=IU2V451e6Wm/YkFfEDC7KmbwEpkv3kelnSP5/kGVCWTD6YxuU/qFOLfUct9bXxk3cSLL4G1UaMVAdrTg7jc9TmdLvYiI+JKxzoTA28qjpo4zTicvtdCgsSKqv6/CKZQqEGL2UsVpdei5JWhriNP4PZ7ztYx+xmuM3LFfjbVgu2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709086390; c=relaxed/simple;
	bh=s+ISkT/YOrp26HW4SKUpdLOJ8xOayW/e8oiD6l9ay9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHX+k9Q7y936d5Ddb9niGrL528SlO6BEyy5tEmkL5erzMPGws8cJHPXNcIyp5XupyLAYtobPnR+P4CsmoQAzcra1JH0/BQ+eFQ1+IP3IH/u2RdRVjz1zd02RkP0zvitdBIqVr6aVY+e+IC9QL7m1M8jZmxHV/HSRU1TNP8GIUsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dEyvM/Fr; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dEyvM/Fr"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dc929e5d99so57555ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Feb 2024 18:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709086387; x=1709691187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbXqEz2vehFLearyt8Qtrm4m+uvH3d0MwaKwIO9Qv3g=;
        b=dEyvM/FrvZY50v1UQpKhgvQITj71bQTxo7ZVnK0KT6QctHMzxuo4hBpV1rFtRHiUdf
         9dIp9LNi549Itb/kyKBLWFRIaImHHJHVMrFfCLeSV8UdCrs3kYizqqh8zN+8BPzDKQft
         p7cwEd9kLv4Qd09r7zlonOH8GakatAbeCPw5q86LfeySDTl91Lk1e0Mvgy9YFahmQJa4
         DWskocVorb9gZhFG/m8T4L0wGoUZGpioMhImIydhZamej7jROYVYzcdMGnL4DiHOL0+i
         g/9opXtavcZNNP8kybOO9dALhJFo7YDIDe/tou8u8RaJc6szilS0rcWOXTrsvSObJ6+z
         30Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709086387; x=1709691187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbXqEz2vehFLearyt8Qtrm4m+uvH3d0MwaKwIO9Qv3g=;
        b=WMwlLUZEZgEtAsHOxmpOkk2D0ZsTQCWiVHSUUtgWPF/T1T2/eIq7zXRVtJOcs1Mp1R
         nsWlgHcwcjGVZBeGs6ffkyUfQeoKtbfedvBawqOjc2QTAcSd8I1d0QZN0Ch0TizA/yP0
         2OpBP3Ce+vtaEcGLw1suCAOUvJUU5NCJXTTNJG53k7U46iNnxBQyrv9ICjP9UG74scG6
         mIYkNLlKljntAc+AHy2nbI0DTzbuBbvH/giwWhJSF3/gtD8BrLszC2iK5ihPPMppZp+e
         JbT2LHEpuFpI/wA6Lz6J2T9OX9CHbvw2FUB9ptQGwsttpL7VjWCR6ZllQhf+PKgEdibJ
         EbJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBiPGKz8mU65OTbcBi+GfVvtbPBAE/MCyxM6gPO6TU0EOaIDgwZbmhaJTKd/tVquPq08Bk5sEX7vl/PQ/NHQG9//pdanFSjUH3M94RqWw3nA==
X-Gm-Message-State: AOJu0Yw2wAu8o6N3xdZtQhB2SHgn/fXfzsT+p0DkOV+6sw7MzTOHQKLE
	rSGyMaE4RmB8i7D9OQo7aoslSwdommMyFz+iQ6//rGSvH+k1lFxVZ6Q02gPIWRmfP1NrE9322mR
	r1hC2m1IL20hfuSSCM90DpXQkWChR3nI7KT8d
X-Google-Smtp-Source: AGHT+IHPwvaTxpFjdMx1YPkq7viSzgBVItHpDsFeqO8/CFOCiFULD0axV0Bz072VNsoWGIbw0nG0hLJupfwCYUa5+/A=
X-Received: by 2002:a17:902:8203:b0:1db:90dd:2939 with SMTP id
 x3-20020a170902820300b001db90dd2939mr18793pln.23.1709086386994; Tue, 27 Feb
 2024 18:13:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226201517.3540187-1-irogers@google.com> <0b2ff06f-099c-424a-97b5-fdf638892e41@linux.intel.com>
In-Reply-To: <0b2ff06f-099c-424a-97b5-fdf638892e41@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 27 Feb 2024 18:12:52 -0800
Message-ID: <CAP-5=fVTOgOO=N7uf4CaANWu+WCCLXXMuNBnDdBOP3E6vijG_A@mail.gmail.com>
Subject: Re: [PATCH v1] perf vendor events intel: Add umasks to PCU events.
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 6:12=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-02-26 3:15 p.m., Ian Rogers wrote:
> > UMasks were being dropped leading to all PCU
> > UNC_P_POWER_STATE_OCCUPANCY events having the same encoding. Don't
> > drop the umask trying to be consistent with other sources of events
> > like libpfm4 [1]. This applies the change from [2].
> >
> > [1] https://sourceforge.net/p/perfmon2/libpfm4/ci/master/tree/lib/event=
s/intel_skx_unc_pcu_events.h#l30
> > [2] https://github.com/captain5050/perfmon/commit/661a229996493448095fb=
55415ed568ceabc631b
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
>
> Thanks Ian.
>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>
> Thanks,
> Kan
>
> >  tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json  | 3 +++
> >  tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json   | 3 +++
> >  tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json | 3 +++
> >  tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json     | 3 +++
> >  tools/perf/pmu-events/arch/x86/icelakex/uncore-power.json     | 3 +++
> >  tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json      | 3 +++
> >  tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json     | 3 +++
> >  tools/perf/pmu-events/arch/x86/skylakex/uncore-power.json     | 3 +++
> >  tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json   | 3 +++
> >  9 files changed, 27 insertions(+)
> >
> > diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.js=
on b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
> > index 83d20130c217..9a0bc34c08e1 100644
> > --- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
> > +++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
> > @@ -396,6 +396,7 @@
> >          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
> >          "PerPkg": "1",
> >          "PublicDescription": "This is an occupancy event that tracks t=
he number of cores that are in the chosen C-State.  It can be used by itsel=
f to get the average number of cores in that C-state with thresholding to g=
enerate histograms, or with other PCU events and occupancy triggering to ca=
pture other details.",
> > +        "UMask": "0x40",
> >          "Unit": "PCU"
> >      },
> >      {
> > @@ -404,6 +405,7 @@
> >          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
> >          "PerPkg": "1",
> >          "PublicDescription": "This is an occupancy event that tracks t=
he number of cores that are in the chosen C-State.  It can be used by itsel=
f to get the average number of cores in that C-state with thresholding to g=
enerate histograms, or with other PCU events and occupancy triggering to ca=
pture other details.",
> > +        "UMask": "0x80",
> >          "Unit": "PCU"
> >      },
> >      {
> > @@ -412,6 +414,7 @@
> >          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
> >          "PerPkg": "1",
> >          "PublicDescription": "This is an occupancy event that tracks t=
he number of cores that are in the chosen C-State.  It can be used by itsel=
f to get the average number of cores in that C-state with thresholding to g=
enerate histograms, or with other PCU events and occupancy triggering to ca=
pture other details.",
> > +        "UMask": "0xc0",
> >          "Unit": "PCU"
> >      },
> >      {
> > diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.jso=
n b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
> > index 83d20130c217..9a0bc34c08e1 100644
> > --- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
> > +++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
> > @@ -396,6 +396,7 @@
> >          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
> >          "PerPkg": "1",
> >          "PublicDescription": "This is an occupancy event that tracks t=
he number of cores that are in the chosen C-State.  It can be used by itsel=
f to get the average number of cores in that C-state with thresholding to g=
enerate histograms, or with other PCU events and occupancy triggering to ca=
pture other details.",
> > +        "UMask": "0x40",
> >          "Unit": "PCU"
> >      },
> >      {
> > @@ -404,6 +405,7 @@
> >          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
> >          "PerPkg": "1",
> >          "PublicDescription": "This is an occupancy event that tracks t=
he number of cores that are in the chosen C-State.  It can be used by itsel=
f to get the average number of cores in that C-state with thresholding to g=
enerate histograms, or with other PCU events and occupancy triggering to ca=
pture other details.",
> > +        "UMask": "0x80",
> >          "Unit": "PCU"
> >      },
> >      {
> > @@ -412,6 +414,7 @@
> >          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
> >          "PerPkg": "1",
> >          "PublicDescription": "This is an occupancy event that tracks t=
he number of cores that are in the chosen C-State.  It can be used by itsel=
f to get the average number of cores in that C-state with thresholding to g=
enerate histograms, or with other PCU events and occupancy triggering to ca=
pture other details.",
> > +        "UMask": "0xc0",
> >          "Unit": "PCU"
> >      },
> >      {
> > diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.j=
son b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json
> > index c6254af7a468..ceef46046488 100644
> > --- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json
> > +++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json
> > @@ -144,6 +144,7 @@
> >          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
> >          "PerPkg": "1",
> >          "PublicDescription": "This is an occupancy event that tracks t=
he number of cores that are in the chosen C-State.  It can be used by itsel=
f to get the average number of cores in that C-state with thresholding to g=
enerate histograms, or with other PCU events and occupancy triggering to ca=
pture other details.",
> > +        "UMask": "0x40",
> >          "Unit": "PCU"
> >      },
> >      {
> > @@ -152,6 +153,7 @@
> >          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
> >          "PerPkg": "1",
> >          "PublicDescription": "This is an occupancy event that tracks t=
he number of cores that are in the chosen C-State.  It can be used by itsel=
f to get the average number of cores in that C-state with thresholding to g=
enerate histograms, or with other PCU events and occupancy triggering to ca=
pture other details.",
> > +        "UMask": "0x80",
> >          "Unit": "PCU"
> >      },
> >      {
> > @@ -160,6 +162,7 @@
> >          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
> >          "PerPkg": "1",
> >          "PublicDescription": "This is an occupancy event that tracks t=
he number of cores that are in the chosen C-State.  It can be used by itsel=
f to get the average number of cores in that C-state with thresholding to g=
enerate histograms, or with other PCU events and occupancy triggering to ca=
pture other details.",
> > +        "UMask": "0xc0",
> >          "Unit": "PCU"
> >      },
> >      {
> > diff --git a/tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json =
b/tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json
> > index daebf1050acb..15097511cbd8 100644
> > --- a/tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json
> > +++ b/tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json
> > @@ -428,6 +428,7 @@
> >          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
> >          "PerPkg": "1",
> >          "PublicDescription": "This is an occupancy event that tracks t=
he number of cores that are in the chosen C-State.  It can be used by itsel=
f to get the average number of cores in that C-state with thresholding to g=
enerate histograms, or with other PCU events and occupancy triggering to ca=
pture other details.",
> > +        "UMask": "0x40",
> >          "Unit": "PCU"
> >      },
> >      {
> > @@ -436,6 +437,7 @@
> >          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
> >          "PerPkg": "1",
> >          "PublicDescription": "This is an occupancy event that tracks t=
he number of cores that are in the chosen C-State.  It can be used by itsel=
f to get the average number of cores in that C-state with thresholding to g=
enerate histograms, or with other PCU events and occupancy triggering to ca=
pture other details.",
> > +        "UMask": "0x80",
> >          "Unit": "PCU"
> >      },
> >      {
> > @@ -444,6 +446,7 @@
> >          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
> >          "PerPkg": "1",
> >          "PublicDescription": "This is an occupancy event that tracks t=
he number of cores that are in the chosen C-State.  It can be used by itsel=
f to get the average number of cores in that C-state with thresholding to g=
enerate histograms, or with other PCU events and occupancy triggering to ca=
pture other details.",
> > +        "UMask": "0xc0",
> >          "Unit": "PCU"
> >      },
> >      {
> > diff --git a/tools/perf/pmu-events/arch/x86/icelakex/uncore-power.json =
b/tools/perf/pmu-events/arch/x86/icelakex/uncore-power.json
> > index ee4dac6fc797..920cab6ffe37 100644
> > --- a/tools/perf/pmu-events/arch/x86/icelakex/uncore-power.json
> > +++ b/tools/perf/pmu-events/arch/x86/icelakex/uncore-power.json
> > @@ -151,6 +151,7 @@
> >          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
> >          "PerPkg": "1",
> >          "PublicDescription": "Number of cores in C-State : C0 and C1 :=
 This is an occupancy event that tracks the number of cores that are in the=
 chosen C-State.  It can be used by itself to get the average number of cor=
es in that C-state with thresholding to generate histograms, or with other =
PCU events and occupancy triggering to capture other details.",
> > +        "UMask": "0x40",
> >          "Unit": "PCU"
> >      },
> >      {
> > @@ -159,6 +160,7 @@
> >          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
> >          "PerPkg": "1",
> >          "PublicDescription": "Number of cores in C-State : C3 : This i=
s an occupancy event that tracks the number of cores that are in the chosen=
 C-State.  It can be used by itself to get the average number of cores in t=
hat C-state with thresholding to generate histograms, or with other PCU eve=
nts and occupancy triggering to capture other details.",
> > +        "UMask": "0x80",
> >          "Unit": "PCU"
> >      },
> >      {
> > @@ -167,6 +169,7 @@
> >          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
> >          "PerPkg": "1",
> >          "PublicDescription": "Number of cores in C-State : C6 and C7 :=
 This is an occupancy event that tracks the number of cores that are in the=
 chosen C-State.  It can be used by itself to get the average number of cor=
es in that C-state with thresholding to generate histograms, or with other =
PCU events and occupancy triggering to capture other details.",
> > +        "UMask": "0xc0",
> >          "Unit": "PCU"
> >      },
> >      {
> > diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json b=
/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
> > index 5df1ebfb89ea..4dac5810324b 100644
> > --- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
> > +++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
> > @@ -516,6 +516,7 @@
> >          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
> >          "PerPkg": "1",
> >          "PublicDescription": "This is an occupancy event that tracks t=
he number of cores that are in the chosen C-State.  It can be used by itsel=
f to get the average number of cores in that C-state with thresholding to g=
enerate histograms, or with other PCU events and occupancy triggering to ca=
pture other details.",
> > +        "UMask": "0x40",

There's something wrong on Ivytown, I don't see a umask format in uncore_pm=
u:
```
$ ls /sys/devices/uncore_pcu/format/
edge   filter_band0  filter_band2  occ_edge    occ_sel
event  filter_band1  filter_band3  occ_invert  thresh
```
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/x86/events/intel/uncore_snbep.c#n1606

It does exist for skylake though:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/x86/events/intel/uncore_snbep.c#n4145

Kan, what's the right way to deal with this?

Thanks,
Ian

> >          "Unit": "PCU"
> >      },
> >      {
> > @@ -524,6 +525,7 @@
> >          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
> >          "PerPkg": "1",
> >          "PublicDescription": "This is an occupancy event that tracks t=
he number of cores that are in the chosen C-State.  It can be used by itsel=
f to get the average number of cores in that C-state with thresholding to g=
enerate histograms, or with other PCU events and occupancy triggering to ca=
pture other details.",
> > +        "UMask": "0x80",
> >          "Unit": "PCU"
> >      },
> >      {
> > @@ -532,6 +534,7 @@
> >          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
> >          "PerPkg": "1",
> >          "PublicDescription": "This is an occupancy event that tracks t=
he number of cores that are in the chosen C-State.  It can be used by itsel=
f to get the average number of cores in that C-state with thresholding to g=
enerate histograms, or with other PCU events and occupancy triggering to ca=
pture other details.",
> > +        "UMask": "0xc0",
> >          "Unit": "PCU"
> >      },
> >      {
> > diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json =
b/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
> > index b3ee5d741015..a83e07dce947 100644
> > --- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
> > +++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
> > @@ -235,6 +235,7 @@
> >          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
> >          "PerPkg": "1",
> >          "PublicDescription": "This is an occupancy event that tracks t=
he number of cores that are in C0.  It can be used by itself to get the ave=
rage number of cores in C0, with thresholding to generate histograms, or wi=
th other PCU events and occupancy triggering to capture other details.",
> > +        "UMask": "0x40",
> >          "Unit": "PCU"
> >      },
> >      {
> > @@ -243,6 +244,7 @@
> >          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
> >          "PerPkg": "1",
> >          "PublicDescription": "This is an occupancy event that tracks t=
he number of cores that are in C0.  It can be used by itself to get the ave=
rage number of cores in C0, with thresholding to generate histograms, or wi=
th other PCU events and occupancy triggering to capture other details.",
> > +        "UMask": "0x80",
> >          "Unit": "PCU"
> >      },
> >      {
> > @@ -251,6 +253,7 @@
> >          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
> >          "PerPkg": "1",
> >          "PublicDescription": "This is an occupancy event that tracks t=
he number of cores that are in C0.  It can be used by itself to get the ave=
rage number of cores in C0, with thresholding to generate histograms, or wi=
th other PCU events and occupancy triggering to capture other details.",
> > +        "UMask": "0xc0",
> >          "Unit": "PCU"
> >      },
> >      {
> > diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-power.json =
b/tools/perf/pmu-events/arch/x86/skylakex/uncore-power.json
> > index c6254af7a468..ceef46046488 100644
> > --- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-power.json
> > +++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-power.json
> > @@ -144,6 +144,7 @@
> >          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
> >          "PerPkg": "1",
> >          "PublicDescription": "This is an occupancy event that tracks t=
he number of cores that are in the chosen C-State.  It can be used by itsel=
f to get the average number of cores in that C-state with thresholding to g=
enerate histograms, or with other PCU events and occupancy triggering to ca=
pture other details.",
> > +        "UMask": "0x40",
> >          "Unit": "PCU"
> >      },
> >      {
> > @@ -152,6 +153,7 @@
> >          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
> >          "PerPkg": "1",
> >          "PublicDescription": "This is an occupancy event that tracks t=
he number of cores that are in the chosen C-State.  It can be used by itsel=
f to get the average number of cores in that C-state with thresholding to g=
enerate histograms, or with other PCU events and occupancy triggering to ca=
pture other details.",
> > +        "UMask": "0x80",
> >          "Unit": "PCU"
> >      },
> >      {
> > @@ -160,6 +162,7 @@
> >          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
> >          "PerPkg": "1",
> >          "PublicDescription": "This is an occupancy event that tracks t=
he number of cores that are in the chosen C-State.  It can be used by itsel=
f to get the average number of cores in that C-state with thresholding to g=
enerate histograms, or with other PCU events and occupancy triggering to ca=
pture other details.",
> > +        "UMask": "0xc0",
> >          "Unit": "PCU"
> >      },
> >      {
> > diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.jso=
n b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json
> > index a61ffca2dfea..dcf268467db9 100644
> > --- a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json
> > +++ b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json
> > @@ -150,6 +150,7 @@
> >          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
> >          "PerPkg": "1",
> >          "PublicDescription": "Number of cores in C-State : C0 and C1 :=
 This is an occupancy event that tracks the number of cores that are in the=
 chosen C-State.  It can be used by itself to get the average number of cor=
es in that C-state with thresholding to generate histograms, or with other =
PCU events and occupancy triggering to capture other details.",
> > +        "UMask": "0x40",
> >          "Unit": "PCU"
> >      },
> >      {
> > @@ -158,6 +159,7 @@
> >          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
> >          "PerPkg": "1",
> >          "PublicDescription": "Number of cores in C-State : C3 : This i=
s an occupancy event that tracks the number of cores that are in the chosen=
 C-State.  It can be used by itself to get the average number of cores in t=
hat C-state with thresholding to generate histograms, or with other PCU eve=
nts and occupancy triggering to capture other details.",
> > +        "UMask": "0x80",
> >          "Unit": "PCU"
> >      },
> >      {
> > @@ -166,6 +168,7 @@
> >          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
> >          "PerPkg": "1",
> >          "PublicDescription": "Number of cores in C-State : C6 and C7 :=
 This is an occupancy event that tracks the number of cores that are in the=
 chosen C-State.  It can be used by itself to get the average number of cor=
es in that C-state with thresholding to generate histograms, or with other =
PCU events and occupancy triggering to capture other details.",
> > +        "UMask": "0xc0",
> >          "Unit": "PCU"
> >      },
> >      {
