Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D5E27F724
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Apr 2025 09:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744708450; cv=none; b=ab7WlrH9U/WWWroEZb/emZuMWsHHFRE63RGoK2y75NqRg0lruHduxfvUaV3EER4el+fA6HebhzX5yA1rdMk4JbbZ/S/0CWGt1zHCYdjCeZZnlNt3YM9jF4YMR1zeAdV7V5N7syoDFT8ab9TPwiC+elr6dAgVJjH/X6sV6QSXYaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744708450; c=relaxed/simple;
	bh=xJd/4b5bhY+n+QZLhZcR9CAG7yTmRPKvPTAhgwEa3PY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JDrxOdInNu2C4gul5ttj408nS/fVIaIBdHzj6NTRURzoGiWMn2k2iqYOvIjMqELu3XAnBmaJGnleHpjcURdaL+Obhr4k2M73bZSyUcGoWD+POWO4RU0X388Lm4xUnh/u32+mWy3IaqDe0mJO8Olyt+L1cj+vBKofuRJ0uZ8eoTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LqAyjc4p; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LqAyjc4p"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cfe574976so36234645e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Apr 2025 02:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744708446; x=1745313246; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7sZcT0Yr0/41RO7Ihzkb4EBq+VMI1W841HKAaxgJwa8=;
        b=LqAyjc4puzL5nBssemk06CzpmHkRQiZEgl88oewyrNr8GWTNYiOEBGflSrRt4mb4sn
         bLzL3BZV971qBiZS5CamRieVEyXMNxiCaprJ3M2PLt/67ClG/vqYOjnTmVX2yuE4k2px
         UE1CYVznKW141pfz0+qLSjevo6itnbapuGjQy+YTqgyI3KLmKR6E83jHiQTbP0TXokFu
         xDRKnhcSPx9s5ktn4VXiZzXdrmdU/+Hu277HaLj7V2XljLUb4unOqz3AF0a6vrubhYiJ
         NChj4JAsIhVIBE5Zh6bYayPW81LsDZHZksRu0UUbszUyEpioO9Hh98uwjsZB5aw/hYss
         B6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744708446; x=1745313246;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7sZcT0Yr0/41RO7Ihzkb4EBq+VMI1W841HKAaxgJwa8=;
        b=ZZFUvl5zNF7JXKMoXSpZuevXAenfu2AeW0dgmDrFZr6Nx8ZtQX2ihWKAr6LsJFIfHE
         Cd+dLO31g1Q+jeEHl4AJ4LhIQbu+PiEpBsE+FBCF2mT0fWfXTP1VcEcCM0Vnh2SxgYkG
         7vvXEpj/a8ngTK9QbG4LUM3sjiCK9H75i2EZpIcrEF4b3J9rmjBRKgkLcODtLv0WI6Vf
         4g89G7B0O8+Fdrlw6PvMT4unp6erAw3RMXtstIIowM8PNmRjU8g9U9V/xpWAHyOkAAaK
         caEzMf9E0fCx0YVrpyHtBqiOdec+dciN/0ZY0JMNiSiS/iTD2l1GEZNV/ydR/9y0pS74
         0UIw==
X-Forwarded-Encrypted: i=1; AJvYcCUhN8I68Ve+VyGflCGdkaVXpnhwSnYcfZk3itgzJ5qx53C56pZocX6lIwcGI+SCq2kaiIOpXZSm/FR2JaG7rhNc@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj6Yb5K/xlHjrtbj81SA16/HcYHXG1IYdfC8ETL53BD/yAPJhM
	dU0HYLpOLCTO7WiHzHqfQPTWjwRfPGmiwVS8K9GUh868uF4M2DYELGsijWyZdYI=
