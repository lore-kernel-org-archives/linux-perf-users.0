Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CE381741
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Jun 2025 14:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750687925; cv=none; b=VFCOUl3K/bJfu2xXWZyboNpuPEbSoftZ7KR7qfDLkvjZ+s5lIpNS43Fs5f7CSDCSxWe25KC7Vl8FdVCc0kU5inA6w+hc30ZlpT8FDcx2GsMTBBucBlEVGK+wu2vnU+gTC7wvfnn1OFNj+eiCfd9/YbHp9eaEM5ylp8mL78mWkqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750687925; c=relaxed/simple;
	bh=sAJGL/AFF0QyWNLpODxJUNG0qnCygtD/QajB6OeKDTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iuKAU3ieV1Eog2AtVIkrvWbRvAwdT7txCQwLFIgdLJR4oFyI4T+vi0FRUxlpOB0S98fYWzqsc4sQT3HvskSfKoTb3/Hf8iat3VV8BFWerIxflCe2RTybgf/5Y5WKbi65Yq9gUipbKcww0CPAuVtLp16sf1xEBCSWcXhOXGVl9/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kr0iazZv; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kr0iazZv"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a6d77b43c9so1869112f8f.3
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Jun 2025 07:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750687922; x=1751292722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=04zirTBW4ONaae9PYnnFEhRuzM6dzMMflL0XU/SMCpw=;
        b=kr0iazZvcf2+sgH1Om2HhASA+yqPhpXC3yfK35BGSxpEfW8PpRfNuyUIUbG/0jWcBE
         5lik1eYJGmlNA4GczWbEiLmlSb0APKm7iVcquu0R0xBVF+rejTpnZTp5yOvMdnq3u/tj
         Bs2knCvSvrAsq65GHNCaICRV1EH2H8DH85m5EZSqirMVW8PvozFnO40yMF4SSUDiKh31
         6aGhZVjWCHcbdvGCcGTC2s1SOB8vT+rfmLuVdoUtZzaisVEVUdfZtbPByqYTNs/nWiuG
         S/7ec9nhA4CkdDULJ3vQ58oEXrfKAWrutD3UFnrdMgfQvtp6KGtzyoYGwGO1VXojo0td
         RHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750687922; x=1751292722;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=04zirTBW4ONaae9PYnnFEhRuzM6dzMMflL0XU/SMCpw=;
        b=nHBBSjKA6is/30NMteuooyVZNBeLTVl8zQzugUFafebylrYqfnMfD1FfGI6Xb7LtPS
         nrkLdtKupWp0AyryNibvFc7ijKWjh0xkdsYseIq9rlJF1YRF5gpq6vXbH+WFrVN0l+uG
         q1xnslEtGrihmYQdq2qWIQC1UNo4LH3tKT8QALl9xLau7FR8rNMpydvV3qr06kuuOfrs
         j+jSOL4bx7vRERsFpPBw7T1WPNUkwcl9s4sEevcAArU9Sz3YqL+B7aR272JBMskU8SBi
         dUffDqhsFYZuZbY5rne5Ouersr/4zZ0vR5atLQwaLDxS1a2xKCkJfPNeolrwJR9/fqmc
         Vs9g==
X-Forwarded-Encrypted: i=1; AJvYcCXhMvdfcvKrgP3Hs4fa3mNM1am0TU3yMvXWMQQ9gb8uk9WzvH3oerp/ZKS0pMtDxKuyF5mPBOQD0YgZjeVxiP7a@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk97RZb/hUCdj87FcEFAI09quUNYD5wVYe15CI7K/somkDt634
	wAZgVegF9+o4dgSZo7rfYXhPsZUgdvcMvB5EeiCPO7oo/KlGJEO5LvwC6bg3M6koY90=
X-Gm-Gg: ASbGncvqpXp03i5Glmyo+84GC0KLO0pRji2FOCyOdT3gzm4wVaLhlZ/uweShIe22zVs
	Xeiskzh/TQypp5KuzVz7opj9jGNOO89jKw0lytT/6ugCe0gtTVVWrLcZrhp3qDLtTDeKV8JkzVe
	MadOxQvEkhr3OAuZur78q0r6eFq7ukU0/e/abpVspQzEegHgYfdtjPKMqsErGKU8YAYyegGg+pT
	LtUl/twInXdqGxDfK7bO4jhcFiEOZUv2EwXB6NUHe/ZMtnSrXakbXUk/ePw9MPQWCbQ4qDBwL9J
	FA9uYhuYKpQFRP75kVuQ8Mdd3pQh3YFNtg3BEf/uoyHyaybWC4irdPF+mtvGkHSK4tE=
X-Google-Smtp-Source: AGHT+IEhFlx8KN+2GKnsD98crsVUfyaoX0mNgBuFWPQFhXzUxCR/Zb/phFY++YIze2FMTwcJnIQdhA==
X-Received: by 2002:a05:6000:4109:b0:3a4:f892:de7f with SMTP id ffacd0b85a97d-3a6d13071e8mr9361649f8f.36.1750687922230;
        Mon, 23 Jun 2025 07:12:02 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d1188804sm9526600f8f.79.2025.06.23.07.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 07:12:01 -0700 (PDT)
Message-ID: <e8c28a7e-bc08-4c50-96ca-afe62cfcf9fd@linaro.org>
Date: Mon, 23 Jun 2025 15:12:00 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf test: Replace grep perl regexp with awk
To: Chun-Tse Shao <ctshao@google.com>
Cc: wy.shih90@gmail.com, Ian Rogers <irogers@google.com>,
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, tmricht@linux.ibm.com,
 leo.yan@arm.com, atrajeev@linux.vnet.ibm.com,
 linux-perf-users@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250620174034.819894-1-ctshao@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250620174034.819894-1-ctshao@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/06/2025 6:40 pm, Chun-Tse Shao wrote:
> perl is not universal on all machines and should be replaced with awk,
> which is much more common.
> 
> Before:
>    $ perf test "probe libc's inet_pton & backtrace it with ping" -v
>    --- start ---
>    test child forked, pid 145431
>    grep: Perl matching not supported in a --disable-perl-regexp build
> 
>    FAIL: could not add event
>    ---- end(-1) ----
>    121: probe libc's inet_pton & backtrace it with ping                 : FAILED!
> After:
>    $ perf test "probe libc's inet_pton & backtrace it with ping" -v
>    121: probe libc's inet_pton & backtrace it with ping                 : Ok
> 
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
>   tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> index c4bab5b5cc59..aaa5ee06ae18 100755
> --- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> +++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> @@ -23,7 +23,8 @@ event_pattern='probe_libc:inet_pton(\_[[:digit:]]+)?'
>   add_libc_inet_pton_event() {
> 
>   	event_name=$(perf probe -f -x $libc -a inet_pton 2>&1 | tail -n +2 | head -n -5 | \
> -			grep -P -o "$event_pattern(?=[[:space:]]\(on inet_pton in $libc\))")
> +			awk -v ep="$event_pattern" -v l="$libc" '$0 ~ ep && $0 ~ \
> +			("\\(on inet_pton in " l "\\)") {print $1}')
> 
>   	if [ $? -ne 0 ] || [ -z "$event_name" ] ; then
>   		printf "FAIL: could not add event\n"
> --
> 2.50.0.rc2.701.gf1e915cc24-goog
> 

Minor nit: the underscore in event_pattern (not shown in the diff) never 
needed to be escaped.

But now we're using awk it gives a warning so we should remove it in 
case anyone is searching through the output:

   awk: warning: escape sequence `\_' treated as plain `_'

Reviewed-by: James Clark <james.clark@linaro.org>

