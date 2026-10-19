Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792432245;
	b=eqL2mP1Bv9KJxt57jlOE5nb+tJ/IJV6ERHLGUxLK8mpTW7Xy4+6oCdJCgN0i6EJC6ipy
	 fp0PVC/xZQV4NwMwG0VUrCEc3bWkHBxY6GZiL1fk87iv0i+D+mAT/AhJNNWV0oAuDxk0S
	 75tnrnjQXkjPx8/dTEMwa+wzj0Gk/xB1+pU/EtOc1TGu77omBMMRJqysm845auobAG+9n
	 sDfB9+LjU9jd/OkZVOFDBpOq7k2MzCWtol9GaB3fhyEpGYF4RBcMpbzf9MNs7lozTI6RZ
	 LIh2cc3aWgz6owbXsIgW2AbsIzUgfBkQSYmA7ri8IcqvmuzGYcsDVLdOV+Lwu9phbSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432245;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yxr3yy5APwTjGC/8MQQ5vWLHB19nNrJrEZoaHSPj4Ms=;
	b=PXLAScNgq+ppbhJpQqBBJnG4sjOlDJZY290pAS8ILQuUk0+2/qykicvLJRC0/AWDYLCe
	 e89zCEcV2iTY5Vpp2ZgvW8oB0zMNOoO5kfG4Omjawn+tXoTAG1yb5jL+hejvR29E1O3k5
	 Y7VYiH/ejiKzimIfj/oAHIBwBcjyrA602fT45iaRB2C0+T8pmKs2C5PGHmE/v2gGGM8BU
	 QxBUeMBfngoyXOMoiNDJJVhkPeCc7u002Ynhdi3PbypOfaiFzctjQcI3kZnXwhfzoMYGY
	 FKfY1e/MZE0MPvgymTjvaTG2ngOyeFglduimJQSC6QqaGNJQZK4+Oi4rp8RhqBkJABQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=UUEQHwGR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75265606A31C
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 17:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75265606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=UUEQHwGR
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-14394530ec6so1306698c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 10:50:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792432244; cv=none;
        d=google.com; s=arc-20260327;
        b=Lk/VbTdCcF88C/h+TtbLl+wNa0PAPSo8oL406qM+YrmIx7elduVB2/g3nQCxslqL/i
         xEjUW9FA4SuE7vk4wdPOx0ikNuVwyyyxToh1YeJSL1oD5RVW0A6nQb0NQ2/bSHokxu6k
         Coj09W+slXcq1PzG7XsmkKueyUaFZw7rQNPiBhl7s+MLOb8PYhDvCAP8mB66+GzFn9LJ
         1gOvf/eW/ClS734WZyR//sD7FihwO9a8OFM1XJ5TAa2datksKzFArXCfrgqWg6R+BWjr
         e0F0rZOKHwBWrg1Yd8MIWFBgS2inEWb6xvSN8nncc+5TLMLYfe7ELPeyaBEEPAKgzX3+
         gmBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yxr3yy5APwTjGC/8MQQ5vWLHB19nNrJrEZoaHSPj4Ms=;
        fh=u1+QsUnY1IUlNJGfa6I2JOWQFt07WlFDDl6C/eDSX2s=;
        b=qQ7AKt1z16dAHK+wCjageRv2ZL1mvxxO6220W5HDcr9tTHYCrxrIgAY7U0mLPaMnr4
         GLGZnIBZGP548OJP4covr63XmWoOS8edmWyIcfSboXM55MvEi9wYWXk1+2/PaJ9BAcyb
         DYFIE265zHCyr6Qq8HfJLhq6ZXJdO8Y9EATcZ7PY5OxzSAfWuseYUM2sVFisSZqjAaFX
         SEsPtmx3ButpBzGPjtU/y1vFLM2RX5lYdeZyOnFLVP3Cjjgm48AihJYLUy5QZ+eQOBPg
         vr7cGbESePsAxSvdKxrnJctutH2ZW+71QzBTC5yx31+T+HAMC6+cvssLLLSXVRXpz4+A
         rHTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792432244; x=1793037044; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yxr3yy5APwTjGC/8MQQ5vWLHB19nNrJrEZoaHSPj4Ms=;
        b=UUEQHwGRh1o6+pisyuJZf3P9fduUvukVOX6CopUvQJ0bn1pVaj6lQMzmk2AtAW/5Dg
         cehvFJRh5oS3VAGYWb2H5hTBS39E79QWUWA2SGoGn/dofmWqwfMSHtNhOQgYg4pUfqz2
         vRRt5RGIyto3ALd03TopjtH8Tfw5yy/W3cazjXGt9GQGXQQKezVE2KLsDzAUL7Pq2yBM
         3GRSzCxiiqrAUiCBrBuHIhGLlIOuQ8Gfl4atd+eYfqLfLq5W5jnVE+1ZGrst6OjKOKSZ
         BDlFuuH6+icJwAtMaCj8r0O/Tf3upHWXgcaW1DbylRe2yLj3if8sOtsgdsZoplxhIF8B
         fBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792432244; x=1793037044;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yxr3yy5APwTjGC/8MQQ5vWLHB19nNrJrEZoaHSPj4Ms=;
        b=vEsnPti18UEu1UQwkiZqL3How9MOgIyygatdpQ34FjIr6RnG5JYwluyquJkSC4uLVk
         YfIpDgh6BQlNugA6sjekch6x4bpY7C3UBrJbHfqwKUYsgsZfxdPjLY6uqO+SSEIGbVHu
         pmT72+xeeLxvQ9oqtDz8jxljcgxrpOX+Wel7+7voZqrIX+L94xw75LS85wylysSHLU1P
         901PpT//v5Wr856yZcw7Cz2E+94RcPJtPDnHOKzL2GT9/covZfL2i33iaanMiZllQXMd
         bvILcbLdjw293HYWdT/pzhl74ij/grVoh4rWAGRcM8ISas3gInBvo7QBaClJmZe+625+
         aQTQ==
