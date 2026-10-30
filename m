Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793383638;
	b=Nt/Mn8r8HtS1pIobzfMF0fvWhA0+yY3unKO4eP+aZ5Dr2fdZzFwBgyOvrbvhyWhM8usf
	 /DiMHL8bkL7ZHIer3LAXHMbWooEOWmGGSUeRRbxsiJ7yvK++lnsJkgwMLSucMWXZjpoPv
	 Fq7p0vPCN2bii4S0gp1NstSusEJ7SK2+n4t1hF8FkpJ68mC8Bn/T9iFXBn6vaLIx87n06
	 zPLiyx+U+bhUDPwbI1B99sEYeu0GQEKQD4eIb9E1uFvOYoAH8OF8xo2vIUspxryl5nAuY
	 HuygfJ2wtbzQ2ZvY13sDcbVDqekBFwB4/yNztK4xN48nStjwPkTwjjA7dk2pgRvZSmw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793383638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Yee/M/vhaQksyDRzfPy2oYsyP6s0T7Yq+RK3mjeMx4U=;
	b=qsWVO2L9wTC7rc94DfntXzt81HkG9yr3/rM2xQJaPioDxrTWjrundrWumILIacLin4U0
	 VWz32btoRwDKPO9GbEwoQGvQqT20HoO1ILjCAuSS4I7DBVOcocGaAfWGu5khjU2nqbJXx
	 5givlsAoVV7MPbwBwQOMzIbaO4trCvGRbKhrQ9oKnHBgTIE2wc7r79mTlshp4vhIQqGDb
	 tXjVUgnIaDC/twEHzD/aYGQXgBbxamRfCQCGfWJM4ZYTjTAoqVVGpXeh1B7NWVnLIIWKx
	 v8Na43gyDa5GmzpeTbGLSbMYuQR9svBdv3aZWjIFpdOxk8ZlEzh8g/cnzH3Rnnb8MNg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MFZfb5uU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDE2606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 18:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFDE2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MFZfb5uU
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1ae7fc5681dso523c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 11:07:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793383637; cv=none;
        d=google.com; s=arc-20260327;
        b=aY1nSVeD7sUnYLlAuRJa+jb+dQ/Vc1gTEka/jcnQLMaebFb0ody7RXGvhk9jkvmowz
         3R1U+bQCrvDem34ol6A5X+1eVjnP3iiQQl7r95f6iCXdKHJ/unaVG8FOCUhMiO9aupX5
         5bkJ2IxPun8I0Nhb2leW+EEWM5sVUecJ3TXBsWK8rtULRscmyNGN+T8hSBoQJtte/4Rq
         4pMUfVHx68yq5nmToKccRysh2tptQDn3gtI/i5g07WhYe24mVXFalcWY1T1wwd81RxQt
         GZZTCUWPPrhhw3Jq48w8D8SVHBMg+AlJSLrQByF3m8m0R9LKHW9Bv4QY5yzl3QoqFuwh
         GiYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yee/M/vhaQksyDRzfPy2oYsyP6s0T7Yq+RK3mjeMx4U=;
        fh=0diOuL8EDh0CV07tbgZeSWN1BWR+18d54VSvRy9U7ek=;
        b=dlmtKjFhWQHoAFHos9ht5w6FGoONMwOHxEF1Tg5K8r8Kda5dyL1GrY6T++TqVSG0qF
         kdliGHQQL1Rr8+fdvlje/Ax9jryEB2CwTeG9HI0annj9f2h2v+Y4ho+yvRUu+j5B3L08
         qHsXZ6GFw6soaQLSpH/PbC/lPlxsjMyAmWubr6VLvy2S/fkXz5dZ7W1BLQKRVcfKOFdv
         sFs+4DeWmTmPJPd2rIxbo9jNuPQAgLBPmIDbxEYCC2Fp1eD8HZicvgg1FcX47bpgpoQG
         XtO2cgI8e2/AnPsrfABknfE1wmVstDtMJdVCn0avoqxT9GqQ3Ylp2S4yzbTUB3ZkUia0
         VKiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793383637; x=1793988437; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yee/M/vhaQksyDRzfPy2oYsyP6s0T7Yq+RK3mjeMx4U=;
        b=MFZfb5uUpuPCKMoHiVswKA/CTet+ZjcCeKaMZc49/8un4YNIWAQ3A8wCFBFo8/0r4T
         I2MjO0Fwvj8mIfoKuXZ7VuNbagzXrJOww583+uv+LHGfuY2+WKUdxVTbuz9dupXYrEJB
         fX8UdXPueXf4LO3Y5pf7ZvQuU8o8f4oqpcrzWlIy2HDC45qTZmCVCRv99JmAwDpFPXnS
         ZzJadKqFJV/s3uC2+vE/lGmi3ByS56aw+1VBeshQ0cR9WrtRmtRBsM/ZtUZDGK98vudB
         p1QaHqobJLbTc2PCqLn+FVzHgDboERmc0JsL4Tvznxmla3Qw3QxCUTYkeJYsI7Owbfdm
         WChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793383637; x=1793988437;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yee/M/vhaQksyDRzfPy2oYsyP6s0T7Yq+RK3mjeMx4U=;
        b=Oo28PTWyNG/L96yQu1Pc9zyAFb5q3i9ZzYMjpFA1PAqG2uz3efsweRCwy9SEdILnzt
         2Os81Gf8PW4xz4qyrF3JwtW/OR78LxAIcKEzAkdmrzxmh4VppRphHG72HACXBEUiShFZ
         8Ru7s4nZ18hJVk1AXf/bEwg6+lLS8hGKflMPUSNBa5hJkHVRMK0t9IKl1Id8poY27mER
         NQKEUFtgmajOVFyrtDP8Om57nY5yYSJfYsuWNbcumPosgB+/RP77UToYJd36hcoV+LCg
         2H3Aid+RPDES2xgCg8/yYqHKzbt+8ov98HymESb02OmFwwftV4NK4j7mlQk+iDs5EVN9
         EVdA==
