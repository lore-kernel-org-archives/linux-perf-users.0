Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6149E2737F2
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Jan 2026 20:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769803665; cv=pass; b=uP8swTNF4bnQRELgPwmCgMsTpbnSAAnpeLJKZD/0S9raUSr54az6CBbocrowfR1n5Gujmk8XeShqj/ooiqbqkY312AyHyPgASgt4/Rs2VHiacIH93t/G80Kct8kUuaprq2PVA22mifuksOkiNuaiEuvFDQ8EaQGW3piZzE0Lg5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769803665; c=relaxed/simple;
	bh=JN6foRqG40JPLGE38gjlFr46l76oJx2SOKRwokKq1T8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0UNlnNxApQrkD5NehDer/SDJsE/Fc0EcNmP5oKN/OqiNex2txx6VUX0AyG3q/FZzVGTq5LUqnNQfwWO8rb0VLLENCQVatTJNkAZbkHE06OpPJ/Pi04+0U8ZhwBlYMVEs03/mNMvr+jolcCTirWPbEpUTOas8kgv5LkU35FEFs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ddyj3eEC; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ddyj3eEC"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a8e4ae61a0so15195ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jan 2026 12:07:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769803663; cv=none;
        d=google.com; s=arc-20240605;
        b=fpgA+Gt2N5qd+9FRAHGf+VTCm25PrTe22q3xDsaabIHgLJ5cQMFf3DlXspCRiJhgG4
         Y8BAZ6fTMxtyfE/DCuDqicQ92xzlxEILPMit0/IvtRKZ5wDoQzEGpECPxodLGG+z6VkZ
         9wJK0G7G25/pEcNr6qRwI8qJM0p6OJXpz+Rd7KJmmk0YyVV1WFZoY64nUy69msU5VNtp
         0yHDyFl4tN2VglzhFw077f4uYDetEclxiU7fLi4BjDgrtnpaiwc+r/EEW+nveYfr7GQM
         5O8fDRmxVfXA3vl2pPhNYQjh3ZBrOjZu+7KS/2MPd81oUoE4GdnErVjyFjdG+Dp5LooV
         3aIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xfZ/yn2sX+8CvDNrIoBnhlU34L/OaV7M5POjaoUPrSs=;
        fh=OCjgoy/IA5rUytOS7MbVJOBPtnp2wWAB2n7sq25A5wM=;
        b=kJYjeihSagG4GCvSjiTliWtH3MOiaeWc8ZCz3LgqyYYLL/L8w3QpNK+LXady8Hqz+e
         z6TQ8GkhgD1AS8soiXHrWjWW+FM5mTJ/3V4y4ds3plTCHWp4WpmRCVTxAugl1bzpIU+D
         fcf2ekTM9kztHDfgkMXLtt2I5topzCw470L71Ivju9T7oAj2Qbef8K1O+uArLjfjCjsz
         bc8Ty48IVGdMc9pCTk7POCVZ555p/M9rIK3DPznoDlA5jjIu4wBqZPPvaVvsCTm4EnJ+
         ggJzty39O+h2/+B4Fk6iUFUEZZ+EePDKPEqB6K1DSezBag5T3I/D4PUSrKUDLCW2d8Hj
         OP8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769803663; x=1770408463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfZ/yn2sX+8CvDNrIoBnhlU34L/OaV7M5POjaoUPrSs=;
        b=Ddyj3eECiWcQOxTCLGp6hMoD8PP3lJ96qZMoAclBiJX1T7IB4ZxawYb9iYSB9JabD6
         Za5nOiXNgPtaT3ei9icAHpSugQN2sSzXRBucBaey1xQnVcB93MjmbvABdAgT1BK6XZpT
         TMAEKNFbMy9XFqg/UWzJTDNjLH1Qk2p05mWehwa2uV9KiO/1VVegfCifQG2uAGCAdGxU
         4/pZ72zNbI7fFfHYRbcTPhBv6WFE0JWsxwTwcAZPL2d9DqI+xRaocJ9GvLc6vMmbUgs1
         4KnIYaZ/xvCwOCBOJE3e6vuygOal0KBInCcPPyFdPQurUqhHiisO94cCQv0VySPGN93B
         6glA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769803663; x=1770408463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xfZ/yn2sX+8CvDNrIoBnhlU34L/OaV7M5POjaoUPrSs=;
        b=ZfdWEhIvbsjsnDZV98x5GI6lJSkrwX7ZcQqfEFxfSa000SUYYl+9GY2whwB2kneYwG
         Hdd93efoq9mZdOIenRhVOn/NZdbCbKE1/tdsIvRZmIaaOYY7ikgG9WviSvXOz2r7DYM+
         Wlj85J61dB2057/SiBFikoeb0DQBFS9kqV6U1O2O2gZQgeGI/ntW1eue/Su1+ugv0E6b
         wIa5oEvXPw9n+/m4DWzN0n3aj9bFIvpQ/yl8j/V4c2mfx9aBkZqFwB8hflD1rqFlPXeJ
         LEd0jpJr3lq8fyLAzSVyRDvv0T6pKMf0pLHYUGqREwexE/PhczE+uT2Tx0/A+ntWsmOw
         fVGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmU+cFkttVeV2cANZ2j/kytrR4k/EMgJhBNT8Pxi5TFmTaIX5lHsYHQ0UNEyVVlD3V8GpFx+rJaiiQsF9/OqNz@vger.kernel.org
