Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B8D1E285A
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Sep 2025 01:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757987229; cv=none; b=PwXu67SrW4HsIw7HplBnf9KbgKConTXaoxmKWMpVHJeTtt8c/w3JdI9h72I0ZZ00iaKHJoQ48/4DZMUXf29kq7+mlCXJvIlFWYDbfcAmSPi3yGQwr+Q3EIKCmjdkGpcBX0HxplfH92mkiUP6fJQbjnuIyg+7bfwpzQOxNmd4Mv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757987229; c=relaxed/simple;
	bh=1MM4695OvRU5sCCjXqK9K7dBH/cGZGrNsbJDPGrHf6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fV26sHreoY/vSLrzJUvKYqSGKjJx+9cI7rOTRO7f3aEifZ3/fgXugZaDRa0QtiKEDoekFalN8GcH0Z1+dLZ8xRINMwDi+Puw9MbsFF6XdVuJIhVJU3ev4MHyhgM8kZ6qmVoLVceo6cN31fn8I5Pt8KgVk4qSqPTpXhCTWiU+UK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/MrJOWW; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/MrJOWW"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4ee87cc81eso4340645a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Sep 2025 18:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757987227; x=1758592027; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RiFj7ZcI9WNx+PCt1N/twq4GLIPGrm80taj6KBbbDlU=;
        b=i/MrJOWW0ARBQ6Koe2636KlWgk01WSy/v5HPod1fklMXRBltRxyUdDSgGwlxLEOft6
         wHAiQi9Eyi9y3TA61abCcFZ5HdqP/KV+UZilbgsn5tVw42YYnwHvbigGHqml2mlMsM8k
         KDJpadWRnqq7qDWWX1D31Pvam2SfXGq+usCtxXq7jYWdzMwqmWbtCa+8N+HPhJsttIOQ
         muBAAogRGDlkl6oOol9L6OXV3RPtcM0hXfsvs0qCv8OPXr9hdtxpgD0hCHoZCQKaH6o6
         SctaznAZkuz8jR1LYE/EvHpBvgCjPHJe+JwKVMRtclwVHNmXFcnzFGrT02DqrrH2mWQS
         T5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757987227; x=1758592027;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RiFj7ZcI9WNx+PCt1N/twq4GLIPGrm80taj6KBbbDlU=;
        b=fNsPkAGu66XL5XzkPJPdVLX0fumQIckL3TLStgrb9OU5Qca9hV35YDMEgYImc54wB2
         q/tlqYTQdcLLlYww2FjpwfyZ7HXy8wlUjF9zL6E3X/jGysmoxUyCKOJItvlj2TmwBl21
         h9qk1PlMrrN0Ke2NAt9pdWlrYm9MSw4H43YywAijRkoij9Ic7TT/t9WR4hGuxfd981kS
         NC9kCUKKZwfug0IVmoFjisl6g++dWdWBfejduhqDi4OH1NicNz7oRu1Y3bMtzYVao3MJ
         TfUdNPNJ9w8biyrqTDOFUvJrSeFEcuPgM2tfS8MuirKKcxnpZoCQPv9pjX/lIM+tKNRn
         L8+w==
X-Forwarded-Encrypted: i=1; AJvYcCU3dMUeAoDJ7e9+6h75OZpt0+FIslDJEfSSuhtKQKs1OtjbOi4SyMBsMZDmPYhR3v2eIihNw1XsOZjMe+h8R1Wb@vger.kernel.org
X-Gm-Message-State: AOJu0YwPq/B7jvhVTfSRu8FGd84s+BpQA6I+wIhp/ZpPihzBcm6teLOE
	anvN/u7P8AiXOcyozNJ4fPyXKQby/NybQpse2OrArDSAJZSGC2uzHptE
X-Gm-Gg: ASbGnctym55SC6qNr+dQzcToVy5D/C5Fx4/QFf1hQy3U/8N8rbunoEoVqDB/d9rH6GQ
	Pz+ukiFW9cqp0mSd4j6997A6j0MQDrSJneuwvpNfbobcO+DEnSoRUBHbBy4FR2+6+EZfFzQOGU8
	qQQuJNSDz0dfSpO+/ctMzS7CsfQZa9/92d6v0xKynbR+0NjDF1ZWjJWZBP3ub6qbKBBS7pudAlk
	IgVfFenOtYg9uG87TSlgjrntl0fpYFoGcCd8eg2b3ZL9Vxa8Y/tdZWaqNiE75aD4NPaxqfMiprM
	wWUnPjqQ/QJTiVFxDkKVICy8tUCKSFyjzY7G38jPtgWhBJRjC5O/Aw8m4wEBr3OolVZJJ9VvAJU
	KX75ce1wQxHBX2wrNdfE=
