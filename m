Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722E94EDCD0
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614508; cv=pass; b=dk68R8k7oB6NVw/QbBEMlCK10irXN7goDolwUD+ST58xl4TiCXFasIZt3+cWWka8iiohrmM3cMDIESYBLhFWYbeYWdgS9hg/MKcH5HQRiuxAob4AiUmRILPJHOStpq6Xpc0iSBiUcSUd7bztEWawhyb8wMfVQhUJ/65Kg8OLOJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614508; c=relaxed/simple;
	bh=IASEx1EJE/GMkLJ5civVJ/l2tj6ZC+WJ9bTI2RQ6yV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMs4zwt7/L9144nFAc3xzWJz2vZv8ylGq2arAInzCtWtUl30TSI5KKRVCiiBL51arVqFnjM1Qo2UgTo5sZayuJX08BFJuydKI4zGyB5jUwa0jnYYxYjFgxmeU+zsetxYwJe0oefLI25LocQK3rctxzWO/9rJoHhme2EOcoiEr5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oLG2kReM; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oLG2kReM"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d8facae850so1125ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 09:55:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790614505; cv=none;
        d=google.com; s=arc-20260327;
        b=BA1mjOGKVyrthcly3mGVhwFaxYui55nNQzijHmvPPR4qrUtkizskOueQcKFzyyvQUE
         HQpAYCiaD5C19b78w04N7Ae853qFBa8PWFRCsTpoIRjaS4/V5xXJacMrdnLzxELCI8E+
         LDlXhBnhDfZnB4owlovLZ9tcpkiO+1R8K7mc8Y1ttOKT/O+TVa+TcZcLVgH+F27ejerX
         o+fl5HPN2gL+704XQ6s7Hpcx2OU1DTAjQlLQFm87QWy/ZybNwtGWq7GDHiFrAgCCcDza
         NvV302ueRP/nrBbO1XBz7Y1XhIveYkPmuwEAoPo6Lp0RYY6qShIxjr1tKjGyp/hCYDRF
         AeOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7soP/O/zINKuD2EF23WfMAwY1php3XkqZsqDRJMpzGA=;
        fh=DCqxWsNYI5kNO1lZiyhXOBA+trK/8E5Lrj7vP6S7E2U=;
        b=fuRpRenRYYbb5dyDkpFZTJOUkzLr+Wq6p6AL+9Lcq2WTjJitkkRHXBxFt6vXFdmyoX
         t9+0Sny449WGPMDUDW7lmMP7RUoWbVCclv+Wx9GgNXDIXvZxR7PJLMLWpM40ccDqgLLP
         n9Zgr0HbzEas6BkR0Vn8Jm5a6fgGQAwxD4Ly6nor4LKEHZla5jpj1EnkcFLrxLpnjGdu
         emTiYfpsRdZTDQlerspcbV02lyo5UoM6INaPxNSCiBjZCgkchmtbn/5OEn3yQwrovs/V
         OpYYoA5Bv3bw4TCBG+rIsrktbzZi20YRalTbk3FuXoPDDbSvOKTYXbqmm/cOc4vRclDt
         mAtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790614505; x=1791219305; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7soP/O/zINKuD2EF23WfMAwY1php3XkqZsqDRJMpzGA=;
        b=oLG2kReMaI949eOp7KVlOym9Q8Mm6h1yKvdfm9x5UbBsYCfzKgBFUO/ZRMvMkDmbba
         U2Jg2lKi8NjiZ3KUZgmzV7gjR5AMtNQf68vVFx1MWp61p+jb6codlEgDJjacLaVZLxmw
         udIshjYrOfX4z+1nGOPx1BS9kRZxIkbT5OQtHMlT9jzRpxAkuoYv34yysA1SVYWD1pfB
         MxIEXFZNBUt9putFsS+LyJiSZfGweOU0kxIKi9S6+AoMeX6/F2dGGPi3UUaa4t6SSvwP
         Rb3H3X34jruKlZ8YI2ebWZpGHqJ9Aihx9m2HclVgzAx6FOr0s9fnRpo6XGxJrBVRKf5t
         jUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790614505; x=1791219305;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7soP/O/zINKuD2EF23WfMAwY1php3XkqZsqDRJMpzGA=;
        b=h+JxhclyTQoUO5+WfeMvrGUYZwIxHzErsN8ZeZh6UiWxRezLni66U17xfd+YlAQvEL
         EdUikhLYkybq1hnZ/9JMZWO1dscC1hvsFdv98sNR5SmIAPsPrQq/IhD3HP0vylw/6hK4
         6zkf+cdeIuADajJ/zZAsXBbYEtK5TQNzaUzT1/UrUFeqjI90TKP42CECbnVSs/k2mY9D
         sid/b4cPE3JwhJ3Y4hm2fq608EEAo94C/sdT0GUwxsMkwc/aMRxjSF5uvOC02eV66xTl
         4kbxIzFBUM79TVWuC9sY8/w1ydaKdJPX5T2vsxbp0JNwUJSs816fOoDfBj1PxPztPsYe
         rOnQ==
