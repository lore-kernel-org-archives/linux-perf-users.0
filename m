Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792572149;
	b=z5avxbpet9fsE+n/e+iAu+lhj0uPVFUCwcdpYb07GesqdTkV7xT9W2sXBvrCzK7cE6At
	 YX3IsE8mUCwQdps2veGSll1zHeJcPKs1hdruIHDOfBjZ1U4v4rKKeh7+je0DtiojBxZ5s
	 WeJvAuohL9JgCWAUTVJC2NPvJ/iy03tGYsYSHy9o0iqL/+Rbw0Y070NyIWxStbLxOQKyT
	 RbjB2VjOJW36nOwsVVZZ+RP2hEX+cKwh4NxNELHmLR9cz7P9hfID5viztpYDj755vE+L/
	 4eSg5X1atnyd5Q2S5QZzKkOBVMfiNh+VPtK47bgUA4G/o4AUj2YM/oMtm4ZDLR9dMwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792572149;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=HEJ2SZbhPnf8rqO4ewN7/B8xVL2Gxv0m91IYI80k11k=;
	b=cTMhA3pXV3TqJs/3RpGf2OIZYLXWaHzURYOEmY3D0qORkWrDsVcKm/cMDNSaiKrcecz4
	 qDPoyuhDZajcKXRHFgpeWTdEx/MJkrVeDPpqOB55O0Bk3uyh/l3TfxFn2Xiq3EpIZVjeB
	 i2zs9DbIzHBUxQTXW5epQI/nL46nx/0Xyhta1/29a0nzk5xyIh1yT9LOyqG0DZOkgGMoA
	 7SuDFxFt7ARIwvo8VeGEBMzjsgRhIkNPN1xnpKZHG/yecAh3ot1LrDcvpvQYrZsPrawvb
	 QuUqVbogl/H27qNhelll1Mf9Cj3SbeUNGtGPMaUKwS77Lf5gDOzfXBlSn85oEYOuCjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qstu8reJ;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80345606A320
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 08:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80345606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qstu8reJ
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48df0fa43c5so305533f8f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 01:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792572147; x=1793176947; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HEJ2SZbhPnf8rqO4ewN7/B8xVL2Gxv0m91IYI80k11k=;
        b=qstu8reJKHTSaVi9NiBX/KezIIDRXPKooU5RpcjJYtIQWGGbcKFWq87wOzYtISRcYh
         IszopNvOPLbHX2DVnM8u/XomKxId2aCZB2qhO/C/NT6Lv4aW8ohYIHsHKgB+W+2HTiDl
         fGX3CluWjL0UGIno2xWEU71BtrYEKtE27xo5N6Tqcb7o2PkaQNfSx/bDHtYkTvmHx/XU
         6Z/gPeHxJ7GXns9QzO4WY+zBDAThpJL75dl9mtS6xrrrhlE4bH1USPagesSh2lScrO4i
         rm8y9QHsNuz7lvu8dengmgvt3KCi+WefDx+6fLsMqEpfmqiv0k4jRIWwSpoNqpiF7RoK
         Gbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792572147; x=1793176947;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HEJ2SZbhPnf8rqO4ewN7/B8xVL2Gxv0m91IYI80k11k=;
        b=QyEkk3B9iA1xSZpMqcatTcIq7buN/E6JgGxPUauOJhhnngb1zDrOrpzq82m3iFfce+
         rB8rl2Gl3q1YkcH/ea+G1qqmsSVwTsF0YlFAqOJ6oRMMvGdaPQxiEUj6YjKXqHHeRvv4
         gBND811AA1WilWWM8Qa0cACo+ORCyZR1AXXqgNqTObm1Nnw1tRo5PvXO98lCuSonZrdT
         xXsPXEg7QcRG2eIzEUBbBETaIj4s/ud+2+uAUyQdm3V/0IybcgKTXbsSix3tnAwmY3yS
         a//Ow4phhlAIQpWUgzC3MEO2XiZPE6HtuotczRiLP+wK8YcL3Raka6MKGzi3A2lqREMg
         WOdw==
X-Forwarded-Encrypted: i=1; AKwUvBwPWmNDAkjkjZIuYu5toWlMFPFGmY0AyDqLcdcReCzwKNd+8UPiHn8QJMnVohhDEDxOcJvbsbqXUJIpoyUALPe1@vger.kernel.org
X-Gm-Message-State: AFq9FYJlirHIwQ+3sbsmxQnguRNBFSCrgqJdNqQFJd35p/Q47B6zZBkw
	pJ2UhQoyf+XwwsI1mGkLnY/AxRXqdo7e4joaH4QDql9ISHngRPXlKpv1x6Zlshg8Xcg=
