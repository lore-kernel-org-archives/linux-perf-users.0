Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C00035F8AE
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Dec 2025 13:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766584297; cv=none; b=IAxfJK0dUmUbzhtJXwXITj6t1ihV9ZSezNuriE9mN+VQs9XH293ImgokN5Ws9CGYXnUtKuGipAP7bSW0eDWgTn/EvZ207kS3oPhYzUGvTxxbiOHdyo5z785QUipR8KiZyKEOSxnNZR7ljO08yv7bwgU53AZJQZdQhMr1/miGcuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766584297; c=relaxed/simple;
	bh=sHiiB5bXZsqhP9gX8KjsvqSPrH/xDtqYsun5t11H5T8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=shyN5SrZohr3yB+V3hpTRcVA9YcuC3g5XMLqYEZ1kUmHK678pNqP3W1XEobUtcClEcPU6yhjFNcZ9ItECQJoNpaKWoODA07wQTjFKlvN87zOoa9TxYLsB2KmpyOxvsPtsr/gAYVe2AJapsvClS/e+lGwRfVS7ZfziCmqTV5neAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LSjYnGje; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LSjYnGje"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so34612135e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Dec 2025 05:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766584294; x=1767189094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N/ZzF1obUaDPXRtg/yqUVnjeEhP/ZAQCXQITZaB2iu8=;
        b=LSjYnGjeXzbusA1CqoGfYxC8at+FB3Yryz7hNSqXUeHgjdz8GLYa4x+XV8UXTRRfHL
         7VGnajBoBW1KlXMDvZKPQLh17+pQ6TOUME/rEZ6UNWFUjJsnQT9aIyjj7/evRBsVuk48
         MeNy2HIc6qSUweHP0lBOGPICeuX0e/NCsfC9M9HOuvM7dmr3QcE5Y/VbjFYKLDgNecXb
         lj6gCxv5G2xezSBLwwxyzDFkq6toJyfM96zWhfVETMdj3xJxr9dQMH56e90Y6SyWHL7Z
         mTiE2+Jlrvj7bPbaVSXIWm3OKnhyLt5HJ5/Uk7w65x4VLpvKJxs+aWBUC0CPg5goge93
         3/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766584294; x=1767189094;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/ZzF1obUaDPXRtg/yqUVnjeEhP/ZAQCXQITZaB2iu8=;
        b=HDhCiUhKPgTf3LbHL/iYigs/+YRrpFRIT63GDUorqz/NXwsYymVAvryVPxtppEs+/5
         6GDBzGCWlKaL8VWAvUQFD82GXKo0iRV7LVUThbQkZNZR0g3bIoxUVh2b9Y8w8FxlwqTD
         ZxRX3bnt27vi88DzbmwGrOnnd8UbbztDv+5RC3OsYIMHqL5NTyEMttLhXWv2rRDIVpX6
         Qtwz+Kd4OHEHHqvMVLBfM2fPElC2F1pe0X2DIOjzBItIR9+Lkxc3Aleum5hw12hTIzdG
         nrreyaYMTNLoC5vVHA35hCoQ8BkRy6lQSVtJJxbqDo9EZoB2eO2wAQYCab+tIkznKhlS
         gP9w==
X-Forwarded-Encrypted: i=1; AJvYcCX/f7LGxKIkQ4i+Z1QNWEApAfb7nxIp+qht82mu85PrvnHKH8nbWKSq/iuHHhEA4o3aTe/UP9haFA8ZhWgeUOa6@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6qN8tqNO7ZEdObvXOqfa72t+B41Xa2b9KiP4YAcZ5l0mdEGZF
	YN21VksRH0a6iuVFM1rPFkwrm3cRyQhazuLYPeOfSZqP4Tu7Cg3+cfM/T/7x+7tdJbE=
X-Gm-Gg: AY/fxX6ZtIvWeTeufs07rbLpEW19zxOiuLB/+bGILC1bw45eXVTMGRxu4CNa1By7krO
	DZd3LTcefkG8ynBoainIvvcCSIneKf4ZgOv6KiXAyRpI0HNL36od9Nczm9Q8cPQvjhetLzJugq2
	ulN8XdysSQDKl/65QqnMZRbpA5lGbNTJ6dKfZ97Xw8B8m37E62D5oyw7fpWrVPC7SYeHhoIc357
	XrZD4kk5K7T3qfhR7SOjkCfN+VqII3l0L0nB8BFuOBm91fUHU0Y0RTr3EoJJI+FBM/FYGPsj72T
	rs0onvNbjjjlcCDmY3BSocZ8HHwhZ4H0i32HaEfQxptsOCGIbkmw9dTRYPEvMGeaY4qwENkeHM/
	kgs0MsTzLFUjCRxQhFLdeDlOZxsRcE51sR6jrf9tSZAyYUnCovR7u3ktAnOz0SWobB3vgpAHIIh
	u6pu+tqGbAl71FBsSp
X-Google-Smtp-Source: AGHT+IHoSRL1o3IUph4veUjp/8KyyN5BGuaOL926mUFfGKUJUv97WAdZyC8VGREHkTIDjwSD0Z111Q==
X-Received: by 2002:a05:600c:1d1d:b0:477:8ba7:fe0a with SMTP id 5b1f17b1804b1-47d1957da90mr176764295e9.24.1766584294440;
        Wed, 24 Dec 2025 05:51:34 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193e329asm297696205e9.15.2025.12.24.05.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Dec 2025 05:51:33 -0800 (PST)
Message-ID: <69a098d8-ff54-4746-96d5-5ce5eb2a8a83@linaro.org>
Date: Wed, 24 Dec 2025 13:51:33 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] tools headers: Don't check arm64's unistd.h
To: Leo Yan <leo.yan@arm.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
References: <20251222-perf_fix_syscall_header-v3-0-eb4a8b9dfe66@arm.com>
 <20251222-perf_fix_syscall_header-v3-3-eb4a8b9dfe66@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251222-perf_fix_syscall_header-v3-3-eb4a8b9dfe66@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 22/12/2025 6:06 pm, Leo Yan wrote:
> The arm64 unistd.h in tools now diverges from the kernel header.
> Comparing the two headers is pointless, remove the check.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/check-headers.sh | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> index e0537f275da2f79ea9e05b91300aa1e2f996e9f1..da3aca87457fdc56c96d4184f2dee88dab026d98 100755
> --- a/tools/perf/check-headers.sh
> +++ b/tools/perf/check-headers.sh
> @@ -54,7 +54,6 @@ declare -a FILES=(
>     "arch/s390/include/uapi/asm/kvm.h"
>     "arch/s390/include/uapi/asm/sie.h"
>     "arch/arm64/include/uapi/asm/kvm.h"
> -  "arch/arm64/include/uapi/asm/unistd.h"

Isn't this _more_ of a special case for arm64 than continuing to do the 
consistency check like in v2? It seems like the desire for consistency 
isn't taking the whole tools/ picture into account and we end up adding 
more inconsistencies than just the regular static copy + diff check that 
we have for all the other headers.

>     "arch/alpha/include/uapi/asm/errno.h"
>     "arch/mips/include/asm/errno.h"
>     "arch/mips/include/uapi/asm/errno.h"
> 

