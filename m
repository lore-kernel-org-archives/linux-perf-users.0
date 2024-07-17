Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20699180058;
	Wed, 17 Jul 2024 13:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721221607; cv=none; b=vGW57EjwDtVrgNK4vqRZ6V3iCw4ySF+PUq0QcFv+YzmfuKyMhCgt5n9y8fadLlf6OXhY1bWomTFAT6tcNHZFsIP9cr3dOqVoqsOxX1Ysq+aMQHtnxn5yCwPOej2M1Kga4wrY0G2zx/s/yo19LoFMs1WbyzfBzePybhZuAZrzaxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721221607; c=relaxed/simple;
	bh=nqzwU62TUTIQqfqi5YPISkss2GL6yfthtYun8w6rQfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZaoqAHWZcBVsyRNbbqVnAZAraSPqjugGfxPMlDA4n/l4pJrm6XpXlWYs0bHG79EupevH996g6qWJ09lXtP4luHaHUStMj/XjdeJp4AK43oIMe7GPf2EAFls+8CYVeqMCCcVwgwh6rUezXO8tvy16dwgeudT/OS8QznkjESvfTwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bzk5fC39; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bzk5fC39"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721221606; x=1752757606;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nqzwU62TUTIQqfqi5YPISkss2GL6yfthtYun8w6rQfY=;
  b=Bzk5fC39do5qLUOZIXu3panEsSZmGD0pnaPby+/8IUHKE68IhFLlikoj
   ruXlnVHTPFzFWuGq9wy6lBgHY7ZEzU7GdbxqeZSb8KUKuyvOyrlxu8+uH
   0ylJW2CLbY3tYvFFa0I77AxB3knrljYT4+el9ng2LShFZLTGGspZtakfm
   Tf+WZAyWXku/07In2uCWJoWnMqpAWN77WwtRAYlWyUGNJUMPaAjdHc+zB
   K62AS1qZ0E+g8DeTY3F/WmKgB9qSKFp3PS5I3ugYAFMZFiRRW7RrnjV9R
   ZX1P6cSH4jtZ0yMsa1juYXhBhnHxiflCtc+nGigR6zek8zllaowirgWgj
   w==;
X-CSE-ConnectionGUID: IimnZ8pjR8G1bbrozXybgA==
X-CSE-MsgGUID: qjgMh+tITvuVhP3ZkztkAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="22536283"
X-IronPort-AV: E=Sophos;i="6.09,214,1716274800"; 
   d="scan'208";a="22536283"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 06:06:45 -0700
X-CSE-ConnectionGUID: AOETldJaSaO1pv4Aq0sK1A==
X-CSE-MsgGUID: eH1SDIy/S6iWVnsiWTY7tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,214,1716274800"; 
   d="scan'208";a="55243990"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 06:06:46 -0700
Received: from [10.212.127.135] (kliang2-mobl1.ccr.corp.intel.com [10.212.127.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 7818220B8CD6;
	Wed, 17 Jul 2024 06:06:44 -0700 (PDT)
Message-ID: <5bd0d2dd-27cd-4054-b152-c5acf7ef3084@linux.intel.com>
Date: Wed, 17 Jul 2024 09:06:43 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH tip rebase] perf/x86/intel/cstate: Add pkg C2 residency
 counter for Sierra Forest
To: Zhenyu Wang <zhenyuw@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 x86@kernel.org, Rui Zhang <rui.zhang@intel.com>,
 Artem Bityutskiy <artem.bityutskiy@intel.com>,
 Wendy Wang <wendy.wang@intel.com>
References: <20240612080835.306254-1-zhenyuw@linux.intel.com>
 <20240717031609.74513-1-zhenyuw@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240717031609.74513-1-zhenyuw@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-07-16 11:16 p.m., Zhenyu Wang wrote:
> Package C2 residency counter is also available on Sierra Forest.
> So add it support in srf_cstates.
> 
> Cc: Rui Zhang <rui.zhang@intel.com>
> Cc: Artem Bityutskiy <artem.bityutskiy@intel.com>
> Cc: Wendy Wang <wendy.wang@intel.com>
> Tested-by: Wendy Wang <wendy.wang@intel.com>
> Fixes: 3877d55a0db2 ("perf/x86/intel/cstate: Add Sierra Forest support")
> Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
> 
> Hi, Peter
> 
> This refresh resolved conflicts in comment against current tip tree.
> Please help to apply.
> 
> Thanks!
> 
>  arch/x86/events/intel/cstate.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
> index be58cfb012dd..9f116dfc4728 100644
> --- a/arch/x86/events/intel/cstate.c
> +++ b/arch/x86/events/intel/cstate.c
> @@ -64,7 +64,7 @@
>   *			       perf code: 0x00
>   *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
>   *						KBL,CML,ICL,ICX,TGL,TNT,RKL,ADL,
> - *						RPL,SPR,MTL,ARL,LNL
> + *						RPL,SPR,MTL,ARL,LNL,SRF
>   *			       Scope: Package (physical package)
>   *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
>   *			       perf code: 0x01
> @@ -693,7 +693,8 @@ static const struct cstate_model srf_cstates __initconst = {
>  	.core_events		= BIT(PERF_CSTATE_CORE_C1_RES) |
>  				  BIT(PERF_CSTATE_CORE_C6_RES),
>  
> -	.pkg_events		= BIT(PERF_CSTATE_PKG_C6_RES),
> +	.pkg_events		= BIT(PERF_CSTATE_PKG_C2_RES) |
> +				  BIT(PERF_CSTATE_PKG_C6_RES),
>  
>  	.module_events		= BIT(PERF_CSTATE_MODULE_C6_RES),
>  };
