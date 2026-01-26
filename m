Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E95534CFC3;
	Mon, 26 Jan 2026 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769448197; cv=none; b=oDN5CwdU9zI/EDoNjYQugfXqN7mQfUwpPVPrIgQr4GFoPjpVnbSw3mmMphBB3wrg+MQjdoF78opf+tEK87M+Nr03Ucexke1NBL1PzEeOrZsK9xB4WzKBUKAMyUwMpzruyQy982pHMPzDbhlpAVCTqtg0OIqxT66j5qQ7WtGsxNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769448197; c=relaxed/simple;
	bh=wWTiUdLOb7w2SidJa5bHMvRPP0ykk933Vc2pm5XtImI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P3+RYuGbna7oaTBkutf8dVzoRrn+fteuo2dEjntzgMKXBn4awY+a0yKcE27ei089JYX5FQ5b6vPAlqR49umQIT7p9AoX44YVe1JdU7zYavLdDsPburYCD8YrBl0aqRr/9R3FZ5k2VTkY9+YI3sN+Mzzsjiz6w14AjL0zn7Xp3RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5874339;
	Mon, 26 Jan 2026 09:09:41 -0800 (PST)
Received: from [10.57.51.176] (unknown [10.57.51.176])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B1803F5CA;
	Mon, 26 Jan 2026 09:09:46 -0800 (PST)
Message-ID: <5f260792-40f2-4a54-a5d1-45644bc9012b@arm.com>
Date: Mon, 26 Jan 2026 17:09:43 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings/perf: Drop irqs for clock domains without
 a PMU instance
To: Baisheng Gao <baisheng.gao@unisoc.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: cixi.geng@linux.dev, hao_hao.wang@unisoc.com,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20260126033029.7923-1-baisheng.gao@unisoc.com>
 <20260126033029.7923-3-baisheng.gao@unisoc.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260126033029.7923-3-baisheng.gao@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-01-26 3:30 am, Baisheng Gao wrote:
> No need to specify the interrupts for the clock domains without a
> PMU instance.

Yes there is a need, because it's what the binding has already defined 
and systems are already implementing, so breaking compatibility at this 
point more than a year after its introduction is not really acceptable. 
And although there's no strict requirement for the DT and ACPI bindings 
to be equivalent, in this case they currently are, and it doesn't seem 
like you've accounted for ACPI here either.

Fact is, the Arm NI-700, NI-710AE, NoC S3 and SI L1 designs do all 
define <CLKNAME>_nPMUINTERRUPT outputs for each <CLKNAME> domain, and 
the intent of the binding was always to describe the hardware. If it's 
the case that one or more of those interrupts are not wired up at all 
(and presumably the corresponding PMU is never exposed to Non-Secure, 
since it's unlikely to be useful), then at worst it's reasonable to use 
dummy entries to pad the array.

If on the other hand you really have got something that is mangled to 
the point of not being compatible with the stock Arm designs, then it 
most likely warrants its own binding.

Thanks,
Robin.

> Signed-off-by: Baisheng Gao <baisheng.gao@unisoc.com>
> ---
>   Documentation/devicetree/bindings/perf/arm,ni.yaml | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/perf/arm,ni.yaml b/Documentation/devicetree/bindings/perf/arm,ni.yaml
> index d66fffa256d5..40a5b8929ef2 100644
> --- a/Documentation/devicetree/bindings/perf/arm,ni.yaml
> +++ b/Documentation/devicetree/bindings/perf/arm,ni.yaml
> @@ -20,7 +20,8 @@ properties:
>     interrupts:
>       minItems: 1
>       maxItems: 32
> -    description: Overflow interrupts, one per clock domain, in order of domain ID
> +    description: Overflow interrupts, one per clock domain which has a PMU
> +      instance, in order of domain ID.
>   
>   required:
>     - compatible

