Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BC344DB6D
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 13:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786540607; cv=none; b=s54Jq3xAXqhgE901MiEWOt8nUqIX/VNgmhB+EhupoWcc1NsNQH3G0zP4eo7Ea9Zg/ls91UBGhnDGYm6FPQieV1H7lypgBK6C7TjgoetB+5MYs5F6nowrKll0s3D1jW6TCUsGmXSU1LBla4BDW4woO2e9NlMnRjOl9/g+Hav5wJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786540607; c=relaxed/simple;
	bh=HJFYkb4Hajh/GcjJG40WCp0AlZL1NY+eEFakOOHDEAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LOJm53TB/zigh+VHqiQwor0TJCxLsGS9hjZzfQJ6ZMEMIsL61FbptQfFhFJbbry6G79QEgnkQaCW4KnnFfx5ahCu5zft3G1cMOiiOx4tIybwqgMIXk1XosrKgvGVjhHda58i42e5/vDLTpdMSTETKNY1JDtG3iVCh9PPMHLXsYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QvNA2YWu; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QvNA2YWu"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47fe2d179e2so529163f8f.1
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 06:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786540603; x=1787145403; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DsZokZ/iedv/wv6L1wEU+vbKd+fdKYrALL/Ray13yqY=;
        b=QvNA2YWu4ROjz/uLpNVL3aT0aAB1tRbgjj4pRNzSkMms5tgYnAcobdi2ML8Di6F7dy
         qMtG1fGfGHQGz1gO1inKoM6vc9hn8Ld8x7azM4LWP2kjkdf4Tm7jW5BUAUk4sBUK8M72
         Puwku7nfgcDOaBMNLpFPwsuBL4Q7WrA2ulKhCxWaUnLpLgEarFD9KK0s84+ndarBgsBf
         QHIIZayFkuyui22edNa+4yNc28vyppywDGLqOvq0kCOkBvVvrdyRbDYePBwipVsQWd5J
         LbYk1E6iXFFKVaQeJVzEb5czYeLpuUqgoB9um7YFmA3FEsnptZNY217cWmswfgNG/aFK
         xe7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786540603; x=1787145403;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DsZokZ/iedv/wv6L1wEU+vbKd+fdKYrALL/Ray13yqY=;
        b=pLZurVgg/Pw0jfZu1caoJ24iSfhd7xLnpFWa05mItXWZn8FahC5RyI3jORwgy1EiU9
         Jb6fAQMcHGoi4rRPnK7Ej94AjT/kMjhtK/ZTjxMczl0URVw/FPJS1Mp0t89K4wh9UmMU
         S7zzsngWCE0wtNpZMVCcKPSZwHA/epo3PP3aoOgZgHq9d8+9zhZRxbDvAbQSqyMBMB0Y
         oXAevq68KfMx7uSi+LY2WDe6xOVd0FwNDN8b+ojGAZZisYLxxFMcAQRvzWN83onR1/FL
         +dJzPrx5njMP1aoUTUjmURYWEWJBKaTxcMfWGkvVVkeP2vMeh0qZ6k6p6gOWH/6TjpiF
         EOUQ==
X-Forwarded-Encrypted: i=1; AHgh+RrEKsK6ai93h/pQXMyxCfTaBMXY0hX45madr68ke48IL6Nv2hRlyILOoTc6JJS02y/awbdBlyMoMDHPYlAU5S2Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yy39km1pW64T9O16fzA7MZ9xg0LQQ+hAeR3sUQZehljN26IQFcM
	8Y7XK3Yr1LKSap+Hbbzav8drKEvx04YgAkk+5qz9m4JNVzxDnIxcvy0wtODiSFcqFYs=
