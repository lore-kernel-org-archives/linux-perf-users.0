Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793006102;
	b=lSM+dQMHXD6OqA3MsOEyYOUDlMGyHznr+BXF0OQpPqOT5IIjSDXYDi8kyz87msmo++/7
	 Wr+HeD+NtG78aaT2O+Pr6EiolVimyPqbxbPQu3bF8QFZuRbReB5aclrpdwiS98zNi6I3u
	 i6dyLJLC0tMgAvyUyfjbu8ZaTn23q8Ef7hAP8BZORKE4HB9VbI1tQJ/LGXD1Ilx7K95Tm
	 i3TCpi9wz3FO/NRNhpJdzYvaBqhsgHGX6Ti/IzPctoiZvQ3pPu+PfDZI8OaAJM/5uMLHc
	 NPV31U3jkc5anEgX36RReS/HpeNJD0UNlGLP/jg/2LpdIiqJH9IVnC5/lSLT3qWHr0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793006102;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=3Cay3XJGA8mhwDRdi6OMoIdd/lKnH6RK+bTVGw2TBMw=;
	b=Pyd+5gSCUfsxvzjawPVDUvC9ZSR4TzH02cf2r2z4Led/1ripWEQTIHhXe2jlFzWnAidD
	 DH0pBC5AYXDKyEexWbtxm80DzNlYin1LBkvH/Ci2mxnLy8Jk7VIoSB6G2bYSLIgzetZjP
	 7zA7FVwete6nqa70znSCYlq9OAXT7kawA+5nOyh2i49reMudV0yKmOw59wnUrtHnjboyA
	 xhZtzeOMidnSOeT0ivWVk2r1HiBV1VNtopPUmVuelf9DQhgEMCAmVNBNOB42zlG8X/lMq
	 eS6YHGlXz3VxeM2zT96kZkam1HpoeMz1Z+7MxZrgHcZ+LYZ+xjpaM3Ef+89CwCO+zTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Si8JDsQQ;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFBC606A31A;
	Mon, 26 Oct 2026 09:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCFBC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Si8JDsQQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793006101; x=1824542101;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mkjA0wjx5T4/havSH95hvAHbESqHIZHy27oTaCk4dxw=;
  b=Si8JDsQQyDyWUdPoivtp91tixgGZH9Qkylc62hsERELIC+bWwlkvL6E6
   CCqQ1aqP7dSO1GHV0TiR+/yMpua1qh0dOnxMB9sRu426HtvWXB2MmHEpE
   5mgZBZkAoAeRBwEXjTnkehKBTlynYUXDTbzFUbH3ES2LmZdeD6pgZQ9XO
   u6mq/7TjIWKpUTfkQtarf+trKVHn+bBL8R8TnnEsau7gXz8RsPmHSyEhb
   WXEh7Hm2dGfCjhSx9DWVGpDtn2A2C0xz05lV2OJRD6By7YOgTPW8/3frU
   P8P/uhjWPDSw6D34n3wlm87WqiwIG1SQmskwNsulcR+lj+Y5zyU2c9Hf3
   Q==;
X-CSE-ConnectionGUID: M2kP9l4BTICBEIUhDDyWxw==
X-CSE-MsgGUID: xqDhMHw2Qa+p2J2wIqI4vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1686782"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1686782"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 02:15:00 -0700
X-CSE-ConnectionGUID: uMAviPBQQxylIjMGhS5q6A==
X-CSE-MsgGUID: 5GlWO6WIRzOCYqNULaw4jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4244457"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 02:14:56 -0700
Message-ID: <1190a947-b314-4df4-91ac-b4cafc2b527c@linux.intel.com>
Date: Mon, 26 Oct 2026 17:14:54 +0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] perf/amd/ibs: Fix kernel address leak via
 REGS_USER and REGS_INTR
To: Ravi Bangoria <ravi.bangoria@amd.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Jim Mattson <jmattson@google.com>
Cc: Jayapal Ashwin Nair <janair@amd.com>,
 Gennady Kupava <gennady.kupava@gmail.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 x86@kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Santosh Shukla <santosh.shukla@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das
 <sandipan.das@amd.com>, Manali Shukla <manali.shukla@amd.com>
References: <20261026041838.941-1-ravi.bangoria@amd.com>
 <20261026041838.941-3-ravi.bangoria@amd.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20261026041838.941-3-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

LGTM. Thanks.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

