Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE862C08DC
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Dec 2025 13:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765287465; cv=none; b=u8ODVS0jJxGivpr1uw/KCGeYtveSGDIsrnD2mj/mak18nrN3DjfILgePjtV7IMX9IHTMbN/8Rhf2EWfvY4xTnpGY/UVclTGSVbLQW6ppI/aYThJshDxba1bw4hcaE1v5KjtgUW7t86VzTp3bqw2gsM0XqgOF4/OPBeYofL2Iekw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765287465; c=relaxed/simple;
	bh=JvckbKETr+2+iNU4zRIDHVg0m4e+FNtypMiHG+2PDJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k5WF5QnUTqXSjkAtzwj2BNbhTyvOl8zgFxtYyB08iuhYS4aqppPyw07dVXdLUPzFjEcLZo2UCA53hFkqURCl7H+QXdPql1are0doEaZ+zItrxDKhi/SDXPqNm9mZ8xYs+8ZipCE6E8yie6WRzaZqB4JGluWFxFbxJLQUMbpz+Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZqT5gMvk; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZqT5gMvk"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42e2e77f519so3628685f8f.2
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Dec 2025 05:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765287461; x=1765892261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qIKjv/DlcA/ThInIs54WwElR7N7WTwnMgJg790nkIxY=;
        b=ZqT5gMvkeV2ZaWr9d1v10etBrC0yc+q2UT6Y+nwy06SoRdGpgePcO3xp6z1lSSJgsv
         61eluRBsVnuFiYJVbmpZ0MHCBjxQKKNLM8JY7T5InfQ57zx9h9FJ52bua08LKL60r7sj
         /ji5rWrnGVO+Bhv6AUOPmORl2Nubu7dnT6I7xB9dSfcEOXNNABifcq/FVK8cUs6jXJ67
         t+HmbupD68OJgE4q4OduQgXCzU3I54AnamZjGHljluJ/hJxl/wff5YNqeQeNQJkUslq/
         fJhO4R1oIWnnRbf72/mkqHjLy0HAx8lwtfsJJSR0PNu9w6vOt3ATOr2gxm38RREWQmCj
         rRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765287461; x=1765892261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qIKjv/DlcA/ThInIs54WwElR7N7WTwnMgJg790nkIxY=;
        b=aHKI/XXod+WVnWd9/s2XLw0rS/J8myfYToi/mecZjmV6xh4fvus7LNiTuDFGkjbC+Y
         PVKICxPlXZo/hCd5A4UH+Hek5vpqOK6ifQPZ2rUu2Ci3YQ9Kn6HYkoSFEFJ63qGn9kya
         On+YLHuBxH8lrossvuoNqaIWE0GtIVsOEEr/qepdg3XcsTiezP+d8VJVXh0ix6UwViq6
         H4qqBrtQmT1JfuX7XEwBSgQKJ8L/R8aLwC7EW/lij7LKNkk20v6Asv3JztIYFmNiclVt
         fK+WhMu4Ifw+86y3nWxTuihe8hmOFeusTmqyQ6wwl5llYvvdIbY1itFkXs8C3+JAaj6r
         xDgA==
X-Forwarded-Encrypted: i=1; AJvYcCVZeGY9wEi75emA0lxND8xb/ibg0KP9rCPRLK0IJ5+uOBvEfudAnS3XCzFlRfJtgeg26EaReXrZ3WjLP2+EACPh@vger.kernel.org
X-Gm-Message-State: AOJu0YyHDakPt/RmyRAuWdNTHmkKskeHFSeVY1dA26Ql0olZTkePmvtK
	A32INBRzPig41HajFZqNtMx23z8Qizc+UkbJNKv6Upjk+cIL+rMFbDASsOpOCvvQ1bc=
X-Gm-Gg: AY/fxX6gGbXhB7EfgwcaOaeZwjCYWOs5F/UqMLH6a8fwC1mGmGFFf6EIgBg78lrP0mk
	LtFhwsy5lYiH68fclfZvUZujCvskXLqmryzUeZMpNqSdv7ON6vch/7Cy9YEGP8vQYB26Nq/heet
	EfCNbuz4tpeQ+QmMMJYLr+rAgNIDH5We8uNMAE55J/WtvkA98dQXDwuocAgmJmsRIIspSoCoMqx
	YanXbIIvwQAaVRHyooa0N1vkvPzt4xSW1PyVRlbfddq+pMbxIhAo5iVE3fh+F+KUoWztg/wzybj
	n3BQ9CRK+ej8UUnFwqiIs+Wqg/pP/vllcd4DHrubKnVtaXAmTBwMipRDk6OiWsui+zztLDx60s0
	DlAghatKKxRtXTqQgzz8nGkqxmK3zlxUcpduIyWSfxOjGYoEvrcdXjtYFOhJVzttrHMc14N66Vg
	fZjurBx4Rs8ViV3rNc4nTtooRRBQg=
