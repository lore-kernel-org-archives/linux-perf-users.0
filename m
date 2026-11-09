Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794219844;
	b=pjlFt68qQk6nxGORA9ZTRXRNab9XWID5TCfs0hz7S3BBw2VldCoKb+RY7EeQuCeFWtdJ
	 EQ0W7Ud/Jq95XsCIjmmD7nPt9uOQXns+rxL92JbzOPpznuA3O7KtI66dWflmm33UNJxtY
	 R5a96Xu8XBWfGeFj6tIWjT8iOBEoYkGdpHM4HXnxhzMChMXzXoNwdZx+MB3LJjfWKSP7v
	 o3pes0F4NBQjdlzcUV776lLaltkH0aOiH6lOUu7H4yd4xwf4NDNXEpQDiw/keDxQDF7SJ
	 7H3dv1IpT6qJUDx+KZosDcVoayjYFPrHmhH0nI0x4be9c07yu5RIYjDuWBTaqCzhzcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794219844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=LrHYhLri5ZS8HxQtgSMKMn2DV1tWM8X9x+L3DN75OE0=;
	b=noVENCa/+J7cfEhfbVeYYzH394o0ElPGbNuyDTNy1+Y4CqMXUPVH1cBLBS1vS/XFFRwO
	 Wuqi4g9jQOjXretvn7hsShoPNtdRFxZnMMMG7/vilO4XFABhbiY8lVzY8ia6IYiDUxONv
	 /8bJRKQkpcfN4S6RWQtoUc7ObvQNcnw1exv7qZ3c6Z1gCexb8o3b/KCQlrjfj3hBqCILO
	 e81vtXrw3veA94JGP+hVqGaWOZlG8lfBfc9dApNxXFEeMeLf1GaR/iNAlVKxfQtAHmI1B
	 tOkedfLrlA1ebXcbC/bHTJCa7NO3rBU3GX9y6U+H6wr952fm07ci5XjPGeqYfwqDJvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nlj9epQT;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEE1606A321
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 10:24:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DEE1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nlj9epQT
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso7368695e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Nov 2026 02:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794219842; x=1794824642; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LrHYhLri5ZS8HxQtgSMKMn2DV1tWM8X9x+L3DN75OE0=;
        b=nlj9epQT2z6HXVUfKx/96+teYLS0gsHU4Q126wQ+ycCDv1e0EFZ/IAcHbWKSpCckJW
         7b/tQV0B1zwMXX/DCdHAVXFRc+UJkrBnM9ACxgvHO0TsEBg+noR/O+LJOeoDjXayliSi
         AXXpc8GA8kTyUxBQ4dGW7p+w4IWZb7+5k2Ys0vipibDcKHeNUAIRCfklmxMhJMxtqeRY
         oQ9wiWxx44j0cI7aQ6Zsuz9xDMcGpOiEQbhFpSx9s/r5lzxSAcw6MYqmN3jR2WV0sUuB
         gDDvv94jll9603RI6xnhZ6wrnmtFYxeLCj2xcAIDkcNdWBDJIeExnlA6PlTr+ybRmalJ
         NSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794219842; x=1794824642;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LrHYhLri5ZS8HxQtgSMKMn2DV1tWM8X9x+L3DN75OE0=;
        b=oE6GY/qjQzLUv9V5XB7O8xivHe9u3dpSjMkBBfZX2lUf9M8sKaRJErWtF5CeTziM7r
         Uw9kFLwWbTiHdD8vKf3ATZzsIxg3ephYSM5qtpigBRrHcFhKywS2cYXvR7R3ITbtEYQH
         xXQzUMs1iWOvx99NDs2YpVizKfXo78VNrtCiwfbiEjUGEp10+Ju/Vx1d307UadiV6HHc
         Tmr1tCjdLcDAWcLiawHxFBwR+M703wEr5LVQXY+FVznNOXvZGFIdK90rUFnLx78HEuXu
         816x13/YvvV0fv22XvfAxjPDFyxDoHdKk4F3qFFnuz8oBxRbPN8Lp5kMBSB7dcnbjTXd
         UO1Q==
X-Forwarded-Encrypted: i=1; AL+hErE49djMvCCsdVsFwSCIxSy/IMcbVGAjca+JBKIXYYQc0PLwR32aVp13WRcL70cBT4YTdb3flQ9I1m5jVkGbhQ8h@vger.kernel.org
X-Gm-Message-State: APuU4Z8uTOJ884wK1C9NtE7rHNHGVMYfdPfWKA8LBF7PjDMH2tI1uqiv
	IyJTu0fc+bv5FckOshRg75mLQgH6lvJnJPkF4W4QWNsShXm2N2vVVUNZvkjkvp+W/vQ=
