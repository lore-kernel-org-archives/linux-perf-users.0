Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB2D2566E2
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Oct 2025 09:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760001489; cv=none; b=pQ3wtiCb1itvDpgiVUnYzAGbN62cHmEYHCjrwqV6CgqAS4gqCAj2m0uN/QMq+Qy83locyKCQlog6T5X1bKdHjmKZqzHuYxRJoWPRoYJLzhs+qg40v6g5k+nMeG9FipyQAbge2GEA9DbCZWBsvh983cLzLmHAvOE5OPdB66TMPYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760001489; c=relaxed/simple;
	bh=+W8reuiaEDQW+QrY17ZbiulSCYEFdZf3CGmBxUajDCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m+7qjhmlRGQQxDAUF2IBfau5wYeas0dFp9iuE1Md8ZgAQtZT/dvoR64jgANBaZWo1KkUi4I3FAIqMXEVhwRehtseXxUpS+tYi+Yitxg2bUNuDenlT6s8vVddz1tWNHLnNCwC9X/9MYx35sw2qfW0nhP0JXzNumX0LJ+GAYhe+TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M2atd4Tl; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M2atd4Tl"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e430494ccso4285075e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Oct 2025 02:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760001485; x=1760606285; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RUiCTQ3L5vyJ1npU/Ek1l1Cxj0jZdtJk6kQTDX+q4eM=;
        b=M2atd4Tljv742Sz6VPYIgeqWt4301JxYxn7K3liufXmMZu8Ym1yIzryLKvQfA37OhX
         x27Rcu6NBobWfwZnLOxvPHIvyTVC8LQO9gN4tEHSG79xHKDitCeKW3dS8V27bGKBFEKH
         5882AhdBdxPMr3As+AcG+QXAEVbaR9yql+NfYFZdEHTCW3raI4pGEFcZWO1Vn2mcfafO
         pz/RSpFp8PIZqqCmbHvRMFzGtQ79F+BaiRTTQFF04ncv2H7PbJOJPAJjMeGHx8NkOUb6
         P8bSGTKMmCsGzNoq0LyUOu6aGcI1ld5aIVLN2v1IgKFRC5S1FWQE+ufMmRl3ar7kgT4/
         odUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760001485; x=1760606285;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RUiCTQ3L5vyJ1npU/Ek1l1Cxj0jZdtJk6kQTDX+q4eM=;
        b=FXytiYn6f3zfO+FAXd90oEWPN0vma1BKCWW6qu/Ugxvr5ocBFPZJmXfcesCI2fX4e0
         jlPo3zUXatcQu+mdvlriXCQQTAs5Dick09sAX8U52Oc5wP7g8qH6WmgTbtacKY6JAmFf
         pRdKPDKceeQB8nVuehkKaM0pBAaQp6HI9bLbW3dsW0hlGJIQYFvWZPKumf4/OFzXohds
         RtDEFuRI0lUYfNa/YVbuhS0eYW0O+kEnpkc89qskD1aeKHgIM2TOivFYi4EbLMaTicQg
         efCPZJ+FWkYTDS2S0YzfXXKltxjz0B0Meq9fKg9eLq2qZPzSw5kQrKBri5/xuCYW55AR
         bbQw==
X-Forwarded-Encrypted: i=1; AJvYcCVHbITSY0/h0lWQDXbZfs5gf/kNEBj++F7SZhxjDIwBlZ8n/RSZu7IfIcyjk/0nxSHZ/5YObTMoszDZrGG2TfwG@vger.kernel.org
X-Gm-Message-State: AOJu0YzL8rbtnZ1XIni23zj8smuP+XqKyT4Dx7N1UrHMW0VJck8rBybJ
	fySbM6WPwNRrK/mMDMYSwWj9cjPi1KZBcQFMdiq52DF2T9uWTCUzhIdCsJmNawy5s8Q=
X-Gm-Gg: ASbGnctctRQk3x+Y0P4n2fTbOv9kwTbKBLAUKbL56D7GN7zhuQ0CeKJs78I4rLXHEyh
	PV1K5W9mSpEg/cOewwwoqeEKDcicZcliZ3kMEBzGRXOsmcd8QBUSvriGeP4eOktH8qvqeMn8cKl
	u5JJ1vNyN9wxovKufxn47NuM1N64wVqvUvnIO3+KMqQWUK3loTA4LnqD+nWxCy8+pP/L6vsT0/G
	azX8c6el9HEu1gC3RhiOSt3ZcxtN/vG5VBO/UUJrsxwXLBxjFNj+34xIn6LBOGltbcIdJxXAoWY
	JTIct9jXFVwqqfXCctuxioz0QW6pbCAOWSrokeaxvtv05y677Jv5Rfp3DZwVfhK18g1X3V9L1MV
	StHSXDVGSkAdZ0HAxdNp5dOOqLHENMtrZlsgPtKp9LsRJzEmkihZh1LJHqGwTGmxLaddBsEMabh
	4w/Q==
