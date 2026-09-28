Received: from mail-ed2-f33.google.com (mail-ed2-f33.google.com [74.125.228.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C129848E0ED
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 09:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586798; cv=none; b=bo46QCTDqBl416mTdWlDKDdXJIP/LdvpO0oC51irJLEMAzJrMdw+Y8BqFs0gsR91yWQoNzCCFrOwumKRbYLURJavC0QU6shqtcDCSBNbsBgDtwX/Aa7xiPWhEnfD1zeqxJQ3tqQd5e6FFpC6enYSzk95YiSN3yf4/gigE538dDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586798; c=relaxed/simple;
	bh=NGlPMXq2fpdcn6udWgt1oJexI34OVAzc82/X+lQc8BQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=IyLb+Wow8GK0k6DIklGHMVRXQOucAE0SVZOH4EhDGoJAX1/YDqdmK3yl9m2NpFsdRj8LrwUuUJgids/qnJG3qmC3D4Y4A9cAKClLWCXCGTuZc6lvGhdEHxTcnkcrFJXSjJG4KKGRekzOuyFmtqqZsiv7yzewZWKIh0ufMnyhvdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VEVPhgcK; arc=none smtp.client-ip=74.125.228.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VEVPhgcK"
Received: by mail-ed2-f33.google.com with SMTP id 4fb4d7f45d1cf-6ac6f5c507fso1219574a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 02:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790586795; x=1791191595; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zrUZW93Kpo3duA4VkIX/sYF08Cc0xHufuLcywAkXwOQ=;
        b=VEVPhgcKv6bpkh1vyZZEPdhRUsJktISv3aArYLdChcgdbZE9D0kPV/3EucxndTfrDX
         umEdVsfu/L5yy83FC4GKchrXoQBAhbZti5idmFg8FHCAw3il+fFPIuQ15E0vKm7/DvZF
         /aHX3sPY114e62Wifp0tL7CQmxc8aOyKDw+MUq5TmIb6e5OJyH0VvQIxgEaXvlmDSMZ3
         PVAbvztFssgymA0thp887SkTGFL07CQ9SWUSDZ0bByC18nm9WA0lv+Kve/+TV6nX6d1V
         /EjRz2A8TfTT7q8fxKCzICgGnlEvmCz+OAJ9LmMKrg4PhzPg8XMQ/7Z6hGTCQVoeVXxS
         h6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790586795; x=1791191595;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zrUZW93Kpo3duA4VkIX/sYF08Cc0xHufuLcywAkXwOQ=;
        b=jYEWtWqFvEUhJPXjwfo9nKyN2DgCDcv7CIuPNA/zNUSk4HhWnYT+8INISnhXg0pfCp
         YYLUmi0VFX91ZHtYT2xHpJXFQXJCI2y7YIffyUjfyYvYark2faUuF3Xs3rezEbNssHq/
         x78+nmsBRD5vn/1ab/mNOlLrNqGJA4tYC6Hfzcq8p5mxNCbkWgxfjA68BlcZUjcinMpA
         EQEJw/VfMetc13QO6L4sTWGXZB8qQ9ucUI9ZJrO5PAKD6Pf1aT+Z0xrroqx0rGF3K9Kk
         ihbIp0DbvSJR+pyqB8qay0srqBokP6qq4g5ldCgRClBhBDu+XTBSoTTzhJa/DEsZ9pza
         TZ/g==
X-Forwarded-Encrypted: i=1; AKwUvBypIUYvmDqNvIDEEUccrL0ib/YQSPCMlcpdp8k9ydfwrfM31G1fW44TpCaPLv225eWy2q5ekIZdnRaIET/0m4TC@vger.kernel.org
X-Gm-Message-State: AFq9FYK1BldfC/8Dj07Imli4aNLMw5gEyd1RnPI3UoO5Jd81B4U7f0F7
	NYzszyizI6e2jj5c1+OdwJpuyT9zJzx8W1FMbnn2ZslJAgRk9tU6QQGaC4QGC37clnc=
X-Gm-Gg: AYBFou30BT4uDqYVi3eWJoUBJ6VgIJMm6XhGctlCcXm2mTAtVlA9qb/x2BVnjHO0/xU
	FhklBhvGpOdNYi0HYWXFf0Lrui3w3VxgOM8/lHKcp3/O6LpOPNQ7lYNzrhi8JUoiBo8AobyFaEa
	AKt/H4ASaVcNmWDgXsAktcJtavC8zQpr5Qv8zg8PwWI1HVP9+R3HMaCLw4HfjHujrKF7WuZGtT/
	FUaBT2HkAMgqbd8/yULggxnBn0hnzgSoElRxdB3rFTtH779txel/YsuBHz8CasrNYZZwQnCZfXa
	wf5cWM0MQOsEvW6xqt6bEsQSZUXm75Tj9m6utU2wN30Mre6Hk0RN1xYQxCozQAK7JXa5aRIIpKP
	MDA2izaFrhuWR3BuLR/74FqawVm1/szrsJTysRv0C3pQcwRw1KjOAJ4zv+dsTRSFgpGJFrjFXca
	kfQl/91LyYnYv7qCksKQ5Wa1CVqa7q3wK7JunAj7/gruulSt1hELSXC30XYp7SVQphGLDQpPAia
	4gS
X-Received: by 2002:a05:6402:2552:b0:6aa:f809:ef41 with SMTP id 4fb4d7f45d1cf-6aaf809f225mr5554167a12.3.1790586794617;
        Mon, 28 Sep 2026 02:13:14 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aae5dc0cddsm3868145a12.14.2026.09.28.02.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 02:13:13 -0700 (PDT)
Message-ID: <efd21aac-4faf-46bc-b1ef-7791e7458cf0@linaro.org>
Date: Mon, 28 Sep 2026 10:13:11 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf test: Record kcore for the CoreSight callchain test
To: Leo Yan <leo.yan@arm.com>
References: <20260928090644.24346-1-leo.yan@arm.com>
Content-Language: en-US
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260928090644.24346-1-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/09/2026 10:06, Leo Yan wrote:
> The CoreSight callchain test traces both userspace and kernel execution
> and checks the callchain across a syscall.
> 
> Add --kcore to perf record to save the running kernel image alongside
> the trace data so perf script can use it to decode the kernel trace.
> 
> Add a Fixes tag so the change can be backported to stable kernels and
> improve the test reliability.
> 
> Fixes: ca0e19074bd6 ("perf test: Add Arm CoreSight callchain test")
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/tests/shell/coresight/callchain.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/coresight/callchain.sh b/tools/perf/tests/shell/coresight/callchain.sh
> index 13cca7dc1118..b69187f1a37f 100755
> --- a/tools/perf/tests/shell/coresight/callchain.sh
> +++ b/tools/perf/tests/shell/coresight/callchain.sh
> @@ -43,7 +43,7 @@ record_trace()
>   
>   	mkfifo "$cf" "$af"
>   
> -	perf record -o "$data" -e cs_etm// --per-thread -D -1 --control fifo:"$cf","$af" -- \
> +	perf record --kcore -o "$data" -e cs_etm// --per-thread -D -1 --control fifo:"$cf","$af" -- \
>   		perf test --record-ctl fifo:"$cf","$af" -w callchain >/dev/null 2>&1 &&
>   
>   	# It is safe to use 'i3i' with a three-instruction interval, since the

Reviewed-by: James Clark <james.clark@linaro.org>
