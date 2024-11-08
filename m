Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58061F26C5;
	Fri,  8 Nov 2024 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731088890; cv=none; b=nI+D62Ewcs1lY7TJWpEk3dsLpspzW2KnW8d3R8MPbpGeUQkedL/Qg1FdKS2c7Ha7FaWLtKEU+KLadpCnJnRUVGywyY8ZOBQMEAgziMnnJqQ7xqGsyNUJGFrqlMMRtjE3Jyh+tXgg9Ibn7mWx/DsgZHbwczjxi2h59Y0qeiAB10I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731088890; c=relaxed/simple;
	bh=35sYeiJo5xS7xz/cHvI/Q6kimidHt4m9ErVWVWVgItw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lePefQtJEQeFif3Mp3us6vFFtj1pGmSQeiG/WtllON8Df4LFJf8y4/GlrIp9a3mpCoaGQX1vfZR11zMpoq9sUWZ14mTwGFeRxYRZllGhs7u2IrqxbkoMfCWSwbaI0AneNePcigsMpw7KEGxo/sELqkxG/OoRjdZkPkfGsc7xOmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=do1PYAx5; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="do1PYAx5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731088889; x=1762624889;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=35sYeiJo5xS7xz/cHvI/Q6kimidHt4m9ErVWVWVgItw=;
  b=do1PYAx58sxGS0FB84eTzPmLoRpiVM4joJvyvFQVNhfOs2uDfHcLeaaH
   2LXEUxESp8AcTCs5+Ra7VIvh1+KRuOM1umYpQnJyFrcud6+SvZUgIb5nQ
   aFZu6yQ1bYVBFmanGwij7vKw+VdMisbyEr5rSAAIurkit4WeAzvKmamVi
   tNqtkYnrCCoxefxfXyQktFQ3n6VIH5UCFfS8xZzXdu/88eEfpIgm5c90o
   ggH0J+E9y5E8gEzbxvqD3SgnalSunz+vxtQEfRVx+msQ6mjm2ZCvYWR3x
   30Gbm0OwE6xuIbB1CB8Xjw2g2QtUitbkdMBIYJ8CnS9AMEnBuxPmhW2Iu
   A==;
X-CSE-ConnectionGUID: MiC5EiEITZiXFPTT2PXEFg==
X-CSE-MsgGUID: /v1vHDJAQ/upZ5VxtiZDNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31138212"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31138212"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 10:01:28 -0800
X-CSE-ConnectionGUID: 1G07uf8uR2O8hVE6/3A//A==
X-CSE-MsgGUID: ekonjwKtQkWBKVyjdu4htw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="85812778"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 10:01:11 -0800
Message-ID: <b97a8aa8-37b1-4d8f-9de0-f294fcd07adb@intel.com>
Date: Fri, 8 Nov 2024 20:01:02 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V14 08/11] perf tools: Add missing_features for
 aux_start_paused, aux_pause, aux_resume
To: Namhyung Kim <namhyung@kernel.org>, Leo Yan <leo.yan@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Will Deacon
 <will@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Andi Kleen <ak@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, H Peter Anvin <hpa@zytor.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20241022155920.17511-1-adrian.hunter@intel.com>
 <20241022155920.17511-9-adrian.hunter@intel.com>
 <20241108154152.GA197781@e132581.arm.com> <Zy5M1WJ97GprNniq@google.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <Zy5M1WJ97GprNniq@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/11/24 19:39, Namhyung Kim wrote:
> Hello,
> 
> On Fri, Nov 08, 2024 at 03:41:52PM +0000, Leo Yan wrote:
>> Hi Adrian,
>>
>> On Tue, Oct 22, 2024 at 06:59:14PM +0300, Adrian Hunter wrote:
>>>
>>> Display "feature is not supported" error message if aux_start_paused,
>>> aux_pause or aux_resume result in a perf_event_open() error.
>>>
>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>> Acked-by: Ian Rogers <irogers@google.com>
>>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>>> ---
>>>
>>>
>>> Changes in V13:
>>>         Add error message also in EOPNOTSUPP case (Leo)
>>>
>>>
>>>  tools/perf/util/evsel.c | 12 ++++++++++++
>>>  tools/perf/util/evsel.h |  1 +
>>>  2 files changed, 13 insertions(+)
>>>
>>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>>> index 95593b55d9a7..88b31a005ac6 100644
>>> --- a/tools/perf/util/evsel.c
>>> +++ b/tools/perf/util/evsel.c
>>> @@ -2102,6 +2102,12 @@ bool evsel__detect_missing_features(struct evsel *evsel)
>>>                 perf_missing_features.inherit_sample_read = true;
>>>                 pr_debug2("Using PERF_SAMPLE_READ / :S modifier is not compatible with inherit, falling back to no-inherit.\n");
>>>                 return true;
>>> +       } else if (!perf_missing_features.aux_pause_resume &&
>>> +           (evsel->core.attr.aux_pause || evsel->core.attr.aux_resume ||
>>> +            evsel->core.attr.aux_start_paused)) {
>>> +               perf_missing_features.aux_pause_resume = true;
>>> +               pr_debug2_peo("Kernel has no aux_pause/aux_resume support, bailing out\n");
>>> +               return false;
>>
>> This patch fails to apply on the latest perf-tools-next branch due to
>> conflict:
>>
>>   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git
>>   branch: perf-tools-next
>>
>> You might need to rebase it on the latest code base.
> 
> Yep, please do for the tooling patches.

I'd noticed that, but there is more work to sort it out.
The probing simply won't work when there are dependencies
on other events, or other attr members.  But there is no
point in trying to "fallback" in that case either.  It is
just a failure, but what *is* still needed is a sensible
error message.

The other patches, including the ones that come after,
still apply by the way, or they did the other day, so
they could be applied anyway.

