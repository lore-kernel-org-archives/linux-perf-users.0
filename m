Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795084925;
	b=RanZnxOkVnEXxu42cNdmz8lNd/aaMOe5EW51ulfjoT0y19dA/WdJ1JkxaFyDgKDnRyns
	 iRM7HeBMnWdrFM5ZT/XA9houB/5TyNxJye255ka8FXbEGD4TcNcNgu7IkAlEN4J6WOK7p
	 ZNHBueJ+AFfIjNzcxARnRPAuvwUi+wqK2hRwklVDVZRt+UOXdwzLoDXoqONOwK2zXWYSC
	 ZYyHzd1QKHowbSdD7x1EK37eQVjQJtD1rL5ahUyeSNsx04sAjVAleC34ROGiv8gQEBhNk
	 biF7aF7kVHbBKeaL0la3HjlLz2Ix4ugBVLPR8Z0aIYGZXcYAcKmcQAvFDZc/2PGv9mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795084925;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:References:
	 Content-Language:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=0A8q/L3CmrGgEk1a8NfJ1t9SknZ8U8Gii/mxNtOtl+c=;
	b=BOeeAKgA+A8DBl/dNYLqLQ5zW5e+SNebseVrFtCOIRoxM6Y1tjGhbWsTOXiLkm0e4pFr
	 esmtDHctEG7qZAc20MtmlsKpR+l8+aiRpGTkGY+KOQtTMwS6qEDkKdKaNiQr0Ys+mr4K8
	 kWMjcumm57IzDtwwjAqds+WyKx3c1vO2X8HPxixVjjtVfNHUPCpaepwkXVWetlOPVztU0
	 ba2ul0+moFEe0wJWvCdscMiI0u+CtPdhUY+Q/d/vKuPHRqwxtyDnZMXbMkgblfQzIjE6G
	 /APosvhRotXiSjMv2WSmmT/BisKOVXbg5x/oU8hdJmfqXAMeXBLZ9DMiV+L9KyQAHkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="ch/kaiTt";
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4821C606A33D
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 10:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4821C606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ch/kaiTt
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so16058935e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 02:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795084921; x=1795689721; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0A8q/L3CmrGgEk1a8NfJ1t9SknZ8U8Gii/mxNtOtl+c=;
        b=ch/kaiTtpwL/+LkhPiSBPfToMQlHCXea3CpZL1gXLWCh4nnTJIlioTkaIIrSetrUcP
         yIghQ8TZWyeEufK9m1U84tP7KfCyGo63q4/hTRa4mXJ6F9gvczi6BYx5W+Ai2in0yoeh
         5BBRCRMiooaSjh+pu7JuuLxXVQidQYpsAA61aWpLaFFkuaWpWrCRE+TWEmOQcw2C4gpe
         fLKT38jHavOU80P1E/tPRYj22SZwMbu3WNG5l5U1OmhebatIgc6KpiS/eERdwpOQoKG3
         s8iZ82HjHRgfkczSzn0IENe/YHGSjSnuK0ChwCOGi0lboYM8CmXKIxskJQjAIpD8KQG/
         zb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795084921; x=1795689721;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0A8q/L3CmrGgEk1a8NfJ1t9SknZ8U8Gii/mxNtOtl+c=;
        b=hAEDAhgLQKI0TlNP/+cRbQAAzB4Xm2ocL/ooBrWxH87t+E05L66o9k885BdWyXMG7Y
         LrxoZbRyy2qro/ZU0USftQq0W0QIl3Ui5QXtdJgyj5kBww7J/B8xVo3Rr8O1E9gdVP2C
         PdjxLIAnIHutU4PnLxijSLeD7nCjurmPsZa2cLHktLjwU8XHfLJT+4vfwsyO8ZpO7fca
         rslbHBV8sjJUvOa/VaKJ+/onnBfxOOdKa21Fx8KFde0G2Vin6GdvKRqj2e3lnXnQ+dwC
         Xooal3BpqB+bXzhlj73QARyVwUGp0XkUa6lD8kQ7F9qvdgMpJczSLzRKy0T03xNtioYf
         /Igw==
