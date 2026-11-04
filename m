Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793809571;
	b=lTvx9h5B0nXUI16DB3pe2oRy+O/S9VMbccm89G4o0jKT85J+o+lUngC5DmV+l8qzuon6
	 DeRVRy9xg97j82wp2XaraHFXB65HCpCoZ0YnPScIP+MK1LIl0qCSb+AADDQBhd66VId6G
	 gsTxM9zucIqHE103SC0+Vj1v5JHY5uPvI8yOXP2NKiyFswY6k1bCACr6J2QD4OZB+juV/
	 v2EUveuweOYxNis78JuX4jKl0ODO+HjRfRMRn89VCx9TUQqQ5tQazd3nMg428kOrTYqAM
	 /rd3ZVBl84s2n/I3NE86PLGW8KiLiZJ6sxBxZj4RuhWGzLajJS5pcC5I6O769IEp0dA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809571;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=02xlunbPJG9twMrNC4lzpNV5WoLplwFKW8EyaQv0RmE=;
	b=I3eUjA0wMYT7VvlmBVnbZsm3VmX6csJ5PAOjwPxP634cbjbcGY8+ITXpegop/p10zQxI
	 QVNUxdzR6qxEN7KQ+j711LlLDnMdmiVAjJK7vonJFztLQ4lUjHj/MvWLDK2nvZAI/jTfV
	 Q43p6ExDPObnTrIZnSxGGx2wt2UmDm3CLMdrLHIfGluTUv18bjTHnN6UcMLnKiA4u8jNC
	 M+jCtCz5zpgAlTt/5rjm0GI4m4WfZSvKl6dtfhzAPz7jHv8G2bTMLsOl+at6EIoH1vBqs
	 fCOaVJoPejiOih8D4GUfgSZ+5BSID78MAoqjvTKpdWqi17gx9U1ElnVrC6me476PsJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PkQndnVj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D77F606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 16:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D77F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PkQndnVj
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5383c97c8cfso321981cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 08:26:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793809569; cv=none;
        d=google.com; s=arc-20260327;
        b=d+pkgYlFp93wd/Ip81i5IEF7l5vLwAFds+bkxQB2SwPLPFSDYiqDaSJXzEPLnmVAKF
         k8pGS5jfHOT9mDc+7XD+0TN672YdeZvjXTNSGUxW9hteRXkm3qG4MJ8qXP2HyovgHCVD
         ms4l/Xbug9MdedJYKbhK6TkOmeJoMNxo83atj1nTRXJ+0ksrCFFD9hYUV599GfflKp+Y
         /W9MzyfGK14go6DkKM8PLkpAuuq2p6iDTavzagn1jtMkPcqm+rfHicDxiiEXNbmncxxU
         ynIvZ+6YbeSG2eJuPwKUQdKiuKWNFNleLzbWMe+sALlSiguyM7s5GGdGjrTKFD8ynaEo
         mZXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=02xlunbPJG9twMrNC4lzpNV5WoLplwFKW8EyaQv0RmE=;
        fh=E/xeD8ahvtvFPw5P5HA4NN22x64v4yno1PpiwEVH4QQ=;
        b=jZxK8e/GiRnmsBcKJRt6hCKAUfGJ9f5rCQBH+8km91pbprovuWGSfqq6Gh5NYiKeSS
         G9j+d4NcefC9e7JaV1CPsN8zkiY8HviCoxSLQ5oBAor6zBWK7SE1BGIiDWv++GeArrux
         UWo2Y+/TAGnCXPjlWKO1pPp7nS9rXcJ9GBBmBhrBUtj8LKzxS8dRmR2A7nY9z9JyJUuU
         iUPzA7C9OxZJRev02oiHrAlnvCr7Lg74nteCS+g0mwJ32IouRlktdvOe7jG3EDGqdNed
         kMLWSd0kqw/AD547i7Sgk9IXhS4PsB5vAZijZsCAWhbtyc3xfgvPzW+RcaGIfuyj8Bho
         wjkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793809569; x=1794414369; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=02xlunbPJG9twMrNC4lzpNV5WoLplwFKW8EyaQv0RmE=;
        b=PkQndnVjODxfjk8gWoorlSWxkVs/Yt5AWI09ReVaivDetcOVoiHlse74NWIkMgMaeb
         FO2aotMPrv6Lzhpa4STmuW3+HlnXlLkdo4v/bfjyhhO7kuZDShCgQwC2McSN7nSDbAnA
         ON0bC5dM29QNnL7HT0hpEhyAa2qFUgX+11YrSQQfiA2PV0W+vrOCmGZ+W3X52hDqBOOW
         /QpB4VOrYkjQC4GFqDPnbDmu7Kr4n3Bz1vzOx9XcoZrrt86Uq+8zP5948IA4yQq0VNIl
         8ehpcuEVERdPPEspxAeYIMQj+53DYvfn9JvKi4J1dhamhRs4yXIXU4g3G9VZWSm3UdiX
         dHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793809569; x=1794414369;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=02xlunbPJG9twMrNC4lzpNV5WoLplwFKW8EyaQv0RmE=;
        b=QrQznafp4YjyLjKPqMju/QZYM/vi2ef9HIKPxjYXXm/SWbcPyZB0jLMgGhQJN/p7eF
         DUhMe617xC0ybO0UCO4x77570KWWVpNmnh2cipWxJOZhFdZqNqmQIn9XCoVn4yLBUkYF
         RPxOBRI7EsZPEjvUZbqc7YJW5CJTYJnKLW6MttfJg20T5hWge/bVWdGmVQLn7O7pzCgK
         f0gfAnMKUenInGVMnatKLjIgy7mRB56/NYqS7ojNjIyvKxvx/zNn4kIun8BZe5T3gt1V
         9O80eOrHfYoroO05vdsq7i4+nuPo61JHeSY4ZlPu9bvHeIgfMycGodN8zR3lIDGGg0gc
         xVMg==
