Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36054B95C3
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792402514; cv=none; b=PV3MQGoBlw96xnGIPk1oONEGJplaseFN7Th8gMOrMAYTkIWuU3Wt6dJpxQsm3jjn3fjk1TD31cyGovNANmh1ijgrbM+kQ1+xQSOI5r1sbE4+dRZM/kfoPDecX1MiSjQAzx5WZ2pUTOWpJ341KWB1F1nAFIMkUvp3NnYgdDEwr2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792402514; c=relaxed/simple;
	bh=4QAG6NlT/0nwL//USt0n95Bo3PHood1TAUditJeGxo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XqB9TomLehInEIBxrncttTrfb/11qhJmLO0JWqLddteV5gONymYyOxhlMzFK/2fI1ZGifQeErVCEAMUzg2Mtes5enVFiqzorKuPUBqSzLkl2uzHXDp6cCywqYkebeWy7H+oCO+lC9vxMSq/TO9x/zSf7Ss39lVCIYz+Pdl6n/K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xEvUesER; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xEvUesER"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48df54150dfso1380898f8f.0
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 02:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792402511; x=1793007311; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fTaWLyJQguuj+iwhlfuFOJfOVGeQt6aW3eAE90gC5/k=;
        b=xEvUesERmfQ9/eF0p39TiklyhjkSGBAvjc6/gkr2heMFFDmlM+yK/3AF2xshobPANn
         8CF8HKs8LXfMhx13oydyvezOzjylDDKUzJPKq1NEWG1Jmd/wv5M/FpSbUhlDfOqxLVRI
         3yY+HmMRDrEbMxf2+QXhNnXG0g6tPEGwagf8Pgf2bVR6X6J6rN9ha2kpDebG6cvo6Yam
         8F4Hj2u8HYMJ734AdkL5PHPdeW7yOSeODKq87k8NcxOz3oHBC8VKRlExjCuyjtE1BSC0
         LPTO/UjXHvNJOAl4xA6p7qHs/wCqUzESvOpGe1d2/o0jIQWNjgA71PjkTGZjFW1jJIL/
         +xWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792402511; x=1793007311;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fTaWLyJQguuj+iwhlfuFOJfOVGeQt6aW3eAE90gC5/k=;
        b=2zFz50gP/NBHYra4FqyFiFTU3iqutM9zeYyyrMA9PD2LlAHrDQQ3CCtWTaqEagALcS
         15XfCGthSWweag5um15xJXvMKOObqiBKR6bgePKfoSfQFyl6XJJJOIB7ppfwyeDByW4w
         dXrOG4dDikw+jR4KKa5TuowIn0tBri1//XkE2rMGPPZFQ0EfrY5mX2DhJdScfnJHM3wU
         /EjD4e7ma0oCs+wimd5oXpwhAw39H5YAphRWQYOZM0PCm+DV4EindZ0xw+kpg/NmB0PI
         lB33vQJV4NAk2etsmAzGjI2bjrQ/FfaYLwu8Yo2TQqspdoTARquxZMwexwSTXm8XCvXU
         mjZw==
X-Forwarded-Encrypted: i=1; AKwUvBxPnUZ4SthS4AWkXOIrdMcHEKDfaEM/NS94dph5xYuDuoenAadaCvW6ntF7/j+od4BVS2stiUpeQoIlxVNnHLnB@vger.kernel.org
X-Gm-Message-State: AFq9FYLfBSc4RNT2OVIoSCvoWTEsjya3B1KmUcJs7L8Z3uviIXZmxsS0
	S8KrsUY58ZIoeosUdMEU29/hm8+/8R2CNFWT0btGywZrErh92vikOz4UdVz5U6Pld60=
X-Gm-Gg: AYBFou1Kw3CmYPLFzrVvYJOOHS9TzYxvc1QYCuMm+5TP4NCtq9l1dUiXoZpnOgRZPkF
	xX5eG9VBde8rwEhUidYW4k9XNccysK/259diiCwoUpyKwOhvHE6Hg9jcFZqh5Te4chYhuTkrdR1
	N3NriLYH0nVbVRqPouWPgkzu+PSzwm4mM0d5eLDUs/NZL8kUtliNdmG4kql7vTWVuYKHTGuFstD
	mjTAJj5v8rlcYQA4qCugxiLS/1qz/FMGzAJ/jbH0p56K4klNgFMvQ6fuRf6F6nFoiA/o/vizerN
	X11xfFBmrPOhCIn0arydIfz5egU+6DrsaNfZfFCJGGlISNoJ6ZSZ8p7eMzO/NKNpIj4CJ5os1LX
	RSuLAufjwRHw61bwTW6cG96tYOr9RQXu7RNOo8sjO0oZ3B8Sa2KJnRHJdZEcW+/+MdGQOdTFNme
	q8j7ebyxR9T/eSAg262+A1g6XH1mMWrjKBSXp1VPeBcQ6cBKVmngpOOcS5Cf8Ccv6fgIc81X1+Q
	E2g
X-Received: by 2002:a05:6000:4b1a:b0:48d:f034:7fcd with SMTP id ffacd0b85a97d-48e07fa2f48mr12167246f8f.51.1792402510355;
        Mon, 19 Oct 2026 02:35:10 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd471a1fsm18752727f8f.3.2026.10.19.02.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 02:35:09 -0700 (PDT)
Message-ID: <296f398a-a351-4290-80e5-d18427a88dac@linaro.org>
Date: Mon, 19 Oct 2026 10:35:08 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/25] coresight: perf: Improve hardware state transitions
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
 <20260915-arm_cs_support_aux_sample-v1-9-35cf6f297d20@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260915-arm_cs_support_aux_sample-v1-9-35cf6f297d20@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/09/2026 16:48, Leo Yan wrote:
> Keep hw.state consistent with event activation and AUX buffer updates.
> Initialize events as stopped and up to date, clear both flags after a
> successful start, and set UPTODATE after committing an AUX buffer
> update. On resume, clear UPTODATE only on success. Preserve state on
> resume failure and ignore duplicate stops.
> 
> Add helpers for setting and clearing state bits. Use READ_ONCE() and
> WRITE_ONCE() to prevent compiler merging or refetching of state
> accesses.
> 
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm-perf.c | 58 ++++++++++++++++--------
>   1 file changed, 40 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index e3c9d3cf84c502f357a430bc3bfa854a776618f1..f66c99b26e1862ab04105704276c901b21728207 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -150,6 +150,20 @@ etm_event_cpu_path(struct etm_event_data *data, int cpu)
>   	return *etm_event_cpu_path_ptr(data, cpu);
>   }
>   
> +static inline void etm_event_set_hw_state(struct perf_event *event, int mask)

Extremely minor nit, but inline does nothing here.

