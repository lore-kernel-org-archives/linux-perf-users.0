Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4712E3E763E
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 21:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791927020; cv=pass; b=SgYumnJCh7nxgwgNNYLcn5uSGCptWNNj6h6NXoDqQYIaczgx/zBWMK5SIU3ewMRQZEb3b3cjFyM6bZfK42n5O/w+HKRx23PoJL1ZW0FivDub+ukmNH8NL0lqStiR9JDgVtNUsANmjr4k68EYg7yeQ4hD6M3ASBYeYnHeGEO0aa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791927020; c=relaxed/simple;
	bh=OsXx4CTLUw54Zdm/PxkaDu/b9Zwkwqy+azWlL7ipEhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eN4qIlDj8XnGY3L/YfhXQQxiOCGwv2Xsh2r2mFk3wR59YH6jaX8XnXwo9h4VJ74zUWMZURQa86iZPBh9XUhFtLNSUUtkZBE+ofNvZ1y5Ux+rFwC+1tK/EKymisoWpCN5iz3QutrzCXXcIXxwag0mfdPKOGqxDB8EO83uFfumhKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F/xyIlCU; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F/xyIlCU"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5337c7b9937so940521cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 14:30:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791927016; cv=none;
        d=google.com; s=arc-20260327;
        b=W64tPiVFKt32nmph6F0O9CzP6RJDmLg90UkcXDrMNkQXv/HijTsThi5UGHUz+36evL
         ZKKmFzpgZKa4XKMtVoqtVDRETsNqVhcDuRzEB7moG1KTTf31gpop0n1VZMGacSJDNbM4
         cpNDLiIfikYb05SZg4nGMQRHMYky9JwRtkodByYSQorXb61XNORHPAtCXo5l4rB7UYcn
         OMWyXIKbpHUVkD7XSI6s/8WiiLKQ5Xq5uPLCcqOCGTnq/WR669FbUItcG2AM5K6xfa7k
         j1739Ei2T2f/QnCDVJf/NavGUBj+uXrth/OjJrCLFhIPiyh2IX+UWGDuC3m4LZQEAlHf
         X9xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JTFf6PciE2mPkxag6h7p3MDvMmr+qpAwgax67MZOwNM=;
        fh=Ea6tgSe2cmFRc2GRfk7N1ZiqfEoKF6DA3IsKLQn1290=;
        b=FlRWRcHXmrLhAobxesgLzbu2ywRhxVnfMSE5F/S2dVPKPvVbsIm4rf4d9CZdxcMWAs
         S7bjbX6DTc/AhOnCy+KYvehsZftg15cwDcRs+1xA3oD6bYiI26+0pc10IfhPQVMCVtzm
         21c/M5T/l2Af/8y/CA1Me3HA2yxSWvtimiOnIjd5+cleg9V3UhftC9m3jlOnGb28sGwd
         vZVGHmh0YTGDTHPHOT0R1pfxiKHXpC4fBUfa+RWBplmF1dFc7A/PIguPbKQwhNvZxmCl
         zSW/Z/1UD0VyFbM3sHL0J38A7AH0qBFu6MroxC+XsmLCK4Bes/TbMmMMsP55AQgQ4rg+
         X6lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791927016; x=1792531816; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JTFf6PciE2mPkxag6h7p3MDvMmr+qpAwgax67MZOwNM=;
        b=F/xyIlCUBbpPO99gIIcY34I1Hcrl/O70O7Q5aKrriyT8T1bO26X82r5AGDz7tv0yv8
         ltVEjy3UHgfys7dfmIQe9+0WWgnzRy91WGdP88nYDn7BfLjyWmTMW3qZg2pFzq826bgW
         iuZBZrbExMafM3N7B+SnyxiQzSK5ktOwpjUOs7i3t99Kgm0MORBfOnWPMJQtJka89sBq
         LBBoNMMLibJCvXdDhs/IlsjLjfpdkvRNp/tuJLREAjuls/4dyUfjOpq/UVXJobVG4G71
         gpbLV/s1PrOsm3kdUAnm5pMupTGum/FWAH7RFVZYLe5k9H2RrCgTGHEFrKIkuVJQfceV
         J/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791927016; x=1792531816;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JTFf6PciE2mPkxag6h7p3MDvMmr+qpAwgax67MZOwNM=;
        b=L/bpmvkS5n8qjTAOnFZj9MgaN2WZ2c8AvddrduzLdFBk4H7L5aki1YcuAQuXYs6W7u
         br7MQ+rwVqDMatrr0nUO1npYfPLh4zSctIfdJl6V8HGaGJi2k6IUAWVGfA9bEmPQ0/Sz
         eZM5sOX5eAwbusNQeDDJczskCja/NKkxJV8BqExb97iTlm1177j+7Rl0FEu20zmjdXpi
         7yZihTwAOGzvCfEhM+wDu72oiozpD9ySCSomBKQ6Xt1CM68fZ6E8tTiG2xMY8q7UtEPu
         u+tYuAZ+Mq/y30UCVvlGydboJiMQudxII8X4Or+o8WS5/y6/z4XwSivttoN9OI26yxFy
         BzQQ==
