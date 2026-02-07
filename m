Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1A81482E8;
	Sat,  7 Feb 2026 04:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770438350; cv=none; b=QZ6UBL+99EDXEqjQLrLJlaMTyl2yS5a/J6Q2TxFkK9+u4qDTjdUvq7isPWbJIHp65zzBsukMWCM9Fs2OKOsnYI1awlYGjq3nDtIzkQaEe/OwkyuqkPPMoA/VR2w+dD+Zc0Vs2W2dg5fOS5AJWxOevvhA7oDu7VVSne7QO2O6hKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770438350; c=relaxed/simple;
	bh=ePffqzyX84NHHqllGIynUa4cK2gT0JXT1s+peIuTnrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WB5HN5ie18sOWN202vk8m1kCYTQiz/JOjuSKNXYK41JtHY7GuhN6JWUVRuxHuN7tydF33qbJLs8v3VZe2x3vHXeQbpRqmLyBzz4UBOwzfhcTu/BnUCWF2VQsz0vUK/EL9q35vxhkf+aJNeucQne0WNYYzd4bphL/fHHUWU6/82o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=y5yY3fbv; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="y5yY3fbv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1770438281;
	bh=CQYvnaGEzgZpCE74zg7SoO/TB2ehyMWN1aSoI7gi5Is=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=y5yY3fbvgXFlrgoDvs0dxqrJHB6qr/Dc6qUU8I9OWHE/7UVZvr3Fv1Ro2HNK0seDV
	 rZgTZSGmBnh927GtiuB19N+uyqC+7vU4vkNx64QytkL5z3BLJpJyx1tgwMGL+AJFM4
	 2tBJ+eXkY6ETflFIJmhmBVsbIJI36fpto/licoRI=
