Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8FF30AABC
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 11:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769511778; cv=none; b=DgBjDbhst0mzJ3kKdu+vUJ3XfxNEEmu+a4GLFLrXPgVmbrURqWPEc7lC2IeXDqaYUkrcaTb1oL1YQYvTiPr1MMsjeGrJRjq5igpRt48t2TX+UWJx6esgWsjSmRJrwstTcYc3TECYu0u7ofr4OBRnbY0zuLMUrI6sUfxXrqUF2tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769511778; c=relaxed/simple;
	bh=nbjJRqVGPNjzissEis91e43zEZqos8pWTPkJxVts5QM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dL3OKy+mdKQFrHhU06C6EsAdloOb7OSUvg0t0OUHmuUDJ5JIXNGTzH6ZpD5qPGwtC4hft5emBEUayO+xowzE3PdawTswOcdl4WiMzjbHcCK8Vwr2CCWbdQpRTdwdT43cDM4lmPkrbUYmQXzu1AlL7cGlYfZl671NtyOQ+HRIUJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NM3wnJgK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NM3wnJgK"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-480142406b3so37353715e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 03:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769511775; x=1770116575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=INl9hoLKul5yCo6Z+vO92OYsqwvOgogS5QUauHQJGts=;
        b=NM3wnJgKuBvxi7kZSk5bajjR/9sb0ccrhlrUmnnBaSW8O/43Q4+Jc3L1OdTGGr3rpb
         pwoVI8xXutAKVu/3OaJ45tZT86g9QDi8AgBonv7N+KW9+6Texs9Jx4XIB8H7I7/EC1FD
         lTKAEfJq5/ZJV+g5kC/U1P9gRstqHKWixm6nG9DxMDfYn5nl2XLpAtgqIaovnUlsYPnb
         RkrwiShrs0tTyrUICOI7+KuXzqlxuaE57Wcy2Eo7P0r43FX92fGj8NIui8yvPsRHvZMp
         y+WCC9E6vJZ64yorqa2pDQ0y6UYz7OJPxvanW9VFY4Y8PnNw2kITrLd+BRJ2OvnKrXHX
         Nnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769511775; x=1770116575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=INl9hoLKul5yCo6Z+vO92OYsqwvOgogS5QUauHQJGts=;
        b=Bcb4VBOZBB03q+vCV3UaadS3s1VHuGeA0Iq7iU/37owWHu2LeBLSy9k04na3NimLYz
         Q7ebXm5i7Jw0iBukqL2a/abfmwrO3h20wHfuC1lTRdnnKKT2PnEVfBhHMl06wlZv3QZQ
         yX8lx4QgXvRyBT8LcokhgQj3vsgElXwMyb2o2ZmsBoldM0TjvwS3nsI4IkwjYJdFsUeR
         SqIvhodL5JV0ucDMK7Wuz54mZZEgU0P5vZUpTWe3MYbYjXMWaenMO1Evk5z78QwU6Wmm
         w6QnTXV0uxNRj6TdKiBcOT7okTeTzEWsW1IWkYM/iNLxdA5GaYXWuHZncFfsMTp9ovFH
         4nEw==
X-Forwarded-Encrypted: i=1; AJvYcCWcUolEpWxAPZCpIX+VKMd0Um1QcbzcikG5Wj95YgKhR7bfQPxxz3Z8z+HKj3bwAVZEBItvRQkjGA9hwFfR1+mi@vger.kernel.org
X-Gm-Message-State: AOJu0YyTGT/9nBwQb+JAlIl6keHTqOVVsQlzKg09J1f8CMAQEGAvjA1c
	RBohapfRq7HRvwVyphZQEdhF8blcuNHWfCZ9VnyLZ2BtdYSWERLLbei9o+9G7mGGMxg=
X-Gm-Gg: AZuq6aLph6vjUc6OyW/51/YJPSOhBszNaVdt84UbIIeLE8uiyiBcRBO01ThyCcVQamX
	4IluMKXAkDtd+DHMZZhQRmaM5YNPqCwHv0PsGa9unO7MvETu6vJ4Q4Qum0kK8SIlrGuCTABSLYP
	lm4p+gpyDG2MN4Aw2T4LE65EHerYz/Bv/izqid6c7F3yZSyJOJCTqzqVjj42vD3l41b8I2Y6lSo
	qyXYvbssL5wk0lMgK5JxFdT7yNI6fj8YoO+LkqwKKpn7g43/DUvkxLpmFi7xxQIZ1J1w863CVcb
	uPJ2znp5om7PwgsWqitAl3MuaxbMzulLyQC/t/UR3yuqWSpakqFS5Yf5hUXw+YZcF9RSKVXqNqy
	Qj1Sqxtl3DdcY26M91mOzDIiaD2LMkTnujS3kVGOU6MvAIeel3nC8WINaI6M7F1XdI5GmCpH9Io
	Q1yaRFG8q9KikWmrq7
X-Received: by 2002:a05:600c:474d:b0:480:1d0b:2d15 with SMTP id 5b1f17b1804b1-48069c53fdbmr16075955e9.27.1769511774697;
        Tue, 27 Jan 2026 03:02:54 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804dbb6315sm130472705e9.4.2026.01.27.03.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 03:02:54 -0800 (PST)
Message-ID: <26a8d557-41a2-4b8f-826f-ed795b13264f@linaro.org>
Date: Tue, 27 Jan 2026 11:02:52 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tests: mmap: skip user counter tests when runtime
 PMU access is unavailable
To: Ian Rogers <irogers@google.com>
Cc: Qiao Zhao <qzhao@redhat.com>, Leo Yan <leo.yan@linux.dev>,
 namhyung@kernel.org, mpetlan@redhat.com, acme@kernel.org,
 linux-perf-users@vger.kernel.org
References: <20260120090522.1193981-1-qzhao@redhat.com>
 <CAATMXfkYH8w7sLpDSHTf1JRGdQiK5Ey8pX6u=5t+Nsi091SXgA@mail.gmail.com>
 <CAP-5=fWPpeLS2D_XgsyM5OYDvWkoTapSb0XfPu-K7ue31BCTCg@mail.gmail.com>
 <72bc7c74-a2da-4cdc-b647-1c9e93388c4b@linaro.org>
 <5122bbaa-7126-455b-97e5-8c998c865961@linaro.org>
 <CAP-5=fXXg=5EvMFm9Jbe+Y81UFcuGYtEZAP86gmXzvbV1=_SQA@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fXXg=5EvMFm9Jbe+Y81UFcuGYtEZAP86gmXzvbV1=_SQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 26/01/2026 5:24 pm, Ian Rogers wrote:
