Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2B223DEB6
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Dec 2025 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765286275; cv=none; b=UnxNyZUtHTzlU/NHCgh9cWhkzh69WVuSg3iaO8wQ6kPbnaoJaF95FAlsZ7JGoiyEuyusOjg7KhE/oOc2o7VGPc1zflMVHn5dIAuTYA/7lMv5NZyX+qK/0KcEFHyhMZDQUsAviNKH4qIL6Q63Ifhrlwz+sTWSYNHpNzQQv6Jo5gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765286275; c=relaxed/simple;
	bh=EhUGZfNpKXNoslsyCqwDQrS3a7bufCc+Q4GvIRe9f2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DipJ/3JxKBiJfbKw1Zc4wIHBJytBq2hbepsaSbn9YFf/dnnBoQ9Ez9zojtsQAHjQzGXRKzIDs9iJBSzSUMDjSk7pCeWmvMCc9W3RUiucLhIOWfmem1QsbAKd4dlxZKH0joE3GE4tBf7vivfLmqpqqp6TsRF2n+/dEstJ1kzJfoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QC4paAmU; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QC4paAmU"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-429ce7e79f8so3519140f8f.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Dec 2025 05:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765286272; x=1765891072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6x4q7pYt+yBI8IV/ZgaXayi6EhlEVDj7sYbIN6bcwR8=;
        b=QC4paAmU0U32ndpCuQhIU2zx61rBdnR3ZR+Hvcht1NJ3/4rwxUXNcyM+/dT+mw/EUc
         Dg/f8Xxw7NU/QCe26QPG/Dc/9G2PF9K7XjdzqfXeiRv1/oweLGUirHRCw5hodXmVF3dd
         juXv/jNKM1TiZWuzTrI2BPFF6Kb5RddPSAwnAmaEPMiNHivfsUTkh5ckiTHYjxBbQaZN
         OgbXdBLQU6kUVVwvRzypxLNoNiDjwmn0SEDAukKJzUiQRn9IGCd7JG4cwLQ27VUZ214O
         Ap0uZQ+LyIkLU3TpHyq4Ib6lKL64lZbAN79nqjN2gN15te/xqaGZR0mVezPVTdydAcaX
         KRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765286272; x=1765891072;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6x4q7pYt+yBI8IV/ZgaXayi6EhlEVDj7sYbIN6bcwR8=;
        b=EgbQAqf62bEqFGoV2t6j+3l1poBspPVHB40IuRY8E0AlDOk4ISqqV7ZwH/8YTarksi
         okuARnDhUUzDv7ykvcLlf6tslSSH5+Cuu7CQhqK3z2rs0Ywfe90SzB7hej8T9OmGB183
         7y16fvKqdEYcyqoZpq285fn87DkkljGhffJtTNIzE1Nv4s5OimpCffEuXiJGwf7lIFn9
         MuTNx6tDzb9FlWKImBQXg9idWx1179lUs9n0FHBUEdWpArn3BMNqdGzw+s2FxRrJZ5Y4
         lhTjyK/Dv/ujNC1QIzPMIjR1tFi1uUVDzcdbewMbSYfrIMO+n8iKYaY/P4E2aY/GNiv9
         /S2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVg/Ml2MmB9QkBseP+4O8Vi0zxGJD/i0QDRCUzzP7uY4mNWxlw6OfM2jqG6K3sg+wTpISfxXeI4lNEBWnblQT8m@vger.kernel.org
X-Gm-Message-State: AOJu0YzxnVySo8CpJhzCgNbt3FUBk3NfxIBu5ouLvWAzAJARBzFho9T2
	gdcBIk3dxhd1ksxUwkO0rQYpxhy7RcLSLyedBcowSn1mHZah70mNSzIVSVWDpIDyWXM=
X-Gm-Gg: AY/fxX7PUoU9Fk0zITcE0eNR9uPSAdpOcwNJxIr8eugMymuKtsMXfBukPdukbCNwQYx
	Z/xpNgA0n5eMLck6Vqke/F24cq8cUadxAF/fyWM73CEXoAiPaIbEtW7lqMybMogKuuAjY0BYW/w
	k6gUtwaOgC24sZprpGBkkdkATPS4aeWU4ScJuGDKNOCs85cZSHFJIksIYIABVhoaT2EH6JZRFu1
	4E1d3xYl+3InkKSEeox/D1iFUtDjkpGmVRImwHCGlnbIODrgjJN+6w3bDvYImfrKfNbkbqBeCNn
	IeS3KYVjuC98Oj7cTKBHhnDiHJDdh1gqwVn479eF0pVMkBbWYmsJVm0eWXQ7YNRcg8u2f5FoHyC
	qlg5Y1mJLhvnMCy2D8QTKffuxE0L+7YJDfszLLrPrkRlUussSEvLAvZXFXEo+7oNaEOT3a1VQ09
	Bjb3c4O6+nplQvgFPY
