Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A62A1F0E26
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Apr 2025 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745313406; cv=none; b=Wyo2uQ3WvcT10q1wTLXNqNx0nqy2lctR6F3Ewv1t2z807SV7KlbLGUah3/GVZ6IMq1udhXXplba4UNCuNvh4zjHXM36Uvc1bHctu0yRr7RE0FfJJUfqVclazp5qOMWOxXlJ3vjbKEzP+Fs+9f9q+yTcBwu7A8nSfRITPSGKvdqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745313406; c=relaxed/simple;
	bh=XLb2GPkP+wj3NGaw9/03Vrv8EQD5FEEK6kKMUdoXDnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZULwlGBuwwcyv25q/RrO5Y2yUuDxFjc3ShmiP2AifFAG7DQvv5RBtF6fk2NetoqE+GGOtACN8hR3xdHxXuz7f4m92o6+8ap2DRsjAIHPwDmPWDDzTJx/+fS3HzHtyUJVdGiLmziF4759Whm8yz4g/4dnwXTJrWwYylWsLS1pPvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D0EFPcFn; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D0EFPcFn"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so44154675e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Apr 2025 02:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745313402; x=1745918202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LAIUiMIMcANp49836dqsOtoIvLH2tYBBYWYFrEFvBSE=;
        b=D0EFPcFn9k0sz6Y2sqDFHAn2yIbPPDleuXs9dQ6pZy9zinA1ZdeWyuHzi5TLq8r7V4
         7iAUrjJNokq+lLvY4UvlPvABGIuvwg76C0KKlfokbFduSzptzbeL6d8Ih+6LaDwRG+/U
         ZGVWe4gS6uzfnYEIIeKrXlxuTYaGlxBpuYMfng3rCLa2JiVUGU6eUSxsWIMCnrmXe/f1
         Rx5p9XUi1OFJUf96l0YDKZEzrismxA8Xz6HfmeaA7mNHJFD2wMnNNET85na0AM40khMS
         xRPEulyNzQxWwxsICz9vuqhJdUZPO8kFQtPVMc13phkbSWh0THk0FT4dkWq8z+91dR4N
         2PEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745313402; x=1745918202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LAIUiMIMcANp49836dqsOtoIvLH2tYBBYWYFrEFvBSE=;
        b=I8gmn9quYucNwrxQy4ugqORWYrwwc3Foh8x87nPdSfzqhcTnr7ePf6nUogX28A3xmo
         i1Hoi7B+5Mu45ffjXIioWan9UiBYnL/mA1zsbBlmcX8xFPqDmf8dcG/Ca4Wi+jwCXNgd
         toC/gwJjJrvTTwBcysgLVYS4odEzletWIfhT8bgmr0/liGE6UwGsXoTjbGkH3sOHIiUI
         h+LNYWZkXpT4pSaSEBPhBCechDaQ/Zrs1rMsuImQ9p+gL3zdl2hLSuC8ZoAU3GImP53F
         qAlk0zPqutuILuxnmeWjCYSgr1j8wP16Nn71bmaxfvV7VnyEIrToTi7VcUEYS9oMwgLR
         3Rnw==
X-Forwarded-Encrypted: i=1; AJvYcCW4ZO6f6SfCv81JkuT67VN/I0OTz9CNVZxxFQtBK9eMXwNBsMx5Kk7UqQDxMqcvTvUtY5TUWLaKV7K7Ae4bWyzy@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ4SLlsTBTH7CCV6TNBh/QrhnecpFL30DeKTk7MiLNj7hzETM0
	bhvWX/PRf31P21JDgn46Ix/VkokeAf5tvwv9eFkg0MmAWBzpSqipKINSJOQzrNk=
X-Gm-Gg: ASbGncu5OFk6Ulb8RVg6yvsbU4CNVOHiBvuQI4qEcI9E39oKcYGoKItrtWVNrxCHotO
	LU4Kzd4WfDDVpudoTFk7XJKrMAc8D3/o+pRALok+ivDATPSYGgYdiC5w5/5Dh0y/EyaWfLejJ6/
	2HyDWtgBrO56XvYIWZBQEu9izFE/pMaW0qPCFu3cr6rEp1DLdD3njrrv/m7PrmrQD+LgWiI8GPy
	3+nJxtD6y17WGiUQ7scaw62HgWaBYZ8Ps3SRdL6npbHnaAYo8WAsJP9fPp7LyFzuEhuR2DLQpcV
	YV9QsWKNqg1ulr+dFCmsGwsjl39tS649unrbyxC2HJA/re9040CRgw==
