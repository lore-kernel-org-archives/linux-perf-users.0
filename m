Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792433684;
	b=kHZcah0b3/Pl3qSlsjYCYFyKjEbvXrBiJJ12g8PSRHKpFE0becl0AnPyAmFRTXtqfrPw
	 6+RstFCNP1SES89r9H5q8hiNUyDhKFl7gunXVgR1kza/+FHyVzKrOnKQT0rfZVkqReB1G
	 pG3O/00FSSs2khuV560jKpiywVyb2M6ZK9XNu4J93wAJG9wcwtxeART7+4FteNpg/G9F8
	 pnMXULqzXRYNFE5LP2m8p+ci0KJZL4hn229HaIiMq40KME00IUIfsL8eVxMRilmEAY/92
	 msbViD+/U58V/nEmrIUv+o9uszRtRZvC0R2splpGfPDVkdD4RgxCDdp0mEECvdm2zuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792433684;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=bfo0P/W9cYL2uIbzlHb1ry83aFWIiBEqOVjBGcfiNA0=;
	b=A/9cM9jo2Y5pE56+GrwPPHAzYhK2Br7rbYH0eu/JGo+6UDVivmGJ6NGlN2I+PS++ckD8
	 wuRIC6vBuVr3609E8rE6Pb0xpIs0+k/HUGIMnxlcPCidIJYqYrz0BqDkNmXqazk+FqG4L
	 DvFzg+RVYnMjuKJZFgZ5eHQwtTKXdc7I21U1ASC5GBJhe6T/km4aiFBIApci+SyhLNRPY
	 AGLWzXM0VHc2TOQD/+J6Yvs8MwqGbUWUoKbKl65gGvwLazGE32ul5sjox3gKQhzy4wZe9
	 oaUzTdfbecCsmDgDB8rgUn3fCEZbxPi4wUuYzZyVpIIzNvIvXpnDMC5rDGjR6i/Z9gg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=uPwgsV7g;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057FB606A31A
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 18:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 057FB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=uPwgsV7g
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-170135e43c7so808336c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 11:14:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792433683; cv=none;
        d=google.com; s=arc-20260327;
        b=WGa292TPijH/3hRR4D39KN9qrctT3OLVDiuc5c/934ayzVYyjdTHmp+CufNugLUn+a
         ge9AY0d/AQ+gadVykOGSP7Kz6UGBNG3dH8JixZA53L9DFSU6oNv6fhsiXUYPN+wn9y1K
         o4laJH2/KSRLQirLNElgM9Es1WMNgJdfWE9U/7nVkfyfayl87wiBk4WRnxICVKjNJlOo
         5eoxnvl4L5z9cwYcM60sb+/Jknxbn6U+ZG67PAJt7cBGSephV+rMQG65kU77MO8Cpn/r
         mzCKQLnrkkFYFXLev6RDyVaKkColz9Tpy39Kv+A9Dvu8Q/k51mRl9/xt5wqjkCZXetys
         F8wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bfo0P/W9cYL2uIbzlHb1ry83aFWIiBEqOVjBGcfiNA0=;
        fh=kCHw3Ar1lfGToAuinD0hLjUK1ybj9p+Po/MiYa966G4=;
        b=KQJkigHOQJzbaOG9PSfXI7Rbqc/H9jpRF2h2kvk/bQX0Chgc4/AKWcjNJicH7gZASS
         g1jvaoYjjwoFyjTzvfvX/WYpJz96a3yPBimV7vmCANzh7hBRMHsrznl2yZgfnsWLlbFM
         VnQGx1iE2UsJk7+L1/I3eHFd2+k/gjPDCobNapPfmYI9OrzicgdyQTzbRjDalCX6jkSQ
         0pgZgfFOAAIdDZYz57+Yw7sMQ4DgRuJYKaA5lkvEe7scOBXHqd9biWKfo9kMtBotir5D
         nrOuCyuild3TT6MXthhn/IS73XU4lBQOkD8lmD9gVDS1402xY8vzBmV3tTDHdqV8WDP+
         YazA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792433683; x=1793038483; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bfo0P/W9cYL2uIbzlHb1ry83aFWIiBEqOVjBGcfiNA0=;
        b=uPwgsV7gipy6T25KYHk7O+TineWbgnMU6urOIWSWNGnbPVpV53klA5sGuwIJry6sEU
         W25fJvoUTL7p2GRNETsf69lNQI8Gvy5IsOomPjJ0RK3HRsd0dOCsf/aBhVAXsAG5WO6U
         xQ0S4ZA3C2YfhMyheoaBdUpNXP6OnyzALBKfDZpTKLrIFyB413HOnWaZb6Btywra40d+
         y83wOjGy/a0TVTW103a+O2jByuhs3FQERUaATevorlBAIs7sC6YdRuTilkf8+stbAwzj
         giMst43gWcDpfuBGzXWohX7VM2aLH+mRIYVhlHRmw3eimDEDR+t7my+QZ4NzzJc1Ud+F
         5AfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792433683; x=1793038483;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bfo0P/W9cYL2uIbzlHb1ry83aFWIiBEqOVjBGcfiNA0=;
        b=MiimaGIpFW9EGmJT4Z8DmTqD/PJ/1Kkn373GQCwVtiiIKG7dWT2npP+DM8qYRWuwNd
         hC76O8dVzqyWli2YkoMQR2DjGDcRAuAoImCZ0Tn1efkK6GRISxG0R4Wsx3pu/zi1MNoB
         Md5j3jaYJngrqqOwpzqrohJtllUZX4UBB4Kx7FFskaAGYDKGKTl840DFgNsy9pUrp7bu
         Hy2vItU8pmMHv1Ur/VikIW0lDTnEi1+iVvKVNGtxvRVMKR4Yk1OS5GTpvXTk9t1IP0Dt
         ze2tC26jFIxnhXh/wX4XjHY/IkK9jvL2siVJgT+xnVD3Kj8ZU9arMEq/yLxnf9Chhb/H
         iDvA==