X-Gm-Gg: AYBFou10fqKgMvn/Wx7I717BeUwtqxXEea8+ZkdK1TsZt/r5l3oOgkxfQtr4N3UhUXO
	XVyBbmJdZtlVXJvY3sY/nPiWUHb1uWnMICAwZqHmJpjmlEmeq6qmw3h4DSm5lAgBN2FregS7dS3
	HLnaeuhaKiuftP6ghQ7JZ3kRGSkU1fThye/xgJu4MhOTiSNLkwiD8RGBtxCtXo0r1W3DB328fWg
	LQnEz5QFimTqaDTKk7cl2xlxuxiZGyFNK8BZxVVmZs3X8KTqiAcWJzUaffe2suG7c0Icb/MIKn0
	OOs527F8On9D61FdOPfovLZW3/gyXxJpiyI+N0p49oSunTRUEwQ9+/TUh9hE47gnzfgJsLgzNXc
	EAZe7mjsG7N2u3Zfvlmtjbg7RVx7UVps6vW1HGrErrTgDQQuzxmBZ3WB6CMO6ePSh5D1DmRyZ6S
	SulDWUqJdIJzt3MeJUvXLBZj+QM8HQxuCBfb0ZU4yWX8w1ujKMzAMeNk2DM7ZLq/GLdfEug2rcs
	Uf3/BIbyDFWTr4bnmWb0+c6bGYc9AbmJRD6eKLhldAfP3yjBnsl4+VucmheB2vWQcJNtZXxz9Sm
	tQumzBZbN7wYQl+XLQatvBE9TpAlGj8q
X-Received: by 2002:a05:600c:3113:b0:4a1:f720:74cd with SMTP id 5b1f17b1804b1-4b963c91d7fmr67354805e9.24.1794219842343;
        Mon, 09 Nov 2026 02:24:02 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7efb1547fsm406780645e9.11.2026.11.09.02.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 02:24:01 -0800 (PST)
Message-ID: <bf6925f6-613f-4e20-8491-2a99183f34fb@linaro.org>
Date: Mon, 9 Nov 2026 10:24:01 +0000
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
Subject: Re: [PATCH] perf vendor events arm64 AmpereOneX: Fix misspelled
 PublicDescription keys
To: TAKANO Mitsuhiro <takano32@gmail.com>
Cc: Ian Rogers <irogers@google.com>, John Garry <john.garry@linux.dev>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
References: <20261108183846.3804875-1-takano32@gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261108183846.3804875-1-takano32@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/11/2026 18:38, TAKANO Mitsuhiro wrote:
> Sixteen of the 28 entries in mmu.json spell PublicDescription as
> "PublicDescrition"; the other 12 spell it correctly.  jevents.py reads
> only the keys it asks for by name, so those 16 fields are dead.

Shouldn't jevents enforce some kind of schema? This seems like a bug in 
the generator that it's allowed. And we have all the json files in one 
repo, so we can fix everything when adding strict validation.

