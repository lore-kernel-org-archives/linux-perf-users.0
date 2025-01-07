Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47EE1537C3
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jan 2025 14:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261389; cv=none; b=oNzohbg1QFiu5dPrHrHVvjiRBF5sx9KTFyLl0xS40LAQao/gg40RMvS9jioPZARyLUTS2jU45WNXqYHidu+PfQqUm271ny+L2f1oB+rVpxLLnsbc3aCSDNIFHVOBiZ8AUDxfsUxzwrgT39hJuw03ijK9c4WuhohOpzisPCBcLlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261389; c=relaxed/simple;
	bh=QEG4Lt3mn+Wq0xsRQRMvQJKA2t4dMpLwC9XZ0QsUKgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d1V4hdKPqaoki1+Q6gxEQhwXBL2LUoz/61eX3RYMNTYIKjD7KU93v33sUzXfN4v+007Feg8WKbStz1mPmsXKylq5ORtbC7OPwe4tr/sdN6qIqfLZH8v1/jMEi/XvKjJdCRuN+jRNxU2/BQBa89rxgCsbzGgAlsMG7LI728lr1r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AoktLoBd; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AoktLoBd"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-436a03197b2so59539225e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Jan 2025 06:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736261382; x=1736866182; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K3u/NmEcbizgpdqDtJODTjPeBG7JBU/0LlN4PU1so0U=;
        b=AoktLoBdRxn2k2l8cQA27v1UUvDErCQDRqwswWyInVEC0rj04Rd4USJqq+fBK6ey4U
         NBDZbOM6rSx0N7iYoYHxHaiGOI1lI0fSWMsMTiml8e8v7UmD9dTrRwJ3yPWzhcSC+sDW
         LX8+hzuX6PKTpWgSgGOpGbJen6DsjXLHG1IW1+SyMywhrkREy0ZWXFDQNSKq+iw6hUt6
         oQWuNjNpgZDrB35o5IhuE5EB12Lu9vriRhjYbQK9xkXg4+5ccRqMNAovgD7uaYwxRNIU
         3X3kLxHYfu6hxo/gIIKHOr7zw1gK1bTJE2vY6XrAy4MpvYLfPrvJHp3RteE0icgrS5Ij
         batA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736261382; x=1736866182;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K3u/NmEcbizgpdqDtJODTjPeBG7JBU/0LlN4PU1so0U=;
        b=EpcrVaENxgaOoWO8+CQBgBxjyJEWgcMICBOT5evD+v9x1UJNVIdmb5S1dD77TeM5qM
         nh63+TV9z94ZJm1OeGR5WJxz/5Wz5v7Sc8X46I1TRdzwcH0dZ70+j+Fd9NKO9hQ4ZIo2
         8IpiZ+S/ooyjrTfxiK2B+aVfB+flD3TosMz//tep8Alb5WtN3BTe6MFUvD/NyBCr/iou
         dTvvAJtgDUTIBDBiKDyxBFKFftlQ1rzqGZU7xw0aRmEFopoYfCWo0Lt8/VD48+b+Gjw0
         PIpXdMkMuzv71/l9PnYwLhnSnJIV6Hf+CuHapb62VzJETmgVoXgZ+1yqxzdz4T9vr1vo
         S1jw==
X-Forwarded-Encrypted: i=1; AJvYcCXjaE3iQrjg6pKOtR5srV6/9LAV1cf4OZ1c0AdboaJlg36LGI850hjYAsUf257f3vsRVY6ONOqoqYUlse2nwwlN@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+meo1BW1Dds1DX1nx97BTOG92dJ2DPL7tCLb3tQRruonSSrYG
	v2F00Clf1Tcaag4W+4FLde4FyDINnfI8dMJxd7cEJDCvKFpeNjUudFxT3Tn8wmYELqUvV6f3NIs
	1
X-Gm-Gg: ASbGncuyjkB0JSxzztK9AMgYxv97RbaiNIwwaRv2pK+up5qWHY5CMlUUByGcCZCjB/m
	8EMnewKMpYWlcVXi/jQM3IVZDafZTzD2jLiTvYYsU0Z7grJvRJmqcUajeLnvmvTRlywQVjBiSQM
	RWFBzlpV2JI/Ovk/GJO6mswE4Ye2mt1cXv8rwgoDKthxS+NrSxheA3u3E04b0jtDkCupmzSwrIQ
	rDRGMG6eSAGsizho7EQY/nPUHVh7/PptLcdL39EsUF/bJdKNe1Isrnxuo2XEKL49zw=
X-Google-Smtp-Source: AGHT+IFGvFPkSlYeeurN8gZ+h8Ez+4npmK5Z8xyVNs2V2PckDfXpluAxmlP4Ufddd+X9OkHCgV4ZkA==
X-Received: by 2002:a05:600c:3b24:b0:436:2923:d23a with SMTP id 5b1f17b1804b1-43668b7a683mr422892985e9.33.1736261382081;
        Tue, 07 Jan 2025 06:49:42 -0800 (PST)
Received: from [192.168.68.163] ([145.224.66.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436dd11d8b4sm15046065e9.1.2025.01.07.06.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 06:49:41 -0800 (PST)
Message-ID: <f0828c16-8892-47c6-91ea-954101ed7dda@linaro.org>
Date: Tue, 7 Jan 2025 14:49:40 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] perf test: Update ftrace test to use --graph-opts
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Thomas Richter <tmricht@linux.ibm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Kan Liang <kan.liang@linux.intel.com>
References: <20250103231630.928815-1-namhyung@kernel.org>
 <20250103231630.928815-3-namhyung@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250103231630.928815-3-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/01/2025 11:16 pm, Namhyung Kim wrote:
> I found it failed on machines with limited memory because 16M byte
> per-cpu buffer is too big.  The reason it added the option is not to
> miss tracing data.  Thus we can limit the data size by reducing the
> function call depth instead of increasing the buffer size to handle the
> whole data.
> 
> As it used the same option in the test_ftrace_trace() and it was able
> to find the sleep function, it should work with the profile subcommand.
> 
> Get rid of other grep commands which might be affected by the depth
> change.
> 
> Cc: Thomas Richter <tmricht@linux.ibm.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>   tools/perf/tests/shell/ftrace.sh | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 

Reviewed-by: James Clark <james.clark@linaro.org>

> diff --git a/tools/perf/tests/shell/ftrace.sh b/tools/perf/tests/shell/ftrace.sh
> index 2df05052c324a21c..c243731d2fbf67aa 100755
> --- a/tools/perf/tests/shell/ftrace.sh
> +++ b/tools/perf/tests/shell/ftrace.sh
> @@ -67,11 +67,8 @@ test_ftrace_latency() {
>   
>   test_ftrace_profile() {
>       echo "perf ftrace profile test"
> -    perf ftrace profile -m 16M sleep 0.1 > "${output}"
> +    perf ftrace profile --graph-opts depth=5 sleep 0.1 > "${output}"
>       grep ^# "${output}"
> -    grep sleep "${output}"
> -    grep schedule "${output}"
> -    grep execve "${output}"
>       time_re="[[:space:]]+1[[:digit:]]{5}\.[[:digit:]]{3}"
>       # 100283.000 100283.000 100283.000          1   __x64_sys_clock_nanosleep
>       # Check for one *clock_nanosleep line with a Count of just 1 that takes a bit more than 0.1 seconds