X-Forwarded-Encrypted: i=1; AKwUvBxRjGnNITADgoNkZ+b4JSfnzQ3T/dUw/TyhVXjfh+Fehz1RGqYMHqCpHLKO7WHYLXtLrn7V1AcmoQlozv4GJ40/@vger.kernel.org
X-Gm-Message-State: AFq9FYLyi1aBACmoRL2/WtBKGyGk37wz2lSGBUOYmNSP2Rb1npn8Wddq
	wbHHuVjySHkhoB4XlrPQFq6u6064N0qErd6poSFG34biNXJvj80HQZ3T/ChkX0lh71biCPdHd5M
	BsJKUaEK3NwlWwPglM0Cv+FnZXD/2C8oJGccqQLtg5n4yYaIVSGQnTI/771GsYQ==
X-Gm-Gg: AYBFou2/Gl/Lh6QIQAbuINnUJ6G0+8Ubiw39JDJU9F48678aISFMbCTk6dYiW07XH7s
	6enx1gqBNAmLc1yZ91WQMCwaX6NWRcJajwwDIVZEsigxI/U1fQ919hFttrDE+C92aX8xgDIWQRM
	PbTaDJi1pCpGTgsKWzS8B6VP3M4fDrgv33MVvyv6iNmEJqf5tx9CgOgMqVtPK6u2Wy8aZDpCML/
	+Kps7SSUf6UpbCIauBEYvTvIuoy3wXYTbpuMhhW8BQKouKopa7pLeJdR2TYxW6Nn0BiyNZaQ4XU
	nyfScNxg8jQ60E3v0xgGVzVNw/+yaept+FyDLrWc4K0wDfxdh0dFajw/1Lb3tAAQZ0gMqd7/AMK
	MjJhKo7ZVz/yKoYycatmoXdBFEsUBfY2w1gpf8g/pUkd9v1MZRYRTWLKOMUzidYGQkBc=
X-Received: by 2002:a05:701b:21c8:b0:143:5266:48ee with SMTP id
 a92af1059eb24-18514634391mr10900137c88.42.1792433681931; Mon, 19 Oct 2026
 11:14:41 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260928175127.1032535-1-ctshao@google.com> <20260928175127.1032535-3-ctshao@google.com>
 <SA1PR12MB6773C9DE93757D6B73C1E9B3A09E2@SA1PR12MB6773.namprd12.prod.outlook.com>
 <CAJpZYjWLRiyNbzoGpA-2KE0zHgQn2gc0V943WxJEr5K5aZtRYA@mail.gmail.com> <SA1PR12MB677381C72E598B0EEC4AA2AAA0982@SA1PR12MB6773.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB677381C72E598B0EEC4AA2AAA0982@SA1PR12MB6773.namprd12.prod.outlook.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Mon, 19 Oct 2026 11:14:05 -0700