> 
> Fixing them does not change the perf list output: every one of the 16
> entries has a BriefDescription with the same text, and jevents.py drops
> the long description when it equals the brief one (jevents.py:405).
> Running jevents.py for arm64 before and after this change gives a
> byte-identical generated string table.  This is a cleanup, not a fix for
> anything a user can see.
> 
> The file becomes self-consistent again, and the field works if the brief
> text is ever changed on its own.  No text, name, code or expression
> changes.
> 
> Written with Hermes Agent, an LLM assistant; the tables were regenerated
> with jevents.py on top of this change, perf was not rebuilt.
> 
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
> ---
>   .../arch/arm64/ampere/ampereonex/mmu.json     | 32 +++++++++----------
>   1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/mmu.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/mmu.json
> index 66d83b680651..9457f9be4ecc 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/mmu.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/mmu.json
> @@ -30,37 +30,37 @@
>           "BriefDescription": "Data TLB translation cache hit on S2L2 walk cache entry"
>       },
>       {
> -        "PublicDescrition": "Data TLB translation cache hit on S2L1 walk cache entry",
> +        "PublicDescription": "Data TLB translation cache hit on S2L1 walk cache entry",
>           "EventCode": "0xd805",
>           "EventName": "MMU_D_TRANS_CACHE_HIT_S2L1_WALK",
>           "BriefDescription": "Data TLB translation cache hit on S2L1 walk cache entry"
>       },
>       {
> -        "PublicDescrition": "Data TLB translation cache hit on S2L0 walk cache entry",
> +        "PublicDescription": "Data TLB translation cache hit on S2L0 walk cache entry",
>           "EventCode": "0xd806",
>           "EventName": "MMU_D_TRANS_CACHE_HIT_S2L0_WALK",
>           "BriefDescription": "Data TLB translation cache hit on S2L0 walk cache entry"
>       },
>       {
> -        "PublicDescrition": "Data-side S1 page walk cache lookup",
> +        "PublicDescription": "Data-side S1 page walk cache lookup",
>           "EventCode": "0xd807",
>           "EventName": "MMU_D_S1_WALK_CACHE_LOOKUP",
>           "BriefDescription": "Data-side S1 page walk cache lookup"
>       },
>       {
> -        "PublicDescrition": "Data-side S1 page walk cache refill",
> +        "PublicDescription": "Data-side S1 page walk cache refill",
>           "EventCode": "0xd808",
>           "EventName": "MMU_D_S1_WALK_CACHE_REFILL",
>           "BriefDescription": "Data-side S1 page walk cache refill"
>       },
>       {
> -        "PublicDescrition": "Data-side S2 page walk cache lookup",
> +        "PublicDescription": "Data-side S2 page walk cache lookup",
>           "EventCode": "0xd809",
>           "EventName": "MMU_D_S2_WALK_CACHE_LOOKUP",
>           "BriefDescription": "Data-side S2 page walk cache lookup"
>       },
>       {
> -        "PublicDescrition": "Data-side S2 page walk cache refill",
> +        "PublicDescription": "Data-side S2 page walk cache refill",
>           "EventCode": "0xd80a",
>           "EventName": "MMU_D_S2_WALK_CACHE_REFILL",
>           "BriefDescription": "Data-side S2 page walk cache refill"
> @@ -90,61 +90,61 @@
>           "BriefDescription": "Level 2 instruction translation buffer allocation"
>       },
>       {
> -        "PublicDescrition": "Instruction TLB translation cache hit on S1L2 walk cache entry",
> +        "PublicDescription": "Instruction TLB translation cache hit on S1L2 walk cache entry",
>           "EventCode": "0xd901",
>           "EventName": "MMU_I_TRANS_CACHE_HIT_S1L2_WALK",
>           "BriefDescription": "Instruction TLB translation cache hit on S1L2 walk cache entry"
>       },
>       {
> -        "PublicDescrition": "Instruction TLB translation cache hit on S1L1 walk cache entry",
> +        "PublicDescription": "Instruction TLB translation cache hit on S1L1 walk cache entry",
>           "EventCode": "0xd902",
>           "EventName": "MMU_I_TRANS_CACHE_HIT_S1L1_WALK",
>           "BriefDescription": "Instruction TLB translation cache hit on S1L1 walk cache entry"
>       },
>       {
> -        "PublicDescrition": "Instruction TLB translation cache hit on S1L0 walk cache entry",
> +        "PublicDescription": "Instruction TLB translation cache hit on S1L0 walk cache entry",
>           "EventCode": "0xd903",
>           "EventName": "MMU_I_TRANS_CACHE_HIT_S1L0_WALK",
>           "BriefDescription": "Instruction TLB translation cache hit on S1L0 walk cache entry"
>       },
>       {
> -        "PublicDescrition": "Instruction TLB translation cache hit on S2L2 walk cache entry",
> +        "PublicDescription": "Instruction TLB translation cache hit on S2L2 walk cache entry",
>           "EventCode": "0xd904",
>           "EventName": "MMU_I_TRANS_CACHE_HIT_S2L2_WALK",
>           "BriefDescription": "Instruction TLB translation cache hit on S2L2 walk cache entry"
>       },
>       {
> -        "PublicDescrition": "Instruction TLB translation cache hit on S2L1 walk cache entry",
> +        "PublicDescription": "Instruction TLB translation cache hit on S2L1 walk cache entry",
>           "EventCode": "0xd905",
>           "EventName": "MMU_I_TRANS_CACHE_HIT_S2L1_WALK",
>           "BriefDescription": "Instruction TLB translation cache hit on S2L1 walk cache entry"
>       },
>       {
> -        "PublicDescrition": "Instruction TLB translation cache hit on S2L0 walk cache entry",
> +        "PublicDescription": "Instruction TLB translation cache hit on S2L0 walk cache entry",
>           "EventCode": "0xd906",
>           "EventName": "MMU_I_TRANS_CACHE_HIT_S2L0_WALK",
>           "BriefDescription": "Instruction TLB translation cache hit on S2L0 walk cache entry"
>       },
>       {
> -        "PublicDescrition": "Instruction-side S1 page walk cache lookup",
> +        "PublicDescription": "Instruction-side S1 page walk cache lookup",
>           "EventCode": "0xd907",
>           "EventName": "MMU_I_S1_WALK_CACHE_LOOKUP",
>           "BriefDescription": "Instruction-side S1 page walk cache lookup"
>       },
>       {
> -        "PublicDescrition": "Instruction-side S1 page walk cache refill",
> +        "PublicDescription": "Instruction-side S1 page walk cache refill",
>           "EventCode": "0xd908",
>           "EventName": "MMU_I_S1_WALK_CACHE_REFILL",
>           "BriefDescription": "Instruction-side S1 page walk cache refill"
>       },
>       {
> -        "PublicDescrition": "Instruction-side S2 page walk cache lookup",
> +        "PublicDescription": "Instruction-side S2 page walk cache lookup",
>           "EventCode": "0xd909",
>           "EventName": "MMU_I_S2_WALK_CACHE_LOOKUP",
>           "BriefDescription": "Instruction-side S2 page walk cache lookup"
>       },
>       {
> -        "PublicDescrition": "Instruction-side S2 page walk cache refill",
> +        "PublicDescription": "Instruction-side S2 page walk cache refill",
>           "EventCode": "0xd90a",
>           "EventName": "MMU_I_S2_WALK_CACHE_REFILL",
>           "BriefDescription": "Instruction-side S2 page walk cache refill"
> 
> base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd

