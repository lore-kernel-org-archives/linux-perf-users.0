Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA82346E47
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Jun 2026 23:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781912403; cv=none; b=QWhfknxnshccQ8CdLU6l3DK4N9BIlLErVJg9mOHM3qkmPW9/5JdSXsA8hYhsiOIT0w1Maw0AyWBgM0ErGiROh26hbf81dqybjbWVY9ppQqdNNknfHGpx5IvDRD2pXJnrka0wmBqzLJe3g8Rb2YlPxj43CnCzp9KT45lfBWhrAkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781912403; c=relaxed/simple;
	bh=HLd093fW6fiXSx0iDoYDRpSHWr7hdA4IeBLK0H8xz38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vfdjt45locnBhZXu46q1Wrr6ozLo06yEwVYJj7+VtmSGRHT3h0DlldTv/KseYf4cad95gjsxCiN/VuuJo1gIOckQ5GGZMQYC04D2N65uLuIGx451Ax/qHcQgWoceTizTR0TLKp+uEaXnXAmCEdicKo22Pyou+7IN4x4EsveTHvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=thjLR9H7; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="thjLR9H7"
Message-ID: <81003947-40c1-4d3c-9c65-bc7f7257628f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781912389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h+bdE/VVGhwRt3zFUnvNiBBGwABz8YqbPEbj27wTHWo=;
	b=thjLR9H70PxWBvpfvSKvv/IXvd6Se7M1wiNY6P9Sxo6NUQisfmLYJNBlu6/El6qEqkzD4J
	w14dEw2pNwyLsqZ3UWjtjyjlWUmExwhoxEg0ecXlvyUOm7+YUZlL/1hC9gxnymOjxG84ZS
	PWuknfuyF3KjmPRfZiTcI5kTfjmW18w=
Date: Fri, 19 Jun 2026 16:39:45 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 03/21] dt-bindings: riscv: add Sxcsrind ISA extension
 description
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org
References: <20260608-counter_delegation-v6-3-285b72ed65a9@meta.com>
 <20260609060921.547691F00893@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <20260609060921.547691F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/8/26 11:09 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Low] The `sscsrind` extension is inserted out of alphanumeric order, violating the explicit formatting rule in the binding file.
> - [Low] The description for `smcsrind` contains a copy-paste error incorrectly labeling it as a 'supervisor-level' extension, and both `smcsrind` and `sscsrind` contain a grammatical typo.
> --
>
> commit a4e1326a37463e042ca0a72ff72d93f2be1d22f8
> Author: Atish Patra <atishp@rivosinc.com>
>
> dt-bindings: riscv: add Sxcsrind ISA extension description
>
> Add the S[m|s]csrind ISA extension description.
>
>> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
>> index 2b0a8a93bb214..4be557dc215de 100644
>> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
>> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
>> @@ -181,6 +181,14 @@ properties:
>>               changes to interrupts as frozen at commit ccbddab ("Merge pull
>>               request #42 from riscv/jhauser-2023-RC4") of riscv-aia.
>>   
>> +        - const: smcsrind
>> +          description: |
>> +            The standard Smcsrind supervisor-level extension extends the
>> +            indirect CSR access mechanism defined by the Smaia extension. This
> [Severity: Low]
> Is this description accurate for smcsrind? The m in Smcsrind indicates
> it is a machine-level extension, rather than a supervisor-level extension.
>
>> +            extension allows other ISA extension to use indirect CSR access
> [Severity: Low]
> This isn't a bug, but there is a typo here. Should "ISA extension" be
> pluralized to "ISA extensions"?
>
>> +            mechanism in M-mode as ratified in the 20240326 version of the
>> +            privileged ISA specification.
>> +
> [ ... ]
>
>> @@ -199,6 +207,14 @@ properties:
>>               added by other RISC-V extensions in H/S/VS/U/VU modes and as
>>               ratified at commit a28bfae (Ratified (#7)) of riscv-state-enable.
>>   
>> +        - const: sscsrind
>> +          description: |
>> +            The standard Sscsrind supervisor-level extension extends the
>> +            indirect CSR access mechanism defined by the Ssaia extension. This
>> +            extension allows other ISA extension to use indirect CSR access
> [Severity: Low]
> This isn't a bug, but there is the same typo here. Should "ISA extension" be
> pluralized to "ISA extensions"?
>
>> +            mechanism in S-mode as ratified in the 20240326 version of the
>> +            privileged ISA specification.
>> +
>>           - const: ssaia
> [Severity: Low]
> Should sscsrind be placed after ssaia rather than before it? The
> extensions in this file are expected to be sorted alphanumerically.

Fixed the typos in v7.


>>             description: |
>>               The standard Ssaia supervisor-level extension for the advanced
