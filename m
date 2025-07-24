Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09142EB5D8;
	Thu, 24 Jul 2025 20:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753389671; cv=none; b=sbQML6wBWsv/dexQIAISSyvTwNIaglJ7XGyqlcgiOq/31M9L2vi9b5eeASDQkkKvmNZbSjUNDs5PzkpmBU5beDUm7FYWJ5bhWTLg3NKIIEOCSRFC6XX8H2X+7eZ30SbTx4f4UP5rJR0SDL8Kj3MNOJUQ3F7Tu7zMV/ZBhlybz4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753389671; c=relaxed/simple;
	bh=KV8Aom+xCAJKe5yKH2ON+CSmCTJK6vJRTJvOK8/Ai1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hvqNEPfP4vYaZ7U53n5MypzhhsVgqkEltH3B6pTzpSGBvB511fMcA4BhusBAqEDeVySY6TGSwzADcuo020Z8jzdcltdAuKK1e7EDwhqeaPDg9cyM755FNP6fXoOGhL6JdwN3ZVtFCHeGrhGh4qT/dXEQFgSO3hrHxy1Kl3B9V6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F5F6168F;
	Thu, 24 Jul 2025 13:41:01 -0700 (PDT)
Received: from [172.27.42.155] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 311083F66E;
	Thu, 24 Jul 2025 13:41:07 -0700 (PDT)
Message-ID: <89f67ab9-f8ea-488a-a94b-4a0f32e41bc5@arm.com>
Date: Thu, 24 Jul 2025 15:41:06 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] arm64: uprobes: Add GCS support to uretprobes
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 thiago.bauermann@linaro.org, broonie@kernel.org, yury.khrustalev@arm.com,
 kristina.martsenko@arm.com, liaochang1@huawei.com, will@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Steve Capper <steve.capper@arm.com>
References: <20250719043740.4548-1-jeremy.linton@arm.com>
 <20250719043740.4548-7-jeremy.linton@arm.com> <aIC06oEF5FV99ukl@arm.com>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <aIC06oEF5FV99ukl@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 7/23/25 5:09 AM, Catalin Marinas wrote:
> On Fri, Jul 18, 2025 at 11:37:38PM -0500, Jeremy Linton wrote:
>> @@ -159,11 +160,41 @@ arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
>>   				  struct pt_regs *regs)
>>   {
>>   	unsigned long orig_ret_vaddr;
>> +	unsigned long gcs_ret_vaddr;
>> +	int err = 0;
>> +	u64 gcspr;
>>   
>>   	orig_ret_vaddr = procedure_link_pointer(regs);
>> +
>> +	if (task_gcs_el0_enabled(current)) {
>> +		gcspr = read_sysreg_s(SYS_GCSPR_EL0);
>> +		gcs_ret_vaddr = load_user_gcs((unsigned long __user *)gcspr, &err);
>> +		if (err) {
>> +			force_sig(SIGSEGV);
>> +			goto out;
>> +		}
> 
> Nit: add an empty line here, I find it easier to read.
> 
>> +		/*
>> +		 * If the LR and GCS entry don't match, then some kind of PAC/control
>> +		 * flow happened. Likely because the user is attempting to retprobe
> 
> I don't full get the first sentence.

I'm trying to succinctly warn people about some non-obvious behavior 
that is being maintained.

Really long version:

So a Retprobe is intended to catch the function returning and run the 
user specified probe logic. But the breakpoint itself isn't placed at 
the 'ret' because there may be multiple 'ret's. Rather its intended to 
be placed at the function entry point. When the breakpoint fires, it 
runs this code to hijack the LR and point it at the actual probe 
routine. Except, ha!, the breakpoint for the ret routine may not be at 
the beginning of the function. Which is perfectly ok, even in some cases 
desirable.

But, if the user say places it after LR has been spilled to the stack, 
the hijack will be discarded when LR is restored and the probe will 
silently fail to run. The user will then eventually figure out that they 
are dropping a retprobe in a location where its basically a NOP. PAC 
messes with this behavior in an inconsistent manner. Is the target 
function's just signing the LR, or is its signing and spilling it. In 
the latter case the probe is again just a NOP, otherwise PAC fault.

But then GCS comes along, and it needs to also update the GCS region. 
but if we update it, and the LR gets restored its going to result in a 
GCS exception where previously the behavior was just the probe being 
NOPed. Now though, we have the advantage that for the most part anyplace 
that GCS is enabled, we are also going to have PAC signing the LR. So 
checking for LR != GCS value acts as both a sanity check and a bit of 
safety that we aren't inside a sign/authenticate block, or that the LR 
hasn't been tampered with via a blr/etc and we will restore a LR from 
the stack that won't match the now updated GCS region.

Hence the comment.

:)




> 
>> +		 * on something that isn't a function boundary or inside a leaf
>> +		 * function. Explicitly abort this retprobe because it will generate
>> +		 * a GCS exception.
>> +		 */
>> +		if (gcs_ret_vaddr != orig_ret_vaddr)	{
>> +			orig_ret_vaddr = -1;
>> +			goto out;
>> +		}
> 
> Nit: another empty line here.
> 
>> +		put_user_gcs(trampoline_vaddr, (unsigned long __user *) gcspr, &err);
> 
> Nit: (... *)gcspr (no space after cast).
> 
>> +		if (err) {
>> +			force_sig(SIGSEGV);
>> +			goto out;
>> +		}
>> +	}
>> +
>>   	/* Replace the return addr with trampoline addr */
>>   	procedure_link_pointer_set(regs, trampoline_vaddr);
>>   
>> +out:
>>   	return orig_ret_vaddr;
>>   }
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

