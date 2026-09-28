Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E9248BD5B
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588481; cv=none; b=NJxMfJr021zaRgnnYBJkMMndSPdHDt6IPOYr/XP47Jnz8IpXABH/PeOabwqvo0tqoLKe8kD6ZkiyC3JT4T57HYuYOvmHWRUHboKJuiSNqmRuvVTXvXbE5uWPhm0G7tcy9cMHyi4Qm1fJ7OuoTFrQ7hSzdT33zf5a3HBHiHr+5jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588481; c=relaxed/simple;
	bh=DD+2DnZkFVPUq7yp49diyNCHzHYKY7VBDFME87IaNDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XRoNPg9FCmrWNwUMyETqq6eSLVwvmfOQ5+shWAAOOZjpYhOPUYh4lBw9oQJm7xytiaE1gzcZMCTBPAl/7R56GPlve1syfJSBJIatfKOpj6oJj+G4/mlxyHA/gEbOV6HDLcJ17Gl0803KC7WEu0IYRKtVFPvc0e8KKFA9Rih+iNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DY9Wm9Cv; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DY9Wm9Cv"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29703cb470so426738166b.0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 02:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790588478; x=1791193278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ge0jtZOtdWzZExU51tpnSwFUmBlplbOktdbQBWDiyyQ=;
        b=DY9Wm9Cvls3y7xidAq37SjJuE5BWNbjslTIqEXZ0Dhs295xu64B5YCV+GU4HgnhEgA
         zM1QA92Gqex5IDHfU9Bjz1yJToI1qaUW3I3EARnO7fCMJG5WDJZmLsw8TBgyfGs8E3ku
         WLHcKFSD1vb8wP+fZVDJ7X3aSLFYVYmziruXcSvlQgP6aDOZTiVLXoiYaJBhmed0Xatj
         j820Nzy6VG7FA9j8CQvABhTQKlGzsN/hqPWFf09FoV8YoR14rtyQVE7D0mhKUWg8ap+b
         RZwKFsOPFjmL4n5CNT78jDjL/BFbdpdzjt9a1RSVolAr2UWp4t5dI8BSD9WJxZrDiwR4
         wuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790588478; x=1791193278;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ge0jtZOtdWzZExU51tpnSwFUmBlplbOktdbQBWDiyyQ=;
        b=2bMDcFxddF+HsR6J/m0dd8KjkgUDNZb4hmOOlNEg0u+GdDdKNLCBVhPSwa/xfubmdr
         xl5plUm8IrZg2vlNm8k5TSEVs6L1peMaVlEtjmoYnudKyAE5rbCabK0gIEfW+4qO7bX8
         9athOFAoDELBFmdFNj7Q+yJQd8erETn1EQlFX7NFQ1NdNAxnscq8nkyNs8wslGKD+0ai
         pLoxjXoU31wQfsl05C4aDFNjJtZkS6U+g27yiI4Fo427pgxOG57iU1SF6r41LVpmMOsR
         gIJ7E6JjveYlbBDOC+AqMpgL7wWxx/WhT2V4saAmjyCdXupdp9dzqdOUatpq/Lwvnrq6
         HPrg==
X-Gm-Message-State: AFuF++nL+kNBwXns0kGt7oYnEX1loR3xnpTvpozcwgLz0Rjqfl3jFb//
	CJXSWINOvOsmHKrU52UrWgm4EEa12dOh/XkcagFxtTHiVF24oyZDlaWhmML2zpmrxp8dDMxPUMo
	wtgiAMkY=
