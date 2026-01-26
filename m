Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0FC302151
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769427623; cv=none; b=iVExUbElCDZevUHdQO2qN0YpoGRgiBorQjPPb3IdcNJ4FACjLlw6dnMSWSiu+wTvoUlfqPL0YgF36ZKKrS1Fxt6Wdb81HzQTJh2W1vt2Flr1/GaL0p/ESGsrO3+OzvhbU56G9Fzz1vpDjOnYbyQQeVsesgjbnOj08uM/kb+9aN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769427623; c=relaxed/simple;
	bh=fb+im2MJpvvRc5kleMTVQPUeFJCA4JmVm4vmW/uSMr0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MelUpIhzdRn7OSwREmMJGUlVN1zkSsX7FohzjKUJTXqVJhp8FiNOzSP2CiUpQ/WCWd6CO9LZ5nNS1pZmEe69Fo5ErbWPGG5pi92NIwJhL4deMMvrlP0X2V0kUEA1bI0qlpRuTDiP5jFTPRw6ZMENHEwbOm2MTb0NRWLKRK4w9+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DRMS8Wcr; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DRMS8Wcr"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4801c731d0aso34667115e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 03:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769427620; x=1770032420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o8Hjx8napHmdiGIcpkWwoNAbzkplPPWmPfcimE7Ezwg=;
        b=DRMS8WcrU/mOfkN06Hl2rB8+NiNNm3FFkO+IviQulTN3gZ6rb0C3EdrqjH2qRlaFfX
         +2pCkXAOL8I29Q7r7PREbKpiUR+kQ3v8/BTB2+n6dlIi41EA05Z42T1xu0V3QEKJ2abU
         VDkUw1BTr08rufBzHh2IoTE1/o0q0nQ8oz0UsS0IQ80aa2SidizkPi6BtsFy37+gsM97
         NJ7fQnfhqowJumWwK9adDukcecacO3dZOlBR4cTE7+iS2DR+OlFLyOt8vEOUHhKa+TNF
         yvTEax1+3w12bZolg0AI6n7Hl2ellvawZWedIIeFAYucrWICtW9QqTbLF7huzZFUp/Ad
         3QvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769427620; x=1770032420;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o8Hjx8napHmdiGIcpkWwoNAbzkplPPWmPfcimE7Ezwg=;
        b=Mjiidu/jAqp0Kv+B/08ss0FWFFh36HPLIIvEq5+v6Kvu2rDD7SkysSddFSPD/grVFs
         fqzzYfTDZhsg7SxOhoaWu/xC6urD0LC3fsXGIuh4dilPOztD2ecS9XPL+IZ2mKWpiTIx
         2g/TlYPX/gqmtqARXy5ZdxJIqUw6wiKgHUZYoIFe/Wi9tkzyDrJteid1eKiJ8cy7PVaU
         80VEMh9FOi+xPaNahprvITvr81Ha6jJN2L5hzyO1b5JBzmp5mfjmD41pn21SsM4kaZKe
         FyxvBniU/g3m1OltSqE3zmNpzVppz/Bn8e+Km+rhKNUEN/Mw86KqCtPpaGr2zbZQ1h80
         Jefw==
X-Forwarded-Encrypted: i=1; AJvYcCV2vb6zsgrk6/IoNoA2e6hwQeaALx1rglDyKF43Y2hCA4XOXtyw/9frk1QOpK14/r36e8elUfPRhop9M2rBstyG@vger.kernel.org
X-Gm-Message-State: AOJu0YzvBDFKA44NGGoKOO9eQs9lF0SNUKQGsUop0LqtVVGJE7fEam3V
	8o8GupfR/90bGYqW4OKLFMZcS+y/uedX+4SvK86VnXweRBvagIF4gpO1C5TKW1Y5YHo=
X-Gm-Gg: AZuq6aJzHSr1DZfa1DLBfSqpoi0mENy2Xbs0zb6Q9Lgm2fd27MTp1Whf44m0PJSGTo2
	PeXK/0PgNQPVUeU7wK8HJ70SpbgPzGPHFxQ9jzCiNIzcGPIW6hzUym8Gq60KMMGI7yl573lPvRd
	IkuoeMxZLN+FNrLdDdAPMpSbEjNleZ51sHHvZ4QuRvfSdj/kIJ1M5YgGix7Kk/bHP3AYCuvJFqK
	Xza8tXkJaEHDnOOpK0QFfp98ROpoGZ/7ZxCseyj4/3NKaYoKIkBrcU+58SvXyVNoxlbpu8jul6x
	QoNlqMjWSakjy9lvCSwy0IF/qpc7RGBC/LIZxiRZWCTylyfSaiRVHhLKAsS9ueM6dzcp6eJbVSQ
	Y4rF5+2prGF0M2RQC5w/fxqcoYsvo8UNKltEjK19pnYAmnIVs0r/Cltx5HjMjL6oZ4Qbtl9+za1
	8mQ1VTSVu8m13CTx7t
