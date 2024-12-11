Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11CE236FAC
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Dec 2024 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733910627; cv=none; b=cI48IOyZ0N0jZcu6Y6wsdZ8TCKnwDPBzSOErN8dIXjPOAdwY9EQP3EW13iMlBTQUZLkP//lxN2dGHoHN1CPjyKhPP5Ec2FlFX4GfNKdwnM2Vxy4Y+tTwN/mJ/ZwEBUkXDws+yT8gCDl75jk7RPKTpJwFiVpnDy8NTD4XtsZevEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733910627; c=relaxed/simple;
	bh=79Y2J60i/jBcsrblqYc4FLqObVvr3StOVIJMFYlmu80=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=PoN+ZUQgkf2FvzLmKGelczpheabazi5Fe9GuAQMU09j/6+iOJYscqjvQ7bWpZMpOKT/bDsCHeSjm97Uf+fs37HYcBpuEuIkvjHspLtRiCKpbKZcJjSUFoj4okBzL+w/TGABMVRa+5FdmNgdnkiw/gqxdFAEa21upAnhJCjES6uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=agtTFFEE; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="agtTFFEE"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434e69857d9so2754715e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Dec 2024 01:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733910624; x=1734515424; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VGWXQh2y/a4pUNmJ5UgKe43cJc98Qm0WVvIS6JUL+7c=;
        b=agtTFFEETsRHylNhX8OINKR3lyouyEtfM1oEBoPaNFHpMzYdt6P9AMyYp+froBvCiN
         Om4n9unPF5nwc9lPoJJbndcqNxWB8FiKZcmQPf/OBiFr84jL8B88fGFUtaPwDW+oLiK5
         ijUMFvZIhzJyVT8zhCLyunBR6AViL4dbbOlKQxnq4j3mpydx/cgkUh1HE5MTqq6+CBbH
         Y+2QJrf9+lepzN3zhbwbSFqXl1JSQzOHlUiDMJJof2/rwe7bt9OzX5xSfg7RNuUVpzSw
         vlx3rS6466AZV39a20B3fxFMPbrIGTF4HbbXSTi845PCyr6Rx0l/T8OmDtH+VfAOHbb6
         kUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733910624; x=1734515424;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VGWXQh2y/a4pUNmJ5UgKe43cJc98Qm0WVvIS6JUL+7c=;
        b=JfIa8+/W42O/wc5QFi5KjrXWtmtxAG2hYB1k9yzVGNVuAl2pChAW4DsdhF1iIzKgF6
         o2Sczcd7Gpfyl6hzpyxohNtT3TYhvZ9Li5rbGSpOSnEm5no7ZOV3jXBpj2a+RCDuoIWK
         BsPTplwc4iXPBAIIrF//Lz3t1LsgMjRGpUcLo1vFzJStnzzhcGVHNJ7OBcqwSs1Et/Cj
         ifhNiNBPhIsPLAXpNP1YLDeWq+CVjaQ4xRC5lAb29uFdD/uvw9g7iS7weBgdWa9FLkGh
         ni3dXp21Y7D2OT877yGsgAZGKldsbbJKzZtX/hy4LrBeN2UsQjJjnS6JDHzWJgK3CSrf
         o6uw==
X-Forwarded-Encrypted: i=1; AJvYcCWoLJSABFu88KargnXr8jlYMqGU31d2+YcqPkMw4fevHX9fK7++itsViZ33l9SbWH6VL5ofhvEzPEkHbo35c+dy@vger.kernel.org
X-Gm-Message-State: AOJu0YztzC2feDWjGhobSukq+TW0uv7w8Axnv6IQVOVkptYHMjBXc6OV
	5yXP0u5j2Mwe7XzjTKoJjnONPXKux+V9g4ac0ewbTtqcAxTLqZsPuK+UDhrjCWo=
X-Gm-Gg: ASbGncs1XvAeY6sz8WUYl3bCqvNE4Y1qZUX8VckmhTF4Jy/1F1ZnsxgInlpvDvOewl3
	1lQS8YAbwEJQRPn45PbWhNtYUMu+YhtjehwMIk3Lapumy1oXuYEkUsOPZ2Vi9pncGttysMfVQh1
	lX279WwmXHwgwxB/MOYNwISzteQUcuUwtozJO9HMM8MWSH5q+hYXdvRpwrjnS64kA5QlBLhhBQ0
	X4fPFfs8ISaCWKlylwOoMceK4r1NwuzC6UYnpqnKPIzphid1sdyo39OVEKcyrISew==
X-Google-Smtp-Source: AGHT+IFkmAYF/4ple1UJDkLPOCeYZOjR8X/YoiUVeI4zDyJ0l2Wc/JKpoP9the1ZI3JMJKeQfZNidQ==
X-Received: by 2002:a05:600c:3b9b:b0:434:fc5d:179c with SMTP id 5b1f17b1804b1-4361cd65b6bmr14401705e9.13.1733910624039;
        Wed, 11 Dec 2024 01:50:24 -0800 (PST)
Received: from [192.168.68.163] ([209.198.129.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434faeda409sm87538405e9.7.2024.12.11.01.50.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 01:50:23 -0800 (PST)
Message-ID: <7c118b40-3b31-46d0-8967-e7c35f6a4868@linaro.org>
Date: Wed, 11 Dec 2024 09:50:22 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf test stat: Avoid hybrid assumption when
 virtualized
To: Ian Rogers <irogers@google.com>
References: <20241211061010.806868-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241211061010.806868-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/12/2024 6:10 am, Ian Rogers wrote:
> The cycles event will fallback to task-clock in the hybrid test when
> running virtualized. Change the test to not fail for this.
> 
> Fixes: a6b8bb2addd0 ("perf test: Add a test for default perf stat command")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/tests/shell/stat.sh | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
> index 5a2ca2bcf94d..60cea07350e1 100755
> --- a/tools/perf/tests/shell/stat.sh
> +++ b/tools/perf/tests/shell/stat.sh
> @@ -165,9 +165,13 @@ test_hybrid() {
>   
>     if [ "$pmus" -ne "$cycles_events" ]
>     then
> -    echo "hybrid test [Found $pmus PMUs but $cycles_events cycles events. Failed]"
> -    err=1
> -    return
> +     # If virtualized the software task-clock event will be used.
> +     if ! perf stat -- true 2>&1 | grep -q "task-clock"
> +     then
> +       echo "hybrid test [Found $pmus PMUs but $cycles_events cycles events. Failed]"
> +       err=1
> +       return
> +     fi
>     fi
>     echo "hybrid test [Success]"
>   }

Hi Ian,

Isn't the distinction between task-clock and cpu-clock whether the event 
is per-cpu or not?

$ perf stat -C 1 -- true 2>&1 | grep cpu-clock
               1.49 msec cpu-clock       #    0.917 CPUs utilized

$ perf stat -- true 2>&1 | grep task-clock
               0.30 msec task-clock      #    0.366 CPUs utilized

The test uses per-task mode so this change makes it always pass, even 
when the number of cycles events doesn't match the PMUs.

Thanks
James

