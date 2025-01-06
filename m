Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293B2159565;
	Mon,  6 Jan 2025 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736171072; cv=none; b=ZZBk8fWO0m7BtHnxXCZYMvX5JFIZAg68s4G1BKcnuVdgcOKcgKiiDlFfSYVoRvhaPa0pK+ERVjdu/EGiAxjc7q4Vh1QDKUIpcepRXa72MarKKqK0mkRaXznmXe9+/NWarUwJBybyk8OARm4/9NOdWb9QwX9fZDuCZmyI52UxZUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736171072; c=relaxed/simple;
	bh=0z9SGlioUYA2SvV4leJI/Cg4ExvFo74WDOjRs0K+Wrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y2Hk4mOJHkEjOXfpJAdx022M78TVcRyE4OGmD32QsoQE46qHN98P9NSZqxW7DWgmJTdk97UoXhTM/2a8gwQmcYgjL6X4O4uuJtM+838uQY79s6yqEk6KY1GhhdRaW8conx5aMVgu3+ZFrqqB5YARILpcsokJNlGzau+biLS7jfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gKnegqfc; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gKnegqfc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736171071; x=1767707071;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0z9SGlioUYA2SvV4leJI/Cg4ExvFo74WDOjRs0K+Wrw=;
  b=gKnegqfcCP9DJWcRCe9bQJykCXHM8LkOTkTjgWK6oQ2xqtoxHNcR20xL
   c1YPLKULuDx2q7uBA6gA9dJY0KNfiGNYA9LpyR3Aq7C9LrFnbGD5gG81f
   mcMiemMKx3RViPOr6WWCutgrBtrL7s/GBMnMBEOD7DNEtikg8UKa/Ij/M
   8QW4wlR5Z0PDSdxSIImA/oMU8qXt5WyfoTl47fjfPg7ZlLsNAjM2/cprp
   C9i785l4eAMB36KAD/8QwVD2idz8jFdG3Cw9jcuYGm4GXXHooaD/anEQ+
   Ozin//I0639U4RN+KWgmkCA26RggG0B1RLuGhzxtU9V03t5fb7DylfSY+
   A==;
X-CSE-ConnectionGUID: yex5P8DMR2S3v0Yxrm2BdQ==
X-CSE-MsgGUID: 75wrS8B6S4yWRnVq1sFF+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="23920002"
X-IronPort-AV: E=Sophos;i="6.12,292,1728975600"; 
   d="scan'208";a="23920002"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 05:44:30 -0800
X-CSE-ConnectionGUID: nQsI0ZDaSfeG1I/HxQI2wg==
X-CSE-MsgGUID: 2UvKxlI4SFe5XBCd8DMdEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,292,1728975600"; 
   d="scan'208";a="102528944"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 05:44:30 -0800
Received: from [10.246.136.10] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.10])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 2806920B5713;
	Mon,  6 Jan 2025 05:44:29 -0800 (PST)
Message-ID: <a6218176-965e-4d69-992b-15d7cc5482ec@linux.intel.com>
Date: Mon, 6 Jan 2025 08:44:27 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel/uncore: Fix the lack of ch_mask format for
 SPR
To: Jing Zhang <renyu.zj@linux.alibaba.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Falcon <thomas.falcon@intel.com>
References: <1735542672-113067-1-git-send-email-renyu.zj@linux.alibaba.com>
 <7e5376f1-ee87-458b-b55e-759125d251a2@linux.intel.com>
 <9f233d6e-ee4b-4ea3-96ee-397bba1b73b0@linux.alibaba.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <9f233d6e-ee4b-4ea3-96ee-397bba1b73b0@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025-01-05 9:16 p.m., Jing Zhang wrote:
> 
> 
> 在 2025/1/3 上午3:02, Liang, Kan 写道:
>>
>>
>> On 2024-12-30 2:11 a.m., Jing Zhang wrote:
>>> perf stat errors out with UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC_LOCAL event
>>> because of lack of ch_mask format in drivers, and perf test "104: perf
>>> all PMU test (exclusive)" failed.
>>>
>>> $perf stat -e perf stat -e UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC_LOCAL
>>> sleep 1
>>>
>>> Initial error:
>>> event syntax error: 'UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC_LOCAL'
>>>                                 \___ unknown term 'ch_mask' for pmu 'uncore_cha_0'
>>>
>>> 104: perf all PMU test (exclusive)                                   : FAILED!
>>>
>>> Add ch_mask format for SPR to fix it.
>>>
>>
>> I don't think there is a ch_mask. It should be extended umask.
>> The issue of the CHA extended umask should has been fixed by
>> https://lore.kernel.org/lkml/172052531679.2215.16140288595428337453.tip-bot2@tip-bot2/
>>
> 
> I think it is not the same issue. I have this patch but still error.
> 
> in "tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-cache.json",
> the event "UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC_LOCAL" is described as:
> {
>         "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC_LOCAL",
>         "Counter": "0,1,2,3",
>         "EventCode": "0x35",
>         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC_LOCAL",
>         "Experimental": "1",
>         "PerPkg": "1",
>         "PortMask": "0x000",
>         "UMask": "0x10c0008101",
>         "Unit": "CHA"
> },
> 
> the PortMask is ch_mask, but driver not output ch_mask on SPR, it causes error.

There is no ch_mask on SPR. It should be Extended Umask.
The convertor tool should avoid generating the PortMask and FCMask for
SPR/EMR/GNR.

+ Thomas

Could you please take a look? We may have to re-generate the event list.

Thanks,
Kan

> 
> Thanks,
> Jing
> 
>> Thanks,
>> Kan
> 
> 
> 
> 
>>> Fixes: 949b11381f81 ("perf/x86/intel/uncore: Add Sapphire Rapids server CHA support")
>>> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
>>> ---
>>>  arch/x86/events/intel/uncore_snbep.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
>>> index ca98744..e537623 100644
>>> --- a/arch/x86/events/intel/uncore_snbep.c
>>> +++ b/arch/x86/events/intel/uncore_snbep.c
>>> @@ -5967,6 +5967,7 @@ static int spr_cha_hw_config(struct intel_uncore_box *box, struct perf_event *ev
>>>  	&format_attr_inv.attr,
>>>  	&format_attr_thresh8.attr,
>>>  	&format_attr_filter_tid5.attr,
>>> +	&format_attr_ch_mask.attr,
>>>  	NULL,
>>>  };
>>>  static const struct attribute_group spr_uncore_chabox_format_group = {
> 

