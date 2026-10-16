Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6444ACC7F
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 13:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792156479; cv=none; b=JIwtwz3tHcOo3GiYaJrZS5KSKOsd7BCx2uS6HSfejpCcrD75pX0rrrK86L864xQEWfUkTtrw7bdm44l/sg94qQQg59P7YGbV1Rl/2/HIODg0nb+BZYrFxdLgrg6TswEqxJig7gycqVGhdA1b0Yq60DuPxMPyyBQjvOi0ekoZkEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792156479; c=relaxed/simple;
	bh=/NqlYCkwEDnx+3z9fm1ChPu+6B52abvScuA7rF51W+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ddp+yqiYODNnS5QoW9bLvpHL1/MCooqOttZUCo/3i1VgLMdkXNR6zf2+zm9Q6TxWhDy1SF8T78AIWwCiuCI3sSbGkRL+EZcvaRc/J+cIIzZ+8B6Wygl/7wSfxL8pKRWd+CnnyfEO6RS2ThEkTF5o0wY6gqyvbYelYaVfGFbSmTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bHp+X4Hj; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bHp+X4Hj"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a0286c981dso30036805e9.2
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 06:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792156474; x=1792761274; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tsX0Fx1Vu5oxDkz2SE9XCwKJJhLzTUajSbyoGIgpXkI=;
        b=bHp+X4HjM2aDZUEFiKJhGIOw2ggxHGI10dBWExn21NBPT++/Q9xNCdYULAwZiCtZbt
         vaPvYYnqEQQBHRsdO78/EJ3Wt7v+lgw7YTWgf+ue0Pf+USQ3rW8ZG4J92ePwR2N6BH+A
         GdVCFK4tJtC72SQ5ekTWNiKLiqwr6xQSQYhdS3BBeWLmfrFGtRbpa3X4XZItAWuBIRCi
         hv6bQGNa2SxJ4q0V/y97/I/yG3v6zbdYb+Ku1htuL6RHtX8MrNtWxdfUS/AKBqPB7vYq
         2IiEh9uxWNPc1f+eU9U05J6RCdzIlJclPQRx3QpqA3udvKWSPXdBkvH4m6/fD3D1T8Vx
         bFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792156474; x=1792761274;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tsX0Fx1Vu5oxDkz2SE9XCwKJJhLzTUajSbyoGIgpXkI=;
        b=oK5tRzAuNHvUCCNU3bsmt6WnAo63kK3dax+Vz65nI2+3HTkHgHw2lQJ60ytaW2j8c4
         ZgBY+yeD4VNRKOjeR63EVOuXo50+sJNBcVqteTGb2Mcj8Is5HYdYdW44N520b1DEjWBe
         YCrW4yOioDoL98vLcbvT3ppgDpTQz5cQII2uLN28m2XwtDCbCqPU2BA2gYQ3p+4zSkPA
         BvFSyULLhDefuv8qrKfyBGtm7kNS/7Q9jSVPsYVTYsEwSZwgpNdTjNdkDGd6mIUPXYVV
         OkoJS2TnVga3pXO5Bmu44rapeFdR4TdYz5C6XlvagdAKFSWp3svuam6y1fltfqDEMF3r
         ImPw==
X-Forwarded-Encrypted: i=1; AKwUvBxzUxSuULWjybVmSbkxS5KkZ9MWGSgJk9No5eeNtg1vJ8fymOBv/ncyvRbXQ1rCh7jma/eQSL5gdYFowMPuQkTZ@vger.kernel.org
X-Gm-Message-State: AFq9FYLmX8+T2zzwDTU3EU7KTUjC6jtSjdpEj/qnJ/iE2c71mDn/45L+
	qcxxDYzZr66jT4EG9xOoAwZVPB5G8pqMQAWq7y1M4SNDMhfZCRYQU8GyQZ69Ad4Q9eU=
X-Gm-Gg: AYBFou3AWgKwOFY6/+XX+z2FOTmCZyzTqrAL90Rma5MKrS18HZ1Dityp2nmQvPhEL6B
	lKMQv0c0vpQqZWWAtmHzEvp+i3q7lC8NhxmrymAKZDfEDWR0ng7vj0MTrA6ygJWo9njWyz+IIxF
	gk0UWEI8Hl6BBLSVrWLMUu5EjE705RSGPZRGcSA9SeFt8a+XujLtvflaQXLw/B/dgd3AA7i0jW1
	qunk0uIDaFwNS7nEE8qMdQSnIdCadsGNVSCzDD5xxQHVIzqKoQNWiAywYPygxn6q3EeyvbRXgAy
	1t99Oc95JU+U0P1SbrY26fRuPwxCWlaGy60drX4JOrtO/Anlrdrlyyu1WlVRjXi17DD18q38t63
	wNX6/4nBQfFrnD6tJYM8DNZHCAkLX3xFjAwkYsp2mZRIdCG4vNDddN/6bx/ZxY7huijM5fFUbhl
	/eLk7dupGjgVLDn7uz5bCQpsJGxxvagOmxbm/Co6pnNIVNFdXHLO/nkG0+TDCaqeoJICPEyvZBl
	RE=
X-Received: by 2002:a05:600c:3144:b0:4a1:70b2:8dbb with SMTP id 5b1f17b1804b1-4a18e4b0347mr432306165e9.19.1792156474596;
        Fri, 16 Oct 2026 06:14:34 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8ac4c70sm45400235e9.2.2026.10.16.06.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 06:14:34 -0700 (PDT)
Message-ID: <13ac34bc-fc8e-43b8-8976-05e91ae46e71@linaro.org>
Date: Fri, 16 Oct 2026 14:14:32 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/25] perf/core: Reject non-positive AUX snapshot sizes
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
 <20260915-arm_cs_support_aux_sample-v1-1-35cf6f297d20@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260915-arm_cs_support_aux_sample-v1-1-35cf6f297d20@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/09/2026 16:48, Leo Yan wrote:
> The existing validation rejects negative copy errors but allows a zero
> return. In that case no AUX data was copied, but it is incorrectly
> passed to the alignment-padding check.
> 
> Reject zero together with negative errors before calculating the padding.
> This reports the invalid snapshot result and avoids treating a missing
> AUX payload as alignment padding.
> 
> Fixes: a4faf00d994c ("perf/aux: Allow using AUX data in perf samples")
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   kernel/events/core.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index fe33fe15689d077e7f445c0b17d9c2e638c884a1..17355e4b8b7c6c106117153c9eb8509e6f9a41e3 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -8058,12 +8058,11 @@ static void perf_aux_sample_output(struct perf_event *event,
>   	size = perf_pmu_snapshot_aux(rb, sampler, handle, data->aux_size);
>   
>   	/*
> -	 * An error here means that perf_output_copy() failed (returned a
> -	 * non-zero surplus that it didn't copy), which in its current
> -	 * enlightened implementation is not possible. If that changes, we'd
> -	 * like to know.
> +	 * A negative return means that perf_output_copy() failed, while zero
> +	 * means that no AUX data was copied despite a non-zero request. Neither
> +	 * can be treated as alignment padding below.
>   	 */
> -	if (WARN_ON_ONCE(size < 0))
> +	if (WARN_ON_ONCE(size <= 0))
>   		goto out_put;
>   
>   	/*
> 

Reviewed-by: James Clark <james.clark@linaro.org>


