Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1507553C3A9
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 18:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792176016; cv=pass; b=qGpC2SR2a6lmX4CmDDSxMbyZUxrEwhN3FN/tzl12UvcMgeh6I6A2/wbjmCvB1PybBEOkv0UEtZhScTag8LjO4pyWjiT8pxj2w2bGNl8rU9mvMzO1caWSUWUG8wOakCfoS/Gtt76OLBZc03kvmJVDriV5XIaDuNXIEva3LkNhj1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792176016; c=relaxed/simple;
	bh=xsYeI4hR5bFvuqm0PSlnW0Z65GnHOzwL1uy/B9ZA4Pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nIiTUwE1XSbW45iIrFUUgNK9Hj16SzP0LaZj35S/g3LeBgeFgTvlBj/bLXf1M+aO4hTe65VG/GYzFSTp8ljbs7ZjyCZxMSA6+RCb+dPNnYigR/kH+HNXiKg1PoLdoB69eHsaTvTGm0ZzD8xyAcBSXjyPtGQjDr0d9sU8YRi+KSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rlnQ8CLD; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rlnQ8CLD"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-15354aa70e8so523149c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 11:40:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792176014; cv=none;
        d=google.com; s=arc-20260327;
        b=L8KxChajhR7NbSrc0OTYQDiA2ZiDRjPDs9KrIi+IBYOT0wgn+ClS7YJbDmsRZ8KT8q
         THCbObvIsd5Tse9Zmj3LTG7DqpIZ+Oscfp32+D7K9s2UYmjkYge/EJBr/Jmk2h8LhMd5
         oHL/PRezB4z1GgVDtUG5Hdjpkxqq2h55c7d+seWO5fb5YaDjUBZlj9VsSh1lrjZL5Dze
         6d57R9+yEaq74b22DltHDI+rZUdAf5akEz0o5oOA7lQpyeVrMYrfQyKKMy18q+GUonaj
         QYYzGDqEAZNbhbYxNOMWL4FNk/Non83sp5IxVoe2UASOTcAaDzSyYwBrRE5QeuSfk3of
         HXQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hlEE7DVQkmo1bBGtV9WB4/uzh7DrzDs6MItzTSYiyfE=;
        fh=bqmwE8AgcMpUSudu85GUX2YeY41eAHr7wSAdr29zfS0=;
        b=K50OT3cKWIM/vzsY9Nq79PUyGHFridPlcoRWbqAj4woEFq7ceeYFMKDNC8GNUE+OT/
         aoUbMOVMyVqyyuZmG9qDuWGGNHE+GXVYzk1u0j7iZlzzCITzxDGL3foBgbdFlhq5Gj2p
         YJkMSOCpbK1XdUdEh8ZF9IjFirGsvOwacv2QPR8Rd5MoBCui7FLxWkOl1ZN9Lu6z484y
         +C/g9yp++G7F/xZ1/wh9nYIYSxxZ2jpZqUHQsG+Rm3PO4PNAb8tKkA42nwTDz3G5t4LS
         ly4Bif2xdMa+GnZ9a9qr5OSOI0bkhAKTF/GVamzIkJl9eIt4jJEsPLMGF74M8oTlvCyb
         oqtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792176014; x=1792780814; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hlEE7DVQkmo1bBGtV9WB4/uzh7DrzDs6MItzTSYiyfE=;
        b=rlnQ8CLDsOxSQsuYUSQtbRWdGiiRQkFBSXH2f9P1EbULvPElHmTy8ysp7htfBz/9GE
         /0MBNmb1K9mHJEnygvwStzgVRrB82jpEuhUDv76t1/DufLlNNkPkQN8uUUUbj0jAxG0F
         r7Atg7APhdMNjT3Vzc1CVW5SnLTxUXCpd7KdxfapiCrE17TRVNXeZ8WPg2DFLK5rqyg/
         wToSM8tMrCZd8Y8CxQzJXtn9C7+GrnIbNiTtbzaQ+35IFKzE9ySc9czOdDB5MgY78pCq
         2Q/FitoQnGg6jl7VB0X05C9zIisZyZETrNJGLXpfbY4VEaXZ7SJzkv+2baO56k23fdAP
         LYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792176014; x=1792780814;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hlEE7DVQkmo1bBGtV9WB4/uzh7DrzDs6MItzTSYiyfE=;
        b=j4hWaXJ0FS8+ySDQv1/y2vnPnog71UnF3teQZaJtVhKkhFejHvPv2WyasYX+OsTxE5
         hDkk5aVXHUw7d0mZYh3Yi7hv6a0RXk3nG/mX/FkKZvwwLiSBhTIgyTcnDtfAqtzf5VKy
         lm3F9xKGUfx1nqYY2BUcru/2nyUBL2NKf7T2CDbl8ES+LAREtIH8Y/n9SoZhHBVyltXm
         9fsFV6KFSbx65BiJ74nmPosSGbkcMGc7CR0ipg+jiqc2fUAKvkKF8hKUj+ORh2rB2zsX
         8K7tJSfCvxFKfxAl0u/keDOigw8qT6Gn6Xd8OcspAjA7t6vYy0CuT2UPDLz0Qow8UTUf
         vo8A==
