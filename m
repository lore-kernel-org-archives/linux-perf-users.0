Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2206A32AAD8
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Dec 2025 10:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765795947; cv=none; b=LpfT5FoTQl+NRT75YjDgPKp+oLgWtbmQQkEqzmRvwlBdLrZcd2Ov0Hhk6CTT6zF4egqEp2Chm4Z5f6vs7YM/WP4DBE+FpK2XjkiKwG0otJ1dZcS9h+KryIo59liIrbCKGqxX0ZSDwiS5xD+Bon2Q8zno6tNORBq2O/HlhjLQUj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765795947; c=relaxed/simple;
	bh=xujxCawMTAHmJS8Ufc31dlg08X09Krdkv2QQufxccoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZolBaFRvlSouBYC3prhlnpZCxxCoOHSRWn9xMd31ONL1NzeNnkBKsWd0IbMaK/cfiMG6Cg4KROzwZwjvd0BtljBeUt/s2tv2D54K/rjxsVdd+3JhhFNfE8Shm4bGZMgTLq7zz9LDOaj9trFS0zi+5qCBEHlRtCir7y+zr8SUZKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OsbCztKg; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OsbCztKg"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-430ff148844so266126f8f.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Dec 2025 02:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765795942; x=1766400742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nB+RBJ6RX6T3WRpIftetkYqL3dVBw+OmqN032iLl9fI=;
        b=OsbCztKgW17DKsmvCdBkn4+en+bcpIGk6sbC+/LqsEf9/58O1y1tT07PafyF8okxk0
         rug4WhE6vY4VtWgyJNrMpHn9IqpLpJW9BuGE62Jm8AlYwPzixoUQhxCQQWuBqnJWBWme
         Im9qy6XXYXHWGuh5KGazfGrh5yATei+v7fn7AtTchYe6asgGy8X2xtYHOuvxFOqGFgW8
         o8PP86T001713mnauYPf2FRQb3NKoeEQgesfyCzs63KEjE+zrxOW3kINU090/KxSCWl0
         tVCbqFc0I6Z0D39pmlhJpF5T8jrbCLc/jOzwXWrLsd2j/ZjCM1XYtGkjD+4vTePWGs+a
         isYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765795942; x=1766400742;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nB+RBJ6RX6T3WRpIftetkYqL3dVBw+OmqN032iLl9fI=;
        b=P8ChH/Y3chI0IK3N6KDS7PqJ9ECewzJuKHvqpC/DdPOMSAuEvWS8GhbGIDxMFL8L19
         AlU3QqOl2Q+9rRRyPa5pHUTcWAF8An5BbQxBKmA8muWJLkYH1JNYItHv5j6wboNVswm8
         /AsE9hTx0PKwLmEWfbqvblVLoYoak464ljtkufVOVDZTwUUFQXYn3dR0n9ciZAsKR39I
         dMTkTCosGmBfdMpkHkIBKm4t4g+hkL6Byl5OU7wlKbcvBWTYB/Y1/S/SriCEwpxIohoS
         frhEoUhIF/jFLAymmteZWpRT7oB7WXEZsX7s7hWQbpvzW7G5Ll3ZThH+dK0jTAC0IbLy
         WSKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkQj9Jzt/lnTIVHCFRT+OGBdNQzklalTyKdq8MnXl2ywluVwJXEekl5fM0tOTCC1eOzZNJFGKewtvPL9d7JOk6@vger.kernel.org
X-Gm-Message-State: AOJu0YznkWGUqYGoqUyq4eyZ8zjnWUS6rTGA9gEFv8ibNweJ/9+X3h7U
	9EQv/CZcP0t024B0Vv1/INKvbi/J1YYgJM3q4nyeFMKX1060M6Woxxqo5Zev9dkSe4+eXGnwNnO
	7lx7H3gsZuXea
