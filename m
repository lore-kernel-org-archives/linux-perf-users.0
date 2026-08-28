Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2373CA4B5;
	Fri, 28 Aug 2026 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787904706; cv=none; b=g0KDHpQXF1wYmkKCrirxw1UfL0XWaaQms9wb4VVtHD+e6G62VUltSbbWG9RSPsU9bIWbTBSV8w9A5lOywYR7ByLtFvWFpyZtinkUf0HeWSRjmLOoW45hqI5cxN4N2GBuvXTFNugam6Iiu096BujnPZOCWrbPbMwE2orZhJKk0zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787904706; c=relaxed/simple;
	bh=/TNjmY6gIsbYZTaMZJVRiVulAyyQ0/zP0EK/2SAVwTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QYo0sjCql1yhk/yWbPYP9U1GKzUEVk0ywrOFJ8xov29v1xWLZcbucHO5BG7ICsiSKFJ7qC5wTE32iFlrEcEOlAbyfciMXDLhqu3fidjDDKagi4jbQF8Sp/+YYEbcQlvFIqgYfKCDn7GjNFwlRTkNyp6KnkDZ0t89K2hdzkH25fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UkCqCyRC; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UkCqCyRC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787904705; x=1819440705;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/TNjmY6gIsbYZTaMZJVRiVulAyyQ0/zP0EK/2SAVwTY=;
  b=UkCqCyRCl2xSDY2B7BWOcflQjSmPhthOAV3AbOGxyGWy1u6LAdJzdsDa
   IlBqCLDywnPDu50XgXLFWcfJaPdJxUOA7Iy4Uzz/UdUPmEeFQa9uaiQMW
   gZeJqXbzBfjSEdHNvTKZDLpYl7yJgt13uCOzMXTuSjTLR4/MftDrOo74g
   E1OjWSlOkIOdmEx+Kofr56Cuzzoiysd6C3V/bUuLmvJjyAYJD/R6daDMj
   DYC7H/HBcpzRuEbD23m6GSKLS6RJ309wvt96IW7GMCXvTzsz6kkXGqIV6
   DmvkoRQo8b328K7ZyLEPrzN0Xx2zyK9yeO9SCZxly1zroDpaDigh1kyDh
   A==;
X-CSE-ConnectionGUID: Pif26tCAQBm5UTMyJGeI2A==
X-CSE-MsgGUID: svyIRq7bTOOx9sL7u6AOPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88334541"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="88334541"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 01:11:45 -0700
X-CSE-ConnectionGUID: krGd7fMwQESVWlgHwP8hUw==
X-CSE-MsgGUID: ZiNATS8lQ1iO7porRt2EEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="264843426"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 01:11:40 -0700
Message-ID: <29d02905-14fd-4c2a-86d0-a605e9d41b10@linux.intel.com>
Date: Fri, 28 Aug 2026 16:11:38 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v7 1/2] perf pmu intel: Generalize SNC cpumask
 adjustment for multiple platforms
To: Ian Rogers <irogers@google.com>, Chun-Tse Shao <ctshao@google.com>,
 Zide Chen <zide.chen@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20260527221934.3830896-1-ctshao@google.com>
 <20260528001117.3BBF11F00A3A@smtp.kernel.org>
 <CAJpZYjUiNdN3a6y+8rs=YP2Mgtj6EQJnkiB9TN_suWd8fGkoEg@mail.gmail.com>
 <CAJpZYjUhw8+ouKTS82G6ih457=pHn18AtvwMCAcaTL9csKmdTg@mail.gmail.com>
 <CAP-5=fVAckZihxg4djQn7iTGbNNT1vFLXt2En8mm8+COSs3GcQ@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fVAckZihxg4djQn7iTGbNNT1vFLXt2En8mm8+COSs3GcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 8/28/2026 1:28 PM, Ian Rogers wrote:
> On Tue, Jun 9, 2026 at 11:44 AM Chun-Tse Shao <ctshao@google.com> wrote:
>> Ping for attention.
> I suspect Arnaldo and Namhyung are waiting for feedback from Intel on
> these patches. If someone could check them it would be appreciated.

I suppose Zide has checked these patches and gave the "reviewed-by" tags. :)


>
> Thanks,
> Ian
>
>> Thanks,
>> CT
>>
>> On Thu, May 28, 2026 at 2:31 PM Chun-Tse Shao <ctshao@google.com> wrote:
>>> On Wed, May 27, 2026 at 5:11 PM <sashiko-bot@kernel.org> wrote:
>>>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>>>>
>>>> Pre-existing issues:
>>>> - [Critical] An integer overflow in `uncore_cha_snc()` can result in a negative Sub-NUMA Clustering (SNC) node index. This bypasses the upper-bound check against `MAX_SNCS` and causes subsequent out-of-bounds array accesses.
>>>> --
>>>>
>>>> commit be394e8b7ddbe730c3fc40fb608337fe19c7b33b
>>>> Author: Chun-Tse Shao <ctshao@google.com>
>>>>
>>>> perf pmu intel: Generalize SNC cpumask adjustment for multiple platforms
>>>>
>>>> This commit generalizes the Sub-NUMA Clustering (SNC) logic previously
>>>> specific to Granite Rapids to support multiple Intel platforms. It uses
>>>> CPUID to determine SNC support and caches various PMU configurations
>>>> to improve thread safety.
>>>>
>>>>> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
>>>>> index 7c9d238922a6c..9b00d5720fb7a 100644
>>>>> --- a/tools/perf/arch/x86/util/pmu.c
>>>>> +++ b/tools/perf/arch/x86/util/pmu.c
>>>> [ ... ]
>>>>
>>>>> @@ -121,46 +142,73 @@ static int uncore_cha_snc(struct perf_pmu *pmu)
>>>>>               return 0;
>>>>>       }
>>>>>       chas_per_node = num_cha / snc_nodes;
>>>>> +     if (chas_per_node == 0) {
>>>>> +             pr_warning("Unexpected: chas_per_node is 0 (num_cha=%d, snc_nodes=%d)\n",
>>>>> +                        num_cha, snc_nodes);
>>>>> +             return 0;
>>>>> +     }
>>>>>       cha_snc = cha_num / chas_per_node;
>>>>>
>>>>>       /* Range check cha_snc. for unexpected out of bounds. */
>>>>>       return cha_snc >= MAX_SNCS ? 0 : cha_snc;
>>>> [Severity: Critical]
>>>> This is a pre-existing issue, but does this range check safely handle very
>>>> large values for cha_num?
>>>>
>>>> Since cha_num is parsed as an unsigned int via sscanf() from the PMU name,
>>>> and cha_snc is a signed int, a sufficiently large cha_num could cause the
>>>> division result to overflow into a negative value.
>>> I think it is very unlikely we would see cha_num > INT_MAX.
>>> Since that is a pre-existing issue, I prefer to fix it separately.
>>>
>>> Thanks,
>>> CT
>>>
>>>> If cha_snc becomes negative, the cha_snc >= MAX_SNCS check evaluates to
>>>> false, allowing the function to return a negative index.
>>>>
>>>> Could this negative index then cause out-of-bounds array accesses when used
>>>> later in uncore_cha_imc_compute_cpu_adjust()?
>>>>
>>>> uncore_cha_imc_compute_cpu_adjust() {
>>>>     static bool checked_cpu_adjust[MAX_SNCS];
>>>>     ...
>>>>     if (checked_cpu_adjust[pmu_snc])
>>>>     ...
>>>> }
>>>>
>>>> --
>>>> Sashiko AI review · https://sashiko.dev/#/patchset/20260527221934.3830896-1-ctshao@google.com?part=1
