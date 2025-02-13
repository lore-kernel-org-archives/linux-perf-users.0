Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011A6211A36
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465606; cv=none; b=nMwUV/PHKzK7dUuOxwS4LmJ5SjRqFfkEnr1AzSxpew2f9Q1OPWrx/D9f9xG+86yTZx7jdeldv2LQJPjqPK7aHh3Liy3B7se1Edk3+Q3iNPT2QfFeUJq6eEPWQdMB22HQhCsaF105WFVBIGDdcZ73IOBgrE/NL4N6cr4SOK/Cllk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465606; c=relaxed/simple;
	bh=6T0mX9ZhL0XsmuME/k3bIy1idwLPlptw/K6lISNL8K4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b1n8N0LsF3X+CCZIKH5UKjZb4exA+DWZ+LB3Co4sfKKK26x7KIkwaCb1qXahJ4+lLp3ZDSZqv9x2TJaEwcK+UhqQnInd/T5Tw6v9trEaMqDWrcSiiSHUjTq4YMkJhdxogsw8qEhDjwdSeDcJ/BYhEHIMhWPv2m3WBL7lBuXyAgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xrPCvYCO; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xrPCvYCO"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d18c325ee4so142765ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 08:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739465601; x=1740070401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZE0eTa44fmzSCx9MsehJYA8cgkvdHRfk3OC03JLTqM=;
        b=xrPCvYCOYPuwwWgXVEY1PZ4MgDJp8oOqiBXI0TAjbE7lt3RsB6yBpSq8JpG/dFFZ+o
         aNxb3PbmtiITdvkrcCsEG6LkmuIuHsudLMEzq3V42PUWnhL0vo64qw8nEgq70nOarjX0
         kZWFEjevykfP2dz5taoyFd90zsqjEVwd3aaM7PdL6swSh1cfdKOxkpmEk5NaZmJx0pL1
         +JPZAAVjrtRjuEEZetT1ANQ6FboEYKYPmle6D09Jp1gfliLd/I3t86pb+8HcHyHiz5WK
         HNGGYHmeVe/CFtfIJzPh82uer0MviLh+JJVQ2dBbiM+W/8sa+S0O6qq/xROdBer58mU0
         koWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739465601; x=1740070401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZE0eTa44fmzSCx9MsehJYA8cgkvdHRfk3OC03JLTqM=;
        b=jv+/2nJxwYU+HDwAyKkH9d/VTMUH+GPWUIvRxGa9rCrGofpCtDVkKmcQXsLUGyCn3l
         bxmTvSC0a7Z0Nf/ANNRrC+o/V59gM78RfPxLcfHAYlyEa5nPCQ0qPY6cNg30+FADe11a
         pXtyixbjqzo86PDtNdvuRcSG+e+UtVoccGfdcUXh9Cy33BuKN3Mr+0KGp5sugQ1jLKmB
         OMjb+A7ADHm9mtAMm6CVw3CO2OCSULtUsZpo5iMgKXrfH8t5xMAKA8maSJQ5aUeHb430
         QEYoGvg24ZNpYrHOaH8uwSlSgW7h9d6oxJxxdnV+TRVvCKfr04HSZU/5XgBGhKXmcEZi
         Rf9g==
X-Gm-Message-State: AOJu0Yw+qOrGVLALA6Naz+JnPHmDx865sR9Yr/69KyABiHuneei04vS7
	ZtYy8cseDa0rsJJ9qoUFLcJ4oayWkRsaZgjcEyNRu+ug1wl2DcR/qRh7jfv8NS9FibiaZF3761W
	tD0Y5+HzLETpP3qiSBVbo3nnf6FUjfTchRthN
X-Gm-Gg: ASbGncuUuwYRAbItGhXMJG3Gl+Qc2P/yBS65iLrxpjsnGMcBTbz/fTeaGfjsqneGXdP
	leUHpDVaZgm/4KdBiaY8h1GvdQFX/upVvRhS76Adrkp8+oIwtqCHZ0DnUC+N8/apTEZ4rCldvkb
	2eZRlcfQthwuIZGEpThY4i7ZNx
X-Google-Smtp-Source: AGHT+IEiv0Y7mRvfkOAu2GOsj7N3jEkG5aMGodBM+1ZhlrCT6uynlJBMmp3vAvmp04VN07Z/lRRlSsJef5x6L4EYmdE=
X-Received: by 2002:a05:6e02:194c:b0:3d1:78cb:b297 with SMTP id
 e9e14a558f8ab-3d18e294cdfmr3331435ab.29.1739465600094; Thu, 13 Feb 2025
 08:53:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_5360DA048EE5B8CF3104213F8D037C698208@qq.com> <tencent_E5686B3956E04AC548862C35FAF03909E20A@qq.com>
In-Reply-To: <tencent_E5686B3956E04AC548862C35FAF03909E20A@qq.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 13 Feb 2025 08:53:07 -0800
X-Gm-Features: AWEUYZntArEXZKw-1Em9yVg-E37umZ11u7VZ0TWgV4yi9yZy_jyQMj6QVm6MyV8
Message-ID: <CAP-5=fX8Bwymn-AxdhtifFPrhzmTdbXbzgaQKGT-dr_i4+9_aQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf vendor events arm64: Add Cortex-A520 events/metrics
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Liang Kan <kan.liang@linux.intel.com>, 
	Yoshihiro Furudera <fj5100bi@fujitsu.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 7:19=E2=80=AFAM Yangyu Chen <cyy@cyyself.name> wrot=
e:
>
> Add JSON files for Cortex-A520 events and metrics. Using the existing
> Neoverse N3 JSON files as a template, I manually checked the missing and
> extra events/metrics using my script [1] and modified them according to
> the Arm Cortex-A520 Core Technical Reference Manual [2].

Thanks for this! Similar notes to the other patch. On the testing
front, if automation would be possible then new tests would be great.
For example, making sure the sum of topdown metrics is 100%. There are
similar tests for Intel here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/shell/stat_metrics_values.sh?h=3Dperf-tools-next

Thanks,
Ian

