Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7CC18453E
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Sep 2024 10:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726049713; cv=none; b=pRr8hxtLV8Zqq7d8kk7VHQRnlArqCoTLFgwhanSITISWpRIv1KbBk8OTilTaK8GxfGv54+5M0MCasKLuOoV0j9YHAEhJVL+SpmANS4ci/ZhKR75bcAqQijJHGKm+CvrEZV+9sUD6pMilWFGkt9/XyMJ9d0y3TuD+Ag2xT4KSXQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726049713; c=relaxed/simple;
	bh=aXYn4ogEDH0r/0ZfDYk09+4jV7K8oaN8MsbvSky+PKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ev0kiAPwnpT1TxU3pxmWsqeJZ/cxaIr7Ru8w9cocKbhPTLwDwbh4FPjXBJn3eMWwHRRwEC8khdR8mU4XxyLm84fKcv/kCkWWP9dBCgutZx/mOYedbTC8uIW77YNr4UuCu8QSZbwHhqqByQUFzoR678eTsgr4o4Y2YGgIEUJH+Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RQDWD+xW; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RQDWD+xW"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-374ba74e9b6so5202307f8f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Sep 2024 03:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726049710; x=1726654510; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V5RCSLLYkiPWbvkMq55gqucmS0XFLKP5JVxEa0qPBEA=;
        b=RQDWD+xWsRFJ94zmgqzzkqcyDydtUKAgWpyWd6RrZ/9UNwfsdD8kofqAxj8BTGEn0f
         m5E24KNjpPz9GXwM8hey80pTVbR8mJ4oqfLKeS3LoRyU2JSdiDiVHcOe5fenCagPphpW
         /SN2A4kY9W1YVLqq6MFdH1jXCSxTNsV53xqn8YqpT0i0YTIj7JM3RkhCmKHggmEqaJxW
         MMEbatAeBxZ6go+z0YTjQpBSHx5+Hv0rK3ClrVjK6XRvHkuDB8VDIhJRO8ifWAUAw2Ns
         3UQWFWMUWh5Dg37/ny//2HJojqTS0EhronOlCr3a01qYwp4K7Iktdn/gI8OHYUacpZrg
         K3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726049710; x=1726654510;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V5RCSLLYkiPWbvkMq55gqucmS0XFLKP5JVxEa0qPBEA=;
        b=AS303fc8PX9vneACiAjjP7VdGXqUNeR2ZIFNkd1+4aEVmmu/joDvEYp2a/d1Fvk0PA
         8ApDAi3qBztbwwbrokIU5j6Sas9g0Eld9BqXrGtYuy1LMRkMcM824tkb7tEUiqYmWeDP
         2JNeRL5OSLOAtx5NSWl8gwLIyv0+kBOMsyTs0PIF6lUll88e30eK5OhPT8RPrM7895mX
         2fvasbMXukH3qA6GuxbIzTjI7KiOmP74s81w0Yb74sanRWOkrki0PH5vRqoYLIURR4a3
         Ye6GNQE5iz/uSeiVefFIRQFTaQhJaEQ+g7Ssps04kExW4ZBGT9K/MaNlORP327jF2hEf
         PW0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFE/J7guM8Vd2IVmYvvPrZUYDTkbSW6EydIs4jM3ZXNBCGvhkqVnSPMrunFbrqWl6Ui3Xg8Je+b6xRC6uPWO09@vger.kernel.org
X-Gm-Message-State: AOJu0YxqYQx9lLBUR8alRcxfnvbBkAnj6wuUru8Eb69g3rN7HQp3/5An
	//yO+u693+r2dXMkfhh4ttZk922IIzqO0T0nXxpwUbO8f4ug/7RV68tUKwtE828=
X-Google-Smtp-Source: AGHT+IEwtA2BAwCy8dZFIsDc1pAg7VcTciPDzhUXTruAUTrFdpFgeQ+jVnBwNxAD3asUMqyEB1RRSw==
X-Received: by 2002:adf:f247:0:b0:374:c8b7:63ec with SMTP id ffacd0b85a97d-378922a6c62mr12205131f8f.21.1726049708974;
        Wed, 11 Sep 2024 03:15:08 -0700 (PDT)
Received: from [192.168.1.61] ([84.67.228.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956e8644sm11111446f8f.114.2024.09.11.03.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 03:15:08 -0700 (PDT)
Message-ID: <c37492e5-6a1a-4506-810c-ec59056ee85b@linaro.org>
Date: Wed, 11 Sep 2024 11:15:19 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf ftrace: Detect whether ftrace is enabled on
 system
To: Changbin Du <changbin.du@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
References: <20240911100126.900779-1-changbin.du@huawei.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240911100126.900779-1-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/09/2024 11:01, Changbin Du wrote:
> To make error messages more accurate, this change detects whether ftrace is
> enabled on system by checking trace file "set_ftrace_pid".
> 
> Before:
> ~ # perf ftrace
> failed to reset ftrace
> 
> After:
> ~ # perf ftrace
> ftrace is not supported on this system
> 
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> 
> v2: rebase on perf-tools-next.
> ---
>   tools/perf/builtin-ftrace.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 88a87bf387d2..abcdc49b7a98 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -80,6 +80,24 @@ static bool check_ftrace_capable(void)
>   	return false;
>   }
>   
> +static bool is_ftrace_supported(void)
> +{
> +	char *file;
> +	bool supported = false;
> +
> +	file = get_tracing_file("set_ftrace_pid");
> +	if (!file) {
> +		pr_debug("cannot get tracing file set_ftrace_pid\n");
> +		return false;
> +	}
> +
> +	if (!access(file, F_OK))
> +		supported = true;
> +
> +	put_tracing_file(file);
> +	return supported;
> +}
> +
>   static int __write_tracing_file(const char *name, const char *val, bool append)
>   {
>   	char *file;
> @@ -1583,6 +1601,11 @@ int cmd_ftrace(int argc, const char **argv)
>   	if (!check_ftrace_capable())
>   		return -1;
>   
> +	if (!is_ftrace_supported()) {
> +		pr_err("ftrace is not supported on this system\n");
> +		return -ENOTSUP;
> +	}
> +
>   	ret = perf_config(perf_ftrace_config, &ftrace);
>   	if (ret < 0)
>   		return -1;

Reviewed-by: James Clark <james.clark@linaro.org>