X-Forwarded-Encrypted: i=1; AKwUvBzmvRIQ8rPD+qtT687N+vgNb4Y1vfAr7SQ/2styMlridpLQNc3OBaJxu/Eq8RxmiIGQUcOcg+Zq+axN0t2pJWdx@vger.kernel.org
X-Gm-Message-State: APuU4Z95Ey6AK/nhNCHFIIpbZlZA2iCgEYzJM2rq2MrciXUlNvp1nBnw
	P69JGrN4m2T/rJbmbcJEWPQ0E/a+enL+Kxxb27DlXftvyPNQAp9l7VzW7IiF2mhgvJcWMZEwk4+
	Wt52VQyIPBgxcXrghZMccMRn+nxFQp2f3vWelHl5v
X-Gm-Gg: AYBFou1Y56JFMKxMIX2FyXB902QaUMK/2THV07n1eeel7JhJhQrBgsuB4KmUqc2tQpr
	s0rqYyGbXflcG2ei9ocH92krnb69uB8VQeIIc8u9R6hWs6gL0jTRSBVrLkTaRwaX9CQ19OgabQg
	pPts0YbBQENChOWmo/YuFupeBlvaNbr/eWFwO/eNDbyhTGxlHucVjUeAb8t6KX6vznPGHWz+JJc
	t1DFQnRMmSbf2fE/aXSCQchejSCJtvUr7PeLkASXtqXtJn9O/VSZA245+8dsjlX9TTRz4kfww2C
	L82EDrf+sCZHRygTWFbdZRdzclcwSkQqFOjZ+nnLcaIZVHesrGqknZMxQWUDPn9r1+Gz2pvAzVb
	ZjD7DOhcFVrqHFpr5W9+jUsdPcnENB/5dEMjxU+2oPseuiGkGNPxq/tP1zRCFnOfZ21bOr88CyZ
	o30ol2XxKaEw4=
X-Received: by 2002:a05:622a:4894:b0:535:9aa3:5ebb with SMTP id
 d75a77b69052e-54b4cd278d4mr21858561cf.8.1793809568468; Wed, 04 Nov 2026
 08:26:08 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104160716.2910873-1-bwicaksono@nvidia.com>
