Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898852045AD
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 11:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769426483; cv=none; b=gdr4o9s/dexgZd6JT5j9aPG2q14bJ+3i/iJZOIewMKeLWWVmH3vGcjumrMNZA3KOXouCdz0XfmZ++kJnIe0VRExgMNJ1jiKic1zYLX7Iskrd04CAKTSQfAmjBadncfNd61IxX8Q+ccf0MP/UKSwhN8eDdqiV9vqalZ1W3Uq1af0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769426483; c=relaxed/simple;
	bh=mxnNEWvjiSwDqY9eOfwfzc//W2+S4RWx+p9kGxZ1/r8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=roa/GnQksBVG7c+wx4HJjc0h8Zwqwv0hlGwoLytp2b6j1kPo37oMPsC1JY632eam/AsTg9IRsaSCI8Hb9mQCRFWIOWBOUhoASQZd38fm2MgyXfbDzvJ2ZaFBibZ4eV31/AdejXmFpEHnf6m5voinEKlCvisy0q1YRiejKKzxIvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lFu/h3zs; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lFu/h3zs"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so35857325e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 03:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769426480; x=1770031280; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AZnOqoPJbA2vcVZDzCW8SWXfAN6VANeVTkDMhtLBF68=;
        b=lFu/h3zskQ7/fI4YBUEJ4DhAwUoikFoNt0t/HJCMT/LpH8D4oE4V3lIGV7omVz6+fq
         DT4h+7GAUhOed5opySH+pVPDA4QoZsgdeukDrOUuEQJ5iZ5gYN5NNox9aMkpGS0Ts7yl
         V0Wd+jra6Mqi8wpdviPkePHx0B2PZgZRz683ky4RMQZe1BlIfCoMPAmpbBTFjxgin8kx
         Bsa5N6QL0XhYwKi5xGsWj5fV/w8kB4q3uiTKt/0HE5zdzWDKrYnz4t29g/AAVIEKuNBy
         FY0JUQJOhfVoWOVwyEsSMCK5y/jsZXPCqN6ZIP3IYJbtpyrIRl7E6UlCr5lsIWZmIc43
         qL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769426480; x=1770031280;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AZnOqoPJbA2vcVZDzCW8SWXfAN6VANeVTkDMhtLBF68=;
        b=Jhz9hu+zsTuHJ4i+Na6PEn3vwfxObtTMw7BNdjFbrEyxXO3tqZ/lwP04pRDQIud2WU
         8OCYKVOkNYpoHIFzIq8E1K+moI8CZnGRsgOI8LOjg/EIPEkMGAZTIyFIfyXW5IFHeLAO
         bV7o/CPVcRFki/8EK2TWBD9x9SltlP4KX3YQDGx+/y5UALyJVgeF3QIxbpJHISy3dVRn
         FUiUWHgsx3xOUS5KTlhI/a8O5QfcTaeYOlrpuyJbpBAwl2q7XMYB+auhALQTvbqEdI8Y
         95J/mrBGMiEJNqQYIzhjPkD145jtjgmijYLxvlc7Pi8yCcYETsXFLR5MH0JqKttWoMzV
         6fHA==
X-Forwarded-Encrypted: i=1; AJvYcCUa7nPSJr1IBTPhVM1U0nxltrGjYDoL6yJgEgU0kSMIbF+nnNCi3PmN7p6cSnhkKZuRJQXUdAvZiLM2a0ny5gcL@vger.kernel.org
X-Gm-Message-State: AOJu0YwoaoEHZcclffWKb+5rMASmYqmCXW/Sx37iR4HrMfIEJsC4D/Kw
	g8ukJ/OyEmjXmQ1C0YPhYqyfA0HkmihctrVCmp/TSEHB22VXhVqxtdzDnBZlEi3UulF3CuU8vQx
	axunU
