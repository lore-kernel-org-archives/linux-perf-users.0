Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793859432;
	b=vKtPYXkIdhq9K18xC8kSs+YHdJdIv15ix0mOUnr89MXEIsub7PVQsm5/B+7ZUezPWgYd
	 3NaYGALT2M5ESlyI4Jc2yW4GSPmVxg/cEUFrtTW/rQLNbYb/IZXw3bFfI4bGXit19JHfD
	 FLTL4TEQNhVYse8uJAAOw/FN3A45d0LPWOBmQA3f5P54nThN4W6v6Emwx/kUxG/npVKFH
	 s8IhaDwoteVSdDyiJc32cWyYKldzGGUfSf4WHskxQNpidpK/2w88h+jv/JHVHDKxqrK2Y
	 yyS7KHrYU5CRdLcwL8SchZ5wOgFnYhfmDycXlWFSG21TZENZwaWu3BdPWAaRWEPR4PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793859432;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=FkbqZx+ozZpuxuRFwNNK8eMnlfcmoK/zTIth0bhRqY0=;
	b=1qSfnIu2tjOlLorFq2azdCRV7Eoi5aoobl2tiqf3u2U8pExO1mmw0OQlu+fWQ599Dzc1
	 E5axPEgoid6YB+8wB7KbYyDZt5AGYbJzLFHr3ucr37bJFN4631FvOyozLISjE0qy2Tk8C
	 CVxJ3CPsSKr+Z90DUH9rxivlsbjf2C9F6jSVOTjDrg0TnVbMg7igrC0Z4ddEQzioZKAPf
	 G4exdLXTNsLA2E3RMUyZnHdM9zR8JIgV+kjLw/ZIGGqPzFFeNIzb0OCXfIwF4ILV6qsI1
	 sGV3tDLqh7TVn9XPlURJvrM1I/PNbsd51WqTVI6PusWnYt8lgEfho+xbGNNa/m6U7Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a+maoXHo;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A2D606A31B
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 06:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4A2D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a+maoXHo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793859432; x=1825395432;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iKZf/EqISe2A5VPDpfuLG/4MEGRd5uG/2iuXsK37itg=;
  b=a+maoXHoFEMzvvjfLmzT3B/Mgm5FY3CnBApuKCbabB+4bO20+vnACy1l
   o1RoN7x0EA7oYcRDMo6xvt7SBnF4oB/m4nXjE6Z4gGbB3B9dMqdT/jU1T
   tLdHiWXqZR/EljyYv2om30ORjcS8BjfeuMNv1zI4pCJ1WsSNTW4PShNbs
   NyWnBnNUqW4J8LfywPl5s/azH9OJvkGk6OCROYPhzOh0rS4T1MNsCGsfL
   N559irZ4TMNOWKIl6vX6ETFOpNuMcaeZNENaHj6qB7kGcU9CH0M2ibIrA
   kVhQsmRZj7tGvSyEwCE75ydy9W92UkJoXTlmDIMmrS2e0OFhUPPtkY8Vr
   w==;