X-Forwarded-Encrypted: i=1; AKwUvByad/ZH4wX3NKr0YCLF2nDKlIvGTqSFaSxr5lnie2hKzVnVKf7IjeRzR9KuJlTOlHzVusNizhpvQlKIhNqxczHU@vger.kernel.org
X-Gm-Message-State: AFq9FYKXnfKdSl7cVmJFwv0bo6XrvRw1vSwPL30jRXcRGQabQoA8vMtO
	swN465z6fxnQhCIBz0UKtD5tlJFi671yoiNI09UJBdp5TRsTxAkLOFFOqPfDpfIrynqVuK8KPRk
	Pp7CL856JiOn9g0O6H5aKOboGIjKWVC+1a0tyEkcA
X-Gm-Gg: AYBFou0D4endE9x6q+i2SqivawZ0MtHDS++jpm0MG8aOWNJ1ta2PuLVAZNZ4m/rq0Rd
	7JvQSzwonQCMXc4qQoI+1kEl1MA2TwvN61H3jkr1pXPCJxippRGsZzzlCFWiDkGS/OnOOHwjtcp
	Maon/hIBFfy9ztpOnWhobhscdUaNeSBgxfUlwrA25CY2+oTuZV+AQ7cdMjPGXEzh7LRqmesptwN
	QGpCOId4leRObe1iqfNag0VoIEP29+JNj58acZ7kNLAFyJ3zSj1gzwIkjY4w0vF93VUZU54v1T0
	k3L4G8k1XJTBAOLLh3qSP6wpPzZ9SzBq7H1tFASK/Xb6gnSDxM5Fr0kpK/8PsiGC7W1JTIc4kzA
	9a/SrqybrFfjSJZQoWdlEtmMqA4abbubU00s=
X-Received: by 2002:a05:7022:f68c:b0:149:49c:22b with SMTP id
 a92af1059eb24-1850c8da7f7mr1196016c88.1.1792176009241; Fri, 16 Oct 2026
 11:40:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928175127.1032535-1-ctshao@google.com> <20260928175127.1032535-3-ctshao@google.com>
 <SA1PR12MB6773C9DE93757D6B73C1E9B3A09E2@SA1PR12MB6773.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB6773C9DE93757D6B73C1E9B3A09E2@SA1PR12MB6773.namprd12.prod.outlook.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Fri, 16 Oct 2026 11:39:32 -0700
X-Gm-Features: AclHuK8Cpf5D1lvwH4p5xYmhynUiIV6Rjo0lLCe4H-T2quohCaweLeh1uTj4GVc
Message-ID: <CAJpZYjWLRiyNbzoGpA-2KE0zHgQn2gc0V943WxJEr5K5aZtRYA@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf jevents: Add NVIDIA Tegra410 uncore PCIe metrics
To: Besar Wicaksono <bwicaksono@nvidia.com>
Cc: "acme@kernel.org" <acme@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>, 
	"irogers@google.com" <irogers@google.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, 
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, "jolsa@kernel.org" <jolsa@kernel.org>, 
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>, "james.clark@linaro.org" <james.clark@linaro.org>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matt Ochs <mochs@nvidia.com>, 
	Sean Kelley <skelley@nvidia.com>, Rich Wiley <rwiley@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, 
	Raj Joshi <rajjoshi@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 2:08=E2=80=AFPM Besar Wicaksono <bwicaksono@nvidia.=
