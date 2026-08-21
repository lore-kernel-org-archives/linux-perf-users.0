Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F79F442105
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 10:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306497; cv=none; b=IJF2c7rWd/ON/1h14wqYwiP1bxpENNp/EajJheASJy/xuUZr+jEzHc970YmkV7NwpkPVmlzXzDW9mFBKT0pzC0lKFNl0D8mXranZsJTAIZOqKITqOz82/zDEgm2W5lfB/Lgyt7aLcDcep57B/PSy3HOVbsufGx4vNG6VJwrl2ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306497; c=relaxed/simple;
	bh=Z5a1DNbXGUAZxi2pCeV3KClyGRhdcC5JL8VPz64/HAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YluF9NRtqQ5RY13AC0YFy1/ciDTzFXl0ARg+2YnPFnQSJe0cuoW27yXQilFgDdsOPJE8yj88Q+aTmD/ZMSEnx0qmYITq3QVe7fExoX/hFZrWC3ut+Bi4+WDs+EE/l6rzBk0V70NxLkUBwGOvWD1eWuTtNS3/cvvwlDo+fVXJO5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y9oHLwRh; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y9oHLwRh"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so840636f8f.1
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 03:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787306489; x=1787911289; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=irmyV/0eSa9w7db6iLa2bBa2VlGeL5F1eUiaUcSYjjA=;
        b=y9oHLwRhcSDmkd05WLNASPHa8SgAGDsSWa+K7+bEdOcvDb9Z/156aJY/dKebVhXPE/
         M0HyjPKz/2qBm3VbhoIecgi/3sxiCtPCV9ukjDXhDxSDQltz7EY4sVmdYPPGAuAgTpeQ
         8aJDTfiPYGv3+c8YvG4GAsD2JpGBhORs62OmCK2/e54UO11TocDeFN4h/NqJoQWKqIxB
         W325DeHd2KeeHWBeO9tS7edp+oJEhQFz01at4LojYJsCScRGRA0jHTV9jzvfqY7OBGJN
         F2jD5NmZ7y+B7RnS3L13Ddt9svF2RuXrJ747Iol2JDSEuMYM0C0IK4imFEv1hY9dlRNm
         1GyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787306489; x=1787911289;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=irmyV/0eSa9w7db6iLa2bBa2VlGeL5F1eUiaUcSYjjA=;
        b=QYzalXG7RwhxOL6qGrZ4ag9fxzSQZPUG+VUyjoNt8elmw6xBMHALp/QHxia1yEUE/q
         rpKiE7WGWNOODRqkuCgMEg+3/xb2E13Oww5HuVUB5CY43AE/Rq7LNFlKxyZQ4Mlq0gHC
         ocmRDrrPb55HaI/CNHYViMGv2P/kWWjzeYctZP+Odm7ECL1vkDZtcG6a6M/w2tlUjOwC
         +71iPyqzbp89xYECi+JE8FHr95St31FwuTf93a6T+1a3G6veLA9yHXMe2DO5Ucd76Ecj
         5sYRRMzLe02NTdNZ5CsloCGvobf1XUx7K0xyJfm37USLpq0gFv3CjiL1JFRzNUe0PiBc
         /xUA==
X-Forwarded-Encrypted: i=1; AHgh+RrEs7Yy0QQS5oU7xHK91tDPwGjwauxPaCJZyj60rOjHCZQeAc3Xdua5VIaXHsx3Dl17P6xBUA+bvkNttuHlrZqT@vger.kernel.org
X-Gm-Message-State: AOJu0YxPG0YQP42JwHwd92gXOCR9mocirMAv+sz9rj7Kxk3zLTNDnfMy
	Rqtx2uTyE0NhHhYVnLWne/UDkK0FLUeJRPwTEHsADgNJFpb6vr574EV1OJTYhBy4zIA=
X-Gm-Gg: AR+sD13QoBXe4Z8Tps7m4trVrM42YftjGWBJi6tKF1p4/C9Lq4SRtgYTdKmlVcS7bfA
	QQ7c1NIp/8F/nr4W+HoGLVZ7fSqkLwe00rV2gqcW3cJGyeYgdVvMmxoJzvBg3WMgfykQciOaKB7
	rd+TVy9kL4k/5we3OcLoAMISRgHP2/+mE0Q1Gtm/y6s31jrjIFhEAi3NVBVVkdKygkXQgp5ri9W
	gTJeDKeV2lcgN2+oObP+ElKRjKidlKuppg4JIrlZ5K3bqWcOC+co1UvR3yoggydp8OYE3DHqD/Q
	XdbnMBzNxRh3SuSp0LoFZOsa/h9pynsWkExOk1tOIxK4kEEERxNM6vxCkANHiYuQKNllnMv3QtY
	ZJTnBwR2k0sSpNzHwG0wrjmvxJwixsOX6BKFPdRgS4mTSqQB25wSjMe6hA5cCxiH2kcrRlvreKP
	wUWcwQ8hSItKCuPUGzu+Hr/YmWQ0pBQ9Bz6BOU21T/gPvfdcvB/2BKm3P7ZDCCpkvMLg==