X-Forwarded-Encrypted: i=1; AKwUvBxcf39RwgyjXePDAISg9sxd2SqNS5vJTkEqNHzD3nYMRGupCLafMBGBQNBhYDehoAqUpz5GqMQ+s7j7UHScGUwg@vger.kernel.org
X-Gm-Message-State: AFq9FYLyvImOzLnxTTPb2dZ2NvRe0JnfFCPx12DLEFp8KLVXF7WBdroL
	gcH2guHWTe6JLjP6uS7czdS6ffcOOG5XYWTw293S3MVdqW5Ogf6R/J7pdYK1zJtIh8k9elZq2DA
	Q9CRiXPqOByJFCZGmlkyk9VQYXrrBK6oWdldMLa3K
X-Gm-Gg: AYBFou3Gzi4IqgcXYLhE2OfZTo1Lqf0m/s6N68KA2xByY1PWJzYnfki3g4rXAVmKqPE
	AYU17N9UIZ/VAQ7sNFIvNUhcN5o3C3JoBD4Pp3XU7xiy7CiEZk+jsXQKr7U6kWotgy8alIR7++Z
	zUXsALneo0v/G8eTtm3PEmNMUhPNtNUp60BhmJOYZ1Q2Ux81wCXMuHvYl7GYtikzunqIK6+Meho
	rrIwpRqftCbol+sQET9UnwjrWs5wjlSJVt6aAtCBaJbyojC2iF6xcejhgq6RRufuW0/wJHKrQF0
	m4d/eV4yvzxMQJBQrbvlP1GfQXq9KAocJIHcVfS74AyPlEX/ftP27QMyJN2Ps4rs4OQxR6/ypQZ
	jxBtR3pEcAQ==
X-Received: by 2002:a05:622a:2519:b0:52f:9ed4:8d76 with SMTP id
 d75a77b69052e-535b4fad502mr62778971cf.14.1791927014950; Tue, 13 Oct 2026
 14:30:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928175127.1032535-1-ctshao@google.com> <20260928175127.1032535-2-ctshao@google.com>
 <SA1PR12MB6773D69355E45BEBF00C33BDA09E2@SA1PR12MB6773.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB6773D69355E45BEBF00C33BDA09E2@SA1PR12MB6773.namprd12.prod.outlook.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 13 Oct 2026 14:30:02 -0700
X-Gm-Features: AclHuK9fLdQ9-yHHtAdzGmjGJw7JE4xDUTKfruq2dp9IU-mk6w7aupgXUeH3bd8
Message-ID: <CAP-5=fX3=fMzq91n8X6Hf+K5D_AqStzK=4kLAC9Hh4gSJo1YCw@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf jevents: Add NVIDIA Tegra410 uncore DDR metrics
To: Besar Wicaksono <bwicaksono@nvidia.com>
Cc: Chun-Tse Shao <ctshao@google.com>, "acme@kernel.org" <acme@kernel.org>, 
	"namhyung@kernel.org" <namhyung@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, 
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, "jolsa@kernel.org" <jolsa@kernel.org>, 
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>, "james.clark@linaro.org" <james.clark@linaro.org>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matt Ochs <mochs@nvidia.com>, 
	Sean Kelley <skelley@nvidia.com>, Rich Wiley <rwiley@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, 
	Raj Joshi <rajjoshi@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 2:07=E2=80=AFPM Besar Wicaksono <bwicaksono@nvidia.=