com> wrote:
>
> Hi Chun-Tse,
>
> I tested this on 2-sockets Tegra410 and found some issues.
> 1. With --per-socket or -A, every lpm_pcie_* metric is only reported for
>    socket 0, so socket 1's PCIe traffic never shows up. Example output:
>
> perf stat -a -A -M lpm_pcie_rc1_bw -- sleep 1
>
>  Performance counter stats for 'system wide':
>
> CPU0               15,204      nvidia_pcie_pmu_0_rc_1/wr_bytes/ #      0.=
0 MB/s  lpm_pcie_wr_bw_1
> CPU0                                                                    #=
     33.8 MB/s  lpm_pcie_bw_1
> CPU0           33,910,952      nvidia_pcie_pmu_0_rc_1/rd_bytes/ #     33.=
8 MB/s  lpm_pcie_rd_bw_1
> CPU88                   0      nvidia_pcie_pmu_1_rc_1/wr_bytes/
> CPU88                   0      nvidia_pcie_pmu_1_rc_1/rd_bytes/
> CPU0        1,002,286,615      tool/duration_time/
> CPU0                    0      nvidia_pcie_pmu_0_rc_1/wr_bytes,dst_rem=3D=
0x1/ #      0.0 MB/s  lpm_pcie_rem_wr_bw_1
> CPU88                   0      nvidia_pcie_pmu_1_rc_1/wr_bytes,dst_rem=3D=
0x1/
> CPU0        1,002,275,059      tool/duration_time/
> CPU0                    0      nvidia_pcie_pmu_0_rc_1/rd_bytes,dst_rem=3D=
0x1/ #      0.0 MB/s  lpm_pcie_rem_rd_bw_1
> CPU88                   0      nvidia_pcie_pmu_1_rc_1/rd_bytes,dst_rem=3D=
0x1/
> <snip>
>
> Note CPU88 (socket 1_ has no lpm_pcie_* values.
>
> 2. In the default mode, lpm_pcie_*_<i> adds RC i of socket 0 and RC i of
>    socket 1. These are separate root complexes with different devices,
>    so the "Root Complex i" value can combine traffic from two unrelated
>    links.
>    Could the metrics follow the hardware hierarchy instead, starting at
>    the socket and drilling down to the RC, with the same destination
>    split at each level?
>     - per socket, all RCs (nvidia_pcie_pmu_<s>_rc):
>         lpm_pcie_s<s>_{bw,rd_bw,wr_bw}
>         lpm_pcie_s<s>_{loc,rem}_{rd,wr}_bw
>     - per socket and RC (nvidia_pcie_pmu_<s>_rc_<i>):
>         lpm_pcie_s<s>_{bw,rd_bw,wr_bw}_<i>
>         lpm_pcie_s<s>_{loc,rem}_{rd,wr}_bw_<i>
>       grouped as lpm_pcie_s<s>_rc<i>_bw.

Thanks for testing and for the suggestion. I think both problems come
from how perf expects a PMU to expose its cpumask. Ideally perf wants
a single PMU for both sockets, with one CPU per socket in its cpumask,
e.g.:

```
/sys/bus/event_source/devices/nvidia_pcie_rc_0/cpumask: 0,88
```

We can work around the one-PMU-per-socket layout in the metrics, but
would a single PMU per RC be a viable plan for you to implement?

Thanks,
CT

>
> Thanks,
> Besar
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
> > Subject: [PATCH 2/2] perf jevents: Add NVIDIA Tegra410 uncore PCIe
> > metrics
> >
> > External email: Use caution opening links or attachments
> >
> >
> > Add PCIe bandwidth metrics for the NVIDIA Tegra410 SoC. The formulas
> > follow Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst:
> >
> >   AVG_RD_BANDWIDTH_IN_GBPS =3D RD_BYTES / ELAPSED_TIME_IN_NS
> >   AVG_WR_BANDWIDTH_IN_GBPS =3D WR_BYTES / ELAPSED_TIME_IN_NS
> >
> > There is one PCIE PMU per socket and PCIe Root Complex (RC), named
> > nvidia_pcie_pmu_<socket-id>_rc_<pcie-rc-id>, with RCs 0 to 5 in each
> > socket. The metrics sum the rd_bytes/wr_bytes events of both sockets:
> >
> >   lpm_pcie_bw, lpm_pcie_rd_bw, lpm_pcie_wr_bw: all RCs.
> >   lpm_pcie_bw_<rc>, lpm_pcie_rd_bw_<rc>, lpm_pcie_wr_bw_<rc>: one RC.
> >   lpm_pcie_loc_rd_bw_<rc>, lpm_pcie_loc_wr_bw_<rc>: one RC to local
> >     CMEM, GMEM, PCIe peer and CXL memory.
> >   lpm_pcie_rem_rd_bw_<rc>, lpm_pcie_rem_wr_bw_<rc>: one RC to remote
> >     memory.
> >
> > The per RC metrics are in the lpm_pcie_rc<rc>_bw metric groups.
> >
> > A socket's event counts as 0 if its PMU isn't present (has_event() is
> > 0), e.g. on a single socket system, or if it isn't counted in the
> > aggregation (source_count() is 0), e.g. the other socket's event with
> > --per-socket. Otherwise the metric fails to parse or is nan.
> >
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > Assisted-by: Gemini:gemini-3.1-pro-preview
> > ---
> >  tools/perf/pmu-events/arm64_metrics.py | 68
> > ++++++++++++++++++++++++--
> >  1 file changed, 64 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/arm64_metrics.py b/tools/perf/pmu-
> > events/arm64_metrics.py
> > index b0d0651fec12..1ca3d8ddb4b7 100755
> > --- a/tools/perf/pmu-events/arm64_metrics.py
> > +++ b/tools/perf/pmu-events/arm64_metrics.py
> > @@ -2,9 +2,10 @@
> >  # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> >  import argparse
> >  import os
> > -from typing import Optional
> > -from metric import (aggr_nr, d_ratio, Event, JsonEncodeMetric,
> > -                    JsonEncodeMetricGroupDescriptions, LoadEvents, Met=
ric,
> > MetricGroup)
> > +from typing import List, Optional, Union
> > +from metric import (aggr_nr, d_ratio, has_event, source_count, Event,
> > Expression,
> > +                    JsonEncodeMetric, JsonEncodeMetricGroupDescription=
s,
> > LoadEvents, Metric,
> > +                    MetricGroup, Select)
> >  from common_metrics import Cycles
> >
> >  # Global command line arguments.
> > @@ -67,7 +68,66 @@ def NvidiaT410Uncore() -> Optional[MetricGroup]:
> >                     rd_cum_outs - rd_cum_outs, "1ns"),
> >          ], description=3D"NVIDIA Tegra410 DDR latency")
> >
> > -    return MetricGroup("lpm_uncore", [DdrBw(), DdrLat()],
> > +    def PcieBw() -> MetricGroup:
> > +        # PCIE PMU, one per socket and PCIe Root Complex (RC):
> > +        # AVG_{RD,WR}_BANDWIDTH =3D {RD,WR}_BYTES / ELAPSED_TIME
> > +        loc_dst =3D
> > "dst_loc_cmem=3D0x1,dst_loc_gmem=3D0x1,dst_loc_pcie_p2p=3D0x1,dst_loc_p=
ci
> > e_cxl=3D0x1"
> > +        rem_dst =3D "dst_rem=3D0x1"
> > +
> > +        def SocketSum(rc: str, event: str) -> Expression:
> > +            # Sum the event over both sockets. A PMU counts as 0 if it=
 isn't
> > +            # present (has_event() is 0) or isn't counted in the aggre=
gation,
> > +            # e.g. the other socket with --per-socket (source_count() =
is 0).
> > +            def Count(e: Event) -> Expression:
> > +                return Select(Select(e, source_count(e), 0), has_event=
(e), 0)
> > +
> > +            return (Count(Event(f"nvidia_pcie_pmu_0_{rc}/{event}/")) +
> > +                    Count(Event(f"nvidia_pcie_pmu_1_{rc}/{event}/")))
> > +
> > +        # nvidia_pcie_pmu_<socket-id>_rc matches the PMUs of all RCs i=
n the
> > socket.
> > +        rd =3D SocketSum("rc", "rd_bytes")
> > +        wr =3D SocketSum("rc", "wr_bytes")
> > +        metrics: List[Union[Metric, MetricGroup]] =3D [
> > +            Metric("lpm_pcie_bw", "Total PCIe bandwidth across all Roo=
t
> > Complexes",
> > +                   d_ratio(rd + wr, interval_sec), mb_per_sec),
> > +            Metric("lpm_pcie_rd_bw", "Total PCIe read bandwidth across=
 all
> > Root Complexes",
> > +                   d_ratio(rd, interval_sec), mb_per_sec),
> > +            Metric("lpm_pcie_wr_bw", "Total PCIe write bandwidth acros=
s all
> > Root Complexes",
> > +                   d_ratio(wr, interval_sec), mb_per_sec),
> > +        ]
> > +        for i in range(6):
> > +            rc =3D f"rc_{i}"
> > +            rc_rd =3D SocketSum(rc, "rd_bytes")
> > +            rc_wr =3D SocketSum(rc, "wr_bytes")
> > +            loc_rd =3D SocketSum(rc, f"rd_bytes,{loc_dst}")
> > +            loc_wr =3D SocketSum(rc, f"wr_bytes,{loc_dst}")
> > +            rem_rd =3D SocketSum(rc, f"rd_bytes,{rem_dst}")
> > +            rem_wr =3D SocketSum(rc, f"wr_bytes,{rem_dst}")
> > +            metrics.append(MetricGroup(f"lpm_pcie_rc{i}_bw", [
> > +                Metric(f"lpm_pcie_bw_{i}", f"PCIe total bandwidth on R=
oot
> > Complex {i}",
> > +                       d_ratio(rc_rd + rc_wr, interval_sec), mb_per_se=
c),
> > +                Metric(f"lpm_pcie_rd_bw_{i}", f"PCIe read bandwidth on=
 Root
> > Complex {i}",
> > +                       d_ratio(rc_rd, interval_sec), mb_per_sec),
> > +                Metric(f"lpm_pcie_wr_bw_{i}", f"PCIe write bandwidth o=
n Root
> > Complex {i}",
> > +                       d_ratio(rc_wr, interval_sec), mb_per_sec),
> > +                Metric(f"lpm_pcie_loc_rd_bw_{i}",
> > +                       f"PCIe local read bandwidth on Root Complex {i}=
",
> > +                       d_ratio(loc_rd, interval_sec), mb_per_sec),
> > +                Metric(f"lpm_pcie_loc_wr_bw_{i}",
> > +                       f"PCIe local write bandwidth on Root Complex {i=
}",
> > +                       d_ratio(loc_wr, interval_sec), mb_per_sec),
> > +                Metric(f"lpm_pcie_rem_rd_bw_{i}",
> > +                       f"PCIe remote read bandwidth on Root Complex {i=
}",
> > +                       d_ratio(rem_rd, interval_sec), mb_per_sec),
> > +                Metric(f"lpm_pcie_rem_wr_bw_{i}",
> > +                       f"PCIe remote write bandwidth on Root Complex {=
i}",
> > +                       d_ratio(rem_wr, interval_sec), mb_per_sec),
> > +            ], description=3Df"PCIe bandwidth on Root Complex {i}"))
> > +
> > +        return MetricGroup("lpm_pcie_bw", metrics,
> > +                           description=3D"NVIDIA Tegra410 PCIe Root Co=
mplex
> > bandwidth")
> > +
> > +    return MetricGroup("lpm_uncore", [DdrBw(), DdrLat(), PcieBw()],
> >                         description=3D"NVIDIA Tegra410 uncore metrics")
> >
> >
> > --
> > 2.56.0.rc1.315.gc6ed9934b7-goog
>