X-Received: by 2002:a05:600c:4e47:b0:499:60bf:c6f7 with SMTP id 5b1f17b1804b1-499b8464503mr76563985e9.13.1787306488617;
        Fri, 21 Aug 2026 03:01:28 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b915c6ccsm21562555e9.13.2026.08.21.03.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 03:01:28 -0700 (PDT)
Message-ID: <c7c42471-d537-4196-b78d-9c9aa6c87570@linaro.org>
Date: Fri, 21 Aug 2026 11:01:26 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] coresight: perf: Retry failed HW_ID writes
To: "coresight@lists.linaro.org" <coresight@lists.linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Mike Leach <mike.leach@arm.com>,
 Leo Yan <leo.yan@linux.dev>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>,
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
References: <20260821-james-cs-hw_id-output-failure-v1-0-9d532ddabcc3@linaro.org>
 <20260821-james-cs-hw_id-output-failure-v1-6-9d532ddabcc3@linaro.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260821-james-cs-hw_id-output-failure-v1-6-9d532ddabcc3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/08/2026 10:50, James Clark wrote:
> Don't set the aux_hwid_done bit when writes fail so that it can be
> retried later if the ring buffer was full.
> 
> Add a second attempt on stop in case this session only has one call
> to start. Otherwise there is no chance to retry and it isn't fixed by
> not setting aux_hwid_done.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>   drivers/hwtracing/coresight/coresight-etm-perf.c | 52 +++++++++++++++---------
>   1 file changed, 32 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 09b21a711a87..0ffc5cd9c88f 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -536,6 +536,31 @@ static int etm_event_resume(struct coresight_path *path)
>   	return ret;
>   }
>   
> +static void etm_output_hw_id(struct perf_event *event,
> +			     struct etm_event_data *event_data,
> +			     struct coresight_path *path,
> +			     struct coresight_device *sink)
> +{
> +	int cpu = smp_processor_id();
> +	u64 hw_id;
> +
> +	/*
> +	 * output cpu / trace ID in perf record, once for the lifetime
> +	 * of the event.
> +	 */
> +	if (!cpumask_test_cpu(cpu, &event_data->aux_hwid_done)) {
> +		hw_id = FIELD_PREP(CS_AUX_HW_ID_MAJOR_VERSION_MASK,
> +				CS_AUX_HW_ID_MAJOR_VERSION);
> +		hw_id |= FIELD_PREP(CS_AUX_HW_ID_MINOR_VERSION_MASK,
> +				CS_AUX_HW_ID_MINOR_VERSION);
> +		hw_id |= FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK, path->trace_id);
> +		hw_id |= FIELD_PREP(CS_AUX_HW_ID_SINK_ID_MASK, coresight_get_sink_id(sink));
> +
> +		if (!perf_report_aux_output_id(event, hw_id))
> +			cpumask_set_cpu(cpu, &event_data->aux_hwid_done);
> +	}
> +}
> +
>   static void etm_event_start(struct perf_event *event, int flags)
>   {
>   	int cpu = smp_processor_id();
> @@ -544,7 +569,6 @@ static void etm_event_start(struct perf_event *event, int flags)
>   	struct perf_output_handle *handle = &ctxt->handle;
>   	struct coresight_device *source, *sink;
>   	struct coresight_path *path;
> -	u64 hw_id;
>   
>   	if (flags & PERF_EF_RESUME) {
>   		path = etm_event_get_ctxt_path(ctxt);
> @@ -596,22 +620,7 @@ static void etm_event_start(struct perf_event *event, int flags)
>   	if (coresight_enable_source(source, event, CS_MODE_PERF, path))
>   		goto fail_disable_path;
>   
> -	/*
> -	 * output cpu / trace ID in perf record, once for the lifetime
> -	 * of the event.
> -	 */
> -	if (!cpumask_test_cpu(cpu, &event_data->aux_hwid_done)) {
> -		cpumask_set_cpu(cpu, &event_data->aux_hwid_done);
> -
> -		hw_id = FIELD_PREP(CS_AUX_HW_ID_MAJOR_VERSION_MASK,
> -				CS_AUX_HW_ID_MAJOR_VERSION);
> -		hw_id |= FIELD_PREP(CS_AUX_HW_ID_MINOR_VERSION_MASK,
> -				CS_AUX_HW_ID_MINOR_VERSION);
> -		hw_id |= FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK, path->trace_id);
> -		hw_id |= FIELD_PREP(CS_AUX_HW_ID_SINK_ID_MASK, coresight_get_sink_id(sink));
> -
> -		perf_report_aux_output_id(event, hw_id);
> -	}
> +	etm_output_hw_id(event, event_data, path, sink);
>   
>   out:
>   	/* Tell the perf core the event is alive */
> @@ -630,7 +639,7 @@ static void etm_event_start(struct perf_event *event, int flags)
>   	 */
>   	if (READ_ONCE(handle->event)) {
>   		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
> -		perf_aux_output_end(handle, 0);
> +		perf_aux_output_end(path->handle, 0);

Accidentally left this in from hacking. It doesn't do anything so I'll 
remove it.

