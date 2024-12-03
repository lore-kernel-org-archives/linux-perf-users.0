Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107E42036FD
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Dec 2024 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244230; cv=none; b=cADCSqJy15SRP1vkSw2QsCRN3FLYVEn2JXnoxrpKEgkKczdYR7Xb6AHBGcJoG/V1mmnz385Do3v3YJMRwhGSqeXIVd2aIp1+mXHCYXl5v0EPPQaxkYTHFWiqam9eJofKllLBtlI83kkeUFVinjkoebcV5xAZ+IlZdg5bxqPn3fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244230; c=relaxed/simple;
	bh=L+J2LAH2xdGpEZwR6QJBfnfB05WXMwbkYAQ2hJQlyiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMLSOtjVxm/klqjLhxHGRlcGj03HGFIWvdq0IRJnjywUKU25pbWWDEQo+mwAI8IFX8M3HL79OyaiSihHuADKkszWZbeXNPl9b8F4gDOPjZ9/RzIow6bVPd9gvjeSY6V2boig2dO7whnFuLe/81rNTeyqYw5uyCjSxwi4Ta+mUO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HJmRDA5d; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HJmRDA5d"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53ded167ae3so6256263e87.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Dec 2024 08:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733244226; x=1733849026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nkPiAjAYY+rl831HCza+zQDKH3sh7oPNvT/kEFoX/5Y=;
        b=HJmRDA5dk60P6XMETmThRI8RnLw8Zo/urMbTUqjVLA/OqGMN6bcOKELf5EMmXeuF2D
         U8xtoM2pPvFdUscVdeXnVl9Szf9s6VFyknJWfpuuoYYrfrlPteMU9Rs4TLxOff8cZXY4
         YgjbduwCq3GhLsAXFSj8AwJ8XsNs/ZmjycvfC8wOBvhGycL7q+xuhT3LZFl5YZEmONGx
         8WZybCl6MLKfuOGV/Zs5oNGWsi/DPaNZM0amWH2G6wPx6CBrokELvpLm6NN0srSgb1s4
         aI6KvUtSbR50UPEHyF4GoNfZa/J9fNJzPIvzZam+k/SFcmJAjZIJf82+ro8wRY5LahaE
         8EUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733244226; x=1733849026;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nkPiAjAYY+rl831HCza+zQDKH3sh7oPNvT/kEFoX/5Y=;
        b=mhOkR8ustPYssvhkFvhg1wKFMsCEt8q7daQ+GoNO1pLfhZtYbo4wWrBf5ujUP/NSHG
         mQl9HMBJgZlhVFX7EU4xuxYUe0pCgwiOZNQKpLtYWAOBlwhat6yClmbm/o8Mr6obNPmE
         f813ZQjt07rwA2ZvMlCxReWI1k4ZoAYHMHsr5FXCKsqanyqDEeKGIjdLiPLdrXyup8/C
         q1jy9WaKID09HInQbe4VlDTWrJ8cQHzHF2VM5ertggUP6E2rtGQ+jBLMY/NXt7+3y68p
         QXQl2/yHzzQSS57ks2NHLY6yp+Tr0Sah9GeskXPA708mYxitFen8Rsw3+z+k/GuubGQb
         Ne0g==
X-Forwarded-Encrypted: i=1; AJvYcCVqLi0LqADUZEMl8DDy6Ow8ksJmPipzhJ39aj0yXTF9vfFyjNIvIYm5491aDjn0+kRx3yqXBLJFHlbAFgqbfOfy@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5eqvi6KIwLZUyT1eSnboTKDTfks/yYjAmT/8YmO+EWJ7ttbxP
	k6+Hs0Nfqxw4HcUTzJTtzZ0O9jn6WiTf79ktCd1jfmFS4qqPlM2pzP/lp+Jc6C8=
X-Gm-Gg: ASbGnctqs8WNTq9uShUEvpbKRhzYyHoKloDtxv9/w7DG7a3N7p1usdnMuXyb8ZejRDD
	E9VVSEzmbL2u0tnuWgaW46GUhIIyfckj73/aOqr0ipQy3w6t9Op2cqd0CCbTss4yE3f/tp7MEb0
	ubWlasrLiXFQR4ZkcwQfTSNzc43zCWDbgkruXRHZKnUtBy1LKqmyxBTsBOAwH6HRRn3AB9ZEZ98
	rCq11JxvlMm17dUl+hYdVW4mfQlSY8maBD3Xjl94h8S+Zed8EpOPKl3CsR6
