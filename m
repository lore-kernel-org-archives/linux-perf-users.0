Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8B44B1CE0
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 09:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403114; cv=none; b=NYv4nXNCmfNPJx9L1Jmuw/bSBZKcB71P1N466877FUc8IEyfapXbqqWyo85L7PgxSV9118clQEqLSriTEE+cB2J9rLrOQF1cnqxuWELbAQKXhL5q7cr2mU6VKNRZwrO/NUgsquk6XhH76/cTUQ8bUqAcw6+Jgci3UtRYEhWEkjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403114; c=relaxed/simple;
	bh=Jaiqy8f/Sl/4tupxPExjmNLGv0E136+VgC8GLOr8zAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U1Obhp9HMBDf9bdPlfFEK/9f1fUQRwy5KmDa0QBmykkBEgzDFPEb5QB6m/Kqec6UnR0uq3RfrSdR11fRL8rgwtHLtBcQHo347KNuBEacvuIMoh3B/2WHEHcxFA8kZmDC3kEe5dyAUbCnHuOHldDRcx3JIncgz2cYXrxSGWrO9MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JbSKM7lN; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JbSKM7lN"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4956869750eso14268585e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 02:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792403112; x=1793007912; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oSec+D9Gcxlfy6q4kTQg7A+nAzcOiDEiKgFT1VAeycs=;
        b=JbSKM7lNrads5fWAUDmMw60KD1SobfFsolHTyqmg6SL3wD9a97LpwNYiS8OERuSeY+
         EiDgB+/AXfby9l2lKhO0PM97LS4KiN3NvpCBGHzkt4fur2SgIBVS1OmmXItEadpopmYz
         LVxBU2oLv+yUUP9w8hU/CWJ+Fm2iMa7kKi3LoBtqr/W9y0pQjE7xvVwIaV3F3v+Wg/TL
         REhmpJhehn/ZJ0eWuSrp7djVXpBg0Q69DVINitP0DBT/v6LHjDaQ84fn/a8PGcaOt0oK
         d6csRVWVt/6MvfmGM40lwG+oT5nMe7DBkU5e4HEGX+INArrPfPK1+r6hI2qIJtjzDgYM
         1SqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792403112; x=1793007912;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oSec+D9Gcxlfy6q4kTQg7A+nAzcOiDEiKgFT1VAeycs=;
        b=vu/pNgEZuQ3XvpkWSETXLdEV6XP3zkB18u0BhKbBhHTmcf7pk0+j+RokZjX4Y4vL/+
         ie5mQcxS2CcSOjYdZBjNQg6em+ongv30kNnK/lbiicXv/+DIvCGKO62N+nBB3InSasnA
         S5jCwk6wy4g4q7muheht1jTGHq73ANi4A8LJi+LKiup5yqoVIGw41qDObQ78kQhq2T+1
         SP9ysUv1TBbP9X8Pffz++L57yZLbBIRoXWBYwwg3+1JIFg3ghU2bPpJqEHq+96KLj1B6
         eOKE2ut7RbHUBbRb+apU5jAF7H6RWGZGnvxIXpSx72n8lukUki64WAGJRJO0hnWSI2QY
         ZzbQ==
X-Forwarded-Encrypted: i=1; AKwUvBxV50B76m2LKr0OP7vM0dco0jdJRSfaU2GV3h4TAt1raPk/hX5KGUoZnb0vUbX22dz+eqduAbEn+17KMXE+VzZp@vger.kernel.org
X-Gm-Message-State: AFq9FYJfGOtf8gmbIS0AX8UulrIi8nrRhG/qiymuuUGPlnjImqB3NhNi
	GJmY94hLkiN37SNKopnZe/S40RVuhzlBisackvgGKedlmT/WJpxjh7TBkn/At4YotpM=
X-Gm-Gg: AYBFou0uHkXQ8FXFqlsdBSWotTAOq+/W11b92JnlJB1/KXeUnJFMdMMAVg3fy31RBwc
	wQwBzDqeuZd2Hmh+pGknOYjp0wOjqSXT71amIMQCTqEmF8ObbFo8b9GXiGjAXiiZoSQsz4zIJDk
	9OCxEXwXfvTA/C3op9aMpLOVya6mfRYEJf0Nep9x90r/hvaGVodjtfIGmUup2aa3YgXIlX3Ibzr
	iarDElKZtLhqh4S/UAzQBEjx5yPmBGdKnthU9DgbmWAn1ndOFZdwy0gG01Hv07gljWTCquhIKBu
	UuwWz0gsU2lsDbmxlXc/BcVW4pFFwRDGOrTfFMBbr58SjJXWddzzqZfH8OmKAUMEXbckkpmT0Bh
	dooBkYiqGbwCAYmRZ/NJsuJ48C3+mChnkbx+ueKGFR6vHZ2T3aHam9PUUIW0NwWRNI44cuDyfXz
	wi3oqF+xv53Z4g8tyfSTC3HUg93QuBnHxg1fVxPpFm8/Y/dR2Jf9ftw+JLWsOPK1sG0k4oh2XB1
	ow=