X-Google-Smtp-Source: AGHT+IFkh1qNBfsdlzavryRRrHz55vGlnsqEVl3PW1eyYgIUgYX4YzhkI06ypPZmgVor+ogQtygTpQ==
X-Received: by 2002:a05:6000:2008:b0:42b:3b62:cd86 with SMTP id ffacd0b85a97d-42f89f09474mr10823996f8f.6.1765286271664;
        Tue, 09 Dec 2025 05:17:51 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbfeb38sm31235105f8f.12.2025.12.09.05.17.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 05:17:51 -0800 (PST)
Message-ID: <1c1092e6-aa5d-4bb1-84e5-81151a02cc6f@linaro.org>
Date: Tue, 9 Dec 2025 13:17:50 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/19] coresight: trbe: Refactor syndrome decoding
To: Leo Yan <leo.yan@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Mike Leach <mike.leach@linaro.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Tamas Petz <tamas.petz@arm.com>,
 Tamas Zsoldos <tamas.zsoldos@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
 <20251201-trbe_buffer_refactor_v1-1-v1-6-7da32b076b28@arm.com>
 <65c84357-0bda-454f-88c3-623b3ff9d29d@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <65c84357-0bda-454f-88c3-623b3ff9d29d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 02/12/2025 11:06 am, Suzuki K Poulose wrote:
> Hi Leo
> 
> A couple of minor nits below. Otherwise looks like a nice cleanup
> 
> 
> On 01/12/2025 11:21, Leo Yan wrote:
>> It gives priority to TRBSR_EL1.EA (external abort); an external abort
>> will immediately bail out and return an error.
>>
>> Next, the syndrome decoding is refactored based on two levels of
>> information: the EC (Event Class) bits and the BSC (Trace Buffer Status
>> Code) bits.
>>
>> If TRBSR_EL1.EC==0b000000, the driver continues parsing TRBSR_EL1.BSC to
>> identify the specific trace buffer event.  Otherwise, any non-zero
>> TRBSR_EL1.EC is treated as an error.
>>
>> For error cases, the driver prints an error string and dumps registers
>> for debugging.
> 
> minor nit: Please avoid describing the code, which cod does well.
> Briefly mention what you are doing, giving any additional contexts
> that may not be evident from the code.
> 
> e.g:
> 
> "Add support for decoding the syndrome for TRBE, providing a verbose
> description of the code for Fatal/unhandled events.
> While at it add the new definitions from the latest Arm ARM for
> EC and BSC"
> 
> 
> 
> 
>>
>> No additional checks are required for wrap mode beyond verifying the
>> TRBSR_EL1.WRAP bit, even on units with overwrite errata, as this bit
> 
> 
>> reliably indicates a buffer wrap.
>>
>> Signed-off-by: Leo Yan <leo.yan@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-trbe.c | 60 ++++++++++++++++++ 
>> +++-------
>>   drivers/hwtracing/coresight/coresight-trbe.h |  8 ++--
>>   2 files changed, 51 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/ 
>> hwtracing/coresight/coresight-trbe.c
>> index 
>> 9e565122816949b37b8ff5e4ba04cfbc317c6f25..28e2bfa68074f19ccaa4a737d00af577aea818fe 100644
>> --- a/drivers/hwtracing/coresight/coresight-trbe.c
>> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
>> @@ -643,29 +643,61 @@ static void trbe_enable_hw(struct trbe_buf *buf)
>>   static enum trbe_fault_action trbe_get_fault_act(struct 
>> perf_output_handle *handle,
>>                            u64 trbsr)
>>   {
>> +    const char *err_str;
>>       int ec = get_trbe_ec(trbsr);
>>       int bsc = get_trbe_bsc(trbsr);
>> -    struct trbe_buf *buf = etm_perf_sink_config(handle);
>> -    struct trbe_cpudata *cpudata = buf->cpudata;
>>       WARN_ON(is_trbe_running(trbsr));
>> -    if (is_trbe_trg(trbsr) || is_trbe_abort(trbsr))
>> -        return TRBE_FAULT_ACT_FATAL;
>> -    if ((ec == TRBE_EC_STAGE1_ABORT) || (ec == TRBE_EC_STAGE2_ABORT))
>> -        return TRBE_FAULT_ACT_FATAL;
>> +    if (is_trbe_abort(trbsr)) {
>> +        err_str = "External abort";
>> +        goto out_fatal;
>> +    }
>> -    /*
>> -     * If the trbe is affected by TRBE_WORKAROUND_OVERWRITE_FILL_MODE,
>> -     * it might write data after a WRAP event in the fill mode.
>> -     * Thus the check TRBPTR == TRBBASER will not be honored.
>> -     */
>> -    if ((is_trbe_wrap(trbsr) && (ec == TRBE_EC_OTHERS) && (bsc == 
>> TRBE_BSC_FILLED)) &&
>> -        (trbe_may_overwrite_in_fill_mode(cpudata) ||
>> -         get_trbe_write_pointer() == get_trbe_base_pointer()))
>> +    switch (ec) {
>> +    case TRBE_EC_OTHERS:
>> +        break;
>> +    case TRBE_EC_BUF_MGMT_IMPL:
>> +        err_str = "Unexpected implemented management";
> 
> minor nit: "Unexpected IMPDEF buffer management event"
> 
> 
> Suzuki
> 
>> +        goto out_fatal;
>> +    case TRBE_EC_GP_CHECK_FAULT:
>> +        err_str = "Granule Protection Check fault";
>> +        goto out_fatal;
>> +    case TRBE_EC_STAGE1_ABORT:
>> +        err_str = "Stage 1 data abort";
>> +        goto out_fatal;
>> +    case TRBE_EC_STAGE2_ABORT:
>> +        err_str = "Stage 2 data abort";
>> +        goto out_fatal;
>> +    default:
>> +        err_str = "Unknown error code";
>> +        goto out_fatal;
>> +    }
>> +
>> +    switch (bsc) {
>> +    case TRBE_BSC_NOT_STOPPED:
>> +        break;
>> +    case TRBE_BSC_FILLED:
>> +        break;
>> +    case TRBE_BSC_TRIGGERED:
>> +        err_str = "Unexpected trigger status";
>> +        goto out_fatal;
>> +    default:
>> +        err_str = "Unexpected buffer status code";
>> +        goto out_fatal;
>> +    }
>> +
>> +    if (is_trbe_wrap(trbsr))
>>           return TRBE_FAULT_ACT_WRAP;
>>       return TRBE_FAULT_ACT_SPURIOUS;
>> +
>> +out_fatal:
>> +    pr_err_ratelimited("%s on CPU %d [TRBSR=0x%016llx, 
>> TRBPTR=0x%016llx, TRBLIMITR=0x%016llx]\n",
>> +               err_str, smp_processor_id(), trbsr,
>> +               read_sysreg_s(SYS_TRBPTR_EL1),
>> +               read_sysreg_s(SYS_TRBLIMITR_EL1));

Don't you need to use %p to not leak pointers?

>> +    return TRBE_FAULT_ACT_FATAL;
>>   }
>>   static unsigned long trbe_get_trace_size(struct perf_output_handle 
>> *handle,
>> diff --git a/drivers/hwtracing/coresight/coresight-trbe.h b/drivers/ 
>> hwtracing/coresight/coresight-trbe.h
>> index 
>> 45202c48accec7c86ba56130e2737bc2d1830fae..d7f7cd763c0c7139cf322b7336ee563073e3bea0 100644
>> --- a/drivers/hwtracing/coresight/coresight-trbe.h
>> +++ b/drivers/hwtracing/coresight/coresight-trbe.h
>> @@ -35,9 +35,11 @@ static inline bool is_trbe_enabled(void)
>>       return trblimitr & TRBLIMITR_EL1_E;
>>   }
>> -#define TRBE_EC_OTHERS        0
>> -#define TRBE_EC_STAGE1_ABORT    36
>> -#define TRBE_EC_STAGE2_ABORT    37
>> +#define TRBE_EC_OTHERS            0x0
>> +#define TRBE_EC_GP_CHECK_FAULT        0X1e
>> +#define TRBE_EC_BUF_MGMT_IMPL        0x1f
>> +#define TRBE_EC_STAGE1_ABORT        0x24
>> +#define TRBE_EC_STAGE2_ABORT        0x25

I know some were already defined here, but this should probably be an 
enum in sysreg.

>>   static inline int get_trbe_ec(u64 trbsr)
>>   {
>>
> 

