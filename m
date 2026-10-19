Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E464A2A75
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 09:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792402072; cv=none; b=A6/Xx88jdspV4mVco8NV1YihrgNLfQm331mCvxGKN7+OutD7Uj6i/Qi9pt24f5Z4n0wkzIlNbmWHoZgNFSdGR53+tJyy5yc0t7m7z1eyCN14oKVnb0gqwecnokAM665w6A9UKHtcLR0fDy51ReeD66sppIU/qRmFYkOpHSP91wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792402072; c=relaxed/simple;
	bh=luibakbmz1LG8fvOlXXumwXQ0o1zXo+G2jWoH1UwJqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFIc4BC4izWSDDrcW8eKEvT7wIPD5UIvSXVHAx99WE4PeWtSM4oJnwMBw6lYgAakBwyfe1SOAtUUe0sSsrYQK87Pahr77Dk4NaphRWnk9O/NKzRFs8aDkqxFtqPQmlKD5/X/NAmhhXgmIEIsLi6bqXO203h9RgkQvjAS+EzFrKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j1cwu2jr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j1cwu2jr"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a1dec056ddso10014585e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 02:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792402069; x=1793006869; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vxfJ3O0iUQzgj7wjnC72GNZjbJ8Awx2pxmwrd9Dvb1I=;
        b=j1cwu2jr+Rzaaas8BvooMezrxIws9tE52OUAKn79wxcrAR8XV/qOhMylgwejI9oibs
         3c12oA1rA4GhbhNE4L7xMC6vfZOUOArZDWldig4Lpb+v/2BkgCQARe8zv3GVRyiOIExY
         Uno2qAs/yzfuB/Sdw67E9YlvXJ8j+mFD1DBv8QQ8XKGFhe7MqkMh6iWwN2KqaaDY8Np0
         q078/NqQKKXZr1OGLEqThehphibX1jkzjiZncLi//z/EXxkb3d/+4peGwTco02nIq4Di
         0aSzfZhlw5JSzDTb9dTniLCQYk3iWM/AebhxlxBYvAtHGkifroQGhIqt3YaKRTtHMoiJ
         P6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792402069; x=1793006869;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vxfJ3O0iUQzgj7wjnC72GNZjbJ8Awx2pxmwrd9Dvb1I=;
        b=PkCvUp6hgoTGrbvhcczo61nzQMz+fgh2BPWEcDnlBNLGVrcRrGqHitnKLSZFlgxJmX
         X8fz18ZZQuDM58B8rnfOnF07K3jximrnIud0qNwG9Vvu2KwDvi7UJTDkx5Kv6cffeRu5
         pn0pU/YO8XN7axfzhMxRKy/xbkZGLbKo61rlLbrvg0sq3vID2/AFtKUf4Z+l1sXQ7DM8
         HAxMYbzBUgOj2mpt/7EKHmk+IS4HomipOvWjp4RQjDoprOonsxhkJtjSZWo0rkWHVdCq
         Hjh1Ba1YAZj+W+3DKoiPGNNUpl4JoaG/bcGxIiskMUhUSkNpZ0KmVx0VGLqGzOgkxWpR
         09Gg==
X-Forwarded-Encrypted: i=1; AKwUvBzcVHlaGb3gH8W6qYLqj5GnKZeMPJ82Gttgt+A/lJaI6wdDCv0Xosy3ro6Do/fi3UI6nQkLoT3NfBPnuKJnTWo0@vger.kernel.org
X-Gm-Message-State: AFq9FYIPzKf+lo/xFfChWf47Wq7FRzsP/+ruh3dqPgsG8ko2JEarNLBl
	P8902CJms+kmw/S2WQN35AlVBOQMByu2cVUqKjfVL895hPHbmb4dfbayzyHkwArM8PI=
X-Gm-Gg: AYBFou1tQdLwtl79IZS6yGKO1c8wXxYuKj/X9TPkJ8mTkL79cg1gURz2eUdMlChK8dG
	Z2MUKUe/SJF8tPmOximx7kvWfojAti7i5Qh5BPjn/52KihA0wnKYbecNLZ8e9XdrYkDRExJXGuj
	TVCO+fuC7n6ftaY57Ag/SkSgB83mLhUAt3mQpo3xkQGrU2ioU/3xt1NXfiUamaCOwhd0fiytFdX
	qbbfH13ITyttmnSQT2M9dFKKnQhyAXYNOGxOVkkAWGHy8q+vIJLH4kJs83TsedONjl0qnYNIwS0
	PTc9/5Gu+bQz8kVypoMGZBWdWoIvtGDVjbQ23f19TFnLh83BuChlNbLrjDbEhA0w6jwPLACGylf
	quzxprEJJECcd8S7p15lYs4J9+Jlv6OLV1TbV1flnQW8reo9PN/wsh4CgDjaWgAgYEbFj0k+Ac0
	cz8d2aNAqpCuL22Q/U74kwnQzM4530xTT+yB4XKjuFGpuAtzITfRR8q/DaKo+YUAbfwJQG3EsYA
	2E=
X-Received: by 2002:a05:600c:4455:b0:4a1:e225:b122 with SMTP id 5b1f17b1804b1-4a1e225b8d7mr85661165e9.14.1792402069375;
        Mon, 19 Oct 2026 02:27:49 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1cca26dc8sm188133145e9.3.2026.10.19.02.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 02:27:48 -0700 (PDT)
Message-ID: <5ce85fe5-f1ab-40ff-af26-7c315a0d47a3@linaro.org>
Date: Mon, 19 Oct 2026 10:27:47 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/25] coresight: perf: Validate context before resuming
 trace
To: Leo Yan <leo.yan@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
References: <20260915-arm_cs_support_aux_sample-v1-0-35cf6f297d20@arm.com>
 <20260915-arm_cs_support_aux_sample-v1-8-35cf6f297d20@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260915-arm_cs_support_aux_sample-v1-8-35cf6f297d20@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/09/2026 16:48, Leo Yan wrote:
> An AUX pause ends the current AUX output before trying to begin a new
> one. That new beginning can fail, leaving the CoreSight path published
> after the perf handle has become inactive. AUX resume may also overlap
> a normal stop which clears the per-CPU context.
> 
> Pass the per-CPU ETM context to etm_event_resume() and centralize both
> lifetime checks there. Use perf_get_aux() to confirm that the AUX output
> handle is active and path to confirm that the context is still live.
> Resume the source only when both checks succeed.
> 
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm-perf.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index c7454da5c881c4a8eea5cc77902c9113c297096e..e3c9d3cf84c502f357a430bc3bfa854a776618f1 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -517,11 +517,17 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>   	goto out;
>   }
>   
> -static int etm_event_resume(struct coresight_path *path)
> +static int etm_event_resume(struct etm_ctxt *ctxt)
>   {
> +	struct perf_output_handle *handle = &ctxt->handle;
>   	struct coresight_device *source;
> +	struct coresight_path *path;
>   	int ret;
>   
> +	if (!perf_get_aux(handle))
> +		return 0;
> +
> +	path = etm_event_get_ctxt_path(ctxt);
>   	if (!path)
>   		return 0;
>   
> @@ -547,8 +553,7 @@ static void etm_event_start(struct perf_event *event, int flags)
>   	u64 hw_id;
>   
>   	if (flags & PERF_EF_RESUME) {
> -		path = etm_event_get_ctxt_path(ctxt);
> -		if (etm_event_resume(path) < 0)
> +		if (etm_event_resume(ctxt) < 0)
>   			goto fail;
>   		return;
>   	}
> 

Reviewed-by: James Clark <james.clark@linaro.org>