X-Forwarded-Encrypted: i=1; AKwUvBz8FeX2KFXZKLSpSCDgiXrXpLPyIjRYNfa3K6+q3dzE0XfQXTntEXB0UxLlkGLat/HIxW5NFZOOXOOSc3wGaJS9@vger.kernel.org
X-Gm-Message-State: AFq9FYLxzlk/X7IlViW1t5RT7JBEdt+rB3AgNN2Fba9CxDfEf3C/YcOA
	F0ek/jbL1NnN1o8VSw/eqtqO3Zme/8lyAGz+Ziulek9CBqZJtpLFKrUFstRfpHmldKWI5MFHw1x
	WKLvdmQU3K4PzUmANmSStN6Ni1SCammdk1/4L5rFX
X-Gm-Gg: AYBFou3MFS+UO6O0C6xONfK/Vptj9CpLHJGxNLbb9G+pV1DE9YHFwRqeey5M7PLP8eJ
	jWqv4m+MB4U+3EJ4Gu5oBiSkTFnMwz35rTm+uwby9tD44g1/coMobRTV1ex5fyu9k02/AMri/av
	LfMsUS9GpH2syNNq+d6b5+S7gauVEzocP0t02Mk7g6eKUcpdCK3ZS7iU/q66vh+RZK4qibdbJO0
	KfK/2gAAoXFlqJoBxh+jdt+BvkfkkFCIbzvKHsu/AgBJbVt/Wz9lGod1HDDuTINO7SjQJpEUBPv
	d/PHCojkilZ9+d896IbFJHFpy7x/0y9C7f6MONLv2WxUSVN6iRotfnignkf4K1HvUgVxgt0yV+o
	Cdk/MJlI0aSlF5ceHgtg9pvDksYTVlqLLvZY/SJKzlt64JDsTiL9gKe0a0yhmTlNH8AcauhYqbc
	TAp2CeMp2dI6RkwQ==
X-Received: by 2002:a05:701b:418f:10b0:162:1b69:fe06 with SMTP id
 a92af1059eb24-1a99bfb8c44mr948799c88.14.1793383635496; Fri, 30 Oct 2026
 11:07:15 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030174816.1544471-1-bwicaksono@nvidia.com>
In-Reply-To: <20261030174816.1544471-1-bwicaksono@nvidia.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 30 Oct 2026 11:07:03 -0700
X-Gm-Features: AclHuK_KkDFZvz94Iv9OiENJydeV5pIlSlXsWtxJeGMUrrlYUp2oAVSujcV7xFQ
Message-ID: <CAP-5=fUEmNrREh-ipxYMiStr5xCakGDBZW8OmAj1rhACs8qaZw@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] perf: Add NVIDIA Tegra410 uncore PMU events and metrics
To: Besar Wicaksono <bwicaksono@nvidia.com>
Cc: acme@kernel.org, namhyung@kernel.org, ctshao@google.com, 
	linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	vsethi@nvidia.com, rwiley@nvidia.com, skelley@nvidia.com, mochs@nvidia.com, 
	rajjoshi@nvidia.com, treding@nvidia.com, jonathanh@nvidia.com, 
	john.garry@linux.dev, will@kernel.org, james.clark@linaro.org, 
	mike.leach@arm.com, leo.yan@linux.dev, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 10:49=E2=80=AFAM Besar Wicaksono <bwicaksono@nvidia=