X-Gm-Gg: AYBFou2rkkDgRAZeWSJw1Jx4V2I43RAk2dPC0l8isgAncY2iH2vIa8CnXtJrJDhTKq4
	20ym7f4+jpRNQIe/Ys/CopD+jCNtZR92y2EHnn+VjwMASqUIzF+VpRWCi6PS3imMCS52/rniAi9
	Y+hPdrIebwbDXgWrPGG+DKildX94T3ROnErDZSsfr7STV/lxRXTUQSkSbQwXxqWnsxBxqQ66kok
	zGpHk1FTyS6vW2+S0GYs6nC1+RFf09Y78aLjJdUhc6Im3VHkazpO1m2SAwr5oUTfV58Q0bYQxk0
	M3fjdvc9Mo+SSSjGf0W6Sp02WeiitMCriuHuQnPAL1JnrSLxCP+c+McfITkLYUasab14v0J7yCL
	kzd1vOtMISh1Kb8ULZLyN6UPsQ1fqJ/a7tk4Vq4RfzFmGxZ4w7a2RCWYJfj8Lne3gkOtTnPpAwX
	iXkPqGjmP0unTgRS9uJfNFyrQ69GMOOCKY1t2BJdwmlYmS2gYsBX6MJorwvOOLR7h+iCRJU4IR4
	L0=
X-Received: by 2002:a17:906:6a04:b0:c2d:d89d:346a with SMTP id a640c23a62f3a-c2dd89d497amr199434166b.3.1790588478209;
        Mon, 28 Sep 2026 02:41:18 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2af3128c48sm370662566b.3.2026.09.28.02.41.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 02:41:17 -0700 (PDT)
Message-ID: <0e6c26a9-854f-42d8-9224-6e23937ad3f1@linaro.org>
Date: Mon, 28 Sep 2026 10:41:16 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] perf: Suppress redundant ITRACE start records for Arm
 SPE and CoreSight
To: Leo Yan <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Adrian Hunter
 <adrian.hunter@intel.com>, Mike Leach <mike.leach@arm.com>,
 Tamas Petz <tamas.petz@arm.com>, Tamas Zsoldos <tamas.zsoldos@arm.com>
References: <20260901-perf_suppress_itrace_start_records-v1-0-c4fbc6860859@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260901-perf_suppress_itrace_start_records-v1-0-c4fbc6860859@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/09/2026 17:36, Leo Yan wrote:
> Thanks to Tamas Petz for noticing that Arm CoreSight perf data can contain
> many PERF_RECORD_ITRACE_START records.
> 
> PERF_RECORD_ITRACE_START provides the decoder with the initial thread
> context when that information is absent from the trace stream. Once
> tracing has started, Arm SPE and CoreSight decoders track subsequent
> context changes using context packets or recorded sched_switch events.
> 
> Have both drivers call perf_event_itrace_started() after successfully
> starting event. This prevents perf core from emitting redundant
> PERF_RECORD_ITRACE_START records when an event is scheduled in again.
> 
> Since the Arm SPE and CoreSight drivers can be built as modules, export
> perf_event_itrace_started() before using it in those drivers.
> 
> This series was verified with Arm CoreSight using the commands below.
> The perf data contains 100 sched_switch events but only one
> PERF_RECORD_ITRACE_START record:
> 
>    taskset -c 2 perf record -e cs_etm//u -e sched:sched_switch -- \
> 	  taskset -c 2 bash -c 'while true; do sleep 0.01; done'
>    ^C
> 
>    perf script -D 2>&1 | grep -c sched_switch
>    100
> 
>    perf script -D 2>&1 | grep -c PERF_RECORD_ITRACE_START
>    1
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
> Leo Yan (3):
>        perf/core: Export perf_event_itrace_started()
>        perf: arm_spe: Suppress redundant ITRACE start records
>        coresight: perf: Suppress ITRACE start records
> 
>   drivers/hwtracing/coresight/coresight-etm-perf.c | 2 ++
>   drivers/perf/arm_spe_pmu.c                       | 2 ++
>   kernel/events/core.c                             | 1 +
>   3 files changed, 5 insertions(+)
> ---
> base-commit: 786262be6048deab760f68c8acc2c85607165894
> change-id: 20260901-perf_suppress_itrace_start_records-42faf45e9ce9
> 
> Best regards,

Reviewed-by: James Clark <james.clark@linaro.org>

