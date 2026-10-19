Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792451897;
	b=lGGH/xRqVLfUap+h/7rBHXtd74LqW5mxysSEA4i3p6C+JLqVzjwYWLp6+WeZLUMOqD2x
	 1XIgMy2muoUAXkvhUbsUKFt71xlR1F/SQl5QLgoLxebS6j9zcZH20r7Rd46mSsL6yPCFB
	 NgXZ0EoUflm9NsI85OQA1nE8WCbW+747xJxPxDpPvT7p5mNZJ26ZyKSI9PpPnC9qlV8rs
	 AmSssPBmXrL40DFbJ5cjBrHGdXhPFppexIOqF8cR/1Z8CnFtV8u8ScyS5kJU8xy3tqo8u
	 S7zr4N6+MiKvmcIGWKPaVVr9GyMg0PucE7nXJGQAYUEAUjPN1zvr0SDMZZNOe8LThug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792451897;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xkEO/OSiRmfTcfnZn00ylSAwEOQz293NLx30J9yMRbI=;
	b=m9IXZqOSW4u3faRRizy3/+MAx2TIRr7OJ1SFK5hqxmCXdPRgQA//ox2PkLyS0sN++ZP1
	 nZRvJ42MkAfoZDVxrNnlnBzzOT85sxEwJzdJT+Ipg+fMa3KKfB5QXdX6n3rd8tSvXPzqo
	 myp9Rv3J+W4asF3nhHKDsDiPR6ksS4cox0jKUW4bFGO1p0Cs3hHWDIQWKFsXpYXsQzV5J
	 seItjAjRD5uWLR+MuYMwlsmGfIM0EY3AJYBI1XlKgPXKLY+sBhzxJgIS708yyZ2EosQDY
	 h6NOqAtfWthjopfktH0GLh0hLghYzZFPCOrILGGUgwBbA9DWwI0OoF51rDJr6Wtttsg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=lXSTaDUM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430DE606A31A
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 23:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 430DE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=lXSTaDUM
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5337c7b9937so126511cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 16:18:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792451896; cv=none;
        d=google.com; s=arc-20260327;
        b=EwzOmwKclRRqGLkjqG6d3u4evD3PgvNNbcMf1sqA63O0QQ33qMB9ygZL6RyxIscCwr
         NKsaoKKm3bAlsMR/ZalZi9vGOOonssBpdHdDM2sJZu2dPhuq0hAoJSEa52N03NTR4wkj
         h+9zuTky0GJL7CJno/fD6I+JB/gNSbSt5oI3bIHhpktdWwRChet8CSim/J4TylT9v1/a
         r2FXpnfis21u34U6HL7btaz1W/0ODT9hHk59cq1Xx8z3+wEGyUUbJ93j2+gjFqwSOC8E
         mboSM025AEJJ6UKlQgHoWgs/tgMOPxyuRH3R3Hi4YJnwMOmGGYNl+khsNm2ZZiuJuvkD
         hztA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xkEO/OSiRmfTcfnZn00ylSAwEOQz293NLx30J9yMRbI=;
        fh=+eg59uif7W7bBargYqIvDvxO6UCpLO5tO1MEeftC9eQ=;
        b=rM73sLnuP8x39cM8hf+f7LDZz25OLMpeaXd6Kfq+4lbmbqE3hixBPfVErXsiOMpm5g
         mSCbXUaENuOnWDyHIqMIv+g1PeMgHxKaKRI+rI1H0XtL+tTneSWREKeG3CMpX/wvpqNh
         Oq6Q0c7rInerV06pLVP9/KYAM1/rkjv464ZGhiqJf4Q+9P8Zl3qiD0cHGRLVhfOPb4wZ
         1ZZb2VasVRwRCK2aUGBwM//5INb5MvZYbv40sLsTgIxV2AOjvE0F9z+PpZ6a2ZOiWQPJ
         c89MBm4vgsjG3Vy1KTeGsT8TMcdGgJAb7QuefXRXf1Q6giYsCq3JvR/8zBTHR+6cUga/
         XG0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792451896; x=1793056696; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xkEO/OSiRmfTcfnZn00ylSAwEOQz293NLx30J9yMRbI=;
        b=lXSTaDUMPxunqT4NG8XOu+6a4OArT7pDWEU93VGCHzg1SUOAWgq/AmOkvPZ3aWJjoE
         cwCm+bFLjJNw+1X6WCGZIwHMMve1j0ZTHgmSFGSnYMVvRX/GQ7rp5vwQjsw9MouTPbUP
         NDOCW5Oeeu7hEi8H4+OHFU5jWndcCD90gzXO2MltTiz6vQE/tsZpX+P4mw9qBLVAy5d/
         A28hrIIKE0NAix8sx6oabnORuMi4RxV6km6Dz7iL4jW3qQzf6OGFfYrGi4vMmOhPiyi4
         WqTpk2bsF9gC5zLdti+hAQ0R4DqeA0U0Fk2lCMo7++axBH8mFnEvVRw8jO0qZpA1cKX3
         1wYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792451896; x=1793056696;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xkEO/OSiRmfTcfnZn00ylSAwEOQz293NLx30J9yMRbI=;
        b=uXvlcQRcLuaQReGGWIA6h07RDSzxZatwnpS4LTI4xw5Fbm8sI3+8uZdkPO8IAb68VW
         Q5/hm5q9xxU1RSNQDMgUpw7ndMxpJwtVBgddxWl/99TcvQyKl8010tVKW6nSYua2p43m
         3HTe9gB7HMIP9EPsqs07/PgYMOWF60OdJnD9SfJnDfv1J8Czxgir0uGN95ZHIkUvRX6t
         4E0CgEaqW90sv30aUpcnHduNyZ/GDasxQyeAkohvrlQiHaxz2w8Kma4aIVQM/DaFh6SX
         WfCqsz1iVGbJdr45+0k+IJbQ+s4M02uCX09ZnT3TjGKb25/D1/fNc5pHsC7JFHdDCq4Z
         XgoA==
