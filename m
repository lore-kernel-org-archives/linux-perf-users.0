Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222732FF64C;
	Tue,  2 Sep 2025 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830057; cv=none; b=sOFN+kjAtGBZf1lSfuFmUR6iRwfAmeI3XtCumjsUxSwr2F2+jX30GoebceptFasg+BJzB52Q8Arg5ZI23joNfxxhuGqF6/B9QR6nWGt2Ley0qJGLgNakrGV5SY4sq3ut12jWNU1pERFZPO6wOEbdawTgIg3557RoLZkGw0MUnho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830057; c=relaxed/simple;
	bh=vTpofpxPDyN+FDxPUYtW2w37ZH4XY50XsXBqaWIPZ6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TALloxvQttpyTa1hqcXBwaOROfD3lNFc8MD5RNuir/b0Fnj8wW1+HGLnkGbucPkDSjFjV60CcJeGhgtdorkL4u+9kpoZnhW4pp5XNM14IKIhnIk5I2cOCzO2JrAamYR+1cS+qUnAGVXmH8rwKldfLfrvo9oKGogN6qSRxCtQTQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hg89vHyF; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hg89vHyF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756830056; x=1788366056;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=vTpofpxPDyN+FDxPUYtW2w37ZH4XY50XsXBqaWIPZ6M=;
  b=hg89vHyFtUrsnxdkqp6iEjLEKo8c+FnU/a9+xH7YW5z6onpMV+Bf6OlQ
   H1b05Se4U8IOIrJu0288bJOg1qL4BLdhNH1iKvFDKeDEHwzlj+uMYScDa
   m+SxsucbrN5vIO88mnWFGyrpBVtfLzGOMrYaStBNU0f8GtQ2TDYCDItPI
   I6y2n0eec9Q1GOfK/5ukdGXa6TANA/Kr1+XfrhWCkmUfrF2OlqpeI8kji
   4HINQtfNjaBq69hkRIDVUusWxtqEILxcHdhvMomkmVT0ciwqIbgvQLHp0
   O5TD8PDzs4SGnIjFPq+FUU6fkrLuUaXJYZRzI86Y1+b0xJGmaUc8oZAwt
   A==;
X-CSE-ConnectionGUID: Bvohqr9DSt6oEuFohSrdvg==
X-CSE-MsgGUID: M6UOy6F4RJ6z6sZHh2jsFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="58147040"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="58147040"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 09:20:55 -0700
X-CSE-ConnectionGUID: M/oOxW/6RUy1IQ13bleFxw==
X-CSE-MsgGUID: ntESb25MRfStMrsKIqUWFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="175689690"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 09:20:55 -0700
Received: from [10.246.166.96] (unknown [10.246.166.96])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id C5E1920B571C;
	Tue,  2 Sep 2025 09:20:53 -0700 (PDT)
Message-ID: <d5062761-c00b-470c-ac01-08b9dd32329f@linux.intel.com>
Date: Tue, 2 Sep 2025 09:20:53 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel: Use guard() instead of mutex_lock() to
 simplify code
To: Liao Yuanhong <liaoyuanhong@vivo.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
 "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
References: <20250901131714.646988-1-liaoyuanhong@vivo.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250901131714.646988-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-09-01 6:17 a.m., Liao Yuanhong wrote:
> Using guard(mutex) instead of mutex_lock/mutex_unlock pair. Simplifies the
> error handling to just return in case of error. No need for the 'done'
> label anymore so remove it.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  arch/x86/events/intel/core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 28f5468a6ea3..ac88d9535e85 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -6107,18 +6107,16 @@ static ssize_t freeze_on_smi_store(struct device *cdev,
>  	if (val > 1)
>  		return -EINVAL;
>  
> -	mutex_lock(&freeze_on_smi_mutex);
> +	guard(mutex)(&freeze_on_smi_mutex);
>  
>  	if (x86_pmu.attr_freeze_on_smi == val)
> -		goto done;
> +		return count;
>  
>  	x86_pmu.attr_freeze_on_smi = val;
>  
>  	cpus_read_lock();
>  	on_each_cpu(flip_smm_bit, &val, 1);
>  	cpus_read_unlock();
> -done:
> -	mutex_unlock(&freeze_on_smi_mutex);
>  
>  	return count;
>  }