X-Gm-Gg: AZuq6aK2b8prY1kl6kEjqTYKUj6eGosjmmZOcnUh8u0P+45ZY5XZB9lhooAg0SDSHlM
	m+fSNCjjMISZjNw7ZtJdo2CuuuSdncudO70WE/PiRAtG2CUza0lSQebDarcp26fnBI4AFzemLfp
	qY42QplqvnyNTVi0P6E++rBQPxNGYJWL1RjIGW75NMDm+E2Ds5GxA0U7zUOTowE4nFcplsgZb+/
	bm63PMqEKVu+KG+bhKUIFEjv052KWdSSO6ZgMkrFQUWlI2Jus/uUjY0ODnnS6gcSp544lscdCro
	0OeeoXwgpqwiKaykyLhbHCPxteBFkrVUpLyvoep7YY723eAdZzNeYCWLlYlwngjd2EmDT7RL3rR
	oVeImtc42KJd3z6q8LY5BYcycFL9nZY0dLSHiWX6Jjixcc0UmFXPqsmfyIU3hpoBrAAmjgNHI6w
	i8Y+CUqm5RBGFVNBXK
X-Received: by 2002:a05:600c:45cf:b0:477:2f7c:314f with SMTP id 5b1f17b1804b1-4805ce3f810mr58902445e9.10.1769426479754;
        Mon, 26 Jan 2026 03:21:19 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480470cf385sm336217465e9.13.2026.01.26.03.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 03:21:19 -0800 (PST)
Message-ID: <72bc7c74-a2da-4cdc-b647-1c9e93388c4b@linaro.org>
Date: Mon, 26 Jan 2026 11:21:18 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tests: mmap: skip user counter tests when runtime
 PMU access is unavailable
To: Ian Rogers <irogers@google.com>, Qiao Zhao <qzhao@redhat.com>,
 Leo Yan <leo.yan@linux.dev>
Cc: namhyung@kernel.org, mpetlan@redhat.com, acme@kernel.org,
 linux-perf-users@vger.kernel.org
References: <20260120090522.1193981-1-qzhao@redhat.com>
 <CAATMXfkYH8w7sLpDSHTf1JRGdQiK5Ey8pX6u=5t+Nsi091SXgA@mail.gmail.com>
 <CAP-5=fWPpeLS2D_XgsyM5OYDvWkoTapSb0XfPu-K7ue31BCTCg@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fWPpeLS2D_XgsyM5OYDvWkoTapSb0XfPu-K7ue31BCTCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 23/01/2026 6:01 am, Ian Rogers wrote:
