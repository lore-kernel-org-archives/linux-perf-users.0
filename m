Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF341D9664
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Nov 2024 11:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582574; cv=none; b=C/Wp3oK80H0caMJMEKdbg2vDy3OKSkbmpDLW/0dUXcbUJlRpU69LzM7yeIaC6UWWIulLVTO4RWS4UUpJaDZPN6H0kxQmTxmpCUmxN6R/vHIy14W1ei5xUxi/SzKzkGJ75u2LmLTflDsxr2SuED/coXWtGdx9cF7dWmo6tzqnixM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582574; c=relaxed/simple;
	bh=tosTpACMBr90iqiDKF/YON69YfCEcBco4UivdlsdubU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fk620KiRBhG5S/olPGKn8B4KKeJLX+xc1h7zmObZFf2r+l0wVl6qX1bSkt9PCBbHoo2yUsQgqDnaWeb0JOQ4AIZIsmgOGW2ojH/zv2Ma27DVLkBsx+I7LMJQwBHHzfiaxfqj10+rz06rlbCJ+5SrCFyaBKGbStN0gF8cgbds41Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ttkSUlFt; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ttkSUlFt"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cece886771so873027a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Nov 2024 03:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731582571; x=1732187371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4B/6kX8Dv1v0x61K7KnGVF200oD26dvfXr9yaw5UIdA=;
        b=ttkSUlFtI6IMMxHtMq/dbGF6NwPyQcgiu/xyNbf/d7lYYoKS+h9dbnjo8xjw9esYVp
         NxnDwGUxR+tJmWTSpqZcmeth900MjXpGob0zG5QB1QZhE2YE1pUb8Jkk8RT5lTpNZuCt
         VPYIGLazhPfVfJSxfQ5g+F1kKgcCd9ULX9xO4qCkVsFB1NKEqQqEW2DZf1WyVgoRLVwJ
         HPiYw6eDft8DxatA17WiwTG6np/HJVXKW2hRMH3Xubj917EXbhCAr7mmG5oJgp/E3qRU
         8HMKtTpQQIfL4enX9T/IfZAdMhEREktfnxHPG5OtEfQA9xon77FCvoHkC418JqOnSmML
         yHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731582571; x=1732187371;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4B/6kX8Dv1v0x61K7KnGVF200oD26dvfXr9yaw5UIdA=;
        b=hIM9d3e2YYZvEWt0i8lBqDahAEjHOZdoCsfSNBvfe2gcDITZx3OFKNAjXa26tiRFAA
         RGh0lDSMb0AbQl8llTaDvJdR0Hmde07vB2tb+bPfA2eQKyQtu6MT1RPcmelLNMxoJvD9
         uuolFHyArxp5eBkSzZT/Zb1YsrE0rCI1h7TQ0SqI6Mkh2rGHQF42p5C7NSWkyK8qty99
         wocB11eQ7peJsFOx4FTUaW/T1WserS7UgSFH1KglGQFbrXuyLk09MiY8/OCwfW7M6kb7
         7FPjwIYj/yaKxsiVwBPzwcB5ya1EL6fYf7SSyXKC2sXC/h9VnuCfxhxQHCMF+GRjc3Wj
         cDNg==
X-Forwarded-Encrypted: i=1; AJvYcCXUIwZYLFOBla9BkeTjsvpsHYZ/ee7ZiTfCjTqxn3tjSbJ20p5VURneFuQvCHLBsvB9rwp0xaq/WxWBGqXbqwWi@vger.kernel.org
X-Gm-Message-State: AOJu0YwUQnRlyMKESBIhzhOTFfHvaLPUxc7Z3iXEXx0fueK1uBYzV9ik
	XOwAJKE/WJpdv90Nat6BoyESWNp62ITBfEqy87XnjZs50vftQBxMT9xTThXKVao=
X-Google-Smtp-Source: AGHT+IF2C+FExDVfDs7XP69Gi5qTPDO/xl7y4YZmBo3xSaFOop1jpkIHKM5PZ6uedcT0B056R4IB4g==
X-Received: by 2002:a05:6402:43cd:b0:5cf:a27:c87e with SMTP id 4fb4d7f45d1cf-5cf75512e6cmr2581823a12.10.1731582571024;
        Thu, 14 Nov 2024 03:09:31 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.214])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf79c1de36sm458723a12.84.2024.11.14.03.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 03:09:30 -0800 (PST)
Message-ID: <b107d9a6-48b7-468d-b36e-da9c587b7953@linaro.org>
Date: Thu, 14 Nov 2024 11:09:27 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PING PATCH] perf/test: fix perf ftrace test on s390
To: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
 svens@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
 hca@linux.ibm.com
References: <20241114090149.1489811-1-tmricht@linux.ibm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241114090149.1489811-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/11/2024 9:01 am, Thomas Richter wrote:
> On s390 the perf test case ftrace sometimes fails as follows:
> 
>    # ./perf test ftrace
>    79: perf ftrace tests    : FAILED!
>    #
> 
> The failure depends on the kernel .config file. Some configurarions
> always work fine, some do not.  The ftrace profile test mostly fails,
> because the ring buffer was not large enough, and some lines
> (especially the interesting ones with nanosleep in it) where dropped.
> 
> To achieve success for all our tested kernel configurations, enlarge
> the buffer to store the traces complete without wrapping.
> The default buffer size is too small  for all kernel configurations.
> Set the buffer size of /sys/kernel/tracing/buffer_size_kb to 16 MB
> 
> 
> Output after:
>    # ./perf test ftrace
>    79: perf ftrace tests     : Ok
>    #
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Suggested-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>   tools/perf/tests/shell/ftrace.sh | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/ftrace.sh b/tools/perf/tests/shell/ftrace.sh
> index a6ee740f0d7e..742d6b8f34d3 100755
> --- a/tools/perf/tests/shell/ftrace.sh
> +++ b/tools/perf/tests/shell/ftrace.sh
> @@ -80,10 +80,21 @@ test_ftrace_profile() {
>       echo "perf ftrace profile test  [Success]"
>   }
>   
> +if [ "$(uname -m)" = "s390x" ]
> +then
> +	ftrace_size=$(cat /sys/kernel/tracing/buffer_size_kb)
> +	echo 16384 > /sys/kernel/tracing/buffer_size_kb
> +fi
> +

It probably wouldn't be terrible to do this for all platforms to reduce 
fragmentation. It doesn't do any harm and it only added a few seconds to 
the test time even on a small Arm box, maybe it will prevent flakes 
everywhere else in the future. But I don't feel too strongly about this one.

>   test_ftrace_list
>   test_ftrace_trace
>   test_ftrace_latency
>   test_ftrace_profile
>   
> +if [ "$(uname -m)" = "s390x" ]
> +then
> +	echo $ftrace_size > /sys/kernel/tracing/buffer_size_kb
> +fi
> +

Restoring the value should be in cleanup() so it works on interrupt too.

With that:

Reviewed-by: James Clark <james.clark@linaro.org>

>   cleanup
>   exit 0

