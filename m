Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF79347FE1
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Jun 2026 23:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781912682; cv=none; b=fIyuNeCd9yILODcjftFYK6ekyXFRxLIe1pT3CCEIBXAdAQ1qkCoI4b/Nel9BEsk3qJcmwdC/zw4XrMaSWbIBE67CCZyWoQNamiVfs9oMZ3Qa+I4wKyysKN8eAbEZJe/jXAmPhggul3SGRXPssdEkCvx6+dHI63ASJ64MfoObxYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781912682; c=relaxed/simple;
	bh=k4sPsofPq50FCBnLPJKP2N/wX51gag3tFnhuVMeuOcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJROj1VgNeHY815fjhezGnVeaaLPfNkPvbDdPZIxWfGvbiM9YZujKVVQFUs27MqtuAHBYkzZGfekdwMb+nk33fiQNUlobtKsCmZRJhJm3MkPwW5u6v0b+1YTwe6S31IHmPa11h6ebI0oT+O+7xGFROCAjg7Bz3urhOJtvrtuUl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uf6Dexpp; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uf6Dexpp"
Message-ID: <9eb2dc2a-c70b-4edd-b372-d4ec8753e275@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781912678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fDjN+tRuIyMxcjQBYzfqmoHMzOg92k59uplUcNU5q8U=;
	b=uf6DexppIoKgZK+YOC8rvA+af2LXZ+X/Qx8imTz0AgeaaUJFqiW0t4I8D1O8lAm7DuXjw3
	4JN2TDG8U+Dw6tiBdc1L5hUWmfgogwRYD/+sLL5E5gq7u/g4300PLgeYpu7UmuVOiIBf0L
	rh0qaYMO6pLhRnS2wcpQc/7ij6A/bqE=
Date: Fri, 19 Jun 2026 16:44:34 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 08/21] RISC-V: Add Ssccfg/Smcdeleg ISA extension
 definition and parsing
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, linux-perf-users@vger.kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20260608-counter_delegation-v6-8-285b72ed65a9@meta.com>
 <20260609061405.1943F1F00893@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <20260609061405.1943F1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/8/26 11:14 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Supervisor extension Ssccfg incorrectly depends on Machine extension Smcdeleg, breaking virtualization.
> - [Medium] The Smcdeleg extension validation incorrectly checks for the Supervisor-level CSR indirection extension (SSCSRIND) instead of the Machine-level one (SMCSRIND).
> --
>
> commit 53e139b078ec8b41f58b09bfd3d37e7132a15d45
> Author: Atish Patra <atishp@rivosinc.com>
>
>      RISC-V: Add Ssccfg/Smcdeleg ISA extension definition and parsing
>
> This commit adds definitions and parsing logic for the RISC-V Ssccfg
> and Smcdeleg ISA extensions. It introduces validation functions for
> both extensions and adds them to the riscv_isa_ext array.

+linux-riscv

Sashiko probably has a bug where it did not determine correctly which 
mailing lists to cc and left linux-riscv.

>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>> index 1452521d740a6..1fe647e035157 100644
>> --- a/arch/riscv/kernel/cpufeature.c
>> +++ b/arch/riscv/kernel/cpufeature.c
>> @@ -330,6 +330,27 @@ static const unsigned int riscv_a_exts[] = {
>>   	RISCV_ISA_EXT_ZKNE,	\
>>   	RISCV_ISA_EXT_ZKNH
>>   
>> +static int riscv_ext_smcdeleg_validate(const struct riscv_isa_ext_data *data,
>> +				       const unsigned long *isa_bitmap)
>> +{
>> +	if (__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_SSCSRIND) &&
>                                                          ^^^^^^^^^^^^^^^^^^^^^^
> [Severity: Medium]
> Since Smcdeleg is a Machine-mode extension, shouldn't its validation depend on
> the Machine-level CSR indirect access extension (SMCSRIND) rather than the
> Supervisor-level extension (SSCSRIND)?

The reason for this dependency is that both Smcdeleg and SSCSRIND are 
required for using counter
delegation usage in S-mode.


> If the kernel runs in M-mode, or on hardware that implements SMCSRIND but not
> SSCSRIND, this validation might incorrectly fail.
Not a valid use.
>> +	    __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZIHPM) &&
>> +	    __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZICNTR))
>> +		return 0;
>> +
>> +	return -EPROBE_DEFER;
>> +}
>> +
>> +static int riscv_ext_ssccfg_validate(const struct riscv_isa_ext_data *data,
>> +				     const unsigned long *isa_bitmap)
>> +{
>> +	if (!riscv_ext_smcdeleg_validate(data, isa_bitmap) &&
>> +	    __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_SMCDELEG))
> [Severity: High]
> Does this break supervisor counter delegation in virtualized environments?
>
> Smcdeleg is a Machine-mode extension, and hypervisors typically do not expose
> M-mode extensions to guest VMs. A guest kernel running in VS-mode won't see
> Smcdeleg in its ISA string, causing this validation to unconditionally fail
> and return -EPROBE_DEFER.
>
> Should Ssccfg validation only depend on S-mode visible extensions?

No. The spec is not designed that way. Counter delegation is not 
available in VS-mode.

Both comments are N/A

>> +		return 0;
>> +
>> +	return -EPROBE_DEFER;
>> +}