.com> wrote:
>
> Add event aliases and derived metrics for the NVIDIA Tegra410 uncore
> PMUs, and fix perf's aggregation of PMU instances that are numbered in
> more than one parts in their name.
>
> The series covers the UCF, PCIe, PCIe target, CPU memory latency, and
> chip-to-chip interconnect PMUs. It provides symbolic names for the raw
> event encodings and metrics for bandwidth, frequency, and average read
> latency.
>
> The PCIe and PCIe target PMUs are named nvidia_pcie_pmu_<socket>_rc_<rc>
> and nvidia_pcie_tgt_pmu_<socket>_rc_<rc>. Their json Unit uses the
> existing comma-separated form ("nvidia_pcie_pmu_,rc_"), but perf only
> merged instances that differ in the trailing number, so these events and
> metrics gave one result per socket and were reported incorrectly (e.g.
> with --metric-only), as discussed in v1. Patches 6-9 fix this:
>
> - Patch 6 adds a check of the cpumasks of all merged PMU instances to the
>   zero-count skip in perf stat, so a socket that counts nothing shows 0
>   instead of having its row hidden.
> - Patch 7 merges PMU instances that match the same comma-separated json
>   Unit. This also applies to the HiSilicon hisi_sccl PMUs, which use the
>   same json form; not tested on HiSilicon hardware.
> - Patch 8 labels a merged uncore counter after all of its PMUs, e.g.
>   nvidia_pcie_pmu_*_rc_*/cycles/ or nvidia_ucf_pmu/cycles/, instead of
>   after the first instance, such as nvidia_pcie_pmu_0_rc_0/cycles/.
>   Output with --no-aggr is unchanged.
> - Patch 9 describes these PMU names in the ABI document.
>
> Changes in v2:
> - Move the uncore JSON out of the sys directory and remove the
>   "Compat" fields. Thanks to Ian Rogers for the feedback.
> - Drop "perf jevents: Process model files before sys subdirectories",
>   which this series no longer needs.
> - Add UCF SLC and memory bandwidth metrics from all sources to local
>   CMEM (read, write and read+write) and from local sources to local
>   CMEM and to remote memory, PCIe bandwidth metrics to local
>   destinations, and read+write bandwidth metrics for UCF SLC, UCF
>   memory and PCIe. Thanks to Chun-Tse Shao for the suggestion.
> - Add patches 6-9 to fix the PCIe instance aggregation. Thanks to Ian
>   Rogers and Chun-Tse Shao for the pointers.
>
> v1: https://lore.kernel.org/all/20261019164241.403644-1-bwicaksono@nvidia=
.com/

Why don't we look to fix code in drivers/perf? This series introduces
PMU instances, overloads the meaning of aliases, and a bunch of other
silly complexity due to poor reviews and maintenance of drivers/perf -
specifically by not pointing out the ABI issues. Isn't this a
straightforward, whoops we did a bad suffix and here's the patch to
rename our PMU in the driver? Throwing more complexity at the problem
doesn't feel like the right fix.

Thanks,
Ian

> Besar Wicaksono (9):
>   perf jevents: Add support for NVIDIA Tegra410 UCF PMU aliasing
>   perf jevents: Add support for NVIDIA Tegra410 PCIE PMU aliasing
>   perf jevents: Add support for NVIDIA Tegra410 PCIE-TGT PMU aliasing
>   perf jevents: Add support for NVIDIA Tegra410 CPU Memory Latency PMU
>     aliasing
>   perf jevents: Add support for NVIDIA Tegra410 C2C PMU aliasing
>   perf stat: Check merged PMU instance's cpumasks when skipping zero
>     counts
>   perf pmu: Merge PMU instances that match the same comma-separated json
>     Unit
>   perf evsel: Name a merged uncore counter after all of its PMUs
>   perf Documentation: Describe PMU names numbered in more than one place
>
>  .../testing/sysfs-bus-event_source-devices    |  14 +
>  .../arm64/nvidia/t410/uncore-cpu_mem.json     |  43 +
>  .../arm64/nvidia/t410/uncore-nvclink.json     |  67 ++
>  .../arm64/nvidia/t410/uncore-nvdlink.json     |  43 +
>  .../arm64/nvidia/t410/uncore-nvlink_c2c.json  | 115 +++
>  .../arch/arm64/nvidia/t410/uncore-pcie.json   | 249 ++++++
>  .../arm64/nvidia/t410/uncore-pcie_tgt.json    |  83 ++
>  .../arch/arm64/nvidia/t410/uncore-ucf.json    | 764 ++++++++++++++++++
>  tools/perf/tests/pmu.c                        | 134 +++
>  tools/perf/util/evlist.c                      |   2 +-
>  tools/perf/util/evsel.c                       |  83 +-
>  tools/perf/util/evsel.h                       |   2 +-
>  tools/perf/util/parse-events.c                |   2 +-
>  tools/perf/util/pmu.c                         |  65 ++
>  tools/perf/util/pmu.h                         |   9 +
>  tools/perf/util/pmus.c                        |  47 ++
>  tools/perf/util/pmus.h                        |   1 +
>  tools/perf/util/stat-display.c                |  20 +
>  18 files changed, 1737 insertions(+), 6 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-c=
pu_mem.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-n=
vclink.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-n=
vdlink.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-n=
vlink_c2c.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-p=
cie.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-p=
cie_tgt.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-u=
cf.json
>
> --
> 2.43.0
>