> On Thu, Jan 22, 2026 at 7:11 PM Qiao Zhao <qzhao@redhat.com> wrote:
>>
>> Hi Kim, Ian,
>>
>> Do you mind reviewing this change?
>>
>> On Tue, Jan 20, 2026 at 5:05 PM Qiao Zhao <qzhao@redhat.com> wrote:
>>>
>>> On some platforms (e.g. ARM systems with restricted PMU access), user space
>>> PMU counters may be reported as supported but blocked at runtime. Failing
>>> the mmap interface tests in this case is incorrect.
>>>
>>> [Test Log]
>>> 124.2: User space counter reading of instructions                    : FAILED!
>>> --- start ---
>>> User space counter reading 0
>>> User space counter reading for PMU armv8_pmuv3_0
>>> User space counter reading for PMU armv8_pmuv3_0 [Failed unexpected unsupported counter access 1]
>>> ---- end ----
>>> 124.3: User space counter reading of cycles                          : FAILED!
>>> --- start ---
>>> User space counter reading 1
>>> User space counter reading for PMU armv8_pmuv3_0
>>> User space counter reading for PMU armv8_pmuv3_0 [Failed unexpected unsupported counter access 1]
>>> ---- end ----
>>> [/Test Log]
>>>
>>> Skip the user counter mmap tests when runtime PMU access is not available,
>>> while preserving failure for genuinely inconsistent states.
>>>
>>> Signed-off-by: Qiao Zhao <qzhao@redhat.com>
>>> ---
>>>   tools/perf/tests/mmap-basic.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
>>> index 3313c236104e..4881a641749b 100644
>>> --- a/tools/perf/tests/mmap-basic.c
>>> +++ b/tools/perf/tests/mmap-basic.c
>>> @@ -308,9 +308,9 @@ static int test_stat_user_read(u64 event, enum user_read_state enabled)
>>>                  }
>>>
>>>                  if (!rdpmc_supported && pc->cap_user_rdpmc) {
>>> -                       pr_err("User space counter reading for PMU %s [Failed unexpected unsupported counter access %d]\n",
>>> +                       pr_debug("User space counter reading for PMU %s is not supported (cap_user_rdpmc=%d), skipping!\n",
>>>                                  pmu->name, pc->cap_user_rdpmc);
>>> -                       ret = TEST_FAIL;
>>> +                       ret = TEST_SKIP;
> 
> Hi Qiao,
> 
> It sounds like the ARM behavior is divergent from the Intel behavior,
> but that said Intel hybrid rdpmc is known to be problematic. There's a
> fix for part of that which will hopefully land [1]. One weird thing on
> Intel hybrid is that the rdpmc permission file within the PMU is kind
> of "shared" between all core PMUs, so disabling rdpmc on the e-core
> PMU disables it on the p-core. In one iteration of this test tried to
> incorporate support for this. Anyway, ARM...
> 
> So in the test we're doing:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/mmap-basic.c?h=perf-tools-next#n243
> ```
> #ifdef __aarch64__
> .config1 = 0x2, /* Request user access */
> #endif
> ```
> So 1 question is why the perf_event_open is succeeding with a request
> user access bit set in the config in a system where this is blocked?

That's because sysctl_perf_user_access isn't checked when opening the 
event, only when scheduling it in. I don't think that's a bug, but just 
how it is. I suppose one benefit is that it allows you to add or revoke 
the permission at run time without recreating events.

The canonical rdpmc example in perf_event.h does say the index should be 
checked before reading the event:

   * index = pc->index;
   * count = pc->offset;
   * if (pc->cap_user_rdpmc && index) {
   *   width = pc->pmc_width;
   *   pmc = rdpmc(index - 1);
   * }

The version of this test before commit 588d22b40480 ("perf test: Expand 
user space event reading (rdpmc) tests") treated "supported" and 
"enabled" as things that could exist separately and skipped if the 
system has /proc/sys/kernel/perf_user_access = 0:

   $ echo 0 > /proc/sys/kernel/perf_user_access
   $ perf test -vv "user space counter"
   ...
   userspace counter access not enabled
   4.2: User space counter reading of instructions  : Skip (permissions)
   ..

Setting /proc/sys/kernel/perf_user_access makes that version of the test 
and the current version of the test pass. That also aligns with what's 
currently in the libperf test tools/lib/perf/tests/test-evsel.c which 
also checks both supported and enabled separately for a skip.

So it looks like commit 588d22b40480 has added the assumption that 
"supported" must equal "enabled" if rdmpc was asked for, but that's 
probably not right.

I think Qiao's change is ok, except it could probably go a bit further 
because we don't need to check pc->cap_user_rdpmc if !rdpmc_supported. 
Maybe the original separate "is supported" (pc->cap_user_rdpmc) and "is 
enabled" (pc->index) checks are clearer. Each can result in a skip on 
their own.

Thanks
James

> 
> I'm not sure on the support for the rdpmc file on ARM but it looks to
> be wired up:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/drivers/perf/arm_pmuv3.c?h=perf-tools-next#n324
> 
> So in the test where you've changed it we've determined that rdpmc
> shouldn't be supported but the shared page is saying the
> cap_uesr_rdpmc is available. So is this an ARM PMU driver bug?
> I wonder if the setting of cap_user_read:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/drivers/perf/arm_pmuv3.c?h=perf-tools-next#n1615
> should also be testing whether support has been disabled through the
> rdpmc attribute? Hmm.. but x86 doesn't do that:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/arch/x86/events/core.c?h=perf-tools-next#n2753
> 
> So given that ARM and x86 look in sync, x86 doesn't have issues I'm
> aware of, and it certainly looks like a failure inconsistency that the
> test thinks that user rdpmc support is disabled but the page says
> otherwise. I could use more details to understand this, like what's
> the contents of the rdpmc file? In your commit message, is the
> restricted PMU access the rdpmc file or a different capability? Could
> this be a weird hybrid/BIG.little issue like on x86?
> 
> Thanks,
> Ian
> 
> [1] https://lore.kernel.org/lkml/24bc287a-a3e0-45f6-a8f1-20a34e2f9af2@linux.intel.com/
> 
>>>                          goto cleanup;
>>>                  }
>>>
>>> --
>>> 2.49.0
>>>
>>

