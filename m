Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F5A440D
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Oct 2023 04:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KN+PvH5x"
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D33187
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Oct 2023 21:20:13 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507a085efa7so1864e87.0
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Oct 2023 21:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698294011; x=1698898811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75q8gySjt19wzXTrkLK8R2Urnb9hTgP0iyJ1UPsf7lo=;
        b=KN+PvH5xswnK3vD2FZFjXhrx7YZbEj74ejf97Lmz7KbgtOJliA8qgZvd3bjt4n4EOs
         oLvM97cZbjeT7JCeU1BiLXv8LGTUlKpBRZw+9+I38eAjpalXGGEhXnbiVsF74PA4wMRU
         smBUBgzSNP2lgK8UJdE1bEpvY+BbITJ7/VpYt1521hy5prNU722m81g35/hZ9paxQYKy
         u0FkhFT9TangOPfBWjxguhVlOSBFXueby0spvTREhZq+75hoi9gpkHF73eiuNbYev1Vh
         tmHkYTag22t9vxwAcrNzqJgw3lbWgQ08PQnItQpKf56GGxMfgrpKt58+bC/FhisVrDBH
         K01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698294011; x=1698898811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75q8gySjt19wzXTrkLK8R2Urnb9hTgP0iyJ1UPsf7lo=;
        b=RRdTPlg/kYBlEvWuzzV/y6cSRPhCF5B2D6xQzW+IxA/n341WR4H9ULYeJwcr9lVQa+
         +DZwbN87gSkUrRQqmqkkvxvlEHYAWKGQ98evTL+jiBEf8Pp3Nskns62eiLGEUHKDRSaO
         K3T7ZPQKWtUUtpErWqwSR/QACQrQ2tXkB+ABJbjou2JV1ok4Jj3RZx3ephXmLKlpUZH2
         +sFp9uHr6H0BTv910vYBhgia5aAcqE7k5CY0CGkWmMATl3H+7LbFjiDLAYKwVaziy7Id
         InmHC5Xy8mTrMMRI9yefLcrB2PmcIKdoX9BqSXYnBsXjLL363vSLRDxG17kRAGnRoS5e
         dwQQ==
X-Gm-Message-State: AOJu0Yzk9oy0aSlOgEjElmptdGttYIxg6hAjlR5qURKkmmdnEoue9spi
	8ya8E1a00S+415IdOA0Fjg9Q/oPF7gI4qsTuP+V0OQ==
X-Google-Smtp-Source: AGHT+IGgoikw81XSACvxOqAeHp09PG2LRCqkhPQl/Hk2uGjvKXzxSN+ovf3ie5WAlPrU8XnhCR/szEzNlNdypm2gcc4=
X-Received: by 2002:a05:6512:2101:b0:507:9a33:37a3 with SMTP id
 q1-20020a056512210100b005079a3337a3mr123916lfr.7.1698294011132; Wed, 25 Oct
 2023 21:20:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926205948.1399594-1-irogers@google.com> <8a6b9556-c82c-4253-a4c1-74d696ad26df@linux.intel.com>
 <CAP-5=fWk12jKjVmV+aJ_U5A=ao7L1ha-wOHaM+ytO9oF0nP9zA@mail.gmail.com> <CAP-5=fURbve928P5CGi-dQ7Y8mZhxRmi9wucFc_gP+aDGMftYw@mail.gmail.com>
In-Reply-To: <CAP-5=fURbve928P5CGi-dQ7Y8mZhxRmi9wucFc_gP+aDGMftYw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 25 Oct 2023 21:19:58 -0700
Message-ID: <CAP-5=fU5W=97NFvL1yUKw+rrbBrcd8c-S_y3=86SYv+pszNjmQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] perf vendor events intel: Fix broadwellde
 tma_info_system_dram_bw_use metric
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 2:56=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Oct 5, 2023 at 3:16=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > On Wed, Sep 27, 2023 at 6:47=E2=80=AFAM Liang, Kan <kan.liang@linux.int=
el.com> wrote:
> > >
> > >
> > >
> > > On 2023-09-26 4:59 p.m., Ian Rogers wrote:
> > > > Broadwell-de has a consumer core and server uncore. The uncore_arb =
PMU
> > > > isn't present and the broadwellx style cbox PMU should be used
> > > > instead. Fix the tma_info_system_dram_bw_use metric to use the serv=
er
> > > > metric rather than client.
> > > >
> > > > The associated converter script fix is in:
> > > > https://github.com/intel/perfmon/pull/111
> > > >
> > > > Fixes: 7d124303d620 ("perf vendor events intel: Update broadwell va=
riant events/metrics")
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > >
> > > Thanks Ian. The whole patch series looks good to me.
> > >
> > > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> >
> > Would be good to pick this up in perf-tools-next.
> >
> > Thanks,
> > Ian
>
> Ping.

Thanks Namhyung for picking this up. There were two other patches in
the v2 patch set that Kan reviewed:
https://lore.kernel.org/all/8a6b9556-c82c-4253-a4c1-74d696ad26df@linux.inte=
l.com/
that I don't see in perf-tools-next.

Ian

> Thanks,
> Ian
>
> > > Thanks,
> > > Kan
> > >
> > > >  tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json | 2 =
+-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metri=
cs.json b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> > > > index 8fc62b8f667d..d0ef46c9bb61 100644
> > > > --- a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> > > > +++ b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> > > > @@ -652,7 +652,7 @@
> > > >      },
> > > >      {
> > > >          "BriefDescription": "Average external Memory Bandwidth Use=
 for reads and writes [GB / sec]",
> > > > -        "MetricExpr": "64 * (arb@event\\=3D0x81\\,umask\\=3D0x1@ +=
 arb@event\\=3D0x84\\,umask\\=3D0x1@) / 1e6 / duration_time / 1e3",
> > > > +        "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.=
WR) / 1e9 / duration_time",
> > > >          "MetricGroup": "HPC;Mem;MemoryBW;SoC;tma_issueBW",
> > > >          "MetricName": "tma_info_system_dram_bw_use",
> > > >          "PublicDescription": "Average external Memory Bandwidth Us=
e for reads and writes [GB / sec]. Related metrics: tma_fb_full, tma_mem_ba=
ndwidth, tma_sq_full"