X-Gm-Gg: AYBFou1e3tDAwzXLNWEt5Ndmxj7cKKLnsy6ZdaZnvmJPm3/MlzfgDn84Hj9rabVo+j6
	3legPHH1Fkzkb6LvE6EYGkRjHpyNi7qVZoEWD0z2tHKwEVFGhKOA83x58Eknx9m6k3PJr8uHK8e
	EOCSBw3rkecmNpxhQgiJjpSqBDZyO26mY1XfNp8bn1Hz/8g7C41/NkFVegmK0p4m+sE6to35yEH
	F6vVriVVWO1+4Yi4/+7VTwiQMU5XpAAVVj9RDse5cHYXvVPYq4m5iUURQftYNquR7QRP/4PosEt
	2ceWqfWVAevfNLyWjLHcVSwvFbpU03F3838acqlDSGNQNeI5tuGu7WiGicU/9E5jLH2bv2ugo7b
	q2+D2sLXOGz2Zi1Zq1E5DnU4ac01rUzULF0LniLtEuuygLTnjirwSr68N8X1WlBfXom7P1AItQL
	r8G2uL6AAdZ6M9Jk/1TBysy2wFT7vE6QJ3UR+ihXaCnLa9Jq++CgKUUo2Gfz6805DBFftwa9ACO
	0tk6cb2e2v1O0aWZjTuW7gXY4CdcS7cQL6hL2smeEBC4f+zTnMPOEob78Ve
X-Received: by 2002:a05:6000:1182:b0:48a:f4d4:e1f3 with SMTP id ffacd0b85a97d-48e264b3eddmr1756774f8f.13.1792572146818;
        Wed, 21 Oct 2026 01:42:26 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e254eeef6sm4066564f8f.8.2026.10.21.01.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 01:42:26 -0700 (PDT)
Message-ID: <2bc4b058-3a5b-4a9c-a469-eb8c93215594@linaro.org>
Date: Wed, 21 Oct 2026 09:42:24 +0100
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] perf: cs-etm: HW_ID improvements
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>,
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
References: <20261002-james-cs-hw_id-output-failure-v3-0-1d8b6ef339c8@linaro.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261002-james-cs-hw_id-output-failure-v3-0-1d8b6ef339c8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/10/2026 12:15, James Clark wrote:
> The driver might not always be able to write HW_IDs, but we don't need
> them for unformatted mode anyway, so fix that in commit ("perf cs-etm:
> Synthesize missing HW_ID mappings for raw trace").
> 
> Include some other minor improvements encountered on the way to appease
> Sashiko, like properly freeing queues and ("perf: cs-etm: Respect
> --no-itrace option") makes debugging broken Coresight perf.data files
> easier.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
> Changes in v3:
> - Remove old b4 prerequisite metadata that's no longer relevant.
> - Link to v2: https://patch.msgid.link/20261002-james-cs-hw_id-output-failure-v2-0-7a194aa61173@linaro.org
> 
> Changes in v2:
> - Drop driver changes and move to https://lore.kernel.org/linux-perf-users/20261001-james-cs-retry-hw_id-v1-0-4d45ab46cde7@linaro.org/T/#t
> - Don't process any HW_IDs for unformatted queues, just create decoders
>    unconditionally with trace ID 1.
> - Use zfree() instead of etmq->decoder = NULL
> - Remove dependency on "[PATCH v2 00/14] perf cs-etm: Per-thread mode
>    fixes and snapshot wrap support", it wasn't functionally dependant,
>    just touching some of the same lines.
> - Link to v1: https://patch.msgid.link/20260821-james-cs-hw_id-output-failure-v1-0-9d532ddabcc3@linaro.org
> 
> ---
> James Clark (3):
>        perf: cs-etm: Don't add global v0 HW_IDs to unformatted queues
>        perf cs-etm: Free partially created queues
>        perf: cs-etm: Respect --no-itrace option
> 
> Leo Yan (1):
>        perf cs-etm: Synthesize missing HW_ID mappings for raw trace
> 
>   tools/perf/util/auxtrace.c                      |   2 +-
>   tools/perf/util/auxtrace.h                      |   1 +
>   tools/perf/util/cs-etm-decoder/cs-etm-decoder.c |  12 +-
>   tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |   2 +-
>   tools/perf/util/cs-etm.c                        | 184 +++++++++++++++---------
>   5 files changed, 123 insertions(+), 78 deletions(-)
> ---
> base-commit: 705da5b15ab89ba97b11eedbe507c2fd83d31cb9
> change-id: 20260706-james-cs-hw_id-output-failure-1d06d042ef96
> 
> Best regards,
> --
> James Clark <james.clark@linaro.org>
> 

Hi Arnaldo,

Is it ok to take this one please, Leo has left his review tags.


Thanks
James

