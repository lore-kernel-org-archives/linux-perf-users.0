Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9E1257831;
	Tue, 11 Nov 2025 22:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762900582; cv=none; b=YabggOademw+yyW9Bxn9WKYAwuoB1fk0BS7uejomk+ZA4AeFub1X/CE8c+zJ2kccMuPvAj8/AzmORuN/jP9xHV7JAMDNLvAr4C18Ck92QBmNO/4j7hcoOsPKV0jjnv6CO9ERJXJf7vCT9E+k+qqBe3bd2n1nN3eOzdbcxBf86TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762900582; c=relaxed/simple;
	bh=cBD2WXd6GLxyKJOuQomnuxFYv9+0Zlpl/oZDWDTbzs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NXSMPKhwXkFogt/Kum7MVrVobXDqDsWzDBzHYsYN/rGeAcQu5qzSrsEuAGjQsgNMAZSVgXV8swHEuAH3R3F9CDlNRYZMUZCmDPO4yIMkUyG08gfd+MbTp0nHuzWVkQufSqKyfbTSoEFlqFT6SQdhP+YxQqjLGOXYC+W1nWw6wwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U8qbgyIi; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U8qbgyIi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762900581; x=1794436581;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cBD2WXd6GLxyKJOuQomnuxFYv9+0Zlpl/oZDWDTbzs0=;
  b=U8qbgyIiMZev2Zw4JZuFKrgi4CkyoBjlS8qcV1HUDcW4j8/5BtrkhsDq
   yzZWb46yugNERk/KTbnsafxVx/I79zex7YWvG/ZTlkOsxsLBCLBz3Dr5Z
   aT3qRirqE5WI4dgz7+xsEEdOEemjUPFUTfzNG5LUQWGoalXIhXHfAJ8uD
   TbFZKCVNCf+mmya7Bx/g3mlhfenZMPSX844GDNgbsH6JjIWjJ3R9UUdx+
   y+ZdgI1+zFkPe/Yd8GCU2usE2nFcHfZfOaxBY857ItcIgoCvfIApNPtaW
   N5soHtK1XmwpFPnppAJ70IwzlfcJwCgv3Wap1OhGtNGKz2Hpim8uDPydF
   g==;
X-CSE-ConnectionGUID: LcxBvZFsRka/91CEbqg9aA==
X-CSE-MsgGUID: 5EBiJzoNSZGPOGIlK2mxWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64897780"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64897780"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 14:36:21 -0800
X-CSE-ConnectionGUID: vbA4fcajRku4c7YuCSPKFg==
X-CSE-MsgGUID: F92hb3nOTpiyRaszuXXkZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,297,1754982000"; 
   d="scan'208";a="188362697"
Received: from rykambar-mobl1.gar.corp.intel.com (HELO [10.125.180.197]) ([10.125.180.197])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 14:36:20 -0800
Message-ID: <3f2e834b-36d1-4227-b1bd-843e824ac353@intel.com>
Date: Tue, 11 Nov 2025 14:36:19 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tools: Fix missing feature check for inherit +
 SAMPLE_READ
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
References: <20251111075944.2328021-1-namhyung@kernel.org>
 <ac137eff-674c-4fa4-b870-80878af032a0@intel.com>
 <aRORSxu22OSf-v0X@google.com>
 <7ea7c72d-7570-4eca-8a8a-d8f93363691e@intel.com>
 <aRO5Tuz_-m5PX9Pz@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <aRO5Tuz_-m5PX9Pz@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/11/2025 2:31 PM, Namhyung Kim wrote:
> On Tue, Nov 11, 2025 at 12:03:22PM -0800, Chen, Zide wrote:
>>
>>
>> On 11/11/2025 11:40 AM, Namhyung Kim wrote:
>>> On Tue, Nov 11, 2025 at 11:13:20AM -0800, Chen, Zide wrote:
>>>>
>>>>
>>>> On 11/10/2025 11:59 PM, Namhyung Kim wrote:
>>>>> It should also have PERF_SAMPLE_TID to enable inherit and PERF_SAMPLE_READ
>>>>> on recent kernels.  Not having _TID makes the feature check wrongly detect
>>>>> the inherit and _READ support.
>>>>>
>>>>> It was reported that the following command failed due to the error in
>>>>> the missing feature check on Intel SPR machines.
>>>>>
>>>>>   $ perf record -e '{cpu/mem-loads-aux/S,cpu/mem-loads,ldlat=3/PS}' -- ls
>>>>>   Error:
>>>>>   Failure to open event 'cpu/mem-loads,ldlat=3/PS' on PMU 'cpu' which will be removed.
>>>>>   Invalid event (cpu/mem-loads,ldlat=3/PS) in per-thread mode, enable system wide with '-a'.
>>>>>
>>>>> Fixes: 3b193a57baf15c468 ("perf tools: Detect missing kernel features properly")
>>>>> Reported-by: "Chen, Zide" <zide.chen@intel.com>
>>>>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>>>>> ---
>>>>>  tools/perf/util/evsel.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>>>>> index 67a898cda86ab559..989c56d4a23f74f4 100644
>>>>> --- a/tools/perf/util/evsel.c
>>>>> +++ b/tools/perf/util/evsel.c
>>>>> @@ -2474,7 +2474,7 @@ static bool evsel__detect_missing_features(struct evsel *evsel, struct perf_cpu
>>>>>  	/* Please add new feature detection here. */
>>>>>  
>>>>>  	attr.inherit = true;
>>>>> -	attr.sample_type = PERF_SAMPLE_READ;
>>>>> +	attr.sample_type = PERF_SAMPLE_READ | PERF_SAMPLE_TID;
>>>>
>>>>
>>>> Seems this could have some unintended side effects. For example,
>>>> consider a :ppp event with PERF_SAMPLE_READ and inherit attributes
>>>> running on a system where the maximum precise_ip is 2:
>>>>
>>>> - It fails to open the event on the first attempt;
>>>> - It goes through the inherit_sample_read detection and fails again
>>>> after removing inherit;
>>>
>>> This is not what we want.  The kernel supports inherit + SAMPLE_READ
>>> so it should not remove the inherit bit.
>>>
>>>
>>>> - Finally, it succeeds after falling back to precision 2 — but the
>>>> inherit attribute has been unexpectedly removed.
>>>
>>> So it'll fallback to precision 2 without removing inherit.
>>>
>>>>
>>>> I may have missed something, but I don’t quite understand why commit
>>>> 3b193a57baf15 ("perf tools: Detect missing kernel features properly")
>>>> performs the check on a dummy evsel instead of the original one. In this
>>>> way, it might incorrectly fall back an attribute that doesn’t actually help.
>>>
>>> Because different platforms have different limitations on hardware
>>> events.  You cannot simply use current event for kernel feature check
>>> since it can result in wrong decisions due to the limitation.  So we
>>> picked the software event to avoid the hardware characteristics and to
>>> focus on kernel features.
>>>
>>>>
>>>> This means evsel__detect_missing_features() could theoretically roll
>>>> back a feature that might not actually work. Given that it cannot
>>>> restore the original evsel state after a failed attempt, side effects
>>>> may occur.
>>>
>>> The purpose is to turn off the non-supported features only and try with
>>> other settings like precise_ip and exclude_kernels and so on.
>>
>> OK, thanks!
> 
> Can you please confirm if this patch fixes your problem?

Yes, it works!
> Thanks,
> Namhyung
> 

