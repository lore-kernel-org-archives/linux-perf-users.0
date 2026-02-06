Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35401DE8BF;
	Fri,  6 Feb 2026 01:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770341649; cv=none; b=iUwMeahVN1TrqBqBW+f/fNfA99PapmFbxWd3eLLLWvF3wO4pvwjX3u/Qi8Ro9etGOLu5ws3KxDwmG6w2/voyxJNBUVk/pInJCZwnBYyZOa8j/1QOw62F8oRWiHtBqTE01UYF3rB2bN97QWXtdk+ipe+tWBvCKepL+hFieHilhVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770341649; c=relaxed/simple;
	bh=fFxcGT+L+JV19ydZ/XgG+QQkeU9MT4E1xbVZAmElpX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f3bQObOVAsPshi81d3AU8NzA8QrlQRs8ppTs+aiy19/zofZtyxwVjY03Bu5XOFO/n5TrWn/tu0GicILuTMoXxnkegpessaBSM9rFo6ImN5pEAXAEMZaDgr/wrgPOLsaOSN/2K8hOdNC4U0VWEwm5JTWy187GVAE4w5BqKFMcplM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=QD07RnPO; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="QD07RnPO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1770341599;
	bh=omyy70O3OuJ3VKPU2PzEKTpT9f6MeOhreIgYvWT0TaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=QD07RnPOCILFHz50XHH5mqEvGqH4YyF8vrjecOwWB9+UQtVrpJr7beu84OBiXP2cI
	 m/IZF0D+KARp95TSv69fwBIkHd3T3sgzCDeNPqDVk3zp+wc5dkp7+9U00mP4wyd4GP
	 NiyZfimfKhs0dCNNloCHqaFY28tN9qX/gS/MjyeI=
