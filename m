Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D202035959;
	Thu, 13 Nov 2025 06:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763017159; cv=none; b=Tmwq1RDmowZPRav5dC54+VaiEdSVmpqDLazgD3JVaaUxN1SKkndHrh8AAfSAhK2wpjOYJeKjHsg615uLvtyk1hKm/7XUjUx9/z9fOCQ4c+DcqX+EyNJzoOiX4lA2B4iWII2O/ZK73hqNYDb8yNJFkIWunT0OwG0jHzTbb0prpco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763017159; c=relaxed/simple;
	bh=kmWf36IUs4aP8gCc4jy0Ny15SO/HPLfZN4FMLoTkYkU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pLWetYJq5SMbDYzgEtg4bdquAzzlhRmHL5bKWhJHqU3Ub4U67SpHq3qwWFjs3vyJjGJWQVih9DhX5TIPUVXq+6HdD5uYCCGN2QUN/aYNWyV5S9nUrbch86DJ6ankPvK1+X0SWVR+GjfVYFDLRz2EHpqZH72h535/h+qq0EBeObs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hhG7EyqT; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hhG7EyqT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763017157; x=1794553157;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=kmWf36IUs4aP8gCc4jy0Ny15SO/HPLfZN4FMLoTkYkU=;
  b=hhG7EyqTIAeuLHerR2zNEcLelMDWYuPSB2Pmtn7JtUTRyyF3C7ivBNlH
   fO3YG79NMyKeNV9nehk5Inkv0WIocQQpP/EFxVHv+UtPgvv9t57tJXAOU
   EsNpmDouK6ODApZ14U+PeVfB8E2GL3gyzjqL38wYnX5/PveBG96P9c8sF
   r5y5GqjdUjSb/UT3xorsboRqBXLANKsin/0IrxZ0I9QXIvBiKLlmGoYNj
   23bHyfeN5ePVIDgD4AgcqQeIAQJpK8si4gvhVIExMHzd9xxE6+XJf4S4s
   Od8Xe7A+qrJLsliwOPFVnSWQrXEGy69O1PLkJOrXKO+3bg85x92qm91Hs
   A==;
X-CSE-ConnectionGUID: Xr0yuDlARzWABgMQhLgpVQ==
X-CSE-MsgGUID: WwHkPe80Q+eczPrwcTUfwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="90561828"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="90561828"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 22:59:16 -0800
X-CSE-ConnectionGUID: L9n9Nk4bS7Sb5L5sbSqStQ==
X-CSE-MsgGUID: waa/RnZ8SlyIGgRfi7zybw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="212809703"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 22:59:13 -0800
Message-ID: <9c0c1a27-8db5-4af3-87a3-a29351b438fc@linux.intel.com>
Date: Thu, 13 Nov 2025 14:59:11 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/events/intel/cstate: Add Pantherlake support
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, jolsa@kernel.org,
 adrian.hunter@intel.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251112090024.3298186-1-kaushlendra.kumar@intel.com>
 <db0d7975-946e-4d74-928a-0c7018adcc03@linux.intel.com>
Content-Language: en-US
In-Reply-To: <db0d7975-946e-4d74-928a-0c7018adcc03@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/13/2025 2:50 PM, Mi, Dapeng wrote:
> Hi Kaushlendra,
>
> The PTL cstate enabling patch had been merged into tip perf/core branch. :)

Sorry, forgot to paste the link.
https://lore.kernel.org/all/20251023223754.1743928-4-zide.chen@intel.com/


>
> Thanks,
>
> - Dapeng
>
> On 11/12/2025 5:00 PM, Kaushlendra Kumar wrote:
>> It supports the same C-state residency counters as Lunarlake.This
>> enables monitoring of C1, C6, C7 core states and C2,C3,C6,C10
>> package states residency counters on Pantherlake platforms.
>>
>> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
>> ---
>>  arch/x86/events/intel/cstate.c | 16 +++++++++-------
>>  1 file changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
>> index ec753e39b007..b3582eeb6c4b 100644
>> --- a/arch/x86/events/intel/cstate.c
>> +++ b/arch/x86/events/intel/cstate.c
>> @@ -41,7 +41,7 @@
>>   *	MSR_CORE_C1_RES: CORE C1 Residency Counter
>>   *			 perf code: 0x00
>>   *			 Available model: SLM,AMT,GLM,CNL,ICX,TNT,ADL,RPL
>> - *					  MTL,SRF,GRR,ARL,LNL
>> + *					  MTL,SRF,GRR,ARL,LNL,PTL
>>   *			 Scope: Core (each processor core has a MSR)
>>   *	MSR_CORE_C3_RESIDENCY: CORE C3 Residency Counter
>>   *			       perf code: 0x01
>> @@ -53,31 +53,32 @@
>>   *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
>>   *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
>>   *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF,
>> - *						GRR,ARL,LNL
>> + *						GRR,ARL,LNL,PTL
>>   *			       Scope: Core
>>   *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
>>   *			       perf code: 0x03
>>   *			       Available model: SNB,IVB,HSW,BDW,SKL,CNL,KBL,CML,
>> - *						ICL,TGL,RKL,ADL,RPL,MTL,ARL,LNL
>> + *						ICL,TGL,RKL,ADL,RPL,MTL,ARL,LNL,
>> + *						PTL
>>   *			       Scope: Core
>>   *	MSR_PKG_C2_RESIDENCY:  Package C2 Residency Counter.
>>   *			       perf code: 0x00
>>   *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
>>   *						KBL,CML,ICL,ICX,TGL,TNT,RKL,ADL,
>> - *						RPL,SPR,MTL,ARL,LNL,SRF
>> + *						RPL,SPR,MTL,ARL,LNL,SRF,PTL
>>   *			       Scope: Package (physical package)
>>   *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
>>   *			       perf code: 0x01
>>   *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,KNL,
>>   *						GLM,CNL,KBL,CML,ICL,TGL,TNT,RKL,
>> - *						ADL,RPL,MTL,ARL,LNL
>> + *						ADL,RPL,MTL,ARL,LNL,PTL
>>   *			       Scope: Package (physical package)
>>   *	MSR_PKG_C6_RESIDENCY:  Package C6 Residency Counter.
>>   *			       perf code: 0x02
>>   *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
>>   *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
>>   *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF,
>> - *						ARL,LNL
>> + *						ARL,LNL,PTL
>>   *			       Scope: Package (physical package)
>>   *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
>>   *			       perf code: 0x03
>> @@ -96,7 +97,7 @@
>>   *	MSR_PKG_C10_RESIDENCY: Package C10 Residency Counter.
>>   *			       perf code: 0x06
>>   *			       Available model: HSW ULT,KBL,GLM,CNL,CML,ICL,TGL,
>> - *						TNT,RKL,ADL,RPL,MTL,ARL,LNL
>> + *						TNT,RKL,ADL,RPL,MTL,ARL,LNL,PTL
>>   *			       Scope: Package (physical package)
>>   *	MSR_MODULE_C6_RES_MS:  Module C6 Residency Counter.
>>   *			       perf code: 0x00
>> @@ -652,6 +653,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
>>  	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&adl_cstates),
>>  	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	&adl_cstates),
>>  	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&lnl_cstates),
>> +	X86_MATCH_VFM(INTEL_PANTHERLAKE_L,	&lnl_cstates),
>>  	{ },
>>  };
>>  MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
