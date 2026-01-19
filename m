Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C27277CAF;
	Mon, 19 Jan 2026 07:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768808361; cv=none; b=gUW32UZO0dn5XV1zdh/jYtCEwV0c4ZyXXXp1qVg71ZbTqhnyIdIaI3z2Ktt0PNLle5JwAh5NhxWBA/cSX5REfuYEXE+Wi5qu4zzu+1fGm0so4PtkNqolge7pVqj3wb8DzpWxeXttYvqzmRAPv9w/eAblscFlVK1UWfZBun7TzrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768808361; c=relaxed/simple;
	bh=x1owPE/KSzmrOCj1bMyz5RS7AUugFntuUM0ccKehVzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WBq8sV7csA7P3ZG9DG39etN5okQa3PFrL2ThXvVxBhr2iwT6gFvJ5YY96KkZT1e1qMOAyg2AXvb9nVRoHwSHzG7kA2gPAFKAO1X9qX85f4n5ezH3bu3cxQO3T4s+e1LXfDTZzr12BTP2iOthQrP/37QJBiY1b5C8ldotUBgUbG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BcwhLng/; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BcwhLng/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768808360; x=1800344360;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x1owPE/KSzmrOCj1bMyz5RS7AUugFntuUM0ccKehVzg=;
  b=BcwhLng/l9TgGRcFIavG9asstNkNkko7+Bi9pqot/LILYIvzjXF64dLR
   5KlIfifYQ4Ri40f3/STQXD/J+yRNK82r5l9LjVK2dvOsaahyZ0V730MPc
   WvF7n8J4v7One9GXaNa5o/QVCBncV2kNlYxsTIJ9jcW36z9UfRkHkcxvB
   XYPTWbAihJntk4c4Ak85h5zvxrtz3sAeAZPPsO3KRdG10ILpcTBWT8g0J
   QduUYM17W2TZnUIYQCABCFkpg4byeA0+WBr87xmNUHUq7kqLD0r+93a3B
   UwbTKrgaibLtqKWIgMzG+N9yY3JCGbFG5YXI6W8snzIZkgrrC92ztz9Eo
   g==;
X-CSE-ConnectionGUID: NP/fGCwwQrOO/tZz/sUG8A==
X-CSE-MsgGUID: zBIpKy9aReOA/SKNXyLwYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="69915976"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="69915976"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 23:39:19 -0800
X-CSE-ConnectionGUID: IaQ8z3GRS2mHFOUjNksG7Q==
X-CSE-MsgGUID: mqLyc9hzT8OYpXRQZbBSxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="209938133"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 23:39:14 -0800
Message-ID: <1c880dac-82c6-4e5f-a4b6-eee53e74cded@linux.intel.com>
Date: Mon, 19 Jan 2026 15:39:12 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] perf/amd/ibs: Add new MSRs and CPUID bits
 definitions
To: Ravi Bangoria <ravi.bangoria@amd.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 James Clark <james.clark@linaro.org>, x86@kernel.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Manali Shukla <manali.shukla@amd.com>,
 Santosh Shukla <santosh.shukla@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
References: <20260116033450.965-1-ravi.bangoria@amd.com>
 <20260116033450.965-7-ravi.bangoria@amd.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260116033450.965-7-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/16/2026 11:34 AM, Ravi Bangoria wrote:
