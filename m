Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78372EACF2
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Dec 2025 08:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765788006; cv=none; b=L8PwvcinMxiXlK5W79jWQBWbK9LEaqOmGyAq+8Zv4zmMzogu79ct6c1AyvnFIbuXx3OYunGzpjD8lDzeQDU1GMms4UvwgFZnr/XCecxzdfesFjCxctOE9ghnnsYSbDdwFOB0G3gDDh0vX3HWJ0xi6Ib6LZhQ7NfAZMsbnzvx9Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765788006; c=relaxed/simple;
	bh=O3bokBj3/HSay0jtP3Z9FXz/l5sIcCbdF1sFWuixX6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NULsx4M6g8VuatTF3JLCdZfMi1LQAerwa0fqzTuBnjjjYKkOonngKBBIxRqXT5/WwQ217tNYl964QDDJvIZmS+i8hoNGETPczJ1ADh1eRVFzd2epVuOjQMtACRynkVV+PrKcWHYxjCeyN9WFvUtI64HlmpO7+bVPvMnE/Nx0YtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i5hjOR7e; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i5hjOR7e"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso23701795e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Dec 2025 00:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765788002; x=1766392802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gOvWJVHqe92dPhZ+P0BBeZG4l3s19nOAl9yNieAQXok=;
        b=i5hjOR7eBjmif/lptzV2REOWxcCLhnjSLi+hfIjsegbxKpmA0p0jIhkr3twdW2UGdG
         g6qZrhkizHdMEH08tRvkFg584N4dVmz+K5/2nnvaIn+ZfslUTErf+oHuCRMsqEgOL+ar
         Ux5+dnqCPm8I5rAl/ZhHGa3/TKf2/W9DJjxTk85tgseMoTBrXQxByl907r0sq+GN7Jo1
         j4j5FUGxIff69jXuR1TusoNhDLVy56qCinUIScBh8EazZoUV87gDDq3OUazCGOzKQ9mo
         rP0kocc5CL11S+5k6XxtBQHodYyz3eAtI3lQgvLh6axma7/IJN+DgydhUJnQITnFaTnQ
         QRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765788002; x=1766392802;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gOvWJVHqe92dPhZ+P0BBeZG4l3s19nOAl9yNieAQXok=;
        b=jDSKOQV35KdeoMvL2LZNz5UfgAgYfGEOgQWNK/lE6faVcIorjvpk7YKVgUkXvtx699
         akzacPdcVvwDG479rW4XojkpWt5Uau8mhcFqe/IOQYzMAnOICajiK93RvtkdmqHNId96
         bQOwf0Xe3kIE7yOlxbfROgTqyL89KJA63C5xzu3cXtAIsVq0WmdacykeygYN6x7WfTj0
         GQbbERJBHsaJkPeU7Q/RC4TIG/zZmkQqL8g9V8y94vpKJDYZygaodiyjzENCaqTkVpV7
         kS72AMsLRqW/Eg50pHN8Sb5HZdkdJzZBevurVD7AHPF7c/HU6w2WDXoMTjJ8NUarG96W
         1qVg==
X-Forwarded-Encrypted: i=1; AJvYcCWdtNto5L1m+AoHv5EIbLlyU12IdCe/GIr+p+jiAtrh0tMV4neVci8ClPCTkptjcc9XDp0IsHCzZ5pCTnvbuEPq@vger.kernel.org
X-Gm-Message-State: AOJu0YyVn4LMZhtC7UXl/uYxVSWo7UdxKuEuVixY9ZpNue+8K/bAysOP
	AsAusvi7JLdtOdvU68kpCuu3oPopqmfR+BYHQztTpYhA0uTjAT6+cAgpKzx/3WBBXzQ=
X-Gm-Gg: AY/fxX5dz1WxDVr3MhWfVcVeHVR7haD4MmR8hCAw3+/8mWyDSVbq5WBBxWrLOWS/4Ez
	v2rHuZdK7k6TzOZdT+9bXyrjAgMb/6olGwGc9dESYF7HDE32H+CRkJuqw/jwqKNpjTpmE+lqLCG
	Ffj1Csu/n9099PGdP3w5hZ2klg9zMZkMaOJmPSY7wDu+q+AJqlvKlwA+hx4QLo//Dq2yMFxtxAH
	l9gExea691PE+Z0VUZ6I4CaDechakFfm1UidY5dIw3s3SYj8KuJuVRqA2v3/79kgrILGzCvvbTi
	UdjN8v5mb1kWCZ4/wbWEROOIluyit69FOdWt/kVwqeKUrFFxZ6t8+OKNlmyeLGnsFx0Oh8JKETW
	RXxHJI+CHtHeu4Xc5HAYXHawesbG0lwvNZbLEkl87i7fJK+4D3kK76Mz5nOYDeJv4XJ6YyGaAG+
	RqIRdOnD5EEPLabMq+h75y
X-Google-Smtp-Source: AGHT+IGAFPjjozwxCPXgm59vyjrVwkbrxG7ETDJg6c98bYHLWBLTFoMu/6fzFgarA/z2HfhN4eM9kQ==
X-Received: by 2002:a05:600c:46cb:b0:477:aed0:f3fd with SMTP id 5b1f17b1804b1-47a8f89ce2emr104709825e9.8.1765788002143;
        Mon, 15 Dec 2025 00:40:02 -0800 (PST)
