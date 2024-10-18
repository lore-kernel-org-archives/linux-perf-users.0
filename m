Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0F8168488
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Oct 2024 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729266438; cv=none; b=rDymJ9j/fS7aWIv7e7SxhzSe6LC1Kz7O1DHYQmSBLg6WFVnfzcJVuobEco+Qy9ZLcOCQFVlegRhecBasuZv3s7jOhaAPe498cDi+M0erey96v5en8GMGSUkMQauzxASWKThFOYRZJOX1s7KsQEBpQWDmLolQjIlm3xE/b+VoegU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729266438; c=relaxed/simple;
	bh=NpxrKemjjR0SgWnwg0mpqUlKK4EnM0TMl7/mQm4BBCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJnygLK+EJZhVp/kW3D2DMPOKF0j4wxWjQbT9CyEcvzJ1z3y/FrDF7e2wT1qFPop2KQf0tz59XwXX5LYLpujciZsGI/yl7Qf/KQMDo9Ot5JfrDloDARlM6bJKEK/l87EUjeOXoee9dvHjAI1/jgFeRCqtbNjO5dBuApJ0G/WLTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ld4DFomn; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ld4DFomn"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a3bd5a273bso236805ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Oct 2024 08:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729266435; x=1729871235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WysErSCps355iliDemzN53mNCGFer2jqjo+iuInVjOY=;
        b=Ld4DFomnhby9z0fPygPcyYv11Fk5TpAq7n+dhgzMO2MsKS6Fq2IOtlnbmygw45+tDy
         j+VGKq82PgiwfRlN/ivpXBtsu4SYGb23aMn1Ljnd6+tiwc4HGCuFlOe0B0kLdVv8CfLf
         h8LOl4dhPrx4qSEzxi3pfxFilN2EltB+H3aoZgGvoSLJ1zeO0/mqZ5252uiwTqV6bqq/
         3Df8mDPYeaHckCzwMFYiXsd6P/JxYOAc+FIoJgcNwBiWAZQRK6cAif+2fKahYJSopRAY
         QlKbS1Ho6tSDD3xpIBpibG9jwR0cbfbDyTJPeaRSmXW8uiNj0ccQpNMb/nhZ/RWmFekW
         4E6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729266435; x=1729871235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WysErSCps355iliDemzN53mNCGFer2jqjo+iuInVjOY=;
        b=F3MdRDWGU8oAqi8782CyT8w7wxJkk9iVbXQmwE/JhunsiKbJUuJNBwaYhfEUu8WWyR
         WScXV8mn84PW3ZuLOT+J9++ItDJdNeyWqDS3Iq/bESx1cziy5Jy99cq7Dsaf8+LJDDad
         qPKptFMuLp/bXw15HTxKqOfLV0ev9OX0iz+EQgqIaKZJNWZKqUpkZT0+k3efDlYZL3MR
         lNTO3IE+gzSgD1yrucia9tUY7uWvRlwgRjTYHSPv3Klvroi0N+PQtZO3SnAjnoEvHpzx
         eZxBV7XG4tuogB/eLznIw3SoncYssKzd9egzYEGYks+eWXPGhIedp0iop+yN+Eks1AfZ
         ySfw==
X-Gm-Message-State: AOJu0Yx20WygF2XUj6SdWcmIdJlQTLTEGqz8gNMu4VNQzGCzNhOlqPS8
	Lh2NONakSA3mwBze9Clihv4U91wGtebT+WY95hQuhdGPMxkvTn6UOhx9a5tmEoQ0JOmrwLiOy1G
	0BLujDIgKUUCc7JVzphhNLNeULOpxLovXC7l3
X-Google-Smtp-Source: AGHT+IHs3jHA/bYqUItcxtwG6Ap0KQUzPAbe9A13IJhaIFjl0C3aUYUdqQhnTs1R8pdGYI+MmA5X0H3vP9hIOtd1K+E=
X-Received: by 2002:a05:6e02:1566:b0:3a0:a459:8eca with SMTP id
 e9e14a558f8ab-3a3f3403171mr4613855ab.10.1729266435245; Fri, 18 Oct 2024
 08:47:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729242778.git.sandipan.das@amd.com> <e8757bb9f511907a52bc182de9395c5edec2fccf.1729242778.git.sandipan.das@amd.com>
