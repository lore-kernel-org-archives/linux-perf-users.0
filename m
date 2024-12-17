Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8736013B792
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Dec 2024 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734446523; cv=none; b=jpToYbrsVPGU68VyweG9tyaFERjfeXiJXIbXGa3pi0YRfgw8mtKyhsE9XXU7HIUS/I3oNmvxX+dJvQFlAi/0XcVKWic6XjSf5M0kY3AcYjY7mXky8ZTLZlbFoiRA54kpROlS/fu+vNHYuf4tvZRnfJgAG1QLHVu4FFQjDkOREtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734446523; c=relaxed/simple;
	bh=IduhPnhYDH1MDPrUhaN7y0qRs3lIO/NMag9SCbU6GdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZphSsy23+X/6fcdX6c7Hia5Nxb+1HN0WcS6Pg8VLb2ng2WSCNAxqSbJzV0fXa5PZcEj5s8HF7ycbucFvgmdokmK3zq6aOPCLjHfdGX13TBYzQIkiLVk+bmEFWupwlfe8cdmAOm9Rh6QQ+r2wJdLuafs3ZhB4/O432UwPefpvNRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iXZIool/; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iXZIool/"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43621d27adeso37830195e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Dec 2024 06:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734446520; x=1735051320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NkDgX86vllpaHSZlaZCU7Cun96tz+XUmIPtYmYXZiuI=;
        b=iXZIool/DonMLyLPNOTROAiMZLHEuig3f/eck5c6tnJZ7y8jluKd7nS0X97OFTJC35
         mT1sdSTVkT19YJE+MTdNJQm3hd8npaA2INoLdW5PvlrCFqQY6MY+PPBf3NtstoaHSQUI
         g/xvpWAjMvE+NX8pEAMKugj7FAlkeI9gfmv9LZizKY5Nqe3Tsj9HVfZKHDe7G1gAebJ+
         6MnqK9ckNxTbhtawHaVf/9KCVFY2UQ2R8+34Xb1BYdDn5WrnclVFyzVxtHAors7Nzb3s
         jf4amT8ZKzucOYX6pZ28uevXVwB0it/0Gc6255+Q6WR1hxI46dzHmK37XKIWzVdSBH05
         vWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734446520; x=1735051320;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NkDgX86vllpaHSZlaZCU7Cun96tz+XUmIPtYmYXZiuI=;
        b=G/iPyazn6EFw1oBS5Y/graQBTrsqeJpvV9rBqDseWABYlkAEikQVS0fNWdCsoS/tzg
         I/rkV2iy7K73lvodE8fcdsC5ZyK5iNnrWMpOBmMpPIUp4tvnXmX/xgGExgK4GuJk6g4e
         TcsXA/+EOIel3DMhm55v+Kl/WIeSWIZPLOXZvCIgY8+bFlLtFJEwCpkcr8vCAdTf96Rc
         JZhdioBLFWuxULNkqDpX+GHX18bO4RTTZbnccasJzZ5DxnWA5/BzOWVTCjLAsTeXIzp0
         QKbqTX3S/kBtcVHEH6TC4hyNMLSjWiOsJnsFEQ+CuBtTI91DhlUC+ZA94IQwst4n67KZ
         QdFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKBsLTWkpB1GdjsZRw7660eDF+t2p04zbfy3+HodQoOmCOXrDi2+DpA6Lu5SjvQaE+QS4sIhDSZ6VvKrdlDP5B@vger.kernel.org
X-Gm-Message-State: AOJu0YykT1U9hAgqWaicR8++ZD6bZNZggd5Oe/MPYIQcnz8TX/mf8NRd
	tEggY2LeOG+qSbPK1jepQSPca8O2err8oOqmHPwYuHf0SGQVXJ4HcNIy//FmAQI=
X-Gm-Gg: ASbGncuA5yAQbchp59uomOkWFmu50SnrnoqDVBcWq6lBRLYKU0+InQPRP/TrzB2Z5P2
	lcicvgk34/+tA5hBm5vUDSrjsjd0UOOLHb9YIzbrOkW8lvam7if0RYEjZhgrp5AALvbCtI8DzGs
	N+bxKcvb3RbJb5APUoqy/Ouw9lG7zPMT2ZXYEnKEx+/ZS0YGipxc37wSKbJJKhgBha0q4ncEwYs
	Foo7+/oivbTUSMrRzAhDqSkdqrcgke0+6z7F45gb+4GlizPGP2v2A1O0HOSfUjvaFw=
