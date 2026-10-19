Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC7949A3AB
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401932; cv=none; b=BbVhRad/35WwiHyyUhomFknZmKMRT57MYB1+lTvh/QMD90olmJIO1G3yJawI0KgKinE+QO/cig3GIx/VH1xl6heKLUqv3URLrVd2aMMWgzySsd8d/chdRdpDNM0oExKJUNfE3abp52WlhPMhgim2jWAkYYs7iglO3pbeLjVrsns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401932; c=relaxed/simple;
	bh=5QpX00F+cW0Oor63CyADvDjpW6mm4yVKdrs0dUpPj20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HRX1ENBR5hai+7tKziKRgHajfUzVv6shcC1Fxcn5xJYWNcrE0llsTcTU7pWdFfK3StsGLkQawGxfDofVyaHTe8++5FP5KhovX39fNijdvMp3fqti3d7ob6DBn2Eyqmo/9ZezjmOW+DiCYOMIY0dhS99spEzUi8ft2dKKYr77AOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N2UxCCKw; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N2UxCCKw"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1d293b293so10601295e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 02:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792401929; x=1793006729; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rj7uwc+EKzyLJl2slhVkFCcJ8uKjGpCu+rX2woYwvYU=;
        b=N2UxCCKw7IkNja23ahPKgmLrz2ZoHuik4pPDuHjrZcbDanQM0f4CGdA8vjU4DN1N/g
         sH3qFXlu5EAMQLGTaPcUiOgRdjHiBCTTd8zm1PuXqfiWRjLX+T6Gy14Dw8j1otlz1CcL
         1oadgt0rUbFPh+pYN0dCmENtnsJ2kX93dExylov5bkfnt15c9wgAgQQ0xOImS0BnczRM
         UwJYel+yMIJsEOmZyQ5rnKVoO7jnR495MKjd8UdnvvL2y7mYd1f/8WnienzVl5aCN+mt
         msESwtG5qhPlfVcgXqe9aZMIkxkeCxStUWmP5r3Jz04GhxLO9eBZZ/kzZWAkvvXKubs2
         ecxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792401929; x=1793006729;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rj7uwc+EKzyLJl2slhVkFCcJ8uKjGpCu+rX2woYwvYU=;
        b=vw8aPxXiu6nXU2dBrrMycmoFBYCsg0kbVE3t64GKKBQ9LBQBAtjwLdZRdnnFikIYvu
         L2xQSqV0km8WdZaqZDk3OlWR5FX/Sa1nr6TqZjZ5JhH8mj3uaICEbyQu5hggvgeLSDfk
         80o8q/hwoWS0aCM3/Z7uknR6g+S8mlRUxdbG+FtlPB3cU6QvhO3+n0j5Ly3PRH+9edmk
         EbZigf2uzj+lcxiW7mikKDDVjj4vzrZtkUmBz2sD4Gxl97CsPQV19U9qxpMALKtsPvt3
         5lJ++CB/J85fUlnohPYYlgJAtV9NXQH/+zMCFKqDbmR5vj9OVjkcI6KwuraHloz408QK
         Y0kA==
X-Forwarded-Encrypted: i=1; AKwUvBzBN+qx9/09QqXR68/FujqvzQZKnhgokA+VDkA3/ZbtMoE4orxzbsGPFw7mELeGoRHJQB+b4lJ3hgMkoSCe4w+G@vger.kernel.org
X-Gm-Message-State: AFq9FYJzJN6MF58fGCky3LhoZ5qyeVtbcGGn2f59mi5y5E7kaq2VI+XC
	fvVrlGR5bwq1yArPyoR0rZdF/7sLzxyEtd5boab/KNK9+mS6Qk78+yMhxzMAyJLDkTM=
