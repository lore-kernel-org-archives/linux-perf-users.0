Received: from out28-172.mail.aliyun.com (out28-172.mail.aliyun.com [115.124.28.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C481625D216;
	Mon,  9 Feb 2026 03:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770607308; cv=none; b=XIGGzfnKjUTQDMvW4m8WHnZueAO+7kVGxLZyFLNuSVcOVe+0JR2WnY5Wda3TUoLz+tSTJDQ/FGPrQ+EV4e6lKqc5YF4RSDCraZnzD7bwdmF1Ulvz2SLfkyi/FBUABDV7d+/uWsAd0y7Cm+FSzh7szUXtALuz5m3A1mRLJ/QLEgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770607308; c=relaxed/simple;
	bh=aQ3gmTI5nWfIIuMUEWsKOlnJsR6KRsiDiAN+cbxEG7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=l0u3fDEM/+2Lr5HT0s5h6uOqCS8V1FZxrTDwxvSdvI4SWm+c69p9t7jWP6zi0ugEjrp2kjtEDIWyiG5VGpyuSETrZGBLGLByJ6VgjgrOvpHmzHEc54Cyp7CvhMVgmk78MHbKl7xtOV1uijn334RCdGfClkIngSTmT1OoSY5XujE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn; spf=pass smtp.mailfrom=bosc.ac.cn; arc=none smtp.client-ip=115.124.28.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bosc.ac.cn
Received: from 172.38.28.171(mailfrom:guoyaxing@bosc.ac.cn fp:SMTPD_---.gScrj65_1770607296 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 09 Feb 2026 11:21:37 +0800
Message-ID: <1e2b448f-3a2a-4b1f-872d-a34f7bd53696@bosc.ac.cn>
Date: Mon, 9 Feb 2026 11:21:32 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] RISC-V IOMMU HPM support
To: Lv Zheng <lv.zheng@linux.spacemit.com>, Zong Li <zong.li@sifive.com>,
 tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, robh@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, mark.rutland@arm.com,
 conor+dt@kernel.org, krzk@kernel.org, luxu.kernel@bytedance.com,
 andrew.jones@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-perf-users@vger.kernel.org
References: <20260208063848.3547817-1-zong.li@sifive.com>
 <D8C71AE40393A6FD+89365591-f896-4609-8b0f-8dffe85b5828@linux.spacemit.com>
From: yaxing guo <guoyaxing@bosc.ac.cn>
In-Reply-To: <D8C71AE40393A6FD+89365591-f896-4609-8b0f-8dffe85b5828@linux.spacemit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/2/9 9:40, Lv Zheng 写道:
> On 2/8/2026 2:38 PM, Zong Li wrote:
>> This series implements support for the RISC-V IOMMU hardware performance
>> monitor.
>>
>> The RISC-V IOMMU PMU driver is implemented as an auxiliary device driver
>> created by the parent RISC-V IOMMU driver. The child driver can obtain
>> resources and information from the parent device, such as the MMIO base
>> address and IRQ number.
>>
>> Custom event support is not included in this series and will be submitted
>> as a separate series. The idea is that custom events will be defined
>> through the driver data of the auxiliary driver. When the parent IOMMU
>> driver creates the auxiliary device, it should pass a vendor-specific
>> name as the device name in order to match the corresponding auxiliary
>> device ID.
>>
>> After my initial RFC and the v1 patch series were posted, similar patch
>> series also appeared on the mailing list.
>>
>> One was from Yaxing Guo:
>> https://lore.kernel.org/all/20250915020911.1313-1-guoyaxing@bosc.ac.cn/
>>
>> and another from Lv Zheng:
>> https://lore.kernel.org/all/30C7AD351DB55276+a8b03dac-c5af-4034-8631- 
>> ac1c352a469f@linux.spacemit.com/
> 
> Please do not forget to Cc:
> Jingyu Li <joey.li@spacemit.com>
> I only provided T100 specific support in the posted series, and the
> new approach of the HPM driver in the same series is composed by her.
> 
>>
>> Yaxing has agreed to pause his series, as discussed here:
>> https://lore.kernel.org/linux-iommu/2ce9d8be-10b3-48dd- 
>> b99e-7358347fc171@bosc.ac.cn/
>>
>> The motivation for sending this v2 version is not only to address the
>> feedback and suggestions from the previous round, but also to introduce
>> a major structural change: the PMU driver has been moved under
>> drivers/perf/, which has been mentioned repeatedly by several people.
>> This results in a different driver structure compared to my earlier
>> version and the other two series, and I'd like to gather feedback and
>> suggestions from the community on this approach. If the community would
>> prefer to go with Lv Zheng’s version instead, I am perfectly fine with
>> that as well.
> 
> We'd like to know if there's any comments related to putting IOMMU HPM
> driver into drivers/perf folder and want to know if this is necessary.
> We also hesitated if riscv iommu hpm should be put into drivers/perf,
> and according to the followings, we finally decided to keep it in
> drivers/iommu:
> 1. drivers/iommu has already a folder maintaining all IOMMU stuffs.
> 2. drivers/iommu has already defined HPM related registers.
> 3. Unlike PMCG of SMMU which is located in a separate namespace, RISC-V
>     IOMMU only defines 5 registers in the same address space as its
>     translation schemes.
> 4. For HPM schemes that is not a standalone device, Intel has put its
>     perf driver under drivers/iommu/intel/perfmon.c.
> 

When I previously submitted my RISC-V IOMMU PMU series, Will（Will 
Deacon<will@kernel.org>） suggested placing the RISC-V IOMMU PMU driver 
under drivers/perf/, similar to the ARM implementation. He also 
commented: "I'm sure Robin had fun dealing with shared MMIO regions 
before" — referring to the discussion here:
  https://patchwork.kernel.org/project/linux-riscv/patch/20250915020911.1313-1-guoyaxing@bosc.ac.cn/

> Cheers,
> Lv
> 

Best regards,
Guo Yaxing