X-Google-Smtp-Source: AGHT+IHSmn7InVI4HJQAnYc4ixv6KlQi3IVS6vPqSQLW1cy6FbhQcHoFR4nhvDq+BMRCiagfyFUWeg==
X-Received: by 2002:a05:600c:3592:b0:439:9e13:2dd7 with SMTP id 5b1f17b1804b1-4408188366cmr66858785e9.2.1745313402478;
        Tue, 22 Apr 2025 02:16:42 -0700 (PDT)
Received: from [192.168.1.3] ([77.81.75.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4407c5c7916sm107783135e9.27.2025.04.22.02.16.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 02:16:42 -0700 (PDT)
Message-ID: <89741897-6c8f-4b75-8ec3-675111ea60a1@linaro.org>
Date: Tue, 22 Apr 2025 10:16:40 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf arm-spe: Add support for SPE Data Source packet on
 HiSilicon HIP12
To: Yicong Yang <yangyicong@huawei.com>
Cc: jonathan.cameron@huawei.com, hejunhao3@huawei.com, linuxarm@huawei.com,
 wangyushan12@huawei.com, caijingtao@huawei.com, xueshan2@huawei.com,
 prime.zeng@hisilicon.com, yangyicong@hisilicon.com, acme@kernel.org,
 namhyung@kernel.org, catalin.marinas@arm.com, will@kernel.org,
 peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
 jolsa@kernel.org, john.g.garry@oracle.com, leo.yan@linux.dev,
 irogers@google.com, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org
References: <20250408122809.37884-1-yangyicong@huawei.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250408122809.37884-1-yangyicong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/04/2025 1:28 pm, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Add data source encoding for HiSilicon HIP12 and coresponding mapping
> to the perf's memory data source. This will help to synthesize the data
> and support upper layer tools like perf-mem and perf-c2c.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>   arch/arm64/include/asm/cputype.h              |   2 +
>   tools/arch/arm64/include/asm/cputype.h        |   2 +
>   .../util/arm-spe-decoder/arm-spe-decoder.h    |  17 +++
>   tools/perf/util/arm-spe.c                     | 101 ++++++++++++++++++
>   4 files changed, 122 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> index d1cc0571798b..36c5bbfbb6e9 100644
> --- a/arch/arm64/include/asm/cputype.h
> +++ b/arch/arm64/include/asm/cputype.h
> @@ -133,6 +133,7 @@
>   
>   #define HISI_CPU_PART_TSV110		0xD01
>   #define HISI_CPU_PART_HIP09			0xD02
> +#define HISI_CPU_PART_HIP12		0xD06
>   
>   #define APPLE_CPU_PART_M1_ICESTORM	0x022
>   #define APPLE_CPU_PART_M1_FIRESTORM	0x023
> @@ -220,6 +221,7 @@
>   #define MIDR_FUJITSU_A64FX MIDR_CPU_MODEL(ARM_CPU_IMP_FUJITSU, FUJITSU_CPU_PART_A64FX)
>   #define MIDR_HISI_TSV110 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_TSV110)
>   #define MIDR_HISI_HIP09 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_HIP09)
> +#define MIDR_HISI_HIP12 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_HIP12)
>   #define MIDR_APPLE_M1_ICESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM)
>   #define MIDR_APPLE_M1_FIRESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_FIRESTORM)
>   #define MIDR_APPLE_M1_ICESTORM_PRO MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM_PRO)
> diff --git a/tools/arch/arm64/include/asm/cputype.h b/tools/arch/arm64/include/asm/cputype.h
> index 488f8e751349..9a5d85cfd1fb 100644
> --- a/tools/arch/arm64/include/asm/cputype.h
> +++ b/tools/arch/arm64/include/asm/cputype.h
> @@ -129,6 +129,7 @@
>   #define FUJITSU_CPU_PART_A64FX		0x001
>   
>   #define HISI_CPU_PART_TSV110		0xD01
> +#define HISI_CPU_PART_HIP12		0xD06
>   
>   #define APPLE_CPU_PART_M1_ICESTORM	0x022
>   #define APPLE_CPU_PART_M1_FIRESTORM	0x023
> @@ -202,6 +203,7 @@
>   #define MIDR_NVIDIA_CARMEL MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_CARMEL)
>   #define MIDR_FUJITSU_A64FX MIDR_CPU_MODEL(ARM_CPU_IMP_FUJITSU, FUJITSU_CPU_PART_A64FX)
>   #define MIDR_HISI_TSV110 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_TSV110)
> +#define MIDR_HISI_HIP12 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_HIP12)
>   #define MIDR_APPLE_M1_ICESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM)
>   #define MIDR_APPLE_M1_FIRESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_FIRESTORM)
>   #define MIDR_APPLE_M1_ICESTORM_PRO MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM_PRO)
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> index 5d232188643b..0410abed5009 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> @@ -82,6 +82,23 @@ enum arm_spe_ampereone_data_source {
>   	ARM_SPE_AMPEREONE_L2D                           = 0x9,
>   };
>   
> +enum arm_spe_hisi_hip_data_source {
> +	ARM_SPE_HISI_HIP_PEER_CPU		= 0,
> +	ARM_SPE_HISI_HIP_PEER_CPU_HITM		= 1,
> +	ARM_SPE_HISI_HIP_L3			= 2,
> +	ARM_SPE_HISI_HIP_L3_HITM		= 3,
> +	ARM_SPE_HISI_HIP_PEER_CLUSTER		= 4,
> +	ARM_SPE_HISI_HIP_PEER_CLUSTER_HITM	= 5,
> +	ARM_SPE_HISI_HIP_REMOTE_SOCKET		= 6,
> +	ARM_SPE_HISI_HIP_REMOTE_SOCKET_HITM	= 7,
> +	ARM_SPE_HISI_HIP_LOCAL			= 8,
> +	ARM_SPE_HISI_HIP_REMOTE			= 9,
> +	ARM_SPE_HISI_HIP_NC_DEV			= 13,
> +	ARM_SPE_HISI_HIP_L2			= 16,
> +	ARM_SPE_HISI_HIP_L2_HITM		= 17,
> +	ARM_SPE_HISI_HIP_L1			= 18,
> +};
> +
>   struct arm_spe_record {
>   	enum arm_spe_sample_type type;
>   	int err;
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 2a9775649cc2..eceae4219601 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -571,6 +571,11 @@ static const struct midr_range ampereone_ds_encoding_cpus[] = {
>   	{},
>   };
>   
> +static const struct midr_range hisi_hip_ds_encoding_cpus[] = {
> +	MIDR_ALL_VERSIONS(MIDR_HISI_HIP12),
> +	{},
> +};
> +
>   static void arm_spe__sample_flags(struct arm_spe_queue *speq)
>   {
>   	const struct arm_spe_record *record = &speq->decoder->record;
> @@ -718,9 +723,105 @@ static void arm_spe__synth_data_source_ampereone(const struct arm_spe_record *re
>   	arm_spe__synth_data_source_common(&common_record, data_src);
>   }
>   
> +static void arm_spe__synth_data_source_hisi_hip(const struct arm_spe_record *record,
> +						union perf_mem_data_src *data_src)
> +{
> +	/* Use common synthesis method to handle store operations */
> +	if (record->op & ARM_SPE_OP_ST) {
> +		arm_spe__synth_data_source_common(record, data_src);
> +		return;
> +	}
> +
> +	switch (record->source) {
> +	case ARM_SPE_HISI_HIP_PEER_CPU:
> +		data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> +		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
> +		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
> +		break;
> +	case ARM_SPE_HISI_HIP_PEER_CPU_HITM:
> +		data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> +		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
> +		break;
> +	case ARM_SPE_HISI_HIP_L3:
> +		data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> +		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
> +		break;
> +	case ARM_SPE_HISI_HIP_L3_HITM:
> +		data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> +		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
> +		break;
> +	case ARM_SPE_HISI_HIP_PEER_CLUSTER:
> +		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE1 | PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> +		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
> +		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
> +		break;
> +	case ARM_SPE_HISI_HIP_PEER_CLUSTER_HITM:
> +		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE1 | PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> +		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
> +		break;
> +	case ARM_SPE_HISI_HIP_REMOTE_SOCKET:
> +		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE2;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
> +		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
> +		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;

Hi Yicong,

Is the mem_snoop setting missing from this one?

Other than that, LGTM.

Thanks
James

