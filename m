Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D91929A9FE
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Sep 2025 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756915709; cv=none; b=hNZF5dsQowJjcTh87aVRPPDaOfe8RKglTSi7LK/ciz3rRsDtu/TaI2OkCgfFQmvUu4XQsV0iBhDlrL9dmRZCDrPLXi+0IWRBh8HtRAEqZiBy7/sawdv9VFjY9/g48+mQAMKMJXNbYR953JhZbVjCbsG50ZXng3tuo9jGpfKasVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756915709; c=relaxed/simple;
	bh=TcnOqHnxWtRRf9NT+MerUvHTwyfwaLmdD3fXWcz/5rU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rvQ6asAbjDM34sRp4aNAGjrpy0rmMDjXJuW1HskA8OuEnfxWNtoNPJD9+rcgaYIF1wDKbmprcWQvrQyMwcNtJ79Oa7+YsbIAbwR38AJmM5yxCKAxHI07G1ZyolMZfv8KJ60W63hQEOHRVaVmY4EqOCTlOz5AIKdJmiGf0Cqf6Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wS/PGVh2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wS/PGVh2"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24b2337d1bfso215375ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 09:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756915707; x=1757520507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4oEAPOJhyq1/T6c/PPsWOSFUUJWRnUyjFcO2apuW1o=;
        b=wS/PGVh22PJRIzDq0hCSGIKALbg7w6cbkw2fRA4MeSsWP2DZegKdpGOz6ZOpIZu96K
         V6vjjEBXH6aOSxcboq9qLpuyXLC1Jo2ZXwdGSUPPmhPF/n5CD7nnBjRct4Mpi9zhMPoS
         ASwaAKpVm05h9YYu9hhGhPSRiEZ6otMFek3U0V/dHkiGQdOki5za0BDMcoGFm0gv720q
         K5isr/SmPZoNzQNSOFfwPgh1VBp62X2GmWuI7xiHgs1ztRSrjGBEct1IeEoc+T2+dMhT
         xXJKkMM3w8BXsi5sS3SktKegQ9mBVpnw3HtC9ZlNuRc6VODq7skyoGKVEd6SXaipgUxx
         K6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756915707; x=1757520507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4oEAPOJhyq1/T6c/PPsWOSFUUJWRnUyjFcO2apuW1o=;
        b=nQCd4MGcZqi+O0iK7BC9QWKD7dy+2GwAcSXJ0vfQMAcr67VSuJUamTRm617AcKEfZh
         ArKL2ro7UxYKVcwIORygRtRkl0OfYvMV7/gh8nbKYtCvDjmRRAq9hpgnmsgNnKniwey7
         +j02AmT1iN0+TVLhtLXxq45RBUf7JOYLtzHrwfmemGLe2HpQ/OO7HgwBy8HaYcNYYY19
         Jhc5sGAf0py+Jo6LTcDDifKuaYh7XuNt1aMKU1jgkAruN0EKdRqOR66G1OMRGIvrnk7c
         PSue1KTFHq9K5eDvyocJH1Wi45xQyxEBaGZupkm9zFnvtVhzvEhp+g+tysdckTaQQOhG
         n7Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWo8Anjg9WMiaPuVAHbe7sJkbM+2RGFNN1Xs6PL5OmVagtNubG5wcH2+uAv1sgBKBnUVxjf2vSO64psOCjXu2c+@vger.kernel.org
X-Gm-Message-State: AOJu0YzZuakmJEdjSmWIdffWHtA15DgW6Pf8x/9k5ptGACOfgUgrXmaM
	lKNk4JANctMOZjuR7rZ7aQMp6oIalfLd2M6O7DCQMsc4hvSes4WYEplAgffy61llsHf1v9KP9Ky
	nbEd4MF/IvdbTS20qJpdqEJ4nk6PL/4ofGcZJBbQc
X-Gm-Gg: ASbGncse1oAlQ7wMh6nCBU1nQfkI8umOuem9iliEp/3Ab2HeZnxTA6cbdpzG5DtdF1v
	adtB9fx02Z8PassuU7twDT3hjJzLrLAOhBRFxZrGEllD4IT8e2hRGtVlx4Ow2wJjd4syBfdiiLI
	0fnjAzOyjoheZDFYp+IUZJrZDZdcTxPcoC3iVl4b/DAoyGWe4y0IJJ4hatknAOOruXOGHfp6TT4
	HMmnuxQciLT5IaEtr0Ut5N7D9TAdbiPjoP5pTIUbnIL53tDCUIoQIU=