X-Google-Smtp-Source: AGHT+IEzBbDbt3N095GZWA5AkGypzQVy5bfUKzLTwWMXJ09Q7iKoxCNLX0cW+TNl2Iv09tcOh2gpSQ==
X-Received: by 2002:a05:600c:4e8c:b0:434:f7e3:bfa8 with SMTP id 5b1f17b1804b1-4362aacb94bmr138319775e9.33.1734446519862;
        Tue, 17 Dec 2024 06:41:59 -0800 (PST)
Received: from [192.168.68.163] ([145.224.66.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436362c8fbasm119231555e9.44.2024.12.17.06.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 06:41:59 -0800 (PST)
Message-ID: <1cb01bec-d5ad-4081-956e-32ac424b5e5a@linaro.org>
Date: Tue, 17 Dec 2024 14:41:57 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: test: Speed up running brstack test
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>
References: <20241213231312.2640687-2-robh@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241213231312.2640687-2-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/12/2024 11:13 pm, Rob Herring (Arm) wrote:
> From: James Clark <james.clark@arm.com>
> 
> The brstack test runs quite slowly in software models. Part of the reason
> is "xargs -n1" is quite inefficient in replacing spaces with newlines.
> While that's not noticeable on normal machines, it is on software models.
> Use "tr -s ' ' '\n'" instead which can do the same transformation, but is
> much faster. For comparison on an M1 Macbook Pro:
> 
> $ time seq -s ' ' 10000 | xargs -n1 > /dev/null
> 
> real    0m2.729s
> user    0m2.009s
> sys     0m0.914s
> $ time seq -s ' ' 10000 | tr -s ' ' '\n' | grep '.' > /dev/null
> 
> real    0m0.002s
> user    0m0.001s
> sys     0m0.001s
> 
> The "grep '.'" is also needed to remove any remaining blank lines.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> [robh: Drop changing loop iterations on arm64. Squash blank line fix and redo commit msg]
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> Originally part of this series[1], but I've dropped any Arm specifics,
> and it stands on its own. No reason this needs to wait on Arm BRBE
> support (which I'm working on now). I don't expect to have other changes
> to this test related to BRBE anymore.
> 
> [1] https://lore.kernel.org/all/20240613061731.3109448-8-anshuman.khandual@arm.com/
> 

Reviewed-by: James Clark <james.clark@linaro.org>

>   tools/perf/tests/shell/test_brstack.sh | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
> index 5f14d0cb013f..e01df7581393 100755
> --- a/tools/perf/tests/shell/test_brstack.sh
> +++ b/tools/perf/tests/shell/test_brstack.sh
> @@ -30,7 +30,7 @@ test_user_branches() {
>   	echo "Testing user branch stack sampling"
>   
>   	perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u -- ${TESTPROG} > /dev/null 2>&1
> -	perf script -i $TMPDIR/perf.data --fields brstacksym | xargs -n1 > $TMPDIR/perf.script
> +	perf script -i $TMPDIR/perf.data --fields brstacksym | tr -s ' ' '\n' > $TMPDIR/perf.script
>   
>   	# example of branch entries:
>   	# 	brstack_foo+0x14/brstack_bar+0x40/P/-/-/0/CALL
> @@ -59,7 +59,7 @@ test_filter() {
>   	echo "Testing branch stack filtering permutation ($test_filter_filter,$test_filter_expect)"
>   
>   	perf record -o $TMPDIR/perf.data --branch-filter $test_filter_filter,save_type,u -- ${TESTPROG} > /dev/null 2>&1
> -	perf script -i $TMPDIR/perf.data --fields brstack | xargs -n1 > $TMPDIR/perf.script
> +	perf script -i $TMPDIR/perf.data --fields brstack | tr -s ' ' '\n' | grep '.' > $TMPDIR/perf.script
>   
>   	# fail if we find any branch type that doesn't match any of the expected ones
>   	# also consider UNKNOWN branch types (-)

