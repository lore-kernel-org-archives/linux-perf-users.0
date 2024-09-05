Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D38D528;
	Thu,  5 Sep 2024 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725546729; cv=none; b=gFRzczP6pxPDXeo4yFrxCYKM0kafdco9H+yeeUYnCMFng2LWXQXawKSyeWwo+xYVcOrqs4JQbo+RkHLbc3rNUAZU9wUP3OH04OhoaRA1iwqrPXZERrUu1MU/iVWi16bZS6G1xsHHd1CdmiW7f59H2HJFHgQPlYzXrTQQeyFNMJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725546729; c=relaxed/simple;
	bh=/plNwCDXFb9Kra/aJzLEsGp/XhfgAI9L6luigV9tfHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JurOlHGAEpoTJIL/mqdNqP1FNSdQrKYR2cvBzgDh/HmijfLdNPAwuodOwyq6G3weNu8R12O2aDcyYaKJ4g360fYrI3f3Mim+hWAhso7uwb9ia3p2dxzNiQe+l2TtqsMyXp2YH8Qh4uFhKSLKe+egiC+hEepUFtmgHcyyVlOVh64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hvbkwRdR; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hvbkwRdR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725546728; x=1757082728;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/plNwCDXFb9Kra/aJzLEsGp/XhfgAI9L6luigV9tfHI=;
  b=hvbkwRdRyRZeRnpLCudm1iD7BFJWi4U6H4Z6nbKfaQBKjD6rGHfG9lL1
   d4uLHYQB1ryn+q4CSRzGOEHfyLz5TDWfq5/jc0/cTwSQMXr2J3+10yr1/
   f+OSCiU+hRuUmtftkWodFMr4RsSdCg/KXChI7ZIqKXdr3im0Sf9de2+PK
   7qlMLNldCRWiXwGhl40CnPHv2vkS7JjdqXqux49U8pViZ5N939em5wQeN
   tB8d5fsZ3hEWIszDjOC1oBV9q5tUBvDPrMV0VqLh1ZWA6+7ZnN/0LLNo2
   lGHFcuj7xe4IwO+QZdiVKUTrvZYDFXJv15TmbIT+98RrsmCynbuwoScqw
   w==;
X-CSE-ConnectionGUID: Gnyb/4JWQN2q4zfvsZHdgw==
X-CSE-MsgGUID: jzS5eSr8Q62xhPapSL4fUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="27189196"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="27189196"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 07:30:23 -0700
X-CSE-ConnectionGUID: +GaIiGkmQOS1wChJClC14Q==
X-CSE-MsgGUID: x1Ftpg/pRXiJ1jaP6s1deg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="65480748"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 07:30:22 -0700
Received: from [10.212.68.73] (kliang2-mobl1.ccr.corp.intel.com [10.212.68.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id C499C20B5782;
	Thu,  5 Sep 2024 07:30:19 -0700 (PDT)
Message-ID: <01d4c489-8830-4fd4-b369-fe2d3ec0b980@linux.intel.com>
Date: Thu, 5 Sep 2024 10:30:18 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
To: Ingo Molnar <mingo@kernel.org>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 gautham.shenoy@amd.com, ravi.bangoria@amd.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240904100934.3260-1-Dhananjay.Ugwekar@amd.com>
 <90028792-19b0-4371-a8b4-0a37612b4c9b@linux.intel.com>
 <ZtmC8hhpUvQTXFDn@gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ZtmC8hhpUvQTXFDn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-09-05 6:07 a.m., Ingo Molnar wrote:
> 
> * Liang, Kan <kan.liang@linux.intel.com> wrote:
> 
>>
>>
>> On 2024-09-04 6:09 a.m., Dhananjay Ugwekar wrote:
>>> After commit ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf"),
>>> on AMD processors that support extended CPUID leaf 0x80000026, the
>>> topology_die_cpumask() and topology_logical_die_id() macros, no longer
>>> return the package cpumask and package id, instead they return the CCD
>>> (Core Complex Die) mask and id respectively. This leads to the energy-pkg
>>> event scope to be modified to CCD instead of package.
>>>
>>> So, change the PMU scope for AMD and Hygon back to package.
>>>
>>> On a 12 CCD 1 Package AMD Zen4 Genoa machine:
>>>
>>> Before:
>>> $ cat /sys/devices/power/cpumask
>>> 0,8,16,24,32,40,48,56,64,72,80,88.
>>>
>>> The expected cpumask here is supposed to be just "0", as it is a package
>>> scope event, only one CPU will be collecting the event for all the CPUs in
>>> the package.
>>>
>>> After:
>>> $ cat /sys/devices/power/cpumask
>>> 0
>>>
>>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>>
>> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> 
> Note that I just merged the older v2 version into perf/urgent, because it's 
> a regression fix, and to not create a backporting complication. I added 
> your Reviewed-by to it if that's fine with you.
> 
> Your hotplug series can essentially revert this:
> 
>   8d72eba1cf8c ("perf/x86/rapl: Fix the energy-pkg event for AMD CPUs")
> 
> and apply the v3 patch to gain the simpler version.
> 

Sure, sounds good to me.

Thanks,
Kan
