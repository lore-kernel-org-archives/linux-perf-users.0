Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71EF27BF85
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Jun 2025 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750770704; cv=none; b=WdXCmVqJ0/6rI+U4SZvUQdpo6wh2jEl2i4ymwcFUG+zRU6ESFO8s2zVaG8TpAMmK+MRh9EWz0EHhUmydIw+C+klYpJ44OeJSB8rA5RByZsZvXDyqiQAG28vSdNlrVszJu6jo4BFy7d2Jcacdg2bGvoLvgiRq70dwi0kwAhOMcXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750770704; c=relaxed/simple;
	bh=rjg11TGeDmCCsQCygDctjbLO/TQiMr6nxtcF4J+W4WY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=gRvXVo7h9/F8btNLQ7QsN6pHa5pDLUWau1CH7qXfv97I3R9VSg+zQvpzGHm3S8rycOgyHixWAvs/H+jmdJ4YkpnvetUWaBPPLv4iVZL83Xhk9AFV8m/r7N9B7xtHfZKtkBE8Zmn1aQAT0o9ugnUMqiasNyrv/fZrqs4yc33ZcGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gT0w3NAf; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gT0w3NAf"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-450dd065828so3761095e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Jun 2025 06:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750770701; x=1751375501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C7Gq0NQEfHoCgjSK8t1yJgCw54muyK7UBDLesR+WBHk=;
        b=gT0w3NAfaWXja33z5QFGuFwZVJEK03gViyyrlvaHIbSfCcpbPUOnsiH6PgAQ/VRXIU
         NMen7sGdH32+OfYmhjAv9sGl7y8NYyO8X55plVWrbNb1gJsq6lIblmUVszh67BpYbNsn
         0eACN/OYuxukc154uCldR8I/zE7ha+Royo/i4FLyMpMhOBMo7G1E4tLkY34sn8MF+h3p
         2w64gMZJpTboX02bF1BAsmETZxcLAx9WgWgTjUPFDAevrfPeqK8pQ9e5r6BW0IcXcJvE
         bnDh/YfwqQRuWuXAE6B4xvc6FKLvdSPbSfbbqfZOlvxq1DPayy+4y2Km8s/qIdo6LUZx
         Iizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750770701; x=1751375501;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C7Gq0NQEfHoCgjSK8t1yJgCw54muyK7UBDLesR+WBHk=;
        b=V9BvsKvK0EWyDlscDQY7PuGeIRtdpfnDtwPiOOSd/NnqLVZrRSWR1IDUtRB4dLl2rE
         p7wvnU05Tu8i4HiO4o/Ov8hmWf+xba13odFYY1B6LghFO8sgiGtc8ZEbKO6s84HHjcfP
         +Q9VXMd1SBoJwN/MxON8RF+PiYTkBx4CKoLqb5YzxfhVDVp3Wtt6/S30TaJgR5rk2y7K
         Bpec4wNNWpWdnSCDgPdBn3FZPk+8oSm52SNOvc/4VmCgighI6b2IC20k5gck+j1CLgZt
         IUzFzraZexbj7qv/RTJAo3m7JN3yQsB0V3QEEXME68cKqJP+h1qgMHSfWVB4vLTl9W5S
         abgA==
X-Forwarded-Encrypted: i=1; AJvYcCUvmbAz+9LZOdUQme7T1QOgUOsBkdLcvzy32Vm67qzEaDd4WE0hSBmk9Cf8UX9xDlQtOrdtMPqOzkrMSGSb0kj/@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfjn05O25OIgbT9Yk7MohgERPdhhYxa2/wEX/ROVFsTZpUT3bY
	VxMc9eYq5reLyS3UPc9pPy/TbVQfcc7lqWevFL6GizbCYHx9ydgsDMxAKPnLn36mKLc=