> On Mon, Jan 26, 2026 at 3:40 AM James Clark <james.clark@linaro.org> wrote:
>> On 26/01/2026 11:21 am, James Clark wrote:
>>> On 23/01/2026 6:01 am, Ian Rogers wrote:
>>>> On Thu, Jan 22, 2026 at 7:11 PM Qiao Zhao <qzhao@redhat.com> wrote:
>>>>>
>>>>> Hi Kim, Ian,
>>>>>
>>>>> Do you mind reviewing this change?
> [snip]
>>>> Hi Qiao,
>>>>
>>>> It sounds like the ARM behavior is divergent from the Intel behavior,
>>>> but that said Intel hybrid rdpmc is known to be problematic. There's a
>>>> fix for part of that which will hopefully land [1]. One weird thing on
>>>> Intel hybrid is that the rdpmc permission file within the PMU is kind
>>>> of "shared" between all core PMUs, so disabling rdpmc on the e-core
>>>> PMU disables it on the p-core. In one iteration of this test tried to
>>>> incorporate support for this. Anyway, ARM...
>>>>
>>>> So in the test we're doing:
>>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-
>>>> next.git/tree/tools/perf/tests/mmap-basic.c?h=perf-tools-next#n243
>>>> ```
>>>> #ifdef __aarch64__
>>>> .config1 = 0x2, /* Request user access */
>>>> #endif
>>>> ```
>>>> So 1 question is why the perf_event_open is succeeding with a request
>>>> user access bit set in the config in a system where this is blocked?
>>>
>>> That's because sysctl_perf_user_access isn't checked when opening the
>>> event, only when scheduling it in. I don't think that's a bug, but just
>>> how it is. I suppose one benefit is that it allows you to add or revoke
>>> the permission at run time without recreating events.
>>>
>>> The canonical rdpmc example in perf_event.h does say the index should be
>>> checked before reading the event:
>>>
>>>     * index = pc->index;
>>>     * count = pc->offset;
>>>     * if (pc->cap_user_rdpmc && index) {
>>>     *   width = pc->pmc_width;
>>>     *   pmc = rdpmc(index - 1);
>>>     * }
>>>
>>> The version of this test before commit 588d22b40480 ("perf test: Expand
>>> user space event reading (rdpmc) tests") treated "supported" and
>>> "enabled" as things that could exist separately and skipped if the
>>> system has /proc/sys/kernel/perf_user_access = 0:
>>>
>>>     $ echo 0 > /proc/sys/kernel/perf_user_access
>>>     $ perf test -vv "user space counter"
>>>     ...
>>>     userspace counter access not enabled
>>>     4.2: User space counter reading of instructions  : Skip (permissions)
>>>     ..
>>>
>>> Setting /proc/sys/kernel/perf_user_access makes that version of the test
>>> and the current version of the test pass. That also aligns with what's
>>> currently in the libperf test tools/lib/perf/tests/test-evsel.c which
>>> also checks both supported and enabled separately for a skip.
>>>
>>> So it looks like commit 588d22b40480 has added the assumption that
>>> "supported" must equal "enabled" if rdmpc was asked for, but that's
>>> probably not right.
>>>
>>> I think Qiao's change is ok, except it could probably go a bit further
>>> because we don't need to check pc->cap_user_rdpmc if !rdpmc_supported.
>>> Maybe the original separate "is supported" (pc->cap_user_rdpmc) and "is
>>> enabled" (pc->index) checks are clearer. Each can result in a skip on
>>> their own.
>>>
>>> Thanks
>>> James
>>>
>>
>> Actually if we check /proc/sys/kernel/perf_user_access in the test we
>> can keep it strict and assume that "supported" must equal "enabled" as
>> long as perf_user_access is set. That might be better and keep the test
>> useful. Otherwise it can start skipping if the feature breaks.
> 
> Thanks James, is /proc/sys/kernel/perf_user_access ARM specific? It
> seems very similar to the rdpmc file. I don't immediately see it on
> the first x86 I tested on. Checking both the rdpmc and
> /proc/sys/kernel/perf_user_access sounds like a good solution to the
> problem to me.
> 
> Thanks,
> Ian
> 

Arm and now riscv a well, so if we #ifdef it, it should be for those 
platforms. The discussions about why to do it that way instead of using 
the /sys/devices/cpu/rdpmc file like on x86 seem to be suggesting that 
multiple PMU types would make this less good than a global setting which 
you might want to change for security. Although there isn't much detail 
about pros and cons of consistency vs usability and then setting just 
appeared on version after that. The x86 /rdpmc semantics are default on 
as well which wasn't desired so maybe that was another reason to diverge.

Either way it's there now.

>>>>
>>>> I'm not sure on the support for the rdpmc file on ARM but it looks to
>>>> be wired up:
>>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-
>>>> next.git/tree/drivers/perf/arm_pmuv3.c?h=perf-tools-next#n324
>>>>
>>>> So in the test where you've changed it we've determined that rdpmc
>>>> shouldn't be supported but the shared page is saying the
>>>> cap_uesr_rdpmc is available. So is this an ARM PMU driver bug?
>>>> I wonder if the setting of cap_user_read:
>>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-
>>>> next.git/tree/drivers/perf/arm_pmuv3.c?h=perf-tools-next#n1615
>>>> should also be testing whether support has been disabled through the
>>>> rdpmc attribute? Hmm.. but x86 doesn't do that:
>>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-
>>>> next.git/tree/arch/x86/events/core.c?h=perf-tools-next#n2753
>>>>
>>>> So given that ARM and x86 look in sync, x86 doesn't have issues I'm
>>>> aware of, and it certainly looks like a failure inconsistency that the
>>>> test thinks that user rdpmc support is disabled but the page says
>>>> otherwise. I could use more details to understand this, like what's
>>>> the contents of the rdpmc file? In your commit message, is the
>>>> restricted PMU access the rdpmc file or a different capability? Could
>>>> this be a weird hybrid/BIG.little issue like on x86?
>>>>
>>>> Thanks,
>>>> Ian
>>>>
>>>> [1] https://lore.kernel.org/lkml/24bc287a-a3e0-45f6-
>>>> a8f1-20a34e2f9af2@linux.intel.com/

