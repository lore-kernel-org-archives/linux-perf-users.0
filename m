Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1592B10F1
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Oct 2025 09:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760000683; cv=none; b=Iy052ZpuEsLQ04h1qCibWSxLBMpTC9wTG1suJeMHcFFcNZ7CDSJEWjh5lvQmE9mQUFEFVlvWMU37peIQ5wOSqb8WSQcj72ArhiSwU+D5OH84SYQnFkpxI+31wNLutcsmYgEi9KkbJutFNE/vcIHKtckFIGXZH2G5KNgUXdoBeAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760000683; c=relaxed/simple;
	bh=I5/ohoBhVKtvUkRFTNBGYLIoie1JXvtwSa5RLNjZISY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lwZVXGDTtKEXIMV0WRIUPcNvCId0tVACSmIlMnBKB8jES9qjQe7zYKqIFGea0+2o5tF7rOE4t6YM6Xrj3VUEFo+bg2Jmm/78G58TWD26+mJe+od27oIfUA+FIwAWI1hi2nYHx2SC6xxkxLlRqFIO1Dn5Z8lw9A+nBlBSg9qEkRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b2+GAk0y; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b2+GAk0y"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e34bd8eb2so7058595e9.3
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Oct 2025 02:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760000680; x=1760605480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OclG1+kzl/iGxxR7lC3nMmz/XW+nbQzJ3yd10e73GM8=;
        b=b2+GAk0yKKgRjgmVLAp1Fp8YAMtLMWB1V8JJDVyDzg5pO1bsQHfoA2bI5P5lt+TVd1
         ZPXKVVGDCQt33zWrGSedDBtJEmWRRS7zjdt0IA3+6iJxOpVx++PkjmztvsyC5E5+9vt8
         Gfd9iwgy9MmedZgkny3XUq/M0iJls3/rmVgq/M3QP/+mFtZ1arLxs4RskCmzS2DVXTQL
         FUEU6AqA8vAjz4s7wFZkmKoEMuolh+OHHuodTbMvTOpamWA3bYO8MKuqS1LTZpwUBzrZ
         RNig1e/+yzlaiuIkPCzVEgBuGrGxC/SDAScfbSLrSWXI2rHvL874KixSKm5kKre+chfu
         BOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760000680; x=1760605480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OclG1+kzl/iGxxR7lC3nMmz/XW+nbQzJ3yd10e73GM8=;
        b=KY8VM3GC/LLXhMgybgxqNcSTK5IO/G0jRlRN5X52bknin4HBwiuxm2IoCAWC/QPZq0
         qkaXkLOTuAp/lfAQtC65ThOegugB08V8LTJj5QHoRhVQmc3OgIrqNb59/JHLS0yUwcTM
         lmsyCBxNhmba/BpPJGc1OEwnzWrHglQpjVkYqo67qjNl/k5J8uKWqe/KMYWxdcopmZNq
         Wqa/1qf1KRmCP8cWn9QgxMsTt9CC0Qo8C3qmz4vOFA+wCUcuGpqfpLlKqAkxqneg01VY
         erN8BU8Euspgg7s1WVD8QgMv3TXReBkBvmjaeI4MEgAvkohInZwnJTBaCO6MoNemxzDB
         0p4g==
X-Forwarded-Encrypted: i=1; AJvYcCV6TqT5zr3eeJnc95Yo1cbFTBKtaqwas0kB2NDXSPOG4MJ30f8uj7YWoMoQ+QorCub+mNLpqDty6aafVhBCak4+@vger.kernel.org
X-Gm-Message-State: AOJu0YwkWoc+Ly3bQWY8j4zweQcC9SxrvDZQiI8vmf7uNKTpQWSyyj96
	sgr7zRBU6dZ0U8ZpUFLnWzMM6zHj0TvzDZ++SwADCdQz2H2uYg8W91GH0hAlSfz9dV4=
X-Gm-Gg: ASbGncux+WacpSylL0s86GwPq30iPpAmZ4zTQ9z+XcZ+3yUkzEmJmasSH4k9V0fWmnu
	kmcmzt8qTFmyyojyC2xpgt2+2jf6L16zSQX8qMLRigfPDO6OpQre0RncOz6DBnrUKnOdB4XTTE6
	oMCPFHiKsfCQwlxLJ+DXntEyYVheAx4Lkj2oci0jm6wfFkhJ+TokMafgbW3omXXcuJ6VR8ev4Zu
	3oa4xuU8YYZAUq1JbH+wImF9ScNHTY/8axS7DmiewHvHrqv/ntel/RF7smfFZo6xO+d1maAa6lo
	NNulVuWlEAIOCOBkvpPvOCt8V1QL2ziO02ib/bCA0dGPl+3zsJLzCRnYXAMuCRFez7xEGCSWfqr
	8S74XO4lwHqV7HWnEx681ZA2d+QQwyXiVRR7CFvpxs798cy7i1JkkH/OHwkBgmCZBeNU=