In-Reply-To: <e8757bb9f511907a52bc182de9395c5edec2fccf.1729242778.git.sandipan.das@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 18 Oct 2024 08:47:01 -0700
Message-ID: <CAP-5=fVH0spLTv16Fs37PKQNkkPXZUcyomQ+Vjc1+NAA9GU5ow@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf vendor events amd: Add Zen 5 data fabric metrics
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, eranian@google.com, ravi.bangoria@amd.com, 
	ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 2:32=E2=80=AFAM Sandipan Das <sandipan.das@amd.com>=
 wrote:
>
> Add data fabric metrics taken from Section 2.1.16.2 "Performance
> Measurement" in the Processor Programming Reference (PPR) for AMD Family
> 1Ah Model 02h Revision C1 Processors document available at the link
> below.
>
> The recommended metrics are sourced from Table 28 "Guidance for Common
> Performance Statistics with Complex Event Selects". They capture data
> bandwidth for various links and interfaces in the data fabric.
>
> Link: https://bugzilla.kernel.org/attachment.cgi?id=3D307010
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> ---
>  .../arch/x86/amdzen5/recommended.json         | 112 ++++++++++++++++++
>  1 file changed, 112 insertions(+)
>
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/recommended.json b/to=
ols/perf/pmu-events/arch/x86/amdzen5/recommended.json
> index c97874039c1e..635d57e3bc15 100644
> --- a/tools/perf/pmu-events/arch/x86/amdzen5/recommended.json
> +++ b/tools/perf/pmu-events/arch/x86/amdzen5/recommended.json
> @@ -341,5 +341,117 @@
>      "MetricGroup": "memory_controller",
>      "PerPkg": "1",
>      "ScaleUnit": "1per_memclk"
> +  },
> +  {
> +    "MetricName": "dram_read_bandwidth_for_local_or_remote_socket",
> +    "BriefDescription": "DRAM read data bandwidth for accesses in local =
or remote socket.",
> +    "MetricExpr": "(local_or_remote_socket_read_data_beats_dram_0 + loca=
l_or_remote_socket_read_data_beats_dram_1 + local_or_remote_socket_read_dat=
a_beats_dram_2 + local_or_remote_socket_read_data_beats_dram_3 + local_or_r=
emote_socket_read_data_beats_dram_4 + local_or_remote_socket_read_data_beat=
s_dram_5 + local_or_remote_socket_read_data_beats_dram_6 + local_or_remote_=
socket_read_data_beats_dram_7 + local_or_remote_socket_read_data_beats_dram=
_8 + local_or_remote_socket_read_data_beats_dram_9 + local_or_remote_socket=
_read_data_beats_dram_10 + local_or_remote_socket_read_data_beats_dram_11) =
/ duration_time",

Fwiw, I think we can make writing metrics like this less error prone
with python. PTAL at:
https://lore.kernel.org/lkml/20240926174101.406874-1-irogers@google.com/

Thanks,
Ian

> +    "MetricGroup": "data_fabric",
> +    "PerPkg": "1",
> +    "ScaleUnit": "6.4e-5MB/s"
> +  },
> +  {
> +    "MetricName": "dram_write_bandwidth_for_local_socket",
> +    "BriefDescription": "DRAM write data bandwidth for accesses in local=
 socket.",
> +    "MetricExpr": "(local_socket_write_data_beats_dram_0 + local_socket_=
write_data_beats_dram_1 + local_socket_write_data_beats_dram_2 + local_sock=
et_write_data_beats_dram_3 + local_socket_write_data_beats_dram_4 + local_s=
ocket_write_data_beats_dram_5 + local_socket_write_data_beats_dram_6 + loca=
l_socket_write_data_beats_dram_7 + local_socket_write_data_beats_dram_8 + l=
ocal_socket_write_data_beats_dram_9 + local_socket_write_data_beats_dram_10=
 + local_socket_write_data_beats_dram_11) / duration_time",
