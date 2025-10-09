Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C501862A
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Oct 2025 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760002429; cv=none; b=n4s1sPwm73lAuzC7vE8Bsvumgha/rLDfwA6Utulnla8luVWMCkyJxzB8kfsUHOvdzhsE7mteUHG/haWHADBNFKA+0UyDspptrckpu1GTHxv9bSm9fuCX8AF5C4/d+5iPUlkONJsE4JWlI+6fnFaTkx1MVxC+YAegIZd/FBzycyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760002429; c=relaxed/simple;
	bh=L4wloDqaMlYz4aA1rti5dc5IAgkSV9wEiUe4Tiq+gA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dr1w7PSPVgnUednHP5tJ4jXKFWvAXwSH4fA6AK806BzfyknVcIB/UdA3WyaXbUuT0dX5qwrkhakxIyzG01fwpDE/cyUn2d4ghjfKFuuj91ikUUwm9XzEv9t1SNkFeHXCN4Qg5W6Hm+woJ/h9BJcfKmrx3cE9pd0w96mHOT+VD88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xGNxcUBa; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xGNxcUBa"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e6674caa5so4376765e9.0
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Oct 2025 02:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760002426; x=1760607226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GLLcZPWRUnnpdUZy/o5VvMg5k4e/Wy0T75t8BL7fr3o=;
        b=xGNxcUBa260xmSgEvPjyvsIzj8Ibwo8iygbS56F4L35prtI86WtqFv3jB/9qLzgvKE
         +zR6Sb3MGDZdlsBT2XUkBK1iTOii1v5wLmde7Cv4dQmirXJSzcNyDtEzsIdc3MwDiK3Q
         brLOPOHtI7rIuFrVcZ0pixrmX2T8/t60RM+NZk35KGKIsIFCEbN04p5Aps9NUvzpBZCx
         8XMyVMGpm9NyLtIyirS5Qkl7LXxDUP2bzRpnxzz6fUhC0ABovHJXcfHmoKxn7oS+TcLP
         8DFMVXbMympU5z2vCnE1ZYkxicfxcBzJsmxsd+i1Z+NKYuMC2BtZFY7QcMExDtdANQf9
         z8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760002426; x=1760607226;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GLLcZPWRUnnpdUZy/o5VvMg5k4e/Wy0T75t8BL7fr3o=;
        b=Juyfa8fLyHsNIm7SzdWadKXkrDKZysxL2Co7Bjq9dTEtXFKLEcZbmOU9uKYQesNlml
         uuG9dvmYIGG0Rs87Ci+heqOsmwzmeUrzez4V68wJY3d/uOWTdfDVbPLX4x93xthbLHNd
         tAgxYMHH4fW61FiZFH8NOeCv/REOsQ4AaSyjscT4BjNDypem+hev+xmuJN7Qeq8x8ToG
         LObSd2WjtE9ODyXy2F0yge+pPVPomoFkWO9VyPR9mt6fCDY7I63FhHaHs6Nc+HGdwSz9
         cBCIMkVBDtkcXrKmVVQKByl53F1UjuuggXClp78clrVgguk96+33nDfOb98DSV0zZ/jK
         aFhw==
X-Forwarded-Encrypted: i=1; AJvYcCVpVTNlaxKJd2y+IxFbh/LkVbi1PyPaBJ3NLFA6zvpxsuqjoEHKvPxHbEgS8ngkJP0tG7L8Ac/ekp5MIn058sfH@vger.kernel.org
X-Gm-Message-State: AOJu0YzRINfA3JzsA0kcJ3ujRHP9I8EipRjzRbjOMgqUmWEacrZJPRgx
	av89+cYJBLHTTxqiLLlz68bB+7ZDSNFIMqZlZDO9k3s2PVrVBtMmbwrwUdj3W5SnkSE=