X-Gm-Gg: AYBFou1U46hgMw3E6JyeaN5uCCm0AbehKOig4RM1Q0hpJmmkZK3Zj3eujEWN2MUT8yv
	GULyXjqhaa7pRqgh44Eja+6m5uFouQYbmoR+Uc0uh2XG2VIRJP+OpGDzwDX27N3uNN5OKQiLKUF
	RLvecgSg+GWlcgp2BzopJQ8d4s6LNPF4RHK9tmoC68J8T/PChnhCQLGEqUmgEccL0bbEd0ZLgDV
	cFox3VlKZ8sa/8SFyATorcP/LS2Qya649rTVKJ2rH2xJaJfpumeKDxMHJZ9T+DqiT/OvNN/CL1J
	uHy4Z0NYHhWmnVAjRGU38+3pFZuz850Zii1FD1WTRGt4pwgU3i+wIcrxDjMpSa+SnLGKmrMUH5M
	1LSJi0qOmzs+l498vvt9FNxu8N5YaXTUiovIA1O/zOC77evmKDEbcpRF73uc2T6cPUxSbDHoNVR
	ilZTTlBYgXMQOgtGQNbdvUwErO6qnTai6EDiHfikscDQpPNk/SAicwjxnZIipZsJOTtlBW65DZ0
	KY=
X-Received: by 2002:a05:600c:5488:b0:4a1:992f:d0e7 with SMTP id 5b1f17b1804b1-4a1d75fd4d0mr152515455e9.16.1792401928632;
        Mon, 19 Oct 2026 02:25:28 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1cf983b88sm258881895e9.7.2026.10.19.02.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 02:25:28 -0700 (PDT)
Message-ID: <76c6cc56-08bd-455e-bd32-63cb024924dc@linaro.org>
Date: Mon, 19 Oct 2026 10:25:26 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/25] coresight: perf: Validate the live context through
 its path
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
 <20260915-arm_cs_support_aux_sample-v1-7-35cf6f297d20@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260915-arm_cs_support_aux_sample-v1-7-35cf6f297d20@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/09/2026 16:48, Leo Yan wrote:
> etm_event_get_ctxt_path() returns a path only when the per-CPU
> context has published event data and that data contains a path for the
> current CPU. Perf PMU callbacks run on the same CPU in atomic context,
> and only the normal stop clears the event data. A returned path therefore
> establishes that the pause and stop callbacks have a live ETM context.
> 
> The AUX handle has a separate lifetime. It can be absent after an AUX
> transaction could not be restarted while the CoreSight path still needs
> to be paused or disabled. The handle is acquired for the callback event
> before event data is published, and another ETM event cannot replace it
> while the published context remains live. Thus any active handle belongs
> to that context, and etm_event_update_buffer() uses perf_get_aux() to
> determine whether it remains valid.
> 
> Remove the redundant comparisons of the handle with the event and event
> data, together with the redundant event_data check. Use the path to
> validate the ETM context lifetime and perf_get_aux() to validate the AUX
> handle lifetime.
> 
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm-perf.c | 15 ---------------
>   1 file changed, 15 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index afd22fd4a851e600ab69fd5b6883e6f8518b2cab..c7454da5c881c4a8eea5cc77902c9113c297096e 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -698,9 +698,6 @@ static void etm_event_pause(struct coresight_path *path,
>   	if (coresight_is_percpu_sink(sink))
>   		return;
>   
> -	if (WARN_ON_ONCE(handle->event != event))
> -		return;
> -
>   	event_data = READ_ONCE(ctxt->event_data);
>   	etm_event_update_buffer(handle, event_data, sink, PERF_EF_UPDATE);
>   
> @@ -728,14 +725,6 @@ static void etm_event_stop(struct perf_event *event, int mode)
>   		return;
>   	}
>   
> -	/*
> -	 * If we still have access to the event_data via handle,
> -	 * confirm that we haven't messed up the tracking.
> -	 */
> -	if (handle->event &&
> -	    WARN_ON(perf_get_aux(handle) != ctxt->event_data))
> -		return;
> -
>   	event_data = READ_ONCE(ctxt->event_data);
>   	/* Clear the event_data as this ETM is stopping the trace. */
>   	WRITE_ONCE(ctxt->event_data, NULL);
> @@ -743,10 +732,6 @@ static void etm_event_stop(struct perf_event *event, int mode)
>   	if (event->hw.state == PERF_HES_STOPPED)
>   		return;
>   
> -	/* We must have a valid event_data for a running event */
> -	if (WARN_ON(!event_data))
> -		return;
> -
>   	source = coresight_get_source(path);
>   	sink = coresight_get_sink(path);
>   	if (!source || !sink)
> 
Reviewed-by: James Clark <james.clark@linaro.org>