X-Gm-Features: AclHuK8ny14bvv7vwuIU1Lzj-DV4j-mZyinQV2eSHNrmwzpfcPNQIzM3xqnCjBs
Message-ID: <CAJpZYjVY_7d_EU37+wEwnFyfTHpQ-TdcMP6U5pW6Bpj55j_zKQ@mail.gmail.com>
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

Hi Besar,

Thanks, that makes sense. I'll drop my series in favor of yours.

Two things from mine that your JSON doesn't have yet:
1. DDR bandwidth from all sources to local CMEM (mem_bytes_{rd,wr}
with only dst_loc_cmem=3D1). Today it needs the sum of the local_cpu,
local_noncpu and remote _to_local_cmem metrics.
2. Read + write total bandwidth, for UCF memory and PCIe.

Agreed on handling the PCIe socket grouping in userspace; the
--metric-only issue I reported on your 3/6 is part of that.

Thanks,
CT

On Mon, Oct 19, 2026 at 10:43=E2=80=AFAM Besar Wicaksono <bwicaksono@nvidia=
.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Chun-Tse Shao <ctshao@google.com>
> > Sent: Friday, October 16, 2026 6:40 PM
> > To: Besar Wicaksono <bwicaksono@nvidia.com>
> > Cc: acme@kernel.org; namhyung@kernel.org; irogers@google.com;
> > peterz@infradead.org; mingo@redhat.com; mark.rutland@arm.com;
> > alexander.shishkin@linux.intel.com; jolsa@kernel.org;
> > adrian.hunter@intel.com; james.clark@linaro.org; linux-perf-
> > users@vger.kernel.org; linux-kernel@vger.kernel.org; Matt Ochs
> > <mochs@nvidia.com>; Sean Kelley <skelley@nvidia.com>; Rich Wiley
> > <rwiley@nvidia.com>; Vikram Sethi <vsethi@nvidia.com>; Raj Joshi
> > <rajjoshi@nvidia.com>
> > Subject: Re: [PATCH 2/2] perf jevents: Add NVIDIA Tegra410 uncore PCIe
> > metrics
> >
> > External email: Use caution opening links or attachments
> >
> >
> > On Tue, Oct 13, 2026 at 2:08=E2=80=AFPM Besar Wicaksono
> > <bwicaksono@nvidia.com> wrote:
> > >
> > > Hi Chun-Tse,
> > >
> > > I tested this on 2-sockets Tegra410 and found some issues.
> > > 1. With --per-socket or -A, every lpm_pcie_* metric is only reported =
for
> > >    socket 0, so socket 1's PCIe traffic never shows up. Example outpu=
t:
> > >
> > > perf stat -a -A -M lpm_pcie_rc1_bw -- sleep 1
> > >
> > >  Performance counter stats for 'system wide':
> > >
> > > CPU0               15,204      nvidia_pcie_pmu_0_rc_1/wr_bytes/ #    =
  0.0 MB/s
> > lpm_pcie_wr_bw_1
> > > CPU0                                                                 =
   #     33.8 MB/s  lpm_pcie_bw_1
> > > CPU0           33,910,952      nvidia_pcie_pmu_0_rc_1/rd_bytes/ #    =
 33.8
