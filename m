Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8BC28A1E8;
	Wed,  7 May 2025 13:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625544; cv=none; b=s2G+JBWzB+k/ngRsBPY3O9mlWNOs3d4Lq/cQ8ICQ8+pemays9v+snP1DAzj0wbDGY2PcOtIf8e2xq+6IF68PM7lSUvFgzt6ICNoPvpCvJGaMrPbtkNwNKGEymOKGlTHT8gh2XtQHQ4gjFkSXsQKqkcEpucFrePp8LLPYnSVEGb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625544; c=relaxed/simple;
	bh=fObmB0A/Q/sOf9nVse3eZ+xly+ZPPNVdcDl3+H5E7S8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kza6VHgbw1luunweL57ox9YFPrbUsKfg5rPSDig2VPA5xr6uYEmz1gkCib6tWtAl9fqze2R90zBk1bOWrg7POYd7BtyH+6xGuUg7UEYRMwe7pUUr0tnjVwQA9Xgdr7dNskdCD9dKvLRf/0jMMv9cn5zM1/PpObVRJpXbqumsumU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IOv0/UnJ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IOv0/UnJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746625543; x=1778161543;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fObmB0A/Q/sOf9nVse3eZ+xly+ZPPNVdcDl3+H5E7S8=;
  b=IOv0/UnJMKnk0LwhyRg4e9pNxWm0efrwp088CjPefrBxOUnmLVl+yAuK
   hK6RDWBt9oVwdHySQRNysiI49VkLgzw5jpGZfqzNyK8DEl4tUcr8+Dw7L
   Sf510awE/PfJzpk+VXqo5fv75kFMKwKxu4hmwXFGK3pfFkBa2Cd+DYzLq
   p9fWJOAegvMKpGjGs86nzUAfYrtdZgxnXfi6PanLZ2qBgEQHzYgLnep26
   7cb5dTsquCgdqtUX+v+4aU1PIboxmLqrbFYQCgVaUY7TjU+Ha7V5Jb8y9
   hQwQlHMBqO9qWBnnslJx3gVVfxU26Vn77L+qvY2yS7FZ9ICwnXVTab2HR
   g==;
X-CSE-ConnectionGUID: vgdYAnQtSOSdS/GiDf1Tcg==
X-CSE-MsgGUID: FMDVyx7NRIGs0gjISjo6lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="52010428"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="52010428"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 06:45:42 -0700
X-CSE-ConnectionGUID: rrgsJGOgSyy+77EMXiqtlw==
X-CSE-MsgGUID: DP+gC8F7QQyQQUa/U8hj0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="135825300"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 06:45:42 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id C04FA20B5736;
	Wed,  7 May 2025 06:45:40 -0700 (PDT)
Message-ID: <4b5212a8-f6e2-4a75-b768-bef0d17ab332@linux.intel.com>
Date: Wed, 7 May 2025 09:45:39 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 12/15] loongarch/perf: Remove driver-specific throttle
 support
To: =?UTF-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
 irogers@google.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, eranian@google.com, ctshao@google.com,
 tmricht@linux.ibm.com, Bibo Mao <maobibo@loongson.cn>,
 loongarch@lists.linux.dev
References: <20250506164740.1317237-1-kan.liang@linux.intel.com>
 <20250506164740.1317237-13-kan.liang@linux.intel.com>
 <6777794d.1b9e4.196a851ddc0.Coremail.chenhuacai@loongson.cn>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <6777794d.1b9e4.196a851ddc0.Coremail.chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025-05-06 9:17 p.m., 陈华才 wrote:
> Hi, Liang,
> 
> Since which version we need this patch? I mean which versions this patch should be backported.

The generic change hasn't been merged. It's still under review.
https://lore.kernel.org/lkml/20250506164740.1317237-2-kan.liang@linux.intel.com/

The driver-specific change should be applied after the generic change is
merged.

> And you need to CC loongarch@lists.linux.dev.
> 

Sure.

Thanks,
Kan

> Huacai
> 
> 
>> -----原始邮件-----
>> 发件人: kan.liang@linux.intel.com
>> 发送时间:2025-05-07 00:47:37 (星期三)
>> 收件人: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org, irogers@google.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
>> 抄送: eranian@google.com, ctshao@google.com, tmricht@linux.ibm.com, "Kan Liang" <kan.liang@linux.intel.com>, "Bibo Mao" <maobibo@loongson.cn>, "Huacai Chen" <chenhuacai@loongson.cn>
>> 主题: [RFC PATCH 12/15] loongarch/perf: Remove driver-specific throttle support
>>
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The throttle support has been added in the generic code. Remove
>> the driver-specific throttle support.
>>
>> Besides the throttle, perf_event_overflow may return true because of
>> event_limit. It already does an inatomic event disable. The pmu->stop
>> is not required either.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> Cc: Bibo Mao <maobibo@loongson.cn>
>> Cc: Huacai Chen <chenhuacai@loongson.cn>
>> ---
>>  arch/loongarch/kernel/perf_event.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/arch/loongarch/kernel/perf_event.c b/arch/loongarch/kernel/perf_event.c
>> index f86a4b838dd7..8ad098703488 100644
>> --- a/arch/loongarch/kernel/perf_event.c
>> +++ b/arch/loongarch/kernel/perf_event.c
>> @@ -479,8 +479,7 @@ static void handle_associated_event(struct cpu_hw_events *cpuc, int idx,
>>  	if (!loongarch_pmu_event_set_period(event, hwc, idx))
>>  		return;
>>  
>> -	if (perf_event_overflow(event, data, regs))
>> -		loongarch_pmu_disable_event(idx);
>> +	perf_event_overflow(event, data, regs);
>>  }
>>  
>>  static irqreturn_t pmu_handle_irq(int irq, void *dev)
>> -- 
>> 2.38.1
> 
> 
> 本邮件及其附件含有龙芯中科的商业秘密信息，仅限于发送给上面地址中列出的个人或群组。禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制或散发）本邮件及其附件中的信息。如果您错收本邮件，请您立即电话或邮件通知发件人并删除本邮件。 
> This email and its attachments contain confidential information from Loongson Technology , which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction or dissemination) by persons other than the intended recipient(s) is prohibited. If you receive this email in error, please notify the sender by phone or email immediately and delete it. 
> 
> 

