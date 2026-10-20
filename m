Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792537982;
	b=XtFxIuNMRfkPUpaVoSJOe2Uwpau4T7ZeN1CAMBQc0vcZc1/zNujNrin/D2TK8oSewQBo
	 YJjOqps4Aei8a/wnyR1dcW87o355qv36GwmRGG6EvYdDMRsdgOU4Skh3jiTAyg/ckGSsp
	 NmP+T1BnBkV2Aheh9XEkw9TCRePEkKoT6DLpn9LBcFzSQHdG0X/rnYgwG3D2U+0X8sA7l
	 3cBmOgsF4fp62294pdB2w+20NpdkFdhp4O/h2TYHucIUpGvm6BC/Z0+27WPG6t7+V3sHw
	 jsDNhAg3mxLhD+qHX+X9KWnaqtMQoZKrPAxZPbOd1k8sbY/Dbm2i3Z+0bcY8WI8o8iw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792537982;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dh/bnyT0JBbnLv1h/bnk9lroIsEMrvUJ0+PR9gCLBfQ=;
	b=MJpx5ieaqeLxZQ+4ujhlSQL5/EpLkqlE/Bzrq3m7D1NIhHSJKkwaryHyC7MK8PEXR3Bl
	 A/pd1rpbJ6BE/eWHN4sHMue8h2WMfeKhMn4cvMyGEJLOd7tiUTjUsz+epwlzVRwL/xV28
	 l1kPVVjkRVYirU+WgaUnERNzSh0fRDa35tz2IJLSVeGatrKgXQtRWCYSMaHLfRWefWFkC
	 eMatErQT1BTUSCTK10kDDWY/WpcxXuF7fFPHGV7qeNB9H1GWJhfW/5DXCl2L04OvCozok
	 TFdaovO9E/J1IQyyXntLBTrI6e4TpnDAYqzM2gTTnBcxFsuWMZFzWzenXF/Qd3qrF9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=nuxs8QOm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA10606A32E
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 23:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAA10606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=nuxs8QOm
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35829219da8so1542222eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 16:13:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792537981; cv=none;
        d=google.com; s=arc-20260327;
        b=nWN/lEVS+YHg/+lGgvRZHkwR235z1zBqnr8rOexlP8OP8sRzT8jyor4ZsnNMuKGWhb
         p2JUzVXQqgGWe7Io5hCbIYepTnaY4ULqeFbOADE2w7eD/xmmoZQFLwgTEA6Av5Oppqc9
         WLDE1Iq/8ClRd3MdK9a4sz7Hqjm60NJpgJx7+eyjCFyifzMQlpYtDIlvl2Ge11lKRXzA
         R7PviQ32Z1J7nD5iMUIQ+3zJwAqIp+ULdOO3xPHRqTBvsrXDciwetevCQyRv2URBmk5e
         VNkuaJHtDxQygQ/ViAdQgnr37cbDUxVuHjzJvENkhFYFIBJS6AxK6Hmfu6PH4EGPvSfW
         ySiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dh/bnyT0JBbnLv1h/bnk9lroIsEMrvUJ0+PR9gCLBfQ=;
        fh=6etGqCo8zcVO1MqQ9TQytAoqU7JVrUbgkbQlI2ZKC4k=;
        b=MSDHm0KVjtcllmthh1tBSmMlBdzX9DqwIqBTbjY1MEkT7TJ+krwrsddsdX82jc7PdQ
         +p2Pp+DUWFJp4BwEBZHm2JRz7yPVvQbv3m946b0XSjtmcYHC0RQ5YDHBKRyz8bhp5ZZ9
         O1qmUfVgAamlDtknmUv1jjLfSj1KOcnWyvser535qROTZIzeHFY/WEhvkA0xJa6j3uBT
         YAOQioDUS/3B9fcq8x+3zcJHCH9StYkCqeiPDoJmS8qZ/0UPQnGz3GkQxrDwlDNLmwoU
         YXEfq9tumLJYUIlTchMUQAai+O1hli8W8ZAuULLb+5LfaEWC4eVVJx0U4BqC3SRPbw1Y
         1npQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792537981; x=1793142781; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dh/bnyT0JBbnLv1h/bnk9lroIsEMrvUJ0+PR9gCLBfQ=;
        b=nuxs8QOmReUEh7t0OlmOOhq7K15+VDqy7drqi8jkgIV/oe4HXWDYTV4pCOjalCN5MI
         FZm0sHfPVwq34qBL5JnLiYFfT4EE23mpQt93upGPnvILC0E990BOUxENCnEFiTEoVnXa
         oHbWq9BrUAEClrlyEpxouWSsvNfY6IN6ZRgHsANIcHrkRosEho6Zh1H9PuKW+/3aY0Ob
         qDfGZ8uuivEEs10xB50lecXfJ/zclWJFvS3JdKD7pITO9mSShT69qxF/Gd3GMNzKAEge
         NNE/iizphuAiOZVK5oj+Uv3kco0FmSHjMzlUB9Dgwx7SfAcKLvpabyI0rtgJNymA0OFH
         waVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792537981; x=1793142781;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dh/bnyT0JBbnLv1h/bnk9lroIsEMrvUJ0+PR9gCLBfQ=;
        b=ziA0gQsSeuRNDWVvicn6a9wd8DxbMlfthIkV149xheRYVa4FUKvNPbmBh+TY/qQfsA
         pnj9pXDse4UqVoG7VGIWPKNe1fSegRMfOBQ8zkiSbXnYCI0eU9VF5oNjWt8RhuR44nRQ
         v13eHTPbfsOvrXfNkx1j9NM/85MMp3CDlQ7JOJt5WaKLqPA4RvxulO+gsGX+r/oqNOID
         EguMJ2EnRJPKyUg6oa6DSfOlfgHilzhkn01mUSHxheSZiiQTzyIFynXw4E6n3ppuuBpE
         03mubwU1Aq+WzJY3qyTjv41xbztFmi/bLVIfHS05lzP1WwPIPHijt7Vg0XWi1eyAkeyr
         09ig==
