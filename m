Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD19189BB3
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jan 2025 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736268700; cv=none; b=H51zufH+vkK4nV4TFmoDfTzxGH1q7rR8e+b8PFZTziYwKVrdxQKvk1TbDx30FM5hE0HwnkEg1LA5L6yRbEkTodDatjA7fShCUq0WoKcIy/uHJ63YIP99LtPcXBazCKEdaZ7AAdyLtmj69lOpDtQo0VuIOJ5FA77nN+rqOi7BEmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736268700; c=relaxed/simple;
	bh=zPQutXkq9wAFj64yViXr+nQrlVZo7TPkRloIt+aB8TU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nnI4ABCw9OEZ9K1EfQ6k5HJXSTjRQhJDgHXMk+35teCWq6mbWOHht10z5InOWjS7LLe5fPj2spFbLnfZoODM0m7ywJrk2oOn+p9SxMA6voIymywSWgGqagVlGMcMEDR5SOUdwWa0hhG2afm60Dnq9vRuISzyN614VZw5W6jg++8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P3B2uSir; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P3B2uSir"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-436281c8a38so113202515e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Jan 2025 08:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736268694; x=1736873494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CTSz7tBjYqInw46x/njFFjf677aGPAIHNq1BnsnC+ec=;
        b=P3B2uSirmLExn0hXMeC5YPloPwD86hGmtUfEJLFxcThDr/A8ScfvZitRTr8xCpyhzW
         QyK8yf7gC8LtWwybQkGaCUe5FGmokA56ciuo2YxCKIWJCG9qWw4hkOH9pHk81ipcfEsK
         pi391vGUmjj6lPYFahNY8OriPxtNRS1mNS8v+Wf8sNn2vu7oGUVkWVrjBxnclNgDQ2mw
         D07TT6uiiZ2efmDnIh8JOxIiBfns9eHYdg9IrDH0mxEDuITHQfby1dSKrD7jPbaJP+KE
         MiRe26y40kH4iTCFt8PKKNr8yvAzNCrOMaUT1M/XhbHIUmXvhbHH15dLehd2qyQuVad9
         kzpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736268694; x=1736873494;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CTSz7tBjYqInw46x/njFFjf677aGPAIHNq1BnsnC+ec=;
        b=l+NnHf5gYpFHvnzf8D8slc4nB3XMg7BFVt++/veo340PgRinef2fcPnnAdx+ZgDUAU
         LOSlarh+7etw8jRG/PtWGu3mdgcdnDdNegsui4yyDj745AoWu3s2QBRppaYY37dEXtUK
         6O21nOgjk6+UNoz7XZE4W17smK2/q4Vbu/m36clhOT/Y+p6Y9/c/n4fM0C/a8+AuycHq
         xrvYM9wvCCV49jed5XJDHx2fOLmNiVm+s4onxLN3LQ1NXlIuGdamMCEHwrTEEk1VbxAg
         vqbPuIUhyiSIxb4j9xz7IeeytWGUqNrsB0+Ftdk+lFcJTCIIX7mGz9QWTINTA2aOoF9b
         h6iw==
X-Forwarded-Encrypted: i=1; AJvYcCUxtg9PpKC+aqlzODUdcxqPRVbRtHP1octiBYC73CwN47VKsvtoL9BHKxIQSV8/HRb+v1m9g/uqIqNSATK/8YKG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6n/OaGYE12Z0+hGmaAuk+zwXMw5EoXJPpFe+zjcD1AU/2hLKK
	/OS+TFjDzDLHg63mJRIrqbm517AY1x3sm4z6m+anB99Gx81HfO+UY49r1gAofvE=
X-Gm-Gg: ASbGnctwral2pm2GbvsIK5FkfXFTQ1tBqiPRrFpCx//+46WZ5KrHWBHTUHXDwkf5gI2
	6XFAQY8DHkoEVKSz3Wo2/3k4L/R6prpt2dMrICscxeqATZ3MdRf3iKyh1mzLmbGuZbpP4+MWO3I
	IPXW3yjN3hvsedVbXQ8slt959jVm2NOeFn2APbf8ObB2N1oWOX03W+dsjSoFZI5TgrsbNEK4BDk
	8z8qdhL4KhyF55d3FdipCl99teyuyO/m435b90yTqRWzyd2os+Xna2RSNlH04BidEA=
X-Google-Smtp-Source: AGHT+IGwgFlorz+SlEeegQol9lzim8uyOt2SpyO+pyVXVckjlFtukdA4j1A0JjMECNUEulfh40a11Q==
X-Received: by 2002:a05:600c:350b:b0:434:f8e5:1bb with SMTP id 5b1f17b1804b1-436686430a2mr559200735e9.12.1736268693699;
        Tue, 07 Jan 2025 08:51:33 -0800 (PST)
