Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C52331EAE
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 12:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792413874; cv=none; b=ZHkxtoJ7OjvG9K0hVdn4QKA5BGDpReQ5A/xgcfR4Yi2Kt1ta8nG2YrF8gRLaYH9eCOFIPKiqA6Yp/TJnFeHMcBIeD5cCgLBwhKk6sav9rPcRfyX7sLquKLuV3OyKQESCAZ1dYBoBVt/AID+r38uCln3zhL4y7Fkl/YLxJx+wS5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792413874; c=relaxed/simple;
	bh=OQ8eav9Ux41+oRFB35TB1JhL91JkSCWggnqYSeogg2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MEtBRIWnZUZe8Us7XS0k4eHIMtBVSq4LelFWzXkEtK7qCbSYyiACxOQPBbzN7QnbSr45zZXDYNHqqgnbqH8OlAWlgebaZ9l62K2mLgpc5cYrNvzNpys6PXbnO8PPMt8vCr2MGvrQJMNOdgd60KTcKEUCVO7ddSGvJdkAYMlNqLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UwthnpkU; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UwthnpkU"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c423b145922so176008466b.3
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 05:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792413871; x=1793018671; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kFqTDlj4awkfSbachY987XqpXNk4Iu67BWeqjiuV6NM=;
        b=UwthnpkUVgoNRi551eX+j85IPrcnZf5L6F6LgkXc8dqv3+O0vTljjjzpgTVMC73xFG
         Ze9XSkTKuhuGwLBWMfLfAZGS6mMP9IEJrp5sy0PAw+3OlD+Ks3H3jC6P5nkec5/5sgZJ
         xNuCo2Rv3YQUn7aRkJ/bTs1+5GkjPCuvWBEofBzfCIw6LRJOv3fZpiY8olnNxDuJL5SH
         y4LUSNg43RHF4RrY0apG+L+vEtAitXRs3QQv1EvIcbVjHW8cRT5SA/n7VbwU2InL/KKd
         I7Wuw6G8UWpDQOiKLVXCjfOy6VZ8CkswJrpqMI57QBpb+oKaY6n9ssz+L5uhw0G31Mc5
         08Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792413871; x=1793018671;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kFqTDlj4awkfSbachY987XqpXNk4Iu67BWeqjiuV6NM=;
        b=zvrHYBPXsKD1kTInLOoBZZQsFrmfuaJeOIMfUePm1liQ5Dkc1gRIm2XlKo4i+9NkG/
         VbDdFKlntuEYAn8yR4XfnXUcdV0AJYEgCTbXLfNmQ2WJLtne+F4Bg2fGJVmcRuBITcnT
         iaAy78ufvmjotTdwYor5GZqOeOly7fF+hW3nFeTd2C61Kd4XPYrGzn9/hzrrjy+p5rjm
         hIa+07mAvYI94vmcw+nJDdeftv/1p1642O0y+a0jGBqdU1axQPO0uWdiQRAll181Cq9H
         sMofStvToHFOeM0gzdGv3MqOtyBB5jXrbzSIPHCW078ZXsUQCKbDjhAUgZbgtBZGzkAY
         LMNA==
X-Forwarded-Encrypted: i=1; AKwUvBwnptLshE/Pt0EF24QqxafFg8/IOVLREP7VTo7OzoSQI8jYj2hnHAi0uBkT7SRb+x90HF1UrS7wkbzjskDMTf+L@vger.kernel.org
X-Gm-Message-State: AFq9FYI0F/Nskn8vvNKsBoBeVs0QUUeZNpD0f18w7mg6Cyizh5N9JnXX
	mY3skxlkpArd00M09hLUHT1YGg50eI1p5lYRSa7wSoIQ7ixla04B3y57zxjnt4Rowfg=
X-Gm-Gg: AYBFou08jFJb9eJLH8kMwVopM0oUYGfNTK8RoPj5WcUp6bWYC19WhH+DXatD00vkuLa
	HtOR9QgePKP8f7+pBuiSAX4yPNGNDiIFOyLnmF7YBcP1BI2WXd7tGsAmMkY174YbKqWaHlxm8mz
	jI3TgBtNWP3olsm48qPW/bwFX178eSjSsrdWilKRX6PNYAxWLOgm/r5mAdw0phMaTtJFkf2+Qt6
	/U4ceTdaouqPX1PcboIwSA7wqnBaF1eojcg9Hn4HOUZye1X+XocE2BS1fY8gy/eYolOFrIUTqCu
	6WXh2MidlGBS4MAn16MpwBRpt1CDvGM8M6HMWGa5OyqBlPWXykjawnPmLMB3x9gW3kCyk59SDv5
	3L7rqi0Y+K9X58MG58lRCgdyQcfQKTmHV8SuZHy69xyw3+q1J0ZUteISr+hQ1cOeX40ii9yNC+u
	MK2oJD6eXIvla95179e/Tsze03a3H4yvcpecSA9ZrARrZ/YGIXtdfs2lzBlYjgj5mjxvIr8UGJ5
	QI=
X-Received: by 2002:a17:906:9f86:b0:c40:560a:45e with SMTP id a640c23a62f3a-c419f416b79mr534320166b.35.1792413869576;
        Mon, 19 Oct 2026 05:44:29 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40912ceffesm362496166b.47.2026.10.19.05.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 05:44:28 -0700 (PDT)
Message-ID: <0aadf786-8c79-46c6-b6e1-d5a6caf30771@linaro.org>
Date: Mon, 19 Oct 2026 13:44:27 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/25] coresight: trbe: Handle an already disabled sink
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
 <20260915-arm_cs_support_aux_sample-v1-13-35cf6f297d20@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260915-arm_cs_support_aux_sample-v1-13-35cf6f297d20@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/09/2026 16:48, Leo Yan wrote:
> arm_trbe_disable() detaches the trace buffer and clears cpudata->buf. A
> subsequent disable dereferences this NULL pointer in the buffer consistency
> check before testing whether the sink is still in perf mode.
> 
> Check the mode before accessing the buffer and return success when the
> sink is already disabled. This allows deferred event cleanup to revisit a
> path that an AUX snapshot has already disabled after a failure.
> 
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-trbe.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 8eb625d3fc99db57a18e35ef59ef814dacf20a09..6da89a890712d32e87a15f7c564ff4dc4d197bb1 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -1098,11 +1098,15 @@ static int arm_trbe_disable(struct coresight_device *csdev)
>   	struct trbe_cpudata *cpudata = dev_get_drvdata(&csdev->dev);
>   	struct trbe_buf *buf = cpudata->buf;
>   
> +	/* A failed AUX snapshot may have already disabled the sink. */
> +	if (cpudata->mode == CS_MODE_DISABLED)
> +		return 0;
> +	if (cpudata->mode != CS_MODE_PERF)
> +		return -EINVAL;
> +
>   	WARN_ON(buf->cpudata != cpudata);
>   	WARN_ON(cpudata->cpu != smp_processor_id());
>   	WARN_ON(cpudata->drvdata != drvdata);
> -	if (cpudata->mode != CS_MODE_PERF)
> -		return -EINVAL;
>   
>   	trbe_drain_and_disable_local(cpudata);
>   	buf->cpudata = NULL;
> 

Reviewed-by: James Clark <james.clark@linaro.org>

