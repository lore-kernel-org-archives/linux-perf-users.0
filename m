Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B264830FF37
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766397949; cv=none; b=qj3AMzQwxfu532c+l+QiSYqRXJWdVqUpIiGXD7+zNQVuk/5QHOEfvP82iExx9Pq/EeEkjAepSEjvofK/rImcytqh7sGyWeH0SXVTX/njIQ8YaawvFQHZvjNyELn9S9lGKgfkFjw16Vy+M+vobayXtwwlNDwAkd5JMutaWncgOCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766397949; c=relaxed/simple;
	bh=8Wmh5WMlcaJle+L3aRw0OP2RpUfURXUMuj0z81GpBdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QgxYEoIouTvYDeBzfX50TOshapb33BzK0dXLiULJvLoALl81tqVpWd/+nbo2MhZCQvBClSoHKPs7G2Be+sPwH0d5i0fSmZsWdQ0ISbbHySNBsbGnGUYIl9xJcAqUJyQt6mItboyu/qZqLM1MC93IlC/351GWlZrmoiSfTHEMeKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vudyyQRo; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vudyyQRo"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47aa03d3326so23192135e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 02:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766397946; x=1767002746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kl5uFcJ0GrtpgcNBs+UKKjQLDugjInQyaq10Ea+44qo=;
        b=vudyyQRoVoAeG234WWSAlWnScDUk20ofR7L8/x9Z1nG/YkwsUIz9dzC/YheKDn9rxo
         knrAl/hQcos9ryS/SpZvWASn/g+dUFfrfwu6bJh2El51Rzl+8FwedZQf0EbWw2In06eQ
         0VHc6BaehM8HislS3BrNwnViOox1kU0pEr8GkLLdiV+PyGVmCjwC7f56VnuSA9DbzpfN
         A0dsqZLNsb0W+VtIhphI7L4mTX8DLvF3Xf7X3WM8fP8QDLm1XNR4e7Vedp9Um5b3vvir
         z2eHhuL6ddre0PSUHWafRw3sZAi87yCI0ANleLsJl6ik1LIzYrgdko9p3zdI3lObxA67
         subg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766397946; x=1767002746;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kl5uFcJ0GrtpgcNBs+UKKjQLDugjInQyaq10Ea+44qo=;
        b=Ms4Qh7f/0YWtk1xb0uZNoY5XjOJ4YQJ/wUFz1pj5FoZUfzTIm6lZ12/aiqQLwCWNPd
         J7dPQGC675VrNR48zzKBP9tfXowkI8EDgTuJHc8S8v/bL3VNLT93bzOgMf1CzWvgW6jZ
         1RMpPNQjIYSfBsqb9roe+jbZCrGOUjFsJnp0CoW1js4Sn50mrIWh6iGn23UNlLnd8vkG
         HASoZV8A4i2n2wEIZuTbbx+YH10uZGPOYCTx2GYS5whdt23BdbnCiQTrRXD193dwawz2
         KlHYyGtDm7txz4155Q2tHNq1MBtiHhzer3yBihQM3RgV85BHMdum2y+0z8gxNAghk1ll
         yM5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1iOIdwbVqW98E5xpQMjf6qPFR9h0WuTlrKKOUh/fJwkAk0xILArwofm19LpmdxOWgK5NW47hbJraReZSll7+P@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd3pZfe7SnsB33wo13Nvg+yigikWOdtfdy2XvArSKQZRrkFLyn
	ztOdGG3p6L6bNf9IrPz1AjUgx8Bbz6Z4g81YF620ILWCDUkyqffyFyYcb8qqYUNkyhk=
X-Gm-Gg: AY/fxX7FuVTuIOt3Uebmas3uPfQNE157K8KWSVZemQBhK5LODmU93BYR8AR1l83lGg0
	T92obJIiUzb3W2VjJaK+NwV9YiHoPNBGqEZXgNbxQRXhpIQGJQeeaAzI7fhPFh4+/D/g2LZhMyi
	RZ1I06URbQAQqopvtC35XuP+aEV09H0Pr+25IkQ7NGNvWBNPj5EqVqENpmbeceFOTxEhwMTL7hl
	QT9DqS6NMVEuYb1iy2lmoZlIxmJkG9nqRa+2bBmgD8P+d2cpkF6VQK6PcDr4XmL3ZH2syHNtcsb
	DR984kuZEWDfzDf6HRjXGuRBU9ddxgXJEOeYl2m9ekJSiO2sB65An3+zrd/gt5yVIhppm3wsmur
	w2HYgzmM9NMvoqOWVowmFYpWsS2w1ey26x3gAsfPgzxJx5WbZD8mzpbMsaMiipQkHmgS0xTL3Gf
	bfS+yuNSR5LmLwkxUR