X-Forwarded-Encrypted: i=1; AKwUvBwi2pMOhxneO9FHP4a7Pwpb4tcNcd+RTM7MfORXOtPqjHkr4IZblVs9TdsC4bIR2fB0TAGKQOBd2nLS8sB84BB/@vger.kernel.org
X-Gm-Message-State: AFq9FYLD0JwIIOZTXWrz6ehb9WDSzyew4FLtwmEjQMG29XAHYDK7PEd1
	fwZViWPTljkMmi+5rXZJ8x7odQrbTH4RdVg9pGTXH6LRoBl3WJHwcbE3/lP/c9nII7+EAe4oAcH
	wYifyeLQ5bpGjHhnhj5JqR9x95buOAn6AXila+Hnh
X-Gm-Gg: AYBFou3ZXufcupaggLutNuiy+Bgen5i7bMjN5Ow6Js5HiPfk3Wc7k2plNhXdj/y2cER
	xsG8mecRyScmc1B0pGGAHHcdZmx1wxgCA7GVBMxmHGuFc7swnpeiMPzB0biJmZgxUTtEy3mpA3O
	ixuapNRUVjBWNEEAVCUxj9TGrIZwVSHb3VklosvcqCtoc2kG+eT/g4MZk2/fpjvdmCX2ikDGdZB
	jvwHx9FYjYOUsQTJhvOUS17wVBJWiIipaj0ArU5si3hLTkJ8x8KUqB5I5cCAcIJDcrMERa7geR2
	WcYtuu53SwcLTsWJdsfIMP/8MqyT24N3uzUfgAv7DQ/1HHCmRwaWi+oBpHy/zMUR02GP6HXdnVZ
	2I4JYuRV3rg==
X-Received: by 2002:a05:7023:901:b0:138:30b1:4c00 with SMTP id
 a92af1059eb24-1850c40d8d0mr14069971c88.3.1792432242358; Mon, 19 Oct 2026
 10:50:42 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019164241.403644-1-bwicaksono@nvidia.com> <20261019164241.403644-4-bwicaksono@nvidia.com>