X-Gm-Gg: ASbGncvkN+jNLn/NIAPVRyIcdicd1AwSQV7GK04c9lwKwE2A4VnrEKJNslvSQrIxETx
	BpC+HPizQNcK1FrlEcR5aueykDis04oBQfWqXKBvepbFlAvbwirUHzHDH/0dGmaKjPgy2PuY2SQ
	bSihLQvZOaMVWZOGn21YImBWPYOSNi+sxgebwwIaEiYGuNiWR/a3Cp6B/gM7N+rGxFOB6zMEnnT
	RDJH1LWEPgn5v1gcGFfGErhFiqSJC/iWsmwPSfy2V7vOGb0qde5x/t7FSMquBiyN4oaTxDOUKtW
	VyJ2XXLh3Fp66TU5coLD2OUQx+mw5XVhNvPjKDuCVF8=
X-Google-Smtp-Source: AGHT+IFIPck0/EXs55Sp/jmilaWHfYYKBCqyBfvSyEux/z5dVtEkS0FpAt5aWShFY0ittLuuU/tdIw==
X-Received: by 2002:a05:6000:220f:b0:391:3157:7717 with SMTP id ffacd0b85a97d-39eaaeaa3d5mr13405746f8f.34.1744708446594;
        Tue, 15 Apr 2025 02:14:06 -0700 (PDT)
Received: from [192.168.1.3] ([77.81.75.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae96c614sm13775004f8f.27.2025.04.15.02.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 02:14:06 -0700 (PDT)
Message-ID: <5bc5f54b-ce6a-4834-86d4-5014d44c7217@linaro.org>
Date: Tue, 15 Apr 2025 10:14:05 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip:perf/core] [perf] da916e96e2:
 BUG:KASAN:null-ptr-deref_in_put_event
To: Oliver Sang <oliver.sang@intel.com>, Peter Zijlstra <peterz@infradead.org>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 x86@kernel.org, Ravi Bangoria <ravi.bangoria@amd.com>,
 linux-perf-users@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
References: <202504131701.941039cd-lkp@intel.com>
 <20250414190138.GB13096@noisy.programming.kicks-ass.net>
 <Z/3krxHJLaWJTj4R@xsang-OptiPlex-9020>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <Z/3krxHJLaWJTj4R@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/04/2025 5:46 am, Oliver Sang wrote:
> hi, Peter Zijlstra,
> 
> On Mon, Apr 14, 2025 at 09:01:38PM +0200, Peter Zijlstra wrote:
>> On Mon, Apr 14, 2025 at 09:59:25AM +0800, kernel test robot wrote:
>>>
>>>
>>> Hello,
>>>
>>> kernel test robot noticed "BUG:KASAN:null-ptr-deref_in_put_event" on:
>>>
>>> commit: da916e96e2dedcb2d40de77a7def833d315b81a6 ("perf: Make perf_pmu_unregister() useable")
>>> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git perf/core
>>>
>>> [test failed on linux-next/master 29e7bf01ed8033c9a14ed0dc990dfe2736dbcd18]
>>>
>>> in testcase: trinity
>>> version: trinity-x86_64-ba2360ed-1_20241228
>>> with following parameters:
>>>
>>> 	runtime: 300s
>>> 	group: group-02
>>> 	nr_groups: 5
>>>
>>>
>>>
>>> config: x86_64-randconfig-078-20250407
>>> compiler: clang-20
>>> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>>>
>>> (please refer to attached dmesg/kmsg for entire log/backtrace)
>>>
>>>
>>>
>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <oliver.sang@intel.com>
>>> | Closes: https://lore.kernel.org/oe-lkp/202504131701.941039cd-lkp@intel.com
>>>
>>
>> Does this help?
> 
> yes, below patch fixes the issues we observed for da916e96e2. thanks
> 
> Tested-by: kernel test robot <oliver.sang@intel.com>
> 

Also fixes the same issues we were seeing:

Tested-by: James Clark <james.clark@linaro.org>

>>
>> ---
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 2eb9cd5d86a1..528b679aaf7e 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -5687,7 +5687,7 @@ static void put_event(struct perf_event *event)
>>   	_free_event(event);
>>   
>>   	/* Matches the refcount bump in inherit_event() */
>> -	if (parent)
>> +	if (parent && parent != EVENT_TOMBSTONE)
>>   		put_event(parent);
>>   }
>>   
> 