X-Received: by 2002:a05:600c:a011:b0:479:2f95:5179 with SMTP id 5b1f17b1804b1-4805ce3fce4mr74986785e9.15.1769427620354;
        Mon, 26 Jan 2026 03:40:20 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48047028928sm479942675e9.2.2026.01.26.03.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 03:40:19 -0800 (PST)
Message-ID: <5122bbaa-7126-455b-97e5-8c998c865961@linaro.org>
Date: Mon, 26 Jan 2026 11:40:19 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tests: mmap: skip user counter tests when runtime
 PMU access is unavailable
From: James Clark <james.clark@linaro.org>
To: Ian Rogers <irogers@google.com>, Qiao Zhao <qzhao@redhat.com>,
 Leo Yan <leo.yan@linux.dev>
Cc: namhyung@kernel.org, mpetlan@redhat.com, acme@kernel.org,
 linux-perf-users@vger.kernel.org
References: <20260120090522.1193981-1-qzhao@redhat.com>
 <CAATMXfkYH8w7sLpDSHTf1JRGdQiK5Ey8pX6u=5t+Nsi091SXgA@mail.gmail.com>
 <CAP-5=fWPpeLS2D_XgsyM5OYDvWkoTapSb0XfPu-K7ue31BCTCg@mail.gmail.com>
 <72bc7c74-a2da-4cdc-b647-1c9e93388c4b@linaro.org>
