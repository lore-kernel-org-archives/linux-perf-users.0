Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41531DF980;
	Tue, 12 May 2026 04:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778561596; cv=none; b=cRKYQWikToNAA/sVIeU6B/USdLiRezs4dMXu2ozdpMSspX/asL1xy9sWyJiPauIGGXjHHWkAENC7Xem6M7kfYj4MaNk68CK4dAInQFFLQgnNRWB/PYQBFw8UKy8ay43aTkTbW1+mgvSXcu9nR3n/u26vHnvjLiwxs+GUduIsGMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778561596; c=relaxed/simple;
	bh=Q39qDPdxX0gyii2sh3hi/lucmRhvwZBq8KDe7Q8Q1jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UOkJcNq7ws6OaYEBW99itt4DK4YfeFWpeAMLI0uh8xCz4Cm+Qrxpk22PerXKy31zC4ixL1wWhUTFcWT5NCfQw4FHNmUaszjhCHuG2z/fddhs/PSixy9riB8AjXSOJ8hzdyilQlMFhaf2o9qWgLEbwmyqc5uMzo88kZYE/D2JOI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qj8ByZfG; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qj8ByZfG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778561595; x=1810097595;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q39qDPdxX0gyii2sh3hi/lucmRhvwZBq8KDe7Q8Q1jg=;
  b=Qj8ByZfGyllY4drkg10VKVe//ICohjUZYgsZKfsdBo0rGM4f9I4K3yXV
   ZyT3eLxctikZCsaLOS6AejhbffTwhHV4UB5CMizoFn6XlJdtqfjFxSoQI
   NpLvd07+LoYiO10hz5cXEBgjwSeeA2IFL65G+5AvgC3lhhiZSUvWglAvF
   1LqBakQLARc+w4hjZPGVdVMIjfzXiq9wehpRuVCuvvXdgoMiAGkxdBQZm
   rA8GBcGQH6QdulTTKOKmKzB+6X48JC6wJHTA8Ca+L3r685b/gJoeXa+C2
   OcbdBXTg0Q1w/yt9JrqPDcDNjot/iZt4+Nc0Qarr9KLUKsoj/0qiok9Oo
   A==;
X-CSE-ConnectionGUID: Hz+0/e3hSw23dznIGZsPJg==
X-CSE-MsgGUID: TU+pgbLKSV+i8x+9rMtilA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90159522"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="90159522"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 21:53:14 -0700
X-CSE-ConnectionGUID: wUksfXXXS/+HcWoMEiSGtA==
X-CSE-MsgGUID: wZPb4uxqTri7hTf2nPzXPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="231254043"
Received: from unknown (HELO [10.238.3.169]) ([10.238.3.169])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 21:53:10 -0700
Message-ID: <abc8c49b-e898-4a23-b3aa-cdf2201473d0@linux.intel.com>
Date: Tue, 12 May 2026 12:53:08 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] perf/x86/intel: Ensure guest PEBS path doesn't set
 unwanted PERF_GLOBAL_CTRL bits
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
 <20260508231353.406465-2-seanjc@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260508231353.406465-2-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/9/2026 7:13 AM, Sean Christopherson wrote:
> When reinstating PEBS counters into PERF_GLOBAL_CTRL for a KVM guest, mask
> the value with perf's desired/original PERF_GLOBAL_CTRL value to ensure
> KVM doesn't unintentionally enable counters.  This _should_ be a nop, as
> arr[pebs_enable].guest is derived from cpuc->pebs_enabled, which should be
> a subset of x86_pmu.intel_ctrl, but paranoia is cheap in this case.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/events/intel/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index d9488ade0f8e..b70dc35fcceb 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -5066,7 +5066,7 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
>  		arr[pebs_enable].guest &= ~kvm_pmu->host_cross_mapped_mask;
>  		arr[global_ctrl].guest &= ~kvm_pmu->host_cross_mapped_mask;
>  		/* Set hw GLOBAL_CTRL bits for PEBS counter when it runs for guest */
> -		arr[global_ctrl].guest |= arr[pebs_enable].guest;
> +		arr[global_ctrl].guest |= intel_ctrl & arr[pebs_enable].guest;
>  	}
>  
>  	return arr;

The change looks good to me, but it's totally removed in next patch. Not
sure if it's worthy to do it.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


