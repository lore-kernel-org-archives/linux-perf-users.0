Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7622B377EC3
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Apr 2026 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123392; cv=none; b=ArJKnh3lle5qEUVasLPHvyDsaYYH7uFQxxIIIPyRlISciVQrEFhrO6lJEiK1FF9JYtQvrer1ZyNORyrG2xggkxaHkIZhzMW5hDdOcSzjkv9wqfT3xBgHjgJccksbNLdEJy0nvq6n0hwJII3COU39a+qJ425OTowbMX/N5GaCUKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123392; c=relaxed/simple;
	bh=nJvoCWu38hxxnKheIDRJrRL9Wcq5XBQkqaSCt/hgYvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NNd8tFTb4EckOf0k9ykIctOeKzQndhIK+E6iWXyQNFDO6zn9FDgf6at4FD//qeNTBfAKJjFQZhkkJdiBOSaN8ttkvS691UG1pj327e46QszSEKg0Dh0AnoD6THcgKksoaPRjJTDy9GlrDDHex4CzomGh1D6DMuLUQBE1XBOtC2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WnsfDuih; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WnsfDuih"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43b95e5b3afso403961f8f.3
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Apr 2026 02:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775123388; x=1775728188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rEH5WzWrgYk3Nyry0RXufGI5C4aPoskx4NXm70qvdmI=;
        b=WnsfDuihaYGATbi0l46ldZIQfaM4X+pNgJC2HO+4jFJkZwhaNjXpOBetNL/d2KWRnN
         JVwv+kzdQHeiuiXozmOfy4mWhppRUkxaon8XBGkSBXtNxo6uIVkl8uUZm/1GUlK30e6w
         +nA409ypcgseQPa/DBomaQDZHoUzw1CNpWWYX/arsF4fy/VnxaRsDZWhNriityndjm4a
         ePkX5poU4d+D4EeqqEfOKi9/6p3DYWtbGFbuqBE/3/FVIZiuHcWzDcZJ4ijVyZ/NMaDh
         Td3S7C80U3CzG2/Z5S5OthlqsKhgq1r5AkyVYmM5iLohzKexGol7TFIUyskHLuGBiMUy
         dTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775123388; x=1775728188;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEH5WzWrgYk3Nyry0RXufGI5C4aPoskx4NXm70qvdmI=;
        b=Oq2XfAUQHexABh9ZKjN4wIrylV6xra/uRumjmlRGHFgERNLmxjxkJJmfrDgEN1Z7qL
         4ilHUYwTxnQjVHO7fA+c/7Ial9bOpYcGzyc8kxpazuZiORb64/gC2xurjyOxbFBOoAdQ
         +3Ubc1PRZEAAnaRa0mXckUzJEo6G6Ztgx88qS9q81m9R+MPuhDDLji0QGtNlJM7QDw0G
         mB3HKUnCK2UikgCPWxIQx9Pf9trHwcHbbd7TfKBA1PSD9Ppy+TnPHQW1cvvbCXCzLbC+
         FHOHiA8F2AoQq3NTpi6xsNOocB6mevJO11pZEEUIeSK/8DFqwoWXMRxnEcDY1M0f4KPX
         /ynQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzkotLz6mNBpJQVmDxM2J3qaH4JI23Fr1V1k35pFNhUU1mdpIGQKnDjay5cJCF/BxEtNe9i7ihuzkiN0Xq7saW@vger.kernel.org
X-Gm-Message-State: AOJu0YzGlfihpV9yqd5U7IaAgAXcaOw8GsitKuYM6ctiPXqNBSn/Fgzl
	jpW5nL5gsnAUc9gpeK2CoRUNRTxF9kxVNeLoXJk7z+THUnM0weTyKG6DyzYMovhUlAk=
X-Gm-Gg: AeBDietqEC03+6acDNg+Cdxc7i0UBl2j4qcbJY2ebLdXi8kz18MhgLD1s+P00yA4xDI
	8a9cDeu4qSLyj5qkQEljLoCdAebVUZ5cuQ2SQQKPEDji5BGHx9KYwC7QSztnA/wGqyAtv/lz8Bh
	BwMVlJ/q9iDcN88AZ0R174CFQJOBSmY5FbISEMLzyLzNx9aeqeGWwN/g1QtdPgdq0K/oWqqa9NH
	lIk3LPTF+sBZ7bobkQgPeHguXm/AgKAH2urHz+mMQlxOBW4tT0L5y0IypCw/e10rkKm0zTZdf/d
	ktJm6vrCFKHo231vl8FpYKmCAj5jJToAveqjYMIvOItMOykK5scTlHKrkDyLe1yYbtxlaQ1zqNY
	atSKEYd07Hm1fOMGDPF/CKR12BbZkA91I1bQVAboYwr4NOgvjuZTBmdyxLkyxAjB1L2zWth7NNb
	eFD0dfRtQmGRflavnVx6xd8701zcI3
X-Received: by 2002:adf:eac1:0:b0:43d:1c49:ce35 with SMTP id ffacd0b85a97d-43d1c49ce84mr6224854f8f.3.1775123387496;
        Thu, 02 Apr 2026 02:49:47 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f13sm6644433f8f.3.2026.04.02.02.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 02:49:47 -0700 (PDT)
Message-ID: <11fd32e8-07e1-4889-bd02-5eb38b7e1ed1@linaro.org>
Date: Thu, 2 Apr 2026 10:49:45 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] perf arm_spe: Decode Arm N1 IMPDEF events
To: Leo Yan <leo.yan@arm.com>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Al Grant <al.grant@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260401-james-spe-impdef-decode-v1-0-ad0d372c220c@linaro.org>
 <20260401-james-spe-impdef-decode-v1-3-ad0d372c220c@linaro.org>
 <20260402093234.GG356832@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260402093234.GG356832@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/04/2026 10:32 am, Leo Yan wrote:
> On Wed, Apr 01, 2026 at 03:25:51PM +0100, James Clark wrote:
> 
> [...]
> 
>>   static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
>> -				  char *buf, size_t buf_len)
>> +				  char *buf, size_t buf_len, u64 midr)
> 
> Just wandering if we can add a "midr" field into struct arm_spe_pkt ?
> Then we don't need to change many functions for populating midr.
> 
> The rest is good for me.
> 
> Thanks,
> Leo

Yeah I can do that. I was worried they were stored in an array and it 
would be a waste of space, but they're not so it's ok.