Received: from [192.168.68.163] ([145.224.66.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b119d7sm635933915e9.20.2025.01.07.08.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 08:51:33 -0800 (PST)
Message-ID: <d0ab6e2e-cd57-4477-8171-77b4c2d364f7@linaro.org>
Date: Tue, 7 Jan 2025 16:51:31 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf test record+probe_libc_inet_pton: Make test
 resilient
To: Leo Yan <leo.yan@arm.com>
Cc: Jing Zhang <renyu.zj@linux.alibaba.com>,
 Guilherme Amadio <amadio@gentoo.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Thomas Richter <tmricht@linux.ibm.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241202111958.553403-1-leo.yan@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241202111958.553403-1-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/12/2024 11:19 am, Leo Yan wrote:
> The test failed back and forth due to the call chain being heavily
> impacted by the libc, which varies across different architectures and
> distros.
> 
> The libc contains the symbols for "gaih_inet" and "getaddrinfo" in some
> cases, but not always.  Moreover, these symbols can be either normal
> symbols or dynamic symbols, making it difficult to decide the call chain
> entries due to the symbols are inconsistent.
> 
> To fix the issue, this commit identifies three call chain entries are
> always present.  These entries are matched by iterating through the
> lines in the "perf script" result.  The recording attribute max-stack is
> set to 4 for the possible maximum call chain depth.
> 
> After:
> 
>    # perf test -vF pton
>    --- start ---
>    Pattern: ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)
>      Matching: ping  285058 [025] 1219802.466939: probe_libc:inet_pton: (ffffa14b7cf0)
>    Pattern: .*inet_pton\+0x[[:xdigit:]]+[[:space:]]\(/usr/lib/aarch64-linux-gnu/libc-2.31.so|inlined\)$
>      Matching: ping  285058 [025] 1219802.466939: probe_libc:inet_pton: (ffffa14b7cf0)
>      Matching: ffffa14b7cf0 __GI___inet_pton+0x0 (/usr/lib/aarch64-linux-gnu/libc-2.31.so)
>    Pattern: .*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$
>      Matching: ping  285058 [025] 1219802.466939: probe_libc:inet_pton: (ffffa14b7cf0)
>      Matching: ffffa14b7cf0 __GI___inet_pton+0x0 (/usr/lib/aarch64-linux-gnu/libc-2.31.so)
>      Matching: ffffa1488040 getaddrinfo+0xe8 (/usr/lib/aarch64-linux-gnu/libc-2.31.so)
>      Matching: aaaab8672da4 [unknown] (/usr/bin/ping)
>    ---- end ----
>     82: probe libc's inet_pton & backtrace it with ping                 : Ok
> 
> Reported-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> Closes: https://lore.kernel.org/linux-perf-users/1728978807-81116-1-git-send-email-renyu.zj@linux.alibaba.com/
> Reported-by: Guilherme Amadio <amadio@gentoo.org>
> Closes: https://lore.kernel.org/linux-perf-users/Z0X3AYUWkAgfPpWj@x1/T/#m57327e135b156047e37d214a0d453af6ae1e02be
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
> Changes from v1: Fixed a typo s/Seatch/Search.
> 
>   .../shell/record+probe_libc_inet_pton.sh      | 34 ++++++++++---------
>   1 file changed, 18 insertions(+), 16 deletions(-)
> 

Reviewed-by: James Clark <james.clark@linaro.org>

> diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> index 47a26f25db9f..3fbc7a7409af 100755
> --- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> +++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> @@ -43,17 +43,8 @@ trace_libc_inet_pton_backtrace() {
>   		echo "((__GI_)?getaddrinfo|text_to_binary_address)\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
>   		echo "(gaih_inet|main)\+0x[[:xdigit:]]+[[:space:]]\(inlined|.*/bin/ping.*\)$" >> $expected
>   		;;
> -	ppc64|ppc64le)
> -		eventattr='max-stack=4'
> -		# Add gaih_inet to expected backtrace only if it is part of libc.
> -		if nm $libc | grep -F -q gaih_inet.; then
> -			echo "gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
> -		fi
> -		echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
> -		echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
> -		;;
>   	*)
> -		eventattr='max-stack=3'
> +		eventattr='max-stack=4'
>   		echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
>   		;;
>   	esac
> @@ -76,14 +67,25 @@ trace_libc_inet_pton_backtrace() {
>   	fi
>   	perf script -i $perf_data | tac | grep -m1 ^ping -B9 | tac > $perf_script
>   
> -	exec 3<$perf_script
>   	exec 4<$expected
> -	while read line <&3 && read -r pattern <&4; do
> +	while read -r pattern <&4; do
> +		echo "Pattern: $pattern"
>   		[ -z "$pattern" ] && break
> -		echo $line
> -		echo "$line" | grep -E -q "$pattern"
> -		if [ $? -ne 0 ] ; then
> -			printf "FAIL: expected backtrace entry \"%s\" got \"%s\"\n" "$pattern" "$line"
> +
> +		found=0
> +
> +		# Search lines in the perf script result
> +		exec 3<$perf_script
> +		while read line <&3; do
> +			[ -z "$line" ] && break
> +			echo "  Matching: $line"
> +			! echo "$line" | grep -E -q "$pattern"
> +			found=$?
> +			[ $found -eq 1 ] && break
> +		done
> +
> +		if [ $found -ne 1 ] ; then
> +			printf "FAIL: Didn't find the expected backtrace entry \"%s\"\n" "$pattern"
>   			return 1
>   		fi
>   	done