X-Forwarded-Encrypted: i=1; AKwUvBwdst5XXQM99J2fDxZPFEv6QklXQcATF5hGRXXP9j9qAcbam78BTAbQmweGPuUPxR5nXZ6vs92HGAEwAapKDLeS@vger.kernel.org
X-Gm-Message-State: AFq9FYKw5GsN2tPTE/z58T5JY7AVwIz7ly7Fk/2EXqoH4ZQlsuQmOS5g
	6ZofDF8AUKG6m1+lgry4p4e7xZLepWZPOfNYcLknU3JzbDLte6bOz3LKEel0gku2SfBcj5+0rfe
	tKUaFhpZp87nOGgb+hWFC7zzxJ3NUw+EtG7wuP9l2
X-Gm-Gg: AYBFou343EVv24SplwpWA3LRGaIreSFnbTigZRGvv3shymu07MrKoyxeM8+DpmkS6U0
	Vw0/DB201k4I+alicAdrFQ8ftyRp21mgkETs4Ibxw/YigruaBkFv1jLpIKmCF3ZSnWmoESjmnsC
	crzeDgPlbUbGptuL5bTM+zi9loNk8ahwmYj0vi9fw3KlHlCfINNkEFAwN1RE5FKlyJAd5wk/ub6
	TmMRch04u1X1RINthlHgPeG1R0QDFIqW5XT/qOVAmmkDbKa3YrjaH97iNczFQFAtIdnBuwKdqNJ
	d4aP9k0pJrQPnTsSFdfyRhrTZNGrYrr/G8wDRG7NTsMG6al1ZPN2J8QfwZrNWZDeZsewFjqaA8t
	5UQIhdHsLOMoRbQPIF8bvySE3+PbBnXkno5pHEejKHqZYK8+JXtUenlP7yg==
X-Received: by 2002:a05:622a:418c:b0:52f:9ed4:8d76 with SMTP id
 d75a77b69052e-53688361cc0mr3730081cf.14.1792451895603; Mon, 19 Oct 2026
 16:18:15 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019164241.403644-1-bwicaksono@nvidia.com> <20261019164241.403644-5-bwicaksono@nvidia.com>
In-Reply-To: <20261019164241.403644-5-bwicaksono@nvidia.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 19 Oct 2026 16:18:02 -0700
X-Gm-Features: AclHuK-P4jTEpdJSRDgE-1GK0BbwVAkaLE7mt8LMQ_UZz4JJYrKoVTt4WXDObg8
Message-ID: <CAP-5=fWucvdYefDOL3Vn=O=YUPEXE+tngDDfPLv-T5i3WkCJVA@mail.gmail.com>
Subject: Re: [PATCH 4/6] perf jevents: Add support for NVIDIA Tegra410
 PCIE-TGT PMU aliasing
To: Besar Wicaksono <bwicaksono@nvidia.com>
Cc: acme@kernel.org, namhyung@kernel.org, linux-tegra@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, vsethi@nvidia.com, rwiley@nvidia.com, 
	skelley@nvidia.com, mochs@nvidia.com, rajjoshi@nvidia.com, treding@nvidia.com, 
	jonathanh@nvidia.com, john.garry@linux.dev, will@kernel.org, 
	james.clark@linaro.org, mike.leach@arm.com, leo.yan@linux.dev, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, ctshao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 9:45=E2=80=AFAM Besar Wicaksono <bwicaksono@nvidia.=
