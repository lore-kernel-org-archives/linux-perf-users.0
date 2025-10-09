Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939A82D2388
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Oct 2025 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760004029; cv=none; b=T1X1CDERHxtpzOmgAIaMeCGZaLiAB3NBk/ARZRtBmK/ii/zNW5NSP8tns1Y/UAl4Pu3RTXFN9B0Cs7HOAMzMsURG2vPTJ3/7kK1Q5Ar4hPB5u6wxy4vUYCIQT7Ijardq+qDcnhdKaG5JbRUpPMPvYrLgQtXfGZLixwwGRk9XzAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760004029; c=relaxed/simple;
	bh=Nvlj8QOM3/LwQsImzQFRW030qZIX5wjnoYElraHmnnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o2IpyXjzNCsKDg4TXYL0ro5AYMUshvELMwA05IzoEMil8DAcaT6FNKSEenv9b4lKOF2WcfW1kEkB642PtHK0lzpDSK3MUyvJ5/tuVe5uAOv70/GVRI0zea0D9SFjnmq9A+FlKXj/ajrAmSkpFTwuP8i2okHmdjvnRwGXpmb5NeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TUpFHK0W; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TUpFHK0W"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3fc36b99e92so1390380f8f.0
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Oct 2025 03:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760004026; x=1760608826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FKkXJ5cBog1kSb9Pudqeky3E5aFn1OojC4INJ8laWnQ=;
        b=TUpFHK0WX9gVyU9z/Wj4oez2Ah5bPVIoriduAMiLzhAcI+yE3rnEe749B7ihJAFzRe
         fiM75l427bgqa64gWsreMPkFDkDE8b1TSHWqvh0d5v22xZaxXTSAm2W7aJrH5Npv19lH
         eNNtC9VEcH8i/GQdgY6Xe3Q0YIjwmzash9yxOqAm1BQs6nqA2sJiExgs8rdYhK//zLCC
         erKcCYrXGpr/lLYBrz31QLNbUFy//HQ5qQIuqGXsLvgD+XtTbFcCTHZV691xIMgARdPO
         GpP7wYisr2pxEyPj+htV5DnvUXcdATn0oecuwVI7zxJWeInNwrAFtxTYKyLbYYi83mFg
         giCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760004026; x=1760608826;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FKkXJ5cBog1kSb9Pudqeky3E5aFn1OojC4INJ8laWnQ=;
        b=WV9K4war0y9aXYM1EUgtV54lprwq/ydW6GfsvkIjazbeW6XZzF7GFF8tteWiJLOk75
         NXpmXEUzrUoQV33YLpkpFdHfbgrVR/NoY2p/BdbEG0i3FxaYbLx/m2akEoVVmY5SABdF
         JJSdhVyecjNhdhDs8whA5PoJthi+PZ/FpiDVjG1RZ5aQfN3/PoE+TyFH15fSWKWgMh56
         FKeyrwsngX3rJLxBLtua4X42xSAxV1scYmMP92RHMZWWSRo7t9kjjKBbGfkVzpNmiq1y
         wvTt2/acbNrM8/ZqZXhX7I1s9rnqOhhKR3Iu+jeYKRKasb/vTAKjZf4G/jJsOye+VZ+h
         0KUA==
X-Forwarded-Encrypted: i=1; AJvYcCUQnJmQHSa6awa4HiXyBcuMqbGFJw5i0Chp+7pwb5tNkhU8WLidrgpIKJc/xfPNOi82o76LuMnnFAOwQlRvjNxJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzxpQy0wNHdwVRsV0JWhzFRdoi9Ah7kxHMHAhRPmHhQCoMyT0Bh
	AhQiOisD3cfFCdp5rnSiD+3CC5TWhC90/2I1r28jsmiZebqmfLPfskArVYVphwtDrnU=
X-Gm-Gg: ASbGncuU2eE+PJFMO/EKf5oioKFAWmkdR8Nv4HO55/GN1blwj3X1FS55UH3OjTMHopz
	oZfu6mMv5C+ph6blksxW+1ZoCHVmn+mCnCj8GMT6wnUk8dhskxBEfA8KShYzNFht+1jNJwg3Z8f
	OSDW7hCvfUaX8dPxpDXI4SVSIRGyiOkSx1AO1HwJfhauONrX7Soy7+LkrXHS2ZCvXgfJ4XgAri2
	EW+4x5yPT0y1Ec2r94CfZ0vLpCS9616A9BqGFmo4vlH1FDT++csKhKaus9Kwlf6cQGPbrJwthnf
	k+IvwEdVRqFyedTdR5mV2tZPewmBD4gDOhR2mV32US0GScylN57+0iLgapJz4yVnhYRMixKUfRD
	l9vGxRaywGdDkQEsw7hGKevssDrJ5Qh9jt5eTRkkfuAJscEpSMafUfybzlnnC+9stCFJv+6mSXZ
	/mIw==
X-Google-Smtp-Source: AGHT+IEsrDwu3DirvSWaVTjPOm5CTQSm/UpPiKu3gsx0vMLrCdo1k15jqFRws3Md9ryGIXqK4Pz8cQ==
X-Received: by 2002:a05:6000:1447:b0:407:d776:4434 with SMTP id ffacd0b85a97d-42582a05718mr7614451f8f.30.1760004025773;
        Thu, 09 Oct 2025 03:00:25 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9c07992sm91103655e9.5.2025.10.09.03.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 03:00:25 -0700 (PDT)
