Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77BC36A009;
	Thu, 22 Jan 2026 02:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769047805; cv=none; b=eJgCXZG6r+aUTM/btdC7jvLSoD6v9PEapHzADyVxvV3vqfGY2ijVVSv9eTDs7yegOL1g3dPd5iNzoSJXzLvNonhrXQA70d+OQEseeAOvKERrZw7BQIBUfs9UWrGuGIwU09d4pl6CjJhFpptsI/HFdVeBUTEX6d2AwwUSA31lFlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769047805; c=relaxed/simple;
	bh=rFFcgyLlYCQDV6CObL9H4vrnyQYAEVK9Yf5Jfrhnf8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r6UrBW7JMMTtLeLE7YDNe8wWU1pBxMgevci8YpZZaPwGKVFyHHaKMrTsP8Ly6z15eNGDaoR4RREEPoCnvIlRziIWE6jkBSRwmN2v62+4UXqcCQP20/pzavmNTz36ZY/YHV+legJ7pUJGxNaAg+uACEx4MBL6YA9B0A0XMQNwgRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TfWTpEm0; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TfWTpEm0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769047804; x=1800583804;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rFFcgyLlYCQDV6CObL9H4vrnyQYAEVK9Yf5Jfrhnf8c=;
  b=TfWTpEm0HR31VrywPVOzHpGgla2MPIrkQKxOl2YjWYJkSiakPVDU0Ss0
   MWyDdMZFenGjQT4yYajWMxSw91aN7LId/UZ2xEPP4n3mhg61mtsxLCKxH
   NMOFueSHMYPMj3b54fozDjwVRZR/+4n3lJ90kS9YsRudYmjdnIruZ05Z+
   Vo/zI45tsnxuITl+qeuGRsoc+RHjs1xfenTNmo6UHrVEs1/Hf4TM4+i4t
   IdoVUN0afupnEwetl7+DqttvtHErjZpJCwrSLX1L5d/mcPtXtwJMqf3fR
   QAyeePYmcrGjGNw45uwKNEJELz1Cn3me6n0mwmsIjUk1dJcVDP3wvvmQo
   w==;
X-CSE-ConnectionGUID: LC4NU5cdSCu+2hI06+5ejA==
X-CSE-MsgGUID: OVPP1jroSgKsoKixfRsp6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="95760429"
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="95760429"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 18:10:03 -0800
X-CSE-ConnectionGUID: zec7BvmgSuKApsAmChbK5g==
X-CSE-MsgGUID: 3NMe1aqRQ/uK16thrPUwhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="206861186"
Received: from unknown (HELO [10.238.3.254]) ([10.238.3.254])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 18:09:59 -0800
Message-ID: <f39e1250-228b-406e-95c2-1a30897dbd0d@linux.intel.com>
Date: Thu, 22 Jan 2026 10:09:57 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 11/13] perf pmu: Relax uncore wildcard matching to
 allow numeric suffix
To: "Chen, Zide" <zide.chen@intel.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Xudong Hao <xudong.hao@intel.com>, Falcon Thomas <thomas.falcon@intel.com>
References: <20251231224233.113839-1-zide.chen@intel.com>
 <20251231224233.113839-12-zide.chen@intel.com>
 <CAP-5=fVO+dSstWmYiTvu7o66hahiUKig4r=FEfu+FvUN8+nvcg@mail.gmail.com>
 <12dbc1f5-022d-4653-8ac7-01c503a860dd@linux.intel.com>
 <CAP-5=fXnMgwoa=VF2oK6D_rXvEOLCyq2PHkXoyN42KOgaWBTgQ@mail.gmail.com>
 <CAP-5=fVVZbb0qSDw+geqbb2m0rtb4gS3xSgO-iK6hJp-R2MWLQ@mail.gmail.com>
 <d8b6e506-a235-4d50-b223-bf979247c4ca@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <d8b6e506-a235-4d50-b223-bf979247c4ca@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 1/22/2026 3:03 AM, Chen, Zide wrote:
