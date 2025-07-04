Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1212C08CD
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Jul 2025 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751627459; cv=none; b=VTTre5XDJG7VEmE6ygahQXL+wjV8xB4p405nAV2qQkXUleMTD1FjFgopCZP9JuS2qLDH8NYheWaIQbaSFQPV4xRxNFxUVQvLEaIl0aGUPcFx99SePx7XbZFnhKxkITHTS05eJrcF317gfldCpxwh0phQBit0GByqc5oGENNmLjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751627459; c=relaxed/simple;
	bh=SF8CYPTrOdy+j7O2eI2p8/yS2Z2CtPaSi47s5TwJido=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G1RyGhc6oibMorZK6jMTdUIr09O+RpG/lLi8umpyJbIrliKJq7fShC2I7J4ldgQkwajJzgLjz/WvaOiKI0afvpC0PyzEJZDhR8bNyMXyeYuAYFXx3/JYbAbwwdcfPmW9Zl1YmbUk8+9xIuOvHhMgIoBHwIYOyl/9iZ6RJnOzl3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YxwURsWn; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YxwURsWn"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a6d1369d4eso426697f8f.2
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Jul 2025 04:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751627456; x=1752232256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dCPtwnOfQ6keZPy4LpTxW8EywDH7gbIh/lGbQNpkD4Y=;
        b=YxwURsWnXvzS80Tvw6J8p4Uq6DszfCS6+xdZA89QQ1/TyYml1nIsJREUoC+6SUOfGg
         xqZ6DRB3xWd2NlLfqE8QkVgySf2IAA5Z2h8RTaD2FKmM2TYmgjimTv8H8R9lvGt3uInP
         CbQIZNY3PMZsepzJtTU4HAIKnLcNSyqu8WwgYqE3yfNmc053ZUOT7+EbG/Pcf9wuMr4R
         75hqNGEHlv2VK6QvPSt+KfCacSWYSHYiyTqKF+UO319gdZL6ZRhuwZFoiigCa7VE1y78
         TnCJCL5Ys6DWICz3cPMaVWQ0TcgpvBYSv04rkGGXV5bYmE9CcWVkplEIPea8JNJyzUNm
         kjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751627456; x=1752232256;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dCPtwnOfQ6keZPy4LpTxW8EywDH7gbIh/lGbQNpkD4Y=;
        b=fmicsIlkc8ELijY6LRw/PUa/Q0R3zU3nToOxUWqeevZfJZuWNiUksQ63oaJ9NPN4Hj
         MKKSJH1QAAIbLy8dr6znRzp+E1MO9kuuhNPRiaJ/pn473ReGyPu8+IbUUrNHCcaHNjI7
         LXt8a0vG105yjqbSw1w99kTYOcDMr1wv/ezyPyXQSass7sxHu4u9ISEvch1iG7IXcArh
         bX+uIdZg3UTtO0ds8HFyoNBcchD/7r95nkq/WZ+JdRvqrEOIWVkx4KsFHx5AwcUCBybW
         dwI8T7eoUmM3QeEv5dkNdWE/EaZWiQNdF0AMCbfNV0g2OgWoUrL/032vpPKPnNAZN4al
         gxCw==
X-Forwarded-Encrypted: i=1; AJvYcCWooSCB3wx2EUwTyZVYUPkT5yVht9xDdzF7imA6LFh66abpgqfGTBhoqV+MbdmLl0HrWSpakzhOdHJljm05l/GN@vger.kernel.org
X-Gm-Message-State: AOJu0YyT2h6m4jGVROp/DOZBU5DTyNg/Ie1A75WF4k8CZTnMxgxxsIEp
	I8Ia6V3h2cWZTOgzTnPS/0pmwBE9SFGlfSS8gPXB9oOcJJHJopAkfiUDhwb+lOPz0UU=
