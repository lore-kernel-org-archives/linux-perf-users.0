Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683C3598BEB
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789656407; cv=none; b=i9BlaHYu+eXWDk5yBoq7PunKgT0qL5622KZh6IkzLDv8BfZKufxgTjxTtYwZyQzMnqM2rWu/pdSVrScF2uvYPZn2FcmmLJiAPdg+PwqKYu1u1z06SrAjsUWQHtycvw0Jj6251OrJbrRyq2UyARuQHhDaBj8Tm45OZ4fR444eMyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789656407; c=relaxed/simple;
	bh=wYdra0/rb995jwKqL3ELavlEIZq2PrYqyO7Wol0SOSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ijlmfag2HVgJ9STNuoN3IrNyLnI7yZJsWmpkdxd/G8oOAUC27f5CqO741KcVXr52xi3rlDWaXgNxO8t9fs2SMOdNVSVMHnjDuvxcROdMlOmBWJQ7pU7ILlwbyK0DNxFHOnAnUaeFsRsT+/AHWpUfUwRPmJcft6jKM3Agl20Yn1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EUF3iujl; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EUF3iujl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789656399; x=1821192399;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wYdra0/rb995jwKqL3ELavlEIZq2PrYqyO7Wol0SOSc=;
  b=EUF3iujlKnCs7OlSXxF4KkjuQaZLB7tBsBAp9o1J8YN6BezdjmBoHmFO
   86/H2MUwYl9SSUm2imQ8eh4LIcbfKMTAVkpqDnmUF+Ed3XDlg9qxeTe52
   gpVugCq+6z8zNn5LSHCJVXO6WMv+qo4ygd3s+43DUI9EfFl69UEYtTjET
   BOnXBaelRVDvMNWmLzJvKsUvDfHr/RN6qzGdngTnKmkrbS6SKsxkliUeB
   dggF+NR+tPDp1ttaotBzzOI++TNFrQxppCdIPtRNwO6/6FdejQySZkF9R
   qsjlZ1LQGbLScmYdbr0Mo0AowiUhq+wDAIwKPjCdGYzXCCMrBk6gGcwsh
   g==;
X-CSE-ConnectionGUID: lJCaC6FDT0iQPvwc81cQug==
X-CSE-MsgGUID: P+78RksgT5mShJfdGZP9zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101429521"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="101429521"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 07:46:34 -0700
X-CSE-ConnectionGUID: 2UwuFsgDRD2V5F61XYstEQ==
X-CSE-MsgGUID: thdfgHLzRAqtu9BPuY/qUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2058893"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 07:46:34 -0700
Message-ID: <048b0319-470e-4f8b-816f-c7c835a43974@intel.com>
Date: Thu, 17 Sep 2026 09:46:33 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf topdown: Don't require config1==0 for a slots event
To: Ian Rogers <irogers@google.com>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
References: <20260916202740.257376-1-zide.chen@intel.com>
 <20260916204416.80E761F000FF@smtp.kernel.org>
 <9e86d9e4-7aee-4c1b-8812-94aecb2a2cea@intel.com>
 <CAP-5=fVkubfWSoQbZRmC7Xg-4SHM-=ickZub7zi4SDuFAhZuCg@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CAP-5=fVkubfWSoQbZRmC7Xg-4SHM-=ickZub7zi4SDuFAhZuCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/16/2026 6:00 PM, Ian Rogers wrote:
> On Wed, Sep 16, 2026 at 2:52 PM Chen, Zide <zide.chen@intel.com> wrote:
>>
>> On 9/16/2026 3:44 PM, sashiko-bot@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>>> - [Low] perf: missing explicit <stdio.h> and <string.h> inclusions
>>> --
>>>
>>> commit 197eea3115a0d065dc53e6f96ad2fd38fdb9bc99
>>> Author: Zide Chen <zide.chen@intel.com>
>>>
>>> perf topdown: Don't require config1==0 for a slots event
>>>
>>> This commit modifies the topdown slots architecture check to no longer require
>>> config1 == 0, fixing an issue where explicit slots events were duplicated in
>>> scheduling. It also adds a new test to verify that an explicit metrics_clear
>>> slots event doesn't trigger extra injections.
>>>
>>>> diff --git a/tools/perf/arch/x86/tests/topdown.c b/tools/perf/arch/x86/tests/topdown.c
>>>> index 2b6f47ce49324..b1ce9f83db00e 100644
>>>> --- a/tools/perf/arch/x86/tests/topdown.c
>>>> +++ b/tools/perf/arch/x86/tests/topdown.c
>>> [ ... ]
>>>> @@ -229,10 +229,38 @@ static int test__x86_topdown_slots_injection(struct test_suite *test __maybe_unu
>>>>      return TEST_OK;
>>>>  }
>>>>
>>>> +/*
>>>> + * An explicit "slots,metrics_clear=1" event is still the slots event and
>>>> + * must not cause an extra slots event to be injected into the group.
>>>> + */
>>>> +static int test__x86_topdown_metrics_clear(struct test_suite *test __maybe_unused,
>>>> +                                       int subtest __maybe_unused)
>>>> +{
>>>> +    struct perf_pmu *pmu;
>>>> +    char event_str[128];
>>>> +    int ret;
>>>> +
>>>> +    if (!topdown_sys_has_perf_metrics())
>>>> +            return TEST_OK;
>>>> +
>>>> +    pmu = perf_pmus__find_by_type(PERF_TYPE_RAW);
>>>> +    if (!pmu || !perf_pmu__has_format(pmu, "metrics_clear"))
>>>> +            return TEST_OK;
>>>> +
>>>> +    snprintf(event_str, sizeof(event_str),
>>>> +             "{%s/slots,metrics_clear=1/,%s/topdown-retiring/}",
>>>> +             pmu->name, pmu->name);
>>>
>>> [Severity: Low]
>>> Does this new function test__x86_topdown_metrics_clear() need explicit header
>>> inclusions for musl compatibility?
>>>
>>> This code relies on an implicit declaration of <stdio.h> for snprintf().
>>> Missing POSIX headers can cause build failures when compiling the perf tool
>>> with strict libc implementations like musl instead of glibc.
>>>
>>> Should <stdio.h> (and potentially <string.h>) be explicitly included at the top
>>> of this file to prevent musl compilation failures?
>>
>> Not needed. tools/perf/util/pmu.h, along with debug.h (which is also
>> included), explicitly pulls in <stdio.h>.
>>
>> Additionally, this file already contains other calls to snprintf(). If
>> the required header dependency were missing, those existing uses would
>> already fail to build.
> 
> In general we want to avoid transitive includes as they are brittle.
> For example, if pmu.h and/or debug.h were changed, it might break
> musl.

OK, then I can add stdio.h and string.h to topdown.c.

> Thanks,
> Ian

