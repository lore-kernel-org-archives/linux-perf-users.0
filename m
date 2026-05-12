Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38CC18C2C;
	Tue, 12 May 2026 05:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778562045; cv=none; b=coWOF+Wj3isN+enLlmcadkG9s8wDh4JP+gIfAbHNR918Y7SBESEeLCY9eSxM7ZEnjIuw5F6ILcRdO2uhz1lyFgXAJ7jxlGX45tZSWPH//97g4FTdrY0g2RJZgz+7AfhukVjfTVhKphkrVPwc61qFXKnBipBy4WuUpCnXDUKCUcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778562045; c=relaxed/simple;
	bh=pI0E7Y1vqYAnb0g7lcsXeZRE+1rNmEhALOH+XE8iXew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vti83fB2q2pyf0xN+/ASoLKrfV1WSvyMSomHZFYOK9YDFhhYxSSrqTE/XLyM9Nvp9TUmAn9oxhWF4wn8aY1w0WcOYH4V8JkTj5kFg5E0wDCqUuKT2zPsnEli2sKCzW8arlYOLtL4U0wJIYcR3PZjrOAbc+MDhNFwkDVEWXb4Yzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lnPNDlZw; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lnPNDlZw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778562043; x=1810098043;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pI0E7Y1vqYAnb0g7lcsXeZRE+1rNmEhALOH+XE8iXew=;
  b=lnPNDlZwKz7BvadePDMnRYHOjG/oV01ve8VfqeQg5pmKVIqSXgCYUKhM
   SfnIerGYLcIQf2cAxulHRwDR4f6lUILr3r5VmdDfAEyZdM7abREUhEkaN
   imtdAmplDUdp4NBf78SgJVXhD9X2iIB2bYcplK9+hXelyHOvsOqRkGfDn
   tb/XlAk0X59DSIk2rWoUcuSVL/MAhO9W36S/Vn9HWcWolgGvu3DJ7z2fT
   O0Ge7QRYY66p1o9EM7zS3kvJkG8mx6TmCcMGPuWfGrRn8Fj2tM8nVtlAz
   BGSmO5v8Ze502146WmzmLoDeUqabosOp3AjoGxTw3z2/sDvRPgrBctyzz
   Q==;
X-CSE-ConnectionGUID: EL50MX4kSgi/2/gkFxN7KQ==
X-CSE-MsgGUID: pyrN6HNkSBCzMKVhc4sZRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79179563"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="79179563"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 22:00:43 -0700
X-CSE-ConnectionGUID: hZ5/RsFyTdeVF/CO0uuI2g==
X-CSE-MsgGUID: K2oZWIRBTSWzd39wKr7fjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="237744631"
Received: from unknown (HELO [10.238.3.169]) ([10.238.3.169])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 22:00:39 -0700
Message-ID: <72b65be8-436d-4db8-97d9-6f4e628b7b47@linux.intel.com>
Date: Tue, 12 May 2026 13:00:37 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] KVM: VMX: Drop a redundant pmu->global_ctrl check
 when processing pebs_enable
To: Sean Christopherson <seanjc@google.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>,
 Stephane Eranian <eranian@google.com>
References: <20260508231353.406465-1-seanjc@google.com>
 <20260508231353.406465-9-seanjc@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260508231353.406465-9-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/9/2026 7:13 AM, Sean Christopherson wrote:
> Drop a redundant check that a PMC is globally enabled when looking for
> PEBS counters that are cross-mapped between the guest and the host.  The
> for-loop explicitly iterates over pmu->global_ctrl, and since PEBS requires
> PMU v2+, kvm_pmu_has_perf_global_ctrl() must be true, and thus
> pmc_is_globally_enabled() is simply checking that the bit is set in
> pmu->global_ctrl.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/vmx/pmu_intel.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index e65adb3dc066..659fe097b904 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -752,8 +752,7 @@ u64 intel_pmu_get_cross_mapped_mask(struct kvm_pmu *pmu)
>  	host_cross_mapped_mask = 0;
>  
>  	kvm_for_each_pmc(pmu, pmc, bit, (unsigned long *)&pmu->global_ctrl) {
> -		if (!pmc_is_locally_enabled(pmc) ||
> -		    !pmc_is_globally_enabled(pmc) || !pmc->perf_event)
> +		if (!pmc_is_locally_enabled(pmc) || !pmc->perf_event)
>  			continue;
>  
>  		/*

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