X-Google-Smtp-Source: AGHT+IHuZPJvj5chfdbrdzBcDVd4tdia78dqN9AumnIHt0HsTrI5NBoiI28owPGskp0+wYu7G+MfVA==
X-Received: by 2002:a05:600c:4fd1:b0:46e:4abd:6515 with SMTP id 5b1f17b1804b1-46fa9af8ebcmr49616235e9.21.1760000680262;
        Thu, 09 Oct 2025 02:04:40 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9d4c8c5sm73350045e9.11.2025.10.09.02.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 02:04:39 -0700 (PDT)
Message-ID: <897c28a8-599f-44b3-8939-8279d2639f2c@linaro.org>
Date: Thu, 9 Oct 2025 10:04:38 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/25] perf arm_spe: Decode ASE and FP fields in other
 operation
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
References: <20250929-perf_support_arm_spev1-3-v1-0-1150b3c83857@arm.com>
 <20250929-perf_support_arm_spev1-3-v1-5-1150b3c83857@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250929-perf_support_arm_spev1-3-v1-5-1150b3c83857@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/09/2025 5:37 pm, Leo Yan wrote:
> Add a check for other operation, which prevents any incorrectly
> classifying. Parse the ASE and FP fields.
> 
> After:
> 
>    .  0000002f:  48 06                                           OTHER ASE FP INSN-OTHER
>    .  00000031:  b2 08 80 48 01 08 00 ff ff                      VA 0xffff000801488008
>    .  0000003a:  9a 00 00                                        LAT 0 XLAT
>    .  0000003d:  42 16                                           EV RETIRED L1D-ACCESS TLB-ACCESS
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 6 +++++-
>   tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h | 4 ++++
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index 533920b738cbcb39136d1ba3d88e99f9d8009e74..21b65a9b40f481b6cb25aaf01ab627ade046ff72 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -351,8 +351,12 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
>   				arm_spe_pkt_out_string(&err, &buf, &buf_len, " FP");
>   			if (payload & SPE_OP_PKT_SVE_PRED)
>   				arm_spe_pkt_out_string(&err, &buf, &buf_len, " PRED");
> -		} else {
> +		} else if (SPE_OP_PKT_OTHER_SUBCLASS_OTHER(payload)) {
>   			arm_spe_pkt_out_string(&err, &buf, &buf_len, "OTHER");
> +			if (payload & SPE_OP_PKT_OTHER_ASE)
> +				arm_spe_pkt_out_string(&err, &buf, &buf_len, " ASE");
> +			if (payload & SPE_OP_PKT_OTHER_FP)
> +				arm_spe_pkt_out_string(&err, &buf, &buf_len, " FP");
>   			arm_spe_pkt_out_string(&err, &buf, &buf_len, " %s",
>   					       payload & SPE_OP_PKT_COND ?
>   					       "COND-SELECT" : "INSN-OTHER");

A warning for unknown packet type would be useful here now that there is 
no final else catch-all.

> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> index 48bd9e9ef132b11b79ffe2e2fbc7cfe4c340ff92..704601c6dbe30e93f83a82670d0d60344a22222a 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> @@ -123,8 +123,12 @@ enum arm_spe_events {
>   #define SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC	0x1
>   #define SPE_OP_PKT_HDR_CLASS_BR_ERET		0x2
>   
> +#define SPE_OP_PKT_OTHER_SUBCLASS_OTHER(v)	(((v) & GENMASK_ULL(7, 3)) == 0x0)
>   #define SPE_OP_PKT_OTHER_SUBCLASS_SVE(v)	(((v) & (BIT(7) | BIT(3) | BIT(0))) == 0x8)
>   
> +#define SPE_OP_PKT_OTHER_ASE			BIT(2)
> +#define SPE_OP_PKT_OTHER_FP			BIT(1)
> +
>   #define SPE_OP_PKT_LDST_SUBCLASS_GP_REG(v)	(((v) & GENMASK_ULL(7, 1)) == 0x0)
>   #define SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP(v)	(((v) & GENMASK_ULL(7, 1)) == 0x4)
>   #define SPE_OP_PKT_LDST_SUBCLASS_UNSPEC_REG(v)	(((v) & GENMASK_ULL(7, 1)) == 0x10)
> 

