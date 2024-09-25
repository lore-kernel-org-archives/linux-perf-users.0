Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A886F2F2
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Sep 2024 09:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727258077; cv=none; b=m0pfTG2DpgwqcKuOvwOl4o9bVKNSuDz9AWo/XsaGyqM0DrCe7xXc6SCgkiv2VolgQjUFg2aa9dv/bCJfrp5O/Gkvk6giCoePnceps0CBZlTqsp39Md9liCSfOSzUuuJxqnXB5dYRMsylM5Ti1mt4OBBM0SszG5Uh3Mr/EnoP6CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727258077; c=relaxed/simple;
	bh=lO5nvWA3IV0Iv8VVBnsGuJGmzlaMsvskh9lAUV9JJqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/A/vLXG4GjfdQguzIP8kwCHtRFYQ26Dp8oIIONc7Y3wCDHGU7C5nEwwnLQEHcciAuEDVWc+LycL99S6tUphwVcnHaq3W5R6hHYj7VRgRhMTzqpWw8V0yvfZ3YJZ9Zlb5YwIVE2c5erkAtKpTPg1PeIwqwAcqVXlt2WLKt9xgPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XPqx4QiU; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XPqx4QiU"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7aa086b077so830999566b.0
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Sep 2024 02:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727258073; x=1727862873; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+c3kM0IzFVsVh0k7OsrfG/XVq2zxRFxQYpJLz6JaIes=;
        b=XPqx4QiUNoGqBzBlN639xgovgk0oBHDpWFd0fW1Kz7/mkpBWgUZkEmFDtBWbcATFws
         H5YSZKp0TbAmfHhFo6YwQgtKQ99Pi+94KEvnahK5llOsClraxza5xFZehXa8b1zt2o/0
         apgOjTOVkY100F/bAcVDJJMYV4ieGEVL0ybkG3n70IiCU09hIVLuJTgbkRvh6nOpFpvU
         lZM3WHFiapz01ecAu0I8E1QnFJx7VNABNbcNYoI94+YjaYtvGpyuOVGTxMjM/AFAwVl/
         0xS8p+wwVQ858l6cswcF6Yj0f+ssFMdCmMCG/vFcCuEc0Pbig0RLYRhPFH4vZzIVl9VT
         v00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727258073; x=1727862873;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+c3kM0IzFVsVh0k7OsrfG/XVq2zxRFxQYpJLz6JaIes=;
        b=qDxDjfTfG7UHKKWtkar8off4Psaeqe8nQ0EJKypu6UehTFKuVl2o3UzpY7EfkcCjII
         z8Cvj4buzVUT8o4u+6uHyLbhJz84j6ANnkqKiyW1FGWkWxV2KmhlKf3o5TGyPMRy7uIS
         uHSgTixTsDymtt5eg7BZy4OltmMCsMfEy4cRpAWpav9m3xI3SRgK9m1idty4gJKL9sP0
         FFdJhYuqwoe4c/E0nfmVbzhyfn4VDnqQtaSOsdr0o2zYjDZ5Y8Fd2mTYZTnlUX9hAbiU
         rNvfaPUj0pbjY8pnn/Cli28svz5BGPdLbOw27LjrCzG+EaRZdgFDkh9eqn3mF1jS5VVA
         Jfnw==
X-Forwarded-Encrypted: i=1; AJvYcCX4RWxieyreZr6ScgrUNe+wkpWmVOfPhSCnCb+frpseg4gqSVGPsEjHOfZ9LGinfNA4vJQmfzfWvAzOv56TuKON@vger.kernel.org
X-Gm-Message-State: AOJu0YyZlNkY2erD+GqNG3WCgiNiDQLDsAHUfP4cbl2jAKwykLf4QiQ6
	WJuD0iHgayiZi6w1YHUjPqfPt6jm2WWOjI2A2hlyJI9peeUFc2DRsnfIHGCevQQ=
X-Google-Smtp-Source: AGHT+IEpyaV+gaoylh/xL1CQdQ+o/9Q+Ttvzern9IGMVbjV8Si52qsVKFPQlQJ9rNm3XCOoM9X+n0g==
X-Received: by 2002:a17:907:9444:b0:a8d:29b7:ecf3 with SMTP id a640c23a62f3a-a93a0325da2mr238677666b.13.1727258073446;
        Wed, 25 Sep 2024 02:54:33 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930cad8dsm190396466b.101.2024.09.25.02.54.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 02:54:32 -0700 (PDT)
Message-ID: <5160d57a-3520-4d99-ae10-5cc539fba813@linaro.org>
Date: Wed, 25 Sep 2024 10:54:31 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: cs-etm: Fix the assert() to handle captured and
 unprocessed cpu trace
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>
References: <20240924233930.5193-1-ilkka@os.amperecomputing.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240924233930.5193-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25/09/2024 12:39 am, Ilkka Koskinen wrote:
> If one builds perf with DEBUG=1, captures data on multiple CPUs and
> finally runs 'perf report -C <cpu>' for only one of the cpus, assert()
> aborts the program. This happens because there are empty queues with
> format set. This patch changes the condition to abort only if a queue
> is not empty and if the format is unset.
> 
>    $ make -C tools/perf DEBUG=1 CORESIGHT=1 CSLIBS=/usr/lib CSINCLUDES=/usr/include install
>    $ perf record -o kcore --kcore -e cs_etm/timestamp/k -s -C 0-1 dd if=/dev/zero of=/dev/null bs=1M count=1
>    $ perf report --input kcore/data --vmlinux=/home/ikoskine/projects/linux/vmlinux -C 1
>    Aborted (core dumped)
> 
> Fixes: 57880a7966be ("perf: cs-etm: Allocate queues for all CPUs")
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>   tools/perf/util/cs-etm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 90f32f327b9b..40f047baef81 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -3323,7 +3323,7 @@ static int cs_etm__create_decoders(struct cs_etm_auxtrace *etm)
>   		 * Don't create decoders for empty queues, mainly because
>   		 * etmq->format is unknown for empty queues.
>   		 */
> -		assert(empty == (etmq->format == UNSET));
> +		assert(empty || etmq->format != UNSET);
>   		if (empty)
>   			continue;
>   

Oops I didn't realize you could filter on CPU in report mode. Thanks for 
the fix. Adding a test to the end of test_arm_coresight.sh might be 
quite useful. Either way:

Reviewed-by: James Clark <james.clark@linaro.org>