X-Gm-Gg: ASbGncsBTNisp6UBUyQQTXfKQ5ExEFI0RpoQwi7gqiqLWAl1p+snRkdgTIEfF22ws0J
	OzwRbQtprVsBkWhHG/mhH+mtdmak8Nq4QUPHqhX+0L62V8+uX34xcs3GmqbJEtSIPLfnZdMNMaU
	be5XoajaCmV4+GGFOYBJDm1Qpdqn8B3d9K29/ap1WyCT0uotTwnrFay1PJTha+CrS7nIEjpBql+
	h9cYQjYKRweJI6z5SMAjMPfDmr6ntlGR/QhvWSKZqjrQs1eY3UF9/pSUcrd0WVdmXoFJZCcOX2N
	m0jtWCYknh3Imo1J1xPL0Ac6/KY1C1qMjZtnydu+nEIut6++J1QweZkmwort2TbDZQpqxDjH30p
	FDaauvLVXQsup55oD8LcfFACUgnPfzO6MMfv8q4iNe7VKZeWpEuaSVibF
X-Google-Smtp-Source: AGHT+IFH4mCbB8Mnz2KZz0nPpaJC0TAPdqbeGBiJXfrxVSiIKaTmawcfA8u+K9lUm/1qkWkfI7jWJw==
X-Received: by 2002:a05:600c:5486:b0:45f:29eb:2148 with SMTP id 5b1f17b1804b1-46fa9e98810mr47289835e9.7.1760002426259;
        Thu, 09 Oct 2025 02:33:46 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9d62890sm73517555e9.14.2025.10.09.02.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 02:33:45 -0700 (PDT)
Message-ID: <af9c5819-becd-4f51-a379-ec62dc08d8b0@linaro.org>
Date: Thu, 9 Oct 2025 10:33:44 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/25] perf arm_spe: Report memset and memcpy in records
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
References: <20250929-perf_support_arm_spev1-3-v1-0-1150b3c83857@arm.com>
 <20250929-perf_support_arm_spev1-3-v1-14-1150b3c83857@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250929-perf_support_arm_spev1-3-v1-14-1150b3c83857@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/09/2025 5:37 pm, Leo Yan wrote:
> Expose memset and memcpy related info in records.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 4 ++++
>   tools/perf/util/arm-spe-decoder/arm-spe-decoder.h | 4 +++-
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> index 5b214fc4ca9f67cf11700a18939f37f4a5400b84..6f0390d4089599cd6bbf1357fa4cd6ec8190a58c 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> @@ -224,6 +224,10 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
>   						decoder->record.op |= ARM_SPE_OP_PRED;
>   					if (payload & SPE_OP_PKT_SVE_SG)
>   						decoder->record.op |= ARM_SPE_OP_SG;
> +				} else if (SPE_OP_PKT_LDST_SUBCLASS_MEMCPY(payload)) {
> +					decoder->record.op |= ARM_SPE_OP_MEMCPY;
> +				} else if (SPE_OP_PKT_LDST_SUBCLASS_MEMSET(payload)) {
> +					decoder->record.op |= ARM_SPE_OP_MEMSET;
>   				}
>   
>   				break;
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> index 87d45c11ad7483c167b4d9cb2e481a001f54e5cc..565458a7a6cbd94d67803cc122154cb5cab4f308 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> @@ -43,7 +43,9 @@ enum arm_spe_op_type {
>   	ARM_SPE_OP_NV_SYSREG		= 1 << 10,
>   	ARM_SPE_OP_SIMD_FP		= 1 << 11,
>   	ARM_SPE_OP_MTE_TAG		= 1 << 12,
> -	ARM_SPE_OP_SVE			= 1 << 13,
> +	ARM_SPE_OP_MEMCPY		= 1 << 13,
> +	ARM_SPE_OP_MEMSET		= 1 << 14,
> +	ARM_SPE_OP_SVE			= 1 << 15,

Same comment as patch 11

>   
>   	/* Assisted information for memory / SIMD */
>   	ARM_SPE_OP_LD			= 1 << 20,
> 