com> wrote:
>
> Hi Chun-Tse,
>
> I tested this patch on 2-socket Tegra410. Both DDR bandwidth and
> read latency metrics give correct values in the default, --per-socket,
> and -A modes.
>
> Some small comments inline below.
>
> > -----Original Message-----
> > From: Chun-Tse Shao <ctshao@google.com>
> > Sent: Monday, September 28, 2026 5:51 PM
> > To: acme@kernel.org; namhyung@kernel.org; irogers@google.com
> > Cc: peterz@infradead.org; mingo@redhat.com; mark.rutland@arm.com;
> > alexander.shishkin@linux.intel.com; jolsa@kernel.org;
> > adrian.hunter@intel.com; james.clark@linaro.org; Besar Wicaksono
> > <bwicaksono@nvidia.com>; linux-perf-users@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Chun-Tse Shao <ctshao@google.com>
> > Subject: [PATCH 1/2] perf jevents: Add NVIDIA Tegra410 uncore DDR
> > metrics
> >
> > External email: Use caution opening links or attachments
> >
> >
> > Add DDR bandwidth and latency metrics for the NVIDIA Tegra410 SoC. The
> > formulas follow Documentation/admin-guide/perf/nvidia-tegra410-
> > pmu.rst:
> >
> >   AVG_MEM_READ_BANDWIDTH_IN_GBPS =3D MEM_BYTES_RD /
> > ELAPSED_TIME_IN_NS
> >   AVG_MEM_WRITE_BANDWIDTH_IN_GBPS =3D MEM_BYTES_WR /
> > ELAPSED_TIME_IN_NS
> >
> >   FREQ_IN_GHZ =3D CYCLES / ELAPSED_TIME_IN_NS
> >   AVG_LATENCY_IN_CYCLES =3D RD_CUM_OUTS / RD_REQ
> >   AVERAGE_LATENCY_IN_NS =3D AVG_LATENCY_IN_CYCLES / FREQ_IN_GHZ
> >
> > The bandwidth metrics use the mem_bytes_rd/mem_bytes_wr events of
> > the
> > Unified Coherence Fabric (UCF) PMU with source/destination filters:
> >
> >   lpm_ddr_bw, lpm_ddr_rd_bw, lpm_ddr_wr_bw: all sources to local CMEM.
> >   lpm_ddr_loc_rd_bw, lpm_ddr_loc_wr_bw: local CPU and non-CPU sources
> > to
> >     local CMEM.
> >   lpm_ddr_rem_rd_bw, lpm_ddr_rem_wr_bw: local CPU and non-CPU
> > sources to
> >     remote memory.
> >
> > The latency metrics use the CPU Memory (CMEM) latency PMU:
> >
> >   lpm_ddr_lat, lpm_ddr_rd_lat: average DDR read latency in ns.
> >   lpm_ddr_wr_lat: the PMU only measures reads, so this is always 0.
> >
>
> A question on naming: what does the "lpm_" prefix stand for? Is it the
> convention for all metrics generated by the Python scripts (I see it on
> the Intel/AMD and common metrics too)?

Hi Besar, naming is one of the hardest problems in Computer Science
:-) When we first added the metrics there was a request to
differentiate between metrics coming from the python scripts and
metrics coming from vendor code, like Intel top-down. We agreed on
having a prefix, and lpm_ was suggested as meaning Linux perf metric.
All of those words seem redundant given the metric is being measured
on Linux using perf, but it was adopted as the best suggestion. If you
have a better proposal, I think we can change it.

Thanks,
Ian

