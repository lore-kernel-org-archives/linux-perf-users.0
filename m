Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E516323393F;
	Wed,  9 Sep 2026 00:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788915589; cv=none; b=nvATYrlLAwWWHwAQomJ+9qz50Idqn/pchfqnFBUA4W7vTmxBzKpZaFKmPOxh0AbEb736+ASfDwpIOjH3dso3Tpj88Pr5ym9d898n7EwR300b9M3NgiicpU3MRY1ooU8Rd7rf5zCv2a9ZIOnzVfU0g3yU7vvEAAG+9lil38wc+cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788915589; c=relaxed/simple;
	bh=XPN8BeJt1I2Lrwjxin49notSGuzwILbb+Mho1Mdtd40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZWrCTcMJ2Cm3hO6l797TGrR+f5zlw4AHjv8tsxIFhkuFrffkEQHhyFICvCKVz59C49ucYBeRPEjx2NVTzkc8rboRIIL7K3NnretR8BDwiuvPfv7mQKAe90oKgqnjPKsFNQKtQ8U27AaBXJ+AzVhlRcZ9w02g6sUb+urbwkh/1WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GQ3jeT2Y; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GQ3jeT2Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788915587; x=1820451587;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XPN8BeJt1I2Lrwjxin49notSGuzwILbb+Mho1Mdtd40=;
  b=GQ3jeT2Yv2dbw+kRAH0+O8fCFWjaINmGfkssmjmZplBbqFOBRrPuY+NI
   0jd2Pc3LptSAD9GWMieXxm9OITeA1UBoDct+Zs+xkqq0mXACkppXV9fYF
   SpnFLe3NRPlzZ9xSSQvtRVdbWNAR2FTmlc5RlvjdrGxD+6FcYsJQRi7wH
   OGN0NxtyhfNgnKtP0s5Zguq2pbZa7pyS+DY+i4mTYMizPx+DFEdU1snJ1
   ed+CYE6szJPFV573fdc0X0toT74MfkPb95wBYfsD6fuSuJwRZ4T7nMwcn
   n0qiWF/Ak5MJ+40DNmi2BKgrj9uDOj4zpuGpW4iV40eq7vbcF81A5AFe7
   w==;
X-CSE-ConnectionGUID: 38dABt+OSQi7NE/PiKezaw==
X-CSE-MsgGUID: WsZU1yVNS7+6JGM1sA8iRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="91843810"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="91843810"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 17:59:46 -0700
X-CSE-ConnectionGUID: dnphDW2OTDuaglwkm1nvFw==
X-CSE-MsgGUID: +kgmVxtXQ9mhNIcJNynzzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="271151278"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 17:59:42 -0700
Message-ID: <ddd7d413-ed95-4c3f-9435-1a3e2c27cce2@linux.intel.com>
Date: Wed, 9 Sep 2026 08:59:39 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf/x86: Disable precise sampling for
 PERF_SAMPLE_STACK_USER
To: Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
 Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>, Gennady Kupava
 <gennady.kupava@gmail.com>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20260908075102.540715-1-dapeng1.mi@linux.intel.com>
 <20260908075102.540715-2-dapeng1.mi@linux.intel.com>
 <20260908084906.GO4121339@noisy.programming.kicks-ass.net>
 <1691a05c-49a6-4b16-8bad-cb3c004ed07c@linux.intel.com>
 <20260908101914.GQ4121339@noisy.programming.kicks-ass.net>
 <aqAlddsFPYJvRhFr@tassilo>
 <CAP-5=fWbSNYpt8p3e+pqjY+xhqs8WrzsBfPaKB1NLBm88mH8Yg@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fWbSNYpt8p3e+pqjY+xhqs8WrzsBfPaKB1NLBm88mH8Yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/9/2026 4:56 AM, Ian Rogers wrote:
> On Tue, Sep 8, 2026 at 8:10 AM Andi Kleen <ak@linux.intel.com> wrote:
>>> That's what we already do, no? I have distinct memories of making the
>>> stack unwind use the NMI regs rather then the PEBS regs.
>>>
>>>> In my opinion, it could even make the thing worse. User
>>>> requires to get precise samplings, but perf silently returns imprecise
>>>> records, this would mislead user.
>>> Mostly just the unwind might be off a little, the rest is accurate. This
>>> has been the case 'forever'. Performance analysis isn't for silly
>>> people, if they can't deal with a little fuzz then perhaps they're in
>>> the wrong business.
>> Is the main problem that the stack doesn't agree? Perhaps there
>> could be a check for regs->rsp == pebs->user rsp (if in user space)
>> to detect problematic samples.
>>
>> The question is how to report it and who should do the checking.
>>
>> It may need new fields in the ABI either to communicate the extra PEBS RSP
>> or a bit to indicate that there might be a mismatch.
>>
>> I guess checking in the kernel and reporting an error might be simpler
>> and maybe cleaner, but it would likely limit more advanced recovery
>> possibilities.
>>
>> Are there other mismatches that break the unwinding? Perhaps the same
>> for RBP?
> For DWARF unwinding any register may be the source of a frame pointer
> (e.g. the OpenSSL library would use R11 rather than RBP).
>
> There is redundancy on x86 you can sample the PERF_REG_X86_IP register
> in the user register and there is PERF_SAMPLE_IP in the sample event
> itself.
>
> My understanding is that IBS can only sample IP and so for precise
> samples we can use PERF_SAMPLE_IP as the precise location and the user
> register PERF_REG_X86_IP as the interrupt IP - this would match the
> other register values in the interrupt.
>
> In DWARF unwinding, we initialize the register state using the sampled
> user registers:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/unwind-libdw.c?h=perf-tools-next#n270
> and on x86 we sample all registers for DWARF unwinding:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/arch/x86/include/perf_regs.h?h=perf-tools-next#n20
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/perf-regs-arch/perf_regs_x86.c?h=perf-tools-next#n238
>
> Having PERF_SAMPLE_IP be precise and the user registers from the
> interrupt I believe works for AMD IBS and ARM SPE, but for Intel PEBS
> there is the ability to use the PEBS register samples for other
> non-redundant registers. In the x86 driver could we disable PEBS
> sampling for these registers when doing user stack sampling, so that
> the sampled user registers match the stack sample? We can keep the
> PERF_SAMPLE_IP precise, and make all the registers precise when there
> is no stack sampling.

That sounds the best way to fix this issue by decoupling PERF_SAMPLE_IP
with PERF_REG_X86_IP. Then we can keep the precise SAMPLE_IP and the PMI
context user register snapshot simultaneously.

I would post v2 patch with this fix. Thanks.


>
> Thanks,
> Ian