> [1] https://github.com/cyyself/arm-pmu-check/tree/1075bebeb3f144106744825=
1a387df35af15bf16
> [2] https://developer.arm.com/documentation/102517/0004/Performance-Monit=
ors-Extension-support-/Performance-monitors-events/Common-event-PMU-events
>
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> ---
>  .../arch/arm64/arm/cortex-a520/bus.json       |  26 ++
>  .../arch/arm64/arm/cortex-a520/exception.json |  18 +
>  .../arm64/arm/cortex-a520/fp_operation.json   |  14 +
>  .../arch/arm64/arm/cortex-a520/general.json   |   6 +
>  .../arch/arm64/arm/cortex-a520/l1d_cache.json |  50 +++
>  .../arch/arm64/arm/cortex-a520/l1i_cache.json |  14 +
>  .../arch/arm64/arm/cortex-a520/l2_cache.json  |  46 +++
>  .../arch/arm64/arm/cortex-a520/l3_cache.json  |  21 +
>  .../arch/arm64/arm/cortex-a520/ll_cache.json  |  10 +
>  .../arch/arm64/arm/cortex-a520/memory.json    |  58 +++
>  .../arch/arm64/arm/cortex-a520/metrics.json   | 373 ++++++++++++++++++
>  .../arch/arm64/arm/cortex-a520/pmu.json       |   8 +
>  .../arch/arm64/arm/cortex-a520/retired.json   |  90 +++++
>  .../arm64/arm/cortex-a520/spec_operation.json |  70 ++++
>  .../arch/arm64/arm/cortex-a520/stall.json     |  82 ++++
>  .../arch/arm64/arm/cortex-a520/sve.json       |  22 ++
>  .../arch/arm64/arm/cortex-a520/tlb.json       |  78 ++++
>  .../arch/arm64/arm/cortex-a520/trace.json     |  32 ++
>  .../arch/arm64/common-and-microarch.json      |  15 +
>  tools/perf/pmu-events/arch/arm64/mapfile.csv  |   1 +
>  20 files changed, 1034 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/bus.=
json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/exce=
ption.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/fp_o=
peration.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/gene=
ral.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l1d_=
cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l1i_=
cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l2_c=
ache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l3_c=
ache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/ll_c=
ache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/memo=
ry.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/metr=
ics.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/pmu.=
json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/reti=
red.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/spec=
_operation.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/stal=
l.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/sve.=
json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/tlb.=
json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/trac=
e.json
>
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/bus.json b/=
tools/perf/pmu-events/arch/arm64/arm/cortex-a520/bus.json
> new file mode 100644
> index 000000000000..884e42ab6a49
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/bus.json
> @@ -0,0 +1,26 @@
> +[
> +    {
> +        "ArchStdEvent": "BUS_ACCESS",
> +        "PublicDescription": "Counts memory transactions issued by the C=
PU to the external bus, including snoop requests and snoop responses. Each =
beat of data is counted individually."
> +    },
> +    {
> +        "ArchStdEvent": "BUS_CYCLES",
> +        "PublicDescription": "Counts bus cycles in the CPU. Bus cycles r=
epresent a clock cycle in which a transaction could be sent or received on =
the interface from the CPU to the external bus. Since that interface is dri=
ven at the same clock speed as the CPU, this event is a duplicate of CPU_CY=
CLES."
> +    },
> +    {
> +        "ArchStdEvent": "BUS_ACCESS_RD",
> +        "PublicDescription": "Counts memory read transactions seen on th=
e external bus. Each beat of data is counted individually."
> +    },
> +    {
> +        "ArchStdEvent": "BUS_ACCESS_WR",
> +        "PublicDescription": "Counts memory write transactions seen on t=
he external bus. Each beat of data is counted individually."
> +    },
> +    {
> +        "ArchStdEvent": "BUS_REQ_RD_PERCYC",
> +        "PublicDescription": "Bus read transactions in progress."
> +    },
> +    {
> +        "ArchStdEvent": "BUS_REQ_RD",
> +        "BriefDescription": "Bus request, read"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/exception.j=
son b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/exception.json
> new file mode 100644
> index 000000000000..fbe580e15c2e
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/exception.json
> @@ -0,0 +1,18 @@
> +[
> +    {
> +        "ArchStdEvent": "EXC_TAKEN",
> +        "PublicDescription": "Counts any taken architecturally visible e=
xceptions such as IRQ, FIQ, SError, and other synchronous exceptions. Excep=
tions are counted whether or not they are taken locally."
> +    },
> +    {
> +        "ArchStdEvent": "EXC_RETURN",
> +        "PublicDescription": "Counts any architecturally executed except=
ion return instructions. For example: AArch64: ERET"
> +    },
> +    {
> +        "ArchStdEvent": "EXC_IRQ",
> +        "PublicDescription": "Counts IRQ exceptions including the virtua=
l IRQs that are taken locally."
> +    },
> +    {
> +        "ArchStdEvent": "EXC_FIQ",
> +        "PublicDescription": "Counts FIQ exceptions including the virtua=
l FIQs that are taken locally."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/fp_operatio=
n.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/fp_operation.json
> new file mode 100644
> index 000000000000..da0c4b05ad5b
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/fp_operation.json
> @@ -0,0 +1,14 @@
> +[
> +    {
> +        "ArchStdEvent": "FP_HP_SPEC",
> +        "PublicDescription": "Counts speculatively executed half precisi=
on floating point operations."
> +    },
> +    {
> +        "ArchStdEvent": "FP_SP_SPEC",
> +        "PublicDescription": "Counts speculatively executed single preci=
sion floating point operations."
> +    },
> +    {
> +        "ArchStdEvent": "FP_DP_SPEC",
> +        "PublicDescription": "Counts speculatively executed double preci=
sion floating point operations."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/general.jso=
n b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/general.json
> new file mode 100644
> index 000000000000..20fada95ef97
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/general.json
> @@ -0,0 +1,6 @@
> +[
> +    {
> +        "ArchStdEvent": "CPU_CYCLES",
> +        "PublicDescription": "Counts CPU clock cycles (not timer cycles)=
. The clock measured by this event is defined as the physical clock driving=
 the CPU logic."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l1d_cache.j=
son b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l1d_cache.json
> new file mode 100644
> index 000000000000..90e871c8986a
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l1d_cache.json
> @@ -0,0 +1,50 @@
> +[
> +    {
> +        "ArchStdEvent": "L1D_CACHE_REFILL",
> +        "PublicDescription": "Counts level 1 data cache refills caused b=
y speculatively executed load or store operations that missed in the level =
1 data cache. This event only counts one event per cache line."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE",
> +        "PublicDescription": "Counts level 1 data cache accesses from an=
y load/store operations. Atomic operations that resolve in the CPUs caches =
(near atomic operations) counts as both a write access and read access. Eac=
h access to a cache line is counted including the multiple accesses caused =
by single instructions such as LDM or STM. Each access to other level 1 dat=
a or unified memory structures, for example refill buffers, write buffers, =
and write-back buffers, are also counted."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_WB",
> +        "PublicDescription": "Counts write-backs of dirty data from the =
L1 data cache to the L2 cache. This occurs when either a dirty cache line i=
s evicted from L1 data cache and allocated in the L2 cache or dirty data is=
 written to the L2 and possibly to the next level of cache. This event coun=
ts both victim cache line evictions and cache write-backs from snoops or ca=
che maintenance operations. The following cache operations are not counted:=
\n\n1. Invalidations which do not result in data being transferred out of t=
he L1 (such as evictions of clean data),\n2. Full line writes which write t=
o L2 without writing L1, such as write streaming mode."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_LMISS_RD",
> +        "PublicDescription": "Counts cache line refills into the level 1=
 data cache from any memory read operations, that incurred additional laten=
cy."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_RD",
> +        "PublicDescription": "Counts level 1 data cache accesses from an=
y load operation. Atomic load operations that resolve in the CPUs caches co=
unts as both a write access and read access."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_WR",
> +        "PublicDescription": "Counts level 1 data cache accesses generat=
ed by store operations. This event also counts accesses caused by a DC ZVA =
(data cache zero, specified by virtual address) instruction. Near atomic op=
erations that resolve in the CPUs caches count as a write access and read a=
ccess."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_REFILL_RD",
> +        "PublicDescription": "Counts level 1 data cache refills caused b=
y speculatively executed load instructions where the memory read operation =
misses in the level 1 data cache. This event only counts one event per cach=
e line."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_REFILL_WR",
> +        "PublicDescription": "Counts level 1 data cache refills caused b=
y speculatively executed store instructions where the memory write operatio=
n misses in the level 1 data cache. This event only counts one event per ca=
che line."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_REFILL_INNER",
> +        "PublicDescription": "Counts level 1 data cache refills where th=
e cache line data came from caches inside the immediate cluster of the core=
."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_REFILL_OUTER",
> +        "PublicDescription": "Counts level 1 data cache refills for whic=
h the cache line data came from outside the immediate cluster of the core, =
like an SLC in the system interconnect or DRAM."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_HWPRF",
> +        "PublicDescription": "Counts level 1 data cache accesses from an=
y load/store operations generated by the hardware prefetcher."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_REFILL_HWPRF",
> +        "PublicDescription": "Counts level 1 data cache refills where th=
e cache line is requested by a hardware prefetcher."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l1i_cache.j=
son b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l1i_cache.json
> new file mode 100644
> index 000000000000..633f1030359d
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l1i_cache.json
> @@ -0,0 +1,14 @@
> +[
> +    {
> +        "ArchStdEvent": "L1I_CACHE_REFILL",
> +        "PublicDescription": "Counts cache line refills in the level 1 i=
nstruction cache caused by a missed instruction fetch. Instruction fetches =
may include accessing multiple instructions, but the single cache line allo=
cation is counted once."
> +    },
> +    {
> +        "ArchStdEvent": "L1I_CACHE",
> +        "PublicDescription": "Counts instruction fetches which access th=
e level 1 instruction cache. Instruction cache accesses caused by cache mai=
ntenance operations are not counted."
> +    },
> +    {
> +        "ArchStdEvent": "L1I_CACHE_LMISS",
> +        "PublicDescription": "Counts cache line refills into the level 1=
 instruction cache, that incurred additional latency."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l2_cache.js=
on b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l2_cache.json
> new file mode 100644
> index 000000000000..9874b1a7c94b
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l2_cache.json
> @@ -0,0 +1,46 @@
> +[
> +    {
> +        "ArchStdEvent": "L2D_CACHE",
> +        "PublicDescription": "Counts accesses to the level 2 cache due t=
o data accesses. Level 2 cache is a unified cache for data and instruction =
accesses. Accesses are for misses in the first level data cache or translat=
ion resolutions due to accesses. This event also counts write back of dirty=
 data from level 1 data cache to the L2 cache."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_REFILL",
> +        "PublicDescription": "Counts cache line refills into the level 2=
 cache. Level 2 cache is a unified cache for data and instruction accesses.=
 Accesses are for misses in the level 1 data cache or translation resolutio=
ns due to accesses."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_WB",
> +        "PublicDescription": "Counts write-backs of data from the L2 cac=
he to outside the CPU. This includes snoops to the L2 (from other CPUs) whi=
ch return data even if the snoops cause an invalidation. L2 cache line inva=
lidations which do not write data outside the CPU and snoops which return d=
ata from an L1 cache are not counted. Data would not be written outside the=
 cache when invalidating a clean cache line."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_ALLOCATE",
> +        "PublicDescription": "Counts level 2 cache line allocates that d=
o not fetch data from outside the level 2 data or unified cache."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_RD",
> +        "PublicDescription": "Counts level 2 data cache accesses due to =
memory read operations. Level 2 cache is a unified cache for data and instr=
uction accesses, accesses are for misses in the level 1 data cache or trans=
lation resolutions due to accesses."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_WR",
> +        "PublicDescription": "Counts level 2 cache accesses due to memor=
y write operations. Level 2 cache is a unified cache for data and instructi=
on accesses, accesses are for misses in the level 1 data cache or translati=
on resolutions due to accesses."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_REFILL_RD",
> +        "PublicDescription": "Counts refills for memory accesses due to =
memory read operation counted by L2D_CACHE_RD. Level 2 cache is a unified c=
ache for data and instruction accesses, accesses are for misses in the leve=
l 1 data cache or translation resolutions due to accesses."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_REFILL_WR",
> +        "PublicDescription": "Counts refills for memory accesses due to =
memory write operation counted by L2D_CACHE_WR. Level 2 cache is a unified =
cache for data and instruction accesses, accesses are for misses in the lev=
el 1 data cache or translation resolutions due to accesses."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_LMISS_RD",
> +        "PublicDescription": "Counts cache line refills into the level 2=
 unified cache from any memory read operations that incurred additional lat=
ency."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_HWPRF",
> +        "PublicDescription": "Counts level 2 data cache accesses generat=
ed by L2D hardware prefetchers."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_REFILL_HWPRF",
> +        "BriefDescription": "This event counts hardware prefetch counted=
 by L2D_CACHE_HWPRF that causes a refill of the Level 2 cache, or any Level=
 1 data and instruction cache of this PE, from outside of those caches."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l3_cache.js=
on b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l3_cache.json
> new file mode 100644
> index 000000000000..d5485d71babb
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l3_cache.json
> @@ -0,0 +1,21 @@
> +[
> +    {
> +        "ArchStdEvent": "L3D_CACHE",
> +        "PublicDescription": "Counts level 3 cache accesses. Level 3 cac=
he is a unified cache for data and instruction accesses. Accesses are for m=
isses in the lower level caches or translation resolutions due to accesses.=
"
> +    },
> +    {
> +        "ArchStdEvent": "L3D_CACHE_RD",
> +        "PublicDescription": "Counts level 3 cache accesses caused by an=
y memory read operation. Level 3 cache is a unified cache for data and inst=
ruction accesses. Accesses are for misses in the lower level caches or tran=
slation resolutions due to accesses."
> +    },
> +    {
> +        "ArchStdEvent": "L3D_CACHE_REFILL_RD"
> +    },
> +    {
> +        "ArchStdEvent": "L3D_CACHE_LMISS_RD",
> +        "PublicDescription": "Counts any cache line refill into the leve=
l 3 cache from memory read operations that incurred additional latency."
> +    },
> +    {
> +        "ArchStdEvent": "L3D_CACHE_HWPRF",
> +        "PublicDescription": "Level 3 data cache hardware prefetch."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/ll_cache.js=
on b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/ll_cache.json
> new file mode 100644
> index 000000000000..fd5a2e0099b8
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/ll_cache.json
> @@ -0,0 +1,10 @@
> +[
> +    {
> +        "ArchStdEvent": "LL_CACHE_RD",
> +        "PublicDescription": "Counts read transactions that were returne=
d from outside the core cluster. This event counts for external last level =
cache  when the system register CPUECTLR.EXTLLC bit is set, otherwise it co=
unts for the L3 cache. This event counts read transactions returned from ou=
tside the core if those transactions are either hit in the system level cac=
he or missed in the SLC and are returned from any other external sources."
> +    },
> +    {
> +        "ArchStdEvent": "LL_CACHE_MISS_RD",
> +        "PublicDescription": "Counts read transactions that were returne=
d from outside the core cluster but missed in the system level cache. This =
event counts for external last level cache when the system register CPUECTL=
R.EXTLLC bit is set, otherwise it counts for L3 cache. This event counts re=
ad transactions returned from outside the core if those transactions are mi=
ssed in the System level Cache. The data source of the transaction is indic=
ated by a field in the CHI transaction returning to the CPU. This event doe=
s not count reads caused by cache maintenance operations."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/memory.json=
 b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/memory.json
> new file mode 100644
> index 000000000000..e7f7914ecd2b
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/memory.json
> @@ -0,0 +1,58 @@
> +[
> +    {
> +        "ArchStdEvent": "MEM_ACCESS",
> +        "PublicDescription": "Counts memory accesses issued by the CPU l=
oad store unit, where those accesses are issued due to load or store operat=
ions. This event counts memory accesses no matter whether the data is recei=
ved from any level of cache hierarchy or external memory. If memory accesse=
s are broken up into smaller transactions than what were specified in the l=
oad or store instructions, then the event counts those smaller memory trans=
actions."
> +    },
> +    {
> +        "ArchStdEvent": "MEMORY_ERROR",
> +        "PublicDescription": "Counts any detected correctable or uncorre=
ctable physical memory errors (ECC or parity) in protected CPUs RAMs. On th=
e core, this event counts errors in the caches (including data and tag rams=
). Any detected memory error (from either a speculative and abandoned acces=
s, or an architecturally executed access) is counted. Note that errors are =
only detected when the actual protected memory is accessed by an operation.=
"
> +    },
> +    {
> +        "ArchStdEvent": "REMOTE_ACCESS_RD",
> +        "PublicDescription": "Counts memory access to another socket in =
a multi-socket system, read."
> +    },
> +    {
> +        "ArchStdEvent": "MEM_ACCESS_RD",
> +        "PublicDescription": "Counts memory accesses issued by the CPU d=
ue to load operations. The event counts any memory load access, no matter w=
hether the data is received from any level of cache hierarchy or external m=
emory. The event also counts atomic load operations. If memory accesses are=
 broken up by the load/store unit into smaller transactions that are issued=
 by the bus interface, then the event counts those smaller transactions."
> +    },
> +    {
> +        "ArchStdEvent": "MEM_ACCESS_WR",
> +        "PublicDescription": "Counts memory accesses issued by the CPU d=
ue to store operations. The event counts any memory store access, no matter=
 whether the data is located in any level of cache or external memory. The =
event also counts atomic load and store operations. If memory accesses are =
broken up by the load/store unit into smaller transactions that are issued =
by the bus interface, then the event counts those smaller transactions."
> +    },
> +    {
> +        "ArchStdEvent": "LDST_ALIGN_LAT",
> +        "PublicDescription": "Counts the number of memory read and write=
 accesses in a cycle that incurred additional latency, due to the alignment=
 of the address and the size of data being accessed, which results in store=
 crossing a single cache line."
> +    },
> +    {
> +        "ArchStdEvent": "LD_ALIGN_LAT",
> +        "PublicDescription": "Counts the number of memory read accesses =
in a cycle that incurred additional latency, due to the alignment of the ad=
dress and size of data being accessed, which results in load crossing a sin=
gle cache line."
> +    },
> +    {
> +        "ArchStdEvent": "ST_ALIGN_LAT",
> +        "PublicDescription": "Counts the number of memory write access i=
n a cycle that incurred additional latency, due to the alignment of the add=
ress and size of data being accessed incurred additional latency."
> +    },
> +    {
> +        "ArchStdEvent": "MEM_ACCESS_CHECKED",
> +        "PublicDescription": "Counts the number of memory read and write=
 accesses counted by MEM_ACCESS that are tag checked by the Memory Tagging =
Extension (MTE). This event is implemented as the sum of MEM_ACCESS_CHECKED=
_RD and MEM_ACCESS_CHECKED_WR"
> +    },
> +    {
> +        "ArchStdEvent": "MEM_ACCESS_CHECKED_RD",
> +        "PublicDescription": "Counts the number of memory read accesses =
in a cycle that are tag checked by the Memory Tagging Extension (MTE)."
> +    },
> +    {
> +        "ArchStdEvent": "MEM_ACCESS_CHECKED_WR",
> +        "PublicDescription": "Counts the number of memory write accesses=
 in a cycle that is tag checked by the Memory Tagging Extension (MTE)."
> +    },
> +    {
> +        "ArchStdEvent": "INST_FETCH_PERCYC",
> +        "PublicDescription": "Counts number of instruction fetches outst=
anding per cycle, which will provide an average latency of instruction fetc=
h."
> +    },
> +    {
> +        "ArchStdEvent": "MEM_ACCESS_RD_PERCYC",
> +        "PublicDescription": "Counts the number of outstanding loads or =
memory read accesses per cycle."
> +    },
> +    {
> +        "ArchStdEvent": "INST_FETCH",
> +        "PublicDescription": "Counts Instruction memory accesses that th=
e PE makes."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/metrics.jso=
n b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/metrics.json
> new file mode 100644
> index 000000000000..62cb910c8945
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/metrics.json
> @@ -0,0 +1,373 @@
> +[
> +    {
> +        "ArchStdEvent": "backend_bound"
> +    },
> +    {
> +        "MetricName": "backend_busy_bound",
> +        "MetricExpr": "STALL_BACKEND_BUSY / STALL_BACKEND * 100",
> +        "BriefDescription": "This metric is the percentage of total cycl=
es stalled in the backend due to issue queues being full to accept operatio=
ns for execution.",
> +        "MetricGroup": "Topdown_Backend",
> +        "ScaleUnit": "1percent of cycles"
> +    },
> +    {
> +        "MetricName": "backend_cache_l1d_bound",
> +        "MetricExpr": "STALL_BACKEND_L1D / (STALL_BACKEND_L1D + STALL_BA=
CKEND_MEM) * 100",
> +        "BriefDescription": "This metric is the percentage of total cycl=
es stalled in the backend due to memory access latency issues caused by lev=
el 1 data cache misses.",
> +        "MetricGroup": "Topdown_Backend",
> +        "ScaleUnit": "1percent of cycles"
> +    },
> +    {
> +        "MetricName": "backend_cache_l2d_bound",
> +        "MetricExpr": "STALL_BACKEND_MEM / (STALL_BACKEND_L1D + STALL_BA=
CKEND_MEM) * 100",
> +        "BriefDescription": "This metric is the percentage of total cycl=
es stalled in the backend due to memory access latency issues caused by lev=
el 2 data cache misses.",
> +        "MetricGroup": "Topdown_Backend",
> +        "ScaleUnit": "1percent of cycles"
> +    },
> +    {
> +        "MetricName": "backend_mem_bound",
> +        "MetricExpr": "STALL_BACKEND_MEMBOUND / STALL_BACKEND * 100",
> +        "BriefDescription": "This metric is the percentage of total cycl=
es stalled in the backend due to backend core resource constraints related =
to memory access latency issues caused by memory access components.",
> +        "MetricGroup": "Topdown_Backend",
> +        "ScaleUnit": "1percent of cycles"
> +    },
> +    {
> +        "MetricName": "backend_mem_cache_bound",
> +        "MetricExpr": "(STALL_BACKEND_L1D + STALL_BACKEND_MEM) / STALL_B=
ACKEND_MEMBOUND * 100",
> +        "BriefDescription": "This metric is the percentage of total cycl=
es stalled in the backend due to memory latency issues caused by data cache=
 misses.",
> +        "MetricGroup": "Topdown_Backend",
> +        "ScaleUnit": "1percent of cycles"
> +    },
> +    {
> +        "MetricName": "backend_mem_store_bound",
> +        "MetricExpr": "STALL_BACKEND_ST / STALL_BACKEND_MEMBOUND * 100",
> +        "BriefDescription": "This metric is the percentage of total cycl=
es stalled in the frontend due to memory write pending caused by stores sta=
lled in the pre-commit stage.",
> +        "MetricGroup": "Topdown_Backend",
> +        "ScaleUnit": "1percent of cycles"
> +    },
> +    {
> +        "MetricName": "backend_mem_tlb_bound",
> +        "MetricExpr": "STALL_BACKEND_TLB / STALL_BACKEND_MEMBOUND * 100"=
,
> +        "BriefDescription": "This metric is the percentage of total cycl=
es stalled in the backend due to memory access latency issues caused by dat=
a TLB misses.",
> +        "MetricGroup": "Topdown_Backend",
> +        "ScaleUnit": "1percent of cycles"
> +    },
> +    {
> +        "MetricName": "backend_stalled_cycles",
> +        "MetricExpr": "STALL_BACKEND / CPU_CYCLES * 100",
> +        "BriefDescription": "This metric is the percentage of cycles tha=
t were stalled due to resource constraints in the backend unit of the proce=
ssor.",
> +        "MetricGroup": "Cycle_Accounting",
> +        "ScaleUnit": "1percent of cycles"
> +    },
> +    {
> +        "ArchStdEvent": "bad_speculation",
> +        "MetricExpr": "(1 - STALL_SLOT / (10 * CPU_CYCLES)) * (1 - OP_RE=
TIRED / OP_SPEC) * 100 + STALL_FRONTEND_FLUSH / CPU_CYCLES * 100"
> +    },
> +    {
> +        "MetricName": "branch_direct_ratio",
> +        "MetricExpr": "BR_IMMED_RETIRED / BR_RETIRED",
> +        "BriefDescription": "This metric measures the ratio of direct br=
anches retired to the total number of branches architecturally executed.",
> +        "MetricGroup": "Branch_Effectiveness",
> +        "ScaleUnit": "1per branch"
> +    },
> +    {
> +        "MetricName": "branch_indirect_ratio",
> +        "MetricExpr": "BR_IND_RETIRED / BR_RETIRED",
> +        "BriefDescription": "This metric measures the ratio of indirect =
branches retired, including function returns, to the total number of branch=
es architecturally executed.",
> +        "MetricGroup": "Branch_Effectiveness",
> +        "ScaleUnit": "1per branch"
> +    },
> +    {
> +        "MetricName": "branch_misprediction_ratio",
> +        "MetricExpr": "BR_MIS_PRED_RETIRED / BR_RETIRED",
> +        "BriefDescription": "This metric measures the ratio of branches =
mispredicted to the total number of branches architecturally executed. This=
 gives an indication of the effectiveness of the branch prediction unit.",
> +        "MetricGroup": "Miss_Ratio;Branch_Effectiveness",
> +        "ScaleUnit": "100percent of branches"
> +    },
> +    {
> +        "MetricName": "branch_mpki",
> +        "MetricExpr": "BR_MIS_PRED_RETIRED / INST_RETIRED * 1000",
> +        "BriefDescription": "This metric measures the number of branch m=
ispredictions per thousand instructions executed.",
> +        "MetricGroup": "MPKI;Branch_Effectiveness",
> +        "ScaleUnit": "1MPKI"
> +    },
> +    {
> +        "MetricName": "branch_percentage",
> +        "MetricExpr": "PC_WRITE_SPEC / INST_SPEC * 100",
> +        "BriefDescription": "This metric measures branch operations as a=
 percentage of operations speculatively executed.",
> +        "MetricGroup": "Operation_Mix",
> +        "ScaleUnit": "1percent of operations"
> +    },
> +    {
> +        "MetricName": "branch_return_ratio",
> +        "MetricExpr": "BR_RETURN_RETIRED / BR_RETIRED",
> +        "BriefDescription": "This metric measures the ratio of branches =
retired that are function returns to the total number of branches architect=
urally executed.",
> +        "MetricGroup": "Branch_Effectiveness",
> +        "ScaleUnit": "1per branch"
> +    },
> +    {
> +        "MetricName": "crypto_percentage",
> +        "MetricExpr": "CRYPTO_SPEC / INST_SPEC * 100",
> +        "BriefDescription": "This metric measures crypto operations as a=
 percentage of operations speculatively executed.",
> +        "MetricGroup": "Operation_Mix",
> +        "ScaleUnit": "1percent of operations"
> +    },
> +    {
> +        "MetricName": "dtlb_mpki",
> +        "MetricExpr": "DTLB_WALK / INST_RETIRED * 1000",
> +        "BriefDescription": "This metric measures the number of data TLB=
 Walks per thousand instructions executed.",
> +        "MetricGroup": "MPKI;DTLB_Effectiveness",
> +        "ScaleUnit": "1MPKI"
> +    },
> +    {
> +        "MetricName": "dtlb_walk_ratio",
> +        "MetricExpr": "DTLB_WALK / L1D_TLB",
> +        "BriefDescription": "This metric measures the ratio of data TLB =
Walks to the total number of data TLB accesses. This gives an indication of=
 the effectiveness of the data TLB accesses.",
> +        "MetricGroup": "Miss_Ratio;DTLB_Effectiveness",
> +        "ScaleUnit": "100percent of TLB accesses"
> +    },
> +    {
> +        "MetricName": "fp16_percentage",
> +        "MetricExpr": "FP_HP_SPEC / INST_SPEC * 100",
> +        "BriefDescription": "This metric measures half-precision floatin=
g point operations as a percentage of operations speculatively executed.",
> +        "MetricGroup": "FP_Precision_Mix",
> +        "ScaleUnit": "1percent of operations"
> +    },
> +    {
> +        "MetricName": "fp32_percentage",
> +        "MetricExpr": "FP_SP_SPEC / INST_SPEC * 100",
> +        "BriefDescription": "This metric measures single-precision float=
ing point operations as a percentage of operations speculatively executed."=
,
> +        "MetricGroup": "FP_Precision_Mix",
> +        "ScaleUnit": "1percent of operations"
> +    },
> +    {
> +        "MetricName": "fp64_percentage",
> +        "MetricExpr": "FP_DP_SPEC / INST_SPEC * 100",
> +        "BriefDescription": "This metric measures double-precision float=
ing point operations as a percentage of operations speculatively executed."=
,
> +        "MetricGroup": "FP_Precision_Mix",
> +        "ScaleUnit": "1percent of operations"
> +    },
> +    {
> +        "MetricName": "frontend_cache_l1i_bound",
> +        "MetricExpr": "STALL_FRONTEND_L1I / (STALL_FRONTEND_L1I + STALL_=
FRONTEND_MEM) * 100",
> +        "BriefDescription": "This metric is the percentage of total cycl=
es stalled in the frontend due to memory access latency issues caused by le=
vel 1 instruction cache misses.",
> +        "MetricGroup": "Topdown_Frontend",
> +        "ScaleUnit": "1percent of cycles"
> +    },
> +    {
> +        "MetricName": "frontend_cache_l2i_bound",
> +        "MetricExpr": "STALL_FRONTEND_MEM / (STALL_FRONTEND_L1I + STALL_=
FRONTEND_MEM) * 100",
> +        "BriefDescription": "This metric is the percentage of total cycl=
es stalled in the frontend due to memory access latency issues caused by le=
vel 2 instruction cache misses.",
> +        "MetricGroup": "Topdown_Frontend",
> +        "ScaleUnit": "1percent of cycles"
> +    },
> +    {
> +        "MetricName": "frontend_core_bound",
> +        "MetricExpr": "STALL_FRONTEND_CPUBOUND / STALL_FRONTEND * 100",
> +        "BriefDescription": "This metric is the percentage of total cycl=
es stalled in the frontend due to frontend core resource constraints not re=
lated to instruction fetch latency issues caused by memory access component=
s.",
> +        "MetricGroup": "Topdown_Frontend",
> +        "ScaleUnit": "1percent of cycles"
> +    },
> +    {
> +        "MetricName": "frontend_core_flush_bound",
> +        "MetricExpr": "STALL_FRONTEND_FLUSH / STALL_FRONTEND_CPUBOUND * =
100",
> +        "BriefDescription": "This metric is the percentage of total cycl=
es stalled in the frontend as the processor is recovering from a pipeline f=
lush caused by bad speculation or other machine resteers.",
> +        "MetricGroup": "Topdown_Frontend",
> +        "ScaleUnit": "1percent of cycles"
> +    },
> +    {
> +        "MetricName": "frontend_mem_bound",
> +        "MetricExpr": "STALL_FRONTEND_MEMBOUND / STALL_FRONTEND * 100",
> +        "BriefDescription": "This metric is the percentage of total cycl=
es stalled in the frontend due to frontend core resource constraints relate=
d to the instruction fetch latency issues caused by memory access component=
s.",
> +        "MetricGroup": "Topdown_Frontend",
> +        "ScaleUnit": "1percent of cycles"
> +    },
> +    {
> +        "MetricName": "frontend_mem_cache_bound",
> +        "MetricExpr": "(STALL_FRONTEND_L1I + STALL_FRONTEND_MEM) / STALL=
_FRONTEND_MEMBOUND * 100",
> +        "BriefDescription": "This metric is the percentage of total cycl=
es stalled in the frontend due to instruction fetch latency issues caused b=
y instruction cache misses.",
> +        "MetricGroup": "Topdown_Frontend",
> +        "ScaleUnit": "1percent of cycles"
> +    },
> +    {
> +        "MetricName": "frontend_mem_tlb_bound",
> +        "MetricExpr": "STALL_FRONTEND_TLB / STALL_FRONTEND_MEMBOUND * 10=
0",
> +        "BriefDescription": "This metric is the percentage of total cycl=
es stalled in the frontend due to instruction fetch latency issues caused b=
y instruction TLB misses.",
> +        "MetricGroup": "Topdown_Frontend",
> +        "ScaleUnit": "1percent of cycles"
> +    },
> +    {
> +        "MetricName": "frontend_stalled_cycles",
> +        "MetricExpr": "STALL_FRONTEND / CPU_CYCLES * 100",
> +        "BriefDescription": "This metric is the percentage of cycles tha=
t were stalled due to resource constraints in the frontend unit of the proc=
essor.",
> +        "MetricGroup": "Cycle_Accounting",
> +        "ScaleUnit": "1percent of cycles"
> +    },
> +    {
> +        "MetricName": "integer_dp_percentage",
> +        "MetricExpr": "DP_SPEC / INST_SPEC * 100",
> +        "BriefDescription": "This metric measures scalar integer operati=
ons as a percentage of operations speculatively executed.",
> +        "MetricGroup": "Operation_Mix",
> +        "ScaleUnit": "1percent of operations"
> +    },
> +    {
> +        "MetricName": "ipc",
> +        "MetricExpr": "INST_RETIRED / CPU_CYCLES",
> +        "BriefDescription": "This metric measures the number of instruct=
ions retired per cycle.",
> +        "MetricGroup": "General",
> +        "ScaleUnit": "1per cycle"
> +    },
> +    {
> +        "MetricName": "itlb_mpki",
> +        "MetricExpr": "ITLB_WALK / INST_RETIRED * 1000",
> +        "BriefDescription": "This metric measures the number of instruct=
ion TLB Walks per thousand instructions executed.",
> +        "MetricGroup": "MPKI;ITLB_Effectiveness",
> +        "ScaleUnit": "1MPKI"
> +    },
> +    {
> +        "MetricName": "itlb_walk_ratio",
> +        "MetricExpr": "ITLB_WALK / L1I_TLB",
> +        "BriefDescription": "This metric measures the ratio of instructi=
on TLB Walks to the total number of instruction TLB accesses. This gives an=
 indication of the effectiveness of the instruction TLB accesses.",
> +        "MetricGroup": "Miss_Ratio;ITLB_Effectiveness",
> +        "ScaleUnit": "100percent of TLB accesses"
> +    },
> +    {
> +        "MetricName": "l1d_cache_miss_ratio",
> +        "MetricExpr": "L1D_CACHE_REFILL / L1D_CACHE",
> +        "BriefDescription": "This metric measures the ratio of level 1 d=
ata cache accesses missed to the total number of level 1 data cache accesse=
s. This gives an indication of the effectiveness of the level 1 data cache.=
",
> +        "MetricGroup": "Miss_Ratio;L1D_Cache_Effectiveness",
> +        "ScaleUnit": "100percent of cache accesses"
> +    },
> +    {
> +        "MetricName": "l1d_cache_mpki",
> +        "MetricExpr": "L1D_CACHE_REFILL / INST_RETIRED * 1000",
> +        "BriefDescription": "This metric measures the number of level 1 =
data cache accesses missed per thousand instructions executed.",
> +        "MetricGroup": "MPKI;L1D_Cache_Effectiveness",
> +        "ScaleUnit": "1MPKI"
> +    },
> +    {
> +        "MetricName": "l1d_tlb_miss_ratio",
> +        "MetricExpr": "L1D_TLB_REFILL / L1D_TLB",
> +        "BriefDescription": "This metric measures the ratio of level 1 d=
ata TLB accesses missed to the total number of level 1 data TLB accesses. T=
his gives an indication of the effectiveness of the level 1 data TLB.",
> +        "MetricGroup": "Miss_Ratio;DTLB_Effectiveness",
> +        "ScaleUnit": "100percent of TLB accesses"
> +    },
> +    {
> +        "MetricName": "l1d_tlb_mpki",
> +        "MetricExpr": "L1D_TLB_REFILL / INST_RETIRED * 1000",
> +        "BriefDescription": "This metric measures the number of level 1 =
data TLB accesses missed per thousand instructions executed.",
> +        "MetricGroup": "MPKI;DTLB_Effectiveness",
> +        "ScaleUnit": "1MPKI"
> +    },
> +    {
> +        "MetricName": "l1i_cache_miss_ratio",
> +        "MetricExpr": "L1I_CACHE_REFILL / L1I_CACHE",
> +        "BriefDescription": "This metric measures the ratio of level 1 i=
nstruction cache accesses missed to the total number of level 1 instruction=
 cache accesses. This gives an indication of the effectiveness of the level=
 1 instruction cache.",
> +        "MetricGroup": "Miss_Ratio;L1I_Cache_Effectiveness",
> +        "ScaleUnit": "100percent of cache accesses"
> +    },
> +    {
> +        "MetricName": "l1i_cache_mpki",
> +        "MetricExpr": "L1I_CACHE_REFILL / INST_RETIRED * 1000",
> +        "BriefDescription": "This metric measures the number of level 1 =
instruction cache accesses missed per thousand instructions executed.",
> +        "MetricGroup": "MPKI;L1I_Cache_Effectiveness",
> +        "ScaleUnit": "1MPKI"
> +    },
> +    {
> +        "MetricName": "l1i_tlb_miss_ratio",
> +        "MetricExpr": "L1I_TLB_REFILL / L1I_TLB",
> +        "BriefDescription": "This metric measures the ratio of level 1 i=
nstruction TLB accesses missed to the total number of level 1 instruction T=
LB accesses. This gives an indication of the effectiveness of the level 1 i=
nstruction TLB.",
> +        "MetricGroup": "Miss_Ratio;ITLB_Effectiveness",
> +        "ScaleUnit": "100percent of TLB accesses"
> +    },
> +    {
> +        "MetricName": "l1i_tlb_mpki",
> +        "MetricExpr": "L1I_TLB_REFILL / INST_RETIRED * 1000",
> +        "BriefDescription": "This metric measures the number of level 1 =
instruction TLB accesses missed per thousand instructions executed.",
> +        "MetricGroup": "MPKI;ITLB_Effectiveness",
> +        "ScaleUnit": "1MPKI"
> +    },
> +    {
> +        "MetricName": "l2_cache_miss_ratio",
> +        "MetricExpr": "L2D_CACHE_REFILL / L2D_CACHE",
> +        "BriefDescription": "This metric measures the ratio of level 2 c=
ache accesses missed to the total number of level 2 cache accesses. This gi=
ves an indication of the effectiveness of the level 2 cache, which is a uni=
fied cache that stores both data and instruction. Note that cache accesses =
in this cache are either data memory access or instruction fetch as this is=
 a unified cache.",
> +        "MetricGroup": "Miss_Ratio;L2_Cache_Effectiveness",
> +        "ScaleUnit": "100percent of cache accesses"
> +    },
> +    {
> +        "MetricName": "l2_cache_mpki",
> +        "MetricExpr": "L2D_CACHE_REFILL / INST_RETIRED * 1000",
> +        "BriefDescription": "This metric measures the number of level 2 =
unified cache accesses missed per thousand instructions executed. Note that=
 cache accesses in this cache are either data memory access or instruction =
fetch as this is a unified cache.",
> +        "MetricGroup": "MPKI;L2_Cache_Effectiveness",
> +        "ScaleUnit": "1MPKI"
> +    },
> +    {
> +        "MetricName": "l2_tlb_miss_ratio",
> +        "MetricExpr": "L2D_TLB_REFILL / L2D_TLB",
> +        "BriefDescription": "This metric measures the ratio of level 2 u=
nified TLB accesses missed to the total number of level 2 unified TLB acces=
ses. This gives an indication of the effectiveness of the level 2 TLB.",
> +        "MetricGroup": "Miss_Ratio;ITLB_Effectiveness;DTLB_Effectiveness=
",
> +        "ScaleUnit": "100percent of TLB accesses"
> +    },
> +    {
> +        "MetricName": "l2_tlb_mpki",
> +        "MetricExpr": "L2D_TLB_REFILL / INST_RETIRED * 1000",
> +        "BriefDescription": "This metric measures the number of level 2 =
unified TLB accesses missed per thousand instructions executed.",
> +        "MetricGroup": "MPKI;ITLB_Effectiveness;DTLB_Effectiveness",
> +        "ScaleUnit": "1MPKI"
> +    },
> +    {
> +        "MetricName": "ll_cache_read_hit_ratio",
> +        "MetricExpr": "(LL_CACHE_RD - LL_CACHE_MISS_RD) / LL_CACHE_RD",
> +        "BriefDescription": "This metric measures the ratio of last leve=
l cache read accesses hit in the cache to the total number of last level ca=
che accesses. This gives an indication of the effectiveness of the last lev=
el cache for read traffic. Note that cache accesses in this cache are eithe=
r data memory access or instruction fetch as this is a system level cache."=
,
> +        "MetricGroup": "LL_Cache_Effectiveness",
> +        "ScaleUnit": "100percent of cache accesses"
> +    },
> +    {
> +        "MetricName": "ll_cache_read_miss_ratio",
> +        "MetricExpr": "LL_CACHE_MISS_RD / LL_CACHE_RD",
> +        "BriefDescription": "This metric measures the ratio of last leve=
l cache read accesses missed to the total number of last level cache access=
es. This gives an indication of the effectiveness of the last level cache f=
or read traffic. Note that cache accesses in this cache are either data mem=
ory access or instruction fetch as this is a system level cache.",
> +        "MetricGroup": "Miss_Ratio;LL_Cache_Effectiveness",
> +        "ScaleUnit": "100percent of cache accesses"
> +    },
> +    {
> +        "MetricName": "ll_cache_read_mpki",
> +        "MetricExpr": "LL_CACHE_MISS_RD / INST_RETIRED * 1000",
> +        "BriefDescription": "This metric measures the number of last lev=
el cache read accesses missed per thousand instructions executed.",
> +        "MetricGroup": "MPKI;LL_Cache_Effectiveness",
> +        "ScaleUnit": "1MPKI"
> +    },
> +    {
> +        "MetricName": "load_percentage",
> +        "MetricExpr": "LD_SPEC / INST_SPEC * 100",
> +        "BriefDescription": "This metric measures load operations as a p=
ercentage of operations speculatively executed.",
> +        "MetricGroup": "Operation_Mix",
> +        "ScaleUnit": "1percent of operations"
> +    },
> +    {
> +        "MetricName": "scalar_fp_percentage",
> +        "MetricExpr": "VFP_SPEC / INST_SPEC * 100",
> +        "BriefDescription": "This metric measures scalar floating point =
operations as a percentage of operations speculatively executed.",
> +        "MetricGroup": "Operation_Mix",
> +        "ScaleUnit": "1percent of operations"
> +    },
> +    {
> +        "MetricName": "simd_percentage",
> +        "MetricExpr": "ASE_SPEC / INST_SPEC * 100",
> +        "BriefDescription": "This metric measures advanced SIMD operatio=
ns as a percentage of total operations speculatively executed.",
> +        "MetricGroup": "Operation_Mix",
> +        "ScaleUnit": "1percent of operations"
> +    },
> +    {
> +        "MetricName": "store_percentage",
> +        "MetricExpr": "ST_SPEC / INST_SPEC * 100",
> +        "BriefDescription": "This metric measures store operations as a =
percentage of operations speculatively executed.",
> +        "MetricGroup": "Operation_Mix",
> +        "ScaleUnit": "1percent of operations"
> +    },
> +    {
> +        "MetricName": "sve_all_percentage",
> +        "MetricExpr": "SVE_INST_SPEC / INST_SPEC * 100",
> +        "BriefDescription": "This metric measures scalable vector operat=
ions, including loads and stores, as a percentage of operations speculative=
ly executed.",
> +        "MetricGroup": "Operation_Mix",
> +        "ScaleUnit": "1percent of operations"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/pmu.json b/=
tools/perf/pmu-events/arch/arm64/arm/cortex-a520/pmu.json
> new file mode 100644
> index 000000000000..d8b7b9f9e5fa
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/pmu.json
> @@ -0,0 +1,8 @@
> +[
> +    {
> +        "ArchStdEvent": "PMU_OVFS"
> +    },
> +    {
> +        "ArchStdEvent": "PMU_HOVFS"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/retired.jso=
n b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/retired.json
> new file mode 100644
> index 000000000000..152f15c1253c
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/retired.json
> @@ -0,0 +1,90 @@
> +[
> +    {
> +        "ArchStdEvent": "SW_INCR",
> +        "PublicDescription": "Counts software writes to the PMSWINC_EL0 =
(software PMU increment) register. The PMSWINC_EL0 register is a manually u=
pdated counter for use by application software.\n\nThis event could be used=
 to measure any user program event, such as accesses to a particular data s=
tructure (by writing to the PMSWINC_EL0 register each time the data structu=
re is accessed).\n\nTo use the PMSWINC_EL0 register and event, developers m=
ust insert instructions that write to the PMSWINC_EL0 register into the sou=
rce code.\n\nSince the SW_INCR event records writes to the PMSWINC_EL0 regi=
ster, there is no need to do a read/increment/write sequence to the PMSWINC=
_EL0 register."
> +    },
> +    {
> +        "ArchStdEvent": "LD_RETIRED",
> +        "PublicDescription": "Counts instruction architecturally execute=
d, Condition code check pass, load."
> +    },
> +    {
> +        "ArchStdEvent": "ST_RETIRED",
> +        "PublicDescription": "Counts instruction architecturally execute=
d, Condition code check pass, store."
> +    },
> +    {
> +        "ArchStdEvent": "INST_RETIRED",
> +        "PublicDescription": "Counts instructions that have been archite=
cturally executed."
> +    },
> +    {
> +        "ArchStdEvent": "CID_WRITE_RETIRED",
> +        "PublicDescription": "Counts architecturally executed writes to =
the CONTEXTIDR_EL1 register, which usually contain the kernel PID and can b=
e output with hardware trace."
> +    },
> +    {
> +        "ArchStdEvent": "PC_WRITE_RETIRED",
> +        "PublicDescription": "Counts branch instructions that caused a c=
hange of Program Counter, which effectively causes a change in the control =
flow of the program."
> +    },
> +    {
> +        "ArchStdEvent": "BR_IMMED_RETIRED",
> +        "PublicDescription": "Counts architecturally executed direct bra=
nches."
> +    },
> +    {
> +        "ArchStdEvent": "BR_RETURN_RETIRED",
> +        "PublicDescription": "Counts architecturally executed procedure =
returns."
> +    },
> +    {
> +        "ArchStdEvent": "TTBR_WRITE_RETIRED",
> +        "PublicDescription": "Counts architectural writes to TTBR0/1_EL1=
. If virtualization host extensions are enabled (by setting the HCR_EL2.E2H=
 bit to 1), then accesses to TTBR0/1_EL1 that are redirected to TTBR0/1_EL2=
, or accesses to TTBR0/1_EL12, are counted. TTBRn registers are typically u=
pdated when the kernel is swapping user-space threads or applications."
> +    },
> +    {
> +        "ArchStdEvent": "BR_RETIRED",
> +        "PublicDescription": "Counts architecturally executed branches, =
whether the branch is taken or not. Instructions that explicitly write to t=
he PC are also counted. Note that exception generating instructions, except=
ion return instructions and context synchronization instructions are not co=
unted."
> +    },
> +    {
> +        "ArchStdEvent": "BR_MIS_PRED_RETIRED",
> +        "PublicDescription": "Counts branches counted by BR_RETIRED whic=
h were mispredicted and caused a pipeline flush."
> +    },
> +    {
> +        "ArchStdEvent": "OP_RETIRED",
> +        "PublicDescription": "Counts micro-operations that are architect=
urally executed. This is a count of number of micro-operations retired from=
 the commit queue in a single cycle."
> +    },
> +    {
> +        "ArchStdEvent": "SVE_INST_RETIRED",
> +        "PublicDescription": "Counts architecturally executed SVE instru=
ctions."
> +    },
> +    {
> +        "ArchStdEvent": "BR_INDNR_TAKEN_RETIRED",
> +        "PublicDescription": "Counts architecturally executed indirect b=
ranches excluding procedure returns that were taken."
> +    },
> +    {
> +        "ArchStdEvent": "BR_IMMED_PRED_RETIRED",
> +        "PublicDescription": "Counts architecturally executed direct bra=
nches that were correctly predicted."
> +    },
> +    {
> +        "ArchStdEvent": "BR_IMMED_MIS_PRED_RETIRED",
> +        "PublicDescription": "Counts architecturally executed direct bra=
nches that were mispredicted and caused a pipeline flush."
> +    },
> +    {
> +        "ArchStdEvent": "BR_RETURN_PRED_RETIRED",
> +        "PublicDescription": "Counts architecturally executed procedure =
returns that were correctly predicted."
> +    },
> +    {
> +        "ArchStdEvent": "BR_RETURN_MIS_PRED_RETIRED",
> +        "PublicDescription": "Counts architecturally executed procedure =
returns that were mispredicted and caused a pipeline flush."
> +    },
> +    {
> +        "ArchStdEvent": "BR_INDNR_PRED_RETIRED",
> +        "PublicDescription": "Counts architecturally executed indirect b=
ranches excluding procedure returns that were correctly predicted."
> +    },
> +    {
> +        "ArchStdEvent": "BR_INDNR_MIS_PRED_RETIRED",
> +        "PublicDescription": "Counts architecturally executed indirect b=
ranches excluding procedure returns that were mispredicted and caused a pip=
eline flush."
> +    },
> +    {
> +        "ArchStdEvent": "BR_PRED_RETIRED",
> +        "PublicDescription": "Counts branch instructions counted by BR_R=
ETIRED which were correctly predicted."
> +    },
> +    {
> +        "ArchStdEvent": "BR_IND_RETIRED",
> +        "PublicDescription": "Counts architecturally executed indirect b=
ranches including procedure returns."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/spec_operat=
ion.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/spec_operation.=
json
> new file mode 100644
> index 000000000000..40c29be53cc0
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/spec_operation.jso=
n
> @@ -0,0 +1,70 @@
> +[
> +    {
> +        "ArchStdEvent": "BR_MIS_PRED",
> +        "PublicDescription": "Counts branches which are speculatively ex=
ecuted and mispredicted."
> +    },
> +    {
> +        "ArchStdEvent": "BR_PRED",
> +        "PublicDescription": "Counts all speculatively executed branches=
."
> +    },
> +    {
> +        "ArchStdEvent": "INST_SPEC",
> +        "PublicDescription": "Counts operations that have been speculati=
vely executed."
> +    },
> +    {
> +        "ArchStdEvent": "OP_SPEC",
> +        "PublicDescription": "Counts micro-operations speculatively exec=
uted. This is the count of the number of micro-operations dispatched in a c=
ycle."
> +    },
> +    {
> +        "ArchStdEvent": "STREX_FAIL_SPEC",
> +        "PublicDescription": "Counts store-exclusive operations that hav=
e been speculatively executed and have not successfully completed the store=
 operation."
> +    },
> +    {
> +        "ArchStdEvent": "STREX_SPEC",
> +        "PublicDescription": "Counts store-exclusive operations that hav=
e been speculatively executed."
> +    },
> +    {
> +        "ArchStdEvent": "LD_SPEC",
> +        "PublicDescription": "Counts speculatively executed load operati=
ons including Single Instruction Multiple Data (SIMD) load operations."
> +    },
> +    {
> +        "ArchStdEvent": "ST_SPEC",
> +        "PublicDescription": "Counts speculatively executed store operat=
ions including Single Instruction Multiple Data (SIMD) store operations."
> +    },
> +    {
> +        "ArchStdEvent": "LDST_SPEC",
> +        "PublicDescription": "Counts speculatively executed load and sto=
re operations."
> +    },
> +    {
> +        "ArchStdEvent": "DP_SPEC",
> +        "PublicDescription": "Counts speculatively executed logical or a=
rithmetic instructions such as MOV/MVN operations."
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SPEC",
> +        "PublicDescription": "Counts speculatively executed Advanced SIM=
D operations excluding load, store and move micro-operations that move data=
 to or from SIMD (vector) registers."
> +    },
> +    {
> +        "ArchStdEvent": "VFP_SPEC",
> +        "PublicDescription": "Counts speculatively executed floating poi=
nt operations. This event does not count operations that move data to or fr=
om floating point (vector) registers."
> +    },
> +    {
> +        "ArchStdEvent": "PC_WRITE_SPEC",
> +        "PublicDescription": "Counts speculatively executed operations w=
hich cause software changes of the PC. Those operations include all taken b=
ranch operations."
> +    },
> +    {
> +        "ArchStdEvent": "CRYPTO_SPEC",
> +        "PublicDescription": "Counts speculatively executed cryptographi=
c operations except for PMULL and VMULL operations."
> +    },
> +    {
> +        "ArchStdEvent": "BR_IMMED_SPEC",
> +        "PublicDescription": "Counts direct branch operations which are =
speculatively executed."
> +    },
> +    {
> +        "ArchStdEvent": "BR_RETURN_SPEC",
> +        "PublicDescription": "Counts procedure return operations (RET, R=
ETAA and RETAB) which are speculatively executed."
> +    },
> +    {
> +        "ArchStdEvent": "BR_INDIRECT_SPEC",
> +        "PublicDescription": "Counts indirect branch operations includin=
g procedure returns, which are speculatively executed. This includes operat=
ions that force a software change of the PC, other than exception-generatin=
g operations and direct branch instructions. Some examples of the instructi=
ons counted by this event include BR Xn, RET, etc..."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/stall.json =
b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/stall.json
> new file mode 100644
> index 000000000000..d65aeb4b8808
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/stall.json
> @@ -0,0 +1,82 @@
> +[
> +    {
> +        "ArchStdEvent": "STALL_FRONTEND",
> +        "PublicDescription": "Counts cycles when frontend could not send=
 any micro-operations to the rename stage because of frontend resource stal=
ls caused by fetch memory latency or branch prediction flow stalls. STALL_F=
RONTEND_SLOTS counts SLOTS during the cycle when this event counts."
> +    },
> +    {
> +        "ArchStdEvent": "STALL_BACKEND",
> +        "PublicDescription": "Counts cycles whenever the rename unit is =
unable to send any micro-operations to the backend of the pipeline because =
of backend resource constraints. Backend resource constraints can include i=
ssue stage fullness, execution stage fullness, or other internal pipeline r=
esource fullness. All the backend slots were empty during the cycle when th=
is event counts."
> +    },
> +    {
> +        "ArchStdEvent": "STALL",
> +        "PublicDescription": "Counts cycles when no operations are sent =
to the rename unit from the frontend or from the rename unit to the backend=
 for any reason (either frontend or backend stall). This event is the sum o=
f STALL_FRONTEND and STALL_BACKEND"
> +    },
> +    {
> +        "ArchStdEvent": "STALL_SLOT_BACKEND",
> +        "PublicDescription": "Counts slots per cycle in which no operati=
ons are sent from the rename unit to the backend due to backend resource co=
nstraints. STALL_BACKEND counts during the cycle when STALL_SLOT_BACKEND co=
unts at least 1."
> +    },
> +    {
> +        "ArchStdEvent": "STALL_SLOT_FRONTEND",
> +        "PublicDescription": "Counts slots per cycle in which no operati=
ons are sent to the rename unit from the frontend due to frontend resource =
constraints."
> +    },
> +    {
> +        "ArchStdEvent": "STALL_SLOT",
> +        "PublicDescription": "Counts slots per cycle in which no operati=
ons are sent to the rename unit from the frontend or from the rename unit t=
o the backend for any reason (either frontend or backend stall). STALL_SLOT=
 is the sum of STALL_SLOT_FRONTEND and STALL_SLOT_BACKEND."
> +    },
> +    {
> +        "ArchStdEvent": "STALL_BACKEND_MEM",
> +        "PublicDescription": "Counts cycles when the backend is stalled =
because there is a pending demand load request in progress in the last leve=
l core cache."
> +    },
> +    {
> +        "ArchStdEvent": "STALL_FRONTEND_MEMBOUND",
> +        "PublicDescription": "Counts cycles when the frontend could not =
send any micro-operations to the rename stage due to resource constraints i=
n the memory resources."
> +    },
> +    {
> +        "ArchStdEvent": "STALL_FRONTEND_L1I",
> +        "PublicDescription": "Counts cycles when the frontend is stalled=
 because there is an instruction fetch request pending in the level 1 instr=
uction cache."
> +    },
> +    {
> +        "ArchStdEvent": "STALL_FRONTEND_MEM",
> +        "PublicDescription": "Counts cycles when the frontend is stalled=
 because there is an instruction fetch request pending in the last level co=
re cache."
> +    },
> +    {
> +        "ArchStdEvent": "STALL_FRONTEND_TLB",
> +        "PublicDescription": "Counts when the frontend is stalled on any=
 TLB misses being handled. This event also counts the TLB accesses made by =
hardware prefetches."
> +    },
> +    {
> +        "ArchStdEvent": "STALL_FRONTEND_CPUBOUND",
> +        "PublicDescription": "Counts cycles when the frontend could not =
send any micro-operations to the rename stage due to resource constraints i=
n the CPU resources excluding memory resources."
> +    },
> +    {
> +        "ArchStdEvent": "STALL_FRONTEND_FLOW",
> +        "PublicDescription": "Counts cycles when the frontend could not =
send any micro-operations to the rename stage due to resource constraints i=
n the branch prediction unit."
> +    },
> +    {
> +        "ArchStdEvent": "STALL_FRONTEND_FLUSH",
> +        "PublicDescription": "Counts cycles when the frontend could not =
send any micro-operations to the rename stage as the frontend is recovering=
 from a machine flush or resteer. Example scenarios that cause a flush incl=
ude branch mispredictions, taken exceptions, micro-architectural flush etc.=
"
> +    },
> +    {
> +        "ArchStdEvent": "STALL_BACKEND_MEMBOUND",
> +        "PublicDescription": "Counts cycles when the backend could not a=
ccept any micro-operations due to resource constraints in the memory resour=
ces."
> +    },
> +    {
> +        "ArchStdEvent": "STALL_BACKEND_L1D",
> +        "PublicDescription": "Counts cycles when the backend is stalled =
because there is a pending demand load request in progress in the level 1 d=
ata cache."
> +    },
> +    {
> +        "ArchStdEvent": "STALL_BACKEND_TLB",
> +        "PublicDescription": "Counts cycles when the backend is stalled =
on any demand TLB misses being handled."
> +    },
> +    {
> +        "ArchStdEvent": "STALL_BACKEND_ST",
> +        "PublicDescription": "Counts cycles when the backend is stalled =
and there is a store that has not reached the pre-commit stage."
> +    },
> +    {
> +        "ArchStdEvent": "STALL_BACKEND_BUSY",
> +        "PublicDescription": "Counts cycles when the backend could not a=
ccept any micro-operations because the issue queues are full to take any op=
erations for execution."
> +    },
> +    {
> +        "ArchStdEvent": "STALL_BACKEND_ILOCK",
> +        "PublicDescription": "Counts cycles when the backend could not a=
ccept any micro-operations due to resource constraints imposed by input dep=
endency."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/sve.json b/=
tools/perf/pmu-events/arch/arm64/arm/cortex-a520/sve.json
> new file mode 100644
> index 000000000000..21810ce5de8d
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/sve.json
> @@ -0,0 +1,22 @@
> +[
> +    {
> +        "ArchStdEvent": "SVE_INST_SPEC",
> +        "PublicDescription": "Counts speculatively executed operations t=
hat are SVE operations."
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SVE_INT8_SPEC",
> +        "PublicDescription": "Counts speculatively executed Advanced SIM=
D or SVE integer operations with the largest data type an 8-bit integer."
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SVE_INT16_SPEC",
> +        "PublicDescription": "Counts speculatively executed Advanced SIM=
D or SVE integer operations with the largest data type a 16-bit integer."
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SVE_INT32_SPEC",
> +        "PublicDescription": "Counts speculatively executed Advanced SIM=
D or SVE integer operations with the largest data type a 32-bit integer."
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SVE_INT64_SPEC",
> +        "PublicDescription": "Counts speculatively executed Advanced SIM=
D or SVE integer operations with the largest data type a 64-bit integer."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/tlb.json b/=
tools/perf/pmu-events/arch/arm64/arm/cortex-a520/tlb.json
> new file mode 100644
> index 000000000000..1de56300e581
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/tlb.json
> @@ -0,0 +1,78 @@
> +[
> +    {
> +        "ArchStdEvent": "L1I_TLB_REFILL",
> +        "PublicDescription": "Counts level 1 instruction TLB refills fro=
m any Instruction fetch. If there are multiple misses in the TLB that are r=
esolved by the refill, then this event only counts once. This event will no=
t count if the translation table walk results in a fault (such as a transla=
tion or access fault), since there is no new translation created for the TL=
B."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_TLB_REFILL",
> +        "PublicDescription": "Counts level 1 data TLB accesses that resu=
lted in TLB refills. If there are multiple misses in the TLB that are resol=
ved by the refill, then this event only counts once. This event counts for =
refills caused by preload instructions or hardware prefetch accesses. This =
event counts regardless of whether the miss hits in L2 or results in a tran=
slation table walk. This event will not count if the translation table walk=
 results in a fault (such as a translation or access fault), since there is=
 no new translation created for the TLB. This event will not count on an ac=
cess from an AT(address translation) instruction."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_TLB",
> +        "PublicDescription": "Counts level 1 data TLB accesses caused by=
 any memory load or store operation. Note that load or store instructions c=
an be broken up into multiple memory operations. This event does not count =
TLB maintenance operations."
> +    },
> +    {
> +        "ArchStdEvent": "L1I_TLB",
> +        "PublicDescription": "Counts level 1 instruction TLB accesses, w=
hether the access hits or misses in the TLB. This event counts both demand =
accesses and prefetch or preload generated accesses."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_TLB_REFILL",
> +        "PublicDescription": "Counts level 2 TLB refills caused by memor=
y operations from both data and instruction fetch, except for those caused =
by TLB maintenance operations and hardware prefetches."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_TLB",
> +        "PublicDescription": "Counts level 2 TLB accesses except those c=
aused by TLB maintenance operations."
> +    },
> +    {
> +        "ArchStdEvent": "DTLB_WALK",
> +        "PublicDescription": "Counts number of demand data translation t=
able walks caused by a miss in the L2 TLB and performing at least one memor=
y access. Translation table walks are counted even if the translation ended=
 up taking a translation fault for reasons different than EPD, E0PD and NFD=
. Note that partial translations that cause a translation table walk are al=
so counted. Also note that this event counts walks triggered by software pr=
eloads, but not walks triggered by hardware prefetchers, and that this even=
t does not count walks triggered by TLB maintenance operations."
> +    },
> +    {
> +        "ArchStdEvent": "ITLB_WALK",
> +        "PublicDescription": "Counts number of instruction translation t=
able walks caused by a miss in the L2 TLB and performing at least one memor=
y access. Translation table walks are counted even if the translation ended=
 up taking a translation fault for reasons different than EPD, E0PD and NFD=
. Note that partial translations that cause a translation table walk are al=
so counted. Also note that this event does not count walks triggered by TLB=
 maintenance operations."
> +    },
> +    {
> +        "ArchStdEvent": "DTLB_WALK_PERCYC",
> +        "PublicDescription": "Counts the number of data translation tabl=
e walks in progress per cycle."
> +    },
> +    {
> +        "ArchStdEvent": "ITLB_WALK_PERCYC",
> +        "PublicDescription": "Counts the number of instruction translati=
on table walks in progress per cycle."
> +    },
> +    {
> +        "ArchStdEvent": "DTLB_HWUPD",
> +        "PublicDescription": "Counts number of memory accesses triggered=
 by a data translation table walk and performing an update of a translation=
 table entry. Memory accesses are counted even if the translation ended up =
taking a translation fault for reasons different than EPD, E0PD and NFD. No=
te that this event counts accesses triggered by software preloads, but not =
accesses triggered by hardware prefetchers."
> +    },
> +    {
> +        "ArchStdEvent": "ITLB_HWUPD",
> +        "PublicDescription": "Counts number of memory accesses triggered=
 by an instruction translation table walk and performing an update of a tra=
nslation table entry. Memory accesses are counted even if the translation e=
nded up taking a translation fault for reasons different than EPD, E0PD and=
 NFD."
> +    },
> +    {
> +        "ArchStdEvent": "DTLB_STEP",
> +        "PublicDescription": "Counts number of memory accesses triggered=
 by a demand data translation table walk and performing a read of a transla=
tion table entry. Memory accesses are counted even if the translation ended=
 up taking a translation fault for reasons different than EPD, E0PD and NFD=
. Note that this event counts accesses triggered by software preloads, but =
not accesses triggered by hardware prefetchers."
> +    },
> +    {
> +        "ArchStdEvent": "ITLB_STEP",
> +        "PublicDescription": "Counts number of memory accesses triggered=
 by an instruction translation table walk and performing a read of a transl=
ation table entry. Memory accesses are counted even if the translation ende=
d up taking a translation fault for reasons different than EPD, E0PD and NF=
D."
> +    },
> +    {
> +        "ArchStdEvent": "DTLB_WALK_LARGE",
> +        "PublicDescription": "Counts number of demand data translation t=
able walks caused by a miss in the L2 TLB and yielding a large page. The se=
t of large pages is defined as all pages with a final size higher than or e=
qual to 2MB. Translation table walks that end up taking a translation fault=
 are not counted, as the page size would be undefined in that case. If DTLB=
_WALK_BLOCK is implemented, then it is an alias for this event in this fami=
ly. Note that partial translations that cause a translation table walk are =
also counted. Also note that this event counts walks triggered by software =
preloads, but not walks triggered by hardware prefetchers, and that this ev=
ent does not count walks triggered by TLB maintenance operations."
> +    },
> +    {
> +        "ArchStdEvent": "ITLB_WALK_LARGE",
> +        "PublicDescription": "Counts number of instruction translation t=
able walks caused by a miss in the L2 TLB and yielding a large page. The se=
t of large pages is defined as all pages with a final size higher than or e=
qual to 2MB. Translation table walks that end up taking a translation fault=
 are not counted, as the page size would be undefined in that case. In this=
 family, this is equal to ITLB_WALK_BLOCK event. Note that partial translat=
ions that cause a translation table walk are also counted. Also note that t=
his event does not count walks triggered by TLB maintenance operations."
> +    },
> +    {
> +        "ArchStdEvent": "DTLB_WALK_SMALL",
> +        "PublicDescription": "Counts number of data translation table wa=
lks caused by a miss in the L2 TLB and yielding a small page. The set of sm=
all pages is defined as all pages with a final size lower than 2MB. Transla=
tion table walks that end up taking a translation fault are not counted, as=
 the page size would be undefined in that case. If DTLB_WALK_PAGE event is =
implemented, then it is an alias for this event in this family. Note that p=
artial translations that cause a translation table walk are also counted. A=
lso note that this event counts walks triggered by software preloads, but n=
ot walks triggered by hardware prefetchers, and that this event does not co=
unt walks triggered by TLB maintenance operations."
> +    },
> +    {
> +        "ArchStdEvent": "ITLB_WALK_SMALL",
> +        "PublicDescription": "Counts number of instruction translation t=
able walks caused by a miss in the L2 TLB and yielding a small page. The se=
t of small pages is defined as all pages with a final size lower than 2MB. =
Translation table walks that end up taking a translation fault are not coun=
ted, as the page size would be undefined in that case. In this family, this=
 is equal to ITLB_WALK_PAGE event. Note that partial translations that caus=
e a translation table walk are also counted. Also note that this event does=
 not count walks triggered by TLB maintenance operations."
> +    },
> +    {
> +        "ArchStdEvent": "DTLB_WALK_RW",
> +        "PublicDescription": "Counts number of demand data translation t=
able walks caused by a miss in the L2 TLB and performing at least one memor=
y access. Translation table walks are counted even if the translation ended=
 up taking a translation fault for reasons different than EPD, E0PD and NFD=
. Note that partial translations that cause a translation table walk are al=
so counted. Also note that this event does not count walks triggered by TLB=
 maintenance operations."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/trace.json =
b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/trace.json
> new file mode 100644
> index 000000000000..33672a8711d4
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/trace.json
> @@ -0,0 +1,32 @@
> +[
> +    {
> +        "ArchStdEvent": "TRB_WRAP"
> +    },
> +    {
> +        "ArchStdEvent": "TRB_TRIG"
> +    },
> +    {
> +        "ArchStdEvent": "TRCEXTOUT0"
> +    },
> +    {
> +        "ArchStdEvent": "TRCEXTOUT1"
> +    },
> +    {
> +        "ArchStdEvent": "TRCEXTOUT2"
> +    },
> +    {
> +        "ArchStdEvent": "TRCEXTOUT3"
> +    },
> +    {
> +        "ArchStdEvent": "CTI_TRIGOUT4"
> +    },
> +    {
> +        "ArchStdEvent": "CTI_TRIGOUT5"
> +    },
> +    {
> +        "ArchStdEvent": "CTI_TRIGOUT6"
> +    },
> +    {
> +        "ArchStdEvent": "CTI_TRIGOUT7"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json b=
/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
> index e40be37addf8..3e774c1e1413 100644
> --- a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
> +++ b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
> @@ -1339,6 +1339,11 @@
>          "EventName": "INST_FETCH",
>          "BriefDescription": "Instruction memory access"
>      },
> +    {
> +        "EventCode": "0x8125",
> +        "EventName": "BUS_REQ_RD_PERCYC",
> +        "BriefDescription": "Bus read transactions in progress"
> +    },
>      {
>          "EventCode": "0x8128",
>          "EventName": "DTLB_WALK_PERCYC",
> @@ -1539,6 +1544,11 @@
>          "EventName": "L2D_CACHE_HWPRF",
>          "BriefDescription": "Level 2 data cache hardware prefetch."
>      },
> +    {
> +        "EventCode": "0x8156",
> +        "EventName": "L3D_CACHE_HWPRF",
> +        "BriefDescription": "Level 3 data cache hardware prefetch."
> +    },
>      {
>          "EventCode": "0x8158",
>          "EventName": "STALL_FRONTEND_MEMBOUND",
> @@ -1674,6 +1684,11 @@
>          "EventName": "DTLB_WALK_PAGE",
>          "BriefDescription": "Data TLB page translation table walk."
>      },
> +    {
> +        "EventCode": "0x818D",
> +        "EventName": "BUS_REQ_RD",
> +        "BriefDescription": "Bus request, read"
> +    },
>      {
>          "EventCode": "0x818B",
>          "EventName": "ITLB_WALK_PAGE",
> diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pm=
u-events/arch/arm64/mapfile.csv
> index ccfcae375750..6b98632636e1 100644
> --- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
> @@ -32,6 +32,7 @@
>  0x00000000410fd440,v1,arm/cortex-x1,core
>  0x00000000410fd4c0,v1,arm/cortex-x1,core
>  0x00000000410fd460,v1,arm/cortex-a510,core
> +0x00000000410fd800,v1,arm/cortex-a520,core
>  0x00000000410fd470,v1,arm/cortex-a710,core
>  0x00000000410fd810,v1,arm/cortex-a720,core
>  0x00000000410fd480,v1,arm/cortex-x2,core
> --
> 2.47.2
>