> > MB/s  lpm_pcie_rd_bw_1
> > > CPU88                   0      nvidia_pcie_pmu_1_rc_1/wr_bytes/
> > > CPU88                   0      nvidia_pcie_pmu_1_rc_1/rd_bytes/
> > > CPU0        1,002,286,615      tool/duration_time/
> > > CPU0                    0      nvidia_pcie_pmu_0_rc_1/wr_bytes,dst_re=
m=3D0x1/ #
> > 0.0 MB/s  lpm_pcie_rem_wr_bw_1
> > > CPU88                   0      nvidia_pcie_pmu_1_rc_1/wr_bytes,dst_re=
m=3D0x1/
> > > CPU0        1,002,275,059      tool/duration_time/
> > > CPU0                    0      nvidia_pcie_pmu_0_rc_1/rd_bytes,dst_re=
m=3D0x1/ #
> > 0.0 MB/s  lpm_pcie_rem_rd_bw_1
> > > CPU88                   0      nvidia_pcie_pmu_1_rc_1/rd_bytes,dst_re=
m=3D0x1/
> > > <snip>
> > >
> > > Note CPU88 (socket 1_ has no lpm_pcie_* values.
> > >
> > > 2. In the default mode, lpm_pcie_*_<i> adds RC i of socket 0 and RC i=
 of
> > >    socket 1. These are separate root complexes with different devices=
,
> > >    so the "Root Complex i" value can combine traffic from two unrelat=
ed
> > >    links.
> > >    Could the metrics follow the hardware hierarchy instead, starting =
at
> > >    the socket and drilling down to the RC, with the same destination
> > >    split at each level?
> > >     - per socket, all RCs (nvidia_pcie_pmu_<s>_rc):
> > >         lpm_pcie_s<s>_{bw,rd_bw,wr_bw}
> > >         lpm_pcie_s<s>_{loc,rem}_{rd,wr}_bw
> > >     - per socket and RC (nvidia_pcie_pmu_<s>_rc_<i>):
> > >         lpm_pcie_s<s>_{bw,rd_bw,wr_bw}_<i>
> > >         lpm_pcie_s<s>_{loc,rem}_{rd,wr}_bw_<i>
> > >       grouped as lpm_pcie_s<s>_rc<i>_bw.
> >
> > Thanks for testing and for the suggestion. I think both problems come
> > from how perf expects a PMU to expose its cpumask. Ideally perf wants
> > a single PMU for both sockets, with one CPU per socket in its cpumask,
> > e.g.:
> >
> > ```
> > /sys/bus/event_source/devices/nvidia_pcie_rc_0/cpumask: 0,88
> > ```
> >
>
> I see this as a driver design choice: expose each physical PMU
> separately, or group several physical instances under one logical PMU.
> Either way, the PMU name and cpumask tell userspace which CPU(s) and
> root complex are associated with the PMU. With the first approach, each
> perf PMU has a cpumask of a single CPU. Tegra410 follows the first
> approach and exposes each physical PMU as a separate perf PMU.
>
> > We can work around the one-PMU-per-socket layout in the metrics, but
> > would a single PMU per RC be a viable plan for you to implement?
> >
>
> Grouping instances across sockets is an interesting alternative, but it
> would require changes to the arm_cspmu driver design. We would also need
> to evaluate how such grouping could be supported generically in
> arm_cspmu, and whether the ACPI APMT would need changes.
>
> For this patch, I think userspace gives us more flexibility in how we
> present and aggregate counts across sockets and root complexes, so I'd
> prefer to address it there and keep the current driver model.
>
> FYI, I've posted the Tegra410 uncore JSON series:
> https://lore.kernel.org/all/20261019164241.403644-1-bwicaksono@nvidia.com=
/
> It adds events and metrics for the same counters (e.g. ucf_avg_*,
> cmem_avg_rd_latency, pcie_avg_*), so it would be good to align the two
> and avoid duplicate metrics.
>
> Thanks,
> Besar
>
> > Thanks,
> > CT
> >
> > >
> > > Thanks,
> > > Besar
> > >
> > > > -----Original Message-----
> > > > From: Chun-Tse Shao <ctshao@google.com>
> > > > Sent: Monday, September 28, 2026 5:51 PM
> > > > To: acme@kernel.org; namhyung@kernel.org; irogers@google.com
> > > > Cc: peterz@infradead.org; mingo@redhat.com;
> > mark.rutland@arm.com;
> > > > alexander.shishkin@linux.intel.com; jolsa@kernel.org;
> > > > adrian.hunter@intel.com; james.clark@linaro.org; Besar Wicaksono
> > > > <bwicaksono@nvidia.com>; linux-perf-users@vger.kernel.org; linux-
> > > > kernel@vger.kernel.org; Chun-Tse Shao <ctshao@google.com>
> > > > Subject: [PATCH 2/2] perf jevents: Add NVIDIA Tegra410 uncore PCIe
> > > > metrics
> > > >
> > > > External email: Use caution opening links or attachments
> > > >
> > > >
> > > > Add PCIe bandwidth metrics for the NVIDIA Tegra410 SoC. The formula=
s
> > > > follow Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst:
> > > >
> > > >   AVG_RD_BANDWIDTH_IN_GBPS =3D RD_BYTES / ELAPSED_TIME_IN_NS
> > > >   AVG_WR_BANDWIDTH_IN_GBPS =3D WR_BYTES / ELAPSED_TIME_IN_NS
> > > >
> > > > There is one PCIE PMU per socket and PCIe Root Complex (RC), named
> > > > nvidia_pcie_pmu_<socket-id>_rc_<pcie-rc-id>, with RCs 0 to 5 in eac=
h
> > > > socket. The metrics sum the rd_bytes/wr_bytes events of both socket=
s:
> > > >
> > > >   lpm_pcie_bw, lpm_pcie_rd_bw, lpm_pcie_wr_bw: all RCs.
> > > >   lpm_pcie_bw_<rc>, lpm_pcie_rd_bw_<rc>, lpm_pcie_wr_bw_<rc>: one
> > RC.
> > > >   lpm_pcie_loc_rd_bw_<rc>, lpm_pcie_loc_wr_bw_<rc>: one RC to local
> > > >     CMEM, GMEM, PCIe peer and CXL memory.
> > > >   lpm_pcie_rem_rd_bw_<rc>, lpm_pcie_rem_wr_bw_<rc>: one RC to
> > remote
> > > >     memory.
> > > >
> > > > The per RC metrics are in the lpm_pcie_rc<rc>_bw metric groups.
> > > >
> > > > A socket's event counts as 0 if its PMU isn't present (has_event() =
is
> > > > 0), e.g. on a single socket system, or if it isn't counted in the
> > > > aggregation (source_count() is 0), e.g. the other socket's event wi=
th
> > > > --per-socket. Otherwise the metric fails to parse or is nan.
> > > >
> > > > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > > > Assisted-by: Gemini:gemini-3.1-pro-preview
> > > > ---
> > > >  tools/perf/pmu-events/arm64_metrics.py | 68
> > > > ++++++++++++++++++++++++--
> > > >  1 file changed, 64 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/tools/perf/pmu-events/arm64_metrics.py b/tools/perf/pm=
u-
> > > > events/arm64_metrics.py
> > > > index b0d0651fec12..1ca3d8ddb4b7 100755
> > > > --- a/tools/perf/pmu-events/arm64_metrics.py
> > > > +++ b/tools/perf/pmu-events/arm64_metrics.py
> > > > @@ -2,9 +2,10 @@
> > > >  # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> > > >  import argparse
> > > >  import os
> > > > -from typing import Optional
> > > > -from metric import (aggr_nr, d_ratio, Event, JsonEncodeMetric,
> > > > -                    JsonEncodeMetricGroupDescriptions, LoadEvents,=
 Metric,
> > > > MetricGroup)
> > > > +from typing import List, Optional, Union
> > > > +from metric import (aggr_nr, d_ratio, has_event, source_count, Eve=
nt,
> > > > Expression,
> > > > +                    JsonEncodeMetric, JsonEncodeMetricGroupDescrip=
tions,
> > > > LoadEvents, Metric,
> > > > +                    MetricGroup, Select)
> > > >  from common_metrics import Cycles
> > > >
> > > >  # Global command line arguments.
> > > > @@ -67,7 +68,66 @@ def NvidiaT410Uncore() ->
> > Optional[MetricGroup]:
> > > >                     rd_cum_outs - rd_cum_outs, "1ns"),
> > > >          ], description=3D"NVIDIA Tegra410 DDR latency")
> > > >
> > > > -    return MetricGroup("lpm_uncore", [DdrBw(), DdrLat()],
> > > > +    def PcieBw() -> MetricGroup:
> > > > +        # PCIE PMU, one per socket and PCIe Root Complex (RC):
> > > > +        # AVG_{RD,WR}_BANDWIDTH =3D {RD,WR}_BYTES / ELAPSED_TIME
> > > > +        loc_dst =3D
> > > >
> > "dst_loc_cmem=3D0x1,dst_loc_gmem=3D0x1,dst_loc_pcie_p2p=3D0x1,dst_loc_p=
ci
> > > > e_cxl=3D0x1"
> > > > +        rem_dst =3D "dst_rem=3D0x1"
> > > > +
> > > > +        def SocketSum(rc: str, event: str) -> Expression:
> > > > +            # Sum the event over both sockets. A PMU counts as 0 i=
f it isn't
> > > > +            # present (has_event() is 0) or isn't counted in the a=
ggregation,
> > > > +            # e.g. the other socket with --per-socket (source_coun=
t() is 0).
> > > > +            def Count(e: Event) -> Expression:
> > > > +                return Select(Select(e, source_count(e), 0), has_e=
vent(e), 0)
> > > > +
> > > > +            return (Count(Event(f"nvidia_pcie_pmu_0_{rc}/{event}/"=
)) +
> > > > +                    Count(Event(f"nvidia_pcie_pmu_1_{rc}/{event}/"=
)))
> > > > +
> > > > +        # nvidia_pcie_pmu_<socket-id>_rc matches the PMUs of all R=
Cs in
> > the
> > > > socket.
> > > > +        rd =3D SocketSum("rc", "rd_bytes")
> > > > +        wr =3D SocketSum("rc", "wr_bytes")
> > > > +        metrics: List[Union[Metric, MetricGroup]] =3D [
> > > > +            Metric("lpm_pcie_bw", "Total PCIe bandwidth across all=
 Root
> > > > Complexes",
> > > > +                   d_ratio(rd + wr, interval_sec), mb_per_sec),
> > > > +            Metric("lpm_pcie_rd_bw", "Total PCIe read bandwidth ac=
ross all
> > > > Root Complexes",
> > > > +                   d_ratio(rd, interval_sec), mb_per_sec),
> > > > +            Metric("lpm_pcie_wr_bw", "Total PCIe write bandwidth a=
cross all
> > > > Root Complexes",
> > > > +                   d_ratio(wr, interval_sec), mb_per_sec),
> > > > +        ]
> > > > +        for i in range(6):
> > > > +            rc =3D f"rc_{i}"
> > > > +            rc_rd =3D SocketSum(rc, "rd_bytes")
> > > > +            rc_wr =3D SocketSum(rc, "wr_bytes")
> > > > +            loc_rd =3D SocketSum(rc, f"rd_bytes,{loc_dst}")
> > > > +            loc_wr =3D SocketSum(rc, f"wr_bytes,{loc_dst}")
> > > > +            rem_rd =3D SocketSum(rc, f"rd_bytes,{rem_dst}")
> > > > +            rem_wr =3D SocketSum(rc, f"wr_bytes,{rem_dst}")
> > > > +            metrics.append(MetricGroup(f"lpm_pcie_rc{i}_bw", [
> > > > +                Metric(f"lpm_pcie_bw_{i}", f"PCIe total bandwidth =
on Root
> > > > Complex {i}",
> > > > +                       d_ratio(rc_rd + rc_wr, interval_sec), mb_pe=
r_sec),
> > > > +                Metric(f"lpm_pcie_rd_bw_{i}", f"PCIe read bandwidt=
h on Root
> > > > Complex {i}",
> > > > +                       d_ratio(rc_rd, interval_sec), mb_per_sec),
> > > > +                Metric(f"lpm_pcie_wr_bw_{i}", f"PCIe write bandwid=
th on
> > Root
> > > > Complex {i}",
> > > > +                       d_ratio(rc_wr, interval_sec), mb_per_sec),
> > > > +                Metric(f"lpm_pcie_loc_rd_bw_{i}",
> > > > +                       f"PCIe local read bandwidth on Root Complex=
 {i}",
> > > > +                       d_ratio(loc_rd, interval_sec), mb_per_sec),
> > > > +                Metric(f"lpm_pcie_loc_wr_bw_{i}",
> > > > +                       f"PCIe local write bandwidth on Root Comple=
x {i}",
> > > > +                       d_ratio(loc_wr, interval_sec), mb_per_sec),
> > > > +                Metric(f"lpm_pcie_rem_rd_bw_{i}",
> > > > +                       f"PCIe remote read bandwidth on Root Comple=
x {i}",
> > > > +                       d_ratio(rem_rd, interval_sec), mb_per_sec),
> > > > +                Metric(f"lpm_pcie_rem_wr_bw_{i}",
> > > > +                       f"PCIe remote write bandwidth on Root Compl=
ex {i}",
> > > > +                       d_ratio(rem_wr, interval_sec), mb_per_sec),
> > > > +            ], description=3Df"PCIe bandwidth on Root Complex {i}"=
))
> > > > +
> > > > +        return MetricGroup("lpm_pcie_bw", metrics,
> > > > +                           description=3D"NVIDIA Tegra410 PCIe Roo=
t Complex
> > > > bandwidth")
> > > > +
> > > > +    return MetricGroup("lpm_uncore", [DdrBw(), DdrLat(), PcieBw()]=
,
> > > >                         description=3D"NVIDIA Tegra410 uncore metri=
cs")
> > > >
> > > >
> > > > --
> > > > 2.56.0.rc1.315.gc6ed9934b7-goog
> > >
