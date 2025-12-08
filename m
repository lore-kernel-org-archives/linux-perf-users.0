Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DDD23D7FF;
	Mon,  8 Dec 2025 05:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765171498; cv=none; b=ZoomdPUSJ4ny92l4G3kisdaUAF/cDZPwivuKK5fioxPRzvN2DZebkeci8ruwkAHB06pZa81+KfjcjPrdbmRLrfP11tKux1AU6e22mLjvnT2sI0/AjhsgjOPW+JSdcOHAap60AV5Mhl7NkbAtoE3FoK/EkeyInFhGIE7kCmU+x0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765171498; c=relaxed/simple;
	bh=bEMRxkvNs0KYgcxdzq6z0odYgVI65uj9k4Zl8E0EFL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGeaeaDzMDBBO95Fkq9DIpKBZU9rqBHT+6aoj6GYTtCn6icfKoUKnsQcDO8Jw9OE5BwJP7e9N8USJM5CbE1Tpq2Jsx7cY9xUKEuvL1upNLl6wNecbSDHN3cX3DcV0jZUKq0J58KQi2y0/md2vPODQdNuerYQjCTupWMgfT8oCSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZZ4VYN0; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZZ4VYN0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765171496; x=1796707496;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bEMRxkvNs0KYgcxdzq6z0odYgVI65uj9k4Zl8E0EFL4=;
  b=ZZZ4VYN0gadZk/fpXw3gDCshSA4Qyyd7M4VP9/aIdm2j9aeRBT9+hc7J
   4MYDc6VyUNoeqf3rtawk85FVB6mLYsiUSDljpzWbYkHdzDs+RCM+juMHS
   7Ube4tx14L4NA2pL/RSa1iuxk2lAVPylgOPqK5zW+stINzH7sm+k/H0YU
   pbzNTHSeymdkqtWeeD7EPOLqNV8vrLgeVk6MCyrSZ5+Lx0Ez/Z2B5fAZ3
   8JnaBQBrXwFoqMBeW2GYnbTNYOK5eCWkxqat/0YHLhHYuf1Ez8Jkw4ZDI
   rGnpOYIJsQAq9k3QNRG9ALEDjR0BYsytJOzG5YlRWdwRwbIc/W6fcGqTE
   g==;
X-CSE-ConnectionGUID: iLvwjikqTRyX0UjHI+YP+g==
X-CSE-MsgGUID: TZolH5mnSKeA/UZgTdQrYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="77431380"
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="77431380"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 21:24:55 -0800
X-CSE-ConnectionGUID: lN2N9BaiRT+SrG+gFzoTeQ==
X-CSE-MsgGUID: ntuZ6btuRQyRSNjcG0D9aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="233215898"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.12]) ([10.124.240.12])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 21:24:50 -0800
Message-ID: <288614cf-d22f-4329-8440-5a3ab7299041@linux.intel.com>
Date: Mon, 8 Dec 2025 13:24:47 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 07/19] perf: Add sampling support for SIMD registers
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Xudong Hao <xudong.hao@intel.com>, Kan Liang <kan.liang@linux.intel.com>
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
 <20251203065500.2597594-8-dapeng1.mi@linux.intel.com>
 <20251205110706.GT2528459@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251205110706.GT2528459@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 12/5/2025 7:07 PM, Peter Zijlstra wrote:
> On Wed, Dec 03, 2025 at 02:54:48PM +0800, Dapeng Mi wrote:
>
>> @@ -545,6 +547,25 @@ struct perf_event_attr {
>>  	__u64	sig_data;
>>  
>>  	__u64	config3; /* extension of config2 */
>> +
>> +
>> +	/*
>> +	 * Defines set of SIMD registers to dump on samples.
>> +	 * The sample_simd_regs_enabled !=0 implies the
>> +	 * set of SIMD registers is used to config all SIMD registers.
>> +	 * If !sample_simd_regs_enabled, sample_regs_XXX may be used to
>> +	 * config some SIMD registers on X86.
>> +	 */
>> +	union {
>> +		__u16 sample_simd_regs_enabled;
>> +		__u16 sample_simd_pred_reg_qwords;
>> +	};
>> +	__u32 sample_simd_pred_reg_intr;
>> +	__u32 sample_simd_pred_reg_user;
>> +	__u16 sample_simd_vec_reg_qwords;
>> +	__u64 sample_simd_vec_reg_intr;
>> +	__u64 sample_simd_vec_reg_user;
>> +	__u32 __reserved_4;
>>  };
> This is poorly aligned and causes holes.
>
> This:
>
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index d292f96bc06f..2deb8dd0ca37 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -545,6 +545,14 @@ struct perf_event_attr {
>  	__u64	sig_data;
>  
>  	__u64	config3; /* extension of config2 */
> +
> +	__u16	sample_simd_pred_reg_qwords;
> +	__u32	sample_simd_pred_reg_intr;
> +	__u32	sample_simd_pred_reg_user;
> +	__u16	sample_simd_vec_reg_qwords;
> +	__u64	sample_simd_vec_reg_intr;
> +	__u64	sample_simd_vec_reg_user;
> +	__u32	__reserved_4;
>  };
>  
>  /*
>
> results in:
>
>         __u64                      config3;              /*   128     8 */
>         __u16                      sample_simd_pred_reg_qwords; /*   136     2 */
>
>         /* XXX 2 bytes hole, try to pack */
>
>         __u32                      sample_simd_pred_reg_intr; /*   140     4 */
>         __u32                      sample_simd_pred_reg_user; /*   144     4 */
>         __u16                      sample_simd_vec_reg_qwords; /*   148     2 */
>
>         /* XXX 2 bytes hole, try to pack */
>
>         __u64                      sample_simd_vec_reg_intr; /*   152     8 */
>         __u64                      sample_simd_vec_reg_user; /*   160     8 */
>         __u32                      __reserved_4;         /*   168     4 */
>
>
>
> A better layout might be:
>
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index d292f96bc06f..f72707e9df68 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -545,6 +545,15 @@ struct perf_event_attr {
>  	__u64	sig_data;
>  
>  	__u64	config3; /* extension of config2 */
> +
> +	__u16	sample_simd_pred_reg_qwords;
> +	__u16	sample_simd_vec_reg_qwords;
> +	__u32	__reserved_4;
> +
> +	__u32	sample_simd_pred_reg_intr;
> +	__u32	sample_simd_pred_reg_user;
> +	__u64	sample_simd_vec_reg_intr;
> +	__u64	sample_simd_vec_reg_user;
>  };
>  
>  /*
>
> such that:
>
>         __u64                      config3;              /*   128     8 */
>         __u16                      sample_simd_pred_reg_qwords; /*   136     2 */
>         __u16                      sample_simd_vec_reg_qwords; /*   138     2 */
>         __u32                      __reserved_4;         /*   140     4 */
>         __u32                      sample_simd_pred_reg_intr; /*   144     4 */
>         __u32                      sample_simd_pred_reg_user; /*   148     4 */
>         __u64                      sample_simd_vec_reg_intr; /*   152     8 */
>         __u64                      sample_simd_vec_reg_user; /*   160     8 */
>
Sure. Thanks.


>
