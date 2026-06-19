Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E792E3451CE
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Jun 2026 23:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781912970; cv=none; b=MLiNTMLXQcoqs8NQ5qFJTdnt1MG9mYuSwUEWPLzIUSOhDWoeoDJAxigCg+aomS/xOTcAVhdABD3LtnETrXsPU1AQg3Xbz6iySs6Nyaf2+bYwWYPCeA2Bbxb4INbjOF99tMm3ai/VF9fPfzPvG/tBSO/glmtVC3qz8ihWemrDy9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781912970; c=relaxed/simple;
	bh=iAaQXQfyyez7M9huvHEEK5f4DTZlorcC+Cw0pos3tdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=frLGLI+4yyFiwTkl3c6l6WDG1XjqfYfnhhm8/ybYwk/rKpNGaAPMCZnhQKphvzi49PvmdurAy+HfiL8DBzvtHM+Zw7GYPsz1GcT1qrU4KGSkq/Y/JL0MxV+nSAdMM13xOmUKkWEbyqot4Esm5o3f4Gbt2uNQsMQdtz0Psd4/5Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qcWl5Rk5; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qcWl5Rk5"
Message-ID: <d997993c-5383-414c-bf07-9316ea956404@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781912967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lBI6Yu5z162t9+MmhDRgf4ObBGTmChunkGVdzdlyXuw=;
	b=qcWl5Rk5hEd52czj3AJO03YxYK7AgrwV/IcN7vZkEFltt2pRfU56JXe8nbMcM/SCP48KVA
	o9qVJoXyCO/nlGa+lXZRmTyjUHx79tgHOaDohNTL6qnwASZeyDquEAp5RrR37KXzepJFRV
	vgCTjvR2eGLFe8caXuH9mDElnIjILoI=
Date: Fri, 19 Jun 2026 16:49:23 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 09/21] dt-bindings: riscv: add Counter delegation ISA
 extensions description
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, linux-perf-users@vger.kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org
References: <20260608-counter_delegation-v6-9-285b72ed65a9@meta.com>
 <20260609061239.160901F00893@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <20260609061239.160901F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/8/26 11:12 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Medium] Incorrect dependency for smcdeleg: depends on sscsrind instead of smcsrind.
> - [Medium] The ssccfg extension is over-constrained by strictly requiring smcntrpmf.
> - [Low] Contradictory description for the smcdeleg extension.
> --
>
> commit 53fb261803de68f9caaa685d63588c9cac6c0f5c
> Author: Atish Patra <atishp@rivosinc.com>
>
> dt-bindings: riscv: add Counter delegation ISA extensions description
>
> This commit adds device tree binding descriptions for the Smcdeleg and
> Ssccfg RISC-V ISA extensions. It also specifies the conditional dependencies
> required for these extensions to pass schema validation.
>
>> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
>> index ece3edccee42c..2845e8e2999a7 100644
>> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
>> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
>> @@ -181,6 +181,13 @@ properties:
>>               changes to interrupts as frozen at commit ccbddab ("Merge pull
>>               request #42 from riscv/jhauser-2023-RC4") of riscv-aia.
>>   
>> +        - const: smcdeleg
>> +          description: |
>> +            The standard Smcdeleg supervisor-level extension for the machine mode
> [Severity: Low]
> This isn't a bug, but should this say machine-level instead of
> supervisor-level? Since it has an Sm prefix and is meant for machine mode,
> calling it a supervisor-level extension might be a copy-paste typo.

In this case, it is not true. Quoting the RISC-V spec.
For a RISC-V hardware platform, Smcdeleg and Ssccfg must always be 
implemented in tandem.

https://docs.riscv.org/reference/isa/v20260120/priv/smcdeleg.html

>> +            to delegate the hpmcounters to supervisor mode so that they are
>> +            directly accessible in the supervisor mode as ratified in the
>> +            20240213 version of the privileged ISA specification.
> [ ... ]
>
>> @@ -1135,6 +1150,36 @@ properties:
>>               allOf:
>>                 - const: zilsd
>>                 - const: zca
>> +      # Smcdeleg depends on Sscsrind, Zihpm, Zicntr
>> +      - if:
>> +          contains:
>> +            const: smcdeleg
>> +        then:
>> +          allOf:
>> +            - contains:
>> +                const: sscsrind
> [Severity: Medium]
> Does smcdeleg actually depend on sscsrind here?
>
> Since smcdeleg is a machine-mode extension that uses M-mode indirect CSRs to
> delegate counters, shouldn't it depend on the smcsrind extension instead of
> sscsrind? If a valid hardware configuration implements smcsrind and smcdeleg
> without sscsrind, would this schema incorrectly reject it?

Yes. Answered above.


>> +            - contains:
>> +                const: zihpm
>> +            - contains:
>> +                const: zicntr
>> +      # Ssccfg depends on Smcdeleg, Sscsrind, Zihpm, Zicntr, Sscofpmf, Smcntrpmf
>> +      - if:
>> +          contains:
>> +            const: ssccfg
>> +        then:
>> +          allOf:
>> +            - contains:
>> +                const: smcdeleg
>> +            - contains:
>> +                const: sscsrind
>> +            - contains:
>> +                const: sscofpmf
>> +            - contains:
>> +                const: smcntrpmf
> [Severity: Medium]
> Is smcntrpmf a strict requirement for ssccfg?
>
> The ssccfg extension provides supervisor-mode access to delegated counters,
> but the kernel implementation seems to only conditionally expose
> cyclecfg/instretcfg CSRs if smcntrpmf is present. If ssccfg can exist
> independently, will requiring smcntrpmf in this binding incorrectly fail
> validation for valid hardware that omits it?

While it is ideal to have that, we can relax that dependency.

Smcntrpmf is strictly dependant on Smcdeleg/Ssccfg extensions 
implementation but not the other way around.

>> +            - contains:
>> +                const: zihpm
>> +            - contains:
>> +                const: zicntr
