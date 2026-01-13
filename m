Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3DF276051
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Jan 2026 20:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768336917; cv=pass; b=GgAZQNnz/NgMMcpyZp0f/QqpXv8Dy9hShguAVUi3xS/pNmgbZRjYYYA3axIaMaB3oGZuPOGFzwTMpuP/EqfC1b8t9L9bS/07bvJB5w1b50uRaj8m2hqhG9CzcVOQ7vz0OK4Q2t1m+yuwhwz2Ci3NaAEUJbQbb2cuHe9iQDeZgeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768336917; c=relaxed/simple;
	bh=/OSrMv1qJd1r2a1toohMqrY9kE18lXPEryNWgFbOY5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aTmeCS8Uk4SGGntTjjA6Q+eLGV/RgRC/c9EgFEcWLemIdqna23tJCJgTM6vTMtZcxXTpnaoQuXApUy1WbbZhqkpbMmqAXI0TNd0BK0eTntaZr7/AHEjMBxMM/xiqNni+77q3/vDmtagkapMTuhaq7TSl4gfmhy0WAg0SfPBo2Eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m4l8Z9cm; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m4l8Z9cm"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a1462573caso17835ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jan 2026 12:41:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768336916; cv=none;
        d=google.com; s=arc-20240605;
        b=VzncT30uBo8ALtf/fXsV5zCWfqro0y8lX8yV/CA5uSksscmRIaYnGX27h+PhkkYRLL
         zcnBbCdrt7JeXisWXP8KM2a1F5qJiuqbr7vYgEH5SCjh/bu8AV3QtmlzTsHW8Id0PVXa
         +sa1iSG6WU2JsgdM4+dcM0aIqNfzhFaGbMW4+8/gbsFTmU7JHBhwG8uYkp/beU6/bXj/
         FwTva43cPQOAU+oo5RblE7VntdVfBEVvlXqJvrNB1msmwxMG+ATbDjtd8U5FNKnVGFuq
         E4q0ecWS0TPiJp482Kgd9SMOxPh8N3BBAxQMtQhU7MhANh/mIB1zmTlvMPdiySR2VBOQ
         bGug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TcBsDIxv8f+cT1mZsoEg4PqbDwkFERBBFV3Y3qGdTrE=;
        fh=8IaJs0SISzvUM86jmNHstdxgiBN8u/yYiumSRQE3aFQ=;
        b=Ajr68F9fRCNPcIoG6+CRxLOpbYvJeJZ39R+RNHsj0alNsfFSlyFtcIYWVtHvV/RGQh
         cCqOI7RLNnXzf5HhFk6h6+onVruUTuKtSn8GwYobJoYSfFvwN/6/ns0ZJoC/0lC+gEn6
         wT+zbMz9htFgoBi7TGFkUkT6iQB1hAB83Wqmre67EmD8ZHGhaRYFSC5bwFBHrUXI1hAL
         rT8g6pZOdMpXrjSG4WN6rGROe0ESqRnECTEQix+8ayFTIKMVRJpJMOIYEJHYvFhH8/QV
         TsP83p/Mve+HON2qSn8JH2XXQ8e8hVHd3B7xJUN1XMCB7TvLaJB1B0tWtzAZWe6rFshp
         araw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768336916; x=1768941716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcBsDIxv8f+cT1mZsoEg4PqbDwkFERBBFV3Y3qGdTrE=;
        b=m4l8Z9cmeADVY+WgICYpzJeSW5efMafpiwFEQNFWg4MaYNK9eQgE7xHiJeSf97MxSy
         2jbtbk3YJgIRfcC+ObejOKHEmg/RdSJ2SWZSaanzYQDuB5uH2Zz2g7kCCVikj2qpTpgi
         c44jq23S/6JvA993EIuxhDDHOgvy//U61yypSf3Pii5lidzEi/P44GnRWHCu3R5J+lyL
         e/X/C+4W7EMqR95DudWZ4l+K1IXltISW+lZX7s/sUU7ZEZqR74yl/PAF298Fe5A/jYGY
         TOdILgBu95MAjmycDOQ28CaNfILpzkNgkoN2koT/2xiwF3MoiXEEmdw6B3hKBp1u5Ha0
         Z87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768336916; x=1768941716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TcBsDIxv8f+cT1mZsoEg4PqbDwkFERBBFV3Y3qGdTrE=;
        b=mU5EqdguIs1MP0j993t5gRRvQTA/eqvPPLLSsglS1Eym9Zap/k3Xbo/yPMCjJ6E6nV
         rIzCKYwiWCs62E8VybWJt7yn6T5MhKlk17LeyG1k308cDik+calmYNeZip+XRM3zO677
         E5ok8hnJ3sg/2pCrie67IeGcSIDAZBbDjP+F6toOhaC148TK0XPEPwRpaH50BrbkVve/
         94U5pOmrnYb3JTijmi0a1vO3yr7VKAG4Tfp59lnqpxKLWtoZJ0vlhFGp7KInCgeJCkI8
         G9S8P7ggDfeGGlp9DqA3Dfoqa9I7j09hZoy9RqtsAe8JFexOqSs1yVORuWYPnYbQDRlO
         caSA==
