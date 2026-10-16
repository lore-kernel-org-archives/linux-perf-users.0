Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB6B48488D
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157381; cv=none; b=L4CoaViyl5JMp3K1lC5Zw38rUqnQYlZYenuuPGUP2SQZuhyiYBA33mnDCoGzWUJxQIhvGaZyLOkLv77/3tqkS6gUCPIo96kLS1Tn6iSYxRpRCA7+fZ85Jq57x26xfay/rKRZBRHYnpA214K/LroYqdJdzGeKfN+gJA9SFsdABxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157381; c=relaxed/simple;
	bh=YBJCnJ8rsdKqrUNhHjjL6sBtv233CpMKpsd1Gw/TmLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q2v91ip9O/vvNE4GySxskNesdhfT/nFOHI4HSveIS8bHaKqXKz1FzKctfglGEZ2LGr3kHr4ej3+3oiyunCLNjO9RSDf4Akg5QVYngx2Zhb6oGc1MvSrPJABmn95sINV3P903gWZ9YttwuHRS3hVA9x2NrDJCCPEFY2uESSh9bqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h1y40CU7; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h1y40CU7"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48df54150dfso1138589f8f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 06:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792157378; x=1792762178; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8jpDLmMBbHfkeVF10s2tGINPrgBL1dTjWhJOL3aqJTw=;
        b=h1y40CU7T5dW8crgX18l/u6v+LlTnRilM+9Q5Nt+VwkLxNjDRbi1FTPpuW7+stApk9
         /NssXpff19jYzhjcbDW7jo6NIxZyqIJ/WlozeGei82UYTVU+tWcwGmOMlpeSHoql9pX/
         hte+8+6BQatr8XQaOSoKBp4Zoj8GwLi8sVLHXwAbqx+7Nw7EgmGaUR4fRbOuqm0/Q826
         x+A7hbkIco2UI59JM47IpYK1TGnJ1lbajiW19HDAzi5LA8FoV5T44Z2SSGL4jIt5fEJx
         JuerB/mkSdFFf3n8XRxhk7E/Y7RGj/g87oPrVwJJOKXrvjAvODLiD0/alKZvuCIFDkPg
         gY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792157378; x=1792762178;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8jpDLmMBbHfkeVF10s2tGINPrgBL1dTjWhJOL3aqJTw=;
        b=brtu80SoM5/08Xm4sfDBXe0o5eMTabCaKGtOt9LONjRnlRvO6HJ51XrZrCapFHvniY
         2juSrVuRuwcNHjnPaRoBF8/uO3BrIwFyl/Fedwy3VQ9+INEdROGa9nnbkPySk7iZ4YgS
         oOApqmnpne55wCC5gQQcmXZV5Daujm6lJvsj0eadep/2tBGw5UOTI1uUW3/Wilx6X4et
         QkiKa9larttWRs3tZRi5LBIvakEomw+Hsyol7p/1oUj5Th2QShIoFDuuOsIqkBON8i56
         TqHQHUFKyCqT5mG5HXTgpQiSwHaleA4C6+P9NAlTrxJOzM9Z1ORhbYBsCQi2Y0G/D4x5
         CvTw==
X-Forwarded-Encrypted: i=1; AKwUvBxX0rdWQqCvXyNwgbPyW3PbiyA6gG2poNLQ06/3ZGlYo6iZTqbiEHWpVx/D4hBQ8ryx2mTDEPkUeAkdti4NLyXl@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3sSq+YuweTe21dx+zwgrmzwDxVA8DtiU2q8h65fo9E/aJ0JcA
	2iZVyraeVEubQ+3403KSqkOdXttb8WJhD0iQ+CCW6IpYe9mnrbf1AGQAEl3R76jGkTo=
X-Gm-Gg: AYBFou2JjhqWzVaVAZD444ap3F5OY8gO3uuERqARy0/HEra6TYHPn9DDGuIC3THKf8D
	qefgsqn30IGwKToARYAszG3w7kzERtbrKc86ixvyg7pDBLgQ2a62y0XNOUP2cHOs7C7fU4+9h6a
	skB91lCgaJGycXgYn6RYdb2fEeZOacdjatPL0+TvLTZ3yz7uNZGfLB/SKfNh0zpN0vZFP0I11Ms
	qnl6r31GFRYReaHcrYh8Zr+jWW8X0WPpz49PiXJmRNtu5HzWQKBiUKq/DJEMESJIrQV76fAKpW3
	vG/Pd4fcx5I9E2jI0Ve6q3IzYgE0Qvo9HcWofWLpgXEi80U9JZE+ijtI9idpmP+K/PjyqSNyPCP
	aAQjen/fTa6Ru1uv+XY01hwpKiiwo7r3SC6tHUslkK8XV0fUuKphlyOMeTOQN7/MXLrhTmDs9g/
	HqxEgGiaaIe+KlOdDUaR+kLUCl4LgzZ6M2FcUAPrazK/XuLua+l50FUiPiToysN7Zc6ZKPCS6Sp
	aY=
