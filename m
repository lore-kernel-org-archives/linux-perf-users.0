Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FB831E82D;
	Thu, 12 Mar 2026 06:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773297885; cv=none; b=gI75qlp8jQfAsIw3/jlEDJRJoeneW744OxVQ6uuKOQjzys6Gp4p+11tR6x021SedJ6VBo7Ef7Yc0Lo/1DEPFDvbcHd7FaRbMxNx4T5tvnNI5QreTOu7qIPkJWA3VDBaIf3aFJGcofE61IiG+tBV2o4vzKnQo21G0Ka0flqfj5wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773297885; c=relaxed/simple;
	bh=M5YBnvCL1leKHEuolly/wZvds8H1SomAROpQHoO7ae8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qs/A8j+BzHUTArD11guzJ/4GhOwJFce8E4kfZYG6vIbFLa5V+cNiV8KP+USA8DniY+oslxvmwcoVa4eL4sbs8W3MyRF44kx+NWQUAFWWj73EfppL8XJp0ZgqCT1TPkBLh/+l3X3flUVofJ3U0OE0lRcigkmrAhAjvt9LwymJR58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iZwhoNUM; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iZwhoNUM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773297884; x=1804833884;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M5YBnvCL1leKHEuolly/wZvds8H1SomAROpQHoO7ae8=;
  b=iZwhoNUMzIySR+WxQjsc7mSt6gwLazII1xX5LPYeMvEWRO1zr3hZc8vS
   wjRSmMDTlTaqz129fri0JtVsvFaJBjYGEfph++5GP5XW1Cl8yUWbJjI6K
   YcDJC/Q3QN0UGS4ew7LLJoETXlLNthAZXfPCJdZqjiE1rFzVbbuO9ERwn
   5TNxawxgFRMQG+t+IUPm/VGXatheODlDyCfTHMvLTnLMmZ6vvWqxkQaSZ
   bpGhe5tzPUmWfNYonCdFyz6UgpMTHQlyrVBARKumPRZwyF05S4IG6uIVE
   fI0O490uk7fI7L2K7MOaiJHRxHSNF/1vktrrJPZ7bK7saJU3hn8jiSpwn
   A==;
X-CSE-ConnectionGUID: Vnm4qapYQ3OsvtGj8LxWCA==
X-CSE-MsgGUID: 9yt09NJwRRGI8MaBGIBFNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="85856441"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="85856441"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 23:44:44 -0700
X-CSE-ConnectionGUID: ZzRpTxvsTamnjUctJnUtyA==
X-CSE-MsgGUID: MQcUBT7MQ/aIV9YmRH5+Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="225685755"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 23:44:40 -0700
Message-ID: <e26d0945-6406-4fe2-bd0d-154aacb1d245@linux.intel.com>
Date: Thu, 12 Mar 2026 14:44:38 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] perf/x86: Reduce is_hybrid calls and aid ellision
 of BUG_ON in hybrid_pmu
To: Ian Rogers <irogers@google.com>, dapeng1.mi@intel.com
Cc: acme@kernel.org, adrian.hunter@intel.com, ak@linux.intel.com,
 alexander.shishkin@linux.intel.com, eranian@google.com,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
 thomas.falcon@intel.com, xudong.hao@intel.com, zide.chen@intel.com
References: <CAP-5=fUBy-vzdSB3xsuyU+AKd8o99R7DLgoyyJHxb6Shkfb-8w@mail.gmail.com>
 <20260312054810.1571020-1-irogers@google.com>
 <20260312054810.1571020-2-irogers@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260312054810.1571020-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

LGTM.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


On 3/12/2026 1:48 PM, Ian Rogers wrote:
> Use the capabilities of the PMU rather than the global variable
> perf_is_hybrid to determine if a hybrid pmu has been passed to the
> main accessors. As the pmu capabilities check mirrors that in
> is_x86_pmu, the BUG_ON(!is_x86_pmu...) in hybrid_pmu can be elided as
> it is provably always false (with sufficient function inlining, common
> sub-expression elimination, etc.) in its most common uses.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> Only build tested.
> ---
>  arch/x86/events/perf_event.h | 52 +++++++++++++++++++-----------------
>  1 file changed, 28 insertions(+), 24 deletions(-)
>
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index f1123c95d174..7990d86ef233 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -802,34 +802,38 @@ static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *pmu)
>  extern struct static_key_false perf_is_hybrid;
>  #define is_hybrid()		static_branch_unlikely(&perf_is_hybrid)
>  
> -#define hybrid(_pmu, _field)				\
> -(*({							\
> -	typeof(&x86_pmu._field) __Fp = &x86_pmu._field;	\
> -							\
> -	if (is_hybrid() && (_pmu))			\
> -		__Fp = &hybrid_pmu(_pmu)->_field;	\
> -							\
> -	__Fp;						\
> +
> +#define hybrid(_pmu, _field)						\
> +(*({									\
> +	typeof(&x86_pmu._field) __Fp = &x86_pmu._field;			\
> +	struct pmu *__pmu = _pmu;					\
> +									\
> +	if (__pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE)	\
> +		__Fp = &hybrid_pmu(__pmu)->_field;			\
> +									\
> +	__Fp;								\
>  }))
>  
> -#define hybrid_var(_pmu, _var)				\
> -(*({							\
> -	typeof(&_var) __Fp = &_var;			\
> -							\
> -	if (is_hybrid() && (_pmu))			\
> -		__Fp = &hybrid_pmu(_pmu)->_var;		\
> -							\
> -	__Fp;						\
> +#define hybrid_var(_pmu, _var)						\
> +(*({									\
> +	typeof(&_var) __Fp = &_var;					\
> +	struct pmu *__pmu = _pmu;					\
> +									\
> +	if (__pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE)	\
> +		__Fp = &hybrid_pmu(__pmu)->_var;			\
> +									\
> +	__Fp;								\
>  }))
>  
> -#define hybrid_bit(_pmu, _field)			\
> -({							\
> -	bool __Fp = x86_pmu._field;			\
> -							\
> -	if (is_hybrid() && (_pmu))			\
> -		__Fp = hybrid_pmu(_pmu)->_field;	\
> -							\
> -	__Fp;						\
> +#define hybrid_bit(_pmu, _field)					\
> +({									\
> +	bool __Fp = x86_pmu._field;					\
> +	struct pmu *__pmu = _pmu;					\
> +									\
> +	if (__pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE)	\
> +		__Fp = hybrid_pmu(__pmu)->_field;			\
> +									\
> +	__Fp;								\
>  })
>  
>  /*