X-Gm-Gg: ASbGncuM23WyGMc9WA3ibimIoVqb+N7CujRS8FmM1+NDj75KwEeF/Pfrvz2NxwSh1Bx
	4xzD5ygcQwRnvRv3muw77Z+njj30yJEsa+jDJfQQnx7C03JvWZcSCma6xAPi4ARVE1RIx5H2WND
	axRoGXjKm9V0bpxFKSTuTODy/lMhUaPNL+8R0pf68Bd7u4KGFJfZILWXT/SuhuhXXmxna3ob180
	5k0mxlPWHjTp2YqLyW9oEr4tuBBQYPd2AomZOYmUkjfpDrzzw4Cr1i8aErTk5uN8qeiWcSKlPS1
	5uij73aaOaJ4MiTxbHCL+ynqxIM77LgwbiTbb2kY5J2ncgGM/kR3O32DNrtJCVMlp8g=
X-Google-Smtp-Source: AGHT+IE/yc9HqGOoWGfAeK8r5RRZj1mQL2RciOopLX9fDZR7XUmEq0HgfLdTjjiXKRgrV0tJG8l5Zw==
X-Received: by 2002:a05:600c:3ac7:b0:450:d019:263 with SMTP id 5b1f17b1804b1-453659aef70mr166503065e9.18.1750770701132;
        Tue, 24 Jun 2025 06:11:41 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e8105f93sm1930160f8f.76.2025.06.24.06.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 06:11:40 -0700 (PDT)
Message-ID: <d87ddbbb-862d-4cf7-b2c4-a5eb0d072a33@linaro.org>
Date: Tue, 24 Jun 2025 14:11:38 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/aux: Properly launch pending disable flow
To: Leo Yan <leo.yan@arm.com>
References: <20250522150510.2942814-1-leo.yan@arm.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Marco Elver <elver@google.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250522150510.2942814-1-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 22/05/2025 4:05 pm, Leo Yan wrote:
> If an AUX event overruns, the event core layer intends to disable the
> event by setting the 'pending_disable' flag. Unfortunately, the event
> is not actually disabled afterwards.
> 
> Since commit ca6c21327c6a ("perf: Fix missing SIGTRAPs"), the
> 'pending_disable' flag was changed to a boolean toggles. However, the
> AUX event code was not updated accordingly. The flag ends up holding a
> CPU number. If this number is zero, the flag is taken as false and the
> IRQ work is never triggered.
> 
> Later, with commit 2b84def990d3 ("perf: Split __perf_pending_irq() out
> of perf_pending_irq()"), a new IRQ work 'pending_disable_irq' was
> introduced to handle event disabling. The AUX event path was not updated
> to kick off the work queue.
> 
> To fix this issue, when an AUX ring buffer overrun is detected, call
> perf_event_disable_inatomic() to initiate the pending disable flow.
> 
> Fixes: ca6c21327c6a ("perf: Fix missing SIGTRAPs")
> Fixes: 2b84def990d3 ("perf: Split __perf_pending_irq() out of perf_pending_irq()")
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   kernel/events/ring_buffer.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index d2aef87c7e9f..aa9a759e824f 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -441,7 +441,7 @@ void *perf_aux_output_begin(struct perf_output_handle *handle,
>   		 * store that will be enabled on successful return
>   		 */
>   		if (!handle->size) { /* A, matches D */
> -			event->pending_disable = smp_processor_id();
> +			perf_event_disable_inatomic(handle->event);
>   			perf_output_wakeup(handle);
>   			WRITE_ONCE(rb->aux_nest, 0);
>   			goto err_put;
> @@ -526,7 +526,7 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
>   
>   	if (wakeup) {
>   		if (handle->aux_flags & PERF_AUX_FLAG_TRUNCATED)
> -			handle->event->pending_disable = smp_processor_id();
> +			perf_event_disable_inatomic(handle->event);
>   		perf_output_wakeup(handle);
>   	}
>   

The types are now a bit misleading and pending_wakeup and 
pending_disable could be bool types. The other pending_*s do use their 
types properly though.

__perf_pending_disable() also still contains a big comment that 
describes use of CPU ID and -1 values.

Other than that it makes sense.

Reviewed-by: James Clark <james.clark@linaro.org>

