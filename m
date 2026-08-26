Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352933B95E9
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Aug 2026 08:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787734378; cv=none; b=e9fJZjO+D5MURm5cYe7KHSDUhrl356s/pm7/SZLN40WzmGT2w8V5zVxxlUvsaj7ojaqA/CrikHu0BoMD18gyvNnjv3D3wodeT6o6cL86mNICouJYydInb8yX4zDFr3+x1KrLi+aqbTCvZNw08zYDx4UGe3uNUTYRQN3nyVsUE5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787734378; c=relaxed/simple;
	bh=yWIXE6NSupjLIMqgnwrU9Ekw1tdcWA17gP1l4IFMCd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QpodCVK4FgyWOubxUPiH5FyqorntffuyQWEiP4oYXYcIf3NYs0Sbqs1nB02dQ/LQH39X1Agd2zpGDSXkQWCl8JomX8hLt7PljUqNLP+d6k0lwzO4xXr9AQchA++yAfwbBxQrLdiJhmpRY+mvAIyuLMTizVrJc8F1hZy/6N5cTSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x/606Wun; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x/606Wun"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4998e0916faso2831255e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Aug 2026 01:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787734373; x=1788339173; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=he6YwXVn2qSwzTZYN9HEDa44GhjQ2natPAQ78fbCcSk=;
        b=x/606WunK2BDMPe4+VWwe9W1uJSf3NrqXpwC7Rm+UXJDgiGdMzBr4jpXvudJo2zkKv
         DPhunFrUzCDc3DWQ0j2ZaDngvz624DfArj1tmgf88HeOPvGUuCy7ZFF+puUUKURuCF+J
         vOEI/3YRxD5CTX7PNsfFGlVxrLNkNpmOVEDdgfFe7mEgre9Ilj+6Qqp8peM3HXkLovKx
         VcN1+bGrv5NXnBRiRXt2/0pZ+XaaSLMDb0IFRWiPmXblnUMUvM36v871rrgjL7iHMCgh
         wUAr3ZoW1SicVjqMv49g3ahKhAbvCU4/TMu/amIRXT7trOdMlSwW8YINVK5D5+e5IgwG
         Y88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787734373; x=1788339173;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=he6YwXVn2qSwzTZYN9HEDa44GhjQ2natPAQ78fbCcSk=;
        b=FfrTyd12Na25+ruNe79tsJgbSBG6N1zUkylLdEqvtp3a78fkdeft+CLQdQi33Yobbq
         RsAbZsaik++Il9VX8jJzVFhA968ZUL8aIb6TJhbeZym31dHoXp3nLa4E+3ZeR3SbvacX
         laQNkIGG/4EACB7x3RZjspLjPvYNgXPjtwQN2xDU7UUhM7+OgpKUDCXLmOVYrCa+kyll
         rQwvcUcchqbgwlj9OKkI1cCQnO/cZmy2Q3c8maDxc4NZ2ivAjYbd+Q34mjbhr2MsV9Ij
         uYQdwas9XoEvdbdOiwmFd70OM4bhDlLcLXoz53oh5zIwd4FyB/OyLATlyLWkEvCtNOS9
         i/og==
X-Gm-Message-State: AFuF++m1321GIQJL1U1gaG+mThgJ0XN4v5LdQqLEPHNDZXSL86/WM9BV
	e567dA//ttrF7CBE9Kyq/jplnHCjZftsdHdjTH9ZhL2I8Dh6nAmPZhpyAVijniCZEME=
X-Gm-Gg: AR+sD10f4NSaYiY2l41RcEfeihYR9m+u8JCaadOgyCAk/MtuKTTiC8CHT6HuH5BuEk7
	aeo7HnBPYjQOcxOI6aTQ6OUh2UwUCglkN2uyigZoqu0J1DMVdFQCREmq4zxF2vy8Dp5uBPQ6Zoz
	PWZgzsv870RHTpNc6kTXPZSYlUkUWnmqTZVmMjV/75WGYG70Q44UYuJLfyf2IaQqgIh1+wNRB+l
	5l/a2J6NAD/4pfvsh6QbeiAx2XiFWmLUqc7czhMfbhLolHNXD/bM9p00759Qdj83sgL3RHz3NLQ
	9Nok/OHmQ3H2Ehx1sxdGiRgjm5mtpfTXwV9QKkv5jxoFrhp4sWR63YtCpQB/eWna6tOKb2lYUIk
	2iVfg1dmQap8P4MxixziR8XIk8Lhhd1Sgj6DEvsdR3BuM/GQzTd8d/TbPVKRsrYMPjTD+WeRVTL
	aopIYvwvMbJSSpc4cizmZoo85e8ace+6Vhrvo4PMZjSzO2XG0Mf8lH8bujHes+6vjLIQ==