X-Received: by 2002:a05:600c:1395:b0:4a1:c6fe:5c0e with SMTP id 5b1f17b1804b1-4a1d76148e6mr149657955e9.33.1792403111528;
        Mon, 19 Oct 2026 02:45:11 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd91c55bsm311684915e9.0.2026.10.19.02.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 02:45:11 -0700 (PDT)
Message-ID: <3d4a1883-3600-4e83-96ca-ccaec398fe91@linaro.org>
Date: Mon, 19 Oct 2026 10:45:09 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/25] coresight: trbe: Pad snapshot buffers
To: Leo Yan <leo.yan@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
References: <20260915-arm_cs_support_aux_sample-v1-0-35cf6f297d20@arm.com>
 <20260915-arm_cs_support_aux_sample-v1-10-35cf6f297d20@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260915-arm_cs_support_aux_sample-v1-10-35cf6f297d20@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/09/2026 16:48, Leo Yan wrote:
> Snapshot buffers use the head as the write pointer without checking its
> alignment or the space remaining before the limit. After a stop or a
> move to another CPU, the head can be misaligned for the current TRBE.
> It can also leave too little space for the Fill mode out-of-range
> workaround.
> 
> Pad the head to the current CPU's alignment. If the remaining buffer
> cannot hold the minimum trace region, pad to the end of buffer. Update
> the head for setting next write pointer.
> 
> Fixes: 3fbf7f011f24 ("coresight: sink: Add TRBE driver")
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-trbe.c | 36 ++++++++++++++++++----------
>   1 file changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index c7cbca45f2debd4047b93283ea9fe5dd9e1f2ebf..a31f2ebc327cd681344a62de28c0b3840505a9cb 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -374,18 +374,6 @@ static void trbe_pad_buf(struct perf_output_handle *handle, int len)
>   		perf_aux_output_skip(handle, len);
>   }
>   
> -static unsigned long trbe_snapshot_offset(struct perf_output_handle *handle)
> -{
> -	struct trbe_buf *buf = etm_perf_sink_config(handle);
> -
> -	/*
> -	 * The ETE trace has alignment synchronization packets allowing
> -	 * the decoder to reset in case of an overflow or corruption.
> -	 * So we can use the entire buffer for the snapshot mode.
> -	 */
> -	return buf->nr_pages * PAGE_SIZE;
> -}
> -
>   static u64 trbe_min_trace_buf_size(struct perf_output_handle *handle)
>   {
>   	u64 size = TRBE_TRACE_MIN_BUF_SIZE;
> @@ -405,6 +393,30 @@ static u64 trbe_min_trace_buf_size(struct perf_output_handle *handle)
>   	return size;
>   }
>   
> +static unsigned long trbe_snapshot_offset(struct perf_output_handle *handle)
> +{
> +	struct trbe_buf *buf = etm_perf_sink_config(handle);
> +	struct trbe_cpudata *cpudata = buf->cpudata;
> +	u64 buf_size = (u64)buf->nr_pages << PAGE_SHIFT;
> +	u64 head = PERF_IDX2OFF(handle->head, buf);
> +	u64 next = round_up(head, cpudata->trbe_align);
> +
> +	/*
> +	 * A task event may migrate to a CPU with a different alignment or
> +	 * errata. Make sure it has enough space, pad up to the alignment
> +	 * required by the current TRBE.
> +	 */
> +	if (buf_size - next < trbe_min_trace_buf_size(handle))
> +		next = buf_size;
> +
> +	if (next != head) {
> +		__trbe_pad_buf(buf, head, next - head);
> +		handle->head += next - head;
> +	}
> +
> +	return buf_size;
> +}
> +
>   /*
>    * TRBE Limit Calculation
>    *
> 

Wouldn't it make sense to have compute_trbe_buffer_limit() do the 
padding now that it happens for both normal and snapshot mode?

Either way:

Reviewed-by: James Clark <james.clark@linaro.org>

