Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D231D555
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Dec 2024 10:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733738511; cv=none; b=iUdnYDj4OtvP4M25H8ot0NuvGH602ZUAxYRvKK3xP3Z87uPNSzauK4ZDynguA8y62s0tGwAwtqUscZkwwF2E6TNeuYO9eG0g1KxYCTglOspnVbiUnks9CcTqKWWHF1PHmC6Tqdmpbds4MHrQ/YM0OiB0PtWOeJcWHZ4ADpmrfkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733738511; c=relaxed/simple;
	bh=gSGNSzf8zXM/Mg9PLTj7i4j/GKoM07kA+g4SuzboP2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=JYVfD1oqzhzdFjXUKp5dwDpEWO46ppptrh+fYdhoELHzAJsFJkzaOLxK8vVDd6K1WqixAIlIB0ufZedy+T8w2psl/cbzuyLxLGzUOEGMC5ofi+dTQFyWdlt/FWo8z76aP3SMHTB8m+l7f7qPCP0huVS23X+T63YcVk3Zl77KTxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ke7FpOli; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ke7FpOli"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434e669342eso11373925e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Dec 2024 02:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733738508; x=1734343308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wDlwyDroBq6zcVrCDpDlItZdzZfKhDPhfE9JnSAIaJU=;
        b=ke7FpOli9zkkXOYZtnPy1hK3CVM4Wjq9GlO07dK14kXak4u+2Geuu1rjrmHSfoEAmW
         +AcXa3IMZ7gP7LGwjPzDaGAyscxjcPR4PMu053caYzYsrfrCdAYpQdozeIBIEEDrnOV/
         OfbKIG6YKr0aAy5QDAgDDHw+QdYbq41tSK5O+3K4370fpaK+rxVoWqDkA6YMvZUwEjKL
         rX00EkMTX/RI/tTQw/bAuFj9V0TSNY03/5N8S2EEJTCWxAon20bUgHJBlaVDxmxV276q
         NHOusNZpcbNa5YSHzpHVvxFQ+OezRajk/1MEnGRYI3EXUaoAK/GarHY42eRy+v8RfSxO
         4BPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733738508; x=1734343308;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDlwyDroBq6zcVrCDpDlItZdzZfKhDPhfE9JnSAIaJU=;
        b=aeAFIyTqCCjZ6GSuXWEPb2dII3XDn62CaBO4SetKfJb0xHdCX0Jy8gWyADIBviGUAM
         62qbCMb9y9/+lC+CHCfku9oxNLgeZKnarxDcWjTCFqcaJOVhEJStGFxiyRpOiXOTkNS3
         t38d6fDq5b53cgE+a4EkTPbyuq3fWxLquw07wdcTS2/uVChq1c/eDN13Zj2ltGY7Gsbd
         3j2EE5IDMU/aqj8x/qHufHaUd0EhV0qBBRdTZfHUS6rkKAF7euf+dplI5WGG2IAYiyAA
         l3Jqog+zutjHnTQvR+JyEt/WKp5GCPtREtfp8WqYECqLTWp+MTVgYVjafywsMpVIJ2Rv
         2sOA==
X-Forwarded-Encrypted: i=1; AJvYcCVPZSSIA2PGoVy6OcBliUn4A1EmrgJopIgDSe8Hv59Tc6Khv9EnQtHTi2d21EhJ/dF4we6nXNNFBO/VKYY9D7vG@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi65y8dhIwUMRf3bpJBmEM2czz171N4jrRtcTxXzc0OX1tZqJP
	9SvBWgzhbFpJYE60SOtXXXssMuNf1M0Rfyy2qAFXMDi40k9FlwlKezkwVaVnJnU=
X-Gm-Gg: ASbGncvSaG7CexQl3pVFELjfJURylVcKkj0/abJUe6jmnbT8rrAeIbnCRB/nmr42LLh
	7YBDK2YE6XcdF+AKP7857CH/aSXJyuU/OvbtYcsZxeO0ipPHTp2m0DM5yeaYUnix9IQqDb6EO/1
	naBZGSxYrfN8SpMLeC0czzpAnHBh9k0x7iKTZyFgivPX9djDRqVMH2nfmRD+/NeSpzn9PBpxdV2
	mzKO/grHOEb6KYlD5AlJkK2UooJiB3P4nrM55WVcl1MSCJCVtSkbUm24cIU2A==
X-Google-Smtp-Source: AGHT+IGwtp3FQpoGqZyO22hYjk1/F0qh54u6BpRMMDp3hLcMSs789LWDskm/IYygzHoEct0bsoKghQ==
X-Received: by 2002:a05:600c:1f8c:b0:434:a1e7:27b0 with SMTP id 5b1f17b1804b1-434ddeb5379mr84518625e9.11.1733738507736;
        Mon, 09 Dec 2024 02:01:47 -0800 (PST)