X-Forwarded-Encrypted: i=1; AKwUvBzc9m+zCeB73LilUMt0zK3ReSbXXBB6D3MQF+2GYksVtniM7oAAwCfdO89B2VWpsrh1SHBu0MIYftI12ySPOjI9@vger.kernel.org
X-Gm-Message-State: AFq9FYLzQIP3LL6OGGiqCmy01Lt0sNx6GW8765Xs1b6mOMc9YOJov6Ff
	GNV2xR5y1fMfVxyR1szK7ori2C3KO1PQbmQZJYC1uLaYvBJIkgeVBKu54S9yCX8HEtJ+Xg/E1nZ
	qTYcyP+ZiDJkffaNqYXhNU1ZmoL8mLygUEsJofSgo
X-Gm-Gg: AYBFou3QoRb0a0x+dda3T5pQRo/hsuItRJElvMFitz14wkN2VVq5IiVSFmVlIyh+42v
	11n/D4RfVc1KCVzP6zIi0K2Y//MMZceVyz/Rf0uATWMOGCfPKiRiY8DSKO+CDT5BbH6ygY858Nb
	kFbj+4XP9YkJHzt05rzsVMxAhU04jofIe82Yl5p/A3460+X3k1ZFfNtCCPUTNpbExpphgnyLHV7
	pZkmD3st5tP61n83k595P0IJcJkvzi9a4R4yC1yHEslZVbI2RCWqeM8HkSREChyRKrEp4X9NyOh
	1weAcWplP4djYDg1znzzedKjAInvtre16iwPwZZDn/QDau2C2Gs0rIRy+2XFp1RGGFgrC4zudoB
	bVaYIx3iK0SzFlFPKvy0ydmnWNfg24rJGJu31/wwFcb/wW1vsPHgquo4u9lBSHiPa5uPchPvEVK
	C9SoHHnXTZ6D8S