X-Google-Smtp-Source: AGHT+IENJInbMwsLUHTnIJnRhiUAa7cm9vbNoqrqt8ITIvS5UFXyo67xRMtE2rrpaCdKkatE3lcGXTFlCVlawA3h0U0=
X-Received: by 2002:a17:902:ced2:b0:231:f6bc:5c84 with SMTP id
 d9443c01a7336-2493e9224f5mr16770495ad.8.1756915706497; Wed, 03 Sep 2025
 09:08:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829033138.4166591-1-irogers@google.com> <efb8ef2a-f5e4-4d7d-ba8e-fee5055f7c20@amd.com>
In-Reply-To: <efb8ef2a-f5e4-4d7d-ba8e-fee5055f7c20@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Sep 2025 09:08:14 -0700
X-Gm-Features: Ac12FXw05mbX-2WBsT9OXc79YW05EK_HXIDNJcJcMhrjtnv_6s36hT6DAMsOy4s
Message-ID: <CAP-5=fW6Pzd0mpdXbZmvNjx=UEY__qfcoFZGTsv6SJ4R=ngwfg@mail.gmail.com>
Subject: Re: [PATCH v5 00/13] Python generated AMD Zen metrics
To: Sandipan Das <sandidas@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 7:26=E2=80=AFAM Sandipan Das <sandidas@amd.com> wrot=
e:
>
> On 8/29/2025 9:01 AM, Ian Rogers wrote:
> > Generate thirteen sets of additional metrics for AMD zen.  Rapl and
> > Idle metrics aren't specific to AMD but are placed here for ease and
> > convenience. Uncore L3 metrics are added along with the majority of
> > core metrics.
> >
> > The patches should be applied on top of:
> > https://lore.kernel.org/lkml/20250829030727.4159703-1-irogers@google.co=
m/
> >
> > v5. Rebase. Add uop cache hit/miss rates patch. Prefix all metric
> >     names with lpm_ (short for Linux Perf Metric) so that python
> >     generated metrics are clearly namespaced.
> >
> > v4. Rebase.
> >     https://lore.kernel.org/lkml/20240926174101.406874-1-irogers@google=
.com/
> >
> > v3. Some minor code cleanup changes.
> >     https://lore.kernel.org/lkml/20240314055839.1975063-1-irogers@googl=
e.com/
> >
> > v2. Drop the cycles breakdown in favor of having it as a common
> >     metric, suggested by Kan Liang <kan.liang@linux.intel.com>.
> >     https://lore.kernel.org/lkml/20240301184737.2660108-1-irogers@googl=
e.com/
> >
> > v1. https://lore.kernel.org/lkml/20240229001537.4158049-1-irogers@googl=
e.com/
> >
> > Ian Rogers (13):
> >   perf jevents: Add RAPL event metric for AMD zen models
> >   perf jevents: Add idle metric for AMD zen models
> >   perf jevents: Add upc metric for uops per cycle for AMD
> >   perf jevents: Add br metric group for branch statistics on AMD
> >   perf jevents: Add software prefetch (swpf) metric group for AMD
> >   perf jevents: Add hardware prefetch (hwpf) metric group for AMD
> >   perf jevents: Add itlb metric group for AMD
> >   perf jevents: Add dtlb metric group for AMD
> >   perf jevents: Add uncore l3 metric group for AMD
> >   perf jevents: Add load store breakdown metrics ldst for AMD
> >   perf jevents: Add ILP metrics for AMD
> >   perf jevents: Add context switch metrics for AMD
> >   perf jevents: Add uop cache hit/miss rates for AMD
> >
> >  tools/perf/pmu-events/amd_metrics.py | 654 ++++++++++++++++++++++++++-
> >  1 file changed, 651 insertions(+), 3 deletions(-)
> >
>
> For clean builds, I am seeing some warnings for the "context-switches" an=
d
> "energy-pkg" events.
>
> ...
> /home/sandipan/linux/tools/perf/pmu-events/amd_metrics.py:124: SyntaxWarn=
ing: invalid escape sequence '\-'
>   cs =3D Event("context\-switches")
> ...
> /home/sandipan/linux/tools/perf/pmu-events/amd_metrics.py:615: SyntaxWarn=
ing: invalid escape sequence '\-'
>   pkg =3D Event("power/energy\-pkg/")
> ...

Thanks Sandipan, I'll fix the warning in v6.

Ian