X-Received: by 2002:a05:6000:26c7:b0:48d:f851:ee5f with SMTP id ffacd0b85a97d-48df851f00dmr9820547f8f.24.1792157377206;
        Fri, 16 Oct 2026 06:29:37 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4d4dddsm5173034f8f.22.2026.10.16.06.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 06:29:36 -0700 (PDT)
Message-ID: <f1a7dac8-5a01-4fc2-bf81-b7609e332e9d@linaro.org>
Date: Fri, 16 Oct 2026 14:29:35 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/25] perf/core: Prevent AUX sampling from racing with
 pause/resume
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
 <20260915-arm_cs_support_aux_sample-v1-2-35cf6f297d20@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260915-arm_cs_support_aux_sample-v1-2-35cf6f297d20@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/09/2026 16:48, Leo Yan wrote:
> AUX snapshot sampling and AUX pause/resume can both run from NMI
> context. Each path currently guards only against its own recursion.
> An NMI can therefore enter one path while the other is changing the
> AUX hardware or buffer state, allowing snapshot_aux() and the PMU
> pause/resume callbacks to overlap.
> 
> Use aux_in_sampling and aux_in_pause_resume as a shared exclusion
> scheme. If sampling nests inside pause/resume, emit the regular sample
> without an AUX payload. If pause/resume nests inside AUX sampling, drop
> the AUX action, matching the existing behavior for recursive
> pause/resume.
> 
> This prevents overlapping PMU operations without waiting in NMI
> context.
> 
> Assisted-by: Codex:gpt-6

Does this need a fixes tag? Seems like using these two things at the 
same time could have gotten you into a state where tracing was enabled 
but aux_paused=1 etc.

> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   kernel/events/core.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 17355e4b8b7c6c106117153c9eb8509e6f9a41e3..a524eb381d4b5731650ec0105d9794b8c89fba4d 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7990,10 +7990,12 @@ static unsigned long perf_prepare_sample_aux(struct perf_event *event,
>   		goto out;
>   
>   	/*
> -	 * If this is an NMI hit inside sampling code, don't take
> -	 * the sample. See also perf_aux_sample_output().
> +	 * If this is an NMI hit inside AUX sampling or pause/resume, don't
> +	 * include AUX data in the sample. See also perf_aux_sample_output()
> +	 * and perf_event_aux_pause().
>   	 */
> -	if (READ_ONCE(rb->aux_in_sampling)) {
> +	if (READ_ONCE(rb->aux_in_sampling) ||
> +	    READ_ONCE(rb->aux_in_pause_resume)) {

I suppose this means that sampling could be quite unpredictable for 
users if sometimes samples are dropped while pausing is happening. You 
might expect to receive a non empty sample even if its triggered while a 
pause is happening? But preventing concurrent use of the two features 
would be difficult and restrictive.

>   		data->aux_size = 0;
>   	} else {
>   		size = min_t(size_t, size, perf_aux_size(rb));
> @@ -8869,10 +8871,13 @@ static void perf_event_aux_pause(struct perf_event *event, bool pause)
>   
>   	scoped_guard (irqsave) {
>   		/*
> -		 * Guard against self-recursion here. Another event could trip
> -		 * this same from NMI context.
> +		 * Guard against self-recursion and AUX sampling. Another event
> +		 * could trigger either path from NMI context, in which case the
> +		 * AUX action is dropped instead of waiting for the preempted
> +		 * context.
>   		 */
> -		if (READ_ONCE(rb->aux_in_pause_resume))
> +		if (READ_ONCE(rb->aux_in_pause_resume) ||
> +		    READ_ONCE(rb->aux_in_sampling))
>   			break;
>   
>   		WRITE_ONCE(rb->aux_in_pause_resume, 1);
> 