X-Google-Smtp-Source: AGHT+IH2FSS1PjtCeF6YlLSfRzI7x09bN1JRS4N+jhSdGJOM0Zoc9/YCrXoFVktGXAB4Hvw/GHFg3Q==
X-Received: by 2002:a05:6512:3d0d:b0:53e:168a:1b2b with SMTP id 2adb3069b0e04-53e168a1e05mr1724853e87.36.1733244226176;
        Tue, 03 Dec 2024 08:43:46 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa59990a9dfsm632884066b.157.2024.12.03.08.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 08:43:45 -0800 (PST)
Message-ID: <981436ce-2d41-4c3e-b77e-63e4c200cd0e@linaro.org>
Date: Tue, 3 Dec 2024 16:43:44 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] perf tools: Fix build error on
 generated/fs_at_flags_array.c
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
References: <20241203035349.1901262-1-namhyung@kernel.org>
 <20241203035349.1901262-12-namhyung@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241203035349.1901262-12-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 03/12/2024 3:53 am, Namhyung Kim wrote:
> It should only have generic flags in the array but the recent header
> sync brought a new flags to fcntl.h and caused a build error.  Let's
> update the shell script to exclude flags specific to name_to_handle_at().
> 
>      CC      trace/beauty/fs_at_flags.o
>    In file included from trace/beauty/fs_at_flags.c:21:
>    tools/perf/trace/beauty/generated/fs_at_flags_array.c:13:30: error: initialized field overwritten [-Werror=override-init]
>       13 |         [ilog2(0x002) + 1] = "HANDLE_CONNECTABLE",
>          |                              ^~~~~~~~~~~~~~~~~~~~
>    tools/perf/trace/beauty/generated/fs_at_flags_array.c:13:30: note: (near initialization for ‘fs_at_flags[2]’)
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Hi Namhyung,

Is it possible to fix this before the updates to keep it buildable? 
Maybe it's not feasible, I didn't check.

I did notice a build issue in the kvm tests after this update:

$ make O=../build/local/ summary=1 TARGETS=kvm kselftest

In file included from aarch64/aarch32_id_regs.c:14:
include/aarch64/processor.h:15:10: fatal error: asm/brk-imm.h: No such 
file or directory
    15 | #include <asm/brk-imm.h>

But I tried the same on v6.13-rc1 and got a different error, so I don't 
know if it's any worse.

Thanks
James

> ---
>   tools/perf/trace/beauty/fs_at_flags.sh | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/trace/beauty/fs_at_flags.sh b/tools/perf/trace/beauty/fs_at_flags.sh
> index e3f13f96a27c227c..fac4d0c049fcc89f 100755
> --- a/tools/perf/trace/beauty/fs_at_flags.sh
> +++ b/tools/perf/trace/beauty/fs_at_flags.sh
> @@ -13,13 +13,14 @@ printf "static const char *fs_at_flags[] = {\n"
>   regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+AT_([^_]+[[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
>   # AT_EACCESS is only meaningful to faccessat, so we will special case it there...
>   # AT_STATX_SYNC_TYPE is not a bit, its a mask of AT_STATX_SYNC_AS_STAT, AT_STATX_FORCE_SYNC and AT_STATX_DONT_SYNC
> -# AT_HANDLE_FID and AT_HANDLE_MNT_ID_UNIQUE are reusing values and are valid only for name_to_handle_at()
> +# AT_HANDLE_FID, AT_HANDLE_MNT_ID_UNIQUE and AT_HANDLE_CONNECTABLE are reusing values and are valid only for name_to_handle_at()
>   # AT_RENAME_NOREPLACE reuses 0x1 and is valid only for renameat2()
>   grep -E $regex ${linux_fcntl} | \
>   	grep -v AT_EACCESS | \
>   	grep -v AT_STATX_SYNC_TYPE | \
>   	grep -v AT_HANDLE_FID | \
>   	grep -v AT_HANDLE_MNT_ID_UNIQUE | \
> +	grep -v AT_HANDLE_CONNECTABLE | \
>   	grep -v AT_RENAME_NOREPLACE | \
>   	sed -r "s/$regex/\2 \1/g"	| \
>   	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n"