X-Received: by 2002:a05:701b:2044:20b0:183:840:1dad with SMTP id
 a92af1059eb24-18dbed50064mr4482643c88.14.1792537980138; Tue, 20 Oct 2026
 16:13:00 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019164241.403644-1-bwicaksono@nvidia.com>
 <20261019164241.403644-5-bwicaksono@nvidia.com> <CAP-5=fWucvdYefDOL3Vn=O=YUPEXE+tngDDfPLv-T5i3WkCJVA@mail.gmail.com>
 <SA1PR12MB67736E99ABA9C126A0E1981EA0672@SA1PR12MB6773.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB67736E99ABA9C126A0E1981EA0672@SA1PR12MB6773.namprd12.prod.outlook.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Tue, 20 Oct 2026 16:12:23 -0700
X-Gm-Features: AclHuK_aNU9kdVSWftIMnRxZ_SwJiwDfg6lcnasTAbePSdlmJHCQQpEbZ_yaUCY
Message-ID: <CAJpZYjVxpQNCjvhK3mmaOiiG8sgJr4EdUwNCn+gVLH=F6Xh0Kg@mail.gmail.com>
Subject: Re: [PATCH 4/6] perf jevents: Add support for NVIDIA Tegra410
 PCIE-TGT PMU aliasing
