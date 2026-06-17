Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9189639EF20
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Jun 2026 10:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781690867; cv=none; b=MpB8WN0dC2dJktliIp4uHfXJ6CJmfVAqD2HKTlZUgJbbBmHE0lcGuqVUXYyaJNjtbB3/Q60UH0mWAGFJpEynNeTAtVJE1+B8ZnNBPanYA6GiZQzifeWOM9ZrpBJi4lY6hqgRMLvwNTGgTznmOIe3JRMEmUA50d/5ucDCrC4mx3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781690867; c=relaxed/simple;
	bh=WViHPFf86OIcrg6u3qvEfJz9qeRU2+uSLzlQE+DLTfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lLx27HbKfah4wEAU0fbs7SuNskVcnRWN/T4Rb3/2/imWLo/wPGrv8k3Inu7QqPhDQYJFPa0tEkXwJMFhP8xrsyzPBrzlvxSKJyMZ05nl1uyPvGi+thhRnQhK0ueeFz3sM2q6NJvLOKqsFiAPUdG+2n4Q6zIc/eEaNQLCVIs0UOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=guqIoj4V; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="guqIoj4V"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-beb7f26ed62so663051766b.0
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jun 2026 03:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781690864; x=1782295664; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L8o6FpowEVikyJSlF+fJiucK7IqeLK1mQod3QozTsco=;
        b=guqIoj4Vi8YZ6sAIljRiQo08U9w6gHgAwMIUHs7OmAeVFMSihnK6ghI/BPWncOdAvA
         vkkw+b7kvJlmM9B1GMjJfThh3KKq9OJ2ZNl2KozUMNxZkR8+6l+7+B5JcnFKESUC3fky
         cRgudiH4nTWb/TbSl/LCNdKGBm+y1h+OTt6hmTFKNEXGGxz1SXfhcb38S/NnL1STZ8Cs
         XMgu6IKijiF0chTfyogTQ9Mq/Xpy8TROddupqNG1e30XW9hDCzGLlC1C6aWnQxV/yuib
         hLOJMxNV+kiEL+JGnS5TZj9Q2+NYTRZpAg28yuM0VmqqcEnHCizxGve54yJwHb8qtOUe
         aWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781690864; x=1782295664;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L8o6FpowEVikyJSlF+fJiucK7IqeLK1mQod3QozTsco=;
        b=YZzanYiTevqW8ri5/x4dyX2LULw17Y/VYGGAAtb4WmPGC/IRpvC6perVXM9quI+OvF
         qEKnc+0LvkBX0XuczohykYe0YuZr1V3JnjOjAWMIuh6ZopAmjK2pCCpnQ2hOT6034dL1
         DDLPX7naFxQ9OksJg+EBUtakZImknd/UKU7ACbaJjUWFjmBRUhfB1r60ZglWqtEA+kYh
         A/eGpAAQHgWf/yUnAgZculNU0qI/Ot3Hktst68eaRZWmIENjhd/g7P0pNR5bzUyCr6OM
         SNQWyldbh71rp6xiVfaacJJ5/g/xRr1DAjgI5nOVXfw4wkWa6ZMuNPaVN6mQ+zZqmssq
         OKOg==
X-Forwarded-Encrypted: i=1; AFNElJ/JMcv4gNzAWXGYV9bYCFXUXxRV+3YrZFkcO7vYFTP2G4txuAORBy/tbDYodzhK27MRj5wvDcOiK/EUxV2aOUg0@vger.kernel.org
X-Gm-Message-State: AOJu0YySM06esCAlaz0T1/VM/sxbeasLbYm9/UQPtAzAn9dEJ+xFyRjV
	4JpxkVq1M+LyxxGjX837oCxTNETF1bCSqXRSWhcnNXiKW4HNFSRmo5EU2mxoWbtw3nE=
X-Gm-Gg: Acq92OGYVPW6btnEohuQ5mIZKyLQUZ302UbZLrTMHWgfoXYCTJUdmBuWtGW3Xr2SB0w
	kzFXi7V6/8xQhqFF0pFxZq+2uDYH54CMxy3csdX4waW0UQKXYZ1jMeZ6SR+K3cBhrTBjrV0juHH
	wwXjBdtAcpgceXQPQzJeYfTHNAEDL32iogQOMcYblDB40uMjd6s0DOwBjWNaZb2tNgv1SfmjudP
	fvexdL/CzuDcgoKAmOzUi0jJrgStNd3uJqy2d5rOUj9XZSQ5T4sl1lNQYxsqgz16qMcvCUExec0
	BQRFfmt0F15pmRRO8FI415VlgbjMufbnm4lR8hxaq56NVCmT20TL5NSJJnKRA7g+UiBwWSH1NB8
	aCjm4+BmduMSoinHO9JWm5DS1yw+10/qW3Zx1L4SUq7B1Z9qgeWrjEeg6rqvUMhNO/8hBvgsmLI
	SVfo5ZjAcJ1pSbP4PiGg==
X-Received: by 2002:a17:906:fe06:b0:c05:21a7:6b0d with SMTP id a640c23a62f3a-c05a859954bmr221241766b.47.1781690863765;
        Wed, 17 Jun 2026 03:07:43 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb51007a9sm758325366b.21.2026.06.17.03.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 03:07:43 -0700 (PDT)
Message-ID: <1b6fccaa-b15d-4a33-af41-8c445f9c9d21@linaro.org>
Date: Wed, 17 Jun 2026 11:07:42 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/9] perf cs-etm: Fix thread leaks on trace queue init
 failure
To: Leo Yan <leo.yan@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo
 <acme@kernel.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Mike Leach <mike.leach@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Al Grant <al.grant@arm.com>,
 Paschalis Mpeis <paschalis.mpeis@arm.com>, Amir Ayupov <aaupov@fb.com>
References: <20260616-b4-arm_cs_callchain_support_v1-v9-0-f8fad931c413@arm.com>
 <20260616-b4-arm_cs_callchain_support_v1-v9-1-f8fad931c413@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260616-b4-arm_cs_callchain_support_v1-v9-1-f8fad931c413@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/06/2026 3:51 pm, Leo Yan wrote:
> cs_etm__init_traceid_queue() allocates the frontend and decode threads,
> if a later allocation fails, the error path does not drop thread
> reference that was already acquired.
> 
> Release both thread pointers with thread__zput() on the error path, so
> does not leak thread references or leave stale pointers behind.
> 
> Fixes: 951ccccdc715 ("perf cs-etm: Only track threads instead of PID and TIDs")
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/cs-etm.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 0927b0b9c06b15046afeafe23fe170b8248cfcc6..d484a6155c2c22fa916d0365987302f6bb9978e9 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -627,6 +627,8 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
>   					       queue->tid);
>   	tidq->decode_thread = machine__findnew_thread(&etm->session->machines.host, -1,
>   					       queue->tid);
> +	if (!tidq->frontend_thread || !tidq->decode_thread)
> +		goto out;
>   
>   	tidq->packet = zalloc(sizeof(struct cs_etm_packet));
>   	if (!tidq->packet)
> @@ -661,6 +663,8 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
>   	zfree(&tidq->prev_packet);
>   	zfree(&tidq->packet);
>   out:
> +	thread__zput(tidq->frontend_thread);
> +	thread__zput(tidq->decode_thread);
>   	return rc;
>   }
>   
> 

Reviewed-by: James Clark <james.clark@linaro.org>