Message-ID: <9a5efa8f-f6a6-45c3-954a-bf8c516ac15c@linaro.org>
Date: Thu, 9 Oct 2025 11:00:23 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/25] perf/uapi: Extend data source fields
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
References: <20250929-perf_support_arm_spev1-3-v1-0-1150b3c83857@arm.com>
 <20250929-perf_support_arm_spev1-3-v1-19-1150b3c83857@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250929-perf_support_arm_spev1-3-v1-19-1150b3c83857@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/09/2025 5:37 pm, Leo Yan wrote:
> Arm CPUs introduce several new types of memory operations, like MTE tag
> accessing, system register access for nested virtualization, memcpy &
> memset, and Guarded Control Stack (GCS).
> 
> For memory operation details, Arm SPE provides information like data
> (parallel) processing, floating-point, predicated, atomic, exclusive,
> acquire/release, gather/scatter, and conditional.
> 
> This commit introduces a field 'mem_op_ext' for extended operation type.
> The extended operation type can be combined with the existed operation
> type to express a memory type, for examples, a PERF_MEM_OP_GCS type can
> be set along with PERF_MEM_OP_LOAD to present a load operation for
> GCS register access.
> 
> Also use a field 'mem_aff' to store affiliate information.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   include/uapi/linux/perf_event.h | 28 ++++++++++++++++++++++++++--
>   1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 78a362b8002776e5ce83a0d7816601638c61ecc6..51ab37d44ac31fcdc4bc919c14d5f97e560d9339 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -1309,14 +1309,18 @@ union perf_mem_data_src {
>   			mem_snoopx  :  2, /* Snoop mode, ext */
>   			mem_blk     :  3, /* Access blocked */
>   			mem_hops    :  3, /* Hop level */
> -			mem_rsvd    : 18;
> +			mem_op_ext  :  6, /* Extended type of opcode */

Why have a 6 bit field containing 1 bit per thing when you can have 6 
named 1 bit fields? That way you don't have to do a load of bitwise 
magic to access it and you don't need separate #defines.

Also, when you set these, you never set more than one bit so they're 
exclusive. Would a 3 bit enum be better than a 6 bit bitfield in this case?

> +			mem_aff     :  8, /* Affiliate info */
> +			mem_rsvd    :  4;
>   	};
>   };
>   #elif defined(__BIG_ENDIAN_BITFIELD)
>   union perf_mem_data_src {
>   	__u64 val;
>   	struct {
> -		__u64	mem_rsvd    : 18,
> +		__u64	mem_rsvd    :  4,
> +			mem_aff     :  8, /* Affiliate info */
> +			mem_op_ext  :  6, /* Extended type of opcode */
>   			mem_hops    :  3, /* Hop level */
>   			mem_blk     :  3, /* Access blocked */
>   			mem_snoopx  :  2, /* Snoop mode, ext */
> @@ -1426,6 +1430,26 @@ union perf_mem_data_src {
>   /* 5-7 available */
>   #define PERF_MEM_HOPS_SHIFT			43
>   
> +/* Extended type of memory opcode: */
> +#define PERF_MEM_EXT_OP_MTE_TAG			0x0001 /* MTE tag */
> +#define PERF_MEM_EXT_OP_NESTED_VIRT		0x0002 /* Nested virtualization */
> +#define PERF_MEM_EXT_OP_MEMCPY			0x0004 /* Memory copy */
> +#define PERF_MEM_EXT_OP_MEMSET			0x0008 /* Memory set */
> +#define PERF_MEM_EXT_OP_SIMD			0x0010 /* SIMD */
> +#define PERF_MEM_EXT_OP_GCS			0x0020 /* Guarded Control Stack */
> +#define PERF_MEM_EXT_OP_SHIFT			46
> +
> +/* Affiliate info */

"Affiliate info" doesn't really describe what these are supposed to be, 
or why they are separate. Is it implying that they're always set in 
addition to another flag? Like "details" or "category"?

Either way, I feel that limitation might be a bit strict for the generic 
uapi, or it needs to be described in more detail. If we change this 
field to be individual bits like the other one, then maybe we can drop 
that it's a separate group and it's just a bunch of bits you can set 
however you like.

> +#define PERF_MEM_AFF_DP				0x0001 /* Data processing */
> +#define PERF_MEM_AFF_FP				0x0002 /* Floating-point */
> +#define PERF_MEM_AFF_PRED			0x0004 /* Predicated */
> +#define PERF_MEM_AFF_ATOMIC			0x0008 /* Atomic */
> +#define PERF_MEM_AFF_EXCLUSIVE			0x0010 /* Exclusive */
> +#define PERF_MEM_AFF_AR				0x0020 /* Acquire/release */
> +#define PERF_MEM_AFF_SG				0x0040 /* Gather/Scatter */
> +#define PERF_MEM_AFF_CONDITIONAL		0x0080 /* Conditional */
> +#define PERF_MEM_AFF_SHIFT			52
> +
>   #define PERF_MEM_S(a, s) \
>   	(((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
>   
> 