com> wrote:
>
> Add alias support for NVIDIA Tegra410 PCIE-TGT PMU events and metrics.
>
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
> ---
>  .../nvidia/t410/sys/uncore-pcie_tgt.json      | 93 +++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/unco=
re-pcie_tgt.json
>
> diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-pcie=
_tgt.json b/tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-pcie_tg=
t.json
> new file mode 100644
> index 000000000000..74786fc3d578
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-pcie_tgt.js=
on
> @@ -0,0 +1,93 @@
> +[
> +    {
> +        "EventCode": "0x4",
> +        "EventName": "PCIE_TGT_CYCLES",
> +        "BriefDescription": "Counts cycles at the PCIe interface to the =
Tegra SoC data fabric.",
> +        "PublicDescription": "Counts cycles at the PCIe interface to the=
 Tegra SoC data fabric.",
> +        "Compat": "1070036b",
> +        "Unit": "nvidia_pcie_tgt_pmu_,rc_"

It looks like the PMU names are broken because of the _rc_ in their names:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/perf/arm_cspmu/nvidia_cspmu.c#n901
```
   .name_pattern =3D "nvidia_pcie_pmu_%u_rc_%u",
```
The convention is for either a numeric (preferable) or hexadecimal suffix:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/ABI/testing/sysfs-bus-event_source-devices
Extra information about the PMU belongs in a caps file.

By definition nothing can work with wildcard matching using the
existing PMU name, so please rename it. If a new suffix convention is
necessary then  you should update the ABI and perf tool suffix
matching logic like pmu_name_len_no_suffix:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/perf/util/pmus.c#n65

Thanks,
Ian Rogers

>
> +    },
> +    {
> +        "EventCode": "0x2",
> +        "EventName": "PCIE_TGT_RD_REQ",
> +        "BriefDescription": "Counts read requests from any source to PCI=
e BAR or CXL HDM ranges under this PCIe root complex.",
> +        "PublicDescription": "Counts read requests from any source to PC=
Ie BAR or CXL HDM ranges under this PCIe root complex, where the target res=
ponds with data. Request size can be from 1 to 256 bytes. Filters: dst_rp_m=
ask selects PCIe BAR traffic to root ports (bit n =3D root port n). dst_add=
r_en with dst_addr_base and dst_addr_mask selects PCIe BAR or CXL HDM addre=
sses that equal the base in the mask's set bits. If both dst_rp_mask and th=
e address filter are set, a request matching either is counted. With no fil=
ter, PCIe BAR traffic to all root ports is counted.",
> +        "Compat": "1070036b",
> +        "Unit": "nvidia_pcie_tgt_pmu_,rc_"
> +    },
> +    {
> +        "EventCode": "0x3",
> +        "EventName": "PCIE_TGT_WR_REQ",
> +        "BriefDescription": "Counts write requests from any source to PC=
Ie BAR or CXL HDM ranges under this PCIe root complex.",
> +        "PublicDescription": "Counts write requests from any source to P=
CIe BAR or CXL HDM ranges under this PCIe root complex, where the source se=
nds data. Request size can be from 1 to 256 bytes. Filters: dst_rp_mask sel=
ects PCIe BAR traffic to root ports (bit n =3D root port n). dst_addr_en wi=
th dst_addr_base and dst_addr_mask selects PCIe BAR or CXL HDM addresses th=
at equal the base in the mask's set bits. If both dst_rp_mask and the addre=
ss filter are set, a request matching either is counted. With no filter, PC=
Ie BAR traffic to all root ports is counted.",
> +        "Compat": "1070036b",
> +        "Unit": "nvidia_pcie_tgt_pmu_,rc_"
> +    },
> +    {
> +        "EventCode": "0x0",
> +        "EventName": "PCIE_TGT_RD_BYTES",
> +        "BriefDescription": "Counts bytes transferred by the read reques=
ts counted by PCIE_TGT_RD_REQ.",
> +        "PublicDescription": "Counts bytes transferred by the read reque=
sts counted by PCIE_TGT_RD_REQ. Destination filters work as described for P=
CIE_TGT_RD_REQ.",
> +        "Compat": "1070036b",
> +        "Unit": "nvidia_pcie_tgt_pmu_,rc_"
> +    },
> +    {
> +        "EventCode": "0x1",
> +        "EventName": "PCIE_TGT_WR_BYTES",
> +        "BriefDescription": "Counts bytes transferred by the write reque=
sts counted by PCIE_TGT_WR_REQ.",
> +        "PublicDescription": "Counts bytes transferred by the write requ=
ests counted by PCIE_TGT_WR_REQ. Destination filters work as described for =
PCIE_TGT_WR_REQ.",
> +        "Compat": "1070036b",
> +        "Unit": "nvidia_pcie_tgt_pmu_,rc_"
> +    },
> +    {
> +        "MetricName": "pcie_tgt_freq",
> +        "MetricGroup": "PCIE_TGT_Frequency",
> +        "MetricConstraint": "NO_GROUP_EVENTS",
> +        "MetricExpr": "(PCIE_TGT_CYCLES / aggr_nr(PCIE_TGT_CYCLES)) / 1e=
9 / duration_time",
> +        "ScaleUnit": "1GHz",
> +        "BriefDescription": "Frequency of the cycles at the PCIe interfa=
ce to the Tegra SoC data fabric.",
> +        "PublicDescription": "Average frequency of the cycles at the PCI=
e interface to the Tegra SoC data fabric over the measurement interval.",
> +        "Compat": "1070036b",
> +        "Unit": "nvidia_pcie_tgt_pmu_,rc_"
> +    },
> +    {
> +        "MetricName": "pcie_tgt_avg_rd_bandwidth_to_all_dst",
> +        "MetricGroup": "PCIE_TGT_Bandwidth;PCIE_TGT_BW_PCIE_BAR_CXL_HDM"=
,
> +        "MetricExpr": "PCIE_TGT_RD_BYTES@dst_addr_en=3D1,dst_addr_base=
=3D0,dst_addr_mask=3D0@ / 1e6 / duration_time",
> +        "ScaleUnit": "1MB/s",
> +        "BriefDescription": "Average read bandwidth to all PCIe BAR and =
CXL HDM ranges under this PCIe root complex.",
> +        "PublicDescription": "Average read bandwidth of requests from an=
y source to all PCIe BAR and CXL HDM ranges under this PCIe root complex.",
> +        "Compat": "1070036b",
> +        "Unit": "nvidia_pcie_tgt_pmu_,rc_"
> +    },
> +    {
> +        "MetricName": "pcie_tgt_avg_wr_bandwidth_to_all_dst",
> +        "MetricGroup": "PCIE_TGT_Bandwidth;PCIE_TGT_BW_PCIE_BAR_CXL_HDM"=
,
> +        "MetricExpr": "PCIE_TGT_WR_BYTES@dst_addr_en=3D1,dst_addr_base=
=3D0,dst_addr_mask=3D0@ / 1e6 / duration_time",
> +        "ScaleUnit": "1MB/s",
> +        "BriefDescription": "Average write bandwidth to all PCIe BAR and=
 CXL HDM ranges under this PCIe root complex.",
> +        "PublicDescription": "Average write bandwidth of requests from a=
ny source to all PCIe BAR and CXL HDM ranges under this PCIe root complex."=
,
> +        "Compat": "1070036b",
> +        "Unit": "nvidia_pcie_tgt_pmu_,rc_"
> +    },
> +    {
> +        "MetricName": "pcie_tgt_avg_rd_bandwidth_to_pcie_bar",
> +        "MetricGroup": "PCIE_TGT_Bandwidth;PCIE_TGT_BW_PCIE_BAR",
> +        "MetricExpr": "PCIE_TGT_RD_BYTES / 1e6 / duration_time",
> +        "ScaleUnit": "1MB/s",
> +        "BriefDescription": "Average read bandwidth of PCIe BAR traffic =
to all root ports under this PCIe root complex.",
> +        "PublicDescription": "Average read bandwidth of PCIe BAR traffic=
 from any source to all root ports under this PCIe root complex.",
> +        "Compat": "1070036b",
> +        "Unit": "nvidia_pcie_tgt_pmu_,rc_"
> +    },
> +    {
> +        "MetricName": "pcie_tgt_avg_wr_bandwidth_to_pcie_bar",
> +        "MetricGroup": "PCIE_TGT_Bandwidth;PCIE_TGT_BW_PCIE_BAR",
> +        "MetricExpr": "PCIE_TGT_WR_BYTES / 1e6 / duration_time",
> +        "ScaleUnit": "1MB/s",
> +        "BriefDescription": "Average write bandwidth of PCIe BAR traffic=
 to all root ports under this PCIe root complex.",
> +        "PublicDescription": "Average write bandwidth of PCIe BAR traffi=
c from any source to all root ports under this PCIe root complex.",
> +        "Compat": "1070036b",
> +        "Unit": "nvidia_pcie_tgt_pmu_,rc_"
> +    }
> +]
> --
> 2.43.0
>
