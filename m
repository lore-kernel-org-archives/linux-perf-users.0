Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795007234;
	b=iM7EMTpPoAz3bS0oc9FSb9kaBQAg+vzviSHS4rFRioisYMKEJbZz+HnMicLP93vTx6ML
	 2oR/74DCySxguDlTVMX15L4KHKoAABtBl8ilu9rwn8QPP5PvQ9rZ0Dt39PFot3qsCtU/9
	 Ed+0oP6MeUJVbB5P4z8MZBP3fcTGLJmXYH67Lm0RFEajcjpYqeqtVFyFDtQxx5X9zowGs
	 FVa0zB9kgeOBNRi5ylFMWeVOzHkcxpIoA6tLa4lTFR6GyFt4r1NB/MHIXJ9PPFUV6W3z6
	 Y8ceGsv0JhL1FVpOQyuUinG4Fbr2eiQdJKEOG6x/HLVSeHGcMenlZBXcB3cmXAa3VEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795007234;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=jqZDsw4/Pv9G6TuHSSZvax905ZGFTyfcu7eywgbZg64=;
	b=ysyYIFAtFxZt1Hg0IjIeB8KrGmoCeKcOYWMVjTG5/WkQfvDitMXwxJ+5oDyKwvSAlL1o
	 Kzwnk0mhughfAdZsJNgvZoAQ8/+nfR/FTCfP4HoNGfZboy7IE0ypmkSqrZZRl///NL+Ti
	 aENINSqVw+A6wVuzCrAESQ70CDMGZqdYriMK6R68yWuQNYjxWA05Pbcd39gtNK1lz8W7P
	 2h9MMkkxY7jINMURgp0FjIu9F6dlS73tTHJW9zn9N0K4e+Z3uFhLYJpiIT5eqyJjTGpaq
	 vYVvpPRRCWoC6RDxLtz2hcZDpDuoBzZeM5TS32Ju9mPPcsXxcdNqngwrqguPsTakSww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=QupW6SWA;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A308E606A31C;
	Wed, 18 Nov 2026 13:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A308E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=QupW6SWA
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB2A21596;
	Wed, 18 Nov 2026 05:07:08 -0800 (PST)
Received: from [10.57.92.80] (unknown [10.57.92.80])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96E0D3F673;
	Wed, 18 Nov 2026 05:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795007231; bh=HEpShK6JaeOW8psRd/l3RPEF82DAOAZP4AgLiMMwhBU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QupW6SWAiFEoX/bwQ9NysNdamPSKgk89MHHXCd0ACOkYEIz954lHFV8MRL+DE8cVG
	 YvCIPkg66Qttzfq0/Yl5ggwKsbTyrwVYlkPbhyQ4vl5CspuegAHlQidKIHDBtY6SOC
	 9bEqTQJAqeft2gn5jMI19CDKxiclG9Aly36P/81I=
Message-ID: <08d06f8c-026c-4503-8783-6b8a1b59d620@arm.com>
Date: Wed, 18 Nov 2026 13:07:06 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: perf: arm,smmu-v3-pmcg: Allow
 power-domains
To: Amita Mishra <amitamishra@google.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261118101913.3135869-1-amitamishra@google.com>
 <20261118101913.3135869-2-amitamishra@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20261118101913.3135869-2-amitamishra@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-11-18 10:19 am, Amita Mishra wrote:
> On some SoCs, SMMUv3 Performance Monitor Counter Groups (PMCGs) reside
> in switchable power domains rather than an always-on domain.
> 
> Document the optional power-domains property so that runtime power
> management can manage the PMCG power state.

Isn't power-domain-consumer one of the common schemas that's 
automatically applicable to any node anyway? I would think that unless 
we have a specific expectation and description of what each 
power-domains entry should represent - which we cannot reasonably do in 
a binding that is for the architectural PMCG interface rather than any 
specific implementation of such - we'd be better off just leaving it 
implicit.

> Signed-off-by: Amita Mishra <amitamishra@google.com>
> ---
>   Documentation/devicetree/bindings/perf/arm,smmu-v3-pmcg.yaml | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/perf/arm,smmu-v3-pmcg.yaml b/Documentation/devicetree/bindings/perf/arm,smmu-v3-pmcg.yaml
> index a4b53a6a1ebf..aea6623bb98c 100644
> --- a/Documentation/devicetree/bindings/perf/arm,smmu-v3-pmcg.yaml
> +++ b/Documentation/devicetree/bindings/perf/arm,smmu-v3-pmcg.yaml
> @@ -36,6 +36,9 @@ properties:
>   
>     msi-parent: true
>   
> +  power-domains:
> +    maxItems: 1

Even for existing implementations it would be quite possible for a PMCG 
to be functionally dependent on multiple power domains (yes some of them 
should usually be hierarchical, but still...) - what justifies 1 being 
the only "correct" number?

Thanks,
Robin.

> +
>   required:
>     - compatible
>     - reg