X-Forwarded-Encrypted: i=1; AKwUvBzJqk7aNU78CH/czSjTCvVYiOVtq8vGqvzWpw07ZWKZxoWWTA6qui3O2mTMT2MYTjll6KBiCS0C7wGLSOIuhTXh@vger.kernel.org
X-Gm-Message-State: AFq9FYI82AnTw/z3UsRA64q7qsgIK3jc9UxZHaouE73Jx/lH8K+L9jR8
	mGdl+qDagxAuvY4CzOZjPpXPPFu4V8cY7ZbHJxWUnZPL/76kmzBgCkV0SL2h51rSJ/qb2JAtydv
	UJtjt0Um2v6kbvTwvcCCfDCW3F8QmnCIzLZ5A6r0t
X-Gm-Gg: AYBFou2OvBZp1j9aeqn/69iKf20HcOzN/hGvUUrxfV4P6kA+ZUouDEs1MRoDQ162oRV
	xq1PtQ1bUoLJ+7HoH0MogRz2Zh2EAgqhjxRxc/rkEwQsuCynlrn/psMG4LbIQrlt1mm5BN/xMP8
	d3OBQHPMBmNd5crNrI++8URQ4fjNZcpa0kaGK1KdUjjVJTYNm2omo0cynQD4zW71GFD3kljMk9h
	itSV/1rFvfg0DcDGEEn286MHVQIOPjqORNtKsPdpco2SRwEsWQcTpCZC8tmjXovaWewoMciNkQJ
	Mg/yoCQqBTYTX0eyl1OgA0tPb1WneO2E/J3e8Tdtyiin9+3G1wN2LfMaoBSm9tiKxT8gddVG6k3
	8LCw7oAkA
X-Received: by 2002:a17:903:1a30:b0:2ca:bf8e:360b with SMTP id
 d9443c01a7336-2dfa973ba48mr7030865ad.9.1790614503504; Mon, 28 Sep 2026
 09:55:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924053645.3555041-1-irogers@google.com> <20260924170346.3872848-1-irogers@google.com>
 <20260924170346.3872848-5-irogers@google.com> <20260924171457.7626C1F00893@smtp.kernel.org>
 <arqaq6ulLswHEQyg@x2>
In-Reply-To: <arqaq6ulLswHEQyg@x2>
From: Ian Rogers <irogers@google.com>
Date: Mon, 28 Sep 2026 09:54:50 -0700
X-Gm-Features: AclHuK8HdpgsjRxgr5YQq0VkxtlRIjiMvAfaIG67NB0uW7fTJ9SYD-8ALAAiP-E
Message-ID: <CAP-5=fUpvYfs__94ByRtib3Px1o5kL+rTrzq=mdK0kyHB_T8FQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/26] perf vendor events intel: Update broadwell
 metrics to TMA 5.2
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 9:49=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Sep 24, 2026 at 05:14:57PM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential is=
sue(s) to consider:
> > - [Medium] perf: missing NO_GROUP_EVENTS_SMT constraint for tma_l3_miss=
_bound
> > - [Low] perf: invalid event and metric references in broadwell TMA desc=
riptions
> > --
>
> Hi Ian,
>
>         I just saw Mi thanking you for addressing an issue in this
> series, will you address these Sashiko comments?

Thanks Arnaldo!

NO_GROUP_EVENTS_SMT  - this is an optimization to avoid weak group
fallbacks when SMT is enabled. Applying this tag across all Intel
models is something of a chore and I'm lazy about it. It isn't a
critical issue as weak groups (should) work.

The invalid metrics in the documentation aren't great, but we're
building the metrics from a spreadsheet. The column containing the
related metrics doesn't differentiate per model, which is where the
problem originates. We could validate that metrics are present with
additional passes over the data; however, fixing this is something we
need to address in the longer term, in my opinion.

Thanks,
Ian

> Mi,
>         Can I have your reviewed-by for the series?
>
> - Arnaldo
>
>
> > commit 9dd8d107153bd9a839dac0461130818443958cb7
> > Author: Ian Rogers <irogers@google.com>
> >
> > perf vendor events intel: Update broadwell metrics to TMA 5.2
> >
> > This commit updates the Telemetry Metric Architecture (TMA) metrics for
> > Intel Broadwell platforms to version 5.2.
> >
> > > diff --git a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.jso=
n b/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
> > > index 1d8e910f59613..cd59e4a666b21 100644
> > > --- a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
> > > +++ b/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
> > [ ... ]
> > > @@ -175,13 +175,13 @@
> > >          "ScaleUnit": "100%"
> > >      },
> > >      {
> > > -        "BriefDescription": "This metric estimates fraction of cycle=
s while the memory subsystem was handling synchronizations due to data-shar=
ing accesses",
> > > +        "BriefDescription": "This metric estimates fraction of cycle=
s while the memory subsystem was handling synchronizations due to L3 data-s=
haring accesses",
> > >          "MetricConstraint": "NO_GROUP_EVENTS",
> > >          "MetricExpr": "43 * (MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT *=
 (1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_L=
OAD_UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_=
UOPS_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + ME=
M_LOAD_UOPS_RETIRED.L3_MISS))) / tma_info_thread_clks",
> > >          "MetricGroup": "BvMS;Offcore;Snoop;TopdownL4;tma_L4_group;tm=
a_issueSyncxn;tma_l3_bound_group",
> > >          "MetricName": "tma_data_sharing",
> > >          "MetricThreshold": "tma_data_sharing > 0.05 & (tma_l3_bound =
> 0.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
> > > -        "PublicDescription": "This metric estimates fraction of cycl=
es while the memory subsystem was handling synchronizations due to data-sha=
ring accesses. Data shared by multiple Logical Processors (even just read s=
hared) may cause increased access latency due to cache coherency. Excessive=
 data sharing can drastically harm multithreaded performance. Sample with: =
MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS. Related metrics: tma_contested_accesse=
s, tma_false_sharing, tma_machine_clears, tma_remote_cache",
> > > +        "PublicDescription": "This metric estimates fraction of cycl=
es while the memory subsystem was handling synchronizations due to L3 data-=
sharing accesses. Data shared by multiple Logical Processors (even just rea=
d shared) may cause increased access latency due to cache coherency. Excess=
ive data sharing can drastically harm multithreaded performance. Sample wit=
h: MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD. Related metrics: tma_contested_acce=
sses, tma_false_sharing, tma_machine_clears, tma_remote_cache",
> >
> > [Severity: Low]
> > Is this sample event correct? The updated description suggests sampling=
 with
> > MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD, but this event does not exist on
> > Broadwell processors. Should this be XSNP_HIT instead?
> >
> > [ ... ]
> > > @@ -827,7 +817,16 @@
> > >          "MetricGroup": "BvML;MemoryLat;TopdownL4;tma_L4_group;tma_is=
sueLat;tma_l3_bound_group",
> > >          "MetricName": "tma_l3_hit_latency",
> > >          "MetricThreshold": "tma_l3_hit_latency > 0.1 & (tma_l3_bound=
 > 0.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
> > > -        "PublicDescription": "This metric estimates fraction of cycl=
es with demand load accesses that hit the L3 cache under unloaded scenarios=
 (possibly L3 latency limited).  Avoiding private cache misses (i.e. L2 mis=
ses/L3 hits) will improve the latency; reduce contention with sibling physi=
cal cores and increase performance.  Note the value of this node may overla=
p with its siblings. Sample with: MEM_LOAD_UOPS_RETIRED.L3_HIT_PS. Related =
metrics: tma_mem_latency",
> > > +        "PublicDescription": "This metric estimates fraction of cycl=
es with demand load accesses that hit the L3 cache under unloaded scenarios=
 (possibly L3 latency limited).  Avoiding private cache misses (i.e. L2 mis=
ses/L3 hits) will improve the latency; reduce contention with sibling physi=
cal cores and increase performance.  Note the value of this node may overla=
p with its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS. Related metri=
cs: tma_mem_latency",
> > > +        "ScaleUnit": "100%"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "This metric estimates how often the CPU=
 was stalled on accesses to external memory (DRAM) by loads",