In-Reply-To: <20261104160716.2910873-1-bwicaksono@nvidia.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 4 Nov 2026 08:25:57 -0800
X-Gm-Features: AclHuK-GeTinNBFNoWnfPGGAtOY6Xq1W9g3atyK1ujiBfiA8CNbeKnUu-zkauLA
Message-ID: <CAP-5=fXriq3akwKxsxSuBZ0M=1OMuCe8ig_j-r6ehfCeCVAYcQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] perf: Add NVIDIA Tegra410 uncore PMU events and metrics
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

On Wed, Nov 4, 2026 at 8:08=E2=80=AFAM Besar Wicaksono <bwicaksono@nvidia.c=
om> wrote:
>
> Add event aliases and derived metrics for the NVIDIA Tegra410 uncore
> PMUs, and fix perf's aggregation of the Tegra410 PCIe PMU instances.
>
> The series covers the UCF, PCIe, PCIe target, CPU memory latency, and
> chip-to-chip interconnect PMUs. It provides symbolic names for the raw
> event encodings and metrics for bandwidth, frequency, and average read
> latency.
>
> The PCIe and PCIe target PMUs are named nvidia_pcie_pmu_<socket>_rc_<rc>
> and nvidia_pcie_tgt_pmu_<socket>_rc_<rc>. perf only strips the number at
> the end of a PMU name, so the instances of each socket were treated as a
> different PMU, and these events and metrics gave one result per socket
> and were reported incorrectly (e.g. with --metric-only), as discussed in
> v1 and v2. Patches 6 and 7 fix this:
>
> - Patch 6 adds a check of the cpumasks of all merged PMU instances to the
>   zero-count skip in perf stat, so a socket that counts nothing shows 0
>   instead of having its row hidden.
> - Patch 7 treats both numbers of the NVIDIA PCIe PMU names as the
>   suffix, so the instances on all sockets are merged as nvidia_pcie_pmu
>   or nvidia_pcie_tgt_pmu. Per-RC results are still available with
>   --no-aggr or -A.
>
> Changes in v3:
> - Replace v2 patches 7-9 (merging PMU instances that match the same
>   comma-separated json Unit, naming a merged counter after all of its
>   PMUs, and the ABI document) with a special case for the NVIDIA PCIe
>   PMU names in pmu_name_len_no_suffix(), perf_pmu__match_wildcard() and
>   pmu_name_cmp(). Thanks to Ian Rogers for the suggestion.
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
> v2: https://lore.kernel.org/all/20261030174816.1544471-1-bwicaksono@nvidi=
a.com/
> v1: https://lore.kernel.org/all/20261019164241.403644-1-bwicaksono@nvidia=
.com/
>
> Besar Wicaksono (7):
>   perf jevents: Add support for NVIDIA Tegra410 UCF PMU aliasing
>   perf jevents: Add support for NVIDIA Tegra410 PCIE PMU aliasing
>   perf jevents: Add support for NVIDIA Tegra410 PCIE-TGT PMU aliasing
>   perf jevents: Add support for NVIDIA Tegra410 CPU Memory Latency PMU
>     aliasing
>   perf jevents: Add support for NVIDIA Tegra410 C2C PMU aliasing
>   perf stat: Check merged PMU instance's cpumasks when skipping zero
>     counts
>   perf pmus: Treat both numbers of NVIDIA PCIe PMU names as suffix

Other than the nit the that commit messages adding events refer to it
as "PMU aliasing":

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  .../arm64/nvidia/t410/uncore-cpu_mem.json     |  43 +
>  .../arm64/nvidia/t410/uncore-nvclink.json     |  67 ++
>  .../arm64/nvidia/t410/uncore-nvdlink.json     |  43 +
>  .../arm64/nvidia/t410/uncore-nvlink_c2c.json  | 115 +++
>  .../arch/arm64/nvidia/t410/uncore-pcie.json   | 249 ++++++
>  .../arm64/nvidia/t410/uncore-pcie_tgt.json    |  83 ++
>  .../arch/arm64/nvidia/t410/uncore-ucf.json    | 764 ++++++++++++++++++
>  tools/perf/util/pmu.c                         |   9 +
>  tools/perf/util/pmus.c                        |  23 +
>  tools/perf/util/stat-display.c                |  20 +
>  10 files changed, 1416 insertions(+)
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
