Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3151A2264A3;
	Tue, 22 Sep 2026 00:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790037065; cv=none; b=sE01LsHUGHf60KUhJMsPDjOwfNrZDvk4WGtNqDywn3eAFNwpdO6JZv8QG3xNeGCSHkXYWtirgNgXJwrClB0Coj3OsW0F2We9oAzLcVzfYOWOae/Z20QbOT256WnMrKiaLaLEMPzIwZUJHFF3cgW3GUupNaZJJev1Y401YmT7aNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790037065; c=relaxed/simple;
	bh=Rr1+pIF4jXLaJOS3sxjlKhpfnExf9QKmWrBEiL+6FkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EIASi8FaE1Qu1VrqoPhaqkGlXg4D3DFbkqtLHn5BUg6/25DU48FJu9P/it2+QmBeSFE9yqQMlasept6XwSJVXk2qgXFAFWvDXWiFERcEW0KLhgoIK/hS+llirmV+dRpEqaMEOJBrkuD8RPB9UmwwYatC4L2OeWt/WIOnqAiofjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aE/UoIvC; arc=none smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aE/UoIvC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790037063; x=1821573063;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Rr1+pIF4jXLaJOS3sxjlKhpfnExf9QKmWrBEiL+6FkE=;
  b=aE/UoIvCtJBYHq+XARZrpjdJ26evqD1ffEJy3Dtd7ThfSPlYyMsVAf0Y
   cVEjh2KOI9KRzkGoXSMTVBeGxFeBorJ6N+8WwbUdg0PRyfnZA+t0kPXPA
   Z1Hrn1WF0JXQvYXxxoe2LvBMKfoBvMpVimRR/PlHXgC8YqUS1juvOPEdu
   TYI5vXvf0DEQYi137BEV5ywz3IxyRGhhDN+zr7vQSmEzL2EFepPDpnh0O
   u0U57nJ7yojYWOXnOIXoNWNAXTmlHNpxMt+VWwL6BCUmcTD11rPTJnRy8
   lR2laHctjHkPE21DYgyVjF/gnn85VJXSJdLm2DMAcHdENpCmmcYFWOttg
   Q==;
X-CSE-ConnectionGUID: 6bee70QOTQeAZZPHiOruDg==
X-CSE-MsgGUID: ERTJw6gaSn+pzY8NvZfN0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="1104138"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="1104138"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 17:31:02 -0700
X-CSE-ConnectionGUID: N6fG3b75QeSR64C6C1fPzw==
X-CSE-MsgGUID: bFL63YsjRlSMSVzzk6bpGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="273046416"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 17:30:59 -0700
Message-ID: <27f7d33d-36b7-4eb6-bb16-d452d090397a@linux.intel.com>
Date: Tue, 22 Sep 2026 08:30:52 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf alsr: Add missing SIMD handling in
 aslr_tool__process_sample()
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260915091112.333308-1-dapeng1.mi@linux.intel.com>
 <024fd251-a4ba-443f-8aff-f5b1cdb062a3@linux.intel.com>
 <CAP-5=fUc_WOHAe4EkLVYuBgvQmxk7_XY4N+v8yJKNJQpCSObHg@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fUc_WOHAe4EkLVYuBgvQmxk7_XY4N+v8yJKNJQpCSObHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/22/2026 12:21 AM, Ian Rogers wrote:
> On Sun, Sep 20, 2026 at 11:42 PM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>> Kindly ping ...
>>
>> @Arnaldo, @Namhyung, @Ian, not sure if you have bandwidth to review this
>> small patchset which fixes the Sashiko found minor issues for the "Perf
>> tools: Support eGPRs/SSP/SIMD registers sampling" patchset?
>>
>> If possible, it's better to be queued in this cycle, then we don't need
>> extra backporting. Thanks.
> Reviewed-by: Ian Rogers <irogers@google.com>
>
>> On 9/15/2026 5:11 PM, Dapeng Mi wrote:
>>> Currently the SIMD register sampling is supported, but the corresponding
>>> handling is missed in aslr_tool__process_sample(). This can break parsing
>>> of the sample record.
>>>
>>> Add the missing SIMD register handling in aslr_tool__process_sample().
>>>
>>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>> ---
>>>
>>> These two patches fix Sashiko reported defects for the patchset:
>>> "Perf tools: Support eGPRs/SSP/SIMD registers sampling"
>>> https://lore.kernel.org/all/20260914014049.2061519-1-dapeng1.mi@linux.intel.com/
>>>
>>>  tools/perf/util/aslr.c | 31 +++++++++++++++++++++++++++++++
>>>  1 file changed, 31 insertions(+)
>>>
>>> diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
>>> index 027695d96779..a097084201a0 100644
>>> --- a/tools/perf/util/aslr.c
>>> +++ b/tools/perf/util/aslr.c
>>> @@ -19,6 +19,7 @@
>>>  #include <internal/lib.h>  /* page_size */
>>>  #include <linux/compiler.h>
>>>  #include <linux/zalloc.h>
>>> +#include <linux/overflow.h>
>>>  #include <errno.h>
>>>  #include <inttypes.h>
>>>  #include <unistd.h>
>>> @@ -992,6 +993,34 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
>>>                               COPY_U64();
>>>               }
>>>       }
>>> +
>>> +#define CHECK_SIMD() \
>>> +     do { \
>>> +             if (abi & PERF_SAMPLE_REGS_ABI_SIMD) { \
>>> +                     u64 nr_vector, vec_qwords; \
>>> +                     u64 nr_pred, pred_qwords; \
>>> +                     u64 header_len, vec_len, pred_len, simd_len; \
>>> +                     if (CHECK_BOUNDS(nr + 4, nr + 4)) { \
>>> +                             ret = -EFAULT; \
>>> +                             goto out_put; \
>>> +                     } \
>>> +                     header_len = 4; \
>>> +                     nr_vector = in_array[i + nr]; \
>>> +                     vec_qwords = in_array[i + nr + 1]; \
>>> +                     nr_pred = in_array[i + nr + 2]; \
>>> +                     pred_qwords = in_array[i + nr + 3]; \
>>> +                     if (check_mul_overflow(nr_vector, vec_qwords, &vec_len) || \
>>> +                         check_mul_overflow(nr_pred, pred_qwords, &pred_len) || \
>>> +                         check_add_overflow(vec_len, pred_len, &simd_len) || \
>>> +                         check_add_overflow(header_len, simd_len, &simd_len) || \
>>> +                         check_add_overflow(nr, simd_len, &nr) || \
>>> +                         nr > max_i - i) { \
>>> +                             ret = -EFAULT; \
>>> +                             goto out_put; \
>>> +                     } \
>>> +             } \
>>> +     } while (0)
>>> +
>>>       if (orig_sample_type & PERF_SAMPLE_REGS_USER) {
>>>               u64 abi;
>>>
>>> @@ -1007,6 +1036,7 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
>>>                               ret = -EFAULT;
>>>                               goto out_put;
>>>                       }
>>> +                     CHECK_SIMD();
>>>                       i += nr;
>>>               }
>>>       }
>>> @@ -1061,6 +1091,7 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
>>>                               ret = -EFAULT;
>>>                               goto out_put;
>>>                       }
>>> +                     CHECK_SIMD();
> nit: at the end of the function you could #undef CHECK_SIMD to make it
> more explicit that the macro only makes sense within the function.

Sure. Thanks.


>
> Thanks,
> Ian
>
>>>                       i += nr;
>>>               }
>>>       }
>>>
>>> base-commit: 91b0782fc9e9d2f0a40b5256146e014802fdbb36