> +    "MetricGroup": "data_fabric",
> +    "PerPkg": "1",
> +    "ScaleUnit": "6.4e-5MB/s"
> +  },
> +  {
> +    "MetricName": "dram_write_bandwidth_for_remote_socket",
> +    "BriefDescription": "DRAM write data bandwidth for accesses in remot=
e socket.",
> +    "MetricExpr": "(remote_socket_write_data_beats_dram_0 + remote_socke=
t_write_data_beats_dram_1 + remote_socket_write_data_beats_dram_2 + remote_=
socket_write_data_beats_dram_3 + remote_socket_write_data_beats_dram_4 + re=
mote_socket_write_data_beats_dram_5 + remote_socket_write_data_beats_dram_6=
 + remote_socket_write_data_beats_dram_7 + remote_socket_write_data_beats_d=
ram_8 + remote_socket_write_data_beats_dram_9 + remote_socket_write_data_be=
ats_dram_10 + remote_socket_write_data_beats_dram_11) / duration_time",
> +    "MetricGroup": "data_fabric",
> +    "PerPkg": "1",
> +    "ScaleUnit": "6.4e-5MB/s"
> +  },
> +  {
> +    "MetricName": "dram_write_bandwidth_for_local_or_remote_socket",
> +    "BriefDescription": "DRAM write data bandwidth for accesses in local=
 or remote socket.",
> +    "MetricExpr": "(local_or_remote_socket_write_data_beats_dram_0 + loc=
al_or_remote_socket_write_data_beats_dram_1 + local_or_remote_socket_write_=
data_beats_dram_2 + local_or_remote_socket_write_data_beats_dram_3 + local_=
or_remote_socket_write_data_beats_dram_4 + local_or_remote_socket_write_dat=
a_beats_dram_5 + local_or_remote_socket_write_data_beats_dram_6 + local_or_=
remote_socket_write_data_beats_dram_7 + local_or_remote_socket_write_data_b=
eats_dram_8 + local_or_remote_socket_write_data_beats_dram_9 + local_or_rem=
ote_socket_write_data_beats_dram_10 + local_or_remote_socket_write_data_bea=
ts_dram_11) / duration_time",
> +    "MetricGroup": "data_fabric",
> +    "PerPkg": "1",
> +    "ScaleUnit": "6.4e-5MB/s"
> +  },
> +  {
> +    "MetricName": "upstream_dma_read_bandwidth_for_local_socket",
> +    "BriefDescription": "Upstream DMA read data bandwidth for accesses i=
n local socket.",
> +    "MetricExpr": "(local_socket_upstream_read_data_beats_io_0 + local_s=
ocket_upstream_read_data_beats_io_1 + local_socket_upstream_read_data_beats=
_io_2 + local_socket_upstream_read_data_beats_io_3 + local_socket_upstream_=
read_data_beats_io_4 + local_socket_upstream_read_data_beats_io_5 + local_s=
ocket_upstream_read_data_beats_io_6 + local_socket_upstream_read_data_beats=
_io_7) / duration_time",
> +    "MetricGroup": "data_fabric",
> +    "PerPkg": "1",
> +    "ScaleUnit": "6.4e-5MB/s"
> +  },
> +  {
> +    "MetricName": "upstream_dma_write_bandwidth_for_local_socket",
> +    "BriefDescription": "Upstream DMA write data bandwidth for accesses =
in local socket.",
> +    "MetricExpr": "(local_socket_upstream_write_data_beats_io_0 + local_=
socket_upstream_write_data_beats_io_1 + local_socket_upstream_write_data_be=
ats_io_2 + local_socket_upstream_write_data_beats_io_3 + local_socket_upstr=
eam_write_data_beats_io_4 + local_socket_upstream_write_data_beats_io_5 + l=
ocal_socket_upstream_write_data_beats_io_6 + local_socket_upstream_write_da=
ta_beats_io_7) / duration_time",
> +    "MetricGroup": "data_fabric",
> +    "PerPkg": "1",
> +    "ScaleUnit": "6.4e-5MB/s"
> +  },
> +  {
> +    "MetricName": "upstream_dma_read_bandwidth_for_remote_socket",
> +    "BriefDescription": "Upstream DMA read data bandwidth for accesses i=
n remote socket.",
> +    "MetricExpr": "(remote_socket_upstream_read_data_beats_io_0 + remote=
_socket_upstream_read_data_beats_io_1 + remote_socket_upstream_read_data_be=
ats_io_2 + remote_socket_upstream_read_data_beats_io_3 + remote_socket_upst=
ream_read_data_beats_io_4 + remote_socket_upstream_read_data_beats_io_5 + r=
emote_socket_upstream_read_data_beats_io_6 + remote_socket_upstream_read_da=
ta_beats_io_7) / duration_time",
> +    "MetricGroup": "data_fabric",
> +    "PerPkg": "1",
> +    "ScaleUnit": "6.4e-5MB/s"
> +  },
> +  {
> +    "MetricName": "upstream_dma_write_bandwidth_for_remote_socket",
> +    "BriefDescription": "Upstream DMA write data bandwidth for accesses =
in remote socket.",
> +    "MetricExpr": "(remote_socket_upstream_write_data_beats_io_0 + remot=
e_socket_upstream_write_data_beats_io_1 + remote_socket_upstream_write_data=
_beats_io_2 + remote_socket_upstream_write_data_beats_io_3 + remote_socket_=
upstream_write_data_beats_io_4 + remote_socket_upstream_write_data_beats_io=
_5 + remote_socket_upstream_write_data_beats_io_6 + remote_socket_upstream_=
write_data_beats_io_7) / duration_time",
> +    "MetricGroup": "data_fabric",
> +    "PerPkg": "1",
> +    "ScaleUnit": "6.4e-5MB/s"
> +  },
> +  {
> +    "MetricName": "core_inbound_data_bandwidth_for_local_socket",
> +    "BriefDescription": "Core inbound data bandwidth for accesses in loc=
al socket.",
> +    "MetricExpr": "(local_socket_inbound_data_beats_cfi_0 + local_socket=
_inbound_data_beats_cfi_1 + local_socket_inbound_data_beats_cfi_2 + local_s=
ocket_inbound_data_beats_cfi_3 + local_socket_inbound_data_beats_cfi_4 + lo=
cal_socket_inbound_data_beats_cfi_5 + local_socket_inbound_data_beats_cfi_6=
 + local_socket_inbound_data_beats_cfi_7 + local_socket_inbound_data_beats_=
cfi_8 + local_socket_inbound_data_beats_cfi_9 + local_socket_inbound_data_b=
eats_cfi_10 + local_socket_inbound_data_beats_cfi_11 + local_socket_inbound=
_data_beats_cfi_12 + local_socket_inbound_data_beats_cfi_13 + local_socket_=
inbound_data_beats_cfi_14 + local_socket_inbound_data_beats_cfi_15) / durat=
ion_time",
> +    "MetricGroup": "data_fabric",
> +    "PerPkg": "1",
> +    "ScaleUnit": "3.2e-5MB/s"
> +  },
> +  {
> +    "MetricName": "core_outbound_data_bandwidth_for_local_socket",
> +    "BriefDescription": "Core outbound data bandwidth for accesses in lo=
cal socket.",
> +    "MetricExpr": "(local_socket_outbound_data_beats_cfi_0 + local_socke=
t_outbound_data_beats_cfi_1 + local_socket_outbound_data_beats_cfi_2 + loca=
l_socket_outbound_data_beats_cfi_3 + local_socket_outbound_data_beats_cfi_4=
 + local_socket_outbound_data_beats_cfi_5 + local_socket_outbound_data_beat=
s_cfi_6 + local_socket_outbound_data_beats_cfi_7 + local_socket_outbound_da=
ta_beats_cfi_8 + local_socket_outbound_data_beats_cfi_9 + local_socket_outb=
ound_data_beats_cfi_10 + local_socket_outbound_data_beats_cfi_11 + local_so=
cket_outbound_data_beats_cfi_12 + local_socket_outbound_data_beats_cfi_13 +=
 local_socket_outbound_data_beats_cfi_14 + local_socket_outbound_data_beats=
_cfi_15) / duration_time",
> +    "MetricGroup": "data_fabric",
> +    "PerPkg": "1",
> +    "ScaleUnit": "6.4e-5MB/s"
> +  },
> +  {
> +    "MetricName": "core_inbound_data_bandwidth_for_remote_socket",
> +    "BriefDescription": "Core inbound data bandwidth for accesses in rem=
ote socket.",
> +    "MetricExpr": "(remote_socket_inbound_data_beats_cfi_0 + remote_sock=
et_inbound_data_beats_cfi_1 + remote_socket_inbound_data_beats_cfi_2 + remo=
te_socket_inbound_data_beats_cfi_3 + remote_socket_inbound_data_beats_cfi_4=
 + remote_socket_inbound_data_beats_cfi_5 + remote_socket_inbound_data_beat=
s_cfi_6 + remote_socket_inbound_data_beats_cfi_7 + remote_socket_inbound_da=
ta_beats_cfi_8 + remote_socket_inbound_data_beats_cfi_9 + remote_socket_inb=
ound_data_beats_cfi_10 + remote_socket_inbound_data_beats_cfi_11 + remote_s=
ocket_inbound_data_beats_cfi_12 + remote_socket_inbound_data_beats_cfi_13 +=
 remote_socket_inbound_data_beats_cfi_14 + remote_socket_inbound_data_beats=
_cfi_15) / duration_time",
> +    "MetricGroup": "data_fabric",
> +    "PerPkg": "1",
> +    "ScaleUnit": "3.2e-5MB/s"
> +  },
> +  {
> +    "MetricName": "core_outbound_data_bandwidth_for_remote_socket",
> +    "BriefDescription": "Core outbound data bandwidth for accesses in re=
mote socket.",
> +    "MetricExpr": "(remote_socket_outbound_data_beats_cfi_0 + remote_soc=
ket_outbound_data_beats_cfi_1 + remote_socket_outbound_data_beats_cfi_2 + r=
emote_socket_outbound_data_beats_cfi_3 + remote_socket_outbound_data_beats_=
cfi_4 + remote_socket_outbound_data_beats_cfi_5 + remote_socket_outbound_da=
ta_beats_cfi_6 + remote_socket_outbound_data_beats_cfi_7 + remote_socket_ou=
tbound_data_beats_cfi_8 + remote_socket_outbound_data_beats_cfi_9 + remote_=
socket_outbound_data_beats_cfi_10 + remote_socket_outbound_data_beats_cfi_1=
1 + remote_socket_outbound_data_beats_cfi_12 + remote_socket_outbound_data_=
beats_cfi_13 + remote_socket_outbound_data_beats_cfi_14 + remote_socket_out=
bound_data_beats_cfi_15) / duration_time",
> +    "MetricGroup": "data_fabric",
> +    "PerPkg": "1",
> +    "ScaleUnit": "6.4e-5MB/s"
> +  },
> +  {
> +    "MetricName": "cross_socket_inbound_data_bandwidth_for_local_socket"=
,
> +    "BriefDescription": "Inbound data bandwidth for accesses between loc=
al socket and remote socket.",
> +    "MetricExpr": "(local_socket_inbound_data_beats_link_0 + local_socke=
t_inbound_data_beats_link_1 + local_socket_inbound_data_beats_link_2 + loca=
l_socket_inbound_data_beats_link_3 + local_socket_inbound_data_beats_link_4=
 + local_socket_inbound_data_beats_link_5) / duration_time",
> +    "MetricGroup": "data_fabric",
> +    "PerPkg": "1",
> +    "ScaleUnit": "6.4e-5MB/s"
> +  },
> +  {
> +    "MetricName": "cross_socket_outbound_data_bandwidth_for_local_socket=
",
> +    "BriefDescription": "Outbound data bandwidth for accesses between lo=
cal socket and remote socket.",
> +    "MetricExpr": "(local_socket_outbound_data_beats_link_0 + local_sock=
et_outbound_data_beats_link_1 + local_socket_outbound_data_beats_link_2 + l=
ocal_socket_outbound_data_beats_link_3 + local_socket_outbound_data_beats_l=
ink_4 + local_socket_outbound_data_beats_link_5) / duration_time",
> +    "MetricGroup": "data_fabric",
> +    "PerPkg": "1",
> +    "ScaleUnit": "6.4e-5MB/s"
>    }
>  ]
> --
> 2.43.0
>
