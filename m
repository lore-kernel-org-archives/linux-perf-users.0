Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5B11BBBC1
	for <linux-perf-users@vger.kernel.org>; Wed, 20 Nov 2024 18:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732127532; cv=none; b=Ix5kqrluREgdFU5IktwIUGstHGEgAl0kO7US7AHBxtileptvBY0KyI6Sw66Yz27hBg45A/Mzr3zs2KmhaNOSUPFxGWqFjK50iWtGlvzF8mzyLD9SPi1sl8NiJ70fEOVdAiHNbn1IKTNAURrye6CeJQMe0r+JzzWkdlZMA/jId0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732127532; c=relaxed/simple;
	bh=v7FzT2Y7X20KgQAQhnJt0PnnygW8kQzuXNIOtRz3Abg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L3SkGzUUEsbmALrcbJoTzLTmFIH+bneUEj86aTnAtHYrLAG63tZmm7d7+9nvxk2vXxjuthpd7nVlQl2VaVPiXEFqt1Or+GBxC9N9NpcrWQ57n5TjFekO9cOjt1Je80mFaB3o2oRdQN+9vJoBZQQCj9Kt/+UvVkhUTb0ZFTce/Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GQpvCQ5o; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GQpvCQ5o"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a762686909so406105ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Nov 2024 10:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732127527; x=1732732327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ugJHkDpsY7uo2BMtMUNuZXkhDGH2iu3OzoVjlOG0w0=;
        b=GQpvCQ5oy1Lf0q3Sy+Qg4hCfZM7vGnKkjJHfK7EMw6vJS9QGqfCm14zcHrsbQsayVW
         NVHSyG4Q2vdHXhkqWwaXaqGkDte2kN+Yts3aaUt9LahDJ1a4R/ugEM+qbVeCFL3wkCqz
         cu9ekAVmOqCnAR+j/+TtAsR0u4s+OguA0usDTIYXSW4JkO5u4GQc1pfTTEa8EWdJrK/x
         JRdkcT6JGiAdrr0D8DIiDWK84guB5j0BpKYn7b+htV6mBnW1mpUrPGBvab5mvpbb1ZiK
         EM8TFKl7g3iQjqi9aCZagiwb0Z0q5voFrrhdkqKkjvXTu2f5IYHoBlz1T6u8vMlV0WZE
         u8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732127527; x=1732732327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ugJHkDpsY7uo2BMtMUNuZXkhDGH2iu3OzoVjlOG0w0=;
        b=RTF41EK7jeLIZ475wtmRiLfOQRLUKDUSvZX5gKVCO1H/CwFjiowR3Wm5Wq+tzw+/gl
         Bo1s81UJd8TwxoWV+s6YlQLqD/PawmDx3kL4ziQF1pxmUTt8lxH4Jk88kKEvzp+/c6VD
         5nFuNPd/mo76L6Scw0yvXwcnTb+Rg6qHhHfkdO8GfTuRnwmfbZdfc0C+X4wpC+m+6TDY
         HxCZL+BfBLOJb0XkZf6spu5j1tu/wJw9SohdxFVGJjJMLVTMw2Dahsfp0y5XWKqvmnsY
         cMn/xzSwODiEjyAvWGHVytS7Miinmq68pbMjiFiuTOPRvGDtrzrCvbkAqzpwb9znWEOX
         c8/w==
X-Gm-Message-State: AOJu0YxrVbd/sK24a4KvuwvlbzIivUX0vlh+ZbERtECorjh2U9fN73LN
	lugg0H3tK2er6a7cuPi6kw8/7dlzpqL3+rqdy5m1pbm29OkOquNgRbmKtSgxdzpE+oZnbK1ejE9
	qywvZbdCFOwR09j0N7al0cEdBlc3NGpVQUkK5
X-Gm-Gg: ASbGnculdmxuA+AYASDBRa6fWcp7jgvi3/CsPzK/FjKTCU7DwlwNbm09yQ/7uuHOZuL
	6ryZMZ7tK5G0If83zmNeOC9/iF1rt0fBhexN5htRLKRkXPT5Uc4H9UaM4tXoZH/U=
X-Google-Smtp-Source: AGHT+IGeQRCH3dXFPHh0ltBccwVzwRP5kJ7XFbHBqDOTpQ4XPXi+XsQWtfsFa1SkeOfm6E9zhST9qfoiQnkMd48ULwY=
X-Received: by 2002:a05:6e02:1ca5:b0:3a7:8b05:4beb with SMTP id
 e9e14a558f8ab-3a78b054c50mr3017205ab.15.1732127526638; Wed, 20 Nov 2024
 10:32:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120143739.243728-1-james.clark@linaro.org>
