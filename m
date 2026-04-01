Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045453F7898
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 10:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775040943; cv=none; b=bq2RXGo8hKksoQCYZJbyzmXWhGJZP7MpM2HtLpuVqpqYfbQG2KNiOMkpRPZ4FmE8Hw9qic9coEFCUxlnL4APfNQ4FsCOT2L1fzUUt7cZ4Nd5VWMaEXaIpUV+VaZ8upb/KWDLjEchn36VyYTP/bXcwN+jNHVHZakXt2Ai+HyU3No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775040943; c=relaxed/simple;
	bh=4zs9v//J3FtMcHGsNl+stI0CMj0a74VFNWBWUpscOBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cISZiowhLM4V227h/ECy+vUIJIh15003+r1NOoFOIVKf50eWEKPX9Cp5gZumsP6UXAGwYEl7gjJGQO+vCGhzYAUNoM9zhrLWZG+IKAEFtZoFZs4k3de0Wnee3tIwBC8oDN5h2q6xSqMe77SfuoMrHqdSW1uHsS9mlfD3FBGXUwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=njqsAVBw; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="njqsAVBw"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-482f454be5bso8379035e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 03:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775040934; x=1775645734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5xTlYT2mRCzPWbMvzG6Gw7RgwMimcucQpAzoCrNsxy0=;
        b=njqsAVBwyRs4PcRbFj7gc3+omI0QfVWJmP6Jsr3QsJTAd3BLkBWQe9wCVPFbTomrfZ
         G5keeQTSXcCZAccS+rBOCnv1JWVG2+ccPmbPwd+zwiS84Y7cifsOwiQkK1h8qgyaqTzP
         5NTUGKDxBcg2lWDnecXSii5M1bjiyfvvlUStFCSxKO4GK5Slzg2NdT2L7JYWdXa73PON
         51hCw+uyY/5jVOzmIOCmrpEWBBJktfxDPi9HHJ+PfDZ5MWf2F4Fmlp5IoQ5cxVYAyfax
         2+TCRhHCZKTMIgkH/V1w0QWk8wGK29GjyxRsVDI7fKoYXCod5TO7YRUWs7/DfNBOm7ZA
         CpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775040934; x=1775645734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xTlYT2mRCzPWbMvzG6Gw7RgwMimcucQpAzoCrNsxy0=;
        b=UcqXeRpFKEpISSdzC4CmUj2nQvnwBAdvhxANs/wC9BNUx8HJCdaUU28OKghc460b9y
         IsN0DIL7SG3X3hzdmSncSzQQlmtLJ5W9xH9055vegDQK28uoSVapWyG5yomZRbPg24fN
         xbsxnz3jF6lXPstrYAaoFNi3OE9cSGoUKpvyeLfqc5s8bviuDBSBRgf8L+pdpgUzq4Ip
         eeFZy32M56p3yonUEKFZ5RKGuTqLBNI1DJN4qFRYmdIUDNvWJXm+7JDFPHaVUYA6sOks
         TQg85eFKGwTznqI1778VpH3ormlGVeejitb7hIs0qD49WxsHjhndd2KDjlfRJmg87Uen
         8gzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdtrJmbaDvP2XzSuyxQgQDLrXUTMSqhgD5ug6DkEU/pcKCIWztP5UGxup5RiltE6iYXne4u5BwIp0oktOVqyJI@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ/phYPqqp8Wb7Nhp8AtfbXNUM9g90Ui30yETEoC6iIaEejQjF
	R6KJFYEDeQvMVmjqTr++JecvKqjF63Zi11Y6VboxmxL8wyopNe+bgCJ82LmLn0ihLn4=
