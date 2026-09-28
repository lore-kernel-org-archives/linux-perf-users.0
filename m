Received: from mail-ed2-f33.google.com (mail-ed2-f33.google.com [74.125.228.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB5F2DCC13
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790603529; cv=none; b=k2n8jEDK9okeBXgF4Qi1ad73iJiNWCYWBxtBDL07iMsVmEI+ygOox+A2NSYtcx/4oYSSGk3AwQEjPFX0HWDjqgv4/W4kGuQ+at94ogJP6llO9VGy6HeA/Q0cPAtCOVH0//ifDx7ugqGZ7K/NniV2sBvU/+9zbirPR4KO6OEVyWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790603529; c=relaxed/simple;
	bh=h9nhueiW90n/PQeZv1y1n3cikpJCagd1jp/6ZlWFcBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UtEGpF+d1PulmBzpLiClZRlPLenWAr/8b60qhIAG+JaTbUOeIp5Xka5yU0ct3DR5a3Jw+i14r3YEnrUycSb9RWTmb1elSgwfn4ovsPzVwJ9bUaVdrfYhFnCtKqEwfszaBRg6k3n3MzXswx6PhDQP/Dl1HVDutSnkVsZKhQENiw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A150Iwbo; arc=none smtp.client-ip=74.125.228.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A150Iwbo"
Received: by mail-ed2-f33.google.com with SMTP id 4fb4d7f45d1cf-6ac62c88c7cso2647631a12.0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 06:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790603525; x=1791208325; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l4Wj4baECg7d15XvpDd5zrHb67qSLbXRWYAn4x6e368=;
        b=A150Iwbo2tFLqNR91CwrGuMs1Txsm0dgch3PlDvZXlMKCaUp7hGMkBGp2whOXTbPOW
         r7ZXgwBg1Z14dOJu4EFgPRmmbnRpzirtiu6vr1jy40V6pOcvWRSFqHNKl+C9LpxFhK1O
         HGhKkEx4lLZTAEMl71bKfppNZSrSCQorjk+P85Hz1OrdhvQ0iphaPhta02DGIgQH6wiX
         xV3sczBExnpvdOpIx/JQSeh3VQuCvLGKsJ9V/ILvyrhKvuSAZdsBGXkojjfqwNCTAcru
         2PByzPs/dfVPm35N5Cy3hy1XFVuaQrPYEgq32x1TB/WSVjLsI9VkhqHgaQkAifgepRsT
         bMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790603525; x=1791208325;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l4Wj4baECg7d15XvpDd5zrHb67qSLbXRWYAn4x6e368=;
        b=Z7Rk7VdITXwzazkOKnAevO5+hWvF9G4mKQlGWbq6Ei21MWQLDINHj9IHboCIj41Whn
         bUmZOLOcfMz8zJoJdy0tCyNJ7BRssnCwHlIReTEmWQD0RVIviPe2spy5sKeHeetietAd
         QcwEHTff6K7EYotRQ2ExLf4s3izGIldreVyvwgcq6/ulYnDDObosKYEDkHo64Ch8HtWx
         BRL2mATyNiIFB46mmg+3NPP6fNswCy3Yjdj5Bil4xK0XUC7XL4kPRYVh6PQ+zGM/iryK
         S09eW5hxrG/MGlfTlIgO0ivUlqQ//AhuLi/uYZL48AxnlaMDMO857bDTlyqko4qjdtGJ
         CtdA==
X-Forwarded-Encrypted: i=1; AKwUvByvWFxwvSEk7J5GdLJEsehkNulPh6Kl4oT+ab512wsBMB3TWBlnnyl/6SPvoCiHAD49It+/HdzGZYCWY89hhVvP@vger.kernel.org
X-Gm-Message-State: AFq9FYJd6sTrp4RGrslf2Bqth4huioCbWfkRaCBUBfKePVfaMDROZGgb
	makCPVke8tImhF4Cu15MrPxVFX9fxeQv5hZBpQTzS1D2AF/HjJoUk3jUHmHfLtQ4QWiojSWPV6A
	G9TVSF18=
X-Gm-Gg: AYBFou2ueEownKKnet3fnB+6je1Rt1Cc0k7dJorlxOSA41WTHOuIJ7C1F6N6KPu2SsP
	8bWBgLSsLmMlWpTgKXPj4RfN0NPh+S8k+c03BtirxAkOfInrMz7eZ0gv/Xy3Qcu74sykCpMLW4d
	gUjXLWStJu8VCAC300XwZQOke1QsJzmviVVZEg7SAaA4cfaGRTf/jbzljy/uQnhIE36XN2iyKRw
	KRjoHYT3VP32y1EZF4tUTw+IaRKAqPtaxLL1KEb8f5qOXGrDi+9jCb/hGo72lZrPBUclRZEjJPV
	tJP5kKC9mgc2TflAPcsRqcB0KoF99+rumWGzXHT3zmnRIFiykFdSuvdTT0HG2VyXEvzbOEloJ3M
	dWnkiKeB45HMXH+72JF50QLrpNY5LkjntbXjsvcJ+lC/q/wxWaj6NAh/n7wCzQfBzF1MTb7xcKP
	CzXltxVRYKVV25oKDBHYArw6+33Ft7o8yikfLX41p/yCwfxKFWws3ONgghsxzoX1NGt19Z93ViY
	KY=
X-Received: by 2002:a17:907:d14:b0:c29:c07f:c0c8 with SMTP id a640c23a62f3a-c2ae979eef6mr776208966b.3.1790603525476;
        Mon, 28 Sep 2026 06:52:05 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dbd3bcadbsm285069566b.72.2026.09.28.06.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 06:52:05 -0700 (PDT)
Message-ID: <79e7cb39-b4af-4ac9-b72b-b01872603cff@linaro.org>
Date: Mon, 28 Sep 2026 14:52:04 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf python: Fix arm-cs-trace-disasm type error
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260928-james-perf-mypy-cs-disasm-v1-1-1bda909475ce@linaro.org>
 <20260928134642.GE14479@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260928134642.GE14479@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/09/2026 14:46, Leo Yan wrote:
> On Mon, Sep 28, 2026 at 01:58:09PM +0100, James Clark wrote:
>> The perf sample dso_bid getter returns a string or None, matching its
>> Optional[str] annotation. Attempting to decode it as bytes causes mypy
>> to report union-attr errors, even though this was behind a conditional
>> that checked for bytes type.
>>
>> Use the string directly, retaining the fallback for an unknown build ID.
>>
>> This fixes the following build error:
>>
>>    python/arm-cs-trace-disasm.py:266: error: Item "None" of "str | None" has no attribute "decode"  [union-attr]
>>
>> Fixes: 279b402e5143 ("perf python: Port arm-cs-trace-disasm to perf module")
>> Assisted-by: Codex:GPT-6-Astra
>> Signed-off-by: James Clark <james.clark@linaro.org>
> 
> Thanks for the fix:
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> 
> Just curious, have you run this script and compare the result with old
> one? Seems to me, the build pass is insufficient, we should run a small
> test to ensure the result to keep same.
> 
> Thanks,
> Leo

Yep the test still passes. I assume the "if isinstance(sample.dso_bid, 
bytes)" part was just dead code.