X-Forwarded-Encrypted: i=1; AJvYcCX3Il97FthadvhytCENXT0myvURlPJgFjTkuzzX7MsaqF0UANKujZANWKwU02BVrAHCDubNc07YfpZMHPB3zWTL@vger.kernel.org
X-Gm-Message-State: AOJu0YwHOpj8CczFLT2UXslEntaEuPLTDY84hdcyWicheLhMumDNJt43
	jfUU5lX/2LQRhUyO1X8kH1AungIo1L1VCCDrALvVI22bwYRTwoTh6fHy1uAO6r45GhMasJrxBtn
	3BzW1gLa1vYEWmKz2MF90NAnR0+JAc1A/NHgmAFsm
X-Gm-Gg: AY/fxX5zDPljfubRL1Y60OphzaydlRit4kXBJkfnSm/PSt6cMz9PPQXVGg+RN3gYXBi
	kK+ni/D9DlxvRbBB6j9q536st6CzJT0lGK61p9ImAWf1WgSCzOA/zX2iuzQBg4eS4203KydRMRz
	arYks3/J3gWu5IAEqM44ZWV9wsh2LJBWyMUUFfqdcXsXB6iWeT2vrAKS6hilJSX+JwaXMn54wbU
	3TJWhwoYTdGHql3yX6Yy57c9Eo5UAwnCrM9CMLE0zbAi2z9Agfma3VRkmmDOdFuBgy8GRd+hkTW
	ObuxmnYV/3THtVOFaG3oUg4TPA==
X-Received: by 2002:a17:903:18a:b0:29f:181c:1f0 with SMTP id
 d9443c01a7336-2a599b9b1camr531065ad.11.1768336915242; Tue, 13 Jan 2026
 12:41:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1767858676.git.sandipan.das@amd.com> <b00e27727d8aea8cf49c5e6e08b29357d04bc2b8.1767858676.git.sandipan.das@amd.com>
 <aWaqmlLZ9NGpY6Ys@x1>
In-Reply-To: <aWaqmlLZ9NGpY6Ys@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 13 Jan 2026 12:41:42 -0800
X-Gm-Features: AZwV_Qj4dkZW42wlWiyw9HzPL8F3W8kmDq8AVtAKUTRaDZzvm4Se7T3CMQDAN8s
Message-ID: <CAP-5=fX6=wj+xZa4dK=5mjAoDJX7KreK1dMAT-o3aH9BkWZyVg@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf vendor events amd: Add Zen 6 uncore events
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Sandipan Das <sandipan.das@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Stephane Eranian <eranian@google.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Ananth Narayan <ananth.narayan@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 12:27=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Jan 08, 2026 at 01:22:15PM +0530, Sandipan Das wrote:
> > Add uncore events taken from Section 1.6 "L3 Cache Performance Monitor
> > Counters" and Section 2.2 "UMC Performance Monitor Events" of the
> > Performance Monitor Counters for AMD Family 1Ah Model 50h-57h Processor=
s
> > document available at the link below.
> >
> > This constitutes events which capture L3 cache and UMC command activity=
.
>
>   LD      /tmp/build/perf-tools-next/perf-util-in.o
>   AR      /tmp/build/perf-tools-next/libperf-util.a
>   CC      /tmp/build/perf-tools-next/pmu-events/pmu-events.o
> /tmp/build/perf-tools-next/pmu-events/pmu-events.c:30902:37: error: =E2=
=80=98pmu_events__amdzen6=E2=80=99 defined but not used [-Werror=3Dunused-c=
onst-variable=3D]
> 30902 | static const struct pmu_table_entry pmu_events__amdzen6[] =3D {
>       |                                     ^~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[3]: *** [pmu-events/Build:89: /tmp/build/perf-tools-next/pmu-events/=
pmu-events.o] Error 1
> make[2]: *** [Makefile.perf:772: /tmp/build/perf-tools-next/pmu-events/pm=
u-events-in.o] Error 2
> make[1]: *** [Makefile.perf:288: sub-make] Error 2
> make: *** [Makefile:119: install-bin] Error 2
> make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
> =E2=AC=A2 [acme@toolbx perf-tools-next]$
>
> When building at this patch (2/4) it breaks, lemme see if at the end it
> works, but even then this can't stand this way, as we break bisection...
>
> Then, on 3/4 we get:
>
>   CC      /tmp/build/perf-tools-next/pmu-events/pmu-events.o
> /tmp/build/perf-tools-next/pmu-events/pmu-events.c:30992:37: error: =E2=
=80=98pmu_metrics__amdzen6=E2=80=99 defined but not used [-Werror=3Dunused-=
const-variable=3D]
> 30992 | static const struct pmu_table_entry pmu_metrics__amdzen6[] =3D {
>       |                                     ^~~~~~~~~~~~~~~~~~~~
> /tmp/build/perf-tools-next/pmu-events/pmu-events.c:30908:37: error: =E2=
=80=98pmu_events__amdzen6=E2=80=99 defined but not used [-Werror=3Dunused-c=
onst-variable=3D]
> 30908 | static const struct pmu_table_entry pmu_events__amdzen6[] =3D {
>       |                                     ^~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[3]: *** [pmu-events/Build:89: /tmp/build/perf-tools-next/pmu-events/=
pmu-events.o] Error 1
> make[2]: *** [Makefile.perf:772: /tmp/build/perf-tools-next/pmu-events/pm=
u-events-in.o] Error 2
> make[1]: *** [Makefile.perf:288: sub-make] Error 2
> make: *** [Makefile:119: install-bin] Error 2
> make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
> =E2=AC=A2 [acme@toolbx perf-tools-next]$
>
> Finally, on 4/4 everything builds.
>
> Can you please take a look to check how we can keep all bisection happy?

So patch 4 adds the mapfile.csv change and that's the thing that
creates the references to the zen6 tables that is failing when
building with the earlier patches. If patch 4 is made patch 1 then the
series builds at each step (1,2,3,4) for me.

Thanks,
Ian

> - Arnaldo
>
> > Link: https://bugzilla.kernel.org/attachment.cgi?id=3D309149
> > Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> > ---
> >  .../pmu-events/arch/x86/amdzen6/l3-cache.json | 177 ++++++++++++++++++
> >  .../arch/x86/amdzen6/memory-controller.json   | 101 ++++++++++
> >  2 files changed, 278 insertions(+)
> >  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/l3-cache.jso=
n
> >  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/memory-contr=
oller.json
> >
> > diff --git a/tools/perf/pmu-events/arch/x86/amdzen6/l3-cache.json b/too=
ls/perf/pmu-events/arch/x86/amdzen6/l3-cache.json
> > new file mode 100644
> > index 000000000000..9b9804317da7
> > --- /dev/null
> > +++ b/tools/perf/pmu-events/arch/x86/amdzen6/l3-cache.json
> > @@ -0,0 +1,177 @@
> > +[
> > +  {
> > +    "EventName": "l3_lookup_state.l3_miss",
> > +    "EventCode": "0x04",
> > +    "BriefDescription": "L3 cache misses.",
> > +    "UMask": "0x01",
> > +    "Unit": "L3PMC"
> > +  },
> > +  {
> > +    "EventName": "l3_lookup_state.l3_hit",
> > +    "EventCode": "0x04",
> > +    "BriefDescription": "L3 cache hits.",
> > +    "UMask": "0xfe",
> > +    "Unit": "L3PMC"
> > +  },
> > +  {
> > +    "EventName": "l3_lookup_state.all_coherent_accesses_to_l3",
> > +    "EventCode": "0x04",
> > +    "BriefDescription": "L3 cache requests for all coherent accesses."=
,
> > +    "UMask": "0xff",
> > +    "Unit": "L3PMC"
> > +  },
> > +  {
> > +    "EventName": "l3_xi_sampled_latency.dram_near",
> > +    "EventCode": "0xac",
> > +    "BriefDescription": "Average sampled latency for L3 requests where=
 data is returned from DRAM in the same NUMA node.",
> > +    "UMask": "0x01",
> > +    "EnAllCores": "0x1",
> > +    "EnAllSlices": "0x1",
> > +    "SliceId": "0x3",
> > +    "ThreadMask": "0x3",
> > +    "Unit": "L3PMC"
> > +  },
> > +  {
> > +    "EventName": "l3_xi_sampled_latency.dram_far",
> > +    "EventCode": "0xac",
> > +    "BriefDescription": "Average sampled latency for L3 requests where=
 data is returned from DRAM in a different NUMA node.",
> > +    "UMask": "0x02",
> > +    "EnAllCores": "0x1",
> > +    "EnAllSlices": "0x1",
> > +    "SliceId": "0x3",
> > +    "ThreadMask": "0x3",
> > +    "Unit": "L3PMC"
> > +  },
> > +  {
> > +    "EventName": "l3_xi_sampled_latency.near_cache",
> > +    "EventCode": "0xac",
> > +    "BriefDescription": "Average sampled latency for L3 requests where=
 data is returned from cache of another CCX in the same NUMA node.",
> > +    "UMask": "0x04",
> > +    "EnAllCores": "0x1",
> > +    "EnAllSlices": "0x1",
> > +    "SliceId": "0x3",
> > +    "ThreadMask": "0x3",
> > +    "Unit": "L3PMC"
> > +  },
> > +  {
> > +    "EventName": "l3_xi_sampled_latency.far_cache",
> > +    "EventCode": "0xac",
> > +    "BriefDescription": "Average sampled latency for L3 requests where=
 data is returned from cache of another CCX in a different NUMA node.",
> > +    "UMask": "0x08",
> > +    "EnAllCores": "0x1",
> > +    "EnAllSlices": "0x1",
> > +    "SliceId": "0x3",
> > +    "ThreadMask": "0x3",
> > +    "Unit": "L3PMC"
> > +  },
> > +  {
> > +    "EventName": "l3_xi_sampled_latency.ext_near",
> > +    "EventCode": "0xac",
> > +    "BriefDescription": "Average sampled latency for L3 requests where=
 data is returned from extension memory (CXL) in the same NUMA node.",
> > +    "UMask": "0x10",
> > +    "EnAllCores": "0x1",
> > +    "EnAllSlices": "0x1",
> > +    "SliceId": "0x3",
> > +    "ThreadMask": "0x3",
> > +    "Unit": "L3PMC"
> > +  },
> > +  {
> > +    "EventName": "l3_xi_sampled_latency.ext_far",
> > +    "EventCode": "0xac",
> > +    "BriefDescription": "Average sampled latency for L3 requests where=
 data is returned from extension memory (CXL) in a different NUMA node.",
> > +    "UMask": "0x20",
> > +    "EnAllCores": "0x1",
> > +    "EnAllSlices": "0x1",
> > +    "SliceId": "0x3",
> > +    "ThreadMask": "0x3",
> > +    "Unit": "L3PMC"
> > +  },
> > +  {
> > +    "EventName": "l3_xi_sampled_latency.all",
> > +    "EventCode": "0xac",
> > +    "BriefDescription": "Average sampled latency for L3 requests where=
 data is returned from all types of sources.",
> > +    "UMask": "0x3f",
> > +    "EnAllCores": "0x1",
> > +    "EnAllSlices": "0x1",
> > +    "SliceId": "0x3",
> > +    "ThreadMask": "0x3",
> > +    "Unit": "L3PMC"
> > +  },
> > +  {
> > +    "EventName": "l3_xi_sampled_latency_requests.dram_near",
> > +    "EventCode": "0xad",
> > +    "BriefDescription": "Average sampled L3 requests where data is ret=
urned from DRAM in the same NUMA node.",
> > +    "UMask": "0x01",
> > +    "EnAllCores": "0x1",
> > +    "EnAllSlices": "0x1",
> > +    "SliceId": "0x3",
> > +    "ThreadMask": "0x3",
> > +    "Unit": "L3PMC"
> > +  },
> > +  {
> > +    "EventName": "l3_xi_sampled_latency_requests.dram_far",
> > +    "EventCode": "0xad",
> > +    "BriefDescription": "Average sampled L3 requests where data is ret=
urned from DRAM in a different NUMA node.",
> > +    "UMask": "0x02",
> > +    "EnAllCores": "0x1",
> > +    "EnAllSlices": "0x1",
> > +    "SliceId": "0x3",
> > +    "ThreadMask": "0x3",
> > +    "Unit": "L3PMC"
> > +  },
> > +  {
> > +    "EventName": "l3_xi_sampled_latency_requests.near_cache",
> > +    "EventCode": "0xad",
> > +    "BriefDescription": "Average sampled L3 requests where data is ret=
urned from cache of another CCX in the same NUMA node.",
> > +    "UMask": "0x04",
> > +    "EnAllCores": "0x1",
> > +    "EnAllSlices": "0x1",
> > +    "SliceId": "0x3",
> > +    "ThreadMask": "0x3",
> > +    "Unit": "L3PMC"
> > +  },
> > +  {
> > +    "EventName": "l3_xi_sampled_latency_requests.far_cache",
> > +    "EventCode": "0xad",
> > +    "BriefDescription": "Average sampled L3 requests where data is ret=
urned from cache of another CCX in a different NUMA node.",
> > +    "UMask": "0x08",
> > +    "EnAllCores": "0x1",
> > +    "EnAllSlices": "0x1",
> > +    "SliceId": "0x3",
> > +    "ThreadMask": "0x3",
> > +    "Unit": "L3PMC"
> > +  },
> > +  {
> > +    "EventName": "l3_xi_sampled_latency_requests.ext_near",
> > +    "EventCode": "0xad",
> > +    "BriefDescription": "Average sampled L3 requests where data is ret=
urned from extension memory (CXL) in the same NUMA node.",
> > +    "UMask": "0x10",
> > +    "EnAllCores": "0x1",
> > +    "EnAllSlices": "0x1",
> > +    "SliceId": "0x3",
> > +    "ThreadMask": "0x3",
> > +    "Unit": "L3PMC"
> > +  },
> > +  {
> > +    "EventName": "l3_xi_sampled_latency_requests.ext_far",
> > +    "EventCode": "0xad",
> > +    "BriefDescription": "Average sampled L3 requests where data is ret=
urned from extension memory (CXL) in a different NUMA node.",
> > +    "UMask": "0x20",
> > +    "EnAllCores": "0x1",
> > +    "EnAllSlices": "0x1",
> > +    "SliceId": "0x3",
> > +    "ThreadMask": "0x3",
> > +    "Unit": "L3PMC"
> > +  },
> > +  {
> > +    "EventName": "l3_xi_sampled_latency_requests.all",
> > +    "EventCode": "0xad",
> > +    "BriefDescription": "Average sampled L3 requests where data is ret=
urned from all types of sources.",
> > +    "UMask": "0x3f",
> > +    "EnAllCores": "0x1",
> > +    "EnAllSlices": "0x1",
> > +    "SliceId": "0x3",
> > +    "ThreadMask": "0x3",
> > +    "Unit": "L3PMC"
> > +  }
> > +]
> > diff --git a/tools/perf/pmu-events/arch/x86/amdzen6/memory-controller.j=
son b/tools/perf/pmu-events/arch/x86/amdzen6/memory-controller.json
> > new file mode 100644
> > index 000000000000..649a60b09e1b
> > --- /dev/null
> > +++ b/tools/perf/pmu-events/arch/x86/amdzen6/memory-controller.json
> > @@ -0,0 +1,101 @@
> > +[
> > +  {
> > +    "EventName": "umc_mem_clk",
> > +    "PublicDescription": "Memory clock (MEMCLK) cycles.",
> > +    "EventCode": "0x00",
> > +    "PerPkg": "1",
> > +    "Unit": "UMCPMC"
> > +  },
> > +  {
> > +    "EventName": "umc_act_cmd.all",
> > +    "PublicDescription": "ACTIVATE commands sent.",
> > +    "EventCode": "0x05",
> > +    "PerPkg": "1",
> > +    "Unit": "UMCPMC"
> > +  },
> > +  {
> > +    "EventName": "umc_act_cmd.rd",
> > +    "PublicDescription": "ACTIVATE commands sent for reads.",
> > +    "EventCode": "0x05",
> > +    "RdWrMask": "0x1",
> > +    "PerPkg": "1",
> > +    "Unit": "UMCPMC"
> > +  },
> > +  {
> > +    "EventName": "umc_act_cmd.wr",
> > +    "PublicDescription": "ACTIVATE commands sent for writes.",
> > +    "EventCode": "0x05",
> > +    "RdWrMask": "0x2",
> > +    "PerPkg": "1",
> > +    "Unit": "UMCPMC"
> > +  },
> > +  {
> > +    "EventName": "umc_pchg_cmd.all",
> > +    "PublicDescription": "PRECHARGE commands sent.",
> > +    "EventCode": "0x06",
> > +    "PerPkg": "1",
> > +    "Unit": "UMCPMC"
> > +  },
> > +  {
> > +    "EventName": "umc_pchg_cmd.rd",
> > +    "PublicDescription": "PRECHARGE commands sent for reads.",
> > +    "EventCode": "0x06",
> > +    "RdWrMask": "0x1",
> > +    "PerPkg": "1",
> > +    "Unit": "UMCPMC"
> > +  },
> > +  {
> > +    "EventName": "umc_pchg_cmd.wr",
> > +    "PublicDescription": "PRECHARGE commands sent for writes.",
> > +    "EventCode": "0x06",
> > +    "RdWrMask": "0x2",
> > +    "PerPkg": "1",
> > +    "Unit": "UMCPMC"
> > +  },
> > +  {
> > +    "EventName": "umc_cas_cmd.all",
> > +    "PublicDescription": "CAS commands sent.",
> > +    "EventCode": "0x0a",
> > +    "PerPkg": "1",
> > +    "Unit": "UMCPMC"
> > +  },
> > +  {
> > +    "EventName": "umc_cas_cmd.rd",
> > +    "PublicDescription": "CAS commands sent for reads.",
> > +    "EventCode": "0x0a",
> > +    "RdWrMask": "0x1",
> > +    "PerPkg": "1",
> > +    "Unit": "UMCPMC"
> > +  },
> > +  {
> > +    "EventName": "umc_cas_cmd.wr",
> > +    "PublicDescription": "CAS commands sent for writes.",
> > +    "EventCode": "0x0a",
> > +    "RdWrMask": "0x2",
> > +    "PerPkg": "1",
> > +    "Unit": "UMCPMC"
> > +  },
> > +  {
> > +    "EventName": "umc_data_slot_clks.all",
> > +    "PublicDescription": "Clock cycles where the data bus is utilized.=
",
> > +    "EventCode": "0x14",
> > +    "PerPkg": "1",
> > +    "Unit": "UMCPMC"
> > +  },
> > +  {
> > +    "EventName": "umc_data_slot_clks.rd",
> > +    "PublicDescription": "Clock cycles where the data bus is utilized =
for reads.",
> > +    "EventCode": "0x14",
> > +    "RdWrMask": "0x1",
> > +    "PerPkg": "1",
> > +    "Unit": "UMCPMC"
> > +  },
> > +  {
> > +    "EventName": "umc_data_slot_clks.wr",
> > +    "PublicDescription": "Clock cycles where the data bus is utilized =
for writes.",
> > +    "EventCode": "0x14",
> > +    "RdWrMask": "0x2",
> > +    "PerPkg": "1",
> > +    "Unit": "UMCPMC"
> > +  }
> > +]
> > --
> > 2.43.0
