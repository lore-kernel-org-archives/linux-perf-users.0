Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2133D8107
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695914; cv=none; b=M9qgwxB/Sd8rMeD7Gh+/ddfrT+jrREiueq7JurDnO8ovbmeHrTgXOOWjSUlryRfSbKGvqf3xZhvLiJSv5Ob3fOIKR/nVe1BozAY2OUOK4kBMbOtkC8HF1VTM1E+lzqzG57xBQMiVt3YXAPTMCZoGkNKwyGPZmvixWMGx1QINYeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695914; c=relaxed/simple;
	bh=xPbWLGY7zm1enSWeIUxEJi4deGkZk+h6h+c+RetpYc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2Tm8lwb1I74qDgRp+h0mD7E+xETQA7pXeFDJpm7PZro1I/jUv/kOKNUoj4qnurBwSIJ2UNus/XxVnyT6L5MF/G38fIpdpcuPHOGwcbrumIzh1NmqyCIHeR2XKtUR7Zm7c2enpDY94KO/XsPjI7QwUrAsW0Kg4yr443rpXTt0+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mUjBR9lS; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mUjBR9lS"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccf3ca626so27089405e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 08:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790695911; x=1791300711; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0kKztUmQRauzLspAudONYS9350S9maMl64aTwFoNWoc=;
        b=mUjBR9lSi5FuNcI59FvKsTG08i3JaYS2qqsGqxNt7FZNywDe9EC2zhoILz0t7Z3Pbf
         RLFycbpDL+wzWFKuSMM8D3tn2/QjHRJlF/EVomsTtQW/eWCXJH/qz8C67ENdx0ow9drF
         3ku+iaiPGAz8NJBLMcrHk2Bv+PSWxU7aJCSMULj5jw4nVmaWNekuQK8gXVewb60uTNoS
         bMGXt0m4ySsFEH8bpqK3rPuEHS3/kUcJ9ThgqA+2xae4mnPmGOppdbrEo6sMJNNyFKXu
         hl7tA4sa4x3rVs9C2ln6d3r4io10THCxgYw40IYJTLTl965cKgvtRl+9eK2Y4V/OAram
         xUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790695911; x=1791300711;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0kKztUmQRauzLspAudONYS9350S9maMl64aTwFoNWoc=;
        b=sWt1OWuaqpc7K/4nFjx9+3DWWk7s/FRu1P8kpy6168lRnZE2XS0PWdU/gJ+5taA+1w
         0tMHrh6fhLHlejyygFyS8yCV9LsRtjO1WJI37DONo+iq9445WaxctXi/dQjBWAFa63eJ
         LBWOIcyVF5zkB6MSOM7W/L7gKMQvQVPF5zxjkSGQAoZlJyOiymzVPxQMtOvus47ElXrB
         5U80xsZY2VnJRDzNPl861mcxeqLUprClW0bsJs3flDdedq+ERIVqIsVRkgGxi414+gDR
         NGe70UtL5nE9iw1CIkzC1qRzSdNkmoBmb+Wvdn2fX2k9X67MqYkT86Pi5b31Cd1+SDIz
         QS0Q==
X-Forwarded-Encrypted: i=1; AKwUvByS8KxPg8VkkUd3t374C9A8wrCnJckQDFIdvJOKWxawE4RhzkZxi1JTaKBoyamr/gLxTCyqhMhSxECC2L5B2w6E@vger.kernel.org
X-Gm-Message-State: AFuF++n1TGY5IHbpNzVjH5cNf+0sUD0JZCCUOMebt1+OlCCRrRbHCwh+
	PDkLdtbcDdoGFO5srYgywvl9eMmGgvyBbu7ufDW6TeU9yXRNWp60NwNdKb0tgQg++wc=