X-QQ-mid: zesmtpip4t1770438274t6e2f2d0d
X-QQ-Originating-IP: SiYifUz4R84wVKt78tfvZCqvpi89f2wr1I4Vp6P87qE=
Received: from [IPV6:2409:8a1e:3015:50f0:29fb: ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 07 Feb 2026 12:24:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13206828355001701766
Message-ID: <7433DA16B96EE987+9b6398e6-edad-4a2e-814d-921483e5f1da@linux.spacemit.com>
Date: Sat, 7 Feb 2026 12:24:30 +0800
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
 <B8005DB6301AACB4+374512e1-f561-4d2f-afd6-7a4b51012501@linux.spacemit.com>
 <20260206-buffed-scrubbed-36fc49ada496@spud>
Content-Language: en-US
From: Lv Zheng <lv.zheng@linux.spacemit.com>
In-Reply-To: <20260206-buffed-scrubbed-36fc49ada496@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: OVMqbsUyNYbucEUZokUuD6PFEVoLvf2aVkZWQ8LhTuAGNWu1GuprdAx3
	dfpCWVZ+TBvIaMAwA1UVoR4cT0N+2CdCxkxBOnj8Eq3fI3njpyQzbgGmXT2QtEHM5/pOFMe
	6QyoBserxzfJgYzoUqUYQ688W5lVj/Go5myQ0zhOlS0F9X98xcIpxl05rR3uOfgvUu5aliS
	vX+QV1sNJ+Nk1QUHMte5hDbicVFkAvuQpaJzoXSnCw/eIZqOrFwOGKSSkvnIiwLSFI/NrZY
	vNRIHvO40Ha0nZmnpW7FOXBKtEPZyVT59MYB12jjB1IVJ1au4aRbQG2yyQ1fxQ0GJl8SsHw
	DC3UtR/j7TuoMrQ+0tz0U+7Vh/WYI9j/1mZBcv4OzQ2XC1HYmUJSRyq9NPf5ae0/tuij2Uh
	jJvzFxNZRViJUgWj+fOZ6WoKusaNF5rQYs4ai/VOuSjK5to7RY6mSQm1e5D4u4MUOYoUDGd
	NZNEZD+tYPyhLvTJHyYSujUAfrv/bHYHtAJxsGuUHX4OZMjZN5rPpsRk41cS0YljMza0Kbn
	zBSRGF0LBaTKrfPGgG0RzlmUQgH1DsoyHPQveyg32myXHoX+FY7cjPXRCzQE83FCZdvRwSI
	FV5ry2662bCclLzw49kOB9gO2l6E9OjsCm10O6DJ5k8X/qwR++JydrxM12fkuiu4ZF9tDm9
	wQAoh3tsetpyBp5JkcRPIHUGZw075ghQrID95Cjx3NiH9tZ5A2IoT0WFt8g/q75eqosWVmx
	9rJVpSs2JvJ+gWOA88d7qylhLuPS8KDsa8gdOsrGdIpU8PyI8ApbiGgb2QdoTIlVpfMjD7+
	c07+NHEjdMXnIRsY9J37F42IDrxMkmdbjSi9UvQBkkC4xsnGUJnK7oT52ISCZCQO30wIUAE
	8SyoHudANNS5wjyurSrcoseGEUTnzUxik3lgm1QAa3YrstLii+zsyRfWBuNrkhwLVRIg6yc
	AP+AMME/5HuqYnb5uZYoSI2qTqbptV7xZNsh7C+0C35Pd8tawta3xXHy4HjkugicIfy/pl1
	5xcQH9baxM5CgDHjwf1ejNNa17+xhy5A6LBFjAk/F8LAsQYGMLWPY+9jv4M9LdidGuFLFZr
	lvpwnNjess/
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

On 2/6/2026 6:24 PM, Conor Dooley wrote:
> On Fri, Feb 06, 2026 at 09:33:09AM +0800, Lv Zheng wrote:
>> On 2/6/2026 2:24 AM, Conor Dooley wrote:
>>> On Thu, Feb 05, 2026 at 11:11:51AM +0800, Lv Zheng wrote:
>>>> On 2/5/2026 1:37 AM, Conor Dooley wrote:
>>>>> On Wed, Feb 04, 2026 at 05:09:12PM +0800, Lv Zheng wrote:
>>>>>> Adds device tree bindings for SpacemiT T100 specific features by
>>>>>> introducing spacemit,100 compatible. T100 contains distributed IOATCs,
>>>>>> each of which exposes pmiv interrupt.
>>>>>>
>>>>>> Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
>>>>>> Signed-off-by: Jingyu Li <joey.li@spacemit.com>
>>>>>> ---
>>>>>>     .../bindings/iommu/riscv,iommu.yaml           | 37 +++++++++++++++++++
>>>>>>     1 file changed, 37 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
>>>>>> index d4838c3b3741..2da3456e7402 100644
>>>>>> --- a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
>>>>>> @@ -32,6 +32,12 @@ properties:
>>>>>>       # should be specified along with 'reg' property providing MMIO location.
>>>>>>       compatible:
>>>>>>         oneOf:
>>>>>> +      - description: SpacemiT distributed IOMMUs
>>>>>> +        items:
>>>>>> +          - enum:
>>>>>> +              - spacemit,t100
>>>>>> +          - const: spacemit,riscv-iommu
>>>>>
>>>>> What actually is the t100? Is it an SoC or is it the name of the core
>>>>> complex IP that spacemit is using in multiple SoCs?
>>>>
>>>> T100 is the name of the IOMMU IP developed by SpacemiT, announced in RISC-V
>>>> 2024 China Summit:
>>>> https://www.bilibili.com/video/BV1DNtCeiEBk/
>>>> It's world first server SPEC IOMMU in RISC-V, supports IOTLB placed in
>>>> adjacent to the DMA masters and supports PCIe ATS and PRI.
>>>> You can find it shipped in the recent publicly purchasable SoC SpacemiT K3.
>>>
>>> Right, then what you need here is something like:
>>>
>>> items:
>>>     - enum:
>>>         - spacemit,k3-iommu
>>>     - spacemit,t100-iommu
>>>     - riscv,iommu
>>>
>>> Driver can then match on spacemit,t100-iommu - but you need to have
>>> soc-specific compatibles.
>>> I'm not convinced that riscv,iommu is suitable here though, does the
>>> driver work on your platform without the portions of code that are added
>>> by this series and enabled by your new compatible? If not, the I don't
>>> think the riscv,iommu fallback should be here.
>>>
>>> Additionally, please stop sending new versions so frequently and in
>>> response to earlier submissions. I have a v4 in my inbox while we are
>>> still discussing v3.
>>
>> SpacemiT provides RISC-V IOMMU implementation, T100 is the first
>> generation of the this IP product line, we have plan to develop T200,
>> T300, etc., with more features introduced to be adoptive to new
>> RISC-V IOMMU specifications.
>> Besides, T100 is not only shipped in K3, but also shipped in V100 and
>> the follow-up SoCs, like Kn, Vn00, they will likely use the same
>> synthesis result of T100 RTLs.
>>
>>  From SpacemiT's point of view, we need a common sense of this IP
>> series for something like IOATCs, that's why spacemit,riscv-iommu
>> (this is same like qemu,riscv-iommu) is introduced. And a common sense
> 
> No, it's not the same as qemu,riscv-iommu. That exists to avoid
> riscv,iommu being allowed in isolation and as a "SoC"/integration
> specific compatible. The driver matches against riscv,iommu not
> qemu,riscv-iommu and has no qemu,riscv-iommu specific behaviours.
> It is akin to having spacemit,k3-iommu.

Got it.

> 
>> of T100 for all SoCs shipped T100 (like global filters, vendor events
>> and etc.,).
>>
>> IMO, the current compatible is proper to reflect these concerns.
>> What do you think?
> 
> I pretty much already told you what I think, that you need SoC-specific
> compatibles for SoCs that integrate this IP and that the you should drop
> the spacemit,riscv-iommu compatible. The spacemit,riscv-iommu compatible
> doesn't provide any additional value over spacemit,t100-iommu, and has
> the downside of maybe being confusing in the future if spacemit
> produces a iommu that doesn't have the IOATC behaviour.

Sounds reasonable. Thanks.

> 
> Also, I don't see an answer to my question about whether the hardware
> will work without the driver changes this series introduces and enables
> with the new compatible?

Basically, T100 is riscv,iommu compatible, its IOATS part should be able
to work using standard HPM events with standard riscv,iommu HPM
compatible driver. People can now test the real hardware of spacemit
T100 on K3.
https://canonical.com/blog/spacemit-announces-availability-of-ubuntu-on-k3-k1-series
I'll try to ask our product team to find third party testers, and if
any, adds Cc(s) in the next revision.

Without the awareness of this compatible, hardware will face the
following problems:

Handled in this series:
1. No vendor event matches
2. No global filter awareness
3. No IOATC enumeration
That's the basic support introduced in this series to enable some basic
features of T100 that we couldn't find in the upstream.

And there are other features not handled in this series:
4. No identities matching vendors
5. No awareness of only PMIV working as WSI, others (CIV/FIV/PIV) are
    configurable as MSI to make IOATS/IOATC PMIV behaves same and more
    suitable for kernel performance sampling.
6. And many other SpacemiT specific features people can find the
    discussions in the IOMMU spec community that is not limited to HPM,
    ex., RISC-V DMA64 compliance, QEMU old style MSI-PTE support, etc.
7. ACPI support for spacemit,v100-iommu.
8. PCIe ATS/PRI support for spacemit,k3-iommu/spacemit,v100-iommu.
9. etc.

Cheers,
Lv

> 
> Cheers,
> Conor.