X-Google-Smtp-Source: AGHT+IF67HpaRIF3/1G6XClevFUfHywcv5txn8AhTLwcPL4utyYwjIWW+2cQLFwZbcn/BkMHwnSGdQ==
X-Received: by 2002:a5d:5888:0:b0:431:307:21f1 with SMTP id ffacd0b85a97d-4324e4c22b3mr11119730f8f.1.1766397945892;
        Mon, 22 Dec 2025 02:05:45 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1b1bdsm20644260f8f.8.2025.12.22.02.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 02:05:45 -0800 (PST)
Message-ID: <a5448524-a147-4edb-9359-bcee3d780eb6@linaro.org>
Date: Mon, 22 Dec 2025 10:05:44 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: perf: fix syscalltbl path base
To: Joel May <joel-linux@jmay.us>, Leo Yan <leo.yan@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Ian Rogers <irogers@google.com>,
 linux-arm-kernel@lists.infradead.org,
 Linux perf Profiling <linux-perf-users@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
References: <b2651f20-6f3a-49f5-9cd8-3fb028b2cab5@app.fastmail.com>
 <fcefc3c0-541d-40cc-84e3-9c2460308bdb@linaro.org>
 <23c07ac4-ff13-47a5-824a-e7af1d1847a3@app.fastmail.com>
 <bda366b4-fa53-4feb-a7ce-ee47cfc404b5@linaro.org>
 <20251215112818.GB681384@e132581.arm.com>
 <c8161700-ad9d-43d3-8c45-cfc110ebcd49@app.fastmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <c8161700-ad9d-43d3-8c45-cfc110ebcd49@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/12/2025 9:48 pm, Joel May wrote:
> On Mon, Dec 15, 2025, at 03:28, Leo Yan wrote:
>> On Mon, Dec 15, 2025 at 12:52:24PM +0200, James Clark wrote:
>>> On 15/12/2025 11:33, Arnd Bergmann wrote:
>>>> On Mon, Dec 15, 2025, at 09:47, James Clark wrote:
>>>>> On 15/12/2025 00:12, Joel May wrote:
>>>>>
>>>>> Hi Joel,
>>>>>
>>>>> There is a similar fix on the list here:
>>>>>
>>>>> https://lore.kernel.org/linux-perf-users/20251204-perf_fix_syscall_header-v1-1-b8e27f74ed6a@arm.com/
>>>>>
>>>>> I'm not sure if commit 1 alone will also fix your issue, or we'd need to
>>>>> collapse both of the commits in that set.
>>
>> We need to apply both patches in the share link - we need to apply the
>> second patch to revert generating unistd_64.h in libperf.
> 
> Yes, applying both of those patches will mitigate my problem.
> 
> Neither of those patches update syscalltbl in
> arm/arm64/kernel/Makefile.syscalls though.  Based on the context in
> scripts/Makefile.asm-headers, it looks like syscalltbl is always intended
> to be relative to srctree.  So, my patch increases consistency, even if
> it's not fixing any known problem (after the other patches are applied).
> 
> Whether headers are dynamically generated or not, it seems like this is
> something that can be improved anyway.
> 
> This is my first time contributing to the Linux kernel, so please bare with
> my ignorance.  I don't know whether it's acceptable to consider patches
> that conceptually improve something without an actual problem they're
> solving.
> 

No worries, thanks for sending the fix. Yes I think it could be ok to 
apply your patch anyway. I just wanted to make sure we were all on the 
same page with both fixes fixing the same thing.

You might want to drop the fixes tag though to avoid confusion if Leo's 
one gets accepted, because then technically it doesn't fix anything any 
more. Keeping Leo's fixes: tag is a bit better because it fixes 
additional things and targets an older commit.

James

> Thanks,
> --Joel