In-Reply-To: <20241120143739.243728-1-james.clark@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 20 Nov 2024 10:31:55 -0800
Message-ID: <CAP-5=fWeJYf4mbSKSonwNhc5smw6_OktRBG2bCObcQiDjy2iAQ@mail.gmail.com>
Subject: Re: [PATCH] perf vendor events arm64: Update N2/V2 events from source
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 6:38=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> Update using the new data [1] for these changes:
>
>   * Scale some metrics like dtlb_walk_ratio to percent so they display
>     better with Perf's 2 dp precision
>   * Description typos, grammar and clarifications
>   * Unnecessary metric formula brackets seem to have been removed in the
>     source but this is not a functional change
>   * New sve_all_percentage metric
>
> The following command was used to generate this commit:
>
> $ telemetry-solution/tools/perf_json_generator/generate.py \
>   tools/perf/ --telemetry-files \
>   telemetry-solution/data/pmu/cpu/neoverse/neoverse-v2.json:neoverse-n2-v=
2
>
> [1]: https://gitlab.arm.com/telemetry-solution/telemetry-solution/-/blob/=
main/data/pmu/cpu/neoverse/neoverse-v2.json
>
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  .../arm64/arm/neoverse-n2-v2/exception.json   |  2 +-
>  .../arm64/arm/neoverse-n2-v2/general.json     |  2 +-
>  .../arm64/arm/neoverse-n2-v2/l1d_cache.json   |  6 +-
>  .../arm64/arm/neoverse-n2-v2/l2_cache.json    | 14 +--
>  .../arm64/arm/neoverse-n2-v2/l3_cache.json    |  4 +-
>  .../arm64/arm/neoverse-n2-v2/ll_cache.json    |  4 +-
>  .../arch/arm64/arm/neoverse-n2-v2/memory.json |  2 +-
>  .../arm64/arm/neoverse-n2-v2/metrics.json     | 93 ++++++++++---------
>  .../arm64/arm/neoverse-n2-v2/retired.json     |  4 +-
>  .../arm/neoverse-n2-v2/spec_operation.json    | 14 +--
>  .../arch/arm64/arm/neoverse-n2-v2/stall.json  |  8 +-
>  .../arch/arm64/arm/neoverse-n2-v2/tlb.json    |  4 +-
>  12 files changed, 82 insertions(+), 75 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/exceptio=
n.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/exception.json
> index 4404b8e91690..7126fbf292e0 100644
> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/exception.json
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/exception.json
> @@ -5,7 +5,7 @@
>      },
>      {
>          "ArchStdEvent": "EXC_RETURN",
> -        "PublicDescription": "Counts any architecturally executed except=
ion return instructions. Eg: AArch64: ERET"
> +        "PublicDescription": "Counts any architecturally executed except=
ion return instructions. For example: AArch64: ERET"
>      },
>      {
>          "ArchStdEvent": "EXC_UNDEF",
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/general.=
json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/general.json
> index 428810f855b8..c5dcdcf43c58 100644
> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/general.json
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/general.json
> @@ -5,6 +5,6 @@
>      },
>      {
>          "ArchStdEvent": "CNT_CYCLES",
> -        "PublicDescription": "Counts constant frequency cycles"
> +        "PublicDescription": "Increments at a constant frequency equal t=
o the rate of increment of the System Counter, CNTPCT_EL0."
>      }
>  ]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/l1d_cach=
e.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/l1d_cache.json
> index da7c129f2569..799d106d5173 100644
> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/l1d_cache.json
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/l1d_cache.json
> @@ -1,11 +1,11 @@
>  [
>      {
>          "ArchStdEvent": "L1D_CACHE_REFILL",
> -        "PublicDescription": "Counts level 1 data cache refills caused b=
y speculatively executed load or store operations that missed in the level =
1 data cache. This event only counts one event per cache line. This event d=
oes not count cache line allocations from preload instructions or from hard=
ware cache prefetching."
> +        "PublicDescription": "Counts level 1 data cache refills caused b=
y speculatively executed load or store operations that missed in the level =
1 data cache. This event only counts one event per cache line."

nit/fwiw: old description looked to have useful information

>      },
>      {
>          "ArchStdEvent": "L1D_CACHE",
> -        "PublicDescription": "Counts level 1 data cache accesses from an=
y load/store operations. Atomic operations that resolve in the CPUs caches =
(near atomic operations) count as both a write access and read access. Each=
 access to a cache line is counted including the multiple accesses caused b=
y single instructions such as LDM or STM. Each access to other level 1 data=
 or unified memory structures, for example refill buffers, write buffers, a=
nd write-back buffers, are also counted."
> +        "PublicDescription": "Counts level 1 data cache accesses from an=
y load/store operations. Atomic operations that resolve in the CPUs caches =
(near atomic operations) counts as both a write access and read access. Eac=
h access to a cache line is counted including the multiple accesses caused =
by single instructions such as LDM or STM. Each access to other level 1 dat=
a or unified memory structures, for example refill buffers, write buffers, =
and write-back buffers, are also counted."
>      },
>      {
>          "ArchStdEvent": "L1D_CACHE_WB",
> @@ -17,7 +17,7 @@
>      },
>      {
>          "ArchStdEvent": "L1D_CACHE_RD",
> -        "PublicDescription": "Counts level 1 data cache accesses from an=
y load operation. Atomic load operations that resolve in the CPUs caches co=
unt as both a write access and read access."
> +        "PublicDescription": "Counts level 1 data cache accesses from an=
y load operation. Atomic load operations that resolve in the CPUs caches co=
unts as both a write access and read access."
>      },
>      {
>          "ArchStdEvent": "L1D_CACHE_WR",
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/l2_cache=
.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/l2_cache.json
> index 0e31d0daf88b..ed8291ab9737 100644
> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/l2_cache.json
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/l2_cache.json
> @@ -1,11 +1,11 @@
>  [
>      {
>          "ArchStdEvent": "L2D_CACHE",
> -        "PublicDescription": "Counts level 2 cache accesses. level 2 cac=
he is a unified cache for data and instruction accesses. Accesses are for m=
isses in the first level caches or translation resolutions due to accesses.=
 This event also counts write back of dirty data from level 1 data cache to=
 the L2 cache."
> +        "PublicDescription": "Counts accesses to the level 2 cache due t=
o data accesses. Level 2 cache is a unified cache for data and instruction =
accesses. Accesses are for misses in the first level data cache or translat=
ion resolutions due to accesses. This event also counts write back of dirty=
 data from level 1 data cache to the L2 cache."
>      },
>      {
>          "ArchStdEvent": "L2D_CACHE_REFILL",
> -        "PublicDescription": "Counts cache line refills into the level 2=
 cache. level 2 cache is a unified cache for data and instruction accesses.=
 Accesses are for misses in the level 1 caches or translation resolutions d=
ue to accesses."
> +        "PublicDescription": "Counts cache line refills into the level 2=
 cache. Level 2 cache is a unified cache for data and instruction accesses.=
 Accesses are for misses in the level 1 data cache or translation resolutio=
ns due to accesses."
>      },
>      {
>          "ArchStdEvent": "L2D_CACHE_WB",
> @@ -13,23 +13,23 @@
>      },
>      {
>          "ArchStdEvent": "L2D_CACHE_ALLOCATE",
> -        "PublicDescription": "TBD"
> +        "PublicDescription": "Counts level 2 cache line allocates that d=
o not fetch data from outside the level 2 data or unified cache."
>      },
>      {
>          "ArchStdEvent": "L2D_CACHE_RD",
> -        "PublicDescription": "Counts level 2 cache accesses due to memor=
y read operations. level 2 cache is a unified cache for data and instructio=
n accesses, accesses are for misses in the level 1 caches or translation re=
solutions due to accesses."
> +        "PublicDescription": "Counts level 2 data cache accesses due to =
memory read operations. Level 2 cache is a unified cache for data and instr=
uction accesses, accesses are for misses in the level 1 data cache or trans=
lation resolutions due to accesses."
>      },
>      {
>          "ArchStdEvent": "L2D_CACHE_WR",
> -        "PublicDescription": "Counts level 2 cache accesses due to memor=
y write operations. level 2 cache is a unified cache for data and instructi=
on accesses, accesses are for misses in the level 1 caches or translation r=
esolutions due to accesses."
> +        "PublicDescription": "Counts level 2 cache accesses due to memor=
y write operations. Level 2 cache is a unified cache for data and instructi=
on accesses, accesses are for misses in the level 1 data cache or translati=
on resolutions due to accesses."
>      },
>      {
>          "ArchStdEvent": "L2D_CACHE_REFILL_RD",
> -        "PublicDescription": "Counts refills for memory accesses due to =
memory read operation counted by L2D_CACHE_RD. level 2 cache is a unified c=
ache for data and instruction accesses, accesses are for misses in the leve=
l 1 caches or translation resolutions due to accesses."
> +        "PublicDescription": "Counts refills for memory accesses due to =
memory read operation counted by L2D_CACHE_RD. Level 2 cache is a unified c=
ache for data and instruction accesses, accesses are for misses in the leve=
l 1 data cache or translation resolutions due to accesses."
>      },
>      {
>          "ArchStdEvent": "L2D_CACHE_REFILL_WR",
> -        "PublicDescription": "Counts refills for memory accesses due to =
memory write operation counted by L2D_CACHE_WR. level 2 cache is a unified =
cache for data and instruction accesses, accesses are for misses in the lev=
el 1 caches or translation resolutions due to accesses."
> +        "PublicDescription": "Counts refills for memory accesses due to =
memory write operation counted by L2D_CACHE_WR. Level 2 cache is a unified =
cache for data and instruction accesses, accesses are for misses in the lev=
el 1 data cache or translation resolutions due to accesses."
>      },
>      {
>          "ArchStdEvent": "L2D_CACHE_WB_VICTIM",
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/l3_cache=
.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/l3_cache.json
> index 45bfba532df7..4a2e72fc5ada 100644
> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/l3_cache.json
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/l3_cache.json
> @@ -9,11 +9,11 @@
>      },
>      {
>          "ArchStdEvent": "L3D_CACHE",
> -        "PublicDescription": "Counts level 3 cache accesses. level 3 cac=
he is a unified cache for data and instruction accesses. Accesses are for m=
isses in the lower level caches or translation resolutions due to accesses.=
"
> +        "PublicDescription": "Counts level 3 cache accesses. Level 3 cac=
he is a unified cache for data and instruction accesses. Accesses are for m=
isses in the lower level caches or translation resolutions due to accesses.=
"
>      },
>      {
>          "ArchStdEvent": "L3D_CACHE_RD",
> -        "PublicDescription": "TBD"
> +        "PublicDescription": "Counts level 3 cache accesses caused by an=
y memory read operation. Level 3 cache is a unified cache for data and inst=
ruction accesses. Accesses are for misses in the lower level caches or tran=
slation resolutions due to accesses."
>      },
>      {
>          "ArchStdEvent": "L3D_CACHE_LMISS_RD",
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/ll_cache=
.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/ll_cache.json
> index bb712d57d58a..fd5a2e0099b8 100644
> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/ll_cache.json
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/ll_cache.json
> @@ -1,10 +1,10 @@
>  [
>      {
>          "ArchStdEvent": "LL_CACHE_RD",
> -        "PublicDescription": "Counts read transactions that were returne=
d from outside the core cluster. This event counts when the system register=
 CPUECTLR.EXTLLC bit is set. This event counts read transactions returned f=
rom outside the core if those transactions are either hit in the system lev=
el cache or missed in the SLC and are returned from any other external sour=
ces."
> +        "PublicDescription": "Counts read transactions that were returne=
d from outside the core cluster. This event counts for external last level =
cache  when the system register CPUECTLR.EXTLLC bit is set, otherwise it co=
unts for the L3 cache. This event counts read transactions returned from ou=
tside the core if those transactions are either hit in the system level cac=
he or missed in the SLC and are returned from any other external sources."
>      },
>      {
>          "ArchStdEvent": "LL_CACHE_MISS_RD",
> -        "PublicDescription": "Counts read transactions that were returne=
d from outside the core cluster but missed in the system level cache. This =
event counts when the system register CPUECTLR.EXTLLC bit is set. This even=
t counts read transactions returned from outside the core if those transact=
ions are missed in the System level Cache. The data source of the transacti=
on is indicated by a field in the CHI transaction returning to the CPU. Thi=
s event does not count reads caused by cache maintenance operations."
> +        "PublicDescription": "Counts read transactions that were returne=
d from outside the core cluster but missed in the system level cache. This =
event counts for external last level cache when the system register CPUECTL=
R.EXTLLC bit is set, otherwise it counts for L3 cache. This event counts re=
ad transactions returned from outside the core if those transactions are mi=
ssed in the System level Cache. The data source of the transaction is indic=
ated by a field in the CHI transaction returning to the CPU. This event doe=
s not count reads caused by cache maintenance operations."
>      }
>  ]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/memory.j=
son b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/memory.json
> index 106a97f8b2e7..bb3491012a8f 100644
> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/memory.json
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/memory.json
> @@ -33,7 +33,7 @@
>      },
>      {
>          "ArchStdEvent": "MEM_ACCESS_CHECKED",
> -        "PublicDescription": "Counts the number of memory read and write=
 accesses in a cycle that are tag checked by the Memory Tagging Extension (=
MTE)."
> +        "PublicDescription": "Counts the number of memory read and write=
 accesses counted by MEM_ACCESS that are tag checked by the Memory Tagging =
Extension (MTE). This event is implemented as the sum of MEM_ACCESS_CHECKED=
_RD and MEM_ACCESS_CHECKED_WR"
>      },
>      {
>          "ArchStdEvent": "MEM_ACCESS_CHECKED_RD",
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.=
json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json
> index 5f449270b448..97d352f94323 100644
> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json
> @@ -5,7 +5,7 @@
>      },
>      {
>          "MetricName": "backend_stalled_cycles",
> -        "MetricExpr": "((STALL_BACKEND / CPU_CYCLES) * 100)",
> +        "MetricExpr": "STALL_BACKEND / CPU_CYCLES * 100",
>          "BriefDescription": "This metric is the percentage of cycles tha=
t were stalled due to resource constraints in the backend unit of the proce=
ssor.",
>          "MetricGroup": "Cycle_Accounting",
>          "ScaleUnit": "1percent of cycles"
> @@ -16,45 +16,45 @@
>      },
>      {
>          "MetricName": "branch_misprediction_ratio",
> -        "MetricExpr": "(BR_MIS_PRED_RETIRED / BR_RETIRED)",
> +        "MetricExpr": "BR_MIS_PRED_RETIRED / BR_RETIRED",
>          "BriefDescription": "This metric measures the ratio of branches =
mispredicted to the total number of branches architecturally executed. This=
 gives an indication of the effectiveness of the branch prediction unit.",
>          "MetricGroup": "Miss_Ratio;Branch_Effectiveness",
> -        "ScaleUnit": "1per branch"
> +        "ScaleUnit": "100percent of branches"
>      },
>      {
>          "MetricName": "branch_mpki",
> -        "MetricExpr": "((BR_MIS_PRED_RETIRED / INST_RETIRED) * 1000)",
> +        "MetricExpr": "BR_MIS_PRED_RETIRED / INST_RETIRED * 1000",
>          "BriefDescription": "This metric measures the number of branch m=
ispredictions per thousand instructions executed.",
>          "MetricGroup": "MPKI;Branch_Effectiveness",
>          "ScaleUnit": "1MPKI"
>      },
>      {
>          "MetricName": "branch_percentage",
> -        "MetricExpr": "(((BR_IMMED_SPEC + BR_INDIRECT_SPEC) / INST_SPEC)=
 * 100)",
> +        "MetricExpr": "(BR_IMMED_SPEC + BR_INDIRECT_SPEC) / INST_SPEC * =
100",
>          "BriefDescription": "This metric measures branch operations as a=
 percentage of operations speculatively executed.",
>          "MetricGroup": "Operation_Mix",
>          "ScaleUnit": "1percent of operations"
>      },
>      {
>          "MetricName": "crypto_percentage",
> -        "MetricExpr": "((CRYPTO_SPEC / INST_SPEC) * 100)",
> +        "MetricExpr": "CRYPTO_SPEC / INST_SPEC * 100",
>          "BriefDescription": "This metric measures crypto operations as a=
 percentage of operations speculatively executed.",
>          "MetricGroup": "Operation_Mix",
>          "ScaleUnit": "1percent of operations"
>      },
>      {
>          "MetricName": "dtlb_mpki",
> -        "MetricExpr": "((DTLB_WALK / INST_RETIRED) * 1000)",
> +        "MetricExpr": "DTLB_WALK / INST_RETIRED * 1000",
>          "BriefDescription": "This metric measures the number of data TLB=
 Walks per thousand instructions executed.",
>          "MetricGroup": "MPKI;DTLB_Effectiveness",
>          "ScaleUnit": "1MPKI"
>      },
>      {
>          "MetricName": "dtlb_walk_ratio",
> -        "MetricExpr": "(DTLB_WALK / L1D_TLB)",
> +        "MetricExpr": "DTLB_WALK / L1D_TLB",
>          "BriefDescription": "This metric measures the ratio of data TLB =
Walks to the total number of data TLB accesses. This gives an indication of=
 the effectiveness of the data TLB accesses.",
>          "MetricGroup": "Miss_Ratio;DTLB_Effectiveness",
> -        "ScaleUnit": "1per TLB access"
> +        "ScaleUnit": "100percent of TLB accesses"
>      },
>      {
>          "ArchStdEvent": "frontend_bound",
> @@ -62,147 +62,147 @@
>      },
>      {
>          "MetricName": "frontend_stalled_cycles",
> -        "MetricExpr": "((STALL_FRONTEND / CPU_CYCLES) * 100)",
> +        "MetricExpr": "STALL_FRONTEND / CPU_CYCLES * 100",
>          "BriefDescription": "This metric is the percentage of cycles tha=
t were stalled due to resource constraints in the frontend unit of the proc=
essor.",
>          "MetricGroup": "Cycle_Accounting",
>          "ScaleUnit": "1percent of cycles"
>      },
>      {
>          "MetricName": "integer_dp_percentage",
> -        "MetricExpr": "((DP_SPEC / INST_SPEC) * 100)",
> +        "MetricExpr": "DP_SPEC / INST_SPEC * 100",
>          "BriefDescription": "This metric measures scalar integer operati=
ons as a percentage of operations speculatively executed.",
>          "MetricGroup": "Operation_Mix",
>          "ScaleUnit": "1percent of operations"
>      },
>      {
>          "MetricName": "ipc",
> -        "MetricExpr": "(INST_RETIRED / CPU_CYCLES)",
> +        "MetricExpr": "INST_RETIRED / CPU_CYCLES",
>          "BriefDescription": "This metric measures the number of instruct=
ions retired per cycle.",
>          "MetricGroup": "General",
>          "ScaleUnit": "1per cycle"
>      },
>      {
>          "MetricName": "itlb_mpki",
> -        "MetricExpr": "((ITLB_WALK / INST_RETIRED) * 1000)",
> +        "MetricExpr": "ITLB_WALK / INST_RETIRED * 1000",
>          "BriefDescription": "This metric measures the number of instruct=
ion TLB Walks per thousand instructions executed.",
>          "MetricGroup": "MPKI;ITLB_Effectiveness",
>          "ScaleUnit": "1MPKI"
>      },
>      {
>          "MetricName": "itlb_walk_ratio",
> -        "MetricExpr": "(ITLB_WALK / L1I_TLB)",
> +        "MetricExpr": "ITLB_WALK / L1I_TLB",
>          "BriefDescription": "This metric measures the ratio of instructi=
on TLB Walks to the total number of instruction TLB accesses. This gives an=
 indication of the effectiveness of the instruction TLB accesses.",
>          "MetricGroup": "Miss_Ratio;ITLB_Effectiveness",
> -        "ScaleUnit": "1per TLB access"
> +        "ScaleUnit": "100percent of TLB accesses"
>      },
>      {
>          "MetricName": "l1d_cache_miss_ratio",
> -        "MetricExpr": "(L1D_CACHE_REFILL / L1D_CACHE)",
> +        "MetricExpr": "L1D_CACHE_REFILL / L1D_CACHE",
>          "BriefDescription": "This metric measures the ratio of level 1 d=
ata cache accesses missed to the total number of level 1 data cache accesse=
s. This gives an indication of the effectiveness of the level 1 data cache.=
",
>          "MetricGroup": "Miss_Ratio;L1D_Cache_Effectiveness",
> -        "ScaleUnit": "1per cache access"
> +        "ScaleUnit": "100percent of cache accesses"
>      },
>      {
>          "MetricName": "l1d_cache_mpki",
> -        "MetricExpr": "((L1D_CACHE_REFILL / INST_RETIRED) * 1000)",
> +        "MetricExpr": "L1D_CACHE_REFILL / INST_RETIRED * 1000",
>          "BriefDescription": "This metric measures the number of level 1 =
data cache accesses missed per thousand instructions executed.",
>          "MetricGroup": "MPKI;L1D_Cache_Effectiveness",
>          "ScaleUnit": "1MPKI"
>      },
>      {
>          "MetricName": "l1d_tlb_miss_ratio",
> -        "MetricExpr": "(L1D_TLB_REFILL / L1D_TLB)",
> +        "MetricExpr": "L1D_TLB_REFILL / L1D_TLB",
>          "BriefDescription": "This metric measures the ratio of level 1 d=
ata TLB accesses missed to the total number of level 1 data TLB accesses. T=
his gives an indication of the effectiveness of the level 1 data TLB.",
>          "MetricGroup": "Miss_Ratio;DTLB_Effectiveness",
> -        "ScaleUnit": "1per TLB access"
> +        "ScaleUnit": "100percent of TLB accesses"
>      },
>      {
>          "MetricName": "l1d_tlb_mpki",
> -        "MetricExpr": "((L1D_TLB_REFILL / INST_RETIRED) * 1000)",
> -        "BriefDescription": "This metric measures the number of level 1 =
instruction TLB accesses missed per thousand instructions executed.",
> +        "MetricExpr": "L1D_TLB_REFILL / INST_RETIRED * 1000",
> +        "BriefDescription": "This metric measures the number of level 1 =
data TLB accesses missed per thousand instructions executed.",
>          "MetricGroup": "MPKI;DTLB_Effectiveness",
>          "ScaleUnit": "1MPKI"
>      },
>      {
>          "MetricName": "l1i_cache_miss_ratio",
> -        "MetricExpr": "(L1I_CACHE_REFILL / L1I_CACHE)",
> +        "MetricExpr": "L1I_CACHE_REFILL / L1I_CACHE",
>          "BriefDescription": "This metric measures the ratio of level 1 i=
nstruction cache accesses missed to the total number of level 1 instruction=
 cache accesses. This gives an indication of the effectiveness of the level=
 1 instruction cache.",
>          "MetricGroup": "Miss_Ratio;L1I_Cache_Effectiveness",
> -        "ScaleUnit": "1per cache access"
> +        "ScaleUnit": "100percent of cache accesses"
>      },
>      {
>          "MetricName": "l1i_cache_mpki",
> -        "MetricExpr": "((L1I_CACHE_REFILL / INST_RETIRED) * 1000)",
> +        "MetricExpr": "L1I_CACHE_REFILL / INST_RETIRED * 1000",
>          "BriefDescription": "This metric measures the number of level 1 =
instruction cache accesses missed per thousand instructions executed.",
>          "MetricGroup": "MPKI;L1I_Cache_Effectiveness",
>          "ScaleUnit": "1MPKI"
>      },
>      {
>          "MetricName": "l1i_tlb_miss_ratio",
> -        "MetricExpr": "(L1I_TLB_REFILL / L1I_TLB)",
> +        "MetricExpr": "L1I_TLB_REFILL / L1I_TLB",
>          "BriefDescription": "This metric measures the ratio of level 1 i=
nstruction TLB accesses missed to the total number of level 1 instruction T=
LB accesses. This gives an indication of the effectiveness of the level 1 i=
nstruction TLB.",
>          "MetricGroup": "Miss_Ratio;ITLB_Effectiveness",
> -        "ScaleUnit": "1per TLB access"
> +        "ScaleUnit": "100percent of TLB accesses"
>      },
>      {
>          "MetricName": "l1i_tlb_mpki",
> -        "MetricExpr": "((L1I_TLB_REFILL / INST_RETIRED) * 1000)",
> +        "MetricExpr": "L1I_TLB_REFILL / INST_RETIRED * 1000",
>          "BriefDescription": "This metric measures the number of level 1 =
instruction TLB accesses missed per thousand instructions executed.",
>          "MetricGroup": "MPKI;ITLB_Effectiveness",
>          "ScaleUnit": "1MPKI"
>      },
>      {
>          "MetricName": "l2_cache_miss_ratio",
> -        "MetricExpr": "(L2D_CACHE_REFILL / L2D_CACHE)",
> +        "MetricExpr": "L2D_CACHE_REFILL / L2D_CACHE",
>          "BriefDescription": "This metric measures the ratio of level 2 c=
ache accesses missed to the total number of level 2 cache accesses. This gi=
ves an indication of the effectiveness of the level 2 cache, which is a uni=
fied cache that stores both data and instruction. Note that cache accesses =
in this cache are either data memory access or instruction fetch as this is=
 a unified cache.",
>          "MetricGroup": "Miss_Ratio;L2_Cache_Effectiveness",
> -        "ScaleUnit": "1per cache access"
> +        "ScaleUnit": "100percent of cache accesses"
>      },
>      {
>          "MetricName": "l2_cache_mpki",
> -        "MetricExpr": "((L2D_CACHE_REFILL / INST_RETIRED) * 1000)",
> +        "MetricExpr": "L2D_CACHE_REFILL / INST_RETIRED * 1000",
>          "BriefDescription": "This metric measures the number of level 2 =
unified cache accesses missed per thousand instructions executed. Note that=
 cache accesses in this cache are either data memory access or instruction =
fetch as this is a unified cache.",
>          "MetricGroup": "MPKI;L2_Cache_Effectiveness",
>          "ScaleUnit": "1MPKI"
>      },
>      {
>          "MetricName": "l2_tlb_miss_ratio",
> -        "MetricExpr": "(L2D_TLB_REFILL / L2D_TLB)",
> +        "MetricExpr": "L2D_TLB_REFILL / L2D_TLB",
>          "BriefDescription": "This metric measures the ratio of level 2 u=
nified TLB accesses missed to the total number of level 2 unified TLB acces=
ses. This gives an indication of the effectiveness of the level 2 TLB.",
>          "MetricGroup": "Miss_Ratio;ITLB_Effectiveness;DTLB_Effectiveness=
",
> -        "ScaleUnit": "1per TLB access"
> +        "ScaleUnit": "100percent of TLB accesses"
>      },
>      {
>          "MetricName": "l2_tlb_mpki",
> -        "MetricExpr": "((L2D_TLB_REFILL / INST_RETIRED) * 1000)",
> +        "MetricExpr": "L2D_TLB_REFILL / INST_RETIRED * 1000",
>          "BriefDescription": "This metric measures the number of level 2 =
unified TLB accesses missed per thousand instructions executed.",
>          "MetricGroup": "MPKI;ITLB_Effectiveness;DTLB_Effectiveness",
>          "ScaleUnit": "1MPKI"
>      },
>      {
>          "MetricName": "ll_cache_read_hit_ratio",
> -        "MetricExpr": "((LL_CACHE_RD - LL_CACHE_MISS_RD) / LL_CACHE_RD)"=
,
> +        "MetricExpr": "(LL_CACHE_RD - LL_CACHE_MISS_RD) / LL_CACHE_RD",
>          "BriefDescription": "This metric measures the ratio of last leve=
l cache read accesses hit in the cache to the total number of last level ca=
che accesses. This gives an indication of the effectiveness of the last lev=
el cache for read traffic. Note that cache accesses in this cache are eithe=
r data memory access or instruction fetch as this is a system level cache."=
,
>          "MetricGroup": "LL_Cache_Effectiveness",
> -        "ScaleUnit": "1per cache access"
> +        "ScaleUnit": "100percent of cache accesses"
>      },
>      {
>          "MetricName": "ll_cache_read_miss_ratio",
> -        "MetricExpr": "(LL_CACHE_MISS_RD / LL_CACHE_RD)",
> +        "MetricExpr": "LL_CACHE_MISS_RD / LL_CACHE_RD",
>          "BriefDescription": "This metric measures the ratio of last leve=
l cache read accesses missed to the total number of last level cache access=
es. This gives an indication of the effectiveness of the last level cache f=
or read traffic. Note that cache accesses in this cache are either data mem=
ory access or instruction fetch as this is a system level cache.",
>          "MetricGroup": "Miss_Ratio;LL_Cache_Effectiveness",
> -        "ScaleUnit": "1per cache access"
> +        "ScaleUnit": "100percent of cache accesses"
>      },
>      {
>          "MetricName": "ll_cache_read_mpki",
> -        "MetricExpr": "((LL_CACHE_MISS_RD / INST_RETIRED) * 1000)",
> +        "MetricExpr": "LL_CACHE_MISS_RD / INST_RETIRED * 1000",
>          "BriefDescription": "This metric measures the number of last lev=
el cache read accesses missed per thousand instructions executed.",
>          "MetricGroup": "MPKI;LL_Cache_Effectiveness",
>          "ScaleUnit": "1MPKI"
>      },
>      {
>          "MetricName": "load_percentage",
> -        "MetricExpr": "((LD_SPEC / INST_SPEC) * 100)",
> +        "MetricExpr": "LD_SPEC / INST_SPEC * 100",
>          "BriefDescription": "This metric measures load operations as a p=
ercentage of operations speculatively executed.",
>          "MetricGroup": "Operation_Mix",
>          "ScaleUnit": "1percent of operations"
> @@ -213,21 +213,21 @@
>      },
>      {
>          "MetricName": "scalar_fp_percentage",
> -        "MetricExpr": "((VFP_SPEC / INST_SPEC) * 100)",
> +        "MetricExpr": "VFP_SPEC / INST_SPEC * 100",
>          "BriefDescription": "This metric measures scalar floating point =
operations as a percentage of operations speculatively executed.",
>          "MetricGroup": "Operation_Mix",
>          "ScaleUnit": "1percent of operations"
>      },
>      {
>          "MetricName": "simd_percentage",
> -        "MetricExpr": "((ASE_SPEC / INST_SPEC) * 100)",
> +        "MetricExpr": "ASE_SPEC / INST_SPEC * 100",
>          "BriefDescription": "This metric measures advanced SIMD operatio=
ns as a percentage of total operations speculatively executed.",
>          "MetricGroup": "Operation_Mix",
>          "ScaleUnit": "1percent of operations"
>      },
>      {
>          "MetricName": "store_percentage",
> -        "MetricExpr": "((ST_SPEC / INST_SPEC) * 100)",
> +        "MetricExpr": "ST_SPEC / INST_SPEC * 100",
>          "BriefDescription": "This metric measures store operations as a =
percentage of operations speculatively executed.",
>          "MetricGroup": "Operation_Mix",
>          "ScaleUnit": "1percent of operations"
> @@ -300,5 +300,12 @@
>          "MetricGroup": "Operation_Mix",
>          "MetricName": "branch_indirect_spec_rate",
>          "ScaleUnit": "100%"
> +    },
> +    {
> +        "MetricName": "sve_all_percentage",
> +        "MetricExpr": "SVE_INST_SPEC / INST_SPEC * 100",
> +        "BriefDescription": "This metric measures scalable vector operat=
ions, including loads and stores, as a percentage of operations speculative=
ly executed.",
> +        "MetricGroup": "Operation_Mix",
> +        "ScaleUnit": "1percent of operations"
>      }
>  ]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/retired.=
json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/retired.json
> index f297b049b62f..337e6a916f2b 100644
> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/retired.json
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/retired.json
> @@ -9,7 +9,7 @@
>      },
>      {
>          "ArchStdEvent": "CID_WRITE_RETIRED",
> -        "PublicDescription": "Counts architecturally executed writes to =
the CONTEXTIDR register, which usually contain the kernel PID and can be ou=
tput with hardware trace."
> +        "PublicDescription": "Counts architecturally executed writes to =
the CONTEXTIDR_EL1 register, which usually contain the kernel PID and can b=
e output with hardware trace."
>      },
>      {
>          "ArchStdEvent": "TTBR_WRITE_RETIRED",
> @@ -17,7 +17,7 @@
>      },
>      {
>          "ArchStdEvent": "BR_RETIRED",
> -        "PublicDescription": "Counts architecturally executed branches, =
whether the branch is taken or not. Instructions that explicitly write to t=
he PC are also counted."
> +        "PublicDescription": "Counts architecturally executed branches, =
whether the branch is taken or not. Instructions that explicitly write to t=
he PC are also counted. Note that exception generating instructions, except=
ion return instructions and context synchronization instructions are not co=
unted."
>      },
>      {
>          "ArchStdEvent": "BR_MIS_PRED_RETIRED",
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/spec_ope=
ration.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/spec_oper=
ation.json
> index 1af961f8a6c8..a7ea0d4c4ea4 100644
> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/spec_operation.=
json
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/spec_operation.=
json
> @@ -5,7 +5,7 @@
>      },
>      {
>          "ArchStdEvent": "BR_PRED",
> -        "PublicDescription": "Counts branches speculatively executed and=
 were predicted right."
> +        "PublicDescription": "Counts all speculatively executed branches=
."
>      },
>      {
>          "ArchStdEvent": "INST_SPEC",
> @@ -29,7 +29,7 @@
>      },
>      {
>          "ArchStdEvent": "LDREX_SPEC",
> -        "PublicDescription": "Counts Load-Exclusive operations that have=
 been speculatively executed. Eg: LDREX, LDX"
> +        "PublicDescription": "Counts Load-Exclusive operations that have=
 been speculatively executed. For example: LDREX, LDX"
>      },
>      {
>          "ArchStdEvent": "STREX_PASS_SPEC",
> @@ -73,15 +73,15 @@
>      },
>      {
>          "ArchStdEvent": "BR_IMMED_SPEC",
> -        "PublicDescription": "Counts immediate branch operations which a=
re speculatively executed."
> +        "PublicDescription": "Counts direct branch operations which are =
speculatively executed."
>      },
>      {
>          "ArchStdEvent": "BR_RETURN_SPEC",
> -        "PublicDescription": "Counts procedure return operations (RET) w=
hich are speculatively executed."
> +        "PublicDescription": "Counts procedure return operations (RET, R=
ETAA and RETAB) which are speculatively executed."
>      },
>      {
>          "ArchStdEvent": "BR_INDIRECT_SPEC",
> -        "PublicDescription": "Counts indirect branch operations includin=
g procedure returns, which are speculatively executed. This includes operat=
ions that force a software change of the PC, other than exception-generatin=
g operations.  Eg: BR Xn, RET"
> +        "PublicDescription": "Counts indirect branch operations includin=
g procedure returns, which are speculatively executed. This includes operat=
ions that force a software change of the PC, other than exception-generatin=
g operations and direct branch instructions. Some examples of the instructi=
ons counted by this event include BR Xn, RET, etc..."
>      },
>      {
>          "ArchStdEvent": "ISB_SPEC",
> @@ -97,11 +97,11 @@
>      },
>      {
>          "ArchStdEvent": "RC_LD_SPEC",
> -        "PublicDescription": "Counts any load acquire operations that ar=
e speculatively executed. Eg: LDAR, LDARH, LDARB"
> +        "PublicDescription": "Counts any load acquire operations that ar=
e speculatively executed. For example: LDAR, LDARH, LDARB"
>      },
>      {
>          "ArchStdEvent": "RC_ST_SPEC",
> -        "PublicDescription": "Counts any store release operations that a=
re speculatively executed. Eg: STLR, STLRH, STLRB'"
> +        "PublicDescription": "Counts any store release operations that a=
re speculatively executed. For example: STLR, STLRH, STLRB"
>      },
>      {
>          "ArchStdEvent": "ASE_INST_SPEC",
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/stall.js=
on b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/stall.json
> index bbbebc805034..1fcba19dfb7d 100644
> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/stall.json
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/stall.json
> @@ -1,7 +1,7 @@
>  [
>      {
>          "ArchStdEvent": "STALL_FRONTEND",
> -        "PublicDescription": "Counts cycles when frontend could not send=
 any micro-operations to the rename stage because of frontend resource stal=
ls caused by fetch memory latency or branch prediction flow stalls. All the=
 frontend slots were empty during the cycle when this event counts."
> +        "PublicDescription": "Counts cycles when frontend could not send=
 any micro-operations to the rename stage because of frontend resource stal=
ls caused by fetch memory latency or branch prediction flow stalls. STALL_F=
RONTEND_SLOTS counts SLOTS during the cycle when this event counts."
>      },
>      {
>          "ArchStdEvent": "STALL_BACKEND",
> @@ -9,11 +9,11 @@
>      },
>      {
>          "ArchStdEvent": "STALL",
> -        "PublicDescription": "Counts cycles when no operations are sent =
to the rename unit from the frontend or from the rename unit to the backend=
 for any reason (either frontend or backend stall)."
> +        "PublicDescription": "Counts cycles when no operations are sent =
to the rename unit from the frontend or from the rename unit to the backend=
 for any reason (either frontend or backend stall). This event is the sum o=
f STALL_FRONTEND and STALL_BACKEND"
>      },
>      {
>          "ArchStdEvent": "STALL_SLOT_BACKEND",
> -        "PublicDescription": "Counts slots per cycle in which no operati=
ons are sent from the rename unit to the backend due to backend resource co=
nstraints."
> +        "PublicDescription": "Counts slots per cycle in which no operati=
ons are sent from the rename unit to the backend due to backend resource co=
nstraints. STALL_BACKEND counts during the cycle when STALL_SLOT_BACKEND co=
unts at least 1."
>      },
>      {
>          "ArchStdEvent": "STALL_SLOT_FRONTEND",
> @@ -21,7 +21,7 @@
>      },
>      {
>          "ArchStdEvent": "STALL_SLOT",
> -        "PublicDescription": "Counts slots per cycle in which no operati=
ons are sent to the rename unit from the frontend or from the rename unit t=
o the backend for any reason (either frontend or backend stall)."
> +        "PublicDescription": "Counts slots per cycle in which no operati=
ons are sent to the rename unit from the frontend or from the rename unit t=
o the backend for any reason (either frontend or backend stall). STALL_SLOT=
 is the sum of STALL_SLOT_FRONTEND and STALL_SLOT_BACKEND."
>      },
>      {
>          "ArchStdEvent": "STALL_BACKEND_MEM",
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/tlb.json=
 b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/tlb.json
> index b550af1831f5..5704f1e83af9 100644
> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/tlb.json
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/tlb.json
> @@ -25,11 +25,11 @@
>      },
>      {
>          "ArchStdEvent": "DTLB_WALK",
> -        "PublicDescription": "Counts data memory translation table walks=
 caused by a miss in the L2 TLB driven by a memory access. Note that partia=
l translations that also cause a table walk are counted. This event does no=
t count table walks caused by TLB maintenance operations."
> +        "PublicDescription": "Counts number of demand data translation t=
able walks caused by a miss in the L2 TLB and performing at least one memor=
y access. Translation table walks are counted even if the translation ended=
 up taking a translation fault for reasons different than EPD, E0PD and NFD=
. Note that partial translations that cause a translation table walk are al=
so counted. Also note that this event counts walks triggered by software pr=
eloads, but not walks triggered by hardware prefetchers, and that this even=
t does not count walks triggered by TLB maintenance operations."
>      },
>      {
>          "ArchStdEvent": "ITLB_WALK",
> -        "PublicDescription": "Counts instruction memory translation tabl=
e walks caused by a miss in the L2 TLB driven by a memory access. Partial t=
ranslations that also cause a table walk are counted. This event does not c=
ount table walks caused by TLB maintenance operations."
> +        "PublicDescription": "Counts number of instruction translation t=
able walks caused by a miss in the L2 TLB and performing at least one memor=
y access. Translation table walks are counted even if the translation ended=
 up taking a translation fault for reasons different than EPD, E0PD and NFD=
. Note that partial translations that cause a translation table walk are al=
so counted. Also note that this event does not count walks triggered by TLB=
 maintenance operations."
>      },
>      {
>          "ArchStdEvent": "L1D_TLB_REFILL_RD",
> --
> 2.34.1
>