Received: from [192.168.0.108] ([130.185.218.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f38a4e9sm213401445e9.2.2025.12.15.00.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 00:40:01 -0800 (PST)
Message-ID: <651e1a79-356f-4f86-a6c3-8119f1c6c98f@linaro.org>
Date: Mon, 15 Dec 2025 10:40:04 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] perf c2c: Update documentation for adding memory
 event table
To: Leo Yan <leo.yan@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Mike Leach <mike.leach@linaro.org>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Al Grant <al.grant@arm.com>
References: <20251212-perf_c2c_update_event-v2-0-27df9a6cb1d4@arm.com>
 <20251212-perf_c2c_update_event-v2-2-27df9a6cb1d4@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251212-perf_c2c_update_event-v2-2-27df9a6cb1d4@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/12/2025 19:25, Leo Yan wrote:
> Users may occasionally need to see which options are applied to memory
> events.  This helps to understand the behavior of "perf c2c" and
> "perf mem", and provides guidance for configuring memory event options
> directly.
> 
> Add a table to track memory events and their corresponding options, and
> include the Arm SPE events in it.
> 
> Suggested-by: Al Grant <al.grant@arm.com>
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Reviewed-by: James Clark <james.clark@linaro.org>

> ---
>   tools/perf/Documentation/perf-c2c.txt | 51 +++++++++++++++++++++++++----------
>   1 file changed, 37 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
> index 40b0f71a2c44eb642ff3bb234631a614b7c4fc9d..e57a122b8719f1b2e20dd509959fc1563a6c20fd 100644
> --- a/tools/perf/Documentation/perf-c2c.txt
> +++ b/tools/perf/Documentation/perf-c2c.txt
> @@ -160,20 +160,43 @@ Following perf record options are configured by default:
>   
>     -W,-d,--phys-data,--sample-cpu
>   
> -Unless specified otherwise with '-e' option, following events are monitored by
> -default on Intel:
> -
> -  cpu/mem-loads,ldlat=30/P
> -  cpu/mem-stores/P
> -
> -following on AMD:
> -
> -  ibs_op//
> -
> -and following on PowerPC:
> -
> -  cpu/mem-loads/
> -  cpu/mem-stores/
> +The following table lists the events monitored on different architectures.
> +Unless specified otherwise with the -e option, the tool will select the
> +default events.
> +
> +  +--------+---------------+-----------------+--------------------------------------------------------------------------------+
> +  | Arch   | Configuration | Options         | Events                                                                         |
> +  +--------+---------------+-----------------+--------------------------------------------------------------------------------+
> +  | Intel  | Default       | -e ldlat-loads  | cpu/mem-loads,ldlat=30/P                                                       |
> +  |        |               | -e ldlat-stores | cpu/mem-stores/P                                                               |
> +  |        |---------------+-----------------+--------------------------------------------------------------------------------+
> +  |        | Load only     | -e ldlat-loads  | cpu/mem-loads,ldlat=30/P                                                       |
> +  |        |---------------+-----------------+--------------------------------------------------------------------------------+
> +  |        | Store only    | -e ldlat-stores | cpu/mem-stores/P                                                               |
> +  +--------+---------------+-----------------+--------------------------------------------------------------------------------+
> +  | Intel  | Default       | -e ldlat-loads  | {cpu/mem-loads-aux/,cpu/mem-loads,ldlat=30/}:P                                 |
> +  | with   |               | -e ldlat-stores | cpu/mem-stores/P                                                               |
> +  | AUX    |--------------+------------------+--------------------------------------------------------------------------------+
> +  |        | Load only     | -e ldlat-loads  | {cpu/mem-loads-aux/,cpu/mem-loads,ldlat=30/}:P                                 |
> +  |        |---------------+-----------------+--------------------------------------------------------------------------------+
> +  |        | Store only    | -e ldlat-stores | cpu/mem-stores/P                                                               |
> +  +--------+---------------+-----------------+--------------------------------------------------------------------------------+
> +  | AMD    | Default       | -e mem-ldst     | ibs_op// (without latency support)                                             |
> +  |        |               |                 | ibs_op/ldlat=30/ (with latency support)                                        |
> +  +--------+---------------+-----------------+--------------------------------------------------------------------------------+
> +  | PowerPC| Default       | -e ldlat-loads  | cpu/mem-loads/                                                                 |
> +  |        |               | -e ldlat-stores | cpu/mem-stores/                                                                |
> +  |        |---------------+-----------------+--------------------------------------------------------------------------------+
> +  |        | Load only     | -e ldlat-loads  | cpu/mem-loads/                                                                 |
> +  |        |---------------+-----------------+--------------------------------------------------------------------------------+
> +  |        | Store only    | -e ldlat-stores | cpu/mem-stores/                                                                |
> +  +--------+---------------+-----------------+--------------------------------------------------------------------------------+
> +  | Arm    | Default       | -e spe-ldst     | arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,store_filter=1,min_latency=30/ |
> +  | SPE    |---------------+-----------------+--------------------------------------------------------------------------------+
> +  |        | Load only     | -e spe-load     | arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,min_latency=30/                |
> +  |        |---------------+-----------------+--------------------------------------------------------------------------------+
> +  |        | Store only    | -e spe-store    | arm_spe_0/ts_enable=1,pa_enable=1,store_filter=1/                              |
> +  +--------+---------------+-----------------+--------------------------------------------------------------------------------+
>   
>   User can pass any 'perf record' option behind '--' mark, like (to enable
>   callchains and system wide monitoring):
> 