X-Google-Smtp-Source: AGHT+IHtSgHPb6AVg9rdfLA09kZRMiuW6l7Gm8b/VBTmTW5QLOQGmo05tlRDmK++reg15GI7jX/9Mg==
X-Received: by 2002:a05:600c:198f:b0:46e:38cc:d3e2 with SMTP id 5b1f17b1804b1-46fa9af3125mr45681515e9.22.1760001484904;
        Thu, 09 Oct 2025 02:18:04 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9bf8288sm75584245e9.2.2025.10.09.02.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 02:18:04 -0700 (PDT)
Message-ID: <6cd67290-a673-4375-b8b5-a8ed68b0ee72@linaro.org>
Date: Thu, 9 Oct 2025 10:18:03 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/25] perf arm_spe: Consolidate operation types
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
References: <20250929-perf_support_arm_spev1-3-v1-0-1150b3c83857@arm.com>
 <20250929-perf_support_arm_spev1-3-v1-8-1150b3c83857@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250929-perf_support_arm_spev1-3-v1-8-1150b3c83857@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/09/2025 5:37 pm, Leo Yan wrote:
> Consolidate operation types in a way:
> 
> (a) The second-level types for memory and SIMD operations are classified
>      by modules. E.g., an operation may relate to general register,
>      SIMD/FP, SVE, etc.
> 
> (b) The associated information tells details. E.g., an operation is
>      load or store, whether it is atomic operation, etc.
> 
> Start the enum items for the second-level types from 8 to accommodate
> more entries within a 32-bit integer.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/arm-spe-decoder/arm-spe-decoder.h | 40 +++++++++++------------
>   1 file changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> index 1259cbadfdc8098019afcd4cf65e733475310392..8156aa04f82e59ce345fb44223d3d22ecbc149a7 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> @@ -37,28 +37,28 @@ enum arm_spe_op_type {
>   	ARM_SPE_OP_LDST		= 1 << 1,
>   	ARM_SPE_OP_BRANCH_ERET	= 1 << 2,
>   
> -	/* Second level operation type for OTHER */
> -	ARM_SPE_OP_SVE_OTHER		= 1 << 16,
> -
> -	/* Second level operation type for LDST */
> -	ARM_SPE_OP_LD			= 1 << 16,
> -	ARM_SPE_OP_ST			= 1 << 17,
> -	ARM_SPE_OP_ATOMIC		= 1 << 18,
> -	ARM_SPE_OP_EXCL			= 1 << 19,
> -	ARM_SPE_OP_AR			= 1 << 20,
> -	ARM_SPE_OP_SIMD_FP		= 1 << 21,
> -	ARM_SPE_OP_GP_REG		= 1 << 22,
> -	ARM_SPE_OP_UNSPEC_REG		= 1 << 23,
> -	ARM_SPE_OP_NV_SYSREG		= 1 << 24,
> -	ARM_SPE_OP_SVE_LDST		= 1 << 25,
> +	/* Second level operation type for memory / SIMD */
> +	ARM_SPE_OP_GP_REG		= 1 << 8,
> +	ARM_SPE_OP_UNSPEC_REG		= 1 << 9,
> +	ARM_SPE_OP_NV_SYSREG		= 1 << 10,
> +	ARM_SPE_OP_SIMD_FP		= 1 << 11,
> +	ARM_SPE_OP_SVE_OTHER		= 1 << 12,
> +	ARM_SPE_OP_SVE_LDST		= 1 << 13,
> +
> +	/* Assisted information for memory / SIMD */
> +	ARM_SPE_OP_LD			= 1 << 20,
> +	ARM_SPE_OP_ST			= 1 << 21,
> +	ARM_SPE_OP_ATOMIC		= 1 << 22,
> +	ARM_SPE_OP_EXCL			= 1 << 23,
> +	ARM_SPE_OP_AR			= 1 << 24,
>   
>   	/* Second level operation type for BRANCH_ERET */
> -	ARM_SPE_OP_BR_COND		= 1 << 16,
> -	ARM_SPE_OP_BR_INDIRECT		= 1 << 17,
> -	ARM_SPE_OP_BR_GCS		= 1 << 18,
> -	ARM_SPE_OP_BR_CR_BL		= 1 << 19,
> -	ARM_SPE_OP_BR_CR_RET		= 1 << 20,
> -	ARM_SPE_OP_BR_CR_NON_BL_RET	= 1 << 21,
> +	ARM_SPE_OP_BR_COND		= 1 << 8,

I know it was already like this, but this should be multiple enums 
stored in a union. Having an enum with duplicate values is a bit of an 
abuse of the language. It takes more effort to understand it to 
carefully make future modifications too.

With multiple enums you don't need to rely on a comment to describe 
them, because that info would be in the name, like "enum 
arm_spe_2nd_op_ldst", "enum arm_spe_2nd_op_mem" etc.


> +	ARM_SPE_OP_BR_INDIRECT		= 1 << 9,
> +	ARM_SPE_OP_BR_GCS		= 1 << 10,
> +	ARM_SPE_OP_BR_CR_BL		= 1 << 11,
> +	ARM_SPE_OP_BR_CR_RET		= 1 << 12,
> +	ARM_SPE_OP_BR_CR_NON_BL_RET	= 1 << 13,
>   };
>   
>   enum arm_spe_common_data_source {
> 

