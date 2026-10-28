Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180110;
	b=d/iyL064cwdg1Q0NLhrpwle7pm4kiFqaPjWrN/s5mCM0MxEPqa+9WoIDlxqc0sKztvjt
	 81E5eyFR2kWgf6ot8923p3jb0ZFWAS7RbPle+vbxmEzrmIiHoxLlGih6NCnkebUAialh0
	 n41RUvJE0V7c8+hSkP5TKIbOh/7gSa5DvHYopNXhc2Fi7DpkQMHBGVpeoQrowrbTjRoOD
	 rcBU55LTqzzu/LxXMngBEENRZQMz0q7Z1OL4xVvJ+rtYwlqUIPZdJbiDbBO2CPbiOIkAb
	 E/nezPh+lzYx7vFoVuoT3PGxPCF8lchLZ0NxBAcMT1SZyS31yc2EGsZJ/F4kMUucekw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180110;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:References:
	 Content-Language:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=A9WtHaR8QfonQLgULw4WHEldvGjq6xiOMZLZlTl9tks=;
	b=pGBpaPymIReHVwdJI3ISvqL3tLp1bLP7S2uA1uNE9AvwFGI1DF6nVasBLV75DFDdfpSM
	 wrL2I/SmvkkdNobEJ17dtnwA743q/y5SIik87tvF+88igNBD8I6FC4JH7FHbqiyK82PLv
	 QaPtkdIodpofHSO9JinhkZjCnKbwQEVSLZErNHWFCZCTeKfhW11cLaY8DsM85TTKZRk3U
	 sGDWPKgaAt3JRJXwx+Lgb/Z9P3hgqZH5D5PZP+eEtKzgMJF9llcfaIutx67M50qVYfMk+
	 ERvRcBSFTzUleXFIVQY/sAzIi4Nj4SeKJLK09tOCpd7sKn8LgKVxSnn4ZhveX6XwT9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=njQEsn09;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18EC606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Oct 2026 09:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E18EC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=njQEsn09
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so5925425e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Oct 2026 02:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793180108; x=1793784908; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A9WtHaR8QfonQLgULw4WHEldvGjq6xiOMZLZlTl9tks=;
        b=njQEsn09fvS2qLgUSPr7CUN6b0DhFo3LFa5YydyA2W619HsLxQg1aYjdqLqWiLJNF4
         fxd+H6ZHHNbk0JsP3/0Y3mUil9MLvr1gX4iru1ddsAqraMYLiqhGhfC3Ip7k7vJ9i/UK
         t6q8OJ9kJL+15Sx5JAZ9h6Y0/RWQ4O6dJ+4omrd97ywnE7l4AVjWdpMQvpdVckyMsaWz
         8gxFm2p3dAAnnYYahwx/C0tRKiErZh7PH2MqXG/GcPTiKRB16GLnaPrdTf9zwrNKvjGI
         MLXWwcrpvgOmnXC3rYXSG2AGKcYxagvRhBUN/L1TVy0ThgTJutG/OcgkZ97YIV+bt+kI
         qfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180108; x=1793784908;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A9WtHaR8QfonQLgULw4WHEldvGjq6xiOMZLZlTl9tks=;
        b=lETsba2WU2MflSQ/UmeEqjoBPLjPIr+rkDTs9lT5EkZuN/VvKXzM0txkXUQ8WXO3s0
         eiy9XuoUF48GByGYeQ/srdx3nWeNnFBbUH8xJERlAqknOxMIHZ/tNQyFoKz2cJpYri4r
         Z6jlXVet7qXKTYUSZZLpq6BaidKOZ/bEytcrrYmjS31Pn2yqjgVZDDl2DQpe3Z/2kfeR
         mFfDumIkH/mem0Vd7x9KTQkr9VHKJLXuF5Nub3nf/8t/3RKT6lhfDt91ICxJQeLoZGIk
         5fcOIMK5r24b8Zp6n4/gvBbZ6m0dmayk6CbxvXo7BfIiv5aE22OYl2s1QijPJQJ4nYgJ
         w2dQ==