>
> On 1/21/2026 10:19 AM, Ian Rogers wrote:
>> On Wed, Jan 21, 2026 at 6:33 AM Ian Rogers <irogers@google.com> wrote:
>>> On Wed, Jan 21, 2026 at 12:02 AM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>>>>
>>>> On 1/21/2026 3:18 PM, Ian Rogers wrote:
>>>>> On Wed, Dec 31, 2025 at 2:49 PM Zide Chen <zide.chen@intel.com> wrote:
>>>>>> Diamond Rapids introduces two types of PCIe related uncore PMUs:
>>>>>> "uncore_pcie4_*" and "uncore_pcie6_*".
>>>>>>
>>>>>> To ensure that generic PCIe events (e.g., UNC_PCIE_CLOCKTICKS) can match
>>>>>> and collect events from both PMU types, slightly relax the wildcard
>>>>>> matching logic in perf_pmu__match_wildcard().
>>>>>>
>>>>>> This change allows a wildcard such as "pcie" to match PMU names that
>>>>>> include a numeric suffix, such as "pcie4_*" and "pcie6_*".
>>>>>>
>>>>>> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>>>>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>>>>> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>>>>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>>>>> Can we not merge this. I'd missed a perf tool patch as it was hiding
>>>>> in a bunch of kernel uncore updates. At the very least if wildcard
>>>>> conventions are updated then the corresponding documentation needs
>>>>> updating:
>>>>> Documentation/ABI/testing/sysfs-bus-event_source-devices
>>>> Ian, thanks for the information. We didn't notice there is such
>>>> documentation to describe the name. :(
>>>>
>>>> Besides the documentation, are there other comments? We can update it
>>>> together. Thanks.
>>> The suffix handling is notoriously brittle. For example, ARM added hex
>>> suffixes which are generally 12 characters of physical address rather
>>> than the typical _0, _1, etc. What could go wrong? Well in some
>>> situations ARM make their core PMU's follow the model name, so rather
>>> than armv8_pmuv3_0 the core pmu is a name that ends with a model
>>> number something like _a76, however, that is also a valid hex suffix.
>>> So we have bumped the hex suffix to be at least 2 characters:
>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmus.c?h=tmp.perf-tools-next#n81
>>> This also works around the naming of s390 PMUs (comments in the code).
>>> ARM now have models like a720ae which would appear as a 5 character
>>> hex suffix, and so this whole hex suffix thing is hanging together for
>>> some part because we treat core and uncore PMUs differently. From my
>>> pov, ideally the ARM uncore PMUs would have just used the _0, _1, etc.
>>> naming convention and placed the physical address information into a
>>> caps file, rather than trying to shoehorn it into the PMU name.
>>> s390 pmu names have discrepancies that mean lots of their core PMUs
>>> can match suffixes and Intel's i915 PMU name ("i915") will happily
>>> match as just "i" as the underscore before the number is optional. A
>>> change like this needs a range of testing on a variety of
>>> architectures because the code has broken things in a lot of different
>>> architecture types.
>>>
>>> Besides a lack of testing, going in through the wrong tree, the change
>>> is changing suffix handling in one place but not all - at least
>>> pmu_name_len_no_suffix wasn't updated. Let's get this out of the tree
>>> and start again.
>> To be explicit, things that I think are broken by this change:
>>
>> 1) ARM has PMUs called armv8_pmuv3_0, previously _0 would be the
>> suffix and now 3_0 becomes the suffix. There may be other existing
>> PMUs where this unintended behavioral change has happened. This may
>> break output formatting but I think as the patch is incomplete that
>> hasn't happened here.
>>
>> 2) as pmu_name_len_no_suffix wasn't updated it and assuming a machine
>> with uncore_pcie4_0, uncore_pcie4_1, uncore_pcie6_0, uncore_pcie6_1
>> and a common data_read event, the wildcarding for "pcie/data_read/"
>> should match the event on the 4 PMUs, however, rather than the PMU
>> name with no suffix (what pmu_name_len_no_suffix gives) being
>> uncore_pcie it will be either uncore_pcie4 or uncore_pcie6 depending
>> on which event/evsel we get the PMU name for. As the output will show
>> an aggregated amount the output for "perf stat -e pcie/data_read/ .."
>> the output may show just 1 event "pcie4/data_read/" rather than
>> "pcie/data_read/" as the suffix length calculation is off and the
>> number before the underscore not removed. In this example, it makes it
>> look like just 2 events on 2 PMUs were read rather than the full 4
>> events.
>>
>> So my point is, resolving this is complex and needs buy-in and testing
>> from at least s390 and ARM. The easiest thing to do for now is to
>> drop/revert the change.

Sigh, the PMU name wildcard comparison is over complicated than I imagine...

I have no objection to drop this specific perf tools patch. Thanks.


> Agreed. Thank you very much for pointing this out!
>
>
>> Thanks,
>> Ian
>>
>>> Thanks,
>>> Ian
>>>
>>>>> Thanks,
>>>>> Ian
>>>>>
>>>>>> ---
>>>>>>  tools/perf/util/pmu.c | 14 ++++++++------
>>>>>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>>>>>> index 956ea273c2c7..01a21b6aa031 100644
>>>>>> --- a/tools/perf/util/pmu.c
>>>>>> +++ b/tools/perf/util/pmu.c
>>>>>> @@ -939,6 +939,7 @@ static bool perf_pmu__match_wildcard(const char *pmu_name, const char *tok)
>>>>>>  {
>>>>>>         const char *p, *suffix;
>>>>>>         bool has_hex = false;
>>>>>> +       bool has_underscore = false;
>>>>>>         size_t tok_len = strlen(tok);
>>>>>>
>>>>>>         /* Check start of pmu_name for equality. */
>>>>>> @@ -949,13 +950,14 @@ static bool perf_pmu__match_wildcard(const char *pmu_name, const char *tok)
>>>>>>         if (*p == 0)
>>>>>>                 return true;
>>>>>>
>>>>>> -       if (*p == '_') {
>>>>>> -               ++p;
>>>>>> -               ++suffix;
>>>>>> -       }
>>>>>> -
>>>>>> -       /* Ensure we end in a number */
>>>>>> +       /* Ensure we end in a number or a mix of number and "_". */
>>>>>>         while (1) {
>>>>>> +               if (!has_underscore && (*p == '_')) {
>>>>>> +                       has_underscore = true;
>>>>>> +                       ++p;
>>>>>> +                       ++suffix;
>>>>>> +               }
>>>>>> +
>>>>>>                 if (!isxdigit(*p))
>>>>>>                         return false;
>>>>>>                 if (!has_hex)
>>>>>> --
>>>>>> 2.52.0
>>>>>>
>
