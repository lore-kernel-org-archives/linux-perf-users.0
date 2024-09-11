Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EC919AA75
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Sep 2024 13:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060803; cv=none; b=orZ/H6tWuvdVjdIUDeiQoHGjriiyP/zwclgLJFp/kW3Bsqh/DX5TkIBK1lijDPaT684BuanLC+n2mGIwa6GTzpY74fwHAFRMLF2IimGEG5JFFT3rfn6fB1hZE8Eloc9bMWuEIvteiWsOSWX6fN/lDDXUUDH8B6zS12zbylWu7qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060803; c=relaxed/simple;
	bh=D1EiHcY8P9weXlSZhRTUAEeg4iKK3QtrCo4b6y9PHW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PFvWIEAVtuaqDISfApC72ecUZffWwN3utEiSSx7LUtH9jKB8A+oWDHtIVhPniygVsx8JbO2uNs/uwSh/OU+MuKVrTsH6/XlrIaUCnV5USe3n11vWEk3v6obQEyJGKtGCVshCCJmLchIZjCegT5Bi5AXbrfzmsVHnNYRfUdfSI3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YnDhUQyX; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YnDhUQyX"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374c6187b6eso4240162f8f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Sep 2024 06:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726060799; x=1726665599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RCmH6mf58csP77BoUiBG1NiEIHJIhhD8mtjQ0XUQ2Ew=;
        b=YnDhUQyX1nl0WR0Hexusub1+WDPsIk/Z2q12qmVQZaAfqMD96CNYbmkY7qvbxZSxvT
         7WDACKLZaPbtHRLhIl+X4t6sGd6HF2FWufFzEveDCslvqtlAt3MDbeoITwVXgUsS18B9
         fBSceuGk7dhUUWEGbnyW33DOlbmoOPPlCmFsbTzGgz5w5HmyJevY1A9g74390bw2//Yj
         qTRWGUH4J5f3WbJIPeMeqt4yg6taCHR09PaeDxgC3O/gkD6qZUx+Iijlr9gxh9lBdRQi
         HQGyAhiyiC9HWFg5r4KvqxAZGcqUlws6kiouQNSZJQ7j8shHXvjzEw4ai99NH6yvyO84
         2RzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726060799; x=1726665599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RCmH6mf58csP77BoUiBG1NiEIHJIhhD8mtjQ0XUQ2Ew=;
        b=L8Jmg+46ru2E+K44dyG+noDbNyFCCJQr7EcIhXu3izYikn+1eTvzbrjn/2ychwkue0
         1qUz6TQsTIdOGygxRP9xIFVG6t3x7EDBzsj/nyVKnVk78osj3iqF/j4vQhwAA5nb1nT8
         ZasKAI2xyJurzZz8EWb9zWl0A2pgPO7B0wh3rkvhf+Q89nIRKf6HsIZQ6kJcAc2NS6we
         tCAPkzm8RhmGOSmZ00ZIx1qrEx3PDtAyAJ7sTCUhjnl97KDfuwDrABLRZB3mEziQ3zTw
         ff45QxyRjTdfeYbv+f/ZTr6U5Gx3L6MXBjfy6CgMidpZbhxeHU8rUY2ImmLLEH+0wl+n
         q2mw==
X-Forwarded-Encrypted: i=1; AJvYcCW9v/i6gm+2/uKSKoQ0XoZ9/Po3NNugvKdn/O5i0QIGbQjqKQk+erYqAa/5HQltjquZGL+MxcoHsz19yQ6RmCgE@vger.kernel.org
X-Gm-Message-State: AOJu0YyaSCoHNPDcTHGbD2yq5Cw47XLQDNYjm+6ACR68x0hRrLvmfCAS
	PKhFT0SKyTjq6IxEoe0ZF17BNf+EkeE7Qf+LFGfAwzfcRwzIiuKkIr/h3O2zWXgC845gLD4n/DC
	g1kg=
X-Google-Smtp-Source: AGHT+IFEENixLL18/yVJLAJfrYAgTnbVQ6WwdXnBfanZyIiOghGVV3B0zi9SftdyFackY5eWv55XaQ==
X-Received: by 2002:adf:f582:0:b0:374:bb1b:d8a1 with SMTP id ffacd0b85a97d-378895c8952mr11094429f8f.13.1726060798926;
        Wed, 11 Sep 2024 06:19:58 -0700 (PDT)
Received: from [192.168.1.61] ([84.67.228.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caf436998sm140496745e9.29.2024.09.11.06.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 06:19:58 -0700 (PDT)
Message-ID: <586cc208-faee-4b76-bd9b-180ac06a0a92@linaro.org>
Date: Wed, 11 Sep 2024 14:20:09 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 2/2] perf stat: Stop repeating when ref_perf_stat()
 returns -1
To: Levi Yun <yeoreum.yun@arm.com>
Cc: nd@arm.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, irogers@google.com,
 asmadeus@codewreck.org
References: <20240911121919.4167483-1-yeoreum.yun@arm.com>
 <20240911121919.4167483-3-yeoreum.yun@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240911121919.4167483-3-yeoreum.yun@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/09/2024 13:19, Levi Yun wrote:
> Exit when run_perf_stat() returns an error to avoid continuously
> repeating the same error message. It's not expected that COUNTER_FATAL
> or internal errors are recoverable so there's no point in retrying.
> 
> This fixes the following flood of error messages for permission issues,
> for example when perf_event_paranoid==3:
>    perf stat -r 1044 -- false
> 
>    Error:
>    Access to performance monitoring and observability operations is limited.
>    ...
>    Error:
>    Access to performance monitoring and observability operations is limited.
>    ...
>    (repeating for 1044 times).
> 
> Signed-off-by: Levi Yun <yeoreum.yun@arm.com>
> ---
>   tools/perf/builtin-stat.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 954eb37ce7b8..18197ded88a7 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2875,7 +2875,10 @@ int cmd_stat(int argc, const char **argv)
>   			evlist__reset_prev_raw_counts(evsel_list);
> 
>   		status = run_perf_stat(argc, argv, run_idx);
> -		if (forever && status != -1 && !interval) {
> +		if (status == -1)
> +			break;

Was this "status != -1" here correct? Seems like everything in 
run_perf_stat() returns -1 except what's in "if (STAT_RECORD)" for some 
reason.

Maybe there is something special about -1, but that feels a bit fragile 
and relies on the whole chain to continue to do the right thing. At 
least a comment about the relevance of -1 is required, although the 
issue might not be introduced by this patch.

James