To: Besar Wicaksono <bwicaksono@nvidia.com>
Cc: Ian Rogers <irogers@google.com>, "acme@kernel.org" <acme@kernel.org>, 
	"namhyung@kernel.org" <namhyung@kernel.org>, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>, 
	Rich Wiley <rwiley@nvidia.com>, Sean Kelley <skelley@nvidia.com>, Matt Ochs <mochs@nvidia.com>, 
	Raj Joshi <rajjoshi@nvidia.com>, Thierry Reding <treding@nvidia.com>, 
	Jon Hunter <jonathanh@nvidia.com>, "john.garry@linux.dev" <john.garry@linux.dev>, 
	"will@kernel.org" <will@kernel.org>, "james.clark@linaro.org" <james.clark@linaro.org>, 
	"mike.leach@arm.com" <mike.leach@arm.com>, "leo.yan@linux.dev" <leo.yan@linux.dev>, 
	"mark.rutland@arm.com" <mark.rutland@arm.com>, 
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, "jolsa@kernel.org" <jolsa@kernel.org>, 
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 3:01=E2=80=AFPM Besar Wicaksono <bwicaksono@nvidia.=
com> wrote:
>
>
>
> > -----Original Message-----
> > From: Ian Rogers <irogers@google.com>
> > Sent: Monday, October 19, 2026 11:18 PM
> > To: Besar Wicaksono <bwicaksono@nvidia.com>
> > Cc: acme@kernel.org; namhyung@kernel.org; linux-tegra@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-perf-users@vger.kernel.org;
> > linux-kernel@vger.kernel.org; Vikram Sethi <vsethi@nvidia.com>; Rich Wi=
ley
> > <rwiley@nvidia.com>; Sean Kelley <skelley@nvidia.com>; Matt Ochs
> > <mochs@nvidia.com>; Raj Joshi <rajjoshi@nvidia.com>; Thierry Reding
> > <treding@nvidia.com>; Jon Hunter <jonathanh@nvidia.com>;
> > john.garry@linux.dev; will@kernel.org; james.clark@linaro.org;
> > mike.leach@arm.com; leo.yan@linux.dev; mark.rutland@arm.com;
> > alexander.shishkin@linux.intel.com; jolsa@kernel.org;
> > adrian.hunter@intel.com; ctshao@google.com
> > Subject: Re: [PATCH 4/6] perf jevents: Add support for NVIDIA Tegra410
> > PCIE-TGT PMU aliasing
> >
> > External email: Use caution opening links or attachments
> >
> >
> > On Mon, Oct 19, 2026 at 9:45=E2=80=AFAM Besar Wicaksono
> > <bwicaksono@nvidia.com> wrote:
> > >
> > > Add alias support for NVIDIA Tegra410 PCIE-TGT PMU events and metrics=
.
> > >
> > > Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
> > > ---
> > >  .../nvidia/t410/sys/uncore-pcie_tgt.json      | 93 +++++++++++++++++=
++
> > >  1 file changed, 93 insertions(+)
> > >  create mode 100644 tools/perf/pmu-
> > events/arch/arm64/nvidia/t410/sys/uncore-pcie_tgt.json
> > >
> > > diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-
> > pcie_tgt.json b/tools/perf/pmu-
> > events/arch/arm64/nvidia/t410/sys/uncore-pcie_tgt.json
> > > new file mode 100644
> > > index 000000000000..74786fc3d578
> > > --- /dev/null
> > > +++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-
> > pcie_tgt.json
> > > @@ -0,0 +1,93 @@
> > > +[
> > > +    {
> > > +        "EventCode": "0x4",
> > > +        "EventName": "PCIE_TGT_CYCLES",
> > > +        "BriefDescription": "Counts cycles at the PCIe interface to =
the Tegra
> > SoC data fabric.",
> > > +        "PublicDescription": "Counts cycles at the PCIe interface to=
 the Tegra
> > SoC data fabric.",
> > > +        "Compat": "1070036b",
> > > +        "Unit": "nvidia_pcie_tgt_pmu_,rc_"
> >
> > It looks like the PMU names are broken because of the _rc_ in their nam=
es:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree
> > /drivers/perf/arm_cspmu/nvidia_cspmu.c#n901
> > ```
> >    .name_pattern =3D "nvidia_pcie_pmu_%u_rc_%u",
> > ```
> > The convention is for either a numeric (preferable) or hexadecimal suff=
ix:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree
> > /Documentation/ABI/testing/sysfs-bus-event_source-devices
> > Extra information about the PMU belongs in a caps file.
> >
>
> Hi Ian,
>
> Thanks for the pointers.
>
> My interpretation is the ABI document doesn=E2=80=99t prevent driver from=
 naming
> the PMU with multiple numbering format. Other PMUs already did this,
> e.g. HiSilicon hisi_sccl<sccl>_ddrc<n>, Arm NI arm_ni_<ni>_cd_<cd> and
> Qualcomm l3cache_<x>_<y>.

Hi Besar,

The ABI only defines a single _<num> suffix, and that is all perf
supports. perf treats `nvidia_pcie_pmu_0_rc_*` and
`nvidia_pcie_pmu_1_rc_*` as two different PMUs, which is the root
cause of the reporting issues you listed. The hisi_sccl, arm_ni and
Qualcomm PMUs have the same problem.

We can always add a new naming format to the ABI and perf, but each
new format makes PMU name handling harder to maintain.

A PMU per rc, for example, `nvidia_pcie_pmu_<rc>` with one cpu per
socket in its `cpumask` (like Intel uncore_imc_<n>), works with perf
as is.

Thanks,
CT

>
> > By definition nothing can work with wildcard matching using the
> > existing PMU name, so please rename it. If a new suffix convention is
> > necessary then  you should update the ABI and perf tool suffix
> > matching logic like pmu_name_len_no_suffix:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree
> > /tools/perf/util/pmus.c#n65
> >
>
> The JSON "Unit" attribute takes a comma-separated form:
> "nvidia_pcie_pmu_,rc_", like HiSilicon's "hisi_sccl,ddrc", which
> perf_pmu__match_wildcard_uncore() matches against "socketX_pmunameY"
> names. The issues seem to be on the reporting side. The counting looks ok=
.
> I guess JSON "Unit" matching logic is not applied everywhere in perf.
>
> For example below is the counting from my 2-socket machine.
>
> Test workload: read 4 GiB from an NVMe on socket 0 RC 0 and 8 GiB from an=
 NVMe
> on socket 1 RC 0, in parallel (dd ... of=3D/dev/null iflag=3Ddirect).
>
> Counting is correct with the wildcards:
>
> $ perf stat -a -e 'nvidia_pcie_pmu_0_rc*/PCIE_WR_BYTES/,nvidia_pcie_pmu_1=
_rc*/PCIE_WR_BYTES/' -- <workload>
>      4,362,223,228      nvidia_pcie_pmu_0_rc*/PCIE_WR_BYTES/
>      8,623,751,168      nvidia_pcie_pmu_1_rc*/PCIE_WR_BYTES/
>
> $ perf stat -a --per-socket -e 'nvidia_pcie_pmu_*_rc_0/PCIE_WR_BYTES/' --=
 <workload>
> S268435456    1      4,362,207,232      nvidia_pcie_pmu_0_rc_0/nvidia_pci=
e_pmu_*_rc_0,PCIE_WR_BYTES/
> S285212672    1      8,724,414,784      nvidia_pcie_pmu_1_rc_0/nvidia_pci=
e_pmu_*_rc_0,PCIE_WR_BYTES/
>
> The reporting is where it goes wrong:
>
> 1) RC 0 of all sockets is not merged into one line, and the wildcard
>      ends up in the event name:
>
> $ perf stat -a -e 'nvidia_pcie_pmu_*_rc_0/PCIE_WR_BYTES/' -- <workload>
>      4,311,875,584      nvidia_pcie_pmu_0_rc_0/nvidia_pcie_pmu_*_rc_0,PCI=
E_WR_BYTES/
>      8,623,751,168      nvidia_pcie_pmu_1_rc_0/nvidia_pcie_pmu_*_rc_0,PCI=
E_WR_BYTES/
>
> 2) The json event is split per socket, and each line is labelled with
>       RC 0 although it is the sum of all RCs of that socket:
>
> $ perf stat -a -e PCIE_WR_BYTES -- <workload>
>      4,311,880,848      nvidia_pcie_pmu_0_rc_0/PCIE_WR_BYTES/
>      8,724,414,784      nvidia_pcie_pmu_1_rc_0/PCIE_WR_BYTES/
>
> 3) The metric is computed per socket, instead of total. With --metric-onl=
y both values
>      end up under one header, and the reader can't tell which socket is
>      which:
>
> $ perf stat -a -M pcie_avg_wr_bandwidth_to_all_dst --metric-only -- <work=
load>
>  MB/s  pcie_avg_wr_bandwidth_to_all_dst
>                                 3113.5                                622=
7.0
>
> 4) With --per-socket, each row shows both copies: the other socket's
>    copy prints nan, and socket 1's counters is 0 instead of 6:
>
> $ perf stat -a --per-socket -M pcie_avg_wr_bandwidth_to_all_dst --metric-=
only -- <workload>
>        MB/s  pcie_avg_wr_bandwidth_to_all_dst
> S268435456    6                                 3127.5                   =
                nan