In-Reply-To: <20261019164241.403644-4-bwicaksono@nvidia.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Mon, 19 Oct 2026 10:50:03 -0700
X-Gm-Features: AclHuK-k9em4UinzRLY1SwpkrF-Fn3v95lx1FapCdO9mAXeOsitZvqSqnBbEdcc
Message-ID: <CAJpZYjURztEO088Z4ms01UmxST+OYD5-t9u4ymGe-iig9jO_jg@mail.gmail.com>
Subject: Re: [PATCH 3/6] perf jevents: Add support for NVIDIA Tegra410 PCIE
 PMU aliasing
To: Besar Wicaksono <bwicaksono@nvidia.com>
Cc: acme@kernel.org, namhyung@kernel.org, irogers@google.com, 
	linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	vsethi@nvidia.com, rwiley@nvidia.com, skelley@nvidia.com, mochs@nvidia.com, 
	rajjoshi@nvidia.com, treding@nvidia.com, jonathanh@nvidia.com, 
	john.garry@linux.dev, will@kernel.org, james.clark@linaro.org, 
	mike.leach@arm.com, leo.yan@linux.dev, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Besar,

Thanks for the series. I tested this on a 2-socket Tegra410. With
--metric-only, each PCIe metric shows up once per socket, with `nan`
("none" with -j) in the other socket's column, so -j has the same key
twice in each row. "counters" is also 0 for socket 1, because it comes
from the first event, which belongs to socket 0:

```
$ perf stat -a --per-socket -M pcie_avg_wr_bandwidth_to_all_dst -j
--metric-only -- sleep 1
{"socket" : "S268435456", "counters" : 6, "MB/s
pcie_avg_wr_bandwidth_to_all_dst" : "0.1", "MB/s
pcie_avg_wr_bandwidth_to_all_dst" : "none"}
{"socket" : "S285212672", "counters" : 0, "MB/s
pcie_avg_wr_bandwidth_to_all_dst" : "none", "MB/s
pcie_avg_wr_bandwidth_to_all_dst" : "0.9"}
```

As in [1], a single PMU per RC with cpumask `0,88`, or the socket last
in the PMU name, would fix this.

[1] https://lore.kernel.org/linux-perf-users/CAJpZYjWLRiyNbzoGpA-2KE0zHgQn2=
gc0V943WxJEr5K5aZtRYA@mail.gmail.com/

Thanks,
CT

