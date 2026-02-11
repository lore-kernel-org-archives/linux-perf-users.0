Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BE22DD5EF;
	Wed, 11 Feb 2026 06:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770791226; cv=none; b=Ora8g1F/AQiiBpvJw1Jh/WAls7Fampq8NZHxLdH/vwY+TZkaDLF0DWI5XRfrQmP8TNaLdyLTEqBfYZ9SRbGpBj4IvVYOSOmzDBW14KhFgaw/EIv9nLsT7UTJzRBEpU3tiG9Zv8z3Lfw5MAB7bvw8KucIWQF9tTw+aOVeSgENAyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770791226; c=relaxed/simple;
	bh=sl0DcmF+UjURQnFyq7mNahM8rjsQgqTPDIs2rybGba4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lnvjMMLzmyzGhT+hgZRDjxDoElVtKz9KGMG4M+xmweP1rnJQp1npawauWMwvfWiLdbRUTup60+bC+YUnjEZUDISbhUIK+upaEiVSMnxJDAL2cr1MwnPDTvEvVUdGHlOUEv5h33Tn2rL5JPfv8QOzDYO+/WJcSVwea5WN3PMuejg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hyc286H2; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hyc286H2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770791225; x=1802327225;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sl0DcmF+UjURQnFyq7mNahM8rjsQgqTPDIs2rybGba4=;
  b=Hyc286H2gpc5/0FUWOqhf2baemTbV3ap1M1nwztADk6If9ygfqq2sSu5
   dPJi+4iIEiq5DdUt0yLDG3ppk3/uMytzJgVhUwf2x7tlXsX/GNe4Zj6t1
   YMQZBFexembb1BzJs7E1UED+oGxAWoCB3GpQ7hyQMunbTit92o1GPyDpa
   V5YMVrJIKmvpjeINC1gO1cJK3xjfudtySANW7Roo6zV4daeKVLXQFclmM
   Q32lsrIwOaK+eqiWLmEkSPEeWUY1jkMkqDzjkjyD3VqfMvW8m1ue+npCC
   W+Sr8GJbtji2piHoRk+X5ebzIFXPJ+IE8EwaDS1xUZNAA1noDoRO7YqC7
   g==;
X-CSE-ConnectionGUID: G0SfaTC9RcurQPdRUci8Jw==
X-CSE-MsgGUID: 6NNXe7EdSi2Mjza8Qj55zQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="82569715"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="82569715"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 22:27:04 -0800
X-CSE-ConnectionGUID: cjtwSgokTL2H4cgnieQpQA==
X-CSE-MsgGUID: xMYwxDqLTvq4oJEPT2oyIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="216681466"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 22:26:58 -0800
Message-ID: <7e321c09-aa1f-401f-a849-7c251e9264c0@linux.intel.com>
Date: Wed, 11 Feb 2026 14:26:56 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v6 05/22] perf/x86: Use x86_perf_regs in the x86 nmi
 handler
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
References: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
 <20260209072047.2180332-6-dapeng1.mi@linux.intel.com>
 <20260210184016.GP2995752@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260210184016.GP2995752@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2/11/2026 2:40 AM, Peter Zijlstra wrote:
> On Mon, Feb 09, 2026 at 03:20:30PM +0800, Dapeng Mi wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> More and more regs will be supported in the overflow, e.g., more vector
>> registers, SSP, etc. The generic pt_regs struct cannot store all of
>> them. Use a X86 specific x86_perf_regs instead.
>>
>> The struct pt_regs *regs is still passed to x86_pmu_handle_irq(). There
>> is no functional change for the existing code.
>>
>> AMD IBS's NMI handler doesn't utilize the static call
>> x86_pmu_handle_irq(). The x86_perf_regs struct doesn't apply to the AMD
>> IBS. It can be added separately later when AMD IBS supports more regs.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/x86/events/core.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index 6df73e8398cd..8c80d22864d8 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -1785,6 +1785,7 @@ EXPORT_SYMBOL_FOR_KVM(perf_put_guest_lvtpc);
>>  static int
>>  perf_event_nmi_handler(unsigned int cmd, struct pt_regs *regs)
>>  {
>> +	struct x86_perf_regs x86_regs;
>>  	u64 start_clock;
> So a few patches ago you pulled this off stack because too large, and
> then here you stick it on stack again.
>
> That is a wee bit inconsistent.

Oh, yes. Just miss this place since no warning is reported here. Thanks.


>
> Furthermore, I think you can re-purpose that same off-stack copy. After
> all, the pebs_drain thing can only happen:
>
>  - from NMI (like here);
>  - from context switch, when PMU is disabled (and thus no NMIs).

I'm not sure if we can use only one x86_perf_regs instance for both PEBS
and non-PEBS sampling. It may be not. When PEBS and non-PEBS events are
overflowed simultaneously in a PMI, the GPRs' value of non-PEBS event could
be overwritten by the GPRs's value of PEBS events if non-PEBS events and
PEBS events share same x86_perf_regs instance. I need a further check on this.

Thanks.