X-Received: by 2002:a05:600c:3e0b:b0:499:adb5:e7b2 with SMTP id 5b1f17b1804b1-499dc717dcbmr47599785e9.11.1787734372810;
        Wed, 26 Aug 2026 01:52:52 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499dca97883sm18686605e9.6.2026.08.26.01.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 01:52:52 -0700 (PDT)
Message-ID: <d99b2248-14b6-4e79-b691-efba443a17ed@linaro.org>
Date: Wed, 26 Aug 2026 09:52:51 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/core: Skip empty AUX records with only format flags
To: Leo Yan <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Tamas Petz <tamas.petz@arm.com>,
 Tamas Zsoldos <tamas.zsoldos@arm.com>
References: <20260825-perf_core_fix_zero_aux_records-v1-1-23b95e8d5df3@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260825-perf_core_fix_zero_aux_records-v1-1-23b95e8d5df3@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25/08/2026 11:37, Leo Yan wrote:
> perf_aux_output_end() emits a PERF_RECORD_AUX when the recorded size is
> nonzero or when any flag other than PERF_AUX_FLAG_OVERWRITE is set.
> 
> PMU format flags describe how an AUX payload is encoded. TRBE driver
> sets PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW for raw trace buffers, causing
> an AUX record to be emitted even when no trace data.
> 
> This is noticeable when tracing a task with strace. Ptrace stops
> repeatedly end empty AUX transactions, producing many zero-sized
> PERF_RECORD_AUX records. For example:
> 
>    perf record -e cs_etm//u -m,128M -- strace ls
> 
>    perf script -D 2>&1 |
>       awk '/PERF_RECORD_AUX offset/ {
>          for (i = 1; i <= NF; i++)
>                  if ($i == "size:" && $(i + 1) == "0")
>                          count++
>       }
>       END { print count }'
>    165
> 
> This recording contains 165 zero-sized AUX records which provide no
> useful information to userspace.
> 
> Ignore PERF_AUX_FLAG_PMU_FORMAT_TYPE_MASK, together with
> PERF_AUX_FLAG_OVERWRITE, when deciding whether an empty AUX record is
> useful. Zero-sized records carrying TRUNCATED, PARTIAL or COLLISION
> are still emitted.
> 
> Fixes: 547b60988e63 ("perf: aux: Add flags for the buffer format")
> Reported-by: Tamas Petz <tamas.petz@arm.com>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   kernel/events/ring_buffer.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 9fe92161715e0987520cddb873dd162fd2a77d5c..1b1ffe0533e58a9d976d0eb0fc23e09d5936da2b 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -509,7 +509,10 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
>   	/*
>   	 * Only send RECORD_AUX if we have something useful to communicate
>   	 *
> -	 * Note: the OVERWRITE records by themselves are not considered
> +	 * PMU_FORMAT bits identify the PMU type rather than an AUX event
> +	 * has occurred, so ignore them for zero-sized records.
> +	 *
> +	 * The OVERWRITE records by themselves are not considered
>   	 * useful, as they don't communicate any *new* information,
>   	 * aside from the short-lived offset, that becomes history at
>   	 * the next event sched-in and therefore isn't useful.
> @@ -518,7 +521,9 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
>   	 * offset. So, from now on we don't output AUX records that
>   	 * have *only* OVERWRITE flag set.
>   	 */
> -	if (size || (handle->aux_flags & ~(u64)PERF_AUX_FLAG_OVERWRITE))
> +	if (size ||
> +	    (handle->aux_flags & ~(u64)(PERF_AUX_FLAG_PMU_FORMAT_TYPE_MASK |
> +					PERF_AUX_FLAG_OVERWRITE)))

Almost seems like it would be better to define the union of what's 
considered useful where they are defined in perf_event.h. Or invert it 
here and do (TRUNCATED | PARTIAL etc).  Otherwise the same thing will 
happen when the next thing is added.

Other than that:

Reviewed-by: James Clark <james.clark@linaro.org>

>   		perf_event_aux_event(handle->event, aux_head, size,
>   				     handle->aux_flags);
>   
> 
> ---
> base-commit: 66498c75b4f8017f62d720d9b59675bdf3abce91
> change-id: 20260825-perf_core_fix_zero_aux_records-8873172d2596
> 
> Best regards,