X-Forwarded-Encrypted: i=1; AL+hErF0adi3BnuuEk7ZBbJXGsOlCsCkZ/ril9KRy7O/4qOBs84tqe6EaGxx6nj49pNZ50PIbsCAXfY2Yml77KwSlnWY@vger.kernel.org
X-Gm-Message-State: APuU4Z9nJiKPCh5Adqm0cgrLmhf2WImeu30irZ3DVff0KPR3KBVSPCXW
	5KDjztRUF+JeegPyrJFrnhbJnaMk+R2k4LpC64uWAby7VXuDDxbw+WoPKs6sJ12NQVc=
X-Gm-Gg: AYBFou0giU9pdDcd093lkDM2C2HIkMvFydXVmQ8SOLElVxXpL32GOmqKBfaf02DnK90
	feMTMNQxD5TRFWnANCGgJbmjF00SVR9xChW8Fweh/fl8iUxIwVlySRHwMDSduZ/GvYG02Ex0GfJ
	hr9JjX3N/iWdfwvKUpgVw/VYhGvUWhYekzHSZLPAIKSGoBUStG+2eC50j/Qqa7jwoDTASo3rKRO
	Fbv2Qg5lVLcjHcLLtYX/a7m1P474FR+99RjLvKqMwDFuz//v0OcmpPYXCZZQSzJEGudDuKlynDf
	RlgR++CXdaOHtPanDPbdtE42fXcXgj+lDeSKr+2VF1U772bxE4CZS5rVPPJOeErL43pflBnuxdd
	yDEs4kDaAV/twfnIOnMgmLeua3PcJPkisVOaPR8ZoMk2PwyhoTJZRx+gNcWpJNtP0xAKHB8CyWK
	9braJdcQqCI2Ub+DGramsovl2ziyfBq9iWu/fCSqrMU9d3u4E2TmZOvXG9jeT7lGiP9kkZTV19K
	fzNLSo6cWL1qKIfomlHdOrJGEbOQ/mozBGsRyNJbA1RJiv1xfAjFk0aX+YjPR/CJcsBq+t1X2W/
	o8UcQR8BpET122tEPHVJJecw95hepbKkpg==
X-Received: by 2002:a05:600c:6708:b0:4a3:59c9:a744 with SMTP id 5b1f17b1804b1-4bb7d9fd2f6mr104170865e9.7.1795084921602;
        Thu, 19 Nov 2026 02:42:01 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b2c5sm26726305e9.5.2026.11.19.02.42.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 02:42:01 -0800 (PST)
Message-ID: <56700f45-9cd1-4375-947a-d59f9aeead0d@linaro.org>
Date: Thu, 19 Nov 2026 10:42:00 +0000
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
Subject: Re: [PATCH v1] libperf mmap: Arm64: fix transposed reads of counters
 12 and 13
To: Ian Rogers <irogers@google.com>
References: <20261118200057.2134362-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Rob Herring <robh@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261118200057.2134362-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/11/2026 20:00, Ian Rogers wrote:
> Reported in Sashiko bug linux-3291a858-209c-483a-b4dc-eeb57abdaee6,
> the 2 counter read functions for counters 12 and 13 are transposed.
> 
> Fixes: 407eb43ae87c ("libperf: Add arm64 support to perf_mmap__read_self()")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/lib/perf/mmap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
> index ab3adf1d8baf..92acb0e911f7 100644
> --- a/tools/lib/perf/mmap.c
> +++ b/tools/lib/perf/mmap.c
> @@ -376,8 +376,8 @@ static u64 read_perf_counter(unsigned int counter)
>   		read_pmevcntr_9,
>   		read_pmevcntr_10,
>   		read_pmevcntr_11,
> -		read_pmevcntr_13,
>   		read_pmevcntr_12,
> +		read_pmevcntr_13,
>   		read_pmevcntr_14,
>   		read_pmevcntr_15,
>   		read_pmevcntr_16,

Reviewed-by: James Clark <james.clark@linaro.org>

Interesting mistake. Doesn't seem to have been copied from any of the 
other enumerations of PMEVCNTR either.