X-Gm-Message-State: AOJu0YzlMM5QQgAZpO4hEaHHHaefAHHD1XI9fuekCR/qYJ3a8nRP65Xb
	Qp7n7hAiCFp0PTZYe+JHzlvgVG1wW8UqZPCN5eWSo35oJfYMRR3UJ8Dbu5qEKhlBKJEZq/f6Sr0
	TqSX9X9KiaEOZRsBMba6iF5JPLkvL95SDc1AweV64
X-Gm-Gg: AZuq6aKAnEgtKSwra9lnieWG6q4DXa/hbIh1rrIAJTd+XpvZQDiHVEdzNuxhEjVQsTN
	C/HLxFtZLwoA8CtSx2fVMul/32fCiVp5MJxQEYw0wJfBhAazu2NLpKzGHzZU4Sg8s5DTmKGBUHA
	8Ga9X1bt6wE8ArGdyOyVHt4Z9TOW2l4LheHriqGCsE5sV1pj8hiRVd++m8q96GsVzj4UavdBaiZ
	RsgLPac0k6a3n9RLbfHcSFBL8fupVm2Ef7mVmtgqVKzkEofdgr0k1zXDBag8WDOq2xVgBumde+2
	cgYwG+/N1UxKvp383sA4e7UN
X-Received: by 2002:a17:903:3d07:b0:2a7:4151:2c74 with SMTP id
 d9443c01a7336-2a8f32da681mr397915ad.16.1769803662323; Fri, 30 Jan 2026
 12:07:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127225909.3296202-1-bwicaksono@nvidia.com>
 <CAP-5=fUxhbR1xs1f9mrkcUXZZNLrVqDG0ebhwW--WtgVRnNxNw@mail.gmail.com>
 <40988c57-ee6f-4693-afe4-2615dc43f395@linaro.org> <MW5PR12MB5681E958BDDCEB137E65CE54A09FA@MW5PR12MB5681.namprd12.prod.outlook.com>
In-Reply-To: <MW5PR12MB5681E958BDDCEB137E65CE54A09FA@MW5PR12MB5681.namprd12.prod.outlook.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 30 Jan 2026 12:07:31 -0800
X-Gm-Features: AZwV_QgiJyUG5mr0pnscOQIDv9TtdTed9GqfFQg3UrXw3XStpF8ShZ6gj_R5UHg
Message-ID: <CAP-5=fWB_nbnc6W9X-6iJH-ZasFriASOtduLjFLgY_exRKCqnQ@mail.gmail.com>
Subject: Re: [PATCH] perf vendor events arm64: Add Tegra410 Olympus PMU events
To: Besar Wicaksono <bwicaksono@nvidia.com>
Cc: James Clark <james.clark@linaro.org>, 
	"john.g.garry@oracle.com" <john.g.garry@oracle.com>, "will@kernel.org" <will@kernel.org>, 
	"mike.leach@linaro.org" <mike.leach@linaro.org>, "leo.yan@linux.dev" <leo.yan@linux.dev>, 
	"mark.rutland@arm.com" <mark.rutland@arm.com>, 
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, "jolsa@kernel.org" <jolsa@kernel.org>, 
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>, 
	"namhyung@kernel.org" <namhyung@kernel.org>, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Makin <tmakin@nvidia.com>, 
	Vikram Sethi <vsethi@nvidia.com>, Rich Wiley <rwiley@nvidia.com>, Sean Kelley <skelley@nvidia.com>, 
	Yifei Wan <YWan@nvidia.com>, Thierry Reding <treding@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>, 
	Matt Ochs <mochs@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 10:08=E2=80=AFAM Besar Wicaksono <bwicaksono@nvidia=
.com> wrote:
>
> Thank you James and Ian for the comments.
> I will try to address the spelling mistakes on v2.
>
> Please see my other comments inline.
>
> > -----Original Message-----
> > From: James Clark <james.clark@linaro.org>
> > Sent: Wednesday, January 28, 2026 3:37 AM
> > To: Ian Rogers <irogers@google.com>; Besar Wicaksono
> > <bwicaksono@nvidia.com>
> > Cc: john.g.garry@oracle.com; will@kernel.org; mike.leach@linaro.org;
> > leo.yan@linux.dev; mark.rutland@arm.com;
> > alexander.shishkin@linux.intel.com; jolsa@kernel.org;
> > adrian.hunter@intel.com; peterz@infradead.org; mingo@redhat.com;
> > acme@kernel.org; namhyung@kernel.org; linux-tegra@vger.kernel.org; linu=
x-
> > arm-kernel@lists.infradead.org; linux-perf-users@vger.kernel.org; linux=
-
> > kernel@vger.kernel.org; Thomas Makin <tmakin@nvidia.com>; Vikram Sethi
> > <vsethi@nvidia.com>; Rich Wiley <rwiley@nvidia.com>; Sean Kelley
> > <skelley@nvidia.com>; Yifei Wan <ywan@nvidia.com>; Thierry Reding
> > <treding@nvidia.com>; Jon Hunter <jonathanh@nvidia.com>; Matt Ochs
> > <mochs@nvidia.com>
> > Subject: Re: [PATCH] perf vendor events arm64: Add Tegra410 Olympus PMU
> > events
> >
> > External email: Use caution opening links or attachments
> >
> >
> > On 28/01/2026 8:03 am, Ian Rogers wrote:
> > > On Tue, Jan 27, 2026 at 3:00=E2=80=AFPM Besar Wicaksono
> > <bwicaksono@nvidia.com> wrote:
> > >>
> > >> Add JSON files for NVIDIA Tegra410 Olympus core PMU events.
> > >> Also updated the common-and-microarch.json.
> > >>
> > >> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
> > >> ---
> > >>   .../arch/arm64/common-and-microarch.json      |  90 +++
> > >>   tools/perf/pmu-events/arch/arm64/mapfile.csv  |   1 +
> > >>   .../arch/arm64/nvidia/t410/branch.json        |  45 ++
> > >>   .../arch/arm64/nvidia/t410/brbe.json          |   6 +
> > >>   .../arch/arm64/nvidia/t410/bus.json           |  48 ++
> > >>   .../arch/arm64/nvidia/t410/exception.json     |  62 ++
> > >>   .../arch/arm64/nvidia/t410/fp_operation.json  |  78 ++
> > >>   .../arch/arm64/nvidia/t410/general.json       |  15 +
> > >>   .../arch/arm64/nvidia/t410/l1d_cache.json     | 122 +++
> > >>   .../arch/arm64/nvidia/t410/l1i_cache.json     | 114 +++
> > >>   .../arch/arm64/nvidia/t410/l2d_cache.json     | 134 ++++
> > >>   .../arch/arm64/nvidia/t410/ll_cache.json      | 107 +++
> > >>   .../arch/arm64/nvidia/t410/memory.json        |  46 ++
> > >>   .../arch/arm64/nvidia/t410/metrics.json       | 722
> > ++++++++++++++++++
> > >>   .../arch/arm64/nvidia/t410/misc.json          | 646 ++++++++++++++=
++
> > >>   .../arch/arm64/nvidia/t410/retired.json       |  94 +++
> > >>   .../arch/arm64/nvidia/t410/spe.json           |  42 +
> > >>   .../arm64/nvidia/t410/spec_operation.json     | 230 ++++++
> > >>   .../arch/arm64/nvidia/t410/stall.json         | 145 ++++
> > >>   .../arch/arm64/nvidia/t410/tlb.json           | 158 ++++
> > >>   20 files changed, 2905 insertions(+)
> > >>   create mode 100644 tools/perf/pmu-
> > events/arch/arm64/nvidia/t410/branch.json
> > >>   create mode 100644 tools/perf/pmu-
> > events/arch/arm64/nvidia/t410/brbe.json
> > >>   create mode 100644 tools/perf/pmu-
> > events/arch/arm64/nvidia/t410/bus.json
> > >>   create mode 100644 tools/perf/pmu-
> > events/arch/arm64/nvidia/t410/exception.json
> > >>   create mode 100644 tools/perf/pmu-
> > events/arch/arm64/nvidia/t410/fp_operation.json
> > >>   create mode 100644 tools/perf/pmu-
> > events/arch/arm64/nvidia/t410/general.json
> > >>   create mode 100644 tools/perf/pmu-
> > events/arch/arm64/nvidia/t410/l1d_cache.json
> > >>   create mode 100644 tools/perf/pmu-
> > events/arch/arm64/nvidia/t410/l1i_cache.json
> > >>   create mode 100644 tools/perf/pmu-
> > events/arch/arm64/nvidia/t410/l2d_cache.json
> > >>   create mode 100644 tools/perf/pmu-
> > events/arch/arm64/nvidia/t410/ll_cache.json
> > >>   create mode 100644 tools/perf/pmu-
> > events/arch/arm64/nvidia/t410/memory.json
> > >>   create mode 100644 tools/perf/pmu-
> > events/arch/arm64/nvidia/t410/metrics.json
> > >>   create mode 100644 tools/perf/pmu-
> > events/arch/arm64/nvidia/t410/misc.json
> > >>   create mode 100644 tools/perf/pmu-
> > events/arch/arm64/nvidia/t410/retired.json
> > >>   create mode 100644 tools/perf/pmu-
> > events/arch/arm64/nvidia/t410/spe.json
> > >>   create mode 100644 tools/perf/pmu-
> > events/arch/arm64/nvidia/t410/spec_operation.json
> > >>   create mode 100644 tools/perf/pmu-
> > events/arch/arm64/nvidia/t410/stall.json
> > >>   create mode 100644 tools/perf/pmu-
> > events/arch/arm64/nvidia/t410/tlb.json
> > >>
> > >> diff --git a/tools/perf/pmu-events/arch/arm64/common-and-
> > microarch.json b/tools/perf/pmu-events/arch/arm64/common-and-
> > microarch.json
> > >> index 468cb085d879..6af15776ff17 100644
> > >> --- a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
> > >> +++ b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
> > >> @@ -179,6 +179,11 @@
> > >>           "EventName": "BUS_CYCLES",
> > >>           "BriefDescription": "Bus cycle"
> > >>       },
> > >> +    {
> > >> +        "EventCode": "0x001E",
> > >> +        "EventName": "CHAIN",
> > >> +        "BriefDescription": "Chain a pair of event counters."
> > >> +    },
> > >
> > > Cool stuff :-)
> > >
> > > For wider counters AMD does something similar, but should this be an
> > > implementation detail rather than an exposed event? How does it
> > > operate as an event?
> > >
> >
> > CHAIN should be excluded from the json, it's used internally by the
> > driver when you want 64 bit counters. Userspace can't use it because it
> > can't control where counters are placed to make sure they're adjacent.
> >
>
> Sure, will address this in V2.
>
> > > [snip]
> > >> diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv
> > b/tools/perf/pmu-events/arch/arm64/mapfile.csv
> > >> index bb3fa8a33496..7f0eaa702048 100644
> > >> --- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
> > >> +++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
> > >> @@ -46,3 +46,4 @@
> > >>   0x00000000500f0000,v1,ampere/emag,core
> > >>   0x00000000c00fac30,v1,ampere/ampereone,core
> > >>   0x00000000c00fac40,v1,ampere/ampereonex,core
> > >> +0x000000004e0f0100,v1,nvidia/t410,core
> > >> diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/branch.jso=
n
> > b/tools/perf/pmu-events/arch/arm64/nvidia/t410/branch.json
> > >> new file mode 100644
> > >> index 000000000000..532bc59dc573
> > >> --- /dev/null
> > >> +++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/branch.json
> > >> @@ -0,0 +1,45 @@
> > >> +[
> > >> +    {
> > >> +        "ArchStdEvent": "BR_MIS_PRED",
> > >> +        "PublicDescription": "The Event counts Branches which are
> > speculatively executed and mis-predicted."
> > >
> > > nit: The capitalization on Event and Branches, as well as other words=
,
> > > is a little unusual.
> > >
> >
> > If there's nothing specific to this CPU then the public description
> > could be left out entierly. The common strings already say the same
> > thing as this:
> >
> >      {
> >          "PublicDescription": "Mispredicted or not predicted branch
> >                                speculatively executed",
> >          "EventCode": "0x10",
> >          "EventName": "BR_MIS_PRED",
> >          "BriefDescription": "Mispredicted or not predicted branch
> >                               speculatively executed"
> >      },
> >
> >
>
> I will check on this and other events.
>
> > > [snip]
> > >> diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/metrics.js=
on
> > b/tools/perf/pmu-events/arch/arm64/nvidia/t410/metrics.json
> > >> new file mode 100644
> > >> index 000000000000..18c2fd58ee9e
> > >> --- /dev/null
> > >> +++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/metrics.json
> > >> @@ -0,0 +1,722 @@
> > >> +[
> > >> +    {
> > >> +        "MetricName": "backend_bound",
> > >> +        "MetricExpr": "100 * (STALL_SLOT_BACKEND / CPU_SLOT)",
> > >> +        "BriefDescription": "This metric is the percentage of total=
 slots that
> > were stalled due to resource constraints in the backend of the processo=
r.",
> > >> +        "ScaleUnit": "1percent of slots",
> > >> +        "MetricGroup": "TopdownL1"
> > >
> > > Note, on x86 we place TopdownL1 in the Default metric group so it is
> > > shown by `perf stat` when it isn't given events or metrics to compute=
.
> > > Perhaps you want to do something similar?
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-
> > next.git/tree/tools/perf/pmu-events/arch/x86/icelake/icl-
> > metrics.json?h=3Dtmp.perf-tools-next#n116
> > >
> > > Thanks,
> > > Ian
> >
> > That's currently true for the Arm topdown metrics in sbsa.json, but we
> > probably don't actually want this because there aren't enough counters
> > for the perf stat defaults plus topdown and it results in multiplexing
> > and bad results.
> >
> > I was planning to change it but we also don't currently expose the
> > number of counters available either...
> >
>
> Agree with James, we may not be able to cover all the events in
> Default + TopdownL1 group.
>
> Ian, James, in general, is it fine to put some metrics in a same group be=
cause
> they are actually correlating even though it may cause multiplexing?
> For example, "Miss_Ratio" group in this patch provides miss ratio from L1=
, L2, TLB, etc.
> It's convenient to have this and get the miss ratio from all cache levels=
.
> There are many events needed for this group and it might not be accurate =
due to
> multiplexing, but user can get a (rough) broad view in the beginning.

These things are strings so there's no real rules for how they get
organized other than Default being a special name. For Intel topdown
there's a convention of having a _group as a suffix to allow some kind
of drill down. There's even some support in ilist.py for this:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/python/ilist.py?h=3Dperf-tools-next#n477
As writing json is painful there's code for generating metrics from
Python and that tries to structure metrics inside groups of groups:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/pmu-events/intel_metrics.py?h=3Dperf-tools-next#n264
My hope is that at some point this will allow some kind of pretty
printing of headers and the like.

Thanks,
Ian

> Thanks,
> Besar