Received: from [192.168.68.163] ([209.198.129.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f2b08972sm57369755e9.27.2024.12.09.02.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 02:01:47 -0800 (PST)
Message-ID: <ee89c235-a126-4874-994d-b2489eb1c00f@linaro.org>
Date: Mon, 9 Dec 2024 10:01:45 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf vendor events arm64: Add FUJITSU-MONAKA pmu event
To: Yoshihiro Furudera <fj5100bi@fujitsu.com>
References: <20241111064843.3003093-1-fj5100bi@fujitsu.com>
Content-Language: en-US
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Ilkka Koskinen <ilkka@os.amperecomputing.com>, Xu Yang <xu.yang_2@nxp.com>,
 Jing Zhang <renyu.zj@linux.alibaba.com>, Lucas Stach
 <l.stach@pengutronix.de>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Akio Kakuno <fj3333bs@aa.jp.fujitsu.com>, nick.forrington@arm.com
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241111064843.3003093-1-fj5100bi@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/11/2024 6:48 am, Yoshihiro Furudera wrote:
>      Add pmu events for FUJITSU-MONAKA.
>      And, also updated common-and-microarch.json and recommended.json.
> 
>      FUJITSU-MONAKA Specification URL:
>      https://github.com/fujitsu/FUJITSU-MONAKA
> 
> Signed-off-by: Akio Kakuno <fj3333bs@aa.jp.fujitsu.com>
> Signed-off-by: Yoshihiro Furudera <fj5100bi@fujitsu.com>
> ---
> Changes in v2:
> - Change "SVE_INT64_DIV_SPEC" to "SVE_INT_DIV64_SPEC" in tools/perf/pmu-events/arch/arm64/fujitsu/monaka/sve.json.
> - Link to v1: https://lore.kernel.org/all/20241111024529.2985894-1-fj5100bi@fujitsu.com/
> 
>   .../arch/arm64/common-and-microarch.json      | 858 ++++++++++++++++++
>   .../fujitsu/monaka/cycle_accounting.json      | 146 +++
>   .../arch/arm64/fujitsu/monaka/energy.json     |  20 +
>   .../arch/arm64/fujitsu/monaka/exception.json  |  32 +
>   .../arm64/fujitsu/monaka/fp_operation.json    | 194 ++++
>   .../arch/arm64/fujitsu/monaka/gcycle.json     | 116 +++
>   .../arch/arm64/fujitsu/monaka/general.json    |   8 +
>   .../arch/arm64/fujitsu/monaka/hwpf.json       |  62 ++
>   .../arch/arm64/fujitsu/monaka/l1d_cache.json  | 101 +++
>   .../arch/arm64/fujitsu/monaka/l1i_cache.json  |  47 +
>   .../arch/arm64/fujitsu/monaka/l2_cache.json   | 146 +++
>   .../arch/arm64/fujitsu/monaka/l3_cache.json   | 185 ++++
>   .../arch/arm64/fujitsu/monaka/ll_cache.json   |   8 +
>   .../arch/arm64/fujitsu/monaka/memory.json     |   8 +
>   .../arch/arm64/fujitsu/monaka/pipeline.json   | 230 +++++
>   .../arch/arm64/fujitsu/monaka/retired.json    |  29 +
>   .../arm64/fujitsu/monaka/spec_operation.json  | 158 ++++
>   .../arch/arm64/fujitsu/monaka/stall.json      |  83 ++
>   .../arch/arm64/fujitsu/monaka/sve.json        | 146 +++
>   .../arch/arm64/fujitsu/monaka/tlb.json        | 404 +++++++++
>   .../arch/arm64/fujitsu/monaka/trace.json      |  20 +
>   tools/perf/pmu-events/arch/arm64/mapfile.csv  |   1 +
>   .../pmu-events/arch/arm64/recommended.json    |   6 +
>   23 files changed, 3008 insertions(+)
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/cycle_accounting.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/energy.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/exception.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/fp_operation.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/gcycle.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/general.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/hwpf.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l1d_cache.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l1i_cache.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l2_cache.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l3_cache.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/ll_cache.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/memory.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/pipeline.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/retired.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/spec_operation.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/stall.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/sve.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/tlb.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/trace.json
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
> index 492083b99256..50fc4b2df361 100644
> --- a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
> +++ b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
> @@ -533,6 +533,12 @@
>           "EventName": "SVE_INST_SPEC",
>           "BriefDescription": "SVE operations speculatively executed"
>       },
> +    {
> +        "PublicDescription": "This event counts architecturally executed Advanced SIMD and SVE operations.",
> +        "EventCode": "0x8007",
> +        "EventName": "ASE_SVE_INST_SPEC",
> +        "BriefDescription": "This event counts architecturally executed Advanced SIMD and SVE operations."
> +    },

Hi Yoshihiro,

You don't need to duplicate the descriptions if they are the same. Just 
BriefDescription is enough and it will show for both normal and verbose 
mode.

Also in the common files, we're using the description strings from the 
Arm ARM. I noticed that the ones from your spec are slightly different. 
This is ok for now, but if we add any new Arm cores that use the same 
events this description may get overwritten. For example 
ASE_SVE_INST_SPEC in the Arm ARM is currently "Operation speculatively 
executed, Advanced SIMD or SVE".

If you have any actual relevant details that are different from the 
common string, you should put them in .../arch/arm64/fujitsu/monaka. But 
if you are ok with the potential overwrite (which looks like it should 
be ok) then you can leave them as is.

[...]

> diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/general.json b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/general.json
> new file mode 100644
> index 000000000000..80bf17fb8f4c
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/general.json
> @@ -0,0 +1,8 @@
> +[
> +    {
> +        "ArchStdEvent": "CPU_CYCLES"
> +    },

Other cores put CPU_CYCLES in bus.json. For user friendlyness I would 
put the common ones into the same existing groups. The same issue 
applies for some other common events.


Thanks
James