> > There is one CMEM latency PMU per socket and perf sums the counts of th=
e
> > PMUs in an aggregation, e.g. of both sockets in the default aggregation
> > mode. Use aggr_nr() to divide the summed cycles by the number of PMUs,
> > otherwise the frequency is too high and the latency too low by that
> > factor.
> >
> > The events are sysfs events of the nvidia_ucf_pmu_<socket-id> and
> > nvidia_cmem_latency_pmu_<socket-id> PMUs rather than json events, so
> > add
> > the "nvidia" PMU prefix to the prefixes that skip the named json event
> > check in metric.py.
> >
> > pmu-events/Build only runs arm64_metrics.py for the "arm" vendor
> > models,
> > so also run it for the "nvidia" vendor models to generate the Tegra410
> > metrics.
> >
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > Assisted-by: Gemini:gemini-3.1-pro-preview
> > ---
> >  tools/perf/pmu-events/Build            |  2 +-
> >  tools/perf/pmu-events/arm64_metrics.py | 66
> > +++++++++++++++++++++++++-
> >  tools/perf/pmu-events/metric.py        |  2 +-
> >  3 files changed, 66 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> > index 1ac067be9d34..8dc8cfcb8b04 100644
> > --- a/tools/perf/pmu-events/Build
> > +++ b/tools/perf/pmu-events/Build
> > @@ -78,7 +78,7 @@ endif
> >
> >  ifeq ($(JEVENTS_ARCH),$(filter $(JEVENTS_ARCH),arm64 all))
> >  # Generate ARM Json
> > -ARMS :=3D $(shell ls -d pmu-events/arch/arm64/arm/*|grep -v cmn)
> > +ARMS :=3D $(shell ls -d pmu-events/arch/arm64/arm/* pmu-
> > events/arch/arm64/nvidia/*|grep -v cmn)
> >  ARM_METRICS =3D $(foreach x,$(ARMS),$(OUTPUT)$(x)/extra-metrics.json)
> >  ARM_METRICGROUPS =3D $(foreach x,$(ARMS),$(OUTPUT)$(x)/extra-
> > metricgroups.json)
> >  GEN_JSON +=3D $(ARM_METRICS) $(ARM_METRICGROUPS)
> > diff --git a/tools/perf/pmu-events/arm64_metrics.py b/tools/perf/pmu-
> > events/arm64_metrics.py
> > index 4ecda96d11fa..b0d0651fec12 100755
> > --- a/tools/perf/pmu-events/arm64_metrics.py
> > +++ b/tools/perf/pmu-events/arm64_metrics.py
> > @@ -2,14 +2,75 @@
> >  # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> >  import argparse
> >  import os
> > -from metric import (JsonEncodeMetric,
> > JsonEncodeMetricGroupDescriptions, LoadEvents,
> > -                    MetricGroup)
> > +from typing import Optional
> > +from metric import (aggr_nr, d_ratio, Event, JsonEncodeMetric,
> > +                    JsonEncodeMetricGroupDescriptions, LoadEvents, Met=
ric,
> > MetricGroup)
> >  from common_metrics import Cycles
> >
> >  # Global command line arguments.
> >  _args =3D None
> >
> >
> > +def NvidiaT410Uncore() -> Optional[MetricGroup]:
> > +    """Uncore metrics for the NVIDIA Tegra410 SoC.
> > +
> > +    The formulas follow Documentation/admin-guide/perf/nvidia-tegra410=
-
> > pmu.rst.
> > +    """
> > +    assert _args is not None
> > +    if _args.vendor !=3D "nvidia" or _args.model !=3D "t410":
> > +        return None
> > +
> > +    interval_sec =3D Event("duration_time")
> > +    mb_per_sec =3D f"{1/1e6}MB/s"
> > +
> > +    def DdrBw() -> MetricGroup:
> > +        # Unified Coherence Fabric (UCF) PMU:
> > +        # AVG_MEM_{READ,WRITE}_BANDWIDTH =3D MEM_BYTES_{RD,WR} /
> > ELAPSED_TIME
> > +        loc_src =3D "src_loc_cpu=3D0x1,src_loc_noncpu=3D0x1"
> > +        rd =3D Event("nvidia_ucf_pmu/mem_bytes_rd,dst_loc_cmem=3D0x1/"=
)
> > +        wr =3D Event("nvidia_ucf_pmu/mem_bytes_wr,dst_loc_cmem=3D0x1/"=
)
> > +        loc_rd =3D
> > Event(f"nvidia_ucf_pmu/mem_bytes_rd,{loc_src},dst_loc_cmem=3D0x1/")
> > +        loc_wr =3D
> > Event(f"nvidia_ucf_pmu/mem_bytes_wr,{loc_src},dst_loc_cmem=3D0x1/")
> > +        rem_rd =3D
> > Event(f"nvidia_ucf_pmu/mem_bytes_rd,{loc_src},dst_rem=3D0x1/")
> > +        rem_wr =3D
> > Event(f"nvidia_ucf_pmu/mem_bytes_wr,{loc_src},dst_rem=3D0x1/")
> > +        return MetricGroup("lpm_ddr_bw", [
> > +            Metric("lpm_ddr_bw", "Total DDR bandwidth",
> > +                   d_ratio(rd + wr, interval_sec), mb_per_sec),
> > +            Metric("lpm_ddr_rd_bw", "DDR read bandwidth",
> > +                   d_ratio(rd, interval_sec), mb_per_sec),
> > +            Metric("lpm_ddr_wr_bw", "DDR write bandwidth",
> > +                   d_ratio(wr, interval_sec), mb_per_sec),
> > +            Metric("lpm_ddr_loc_rd_bw", "Local DDR read bandwidth",
> > +                   d_ratio(loc_rd, interval_sec), mb_per_sec),
> > +            Metric("lpm_ddr_loc_wr_bw", "Local DDR write bandwidth",
> > +                   d_ratio(loc_wr, interval_sec), mb_per_sec),
> > +            Metric("lpm_ddr_rem_rd_bw", "Remote DDR read bandwidth",
> > +                   d_ratio(rem_rd, interval_sec), mb_per_sec),
> > +            Metric("lpm_ddr_rem_wr_bw", "Remote DDR write bandwidth",
> > +                   d_ratio(rem_wr, interval_sec), mb_per_sec),
> > +        ], description=3D"NVIDIA Tegra410 DDR bandwidth")
> > +
> > +    def DdrLat() -> MetricGroup:
> > +        # CPU Memory (CMEM) latency PMU, one per socket:
> > +        # AVERAGE_LATENCY_IN_NS =3D (RD_CUM_OUTS / RD_REQ) / (CYCLES /
> > ELAPSED_TIME_IN_NS)
> > +        rd_cum_outs =3D Event("nvidia_cmem_latency_pmu/rd_cum_outs/")
> > +        rd_req =3D Event("nvidia_cmem_latency_pmu/rd_req/")
> > +        cycles =3D Event("nvidia_cmem_latency_pmu/cycles/")
> > +        # perf sums the counts of the PMUs in an aggregation, e.g. bot=
h
> > sockets
> > +        # by default, so divide cycles by their number to get the freq=
uency.
> > +        rd_lat =3D d_ratio(1e9 * interval_sec * rd_cum_outs * aggr_nr(=
cycles),
> > rd_req * cycles)
> > +        return MetricGroup("lpm_ddr_lat", [
> > +            Metric("lpm_ddr_lat", "Average DDR read latency in ns", rd=
_lat,
> > "1ns"),
> > +            Metric("lpm_ddr_rd_lat", "DDR read latency in ns", rd_lat,=
 "1ns"),
>
> Could we keep just lpm_ddr_rd_lat ?
>
> > +            # The CMEM latency PMU only measures reads, write latency =
is
> > always 0.
> > +            Metric("lpm_ddr_wr_lat", "DDR write latency in ns",
> > +                   rd_cum_outs - rd_cum_outs, "1ns"),
> > +        ], description=3D"NVIDIA Tegra410 DDR latency")
>
> This always prints 0.0 ns, which reads like a real measurement of
> zero-latency writes. Since the hardware can't measure write latency, I'd
> drop this metric rather than report a placeholder.
>
> Tested-by: Besar Wicaksono <bwicaksono@nvidia.com>
>
> Thanks,
> Besar
>
> > +
> > +    return MetricGroup("lpm_uncore", [DdrBw(), DdrLat()],
> > +                       description=3D"NVIDIA Tegra410 uncore metrics")
> > +
> > +
> >  def main() -> None:
> >      global _args
> >
> > @@ -37,6 +98,7 @@ def main() -> None:
> >
> >      all_metrics =3D MetricGroup("", [
> >          Cycles(),
> > +        NvidiaT410Uncore(),
> >      ])
> >
> >      if _args.metricgroups:
> > diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-
> > events/metric.py
> > index f5d81eccd5c3..6fb69024d1fd 100644
> > --- a/tools/perf/pmu-events/metric.py
> > +++ b/tools/perf/pmu-events/metric.py
> > @@ -91,7 +91,7 @@ def CheckEveryEvent(*names: str) -> None:
> >        name =3D name[:name.find(':')]
> >      elif '/' in name:
> >        name =3D name[:name.find('/')]
> > -      if any([name.startswith(x) for x in ['amd', 'arm', 'cpu', 'msr',=
 'power',
> > 'cha', 'uncore']]):
> > +      if any([name.startswith(x) for x in ['amd', 'arm', 'cpu', 'msr',=
 'power',
> > 'cha', 'uncore', 'nvidia']]):
> >          continue
> >      if name not in all_events_all_models:
> >        raise ValueError(f"Is {name} a named json event?")
> > --
> > 2.56.0.rc1.315.gc6ed9934b7-goog
>
