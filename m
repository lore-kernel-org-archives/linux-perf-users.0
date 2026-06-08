Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C482EEE95;
	Mon,  8 Jun 2026 02:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780886870; cv=none; b=BBwOnsM9DKqyqX33i+GesQv0BN7Dlj+WRKN/wElZr//h487wXbcWmr+v7zzsQ/3AgOEuG2cyMZdMvAxk38udcldwgiTVqQlnt+bX3sUJT1LkvuGr2dgI2YNPdL4vovKSnI6W5og/9qxC325WensSO/ATXLwkzm0Ddf5Z7BWTkas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780886870; c=relaxed/simple;
	bh=kQ3CrknEcfErIPbAVXxw6X7j4yk11zINN/qnrgcOPzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QABxS3AAuhTRUnuZMFUtbXoQx/xSLrCpj/3lWyr64YgjPI44ocD+uc2ijwJfWemAVeanpKf/bkjWlzdEtvHyo5vjSA/GSkSSmRkD+YTMPI2hZAJt1bKLLB2VY5QVItKGjRkHvLUBWprf2Sx0z1rhVGyINryYMAKqjWgvddoE3HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q2dIAxT+; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q2dIAxT+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780886869; x=1812422869;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kQ3CrknEcfErIPbAVXxw6X7j4yk11zINN/qnrgcOPzs=;
  b=Q2dIAxT+lPlivdmKpijmQGtbaH8S1Qa3n91eZMTinM7Dqt81LCATdqw6
   1LPye1NrQ6nMF3oK9znXE1k3Ltx7+pb2EDlZnsREnuhmasnb+s38GZHi7
   HbpMK8i8dbncboNtpVET/d2MgCeoQTSej5E1zRS/5HhpXDJUFo/yUlHJc
   7QziomxJz6G1sKj4jwC1TgxQ+ETdBXF0SootIO0RBPahlt7qfn8/cOXlB
   S2dHdl5/OY+p14llAoC8sPSWiE3glducJeJDAq24rr8AlZCEreYEGLyWx
   TIu7+C6qCAS3E4V8vlWbfX23fVIeWDB/YySKmkXOuFLDYbIFgtwodulAg
   Q==;
X-CSE-ConnectionGUID: hcj1ZsF8QlCEqKrVQORKqw==
X-CSE-MsgGUID: m1jkcYT0QMm42pnFJ3zr/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="81472503"
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="81472503"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 19:47:48 -0700
X-CSE-ConnectionGUID: tz2uf14HTyKfDq3L01+Cgw==
X-CSE-MsgGUID: BeDtA30XQHWg60N/plM87A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="244300849"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 19:47:44 -0700
Message-ID: <ec947a5f-3f97-474a-8dcc-8499cc952746@linux.intel.com>
Date: Mon, 8 Jun 2026 10:47:41 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] perf/core: Fix kernel register info leak via hardware
 skid
To: "Falcon, Thomas" <thomas.falcon@intel.com>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "ak@linux.intel.com" <ak@linux.intel.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "acme@kernel.org" <acme@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "Hunter, Adrian" <adrian.hunter@intel.com>,
 "namhyung@kernel.org" <namhyung@kernel.org>, "Rogers, Ian"
 <irogers@google.com>, "Eranian, Stephane" <eranian@google.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "Chen, Zide" <zide.chen@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "Mi, Dapeng1" <dapeng1.mi@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
References: <20260605011136.2043393-1-dapeng1.mi@linux.intel.com>
 <20260605011136.2043393-9-dapeng1.mi@linux.intel.com>
 <6e3a013359d6d0691a9ed3294520accaa36592c6.camel@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <6e3a013359d6d0691a9ed3294520accaa36592c6.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 6/6/2026 3:08 AM, Falcon, Thomas wrote:
> On Fri, 2026-06-05 at 09:11 +0800, Dapeng Mi wrote:
>> An unprivileged hardware perf event using exclude_kernel=1 can leak
>> kernel
>> register data to user space via PERF_SAMPLE_REGS_INTR. Due to
>> hardware
>> skid, a PMI may trigger after the CPU has already entered kernel
>> space
>> (Ring 0), bypassing the perf_allow_kernel() privilege barrier.
>>
>> This security vulnerability is severely exacerbated by upcoming
>> support
>> for SIMD register sampling via XSAVES, which could expose sensitive
>> kernel
>> FPU states (such as active cryptographic keys).
>>
>> Fix this by ensuring that sampled register data is dropped if the
>> event's
>> exclude_kernel attribute is set but the PMI catches the CPU in kernel
>> mode.
>>
>> Link:
>> https://lore.kernel.org/all/20260529085613.CCAFB1F00893@smtp.kernel.org/
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  kernel/events/core.c | 20 ++++++++++++++++----
>>  1 file changed, 16 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 7935d5663944..b7326bc3acd0 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -7800,10 +7800,21 @@ static void perf_sample_regs_user(struct
>> perf_regs *regs_user,
>>  }
>>  
>>  static void perf_sample_regs_intr(struct perf_regs *regs_intr,
>> -				  struct pt_regs *regs)
>> +				  struct pt_regs *regs,
>> +				  bool exclude_kernel)
>>  {
>> -	regs_intr->regs = regs;
>> -	regs_intr->abi  = perf_reg_abi(current);
>> +	/*
>> +	 * Hardware skid can lead to PMI is delivered after
>> +	 * the CPU has already entered kernel mode. In that case,
> Sorry to nitpick but it might be better to say "Hardware skid can lead
> to a scenario where a PMI is delivered..."

Sure. Thanks.


>
> Other than that, LGTM.
>
> Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
>
> Thanks,
> Tom
>
>> +	 * user-space sampling must not expose kernel register
>> state.
>> +	 */
>> +	if (exclude_kernel && !user_mode(regs)) {
>> +		regs_intr->abi = PERF_SAMPLE_REGS_ABI_NONE;
>> +		regs_intr->regs = NULL;
>> +	} else {
>> +		regs_intr->regs = regs;
>> +		regs_intr->abi = perf_reg_abi(current);
>> +	}
>>  }
>>  
>>  
>> @@ -8694,7 +8705,8 @@ void perf_prepare_sample(struct
>> perf_sample_data *data,
>>  		/* regs dump ABI info */
>>  		int size = sizeof(u64);
>>  
>> -		perf_sample_regs_intr(&data->regs_intr, regs);
>> +		perf_sample_regs_intr(&data->regs_intr, regs,
>> +				      event->attr.exclude_kernel);
>>  
>>  		if (data->regs_intr.regs) {
>>  			u64 mask = event->attr.sample_regs_intr;
