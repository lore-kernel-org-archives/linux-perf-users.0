Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CF119F13F
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765551632; cv=none; b=Z/pJhiX/aawMNQepE1I1D5hzAPeGrWlTMUvxydTihYtrnyA01dHilt8DONXmJAuntpCwmP/TeoOnhTOexwOF2TbheIDOo/AKhwiKj7A+J3lpWIZrtF8of0W7LtKmnPryLFrMoIaDUKKnn9g0QcytohqIsDc3Rjau3ijzIYewzzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765551632; c=relaxed/simple;
	bh=evgSYkwUYH+t4KgskXe06Ttrzqn3j/4ghuseDtbEqqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R1uyfPztA1byYIBgGu6O1edXAloqgvJE+tl7S+PwAhYsZ2hrv1+lfWmmr2WuQNtii5piXITW4eCh6VPol/sdtsfAxI6FGRJfF8oCReNXJ8AcwUPYhrPEOnsBKtH/Up9EN8u983NhaPSsfPpzO6RYw4lFqWccTYc+MS3YwA/e4VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ny05kmA1; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ny05kmA1"
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-64162c04f90so2405062a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 07:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765551629; x=1766156429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tdtwwIJNAU9UljeByxBUVUW2Rebc/JHtWDPV4PBUMDU=;
        b=ny05kmA1OkxkJQgmBTNgKBnuVbb9Gdvvwo5oNj+Tzq6wYapwNQYRA8QGL7cRZjVwCm
         xnPKfBQ4IMCJieUAS2b/D+g6QWg+yaFuJv3sNbJltO4VH8CPKY3BSI559ic4FsL2d+NR
         cPMaR8mtI6ZG1750TTct5vD77Lrp63CPafknJ75C/K5gAnoKHibUCqEZUlNIIRlhssuI
         AhS3OE+4n1e/IXkw6B7ejjJnHRO9x/lR0e4nvEY+GAmAcmmfOuFysNV16vFV9Z9z3WaH
         rJ80rOplgWRt1+SLzBimWVr8TynykOBYr24DjwACjAE+ZC8GjNtb5Stp1VEMxHkuXW3u
         +jbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765551629; x=1766156429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tdtwwIJNAU9UljeByxBUVUW2Rebc/JHtWDPV4PBUMDU=;
        b=jemMolYvOaCphH2UtN94deesrvlZ9KTFUPeWNod3oz1MJZ9cS6sPTUAXtjeskl+zq9
         urRjnWWaQlQpIWPfCsVXHn4CSMV3bKbOoRc6sxc8kB3S10c8U5pb7c/MwmW3FnDb8xBk
         /zR0a4A3XIC006C5gy37LrByTJzgXWE/JeHq28nmacynHZ2t/PEcPndkcxZcxNSoVoh6
         JGn79+XAJz6UblwjPnryP7y8uThJOp0nWbgOk72juHIuOMk3RnvhGG04IeRz5/tDY0Wg
         ELyvwH1kcTtYjo9Y6q3CvB5Q/j5RQJv15rFEYuiaKkF9Qt62/S2Kq08RAK6UdiqHC7tt
         ROng==
X-Forwarded-Encrypted: i=1; AJvYcCW9Y4eHWwm3gUNsuh9fI5Z/XNYrJiK48MeB8VAuZodTJXPFt7/0vNHsc67wcqCRMVJpEgUbKCpaW/H9lRRq2FOn@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0DGbPECDoZcYQFZpfe0N1Ip/U9qXh+kVTPJO+W8AhX4+silY6
	H06wzJmPLhDhB1ON9uC+gNEqlNcsixKNMWTju7cWFPoToo3wqeBUoVBRD714hKGxgDU=
X-Gm-Gg: AY/fxX74acPwquHa9cXzNgBAOzDbwj4uh6RuWNrKaTG4c5OmulXmsY0jjUqgAKr40UU
	ZFy4Av5/1qHysodsQUG7v2wpethpeQaNJrzupmZMHE9lQpmhjONXdo1M9YVkwU+sgM3WxGc9MTy
	UO0g5p1ebb2unTWTrXxvlMNbDBp+g7qE/QThx0HqKZ4Ds26wfjnyMXU9EAj7jEuY2rs+IpsGCu9
	v84jbYHcPLq1zgnN28HOpou57qTNmQaBv53OaLttfClU6Rewv6+zMB44f/tWThzvw/HjBJmKeIW
	0pDx9jJ02Rj07T1BzEBQdTpTrZTenmZBqwSoO5UYNe2jZZFFTBYuQUcTXvclDqHlc9hwqsqlsDZ
	864sx1WANA/os3+JYK5qTLGWbdo/GRu02Z1QH1PqGr79oGBNPkHdFz6/apAlO/w7dNKx8HsEd0A
	rBittx/8fuI79qlrbnht61
X-Google-Smtp-Source: AGHT+IElfvfWwMZz1cNmYrEtoT0T6NC0VQveo08Mp01q2n8OVYW3xlLRaecHrQm7FbKCC25OI7vsMg==
X-Received: by 2002:a05:6402:5209:b0:649:9251:1115 with SMTP id 4fb4d7f45d1cf-6499b1f369bmr2115809a12.29.1765551628638;
        Fri, 12 Dec 2025 07:00:28 -0800 (PST)
Received: from [192.168.0.108] ([130.185.218.160])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-649820517d6sm5453544a12.13.2025.12.12.07.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 07:00:28 -0800 (PST)
Message-ID: <c3fa97dc-3377-4a62-9fc1-561fc904cf5c@linaro.org>
Date: Fri, 12 Dec 2025 17:00:26 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf c2c: Update documentation for Arm SPE events
To: Leo Yan <leo.yan@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Mike Leach <mike.leach@linaro.org>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Al Grant <al.grant@arm.com>
References: <20251212-perf_c2c_update_event-v1-0-29a26c7a949b@arm.com>
 <20251212-perf_c2c_update_event-v1-2-29a26c7a949b@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251212-perf_c2c_update_event-v1-2-29a26c7a949b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/12/2025 14:44, Leo Yan wrote:
> Document the default Arm SPE events used by the perf c2c tool.  Make a
> minor adjustment to the PowerPC entry for formatting consistency.
> 
> Suggested-by: Al Grant <al.grant@arm.com>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/Documentation/perf-c2c.txt | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
> index 40b0f71a2c44eb642ff3bb234631a614b7c4fc9d..b765ae2511d2418a63092fb8a90a61faa335ac91 100644
> --- a/tools/perf/Documentation/perf-c2c.txt
> +++ b/tools/perf/Documentation/perf-c2c.txt
> @@ -170,11 +170,16 @@ following on AMD:
>   
>     ibs_op//
>   
> -and following on PowerPC:
> +following on PowerPC:
>   
>     cpu/mem-loads/
>     cpu/mem-stores/
>   
> +following on Arm:
> +
> +  arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,min_latency=30/
> +  arm_spe_0/ts_enable=1,pa_enable=1,store_filter=1/
> +

Technically there's 3 different ones on Arm because 
PERF_MEM_EVENTS__LOAD_STORE is also supported. Although I question the 
usefulness of these without labels or any text to say what the 
difference is, but that's an existing problem.

>   User can pass any 'perf record' option behind '--' mark, like (to enable
>   callchains and system wide monitoring):
>   
> 