On Mon, Oct 19, 2026 at 9:45=E2=80=AFAM Besar Wicaksono <bwicaksono@nvidia.=
com> wrote:
>
> Add alias support for NVIDIA Tegra410 PCIE PMU events and metrics.
>
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
> ---
>  .../arm64/nvidia/t410/sys/uncore-pcie.json    | 247 ++++++++++++++++++
>  1 file changed, 247 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/unco=
re-pcie.json
>
> diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-pcie=
.json b/tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-pcie.json
> new file mode 100644
> index 000000000000..37c3eac305e5
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-pcie.json
> @@ -0,0 +1,247 @@
> +[
> +    {
> +        "EventCode": "0x100000000",
> +        "EventName": "PCIE_CYCLES",
> +        "BriefDescription": "Counts cycles at the PCIe interface to the =
Tegra SoC data fabric.",
> +        "PublicDescription": "Counts cycles at the PCIe interface to the=
 Tegra SoC data fabric.",
> +        "Compat": "1030136b",
> +        "Unit": "nvidia_pcie_pmu_,rc_"
> +    },
> +    {
> +        "EventCode": "0x2",
> +        "EventName": "PCIE_RD_REQ",
> +        "BriefDescription": "Counts read requests from PCIe devices unde=
r this PCIe root complex to memory or another PCIe device.",
> +        "PublicDescription": "Counts read requests from PCIe devices und=
er this PCIe root complex to memory or another PCIe device, where the targe=
t responds with data. Request size can be from 1 to 256 bytes. Filters: src=
_rp_mask selects the requesting root ports. Alternatively, src_bdf with src=
_bdf_en selects one requesting device (BDF); it cannot be combined with src=
_rp_mask and applies to all counters of this PMU. Destination filters selec=
t the memory type of the request address: dst_loc_cmem local CMEM, dst_loc_=
gmem local GMEM, dst_loc_pcie_p2p local PCIe peer addresses, dst_loc_pcie_c=
xl local CXL memory, dst_rem remote memory. This is the address's home type=
, not where the data currently resides; local or remote is determined by th=
e home socket of the address. An unset source filter counts all root ports;=
 an unset destination filter counts all destinations.",
> +        "Compat": "1030136b",
> +        "Unit": "nvidia_pcie_pmu_,rc_"
> +    },
> +    {
> +        "EventCode": "0x3",
> +        "EventName": "PCIE_WR_REQ",
> +        "BriefDescription": "Counts write requests from PCIe devices und=
er this PCIe root complex to memory or another PCIe device.",
> +        "PublicDescription": "Counts write requests from PCIe devices un=
der this PCIe root complex to memory or another PCIe device, where the PCIe=
 device sends data. Request size can be from 1 to 256 bytes. Filters: src_r=
p_mask selects the requesting root ports. Alternatively, src_bdf with src_b=
df_en selects one requesting device (BDF); it cannot be combined with src_r=
p_mask and applies to all counters of this PMU. Destination filters select =
the memory type of the request address: dst_loc_cmem local CMEM, dst_loc_gm=
em local GMEM, dst_loc_pcie_p2p local PCIe peer addresses, dst_loc_pcie_cxl=
 local CXL memory, dst_rem remote memory. This is the address's home type, =
not where the data currently resides; local or remote is determined by the =
home socket of the address. An unset source filter counts all root ports; a=
n unset destination filter counts all destinations.",
> +        "Compat": "1030136b",
> +        "Unit": "nvidia_pcie_pmu_,rc_"
> +    },
> +    {
> +        "EventCode": "0x0",
> +        "EventName": "PCIE_RD_BYTES",
> +        "BriefDescription": "Counts bytes transferred by the read reques=
ts counted by PCIE_RD_REQ.",
> +        "PublicDescription": "Counts bytes transferred by the read reque=
sts counted by PCIE_RD_REQ. Source and destination filters work as describe=
d for PCIE_RD_REQ.",
> +        "Compat": "1030136b",
> +        "Unit": "nvidia_pcie_pmu_,rc_"
> +    },
> +    {
> +        "EventCode": "0x1",
> +        "EventName": "PCIE_WR_BYTES",
> +        "BriefDescription": "Counts bytes transferred by the write reque=
sts counted by PCIE_WR_REQ.",
> +        "PublicDescription": "Counts bytes transferred by the write requ=
ests counted by PCIE_WR_REQ. Source and destination filters work as describ=
ed for PCIE_WR_REQ.",
> +        "Compat": "1030136b",
> +        "Unit": "nvidia_pcie_pmu_,rc_"
> +    },
> +    {
> +        "EventCode": "0x4",
> +        "EventName": "PCIE_RD_CUM_OUTS",
> +        "BriefDescription": "Accumulates the outstanding read requests c=
ounted by PCIE_RD_REQ each cycle at the PCIe interface.",
> +        "PublicDescription": "Accumulates the outstanding read requests =
counted by PCIE_RD_REQ each cycle at the PCIe interface. Pair the two under=
 the same filters for the average read latency. Source and destination filt=
ers work as described for PCIE_RD_REQ.",
> +        "Compat": "1030136b",
> +        "Unit": "nvidia_pcie_pmu_,rc_"
> +    },
> +    {
> +        "MetricName": "pcie_freq",
> +        "MetricGroup": "PCIE_Frequency;PCIE_Read_Latency",
> +        "MetricConstraint": "NO_GROUP_EVENTS",
> +        "MetricExpr": "(PCIE_CYCLES / aggr_nr(PCIE_CYCLES)) / 1e9 / dura=
tion_time",
> +        "ScaleUnit": "1GHz",
> +        "BriefDescription": "Frequency of the cycles at the PCIe interfa=
ce to the Tegra SoC data fabric.",
> +        "PublicDescription": "Average frequency of the cycles at the PCI=
e interface to the Tegra SoC data fabric over the measurement interval.",
> +        "Compat": "1030136b",
> +        "Unit": "nvidia_pcie_pmu_,rc_"
> +    },
> +    {
> +        "MetricName": "pcie_avg_rd_bandwidth_to_all_dst",
> +        "MetricGroup": "PCIE_Bandwidth;PCIE_To_All_Destinations",
> +        "MetricExpr": "PCIE_RD_BYTES@dst_loc_cmem=3D1,dst_loc_gmem=3D1,d=
st_loc_pcie_p2p=3D1,dst_loc_pcie_cxl=3D1,dst_rem=3D1@ / 1e6 / duration_time=
",
> +        "ScaleUnit": "1MB/s",
> +        "BriefDescription": "Average read bandwidth from PCIe devices un=
der this PCIe root complex to all destinations.",
> +        "PublicDescription": "Average read bandwidth of requests from al=
l PCIe devices under this PCIe root complex to all destinations: local CMEM=
, local GMEM, local PCIe peer addresses, local CXL memory and remote memory=
.",
> +        "Compat": "1030136b",
> +        "Unit": "nvidia_pcie_pmu_,rc_"
> +    },
> +    {
> +        "MetricName": "pcie_avg_wr_bandwidth_to_all_dst",
> +        "MetricGroup": "PCIE_Bandwidth;PCIE_To_All_Destinations",
> +        "MetricExpr": "PCIE_WR_BYTES@dst_loc_cmem=3D1,dst_loc_gmem=3D1,d=
st_loc_pcie_p2p=3D1,dst_loc_pcie_cxl=3D1,dst_rem=3D1@ / 1e6 / duration_time=
",
> +        "ScaleUnit": "1MB/s",
> +        "BriefDescription": "Average write bandwidth from PCIe devices u=
nder this PCIe root complex to all destinations.",
> +        "PublicDescription": "Average write bandwidth of requests from a=
ll PCIe devices under this PCIe root complex to all destinations: local CME=
M, local GMEM, local PCIe peer addresses, local CXL memory and remote memor=
y.",
> +        "Compat": "1030136b",
> +        "Unit": "nvidia_pcie_pmu_,rc_"
> +    },
> +    {
> +        "MetricName": "pcie_avg_rd_latency_to_all_dst",
> +        "MetricGroup": "PCIE_Read_Latency;PCIE_To_All_Destinations",
> +        "MetricConstraint": "NO_GROUP_EVENTS",
> +        "MetricExpr": "(PCIE_RD_CUM_OUTS@dst_loc_cmem=3D1,dst_loc_gmem=
=3D1,dst_loc_pcie_p2p=3D1,dst_loc_pcie_cxl=3D1,dst_rem=3D1@ / PCIE_RD_REQ@d=
st_loc_cmem=3D1,dst_loc_gmem=3D1,dst_loc_pcie_p2p=3D1,dst_loc_pcie_cxl=3D1,=
dst_rem=3D1@) / pcie_freq",
> +        "ScaleUnit": "1ns/request",
> +        "BriefDescription": "Average read latency from PCIe devices unde=
r this PCIe root complex to all destinations.",
> +        "PublicDescription": "Average latency of read requests from all =
PCIe devices under this PCIe root complex to all destinations: local CMEM, =
local GMEM, local PCIe peer addresses, local CXL memory and remote memory."=
,
> +        "Compat": "1030136b",
> +        "Unit": "nvidia_pcie_pmu_,rc_"
> +    },
> +    {
> +        "MetricName": "pcie_avg_rd_bandwidth_to_local_cmem",
> +        "MetricGroup": "PCIE_Bandwidth;PCIE_Read;PCIE_To_Local_CMEM",
> +        "MetricExpr": "PCIE_RD_BYTES@dst_loc_cmem=3D1@ / 1e6 / duration_=
time",
> +        "ScaleUnit": "1MB/s",
> +        "BriefDescription": "Average read bandwidth from PCIe devices un=
der this PCIe root complex to local CMEM.",
> +        "PublicDescription": "Average read bandwidth of requests from al=
l PCIe devices under this PCIe root complex to local CMEM.",
> +        "Compat": "1030136b",
> +        "Unit": "nvidia_pcie_pmu_,rc_"
> +    },
> +    {
> +        "MetricName": "pcie_avg_wr_bandwidth_to_local_cmem",
> +        "MetricGroup": "PCIE_Bandwidth;PCIE_Write;PCIE_To_Local_CMEM",
> +        "MetricExpr": "PCIE_WR_BYTES@dst_loc_cmem=3D1@ / 1e6 / duration_=
time",
> +        "ScaleUnit": "1MB/s",
> +        "BriefDescription": "Average write bandwidth from PCIe devices u=
nder this PCIe root complex to local CMEM.",
> +        "PublicDescription": "Average write bandwidth of requests from a=
ll PCIe devices under this PCIe root complex to local CMEM.",
> +        "Compat": "1030136b",
> +        "Unit": "nvidia_pcie_pmu_,rc_"
> +    },
> +    {
> +        "MetricName": "pcie_avg_rd_latency_to_local_cmem",
> +        "MetricGroup": "PCIE_Read_Latency;PCIE_Read;PCIE_To_Local_CMEM",
> +        "MetricConstraint": "NO_GROUP_EVENTS",
> +        "MetricExpr": "(PCIE_RD_CUM_OUTS@dst_loc_cmem=3D1@ / PCIE_RD_REQ=
@dst_loc_cmem=3D1@) / pcie_freq",
> +        "ScaleUnit": "1ns/request",
> +        "BriefDescription": "Average read latency from PCIe devices unde=
r this PCIe root complex to local CMEM.",
> +        "PublicDescription": "Average latency of read requests from all =
PCIe devices under this PCIe root complex to local CMEM.",
> +        "Compat": "1030136b",
> +        "Unit": "nvidia_pcie_pmu_,rc_"
> +    },
> +    {
> +        "MetricName": "pcie_avg_rd_bandwidth_to_local_gmem",
> +        "MetricGroup": "PCIE_Bandwidth;PCIE_Read;PCIE_To_Local_GMEM",
> +        "MetricExpr": "PCIE_RD_BYTES@dst_loc_gmem=3D1@ / 1e6 / duration_=
time",
> +        "ScaleUnit": "1MB/s",
> +        "BriefDescription": "Average read bandwidth from PCIe devices un=
der this PCIe root complex to local GMEM.",
> +        "PublicDescription": "Average read bandwidth of requests from al=
l PCIe devices under this PCIe root complex to local GMEM.",
> +        "Compat": "1030136b",
> +        "Unit": "nvidia_pcie_pmu_,rc_"
> +    },
> +    {
> +        "MetricName": "pcie_avg_wr_bandwidth_to_local_gmem",
> +        "MetricGroup": "PCIE_Bandwidth;PCIE_Write;PCIE_To_Local_GMEM",
> +        "MetricExpr": "PCIE_WR_BYTES@dst_loc_gmem=3D1@ / 1e6 / duration_=
time",
> +        "ScaleUnit": "1MB/s",
> +        "BriefDescription": "Average write bandwidth from PCIe devices u=
nder this PCIe root complex to local GMEM.",
> +        "PublicDescription": "Average write bandwidth of requests from a=
ll PCIe devices under this PCIe root complex to local GMEM.",
> +        "Compat": "1030136b",
> +        "Unit": "nvidia_pcie_pmu_,rc_"
> +    },
> +    {
> +        "MetricName": "pcie_avg_rd_latency_to_local_gmem",
> +        "MetricGroup": "PCIE_Read_Latency;PCIE_Read;PCIE_To_Local_GMEM",
> +        "MetricConstraint": "NO_GROUP_EVENTS",
> +        "MetricExpr": "(PCIE_RD_CUM_OUTS@dst_loc_gmem=3D1@ / PCIE_RD_REQ=
@dst_loc_gmem=3D1@) / pcie_freq",
> +        "ScaleUnit": "1ns/request",
> +        "BriefDescription": "Average read latency from PCIe devices unde=
r this PCIe root complex to local GMEM.",
> +        "PublicDescription": "Average latency of read requests from all =
PCIe devices under this PCIe root complex to local GMEM.",
> +        "Compat": "1030136b",
> +        "Unit": "nvidia_pcie_pmu_,rc_"
> +    },
> +    {
> +        "MetricName": "pcie_avg_rd_bandwidth_to_local_cxlmem",
> +        "MetricGroup": "PCIE_Bandwidth;PCIE_Read;PCIE_To_Local_CXLMEM",
> +        "MetricExpr": "PCIE_RD_BYTES@dst_loc_pcie_cxl=3D1@ / 1e6 / durat=
ion_time",
> +        "ScaleUnit": "1MB/s",
> +        "BriefDescription": "Average read bandwidth from PCIe devices un=
der this PCIe root complex to local CXL memory.",
> +        "PublicDescription": "Average read bandwidth of requests from al=
l PCIe devices under this PCIe root complex to local CXL memory.",
> +        "Compat": "1030136b",
> +        "Unit": "nvidia_pcie_pmu_,rc_"
> +    },
> +    {
> +        "MetricName": "pcie_avg_wr_bandwidth_to_local_cxlmem",
> +        "MetricGroup": "PCIE_Bandwidth;PCIE_Write;PCIE_To_Local_CXLMEM",
> +        "MetricExpr": "PCIE_WR_BYTES@dst_loc_pcie_cxl=3D1@ / 1e6 / durat=
ion_time",
> +        "ScaleUnit": "1MB/s",
> +        "BriefDescription": "Average write bandwidth from PCIe devices u=
nder this PCIe root complex to local CXL memory.",
> +        "PublicDescription": "Average write bandwidth of requests from a=
ll PCIe devices under this PCIe root complex to local CXL memory.",
> +        "Compat": "1030136b",
> +        "Unit": "nvidia_pcie_pmu_,rc_"
> +    },
> +    {
> +        "MetricName": "pcie_avg_rd_latency_to_local_cxlmem",
> +        "MetricGroup": "PCIE_Read_Latency;PCIE_Read;PCIE_To_Local_CXLMEM=
",
> +        "MetricConstraint": "NO_GROUP_EVENTS",
> +        "MetricExpr": "(PCIE_RD_CUM_OUTS@dst_loc_pcie_cxl=3D1@ / PCIE_RD=
_REQ@dst_loc_pcie_cxl=3D1@) / pcie_freq",
> +        "ScaleUnit": "1ns/request",
> +        "BriefDescription": "Average read latency from PCIe devices unde=
r this PCIe root complex to local CXL memory.",
> +        "PublicDescription": "Average latency of read requests from all =
PCIe devices under this PCIe root complex to local CXL memory.",
> +        "Compat": "1030136b",
> +        "Unit": "nvidia_pcie_pmu_,rc_"
> +    },
> +    {
> +        "MetricName": "pcie_avg_rd_bandwidth_to_remote_mem",
> +        "MetricGroup": "PCIE_Bandwidth;PCIE_Read;PCIE_To_Remote_Memory",
> +        "MetricExpr": "PCIE_RD_BYTES@dst_rem=3D1@ / 1e6 / duration_time"=
,
> +        "ScaleUnit": "1MB/s",
> +        "BriefDescription": "Average read bandwidth from PCIe devices un=
der this PCIe root complex to remote memory.",
> +        "PublicDescription": "Average read bandwidth of requests from al=
l PCIe devices under this PCIe root complex to remote memory.",
> +        "Compat": "1030136b",
> +        "Unit": "nvidia_pcie_pmu_,rc_"
> +    },
> +    {
> +        "MetricName": "pcie_avg_wr_bandwidth_to_remote_mem",
> +        "MetricGroup": "PCIE_Bandwidth;PCIE_Write;PCIE_To_Remote_Memory"=
,
> +        "MetricExpr": "PCIE_WR_BYTES@dst_rem=3D1@ / 1e6 / duration_time"=
,
> +        "ScaleUnit": "1MB/s",
> +        "BriefDescription": "Average write bandwidth from PCIe devices u=
nder this PCIe root complex to remote memory.",
> +        "PublicDescription": "Average write bandwidth of requests from a=
ll PCIe devices under this PCIe root complex to remote memory.",
> +        "Compat": "1030136b",
> +        "Unit": "nvidia_pcie_pmu_,rc_"
> +    },
> +    {
> +        "MetricName": "pcie_avg_rd_latency_to_remote_mem",
> +        "MetricGroup": "PCIE_Read_Latency;PCIE_Read;PCIE_To_Remote_Memor=
y",
> +        "MetricConstraint": "NO_GROUP_EVENTS",
> +        "MetricExpr": "(PCIE_RD_CUM_OUTS@dst_rem=3D1@ / PCIE_RD_REQ@dst_=
rem=3D1@) / pcie_freq",
> +        "ScaleUnit": "1ns/request",
> +        "BriefDescription": "Average read latency from PCIe devices unde=
r this PCIe root complex to remote memory.",
> +        "PublicDescription": "Average latency of read requests from all =
PCIe devices under this PCIe root complex to remote memory.",
> +        "Compat": "1030136b",
> +        "Unit": "nvidia_pcie_pmu_,rc_"
> +    },
> +    {
> +        "MetricName": "pcie_avg_rd_bandwidth_to_local_pcie_peer",
> +        "MetricGroup": "PCIE_Bandwidth;PCIE_Read;PCIE_To_Local_PCIE_Peer=
",
> +        "MetricExpr": "PCIE_RD_BYTES@dst_loc_pcie_p2p=3D1@ / 1e6 / durat=
ion_time",
> +        "ScaleUnit": "1MB/s",
> +        "BriefDescription": "Average read bandwidth from PCIe devices un=
der this PCIe root complex to local PCIe peer addresses.",
> +        "PublicDescription": "Average read bandwidth of requests from al=
l PCIe devices under this PCIe root complex to local PCIe peer addresses.",
> +        "Compat": "1030136b",
> +        "Unit": "nvidia_pcie_pmu_,rc_"
> +    },
> +    {
> +        "MetricName": "pcie_avg_wr_bandwidth_to_local_pcie_peer",
> +        "MetricGroup": "PCIE_Bandwidth;PCIE_Write;PCIE_To_Local_PCIE_Pee=
r",
> +        "MetricExpr": "PCIE_WR_BYTES@dst_loc_pcie_p2p=3D1@ / 1e6 / durat=
ion_time",
> +        "ScaleUnit": "1MB/s",
> +        "BriefDescription": "Average write bandwidth from PCIe devices u=
nder this PCIe root complex to local PCIe peer addresses.",
> +        "PublicDescription": "Average write bandwidth of requests from a=
ll PCIe devices under this PCIe root complex to local PCIe peer addresses."=
,
> +        "Compat": "1030136b",
> +        "Unit": "nvidia_pcie_pmu_,rc_"
> +    },
> +    {
> +        "MetricName": "pcie_avg_rd_latency_to_local_pcie_peer",
> +        "MetricGroup": "PCIE_Read_Latency;PCIE_Read;PCIE_To_Local_PCIE_P=
eer",
> +        "MetricConstraint": "NO_GROUP_EVENTS",
> +        "MetricExpr": "(PCIE_RD_CUM_OUTS@dst_loc_pcie_p2p=3D1@ / PCIE_RD=
_REQ@dst_loc_pcie_p2p=3D1@) / pcie_freq",
> +        "ScaleUnit": "1ns/request",
> +        "BriefDescription": "Average read latency from PCIe devices unde=
r this PCIe root complex to local PCIe peer addresses.",
> +        "PublicDescription": "Average latency of read requests from all =
PCIe devices under this PCIe root complex to local PCIe peer addresses.",
> +        "Compat": "1030136b",
> +        "Unit": "nvidia_pcie_pmu_,rc_"
> +    }
> +]
> --
> 2.43.0
>
