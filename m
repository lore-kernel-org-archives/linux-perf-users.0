Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59005219A9D;
	Tue,  4 Feb 2025 21:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738703357; cv=none; b=qbK9h8dlfZEiGz+0NtSVbBcBdgsdt4IaomRkrDlb0Ycqa321gjbcSY1zw+0Fw144BdcNdo9RfF5WL1+tzGY6n/wem9cSt4thRxSKJ11qjc/5UmZvRenosu9uuPiYEGLprmPC5lLhK3EeFhjyoLDRs6kot2fOAk9SgVKPVSpPNes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738703357; c=relaxed/simple;
	bh=WN310kV2jADJRcPMhCfFUsQ36Rf7aXB/v87njf9xJkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UBsLJYzZXlHDZDoMq5jpr1K8IVTnzHN9bZ+wcn+hjZgc0Coa08KpW6PCRql+96fu00nuE886YQiZ7X4UcIvIblxPQHZmr05Bj/EPLy72KljRht2+fZw0yI3T3WoY/7XMkCMNFOKp+qIPgxG7E23Z7j8PVP5KUmtqnNKwNHQIhHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QUFwFsoe; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QUFwFsoe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738703356; x=1770239356;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WN310kV2jADJRcPMhCfFUsQ36Rf7aXB/v87njf9xJkg=;
  b=QUFwFsoeFSFn2wUJxVeeBlhrtGVol8pu2Mgb9Db/f1t5VQBVwRWCgsaF
   ssb66eUYX7f61I484d5MWocSXYtpFPYrAKG4ci8Az5qY400lomGtgWH1u
   kTx5/9ndRn4SSurbG7vdrfQTFMhyNtuemwRLegLOlhEMgWpVXFqQhwQMO
   3+kzd7y3i9QhgudTv8NMEqOa4vgixtyjHrsw5Bk0zzQW11jcMCz4UXCZ5
   RWKAmFctIAsEuVQkedMULhQsy4fYqhWBdjbrNvx9jvTo15p4QcSyjq+AY
   jXVJLl94ivzvR9lPZYDcpQzIeThf6+uICaT/xqsrcRCRWebkaDodR5VI7
   A==;
X-CSE-ConnectionGUID: /2XXNbqXS7eTrT90IifWNA==
X-CSE-MsgGUID: 3lW4QkiNTrCjpRM7sV7g7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43170427"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="43170427"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 13:09:13 -0800
X-CSE-ConnectionGUID: /SsNr1C3TguOMFe+DLAx+A==
X-CSE-MsgGUID: mELU3NwzRwOj0NTyxPHEVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="110480812"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 13:09:13 -0800
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 7202720B5713;
	Tue,  4 Feb 2025 13:09:11 -0800 (PST)
Message-ID: <f3b71bfb-4e04-48a2-b606-bac81cd3f50e@linux.intel.com>
Date: Tue, 4 Feb 2025 16:09:09 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V10 4/4] perf/x86/intel: Support PEBS counters
 snapshotting
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, ak@linux.intel.com, eranian@google.com,
 dapeng1.mi@linux.intel.com
References: <20250121152303.3128733-1-kan.liang@linux.intel.com>
 <20250121152303.3128733-4-kan.liang@linux.intel.com>
 <20250127155107.GI16742@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250127155107.GI16742@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Peter,

On 2025-01-27 10:51 a.m., Peter Zijlstra wrote:
> On Tue, Jan 21, 2025 at 07:23:03AM -0800, kan.liang@linux.intel.com wrote:
> 
>> @@ -471,6 +477,15 @@ struct pebs_xmm {
>>  
>>  #define IBS_CPUID_FEATURES		0x8000001b
>>  
>> +struct pebs_cntr_header {
>> +	u32 cntr;
>> +	u32 fixed;
>> +	u32 metrics;
>> +	u32 reserved;
>> +};
>> +
>> +#define INTEL_CNTR_METRICS		0x3
> 
> I've moved this up a little, so that all the adaptive pebs crud is
> together.
> 
> Other than that, I've picked up these patches and will merge the lot
> past -rc1.
> 

We found a bug when testing with some non-precise events in freq mode.
I've submitted a patch to fix it.
https://lore.kernel.org/lkml/20250204210514.4089680-1-kan.liang@linux.intel.com/

Could you please fold it into the patch ("perf/x86/intel: Support PEBS
counters snapshotting")?

Sorry for any inconvenience.

Thanks,
Kan