> > > +        "MetricExpr": "(1 - MEM_LOAD_UOPS_RETIRED.L3_HIT / (MEM_LOAD=
_UOPS_RETIRED.L3_HIT + 7 * MEM_LOAD_UOPS_RETIRED.L3_MISS)) * CYCLE_ACTIVITY=
.STALLS_L2_MISS / tma_info_thread_clks",
> > > +        "MetricGroup": "MemoryBound;Offcore;TmaL3mem;TopdownL3;tma_L=
3_group;tma_memory_bound_group",
> > > +        "MetricName": "tma_l3_miss_bound",
> >
> > [Severity: Medium]
> > Does this metric need the NO_GROUP_EVENTS_SMT constraint like the old
> > tma_dram_bound metric it replaces?
> >
> > The expression uses CYCLE_ACTIVITY.STALLS_L2_MISS which has multiplexin=
g
> > limitations when SMT is enabled on older architectures like Broadwell.
> > Without this constraint, hardware PMU events might fail to schedule or =
yield
> > invalid results when SMT is enabled.
> >
> > > +        "MetricThreshold": "tma_l3_miss_bound > 0.1 & (tma_memory_bo=
und > 0.2 & tma_backend_bound > 0.2)",
> > > +        "PublicDescription": "This metric estimates how often the CP=
U was stalled on accesses to external memory (DRAM) by loads. Better cachin=
g can improve the latency and increase performance. Sample with: MEM_LOAD_R=
ETIRED.L3_MISS",
> >
> > [Severity: Low]
> > Is this sample event correct? The new tma_l3_miss_bound metric suggests
> > MEM_LOAD_RETIRED.L3_MISS, but this event doesn't exist on Broadwell. Sh=
ould
> > this be MEM_LOAD_UOPS_RETIRED.L3_MISS_PS?
> >
> > > +        "ScaleUnit": "100%"
> > >      },
> > >      {
> > > @@ -882,18 +881,18 @@
> > >      {
> > >          "BriefDescription": "This metric estimates fraction of cycle=
s where the core's performance was likely hurt due to approaching bandwidth=
 limits of external memory - DRAM ([SPR-HBM] and/or HBM)",
> > >          "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQU=
ESTS_OUTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@) / tma_info_thread_clks",
> > > -        "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group=
;tma_dram_bound_group;tma_issueBW",
> > > +        "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group=
;tma_issueBW;tma_l3_miss_bound_group",
> > >          "MetricName": "tma_mem_bandwidth",
> > > -        "MetricThreshold": "tma_mem_bandwidth > 0.2 & (tma_dram_boun=
d > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
> > > -        "PublicDescription": "This metric estimates fraction of cycl=
es where the core's performance was likely hurt due to approaching bandwidt=
h limits of external memory - DRAM ([SPR-HBM] and/or HBM).  The underlying =
heuristic assumes that a similar off-core traffic is generated by all IA co=
res. This metric does not aggregate non-data-read requests by this logical =
processor; requests from other IA Logical Processors/Physical Cores/sockets=
; or other non-IA devices like GPU; hence the maximum external memory bandw=
idth limits may or may not be approached when this metric is flagged (see U=
ncore counters for that). Related metrics: tma_fb_full, tma_info_system_dra=
m_bw_use, tma_sq_full",
> > > +        "MetricThreshold": "tma_mem_bandwidth > 0.2 & (tma_l3_miss_b=
ound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
> > > +        "PublicDescription": "This metric estimates fraction of cycl=
es where the core's performance was likely hurt due to approaching bandwidt=
h limits of external memory - DRAM ([SPR-HBM] and/or HBM).  The underlying =
heuristic assumes that a similar off-core traffic is generated by all IA co=
res. This metric does not aggregate non-data-read requests by this logical =
processor; requests from other IA Logical Processors/Physical Cores/sockets=
; or other non-IA devices like GPU; hence the maximum external memory bandw=
idth limits may or may not be approached when this metric is flagged (see U=
ncore counters for that). Related metrics: tma_fb_full, tma_info_system_dra=
m_bw_use, tma_sq_full, tma_uc_bound",
> >
> > [Severity: Low]
> > Does this description reference an undefined metric? The related metric=
s list
> > adds tma_uc_bound, but that metric isn't defined in the Broadwell event=
s.
> >
> > > diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics=
.json b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> > > index a5e408ca46a7e..a3e6835f4f847 100644
> > > --- a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> > > +++ b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> > [ ... ]
> > > @@ -819,7 +809,16 @@
> > >          "MetricGroup": "BvML;MemoryLat;TopdownL4;tma_L4_group;tma_is=
sueLat;tma_l3_bound_group",
> > >          "MetricName": "tma_l3_hit_latency",
> > >          "MetricThreshold": "tma_l3_hit_latency > 0.1 & (tma_l3_bound=
 > 0.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
> > > -        "PublicDescription": "This metric estimates fraction of cycl=
es with demand load accesses that hit the L3 cache under unloaded scenarios=
 (possibly L3 latency limited).  Avoiding private cache misses (i.e. L2 mis=
ses/L3 hits) will improve the latency; reduce contention with sibling physi=
cal cores and increase performance.  Note the value of this node may overla=
p with its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS. Related metri=
cs: tma_mem_latency",
> > > +        "PublicDescription": "This metric estimates fraction of cycl=
es with demand load accesses that hit the L3 cache under unloaded scenarios=
 (possibly L3 latency limited).  Avoiding private cache misses (i.e. L2 mis=
ses/L3 hits) will improve the latency; reduce contention with sibling physi=
cal cores and increase performance.  Note the value of this node may overla=
p with its siblings. Sample with: MEM_LOAD_L2_MISS_RETIRED.L3_HIT_SAME_CBB.=
 Related metrics: tma_mem_latency",
> > > +        "ScaleUnit": "100%"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "This metric estimates how often the CPU=
 was stalled on accesses to external memory (DRAM) by loads",
> > > +        "MetricExpr": "(1 - MEM_LOAD_UOPS_RETIRED.L3_HIT / (MEM_LOAD=
_UOPS_RETIRED.L3_HIT + 7 * MEM_LOAD_UOPS_RETIRED.L3_MISS)) * CYCLE_ACTIVITY=
.STALLS_L2_MISS / tma_info_thread_clks",
> > > +        "MetricGroup": "MemoryBound;Offcore;TmaL3mem;TopdownL3;tma_L=
3_group;tma_memory_bound_group",
> > > +        "MetricName": "tma_l3_miss_bound",
> >
> > [Severity: Medium]
> > Just like the Broadwell metric above, should this also include the
> > NO_GROUP_EVENTS_SMT constraint to prevent SMT scheduling failures for
> > CYCLE_ACTIVITY.STALLS_L2_MISS?
> >
> > > diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.js=
on b/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
> > > index 5b83b040060c3..6b914b29bff95 100644
> > > --- a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
> > > +++ b/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
> > [ ... ]
> > > @@ -1050,7 +1034,16 @@
> > >          "MetricGroup": "BvML;MemoryLat;TopdownL4;tma_L4_group;tma_is=
sueLat;tma_l3_bound_group",
> > >          "MetricName": "tma_l3_hit_latency",
> > >          "MetricThreshold": "tma_l3_hit_latency > 0.1 & (tma_l3_bound=
 > 0.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