On 10/26/2026 12:18 PM, Ravi Bangoria wrote:
> IBS hardware captures a sample and raises an NMI. Since the NMI can be
> delivered with a delay, a privilege change may occur between sample
> capture and NMI delivery. Because IBS only provides the sample RIP, the
> kernel records GPRs from the NMI pt_regs, which may reflect kernel mode
> if a privilege switch occurred in the interim. This can leak kernel
> addresses to unprivileged users through PERF_SAMPLE_REGS_USER and/or
> PERF_SAMPLE_REGS_INTR.
>
> Fix this by using interrupt regs while preparing PERF_SAMPLE_REGS_USER
> and PERF_SAMPLE_REGS_INTR. With the change, when IBS samples a user mode
> instruction but the NMI is delivered in kernel mode, PERF_SAMPLE_REGS_USER
> will source its register state from task_pt_regs(current) and
> PERF_SAMPLE_REGS_INTR will be omitted from the data sent to userspace.
>
> In addition to fixing the kernel address leak, this change also ensures
> GPR snapshot consistency, which resolves the DWARF unwinding issue with
> IBS.
>
> Reported-by: Gennady Kupava <gennady.kupava@gmail.com>
> Closes: https://lore.kernel.org/r/CAPu-DQqF0aF6=GS8Z6KKWeeX_V5LiXeKU_rJQZC+uGg8zuTPNw@mail.gmail.com
> Reported-by: Jayapal Ashwin Nair <janair@amd.com>
> Fixes: d29e744c7167 ("perf/x86: Relax privilege filter restriction on AMD IBS")
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  arch/x86/events/amd/ibs.c  | 50 ++++++++++++++++++++++++++++++++++++++
>  include/linux/perf_event.h |  6 +++++
>  kernel/events/core.c       | 10 ++++----
>  3 files changed, 61 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index bfb51f8e184f..78a36ebf2d23 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -1533,6 +1533,56 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
>  		throttle = perf_event_account_interrupt(event);
>  		goto out;
>  	}
> +
> +	/*
> +	 * IBS captured RIP is out of sync with NMI pt_regs due to NMI
> +	 * delivery latency. Use NMI pt_regs for PERF_SAMPLE_REGS_USER.
> +	 *
> +	 * Note: Valid user regs are required for PERF_SAMPLE_STACK_USER.
> +	 */
> +	if (event->attr.sample_type & (PERF_SAMPLE_REGS_USER |
> +				       PERF_SAMPLE_STACK_USER)) {
> +		perf_sample_regs_user(&data.regs_user, iregs);
> +
> +		/*
> +		 * Don't update dyn_size if user has not requrested for
> +		 * PERF_SAMPLE_REGS_USER.
> +		 */
> +		if (event->attr.sample_type & PERF_SAMPLE_REGS_USER) {
> +			/* regs dump ABI info */
> +			int size = sizeof(u64);
> +
> +			if (data.regs_user.regs) {
> +				u64 mask = event->attr.sample_regs_user;
> +				size += hweight64(mask) * sizeof(u64);
> +			}
> +
> +			data.dyn_size += size;
> +		}
> +
> +		data.sample_flags |= PERF_SAMPLE_REGS_USER;
> +	}
> +
> +	/*
> +	 * IBS captured RIP is out of sync with NMI pt_regs due to NMI
> +	 * delivery latency. Use NMI pt_regs for PERF_SAMPLE_REGS_INTR.
> +	 */
> +	if (event->attr.sample_type & PERF_SAMPLE_REGS_INTR) {
> +		/* regs dump ABI info */
> +		int size = sizeof(u64);
> +
> +		perf_sample_regs_intr(&data.regs_intr, iregs,
> +				      event->attr.exclude_kernel);
> +
> +		if (data.regs_intr.regs) {
> +			u64 mask = event->attr.sample_regs_intr;
> +			size += hweight64(mask) * sizeof(u64);
> +		}
> +
> +		data.dyn_size += size;
> +		data.sample_flags |= PERF_SAMPLE_REGS_INTR;
> +	}
> +
>  	/*
>  	 * Prevent leaking physical addresses to unprivileged users. Skip
>  	 * PERF_SAMPLE_PHYS_ADDR check since generic code prevents it for
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 2d5e7687875b..ca495f6b03c4 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1791,6 +1791,12 @@ extern unsigned long perf_misc_flags(struct perf_event *event, struct pt_regs *r
>  extern unsigned long perf_instruction_pointer(struct perf_event *event,
>  					      struct pt_regs *regs);
>  
> +extern void perf_sample_regs_user(struct perf_regs *regs_user,
> +				  struct pt_regs *regs);
> +extern void perf_sample_regs_intr(struct perf_regs *regs_intr,
> +				  struct pt_regs *regs,
> +				  bool exclude_kernel);
> +
>  #ifndef perf_arch_misc_flags
>  # define perf_arch_misc_flags(regs) \
>  		(user_mode(regs) ? PERF_RECORD_MISC_USER : PERF_RECORD_MISC_KERNEL)
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 7846d70be57f..69b767ace309 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7846,8 +7846,8 @@ perf_output_sample_regs(struct perf_output_handle *handle,
>  	}
>  }
>  
> -static void perf_sample_regs_user(struct perf_regs *regs_user,
> -				  struct pt_regs *regs)
> +void perf_sample_regs_user(struct perf_regs *regs_user,
> +			   struct pt_regs *regs)
>  {
>  	if (user_mode(regs)) {
>  		regs_user->abi = perf_reg_abi(current);
> @@ -7860,9 +7860,9 @@ static void perf_sample_regs_user(struct perf_regs *regs_user,
>  	}
>  }
>  
> -static void perf_sample_regs_intr(struct perf_regs *regs_intr,
> -				  struct pt_regs *regs,
> -				  bool exclude_kernel)
> +void perf_sample_regs_intr(struct perf_regs *regs_intr,
> +			   struct pt_regs *regs,
> +			   bool exclude_kernel)
>  {
>  	/*
>  	 * Hardware skid can lead to a scenario where a PMI is