X-CSE-ConnectionGUID: VVj8tYgdT+SzMSUePfxAKQ==
X-CSE-MsgGUID: 6YLh9aJyTKqh7f6SBmXELw==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2508868"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2508868"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 22:17:12 -0800
X-CSE-ConnectionGUID: cnCCUV9mTJ+XiD5IHettZw==
X-CSE-MsgGUID: 5JcwMWmlSmKuO0WEq9xiuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="7084008"
Received: from unknown (HELO [10.238.2.61]) ([10.238.2.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 22:17:09 -0800
Message-ID: <569b3882-5862-4f6f-96b7-302910e2cf4e@linux.intel.com>
Date: Thu, 5 Nov 2026 14:17:07 +0800
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
Subject: Re: perf_event: avoiding gpf on rdpmc for top-down-events on hybrid
To: Peter Zijlstra <peterz@infradead.org>, Ian Rogers <irogers@google.com>,
 x86@kernel.org
Cc: Vince Weaver <vincent.weaver@maine.edu>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org
References: <b0b0ae91-785e-64f6-348a-ca6edd448b74@maine.edu>
 <CAP-5=fVivxz-TPVap6-+6U=ueU9W9fdZSH3w5F7e-h=uN--8kA@mail.gmail.com>
 <CAP-5=fVa14Y+0a=nrxo85uEOHfiEJRbQXt6fOV7E3dQJDf4fdQ@mail.gmail.com>
 <2c759cfb-41b2-6f50-e893-1545a965d106@maine.edu>
 <CAP-5=fXHgzhp6=xrVi1GK6gO_dtVAAStK__eKKoaAvvge4oNow@mail.gmail.com>
 <CAP-5=fWYfMe8y-xcZkkEnppA11+H0r33Xnn0Mn2d4_y3dortmQ@mail.gmail.com>
 <20250617181738.GD1613376@noisy.programming.kicks-ass.net>
 <CAP-5=fUbEuwHKOAJhvgHbbfg_f=KcED=9a94ra++cPbNLJP5BQ@mail.gmail.com>
 <20250618084522.GE1613376@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250618084522.GE1613376@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/18/2025 4:45 PM, Peter Zijlstra wrote:
> On Tue, Jun 17, 2025 at 01:36:40PM -0700, Ian Rogers wrote:
>
>> Thanks Peter, out of curiosity, how does the RDPMC fail? If an event
>> were rescheduled (even with RSEQ assuming the CPU the thread is
>> running on doesn't change) could the RDPMC with the incorrect index
>> also fail?
> So the problem with RDPMC is that it will #GP when used with an invalid
> index.
>
> Normally, when counting using fixed or general purpose events, this is
> not a problem, because every CPU in the machine has those. So while the
> index might not be the event you were after, the instruction doesn't
> trap, we observe the sequence changed and retry the loop. No harm done.
>
> But for the top-down thingies, the P-cores will have a RDPMC idx that
> the E-cores do not support. Using this index on an E-core will #GP.
>
> So the following situation:
>
> 	CPU-P				CPU-E
>
> 	do {
> 	  seq = pc->lock;
> 	  barrier();
>
> 	  index = pc->index;
> 	  count = pc->count;
> 	  if (index) {
> 	    width = pm->pmc_width;
> 	
> 			<migrate task to CPU-E>
>
> 					    rdpmc(index - 1); <-- #GP
> 					  }
>
> 					  barrier();
> 					} while (pc->lock != seq);
>
> Where the task is migrated from a P to an E core after reading the
> index but before doing RDPMC, turns fatal.
>
> When we use RSEQ, the migration will abort the sequence and the RDPMC
> will not be executed.
>
>
> Aand... while writing this I wondered why we don't simply fix up the
> fault in kernel space. Something like so...

If we silently drop the #GP for invalid rdpmc index, it would make the
kernel's behavior inconsistent with what SDM describes, "Specifying an
unsupported PMC encoding will cause a general protection exception #GP(0)."
It may break users' default assumption and cause some issues.


>
> ---
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 9f88b8a78e50..90391526acf7 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -677,6 +677,43 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
>  
>  #define GPFSTR "general protection fault"
>  
> +static bool fixup_rdpmc_exception(struct pt_regs *regs)
> +{
> +	struct mm_struct *mm = current->mm;
> +	u8 buf[MAX_INSN_SIZE];
> +	struct insn insn;
> +	int len;
> +
> +	len = insn_fetch_from_user(regs, buf);
> +	if (len <= 0)
> +		return false;
> +
> +	if (!insn_decode_from_regs(&insn, regs, buf, len))
> +		return false;
> +
> +	/* RDPMC */
> +	if (insn.opcode.bytes[0] != 0x0f || insn.opcode.bytes[1] != 0x33)
> +		return false;
> +
> +	if (!atomic_read(&mm->context.perf_rdpmc_allowed))
> +		return false;
> +
> +	/*
> +	 * So userspace RDPMC is allowed and took #GP.
> +	 *
> +	 * This means they got the index wrong. But per the ABI described in
> +	 * struct perf_event_mmap_page; this means they'll also fail the
> +	 * sequence lock and will retry the operation after re-reading the
> +	 * index.
> +	 *
> +	 * Fake out the RDPMC by returning all zeros and continue.
> +	 */
> +	regs->ax = 0;
> +	regs->dx = 0;
> +	regs->ip += insn.length;
> +	return true;
> +}
> +
>  static bool fixup_iopl_exception(struct pt_regs *regs)
>  {
>  	struct thread_struct *t = &current->thread;
> @@ -812,6 +849,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
>  	}
>  
>  	if (user_mode(regs)) {
> +		if (fixup_rdpmc_exception(regs))
> +			goto exit;
> +
>  		if (fixup_iopl_exception(regs))
>  			goto exit;
>  