X-Google-Smtp-Source: AGHT+IHJPmOLXIdspKyA83O/BAcGlrfnU5dISVvn02DWV9qPvrZzZVyEnyHMg3+oATLbcf7uKM0HhA==
X-Received: by 2002:a05:6a20:7f90:b0:249:fd42:fa33 with SMTP id adf61e73a8af0-2602a28e8edmr15663072637.4.1757987227306;
        Mon, 15 Sep 2025 18:47:07 -0700 (PDT)
Received: from [127.0.0.1] ([2604:a840:3::30f3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760793b5fasm14930150b3a.16.2025.09.15.18.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 18:47:06 -0700 (PDT)
Message-ID: <7366f87a-1924-4dac-8945-389e6674213f@gmail.com>
Date: Tue, 16 Sep 2025 09:46:53 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: remove HARDLOCKUP_DETECTOR_PERF
To: Doug Anderson <dianders@chromium.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>,
 akpm@linux-foundation.org, catalin.marinas@arm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, kees@kernel.org,
 masahiroy@kernel.org, aliceryhl@google.com, ojeda@kernel.org,
 thomas.weissschuh@linutronix.de, xur@google.com, ruanjinjie@huawei.com,
 gshan@redhat.com, maz@kernel.org, suzuki.poulose@arm.com,
 zhanjie9@hisilicon.com, yangyicong@hisilicon.com, gautam@linux.ibm.com,
 arnd@arndb.de, zhao.xichao@vivo.com, rppt@kernel.org, lihuafei1@huawei.com,
 coxu@redhat.com, jpoimboe@kernel.org, yaozhenguo1@gmail.com,
 luogengkun@huaweicloud.com, max.kellermann@ionos.com, tj@kernel.org,
 yury.norov@gmail.com, thorsten.blum@linux.dev, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org
References: <20250915035355.10846-1-cuiyunhui@bytedance.com>
 <aMfpwYPX6_i6ROOY@willie-the-truck>
 <20250915103506.GA3245006@noisy.programming.kicks-ass.net>
 <CAD=FV=Vr67+uRK2bYu34MDXRJN4w_VH_EO7OW4eVLJ3wqUUBog@mail.gmail.com>
Content-Language: en-CA
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <CAD=FV=Vr67+uRK2bYu34MDXRJN4w_VH_EO7OW4eVLJ3wqUUBog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/15/25 23:42, Doug Anderson wrote:
> Hi,
> 
> On Mon, Sep 15, 2025 at 3:35 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Mon, Sep 15, 2025 at 11:26:09AM +0100, Will Deacon wrote:
>>
>>>    | If all CPUs are hard locked up at the same time the buddy system
>>>    | can't detect it.
>>>
>>> Ok, so why is that limitation acceptable? It looks to me like you're
>>> removing useful functionality.
>>
>> Yeah, this. I've run into this case waaay too many times to think it
>> reasonable to remove the perf/NMI based lockup detector.
> 
> I am a bit curious how this comes to be in cases where you've seen it.
> What causes all CPUs to be stuck looping all with interrupts disabled
> (but still able to execute NMIs)? Certainly one can come up with a
> synthetic way to make that happen, but I would imagine it to be
> exceedingly rare in real life. Maybe all CPUs are deadlocked waiting
> on spinlocks or something? There shouldn't be a lot of other reasons
> that all CPUs should be stuck indefinitely with interrupts disabled...
> If that's what's happening, (just spitballing) I wonder if hooking
> into the slowpath of spinlocks to look for lockups would help? Maybe
> every 10000 failures to acquire the spinlock we check for a lockup?
> Obviously you could still come up with synthetic ways to make a
> non-caught watchdog, but hopefully in those types of cases we can at
> least reset the device with a hardware watchdog?
> 
> Overall the issue is that it's really awkward to have both types of
> lockup detectors, especially since you've got to pick at compile time.
> The perf lockup detector has a pile of things that make it pretty
> awkward and it seems like people have been toward the buddy detector
> because of this...
> 
> -Doug

Should we support both modularization and changing the backend after 
boot, so that the user has the choice?

-- 
Jinchao