X-Google-Smtp-Source: AGHT+IHc36kDCLFzZcSvL7RNGxI5IvpysYdqJXouT0/1Mp64sv0XpKo/zZqEWK1kRSMjpMtCqyMjgA==
X-Received: by 2002:a05:6000:1a8d:b0:429:d19f:d959 with SMTP id ffacd0b85a97d-42f89f0c5c4mr12265909f8f.15.1765287461412;
        Tue, 09 Dec 2025 05:37:41 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d331e62sm31622167f8f.35.2025.12.09.05.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 05:37:40 -0800 (PST)
Message-ID: <a638f74f-94bc-4052-b8e1-e940aca2d4ce@linaro.org>
Date: Tue, 9 Dec 2025 13:37:39 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/19] coresight: trbe: Refactor AUX flag setting
To: Leo Yan <leo.yan@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, Anshuman Khandual <anshuman.khandual@arm.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Tamas Petz <tamas.petz@arm.com>,
 Tamas Zsoldos <tamas.zsoldos@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
References: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
 <20251201-trbe_buffer_refactor_v1-1-v1-7-7da32b076b28@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251201-trbe_buffer_refactor_v1-1-v1-7-7da32b076b28@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/12/2025 11:21 am, Leo Yan wrote:
> Rather than spreading AUX flag setting in different functions, use
> trbe_get_fault_act() as a central place for setting the flag.
> 
> Later we will support WRAP mode with continuous trace, so the WRAP
> event does not necessarily cause the trace discontinuity, change to
> check the stop status instead.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-trbe.c | 38 +++++++++++++---------------
>   1 file changed, 17 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 28e2bfa68074f19ccaa4a737d00af577aea818fe..b06885a08e082fd34f68d9588518807b5c47c86e 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -265,25 +265,6 @@ static void trbe_reset_local(struct trbe_cpudata *cpudata)
>   	write_sysreg_s(0, SYS_TRBSR_EL1);
>   }
>   
> -static void trbe_report_wrap_event(struct perf_output_handle *handle)
> -{
> -	/*
> -	 * Mark the buffer to indicate that there was a WRAP event by
> -	 * setting the COLLISION flag. This indicates to the user that
> -	 * the TRBE trace collection was stopped without stopping the
> -	 * ETE and thus there might be some amount of trace that was
> -	 * lost between the time the WRAP was detected and the IRQ
> -	 * was consumed by the CPU.
> -	 *
> -	 * Setting the TRUNCATED flag would move the event to STOPPED
> -	 * state unnecessarily, even when there is space left in the
> -	 * ring buffer. Using the COLLISION flag doesn't have this side
> -	 * effect. We only set TRUNCATED flag when there is no space
> -	 * left in the ring buffer.
> -	 */
> -	perf_aux_output_flag(handle, PERF_AUX_FLAG_COLLISION);
> -}
> -
>   static void trbe_truncate_event(struct perf_output_handle *handle)
>   {
>   	struct trbe_buf *buf = etm_perf_sink_config(handle);
> @@ -687,6 +668,23 @@ static enum trbe_fault_action trbe_get_fault_act(struct perf_output_handle *hand
>   		goto out_fatal;
>   	}
>   
> +	/*
> +	 * Mark the buffer to indicate that there was a WRAP event by
> +	 * setting the COLLISION flag. This indicates to the user that
> +	 * the TRBE trace collection was stopped without stopping the
> +	 * ETE and thus there might be some amount of trace that was
> +	 * lost between the time the WRAP was detected and the IRQ
> +	 * was consumed by the CPU.
> +	 *
> +	 * Setting the TRUNCATED flag would move the event to STOPPED
> +	 * state unnecessarily, even when there is space left in the
> +	 * ring buffer. Using the COLLISION flag doesn't have this side
> +	 * effect. We only set TRUNCATED flag when there is no space
> +	 * left in the ring buffer.
> +	 */
> +	if (!is_trbe_running(trbsr))
> +		perf_aux_output_flag(handle, PERF_AUX_FLAG_COLLISION);
> +

Do we need the complexity of COLLISION (changed to PARTIAL in a later 
commit) and TRUNCATED at the same time?

 From my understanding, TRUNCATED would be when Perf is too slow and we 
want to disable the event for it to catch up, and PARTIAL is when there 
was some buffer error so technically we don't need the event to be 
disabled, but Perf still needs to be notified if we want to start only 
resetting the decoder when a flag is set rather than on all aux records?

There is no happy path where there is a buffer error, so I'm not sure 
why we need the complexity of an extra case? There's no harm in 
disabling the event on a buffer error. Also it's hard to see what the 
exact scenario for PARTIAL is, because we set truncated anyway for fatal 
statuses. The comment in the later commit for the PARTIAL change just 
says "trace was stopped", but not why.

>   	if (is_trbe_wrap(trbsr))
>   		return TRBE_FAULT_ACT_WRAP;
>   
> @@ -878,7 +876,6 @@ static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
>   			goto done;
>   		}
>   
> -		trbe_report_wrap_event(handle);
>   		wrap = true;
>   	}
>   
> @@ -1099,7 +1096,6 @@ static int trbe_handle_overflow(struct perf_output_handle *handle)
>   	if (buf->snapshot)
>   		handle->head += size;
>   
> -	trbe_report_wrap_event(handle);
>   	perf_aux_output_end(handle, size);
>   	event_data = perf_aux_output_begin(handle, event);
>   	if (!event_data) {
> 