> IBS on upcoming microarch introduced two new control MSRs and couple of
> new features. Define macros for them.
>
> New capabilities:
>
>  o IBS_CAPS_DIS: Alternate Fetch and Op IBS disable bits
>  o IBS_CAPS_FETCHLAT: Fetch Latency filter
>  o IBS_CAPS_BIT63_FILTER: Virtual address bit 63 based filters for Fetch
>    and Op
>  o IBS_CAPS_STRMST_RMTSOCKET: Streaming store filter and indicator,
>    remote socket indicator
>
> New control MSRs for above features:
>
>  o MSR_AMD64_IBSFETCHCTL2
>  o MSR_AMD64_IBSOPCTL2
>
> Also do cosmetic alignment changes.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  arch/x86/include/asm/msr-index.h  |  2 ++
>  arch/x86/include/asm/perf_event.h | 52 ++++++++++++++++++++-----------
>  2 files changed, 35 insertions(+), 19 deletions(-)
>
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 3d0a0950d20a..d8b3f3abe583 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -693,6 +693,8 @@
>  #define MSR_AMD64_IBSBRTARGET		0xc001103b
>  #define MSR_AMD64_ICIBSEXTDCTL		0xc001103c
>  #define MSR_AMD64_IBSOPDATA4		0xc001103d
> +#define MSR_AMD64_IBSOPCTL2		0xc001103e
> +#define MSR_AMD64_IBSFETCHCTL2		0xc001103f
>  #define MSR_AMD64_IBS_REG_COUNT_MAX	8 /* includes MSR_AMD64_IBSBRTARGET */
>  #define MSR_AMD64_SVM_AVIC_DOORBELL	0xc001011b
>  #define MSR_AMD64_VM_PAGE_FLUSH		0xc001011e
> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
> index 0d9af4135e0a..6f5ec5c9d5b4 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -639,6 +639,10 @@ struct arch_pebs_cntr_header {
>  #define IBS_CAPS_OPDATA4		(1U<<10)
>  #define IBS_CAPS_ZEN4			(1U<<11)
>  #define IBS_CAPS_OPLDLAT		(1U<<12)
> +#define IBS_CAPS_DIS			(1U<<13)
> +#define IBS_CAPS_FETCHLAT		(1U<<14)
> +#define IBS_CAPS_BIT63_FILTER		(1U<<15)
> +#define IBS_CAPS_STRMST_RMTSOCKET	(1U<<16)
>  #define IBS_CAPS_OPDTLBPGSIZE		(1U<<19)
>  
>  #define IBS_CAPS_DEFAULT		(IBS_CAPS_AVAIL		\
> @@ -653,31 +657,41 @@ struct arch_pebs_cntr_header {
>  #define IBSCTL_LVT_OFFSET_MASK		0x0F
>  
>  /* IBS fetch bits/masks */
> -#define IBS_FETCH_L3MISSONLY	(1ULL<<59)
> -#define IBS_FETCH_RAND_EN	(1ULL<<57)
> -#define IBS_FETCH_VAL		(1ULL<<49)
> -#define IBS_FETCH_ENABLE	(1ULL<<48)
> -#define IBS_FETCH_CNT		0xFFFF0000ULL
> -#define IBS_FETCH_MAX_CNT	0x0000FFFFULL
> +#define IBS_FETCH_L3MISSONLY		      (1ULL << 59)
> +#define IBS_FETCH_RAND_EN		      (1ULL << 57)
> +#define IBS_FETCH_VAL			      (1ULL << 49)
> +#define IBS_FETCH_ENABLE		      (1ULL << 48)
> +#define IBS_FETCH_CNT			     0xFFFF0000ULL
> +#define IBS_FETCH_MAX_CNT		     0x0000FFFFULL
> +
> +#define IBS_FETCH_2_DIS			      (1ULL <<  0)
> +#define IBS_FETCH_2_FETCH_LAT_FILTER	    (0xFULL <<  1)
> +#define IBS_FETCH_2_EXCL_RIP_63_EQ_1	      (1ULL <<  5)
> +#define IBS_FETCH_2_EXCL_RIP_63_EQ_0	      (1ULL <<  6)
>  
>  /*
>   * IBS op bits/masks
>   * The lower 7 bits of the current count are random bits
>   * preloaded by hardware and ignored in software
>   */
> -#define IBS_OP_LDLAT_EN		(1ULL<<63)
> -#define IBS_OP_LDLAT_THRSH	(0xFULL<<59)
> -#define IBS_OP_CUR_CNT		(0xFFF80ULL<<32)
> -#define IBS_OP_CUR_CNT_RAND	(0x0007FULL<<32)
> -#define IBS_OP_CUR_CNT_EXT_MASK	(0x7FULL<<52)
> -#define IBS_OP_CNT_CTL		(1ULL<<19)
> -#define IBS_OP_VAL		(1ULL<<18)
> -#define IBS_OP_ENABLE		(1ULL<<17)
> -#define IBS_OP_L3MISSONLY	(1ULL<<16)
> -#define IBS_OP_MAX_CNT		0x0000FFFFULL
> -#define IBS_OP_MAX_CNT_EXT	0x007FFFFFULL	/* not a register bit mask */
> -#define IBS_OP_MAX_CNT_EXT_MASK	(0x7FULL<<20)	/* separate upper 7 bits */
> -#define IBS_RIP_INVALID		(1ULL<<38)
> +#define IBS_OP_LDLAT_EN			      (1ULL << 63)
> +#define IBS_OP_LDLAT_THRSH		    (0xFULL << 59)
> +#define IBS_OP_CUR_CNT			(0xFFF80ULL << 32)
> +#define IBS_OP_CUR_CNT_RAND		(0x0007FULL << 32)
> +#define IBS_OP_CUR_CNT_EXT_MASK		   (0x7FULL << 52)
> +#define IBS_OP_CNT_CTL			      (1ULL << 19)
> +#define IBS_OP_VAL			      (1ULL << 18)
> +#define IBS_OP_ENABLE			      (1ULL << 17)
> +#define IBS_OP_L3MISSONLY		      (1ULL << 16)
> +#define IBS_OP_MAX_CNT			     0x0000FFFFULL
> +#define IBS_OP_MAX_CNT_EXT		     0x007FFFFFULL	/* not a register bit mask */
> +#define IBS_OP_MAX_CNT_EXT_MASK		   (0x7FULL << 20)	/* separate upper 7 bits */
> +#define IBS_RIP_INVALID			      (1ULL << 38)
> +
> +#define IBS_OP_2_DIS			      (1ULL <<  0)
> +#define IBS_OP_2_EXCL_RIP_63_EQ_0	      (1ULL <<  1)
> +#define IBS_OP_2_EXCL_RIP_63_EQ_1	      (1ULL <<  2)
> +#define IBS_OP_2_STRM_ST_FILTER		      (1ULL <<  3)
>  
>  #ifdef CONFIG_X86_LOCAL_APIC
>  extern u32 get_ibs_caps(void);

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