X-Gm-Gg: AR+sD11nowMqTWd9GbkcVKOdkJMlIDxgN0Hk6u/eF9YWJLgf5bWr8LhKdRpA9GfUuvv
	ep0AlGA5XKFOhhMRPc1R9h/4OY0V7KA8dyNd9CJc3fGu/N7lSQNxOrRn3pfn9qNAujLiV1c02Ok
	dT6B0wTlb2slHFM3wVX9CXJTc+YdC/JdeWTzvNrelMYK2GlSm09+ocjkaK7kFoBLQFITFQbXYxt
	kRlwdJuIi7nrEYYmd+x6RLUUPW8/DNTPhQJPle2iExC5SW6vriAV2nr0F9m6Z6AmS6roY6OWngE
	my7xpmkbPXvELIktvkfO5otGABpKOaMMSVx92a4mkhoxe6ACB8AKoRAX4/8qGkUUl84aWZQv1mW
	fN3xxJwgbgFHh77zp05fc3jgU6FO9WYhDgfbjpYWJ7AOEOesCIurcltqNRrCNcvhlJEkPF9IWtF
	2qBr0pcEVY0N3OEeSOPNH60HPMlEMuhuLUn3cmxH+hrv49205AfQRfy6jG+SlbIdIt9Q==
X-Received: by 2002:a05:600c:4504:b0:495:737a:7afe with SMTP id 5b1f17b1804b1-4997c12592cmr68779655e9.15.1786540602720;
        Wed, 12 Aug 2026 06:16:42 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997b34afe3sm57791515e9.2.2026.08.12.06.16.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 06:16:42 -0700 (PDT)
Message-ID: <274fdcb1-70fa-4976-8f13-bdf6568e12af@linaro.org>
Date: Wed, 12 Aug 2026 14:16:41 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] perf thread-stack: Report branch stack hw_idx as not
 available
To: Amir Ayupov <aaupov@fb.com>
Cc: linux-doc@vger.kernel.org, Mike Leach <mike.leach@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>, linux-perf-users@vger.kernel.org,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Leo Yan <leo.yan@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, John Garry
 <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>
References: <20260803090640.2412336-1-aaupov@fb.com>
 <20260803090640.2412336-2-aaupov@fb.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260803090640.2412336-2-aaupov@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/08/2026 10:06, Amir Ayupov wrote:
> thread_stack__br_sample() and thread_stack__br_sample_late() fill a
> caller-supplied branch_stack that is typically allocated with zalloc(),
> leaving hw_idx as 0. Zero is a valid hardware index, so consumers that
> honour PERF_SAMPLE_BRANCH_HW_INDEX see a reconstructed branch stack
> claiming to start at LBR TOS entry 0.
> 
> These branch stacks are reconstructed from instruction trace and have no
> hardware index at all. Set hw_idx to -1ULL, which is the established way
> to say "not available" and matches what intel-pt and cs-etm already put
> in the branch stacks they synthesise directly.
> 

This fix makes sense in case someone doesn't overwrite it, but I think 
"matches what cs-etm already puts in the branch stacks" isn't quite 
right. Based on the hw_id docs, cs-etm should be setting 0 shouldn't it?

  * For the architectures whose raw branch records are
  * already stored in age order, the hw_idx should be 0.

-1 "unknown" isn't accurate as we do know what the order is because we 
generate them in order. If anyone is reading the field 0 is much more 
useful than -1.

Can we change cs_etm__synth_branch_sample() to 0 and update this commit 
message to not say that -1 is right for cs-etm?

> Signed-off-by: Amir Ayupov <aaupov@fb.com>
> ---
>   tools/perf/util/thread-stack.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
> index c5ce741b07446..1a3dffa83bde2 100644
> --- a/tools/perf/util/thread-stack.c
> +++ b/tools/perf/util/thread-stack.c
> @@ -624,6 +624,7 @@ void thread_stack__br_sample(struct thread *thread, int cpu,
>   	unsigned int nr;
>   
>   	dst->nr = 0;
> +	dst->hw_idx = -1ULL;
>   
>   	if (!ts)
>   		return;
> @@ -686,6 +687,7 @@ void thread_stack__br_sample_late(struct thread *thread, int cpu,
>   	bool start = false;
>   
>   	dst->nr = 0;
> +	dst->hw_idx = -1ULL;
>   
>   	if (!ts)
>   		return;