X-Forwarded-Encrypted: i=1; AKwUvBxe0hGRVrc/QmnzNnint4Wm6xAylbFKRF53U5AgbApviyzmA7DNU73RtXUUOaob+2+UzXBGvmzmm/JgIfC0z/ZD@vger.kernel.org
X-Gm-Message-State: AFq9FYI2dNyNf2iRTgPjHbWNopjFjz/LHXqCUADOIT4At3j8IyC42TZh
	IXSU/WkA8fkxoysMrueocYlkP4UF4sOm3BPF3kVLqWu/nXMW7KZQAjj1fW4zEMYC39o=
X-Gm-Gg: AYBFou2+Bdbu0VJkZTSZ1R9l5tC3t74+8IFHIv5P7xdDE6ZJKJvNIFWovFQe5rZtsU9
	jFuRSxv1s3r+CVdmT05B/Mtjtjpu3Tt7Nv5AIUdp6vU84OSYTzjeQkjrmUBgbS0YNTfmmSajgPz
	G5v1zG9D7DSntlvHWJIvUkz1G5CzBnX/NPx53WrM9nJsyJSP7lqZoo5lG2RVqOsKq2iXXvRy89j
	3VSnEs/nr3BFKNZkfJfvI8uQPcw9AIklWQgXtxa2F1a5gq2hCqi4q0/xQ64CfR+fULWjANHQxRl
	Ko1RQmt7K8XXDeZzC6699g6eHt1IcmqKy/YuPDpEju0q6Ev5XQCxlNE7CGbqyPFKhrMn/TBD4bD
	HngjH67w6mobu3TM8IoDPDlif5xXOWudg7ElBT77eKRvA42JSYoF3VFIHRMeuARDtfDbP6kvhiU
	NVljTUuYGG3sJpygFZPMcz9C8S0tIwIH9ch+lEd0ArG1TLDLCb+ML63uo+XK47DHr06BT0DkqPM
	oB9ybU6jmQhN/+0ehPYUucJf6yPO3pKboCnvmpretmjwHtCV5apJlsybyDowYYMVj+tjd7MWLbL
	knNJVp+9INzMEhtsMIA7DlwV3zkppZO2AQ==
X-Received: by 2002:a05:600d:12:b0:4a1:d97e:cd60 with SMTP id 5b1f17b1804b1-4a9672f8166mr25922195e9.16.1793180107988;
        Wed, 28 Oct 2026 02:35:07 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a977edc20csm28371725e9.3.2026.10.28.02.35.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 02:35:07 -0700 (PDT)
Message-ID: <d3886efa-5be4-4cdc-8990-ed56b044a5b3@linaro.org>
Date: Wed, 28 Oct 2026 09:35:06 +0000
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
Subject: Re: [PATCH v1 4/4] libperf evlist: Recompute CPU map when an evsel
 goes system wide
To: Ian Rogers <irogers@google.com>
References: <20261027170415.2815859-1-irogers@google.com>
 <20261027170415.2815859-4-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Ankur Arora <ankur.a.arora@oracle.com>, Howard Chu <howardchu95@gmail.com>,
 Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261027170415.2815859-4-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27/10/2026 17:04, Ian Rogers wrote:
> perf_evlist__go_system_wide() marks the evsel as system wide and then
> propagates the evlist's maps to it. __perf_evlist__propagate_maps()
> only assigns the PMU CPUs to evsel->cpus if the map is empty, but an
> evsel added after the evlist's maps were created already has the user
> requested CPUs propagated (e.g. the "any CPU" map of -1 in per-thread
> or workload mode). Going system wide then leaves the evsel opened on
> the wrong CPUs.
> 
> Drop the existing CPU map before propagating so the evsel is given all
> of its PMU's CPUs, as is expected for a system wide event.
> 
> Fixes: 811082e4b668 ("perf parse-events: Support user CPUs mixed with threads/processes")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/lib/perf/evlist.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index c1c5b0684eed..46de69aa5a86 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -835,7 +835,10 @@ void perf_evlist__go_system_wide(struct perf_evlist *evlist, struct perf_evsel *
>   {
>   	if (!evsel->system_wide) {
>   		evsel->system_wide = true;
> -		if (evlist->needs_map_propagation)
> +		if (evlist->needs_map_propagation) {
> +			perf_cpu_map__put(evsel->cpus);
> +			evsel->cpus = NULL;
>   			__perf_evlist__propagate_maps(evlist, evsel);
> +		}
>   	}
>   }

Reviewed-by: James Clark <james.clark@linaro.org>