X-Gm-Gg: AY/fxX5Xs72pp7oZgmGVLWVXJKwD6wxBAVUlPHDhr4Yz56dWXLCI0aj+Cxn/vx4T2Fw
	KZOm67tD/6zm7gSsSYsdgclw6erHISuvf0xzR60FhBA5nmChSAXfVIlolkUgnxs3XHZa3xWJ/ad
	+OJD1/S7rZ6vqP+e7qTWCUrXWS0ufEcdeHajGKha16WXtLdlHf1t32WkD2teGCrYZChjesHHi8n
	jTRN+BtM1bMzz6auPSG/LgsZLxV9TsHmAM3bTQizIkQDwjesX0miZgc50uYL1G5EqWNKuvTtH0Y
	DVghf+2B8Nd4+aKI8HhT8LLhC5NfArEurVnpVtb1QflqPn3sJkEAg+AUfWhYXM4kbPWD1/hqbR+
	V8cpUwtDwFKxGQ5O9FwcgreZtk3IFkBVCImtBhi84SnlmeeN3ww2d5IwLvrQsn9qrTrCBYoAv0c
	4JZC2Zja0KbGRdmTMQopOM
X-Google-Smtp-Source: AGHT+IHIejLZ8yFwsZwEEzCINtAT3WHk822OpusGi4A5ihMbhmK9XmClAvJ/IZaC+/ow4gbl8lRFxw==
X-Received: by 2002:a05:6000:2410:b0:42b:2eb3:c92a with SMTP id ffacd0b85a97d-42fb3e65c54mr12756034f8f.12.1765795941787;
        Mon, 15 Dec 2025 02:52:21 -0800 (PST)
Received: from [192.168.0.108] ([130.185.218.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fbab2d3b6sm18412955f8f.23.2025.12.15.02.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 02:52:21 -0800 (PST)
Message-ID: <bda366b4-fa53-4feb-a7ce-ee47cfc404b5@linaro.org>
Date: Mon, 15 Dec 2025 12:52:24 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: perf: fix syscalltbl path base
To: Arnd Bergmann <arnd@arndb.de>, Joel May <joel-linux@jmay.us>,
 Leo Yan <leo.yan@arm.com>, Ian Rogers <irogers@google.com>
Cc: linux-arm-kernel@lists.infradead.org,
 Linux perf Profiling <linux-perf-users@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
References: <b2651f20-6f3a-49f5-9cd8-3fb028b2cab5@app.fastmail.com>
 <fcefc3c0-541d-40cc-84e3-9c2460308bdb@linaro.org>
 <23c07ac4-ff13-47a5-824a-e7af1d1847a3@app.fastmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <23c07ac4-ff13-47a5-824a-e7af1d1847a3@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/12/2025 11:33, Arnd Bergmann wrote:
> On Mon, Dec 15, 2025, at 09:47, James Clark wrote:
>> On 15/12/2025 00:12, Joel May wrote:
>>
>> Hi Joel,
>>
>> There is a similar fix on the list here:
>>
>> https://lore.kernel.org/linux-perf-users/20251204-perf_fix_syscall_header-v1-1-b8e27f74ed6a@arm.com/
>>
>> I'm not sure if commit 1 alone will also fix your issue, or we'd need to
>> collapse both of the commits in that set.
>>
>> The first commit has an older fixes: tag and also fixes some other
>> issues so it might be better to take that one rather than this one.
> 
> I don't understand that other "fix", doesn't that just work around
> the arm64 build issue by adding another special case for arm64?
> 
> If we want the tools directory to have a copy of the generated unistd.h
> files instead of generating them, it should at the minimum be done
> the same across all architectures.
> 
>      Arnd

I don't think it's a special case, the other architectures already have 
a copy of their syscall headers in tools/ don't they?

My original commit that is reverted by Leo's patches is more of a "fix" 
than his fix. It turned out that running the generator script for the 
Perf build wasn't the best idea after all. Now it's obvious that we'd 
have to keep injecting that build rule into every tool that needs it. 
And it doesn't even respect this rule described here that tools headers 
should be decoupled from the kernel sources:

  linux/tools/include/uapi/README

I don't see the benefit of manually copying over the generator script 
and its input file and then updating every build rule to invoke it when 
we can manually copy over the output of that script and not have to do 
anything else.

Ian makes the point that we can run the generator for doing 
check_headers.sh. But at least that only needs to be done for one tool 
and can be in addition to the manual copy.

James

