Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1033438AF
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Jun 2026 23:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781912441; cv=none; b=DPXNjmrlgTorO5WDrCoC5MMBgh4vCCmGmkdiXUgGno39uTM73OvKCeDVmC1MhZTZSTkqaoCtlO5LzINgf+cGO1NMZtC48S4LHvyj0yXIJnW1SeP2Kln9fmOfQYGqKJkWjJK2JolEhyPSmsRlwD7agoR8oiXGpSwNjAx1LACUShU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781912441; c=relaxed/simple;
	bh=PbW3fqVzRPhO55V63DAT6NbmDMlHINxLcNP6wxIIMnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AInkkPSjwqNvVrFWfRj4L0vWqetGmMU5vdma3+7XPlrrr/95sENt55pn4SH71jSSHA20vBtwkMJ2NGyjgGii7dRFddwjdvPUsS92RdWSplWeKvfSDNa/c37eoPF9IDwyg/IWpgBSNoTzikeHCyPGFYmqLbDkzboXuk9FHQ+dfgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xjYjHJe3; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xjYjHJe3"
Message-ID: <437b1be4-1c01-4dc1-95b5-033d38ec20cf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781912437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dr93Mt28IFAycdde0QN62JpVudutzw3MoBCesVJIkok=;
	b=xjYjHJe3hmK2x9giGnzyvyLU8FCuR8eAlEtYVPe8YrKEAJ3ar+xVqs8G/oVYvwDZfFAENB
	YfcbX2M/CCl+7IR8WADaTr7LQj+NeM8ukjNgebsE8h1a76KaWv+Vuq10G/NfadxW/xlEmv
	NpzNpHvZFmHKghspU35McHvEydQ8TUs=
Date: Fri, 19 Jun 2026 16:40:34 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 06/21] dt-bindings: riscv: add Smcntrpmf ISA extension
 description
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20260608-counter_delegation-v6-6-285b72ed65a9@meta.com>
 <20260609060915.6C7461F00893@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <20260609060915.6C7461F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/8/26 11:09 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Low] The `smcntrpmf` extension is inserted in the wrong alphabetical order.
> - [Low] The description incorrectly refers to `Smcntrpmf` as a 'supervisor-level' extension.
> --
>
> commit 9fd028f70a33e1a78db2f635eed4200c33b6b90d
> Author: Atish Patra <atishp@rivosinc.com>
>
> dt-bindings: riscv: add Smcntrpmf ISA extension description
>
> Add the description for the Smcntrpmf ISA extension.
>
>> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
>> index 4be557dc215de..ece3edccee42c 100644
>> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
>> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
>> @@ -189,6 +189,12 @@ properties:
>>               mechanism in M-mode as ratified in the 20240326 version of the
>>               privileged ISA specification.
>>   
>> +        - const: smcntrpmf
> [Severity: Low]
> Is this inserted in the correct alphabetical order?
>
> The multi-letter extensions list in this file explicitly requires entries to be
> sorted alphanumerically. Alphabetically, smcntrpmf ("c-n") should come before
> the preceding extension (smcsrind, "c-s").
>
>> +          description: |
>> +            The standard Smcntrpmf supervisor-level extension for the machine mode
> [Severity: Low]
> Is "supervisor-level" accurate here?
>
> In the RISC-V ISA naming convention, the "Sm" prefix denotes a standard
> machine-level extension, while "Ss" denotes a supervisor-level extension.
>
> Calling it a "supervisor-level extension for the machine mode" seems
> contradictory. Could this be a copy-paste error?
>
>> +            to enable privilege mode filtering for cycle and instret counters as
>> +            ratified in the 20240326 version of the privileged ISA specification.
>> +
>>           - const: smmpm
>>             description: |
>>               The standard Smmpm extension for M-mode pointer masking as


Fixed in v7.