> S285212672    0                                    nan                   =
             6182.8
>
> $ perf stat -a --per-socket -j -M pcie_avg_wr_bandwidth_to_all_dst --metr=
ic-only -- <workload>
> {"socket" : "S268435456", "counters" : 6, "MB/s  pcie_avg_wr_bandwidth_to=
_all_dst" : "3087.8", "MB/s  pcie_avg_wr_bandwidth_to_all_dst" : "none"}
> {"socket" : "S285212672", "counters" : 0, "MB/s  pcie_avg_wr_bandwidth_to=
_all_dst" : "none", "MB/s  pcie_avg_wr_bandwidth_to_all_dst" : "6247.8"}
>
> All of these, I think, come from perf treating nvidia_pcie_pmu_0_rc_* and
> nvidia_pcie_pmu_1_rc_* as two different PMUs instead of one PMU, i.e
> nvidia_pcie_pmu.
>
> I will investigate further and see if I can come up with a perf patch to =
fix this.
>
> Regards,
> Besar
>
> > Thanks,
> > Ian Rogers
> >
>

On Tue, Oct 20, 2026 at 3:01=E2=80=AFPM Besar Wicaksono <bwicaksono@nvidia.=
com> wrote:
>
>
>
> > -----Original Message-----
> > From: Ian Rogers <irogers@google.com>
> > Sent: Monday, October 19, 2026 11:18 PM
> > To: Besar Wicaksono <bwicaksono@nvidia.com>
> > Cc: acme@kernel.org; namhyung@kernel.org; linux-tegra@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-perf-users@vger.kernel.org;
> > linux-kernel@vger.kernel.org; Vikram Sethi <vsethi@nvidia.com>; Rich Wi=
ley
> > <rwiley@nvidia.com>; Sean Kelley <skelley@nvidia.com>; Matt Ochs
> > <mochs@nvidia.com>; Raj Joshi <rajjoshi@nvidia.com>; Thierry Reding
> > <treding@nvidia.com>; Jon Hunter <jonathanh@nvidia.com>;
> > john.garry@linux.dev; will@kernel.org; james.clark@linaro.org;
> > mike.leach@arm.com; leo.yan@linux.dev; mark.rutland@arm.com;
> > alexander.shishkin@linux.intel.com; jolsa@kernel.org;
> > adrian.hunter@intel.com; ctshao@google.com
> > Subject: Re: [PATCH 4/6] perf jevents: Add support for NVIDIA Tegra410
> > PCIE-TGT PMU aliasing
> >
> > External email: Use caution opening links or attachments
> >
> >
> > On Mon, Oct 19, 2026 at 9:45=E2=80=AFAM Besar Wicaksono
> > <bwicaksono@nvidia.com> wrote:
> > >
> > > Add alias support for NVIDIA Tegra410 PCIE-TGT PMU events and metrics=
.
> > >
> > > Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
> > > ---
> > >  .../nvidia/t410/sys/uncore-pcie_tgt.json      | 93 +++++++++++++++++=
++
> > >  1 file changed, 93 insertions(+)
> > >  create mode 100644 tools/perf/pmu-
> > events/arch/arm64/nvidia/t410/sys/uncore-pcie_tgt.json
> > >
> > > diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-
> > pcie_tgt.json b/tools/perf/pmu-
> > events/arch/arm64/nvidia/t410/sys/uncore-pcie_tgt.json
> > > new file mode 100644
> > > index 000000000000..74786fc3d578
> > > --- /dev/null
> > > +++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-
> > pcie_tgt.json
> > > @@ -0,0 +1,93 @@
> > > +[
> > > +    {
> > > +        "EventCode": "0x4",
> > > +        "EventName": "PCIE_TGT_CYCLES",
> > > +        "BriefDescription": "Counts cycles at the PCIe interface to =
the Tegra
> > SoC data fabric.",
> > > +        "PublicDescription": "Counts cycles at the PCIe interface to=
 the Tegra
> > SoC data fabric.",
> > > +        "Compat": "1070036b",
> > > +        "Unit": "nvidia_pcie_tgt_pmu_,rc_"
> >
> > It looks like the PMU names are broken because of the _rc_ in their nam=
es:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree
> > /drivers/perf/arm_cspmu/nvidia_cspmu.c#n901
> > ```
> >    .name_pattern =3D "nvidia_pcie_pmu_%u_rc_%u",
> > ```
> > The convention is for either a numeric (preferable) or hexadecimal suff=
ix:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree
> > /Documentation/ABI/testing/sysfs-bus-event_source-devices
> > Extra information about the PMU belongs in a caps file.
> >
>
> Hi Ian,
>
> Thanks for the pointers.
>
> My interpretation is the ABI document doesn=E2=80=99t prevent driver from=
 naming
> the PMU with multiple numbering format. Other PMUs already did this,
> e.g. HiSilicon hisi_sccl<sccl>_ddrc<n>, Arm NI arm_ni_<ni>_cd_<cd> and
> Qualcomm l3cache_<x>_<y>.
>
> > By definition nothing can work with wildcard matching using the
> > existing PMU name, so please rename it. If a new suffix convention is
> > necessary then  you should update the ABI and perf tool suffix
> > matching logic like pmu_name_len_no_suffix:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree
> > /tools/perf/util/pmus.c#n65
> >
>
> The JSON "Unit" attribute takes a comma-separated form:
> "nvidia_pcie_pmu_,rc_", like HiSilicon's "hisi_sccl,ddrc", which
> perf_pmu__match_wildcard_uncore() matches against "socketX_pmunameY"
> names. The issues seem to be on the reporting side. The counting looks ok=
.
> I guess JSON "Unit" matching logic is not applied everywhere in perf.
>
> For example below is the counting from my 2-socket machine.
>
> Test workload: read 4 GiB from an NVMe on socket 0 RC 0 and 8 GiB from an=
 NVMe
> on socket 1 RC 0, in parallel (dd ... of=3D/dev/null iflag=3Ddirect).
>
> Counting is correct with the wildcards:
>
> $ perf stat -a -e 'nvidia_pcie_pmu_0_rc*/PCIE_WR_BYTES/,nvidia_pcie_pmu_1=
_rc*/PCIE_WR_BYTES/' -- <workload>
>      4,362,223,228      nvidia_pcie_pmu_0_rc*/PCIE_WR_BYTES/
>      8,623,751,168      nvidia_pcie_pmu_1_rc*/PCIE_WR_BYTES/
>
> $ perf stat -a --per-socket -e 'nvidia_pcie_pmu_*_rc_0/PCIE_WR_BYTES/' --=
 <workload>
> S268435456    1      4,362,207,232      nvidia_pcie_pmu_0_rc_0/nvidia_pci=
e_pmu_*_rc_0,PCIE_WR_BYTES/
> S285212672    1      8,724,414,784      nvidia_pcie_pmu_1_rc_0/nvidia_pci=
e_pmu_*_rc_0,PCIE_WR_BYTES/
>
> The reporting is where it goes wrong:
>
> 1) RC 0 of all sockets is not merged into one line, and the wildcard
>      ends up in the event name:
>
> $ perf stat -a -e 'nvidia_pcie_pmu_*_rc_0/PCIE_WR_BYTES/' -- <workload>
>      4,311,875,584      nvidia_pcie_pmu_0_rc_0/nvidia_pcie_pmu_*_rc_0,PCI=
E_WR_BYTES/
>      8,623,751,168      nvidia_pcie_pmu_1_rc_0/nvidia_pcie_pmu_*_rc_0,PCI=
E_WR_BYTES/
>
> 2) The json event is split per socket, and each line is labelled with
>       RC 0 although it is the sum of all RCs of that socket:
>
> $ perf stat -a -e PCIE_WR_BYTES -- <workload>
>      4,311,880,848      nvidia_pcie_pmu_0_rc_0/PCIE_WR_BYTES/
>      8,724,414,784      nvidia_pcie_pmu_1_rc_0/PCIE_WR_BYTES/
>
> 3) The metric is computed per socket, instead of total. With --metric-onl=
y both values
>      end up under one header, and the reader can't tell which socket is
>      which:
>
> $ perf stat -a -M pcie_avg_wr_bandwidth_to_all_dst --metric-only -- <work=
load>
>  MB/s  pcie_avg_wr_bandwidth_to_all_dst
>                                 3113.5                                622=
7.0
>
> 4) With --per-socket, each row shows both copies: the other socket's
>    copy prints nan, and socket 1's counters is 0 instead of 6:
>
> $ perf stat -a --per-socket -M pcie_avg_wr_bandwidth_to_all_dst --metric-=
only -- <workload>
>        MB/s  pcie_avg_wr_bandwidth_to_all_dst
> S268435456    6                                 3127.5                   =
                nan
> S285212672    0                                    nan                   =
             6182.8
>
> $ perf stat -a --per-socket -j -M pcie_avg_wr_bandwidth_to_all_dst --metr=
ic-only -- <workload>
> {"socket" : "S268435456", "counters" : 6, "MB/s  pcie_avg_wr_bandwidth_to=
_all_dst" : "3087.8", "MB/s  pcie_avg_wr_bandwidth_to_all_dst" : "none"}
> {"socket" : "S285212672", "counters" : 0, "MB/s  pcie_avg_wr_bandwidth_to=
_all_dst" : "none", "MB/s  pcie_avg_wr_bandwidth_to_all_dst" : "6247.8"}
>
> All of these, I think, come from perf treating nvidia_pcie_pmu_0_rc_* and
> nvidia_pcie_pmu_1_rc_* as two different PMUs instead of one PMU, i.e
> nvidia_pcie_pmu.
>
> I will investigate further and see if I can come up with a perf patch to =
fix this.
>
> Regards,
> Besar
>
> > Thanks,
> > Ian Rogers
> >
>
