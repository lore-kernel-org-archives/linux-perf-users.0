Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3F3358B5
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 18:03:03 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB42116
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 11:03:01 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-414ba610766so48451cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 11:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695751381; x=1696356181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fG3vIfPo5yol0BVmzq+e6p47Tw2I82MeM0wmrspuJLQ=;
        b=um0JECdhF1tycyiS8AeSMCzcHggcYXCl9Rk+bF6xkrCZCCCWaCwqrHNPcPD3pPcFtp
         p7nUyCI/a/ia3ONcHi1BeiP/mKMSNZbdfmRddXHwOHnJvIx4Z5kBVF7jEMhFbpk00m59
         E+ytKmAffpGvkD2p4fPiO3dxbxkd0GplfH11WSGEj7sX3MpV4oT3MrdMhGjPuzE+sLTH
         o3eU6zx3B3Z8k+m0pjFCOR3/XeJVe7VJK1Qe3y4GYsE5r7pfExsv4qUSxPO1laZYNoZW
         gf5l2dDhq0tRUUvVPatUTthym0PDd6NHYwPOKELxT0opKa7PFXeC5XKI5/u2taWY5inF
         Iz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695751381; x=1696356181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fG3vIfPo5yol0BVmzq+e6p47Tw2I82MeM0wmrspuJLQ=;
        b=TP7E2eASfDV3IWiAaoZ99O+Mw0rUTzv/fMFgIuILLbnKDedvdCzGlBKcoZy7ZkQnEe
         hq9vwyMxY8dP/QCc+68rnb7Q1pN9FDK7NdS9QXxcQtJBXDaQRWjzYi31KHZ4CKOEnLzB
         UJchRhUf42sUY5gTKIl8OMpvi6Ox0MXS4z6aZ8qr9MhG6qhNxLag0vrXRHe+iMyCf2Cb
         9WVqJx9OQEHyn4seJ31NmPui/AjA+obnG23WeW6WX5XhfUm1l9E5hpQJiYDhenEpnAp+
         JohuELx83UCR1QXjEKq463Bgjl3Vwc+eQ03WFhQrRfefLWmsokvrtp4aMQgdigJGZGqf
         6kLg==
X-Gm-Message-State: AOJu0YyaHNz3nUwsWQoqbhBlUAZz3zLUjC+sb47vp50r71BkvX42rWnn
	ItdDagDZTP4F1JaaaHOVGsIxL/gQLvoJKVSMQOssTw==
X-Google-Smtp-Source: AGHT+IGbzKHyIqDxIB8t2yyWwteM+BcXKq4YWgWnj5Ouj1SVxWO4HfwutwHdlSluuw25Lv08nSyys87kBbVOm6ArGbQ=
X-Received: by 2002:ac8:7e8d:0:b0:403:b1d0:2f0a with SMTP id
 w13-20020ac87e8d000000b00403b1d02f0amr420630qtj.28.1695751380840; Tue, 26 Sep
 2023 11:03:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926031034.1201145-1-irogers@google.com> <f4b23e81-9a49-a3ba-d666-4b8f90e9720c@linux.intel.com>
In-Reply-To: <f4b23e81-9a49-a3ba-d666-4b8f90e9720c@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 26 Sep 2023 11:02:49 -0700
Message-ID: <CAP-5=fWx1EJjt8K=vKC=xyVWO+VXX=Cnb+6YOjExQaFVG4pL=A@mail.gmail.com>
Subject: Re: [PATCH v1] perf vendor events intel: Fix broadwellde
 tma_info_system_dram_bw_use metric
To: "Liang, Kan" <kan.liang@linux.intel.com>, Perry Taylor <perry.taylor@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 7:02=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2023-09-25 11:10 p.m., Ian Rogers wrote:
> > Broadwell-de has a consumer core and server uncore.
>
> Besides this one, compared with the bdx-metrics.json, there is one
> uncore metrics missed in the bdwde-metrics.json, uncore_frequency.

You're right and I knew it related to this:
https://github.com/intel/perfmon/blob/cddf6ebe4cc23b71a5d8bf7fa007b3e2cb706=
c2e/scripts/create_perf_json.py#L760
On Tigerlake UNC_CLOCK.SOCKET works fine so maybe the exclusion was an erro=
r:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/pmu-events/arch/x86/tigerlake/uncore-other.json?h=3Dperf-tool=
s-next
On BDW-DE if I do the same trick as UNC_ARB and use the BDX resolution
then that works too. So I'll fix that and send out a v2.

Thanks,
Ian

> > The uncore_arb PMU
> > isn't present and the broadwellx style cbox PMU should be used
> > instead. Fix the tma_info_system_dram_bw_use metric to use the server
> > metric rather than client.>
> > The associated converter script fix is in:
> > https://github.com/intel/perfmon/pull/111
> >
> > Fixes: 7d124303d620 ("perf vendor events intel: Update broadwell varian=
t events/metrics")
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>
> Thanks,
> Kan
> > ---
> >  tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.j=
son b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> > index 8fc62b8f667d..d0ef46c9bb61 100644
> > --- a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> > +++ b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> > @@ -652,7 +652,7 @@
> >      },
> >      {
> >          "BriefDescription": "Average external Memory Bandwidth Use for=
 reads and writes [GB / sec]",
> > -        "MetricExpr": "64 * (arb@event\\=3D0x81\\,umask\\=3D0x1@ + arb=
@event\\=3D0x84\\,umask\\=3D0x1@) / 1e6 / duration_time / 1e3",
> > +        "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) =
/ 1e9 / duration_time",
> >          "MetricGroup": "HPC;Mem;MemoryBW;SoC;tma_issueBW",
> >          "MetricName": "tma_info_system_dram_bw_use",
> >          "PublicDescription": "Average external Memory Bandwidth Use fo=
r reads and writes [GB / sec]. Related metrics: tma_fb_full, tma_mem_bandwi=
dth, tma_sq_full"