Content-Language: en-US
In-Reply-To: <72bc7c74-a2da-4cdc-b647-1c9e93388c4b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 26/01/2026 11:21 am, James Clark wrote:
> 
> 
> On 23/01/2026 6:01 am, Ian Rogers wrote:
>> On Thu, Jan 22, 2026 at 7:11 PM Qiao Zhao <qzhao@redhat.com> wrote:
>>>
>>> Hi Kim, Ian,
>>>
>>> Do you mind reviewing this change?
>>>
>>> On Tue, Jan 20, 2026 at 5:05 PM Qiao Zhao <qzhao@redhat.com> wrote:
>>>>
>>>> On some platforms (e.g. ARM systems with restricted PMU access), 
>>>> user space
>>>> PMU counters may be reported as supported but blocked at runtime. 
>>>> Failing
>>>> the mmap interface tests in this case is incorrect.
>>>>
>>>> [Test Log]
>>>> 124.2: User space counter reading of 
>>>> instructions                    : FAILED!
>>>> --- start ---
>>>> User space counter reading 0
>>>> User space counter reading for PMU armv8_pmuv3_0
>>>> User space counter reading for PMU armv8_pmuv3_0 [Failed unexpected 
>>>> unsupported counter access 1]
>>>> ---- end ----
>>>> 124.3: User space counter reading of 
>>>> cycles                          : FAILED!
>>>> --- start ---
>>>> User space counter reading 1
>>>> User space counter reading for PMU armv8_pmuv3_0
>>>> User space counter reading for PMU armv8_pmuv3_0 [Failed unexpected 
>>>> unsupported counter access 1]
>>>> ---- end ----
>>>> [/Test Log]
>>>>
>>>> Skip the user counter mmap tests when runtime PMU access is not 
>>>> available,
>>>> while preserving failure for genuinely inconsistent states.
>>>>
>>>> Signed-off-by: Qiao Zhao <qzhao@redhat.com>
>>>> ---
>>>>   tools/perf/tests/mmap-basic.c | 4 ++--
>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap- 
>>>> basic.c
>>>> index 3313c236104e..4881a641749b 100644
>>>> --- a/tools/perf/tests/mmap-basic.c
>>>> +++ b/tools/perf/tests/mmap-basic.c
>>>> @@ -308,9 +308,9 @@ static int test_stat_user_read(u64 event, enum 
>>>> user_read_state enabled)
>>>>                  }
>>>>
>>>>                  if (!rdpmc_supported && pc->cap_user_rdpmc) {
>>>> -                       pr_err("User space counter reading for PMU 
>>>> %s [Failed unexpected unsupported counter access %d]\n",
>>>> +                       pr_debug("User space counter reading for PMU 
>>>> %s is not supported (cap_user_rdpmc=%d), skipping!\n",
>>>>                                  pmu->name, pc->cap_user_rdpmc);
>>>> -                       ret = TEST_FAIL;
>>>> +                       ret = TEST_SKIP;
>>
>> Hi Qiao,
>>
>> It sounds like the ARM behavior is divergent from the Intel behavior,
>> but that said Intel hybrid rdpmc is known to be problematic. There's a
>> fix for part of that which will hopefully land [1]. One weird thing on
>> Intel hybrid is that the rdpmc permission file within the PMU is kind
>> of "shared" between all core PMUs, so disabling rdpmc on the e-core
>> PMU disables it on the p-core. In one iteration of this test tried to
>> incorporate support for this. Anyway, ARM...
>>
>> So in the test we're doing:
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools- 
>> next.git/tree/tools/perf/tests/mmap-basic.c?h=perf-tools-next#n243
>> ```
>> #ifdef __aarch64__
>> .config1 = 0x2, /* Request user access */
>> #endif
>> ```
>> So 1 question is why the perf_event_open is succeeding with a request
>> user access bit set in the config in a system where this is blocked?
> 
> That's because sysctl_perf_user_access isn't checked when opening the 
> event, only when scheduling it in. I don't think that's a bug, but just 
> how it is. I suppose one benefit is that it allows you to add or revoke 
> the permission at run time without recreating events.
> 
> The canonical rdpmc example in perf_event.h does say the index should be 
> checked before reading the event:
> 
>    * index = pc->index;
>    * count = pc->offset;
>    * if (pc->cap_user_rdpmc && index) {
>    *   width = pc->pmc_width;
>    *   pmc = rdpmc(index - 1);
>    * }
> 
> The version of this test before commit 588d22b40480 ("perf test: Expand 
> user space event reading (rdpmc) tests") treated "supported" and 
> "enabled" as things that could exist separately and skipped if the 
> system has /proc/sys/kernel/perf_user_access = 0:
> 
>    $ echo 0 > /proc/sys/kernel/perf_user_access
>    $ perf test -vv "user space counter"
>    ...
>    userspace counter access not enabled
>    4.2: User space counter reading of instructions  : Skip (permissions)
>    ..
> 
> Setting /proc/sys/kernel/perf_user_access makes that version of the test 
> and the current version of the test pass. That also aligns with what's 
> currently in the libperf test tools/lib/perf/tests/test-evsel.c which 
> also checks both supported and enabled separately for a skip.
> 
> So it looks like commit 588d22b40480 has added the assumption that 
> "supported" must equal "enabled" if rdmpc was asked for, but that's 
> probably not right.
> 
> I think Qiao's change is ok, except it could probably go a bit further 
> because we don't need to check pc->cap_user_rdpmc if !rdpmc_supported. 
> Maybe the original separate "is supported" (pc->cap_user_rdpmc) and "is 
> enabled" (pc->index) checks are clearer. Each can result in a skip on 
> their own.
> 
> Thanks
> James
> 

Actually if we check /proc/sys/kernel/perf_user_access in the test we 
can keep it strict and assume that "supported" must equal "enabled" as 
long as perf_user_access is set. That might be better and keep the test 
useful. Otherwise it can start skipping if the feature breaks.

>>
>> I'm not sure on the support for the rdpmc file on ARM but it looks to
>> be wired up:
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools- 
>> next.git/tree/drivers/perf/arm_pmuv3.c?h=perf-tools-next#n324
>>
>> So in the test where you've changed it we've determined that rdpmc
>> shouldn't be supported but the shared page is saying the
>> cap_uesr_rdpmc is available. So is this an ARM PMU driver bug?
>> I wonder if the setting of cap_user_read:
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools- 
>> next.git/tree/drivers/perf/arm_pmuv3.c?h=perf-tools-next#n1615
>> should also be testing whether support has been disabled through the
>> rdpmc attribute? Hmm.. but x86 doesn't do that:
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools- 
>> next.git/tree/arch/x86/events/core.c?h=perf-tools-next#n2753
>>
>> So given that ARM and x86 look in sync, x86 doesn't have issues I'm
>> aware of, and it certainly looks like a failure inconsistency that the
>> test thinks that user rdpmc support is disabled but the page says
>> otherwise. I could use more details to understand this, like what's
>> the contents of the rdpmc file? In your commit message, is the
>> restricted PMU access the rdpmc file or a different capability? Could
>> this be a weird hybrid/BIG.little issue like on x86?
>>
>> Thanks,
>> Ian
>>
>> [1] https://lore.kernel.org/lkml/24bc287a-a3e0-45f6- 
>> a8f1-20a34e2f9af2@linux.intel.com/
>>
>>>>                          goto cleanup;
>>>>                  }
>>>>
>>>> -- 
>>>> 2.49.0
>>>>
>>>
> 