> > > -        "PublicDescription": "This metric estimates fraction of cycl=
es with demand load accesses that hit the L3 cache under unloaded scenarios=
 (possibly L3 latency limited).  Avoiding private cache misses (i.e. L2 mis=
ses/L3 hits) will improve the latency; reduce contention with sibling physi=
cal cores and increase performance.  Note the value of this node may overla=
p with its siblings. Sample with: MEM_LOAD_UOPS_RETIRED.L3_HIT_PS. Related =
metrics: tma_mem_latency",
> > > +        "PublicDescription": "This metric estimates fraction of cycl=
es with demand load accesses that hit the L3 cache under unloaded scenarios=
 (possibly L3 latency limited).  Avoiding private cache misses (i.e. L2 mis=
ses/L3 hits) will improve the latency; reduce contention with sibling physi=
cal cores and increase performance.  Note the value of this node may overla=
p with its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS. Related metri=
cs: tma_mem_latency",
> > > +        "ScaleUnit": "100%"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "This metric estimates how often the CPU=
 was stalled on accesses to external memory (DRAM) by loads",
> > > +        "MetricExpr": "(1 - MEM_LOAD_UOPS_RETIRED.L3_HIT / (MEM_LOAD=
_UOPS_RETIRED.L3_HIT + 7 * MEM_LOAD_UOPS_RETIRED.L3_MISS)) * CYCLE_ACTIVITY=
.STALLS_L2_MISS / tma_info_thread_clks",
> > > +        "MetricGroup": "MemoryBound;Offcore;TmaL3mem;TopdownL3;tma_L=
3_group;tma_memory_bound_group",
> > > +        "MetricName": "tma_l3_miss_bound",
> >
> > [Severity: Medium]
> > This appears to be missing the NO_GROUP_EVENTS_SMT constraint here as w=
ell
> > for the broadwellx architecture.
> >
> > --
> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924170346.=
3872848-1-irogers@google.com?part=3D4