X-Gm-Gg: AYBFou3047UK4goxGHku/WpjtZLXkLCx2IklENtM/xWj0xRJz5zhtRTLb7dP0vq/EAp
	x01tI7IianAZ3a5P5rJ12AGS8IVJl5F9OCcmuPbS/4Y1S6obJxYFKtcwgE8t3F0PPPAv2Qj9zoo
	aAAe74a/sgvNRdrSdCHVj3k4z+QEOIq5aoOFKNwlTyJTI3/8pxQFnzwDEro+vJgz25VkXHK90QX
	LhdVDiaEXZqvjK31j5Vb0dhxbYYv1mmj3u1eYM68lZTmh8gfF9mVrYp5cz7SPxZWC5tAO1afHki
	4zWAWWUTzmRAF0pyxr2g9OUtju+vUm0rYij3e9d9DmEnNpcezxvjwDv4mWRswS8SfG0pZcRGTQ2
	2YBex7hrkkLMzX+aM5oJWGB7gRT0/qdUw3WlE6G1hdraR5fPe2HCEEUj3I1eDjLLGtrbgYFQYuv
	C4LCm2N8SyPn8d0DVLqG3BuGsKKcl6IuzHNAxpXASWQ2WUSfcRAlhSFTZ/3IEbYlCsXkUOb5h/L
	Ok=
X-Received: by 2002:a05:600c:4f4b:b0:4a0:b9:21b5 with SMTP id 5b1f17b1804b1-4a000d959d2mr144380745e9.30.1790695910824;
        Tue, 29 Sep 2026 08:31:50 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af50923f0sm4866532f8f.31.2026.09.29.08.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 08:31:50 -0700 (PDT)
Message-ID: <0b657642-0770-4fb4-a9d8-4dc59d5407df@linaro.org>
Date: Tue, 29 Sep 2026 16:31:49 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf/core: Fix ITRACE start suppression for inherited
 events
To: Leo Yan <leo.yan@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sashiko AI <sashiko-bot@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>
References: <20260929-perf_core_itrace_start_fix_inherit_event-v2-1-9361a946ed56@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260929-perf_core_itrace_start_fix_inherit_event-v2-1-9361a946ed56@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/09/2026 16:08, Leo Yan wrote:
> perf_log_itrace_start() follows event->parent before checking
> PERF_ATTACH_ITRACE, but perf_event_itrace_started() sets the flag on the
> event passed by the PMU driver. If an inherited event starts tracing
> before its parent, the parent's flag remains clear and the child emits
> redundant ITRACE_START records on subsequent schedule-ins.
> 
> Follow event->parent in perf_event_itrace_started() as well, so that the
> setter and checker use the same event. This preserves the original
> suppression policy: ITRACE_START supplies the initial task context when
> tracing begins, while subsequent task switches are tracked through
> context-switch records or trace context packets.
> 
> Reported-by: Sashiko AI <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/linux-perf-users/20260901164705.042781F000E9@smtp.kernel.org/
> Fixes: 9a6694cfa239 ("perf/x86/intel/pt: Do not force sync packets on every schedule-in")
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
> Changes in v2:
> - Changed setter to fetch parent event instead (James).
> - Link to v1: https://lore.kernel.org/r/20260903-perf_core_itrace_start_fix_inherit_event-v1-1-6bff7e675af5@arm.com
> ---
>   kernel/events/core.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 634d2ccbab82d8bfe9d1bd7f8c6745f60260dbd9..85d924cce387f88de0c1efe6c22754d38430c9d6 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10568,6 +10568,9 @@ void perf_event_text_poke(const void *addr, const void *old_bytes,
>   
>   void perf_event_itrace_started(struct perf_event *event)
>   {
> +	if (event->parent)
> +		event = event->parent;
> +
>   	WRITE_ONCE(event->attach_state, event->attach_state | PERF_ATTACH_ITRACE);
>   }
>   
> 
> ---
> base-commit: 6f8319e3e9a44dd537d17f41565a8453c560a581
> change-id: 20260903-perf_core_itrace_start_fix_inherit_event-a8930d792899
> 
> Best regards,

Reviewed-by: James Clark <james.clark@linaro.org>
