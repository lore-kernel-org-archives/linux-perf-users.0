Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B0C2DA779;
	Fri, 21 Nov 2025 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763745759; cv=none; b=hVq+MiITEF1f48zeMNlXhvXTSdSgRVUwV+I3lBq7d1pkRIDkdSs5TdMAZRk8cGstYV85a+RyLFd4dsd7Es3LBKf6XrK347cZfmBVKXSgKRfd2T/vCFs4YXrTC7fj5zqnvaWwGYt2LwvFyKZxOfDhZtrzvLg89iCO9yHT+tIEyMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763745759; c=relaxed/simple;
	bh=+h/Yc1dp+CFDd2KN9AzZ5krPiFpi1l2fIrX/TdWsPiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RuQJVR4pErvrPd7xCPqacKvj1pnqOApBJPVZYZ/o30t18rLPtOqOiIV26bAwXbXxAZdhPjPL8jqmphGqFJJ2iBYsxaIkM49EUy7ngRabbz7uTyP6A0jXWyhMbiHa4eEbFz7RJle2e3maOiZf+TUpIk7Zhu3+DMWm/vIOfNiPi58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FV5pDfBV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FV5pDfBV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D175C4CEF1;
	Fri, 21 Nov 2025 17:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763745758;
	bh=+h/Yc1dp+CFDd2KN9AzZ5krPiFpi1l2fIrX/TdWsPiY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FV5pDfBV2jcsTBz79mbt5JpGGRP/X4G560gmlcngXYzRsGfIbM+ZvL5KLTBtIhlLD
	 PN2xJ5REsMsNWGlVLjeQdPPAjhj3zsRgkgpvMFkffUsGrbAWzHKHu2AJdmZ5kgxDp3
	 3BOIyx/M4oc+4azxtaORJCSDAGV6rw6ZkQyi1TJ7LAUpw64GiySSAEzjBM+dzS62Eb
	 Jyw4q4fjh3N4F+bRveDoC589oWd8hVQU7WS1Pwz1xKHVvYfoasCTOKyBXUlW0xTemv
	 +boYsnTURbA3mku4rsSbOEc+j4mmUyMWhTiDl1GLAadLk8TzhknO/maSWnKPRb2uji
	 UKHZ92926CMaw==
Message-ID: <88bfaf9f-4483-4bcd-b3a8-de453ce6417f@kernel.org>
Date: Fri, 21 Nov 2025 18:22:31 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: vendor-prefixes: Add prefix for
 XuanTie
To: Guo Ren <guoren@kernel.org>, Conor Dooley <conor@kernel.org>
Cc: cp0613@linux.alibaba.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, james.clark@linaro.org, devicetree@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251121063439.2545-1-cp0613@linux.alibaba.com>
 <20251121063439.2545-2-cp0613@linux.alibaba.com>
 <20251121-able-terrestrial-spaniel-90c3cf@kuoka>
 <20251121-shortlist-coroner-b29e19293b40@spud>
 <CAJF2gTRUmUHrTsOBM82kNq2cSYmeYr9NC_ORacUnqHAefFSaWw@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <CAJF2gTRUmUHrTsOBM82kNq2cSYmeYr9NC_ORacUnqHAefFSaWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/11/2025 14:01, Guo Ren wrote:
> On Fri, Nov 21, 2025 at 8:31 PM Conor Dooley <conor@kernel.org> wrote:
>>
>> On Fri, Nov 21, 2025 at 10:01:07AM +0100, Krzysztof Kozlowski wrote:
>>> On Fri, Nov 21, 2025 at 02:34:36PM +0800, cp0613@linux.alibaba.com wrote:
>>>> From: Chen Pei <cp0613@linux.alibaba.com>
>>>>
>>>> Add new vendor strings to dt bindings for RISC-V vendor XuanTie.
>>>>
>>>> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>>>> index f1d1882009ba..5d28b2da94cd 100644
>>>> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
>>>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>>>> @@ -1829,6 +1829,8 @@ patternProperties:
>>>>      description: Xilinx
>>>>    "^xnano,.*":
>>>>      description: Xnano
>>>> +  "^xuantie,.*":
>>>> +    description: C-SKY Microsystems Co., Ltd. (XuanTie)
>>>
>>> We do not create new prefixes for existing entries. You have already
>>> csky, alibaba and thead and probably many more. Choose some appropriate.
> We could leave the one C-SKY vendor entry, how about:
> 
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -347,8 +347,8 @@ patternProperties:
>      description: Creative Technology Ltd
>    "^crystalfontz,.*":
>      description: Crystalfontz America, Inc.
> -  "^csky,.*":
> -    description: Hangzhou C-SKY Microsystems Co., Ltd
> +  "^xuantie,.*":
> +    description: C-SKY Microsystems Co., Ltd. (XuanTie)
>    "^csot,.*":
>      description: Guangzhou China Star Optoelectronics Technology Co., Ltd
>    "^csq,.*":
> 
> The arch/csky is the architecture name, which means "xuantie,csky".
> 
> The c810 is the CPU product name, which means "xuantie,c810" of the
> "xuantie,csky" architecture.
> 
> The c930 is the CPU product name, which means "xuantie,c930".
> 
>>
>> When the vendor literally says "C-SKY", it's hard to buy why csky
>> shouldn't be used here. Xuantie is described as being a brand, where at
>> least t-head was a company. This seems akin to having
>> "snapdragon,msm8660" instead of "qcom,msm8660", for example.
> Yes, XuanTie is not only a brand, but also the abbreviation of C-SKY
> Microsystems Co., Ltd.

"XuanTie is a brand", so not suitable for vendor prefixes.

https://www.xrvm.com/declaration

What's more:

<<A reference to “C-SKY”, “we” or “us” is a reference to C-SKY
Microsystems Co., Ltd. of Room >>

So again c-sky.


Best regards,
Krzysztof