X-Gm-Gg: ASbGnctb/cBtm++cIhrkvY0aJ4N0TdCqfry9D3DqvOoVVbh5tSEekX4/gxICa4r7gSO
	iUEP6xyE5zzyQ4BFDJwnf1QIiBNkQkKY8yPfXMvNeK7Y4SbaRI2OL1FrhWMdhTlCPhe/sHpbOoD
	hewHZQrZUdBHoEU2O2dMi0X9hNi71h0oviVoKCBB3E0rrmzwgHnDs+wpWZBH+lZ7ZWBEJFjoAQI
	ngUMGxNwB2s//9fsQYlbGMJN0FL14cniIDFlrA/a40DF9mKfMQ5fTkjWKxP48iztKruwC/IIuox
	JJHiVoT4gvNzn4OqKKp/p7oOtP80sMZPR8VqRp3a6QTO4MgpTKo5/FZK9qJuAt5c2dw=
X-Google-Smtp-Source: AGHT+IFUrRT4OwH5hTE+/EwaS0JQstvht/Nvd/yC+ncXVq5jOgWUtrHO2HEpZmkTrSJj963GBPh1Hw==
X-Received: by 2002:a05:6000:26ca:b0:3a5:1410:71c0 with SMTP id ffacd0b85a97d-3b4965fa43dmr1629767f8f.38.1751627455547;
        Fri, 04 Jul 2025 04:10:55 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b471b97732sm2265248f8f.59.2025.07.04.04.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 04:10:55 -0700 (PDT)
Message-ID: <9c59d1b1-a483-49d9-b57a-c86e3e020234@linaro.org>
Date: Fri, 4 Jul 2025 12:10:53 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86: Replace strncpy() with memcpy() for vendor
 string
To: David Laight <david.laight.linux@gmail.com>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
References: <20250618215843.109941-1-usmanakinyemi202@gmail.com>
 <20250704102007.6354ce9f@pumpkin>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250704102007.6354ce9f@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/07/2025 10:20 am, David Laight wrote:
> On Thu, 19 Jun 2025 03:28:43 +0530
> Usman Akinyemi <usmanakinyemi202@gmail.com> wrote:
> 
>> strncpy() is unsafe for fixed-size binary data as
>> it may not NUL-terminate and is deprecated for such

But memcpy doesn't null terminate after the 4 chars either so I don't 
think that's a good justification. Surely you don't want null 
termination, because char *vendor is supposed to be a single string 
without extra nulls in the middle. It specifically adds a null at the 
end of the function.

>> usage. Since we're copying raw CPUID register values,
>> memcpy() is the correct and safe choice.
>>

There should be a fixes: tag here if it actually fixes something. But in 
this use case strncpy seems to behave identically to memcpy so I don't 
think we should change it. Except maybe if b,c,d have NULLs in them then 
strncpy will give you uninitialized parts where memcpy won't. But that's 
not mentioned in the commit message and presumably it doesn't happen?

>> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
>> ---
>>   tools/perf/arch/x86/util/header.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86/util/header.c
>> index 412977f8aa83..43ba55627817 100644
>> --- a/tools/perf/arch/x86/util/header.c
>> +++ b/tools/perf/arch/x86/util/header.c
>> @@ -16,9 +16,9 @@ void get_cpuid_0(char *vendor, unsigned int *lvl)
>>   	unsigned int b, c, d;
>>   
>>   	cpuid(0, 0, lvl, &b, &c, &d);
>> -	strncpy(&vendor[0], (char *)(&b), 4);
>> -	strncpy(&vendor[4], (char *)(&d), 4);
>> -	strncpy(&vendor[8], (char *)(&c), 4);
>> +	memcpy(&vendor[0], (char *)(&b), 4);
>> +	memcpy(&vendor[4], (char *)(&d), 4);
>> +	memcpy(&vendor[8], (char *)(&c), 4);
> 
> Why not:
> 	cpuid(0, 0, lvl, (void *)vendor, (void *)(vendor + 8), (void *)(vendor + 4));
> 
> 
>>   	vendor[12] = '\0';
>>   }
>>   
> 

