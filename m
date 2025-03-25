Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D706A25A349
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Mar 2025 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742915389; cv=none; b=M+pU2h7blofye+MY5mXSBhaDmoP9tWxWuISzu8XPQFCHn2mflHWvSbfrbABGs3cF2Rq3Q2jxDoXyxb4s/q0sGEQcwG0ak0wfARzxIpFiV4HSwB1h+W6u9NW1wGrylZqoGyeqFuji8GptvOa0Po/vOddVnP17fgMiFAIwf20Rr4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742915389; c=relaxed/simple;
	bh=adrV/Tb1NJvVkg7GbovqjunHFyvYZNN9pXpHCiYM3xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S0EyXnDIKzE4V5fLMk93JlZ4e6xcpHXY/YRTYlQxaOOmp+Tup+XFX/1583bJV/h64rgROhJXTI0TOGZGc9H2AmoEWBi0O8W7r7x5bkhFTTFi3CcAbHIVF24jxPWNqev0Ppye56z3EppR+0UZzjjDYBxIjlYtbyyXVlwAa7367hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ie3vFuTD; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ie3vFuTD"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2240aad70f2so275985ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Mar 2025 08:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742915387; x=1743520187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O25tyu9grQRrZmiolUDiiMq1n9JgUYAqthBzADNM90g=;
        b=ie3vFuTDetxGtaLSf6M2rooPtZd4zodDPvtVg4TJboEqlFtTLkTrgRhw7ZZI6fC0QL
         8xe4UdYrVMenMtXZTE8dIGUwYL1MmG5EhZEV4VVeU0QEYBH76mnwGXQoBEFXL/DzDZKQ
         seOlvcFZaDV71mn4txAjrH6/BGQrfeZsWetLgCW3stMf7CfQBtxKtES0geb5H0Qvh8zI
         W6sj5pDkq/UK6JpXj7fGZXlxllyXlJ9g+o9F1BB2LQ5tF6Z4T+16M6bTq8tCmXbnIPd6
         mn/xkkiUmnYQzYY1qcNzRkwM1Iaomkr1+RxldAWbSYp0h9snnKW/NCSkMdgWHDrh89na
         JTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742915387; x=1743520187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O25tyu9grQRrZmiolUDiiMq1n9JgUYAqthBzADNM90g=;
        b=bxkbbJKvVRZGKU71Rp892X3RRBQRxq3T5pirOUJyd9110Fb5jYDpicIn5QHQ+rRrlo
         i5cj4z1X+8h5Hr5CFEvEII76TnCjw8RK57fYtoqnry26jxksG7ZN1JKPLlqbCuCkqBls
         yo5URYOE9d6iuu3YQLLYfM8WDuLvkwKXXtXt+G1+cjSUR4wBHN/jR34KCr5rJV9bUez3
         9JtFSCMLlI88CiA/pEn3TblX4Ev3sngaQsQ4nrNyxRfNvyU5LL9CNVuTJd+yJuvWtMAD
         WbU3RIbKDtBM1i3NsWSZQZBFGJgnwbfCtsX+2jKfIJ/C9Gyxg3uXsdMHpqwWI19pSF/S
         HeWw==
X-Forwarded-Encrypted: i=1; AJvYcCXjMklOSHje4SEl7mOGKQGx7ftbZNNcpGgF/a6R/npsC/h/k7YzZ2/kCvcYFrqWZbCVVG2uh2KkRMsnUGg56c6J@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0JFHFI7tEJOtYtcuAWJE9nfU3pyhHbFK5uURHJtPcXuV0hu0D
	24igcB0EENyb+83ryTMTDkNg0njjXdVLa+3BBnH1GwBGf//Lw2G01Kr8BcxQ64dVBg694P8mZUB
	JS0+Z2krb1/Qi7kQQt317G2bTxNUKzoPfcCGS
X-Gm-Gg: ASbGncsZpZImD0mZQrFHObTyWNdpC/2HeFddvwcyMBdVMD3EglcKnuPBMRrDvXIONgl
	IZNI1Kr8o2uEy/AciETAcyhkaYtUjvVn3qrFMvBaypC1gWvWst7UU0uYviluvzAHv+Iu7TYm5Dn
	LQ2iWbj8/CX51H97K0mFjNQrj/40ikbgwaDSKOMDwOwIcSX+CHPpxfui8=
X-Google-Smtp-Source: AGHT+IGH02pIpw9ePhkURA/abBLjMSfBXIamJu/AUquADH/jXaYNbZMwBF8js8MWvLkmEh6Du9SL1Deh8tN2ZpBhOo0=
X-Received: by 2002:a17:902:ce11:b0:224:a93:704d with SMTP id
 d9443c01a7336-227982a7faamr7964675ad.2.1742915386672; Tue, 25 Mar 2025
 08:09:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250322063403.364981-1-irogers@google.com> <20250322063403.364981-4-irogers@google.com>
 <48eb46bce14d895b61560907cb7f0df9038df57d.camel@intel.com>
In-Reply-To: <48eb46bce14d895b61560907cb7f0df9038df57d.camel@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 25 Mar 2025 08:09:35 -0700
X-Gm-Features: AQ5f1JpEGGA-ok2ErrBCy0AI6IuEEiiZNC5YMor8Ed02ipPGWm0vrAgaGC1v2kg
Message-ID: <CAP-5=fU2OhLBF9GdLngUVq00T1h38deLj7oDrWNc6fYckjpuWg@mail.gmail.com>
Subject: Re: [PATCH v1 03/35] perf vendor events: Update arrowlake events/metrics
To: "Falcon, Thomas" <thomas.falcon@intel.com>
Cc: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, 
	"Biggers, Caleb" <caleb.biggers@intel.com>, "Hunter, Adrian" <adrian.hunter@intel.com>, 
	"Taylor, Perry" <perry.taylor@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>, 
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, 
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>, "Wang, Weilin" <weilin.wang@intel.com>, 
	"acme@kernel.org" <acme@kernel.org>, "afaerber@suse.de" <afaerber@suse.de>, 
	"jolsa@kernel.org" <jolsa@kernel.org>, "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>, 
	"namhyung@kernel.org" <namhyung@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 5:17=E2=80=AFPM Falcon, Thomas <thomas.falcon@intel=
.com> wrote:
>
> On Fri, 2025-03-21 at 23:33 -0700, Ian Rogers wrote:
> > Update events from v1.07 to v1.08.
> > Update event topics, metrics to be generated from the TMA spreadsheet
> > and other small clean ups.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  .../arch/x86/arrowlake/arl-metrics.json       | 566 +++++++++---------
> >  .../pmu-events/arch/x86/arrowlake/cache.json  | 148 +++++
> >  .../pmu-events/arch/x86/arrowlake/memory.json |  11 +
> >  .../pmu-events/arch/x86/arrowlake/other.json  | 193 ------
> >  .../arch/x86/arrowlake/pipeline.json          | 163 ++++-
> >  tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
> >  6 files changed, 608 insertions(+), 475 deletions(-)
> >
> >
> ...
>
> > @@ -1086,18 +1086,18 @@
> >          "MetricExpr": "cpu_core@MEMORY_STALLS.MEM@ / tma_info_thread_c=
lks",
> >          "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tm=
a_memory_bound_group",
> >          "MetricName": "tma_dram_bound",
> > -        "MetricThreshold": "tma_dram_bound > 0.1 & tma_memory_bound > =
0.2 & tma_backend_bound > 0.2",
> > +        "MetricThreshold": "tma_dram_bound > 0.1 & (tma_memory_bound >=
 0.2 & tma_backend_bound > 0.2)",
> >          "PublicDescription": "This metric estimates how often the CPU =
was stalled on accesses to external memory (DRAM) by loads. Better caching =
can improve the latency and increase performance. Sample with: MEM_LOAD_RET=
IRED.L3_MISS",
> >          "ScaleUnit": "100%",
> >          "Unit": "cpu_core"
> >      },
> >      {
> >          "BriefDescription": "This metric represents Core fraction of c=
ycles in which CPU was likely limited due to DSB (decoded uop cache) fetch =
pipeline",
> > -        "MetricExpr": "(cpu_core@IDQ.DSB_UOPS\\,cmask\\=3D0x8\\,inv\\=
=3D0x1@ + cpu_core@IDQ.DSB_UOPS@ / (cpu_core@IDQ.DSB_UOPS@ + cpu_core@IDQ.M=
ITE_UOPS@) * (cpu_core@IDQ_BUBBLES.CYCLES_0_UOPS_DELIV.CORE@ - cpu_core@IDQ=
_BUBBLES.FETCH_LATENCY@)) / tma_info_thread_clks",
> > +        "MetricExpr": "(cpu@IDQ.DSB_UOPS\\,cmask\\=3D0x8\\,inv\\=3D0x1=
@ + cpu_core@IDQ.DSB_UOPS@ / (cpu_core@IDQ.DSB_UOPS@ + cpu_core@IDQ.MITE_UO=
PS@) * (cpu_core@IDQ_BUBBLES.CYCLES_0_UOPS_DELIV.CORE@ - cpu_core@IDQ_BUBBL=
ES.FETCH_LATENCY@)) / tma_info_thread_clks",
> >          "MetricGroup": "DSB;FetchBW;TopdownL3;tma_L3_group;tma_fetch_b=
andwidth_group",
> >          "MetricName": "tma_dsb",
> >          "MetricThreshold": "tma_dsb > 0.15 & tma_fetch_bandwidth > 0.2=
",
> > -        "PublicDescription": "This metric represents Core fraction of =
cycles in which CPU was likely limited due to DSB (decoded uop cache) fetch=
 pipeline.  For example; inefficient utilization of the DSB cache structure=
 or bank conflict when reading from it; are categorized here",
> > +        "PublicDescription": "This metric represents Core fraction of =
cycles in which CPU was likely limited due to DSB (decoded uop cache) fetch=
 pipeline.  For example; inefficient utilization of the DSB cache structure=
 or bank conflict when reading from it; are categorized here.",
> >          "ScaleUnit": "100%",
> >          "Unit": "cpu_core"
> >      },
> >
>
> I'm seeing some errors for metrics tma_dsb, tma_lsd, and tma_mite on arro=
wlake. I think cpu should
> be cpu_core here
>
> $ sudo ./perf stat -M tma_dsb
> event syntax error: '...THREAD!3/,cpu/IDQ.DSB_UOPS,cmask=3D0x8,inv=3D0x1,=
metric-
> id=3Dcpu!3IDQ.DSB_UOPS!0cmask!20x8!0inv!20x1!3/,cpu_core/topdown-fe-bound=
,metric-id=3Dcpu_core!3t..'
>                                   \___ Bad event or PMU
>
> Unable to find PMU or event on a PMU of 'cpu'
>
>
> >          "BriefDescription": "This metric represents Core fraction of c=
ycles in which CPU was likely limited due to LSD (Loop Stream Detector) uni=
t",
> > -        "MetricExpr": "cpu_core@LSD.UOPS\\,cmask\\=3D0x8\\,inv\\=3D0x1=
@ / tma_info_thread_clks",
> > +        "MetricExpr": "cpu@LSD.UOPS\\,cmask\\=3D0x8\\,inv\\=3D0x1@ / t=
ma_info_thread_clks",
> >          "MetricGroup": "FetchBW;LSD;TopdownL3;tma_L3_group;tma_fetch_b=
andwidth_group",
> >          "MetricName": "tma_lsd",
> >          "MetricThreshold": "tma_lsd > 0.15 & tma_fetch_bandwidth > 0.2=
",
> > -        "PublicDescription": "This metric represents Core fraction of =
cycles in which CPU was likely limited due to LSD (Loop Stream Detector) un=
it.  LSD typically does well sustaining Uop supply. However; in some rare c=
ases; optimal uop-delivery could not be reached for small loops whose size =
(in terms of number of uops) does not suit well the LSD structure",
> > +        "PublicDescription": "This metric represents Core fraction of =
cycles in which CPU was likely limited due to LSD (Loop Stream Detector) un=
it.  LSD typically does well sustaining Uop supply. However; in some rare c=
ases; optimal uop-delivery could not be reached for small loops whose size =
(in terms of number of uops) does not suit well the LSD structure.",
> >          "ScaleUnit": "100%",
> >          "Unit": "cpu_core"
> >      },
> >
>
> ...here
>
> $ sudo ./perf stat -M tma_lsd
> event syntax error: '...THREAD!3/,cpu/LSD.UOPS,cmask=3D0x8,inv=3D0x1,metr=
ic-
> id=3Dcpu!3LSD.UOPS!0cmask!20x8!0inv!20x1!3/,cpu_core/topdown-fe-bound,met=
ric-id=3Dcpu_core!3topdown!1..'
>                                   \___ Bad event or PMU
>
> Unable to find PMU or event on a PMU of 'cpu'
>
>
> >      },
> >      {
> >          "BriefDescription": "This metric represents Core fraction of c=
ycles in which CPU was likely limited due to the MITE pipeline (the legacy =
decode pipeline)",
> > -        "MetricExpr": "(cpu_core@IDQ.MITE_UOPS\\,cmask\\=3D0x8\\,inv\\=
=3D0x1@ / tma_info_thread_clks + cpu_core@IDQ.MITE_UOPS@ / (cpu_core@IDQ.DS=
B_UOPS@ + cpu_core@IDQ.MITE_UOPS@) * (cpu_core@IDQ_BUBBLES.CYCLES_0_UOPS_DE=
LIV.CORE@ - cpu_core@IDQ_BUBBLES.FETCH_LATENCY@)) / tma_info_thread_clks",
> > +        "MetricExpr": "(cpu@IDQ.MITE_UOPS\\,cmask\\=3D0x8\\,inv\\=3D0x=
1@ / 2 + cpu_core@IDQ.MITE_UOPS@ / (cpu_core@IDQ.DSB_UOPS@ + cpu_core@IDQ.M=
ITE_UOPS@) * (cpu_core@IDQ_BUBBLES.CYCLES_0_UOPS_DELIV.CORE@ - cpu_core@IDQ=
_BUBBLES.FETCH_LATENCY@)) / tma_info_thread_clks",
> >          "MetricGroup": "DSBmiss;FetchBW;TopdownL3;tma_L3_group;tma_fet=
ch_bandwidth_group",
> >          "MetricName": "tma_mite",
> >          "MetricThreshold": "tma_mite > 0.1 & tma_fetch_bandwidth > 0.2=
",
>
> ...and here?
>
> $ sudo ./perf stat -M tma_mite
> event syntax error: '..etiring!3/,cpu/IDQ.MITE_UOPS,cmask=3D0x8,inv=3D0x1=
,metric-
> id=3Dcpu!3IDQ.MITE_UOPS!0cmask!20x8!0inv!20x1!3/,cpu_core/topdown-bad-spe=
c,metric-id=3Dcpu_core!..'
>                                   \___ Bad event or PMU
>
> Unable to find PMU or event on a PMU of 'cpu'

Thanks Tom, I'll post a fix in v2.

Ian

>
> Thanks,
> Tom
>
>