X-QQ-mid: zesmtpsz2t1770341592t1b2531e8
X-QQ-Originating-IP: IGc2qSSjBPifceWa0Fo5f41QcQ3coZKZBB3/OIZklF4=
Received: from [10.3.91.191] ( [101.70.125.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 06 Feb 2026 09:33:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3718362222748311692
Message-ID: <B8005DB6301AACB4+374512e1-f561-4d2f-afd6-7a4b51012501@linux.spacemit.com>
Date: Fri, 6 Feb 2026 09:33:09 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] dt-bindings: iommu: Add spacemit/t100 features
To: Conor Dooley <conor@kernel.org>
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Jingyu Li <joey.li@spacemit.com>,
 iommu@lists.linux.dev, linux-perf-users@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 devicetree@vger.kernel.org
References: <cover.1769562575.git.lv.zheng@spacemit.com>
 <cover.1770195980.git.lv.zheng@linux.spacemit.com>
 <A0E91F323138E92F+a27d73b00f3324f0d3885128f5596230b3f1370b.1770195980.git.lv.zheng@linux.spacemit.com>
 <20260204-primer-wrought-6f64b14bf152@spud>
 <53171BEB06F43599+7c1f54bc-e72d-4cbd-9d10-194ae6b13744@linux.spacemit.com>
 <20260205-attitude-customer-129fe2bd5dc7@spud>
Content-Language: en-US
From: Lv Zheng <lv.zheng@linux.spacemit.com>
In-Reply-To: <20260205-attitude-customer-129fe2bd5dc7@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NpfbsqbTlzxUCzfq5/Ht/zQVJr3Bf4NUwUOdJ0yKuokkmbVjA4paMjQL
	4P+y5Sb/x2r4ENt8IPN+u1sNaRtD6J0QQprHOFmsn/aDCg61UG9d/e8vgplO24EYYmzrD1K
	8LkWC6kRc1rTWVDJIs7IZp9cdyOYkmsxQIzj9qpVLUlySQkio9Epye1AyvWYDx5DN3lvyv7
	gexLk6MLENDqFrrGFMmwxDruTGzgB54S6dn9Nyb9MLNRaDtFZFCjGh8g1apqmYothR39zN4
	OARlarPovAHNEYhFw6g9r1aac5Cn/SqpieglMBygIUdmBBQZzCREDp4e/0cNyPssA3Fed8n
	MELiOn1wvmuNLDe8If8RsHOfPs6638OrIrAOYkSnfhc5tqwBjaBseuImDZl16NaU/ktFqXt
	pZ5BarfNsWr+z0rSmzah3bUJEH+uqXdMx5hK+wXI2p6NZoy8oeTnp0TzqO8RwlyrB+JQ3LC
	tzc4fFgJKLFODbWTMqwhj21nq3+08mVZzsyKnlO6L64avZNCqlfATYSkkAOX0M99ADxvcX6
	mAPgVbvzt5dV1AAsJFRGGQHeVWoNbtc0zqPCy7iDugjqwQi5VkUhjHbXijy/Eg3YmmeRl4R
	L7MLtzN8w4llS/srGye5InBXNbv0q+urusZJvd9jahfsKGJSlzUSLT37mQjXXMVt6ueGbou
	kdzg4tj7xX9PO9HwHLWof65dC4Km6ziD+hOVCAYL88QPAwZZvBkcRVWb1KRFdWcxJAoMrWz
	ghWrlscjUfb5Q8HUhGWUsXhNHDNJUREyDD3/pNf/DbgQhYFcjpUMcwb1DG+dVy9YG0lfnWc
	Z49zEUvc1j7ZECtJD+F2fyWrs8t2gUromBwZtCD0CuB7z9HCzNxj+btctKZkCgNFEdeAFfe
	i3fud1EWG3g5qZN94w3KIHl2heZMI826kPInG+0OKlIfpqOy4BRP8qh2Iev2PU9ZcUrsRd8
	6/LpRAdtAXORLMEfNhghXSHzMdH6HtAhMhjDYPCPv14B65LC57k8QaiFO1HCq52woYqEiZ0
	GcxksBJfeocoJz+3xw/aprWTNHdYU=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

On 2/6/2026 2:24 AM, Conor Dooley wrote:
> On Thu, Feb 05, 2026 at 11:11:51AM +0800, Lv Zheng wrote:
>> On 2/5/2026 1:37 AM, Conor Dooley wrote:
>>> On Wed, Feb 04, 2026 at 05:09:12PM +0800, Lv Zheng wrote:
>>>> Adds device tree bindings for SpacemiT T100 specific features by
>>>> introducing spacemit,100 compatible. T100 contains distributed IOATCs,
>>>> each of which exposes pmiv interrupt.
>>>>
>>>> Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
>>>> Signed-off-by: Jingyu Li <joey.li@spacemit.com>
>>>> ---
>>>>    .../bindings/iommu/riscv,iommu.yaml           | 37 +++++++++++++++++++
>>>>    1 file changed, 37 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
>>>> index d4838c3b3741..2da3456e7402 100644
>>>> --- a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
>>>> +++ b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
>>>> @@ -32,6 +32,12 @@ properties:
>>>>      # should be specified along with 'reg' property providing MMIO location.
>>>>      compatible:
>>>>        oneOf:
>>>> +      - description: SpacemiT distributed IOMMUs
>>>> +        items:
>>>> +          - enum:
>>>> +              - spacemit,t100
>>>> +          - const: spacemit,riscv-iommu
>>>
>>> What actually is the t100? Is it an SoC or is it the name of the core
>>> complex IP that spacemit is using in multiple SoCs?
>>
>> T100 is the name of the IOMMU IP developed by SpacemiT, announced in RISC-V
>> 2024 China Summit:
>> https://www.bilibili.com/video/BV1DNtCeiEBk/
>> It's world first server SPEC IOMMU in RISC-V, supports IOTLB placed in
>> adjacent to the DMA masters and supports PCIe ATS and PRI.
>> You can find it shipped in the recent publicly purchasable SoC SpacemiT K3.
> 
> Right, then what you need here is something like:
> 
> items:
>    - enum:
>        - spacemit,k3-iommu
>    - spacemit,t100-iommu
>    - riscv,iommu
> 
> Driver can then match on spacemit,t100-iommu - but you need to have
> soc-specific compatibles.
> I'm not convinced that riscv,iommu is suitable here though, does the
> driver work on your platform without the portions of code that are added
> by this series and enabled by your new compatible? If not, the I don't
> think the riscv,iommu fallback should be here.
> 
> Additionally, please stop sending new versions so frequently and in
> response to earlier submissions. I have a v4 in my inbox while we are
> still discussing v3.

SpacemiT provides RISC-V IOMMU implementation, T100 is the first
generation of the this IP product line, we have plan to develop T200,
T300, etc., with more features introduced to be adoptive to new
RISC-V IOMMU specifications.
Besides, T100 is not only shipped in K3, but also shipped in V100 and
the follow-up SoCs, like Kn, Vn00, they will likely use the same
synthesis result of T100 RTLs.

 From SpacemiT's point of view, we need a common sense of this IP
series for something like IOATCs, that's why spacemit,riscv-iommu
(this is same like qemu,riscv-iommu) is introduced. And a common sense
of T100 for all SoCs shipped T100 (like global filters, vendor events
and etc.,).

IMO, the current compatible is proper to reflect these concerns.
What do you think?

Cheers,
Lv

> 
> Cheers,
> Conor.