X-Gm-Gg: ATEYQzz+vuB63dTQ5InlGa9h+r/eY/+3EBvM8VEBqoQ2LcArJ377Tr0IQTfYqyzu95f
	ymS2Mn9NvFFwnWoW43ZcVOio/GAZMLF/7ys7ibr/kZdE6wUMU8yfF/icU/8+p08uemfYkVpDuyu
	UOHl68C+S8u7kLQpYu9M1KZEyJ08RgaErI7I4kcE0gAJoVgjOTOwNBgz2ZAIChGyGoZ7B6PPU18
	ZzC3WJFC+m6lwVxeBENmt6XretT/8COBxZ4KyjVTHmxUoWOuVJ+addJs6GEppHr0kkcokFLiQ3P
	W5EevY93Ys+GJgSW0Cj2TR1Qt1/hlR639QVLOn6AFqHTSKAU3GaTYlEeMe+23WRmU1dKMX48CZK
	L+uepBDuE/GFp6Fo8X7fbHCclMi2E2Vq9YI5pX6NZus6d7OvSIukg1PA0FBDLNCCko7PVq333Ij
	2oMV2D2TiIGobuWamJ69GqBmv5495dC0Kt1bwcFcw=
X-Received: by 2002:a05:600c:3e1a:b0:486:fbc4:8fe2 with SMTP id 5b1f17b1804b1-488835d166amr47030845e9.15.1775040933566;
        Wed, 01 Apr 2026 03:55:33 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e7e9786sm102087935e9.3.2026.04.01.03.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 03:55:32 -0700 (PDT)
Message-ID: <bf734b00-fb08-45b3-9201-92c11ad1fb6c@linaro.org>
Date: Wed, 1 Apr 2026 11:55:30 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] perf: Fix SIGCHLD vs pause() race with short-lived
 workloads
To: Swapnil Sapkal <swapnil.sapkal@amd.com>
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
 jolsa@kernel.org, adrian.hunter@intel.com, gautham.shenoy@amd.com,
 ravi.bangoria@amd.com, KPrateek.Nayak@amd.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, irogers@google.com
References: <20260401064114.141066-1-swapnil.sapkal@amd.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260401064114.141066-1-swapnil.sapkal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/04/2026 7:41 am, Swapnil Sapkal wrote:
> Some perf subcommands (sched stats, lock contention) use the pattern
> of forking a workload child, calling evlist__start_workload() to uncork
> it, and then calling pause() to wait for a signal (typically SIGCHLD
> when the child exits, or SIGINT/SIGTERM from the user).
> 
> This pattern has a race condition: if the workload is very short-lived,
> the child can exit and deliver SIGCHLD in the window between
> evlist__start_workload() and pause(). Since pause() only returns when a
> signal is received *while the process is suspended*, and SIGCHLD has
> already been delivered and handled by the empty sighandler(), pause()
> blocks indefinitely.
> 
> The fix uses the standard POSIX pattern for this class of bug:
> 
> 1. Block SIGCHLD (via sigprocmask) before starting the workload.
>     If the child exits, the signal remains pending rather than being
>     delivered and lost.
> 
> 2. Replace pause() with sigsuspend(&oldmask), which atomically
>     unblocks SIGCHLD and suspends the process. There is no window
>     where the signal can slip through unnoticed.
> 
> 3. Restore the original signal mask after sigsuspend() returns.
> 
> SIGINT and SIGTERM are not blocked at any point, so Ctrl+C and
> graceful termination continue to work exactly as before.
> 
> Three call sites are affected across two files:
>    - perf_sched__schedstat_record() in builtin-sched.c
>    - perf_sched__schedstat_live()   in builtin-sched.c
>    - __cmd_contention()             in builtin-lock.c
> 
> The two pause() sites in builtin-kwork.c are NOT affected because they
> do not register SIGCHLD or fork workload children; they only wait for
> user-initiated SIGINT/SIGTERM.
> 
> Swapnil Sapkal (3):
>    perf sched stats: Fix SIGCHLD race in schedstat_record()
>    perf sched stats: Fix SIGCHLD race in schedstat_live()
>    perf lock contention: Fix SIGCHLD race in __cmd_contention()
> 
>   tools/perf/builtin-lock.c  | 20 ++++++++++++++++++--
>   tools/perf/builtin-sched.c | 30 ++++++++++++++++++++++++++----
>   2 files changed, 44 insertions(+), 6 deletions(-)
> 

Reviewed-by: James Clark <james.clark@linaro.org>

