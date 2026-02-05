Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BEA34D38D;
	Thu,  5 Feb 2026 06:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770271971; cv=none; b=hv0VVV9O3BO4YJH/o2XmXdFrOxjrexaYxJ62jAhotlVw716E9vrFIthgAanuJyIFQWCGQH8yvluuaha/I0XuQq4VuPwP2bLggSEU7pbILWvdThjpiIt7J1NQ2OmK3PcTipRDZTnJCud0iSdA72MzY6alIZ80HlZC9CP4RZx9+ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770271971; c=relaxed/simple;
	bh=uZpneSQWAnsGaiDthCUuC/HDbbKtK6rBmlvSADRD3Z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JYJRj3LixA07Yz0413WtBNCgliy0Kf5Y9t4BKvtYOMqVJRpsHQ4Frxb9FNb5s9DG68FujPON8ViGij56SsGRKskrvadW/phbXFKbq+yCkeCnZq2nZLD/BXsOqEitFZ/01wWhnq7f9WzFjsGwmCjyXyvWY5Iz2o9i41MVWnAoFTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=xUGscN53; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="xUGscN53"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1770271914;
	bh=tDgt6vZpYx+8Gxn4WiLvnLAeS2beozPCKmdyy780RYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=xUGscN53mHEDl3yC3r+TmbaLbq0Wz/U52w7ruz0VsD5ArhG8XFRk88CWhXKbsabsr
	 qKkAQAJXr7YqIJJvw/IB1VCV08hat8gvsJZGvnXFSccsnPiwV/C7z8ZOTmtuO/Vbr3
	 WkFY8vsjCoD4JTfg06xuJocwhNGpE/DMOTrss7t0=
X-QQ-mid: zesmtpsz3t1770271912t7844f74a
X-QQ-Originating-IP: sH+CVXzMSrAXjiTiHvm7S7Z4jmFxT90oqobPcqXkkTs=
Received: from [10.3.91.191] ( [101.70.125.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 05 Feb 2026 14:11:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6470129798004699414
Message-ID: <6C65A3873186B07C+29da5dbd-ed27-4ace-a5ca-355b3983d60c@linux.spacemit.com>
Date: Thu, 5 Feb 2026 14:11:48 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] iommu/riscv: Add HPM support for performance
 monitoring
To: Zong Li <zong.li@sifive.com>
Cc: Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
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
 <9C0A2AD4850D179B+524146e74e808db90d5f28fcb6ee791cf1d1bfaa.1770195980.git.lv.zheng@linux.spacemit.com>
 <p74snip7yykhogvzqld4gyjlygmd2z4kqnat7w3qj63fwebnmm@dlz6tloevgbs>
 <4D87481E9AABE2C6+72d18f72-9407-4d68-8195-edc6c171df14@linux.spacemit.com>
 <CANXhq0q8N5eHx9ytabZR97Y7AULKwgS2-uEGhcaOOGp9mvbtRQ@mail.gmail.com>
Content-Language: en-US
From: Lv Zheng <lv.zheng@linux.spacemit.com>
In-Reply-To: <CANXhq0q8N5eHx9ytabZR97Y7AULKwgS2-uEGhcaOOGp9mvbtRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MTI/6z+04aqCmKtOooE8Ec8p6bzHjOcrb9ijGprdxfZjLV+1DnWF1w6F
	KgSdvHq29w6GBLYtahni+uA0YOQl1KnLM5xYcU7YPiUANN782jlv+Fawbw/Y/eV1lq20GHH
	paJ/jE2nX/3tfa1R6XUTleXCK1sF8LERhvx0B+lTrEjzHhBF9kQoRxfgcL8+etiP0UcOYSX
	l8N0s9qU/WI5vQb5PlWc4nFT8wht06g9hvYN2C3QivJSBTRdj7ouISlvnvRI9rYmjvl7lX1
	FwfoxUeNSKouIHNvjexGVQJO+jmOXgTCU5MVD5G17AbbB3/9tFS1LP6WiXhsz4XuDWoz9cI
	/pk0m4ivI2UkcbMRX7o6rxgUeG5Vh/vc4TsygpKU/Ypw2R/ufu5CXwvLrJtb/RatOxDeEzN
	CSFHbauT/5tU0JI0NpdFDixI/+dqZCUhVfCnRVSypgksvICptFbWp7j0WrRBdAYr3GfrH7r
	8/SbLin974hlZGtQH1rvh/hOQEsyi93hkO8fR9tHWplLzx7RLWmkkWuiTZcSK1tQXyOw7ay
	S+M9AFp7+Go49KU0/pwWOHGjhaiSp85lE5YKhbkQa5kHfigzFPC7Q6xut1lyTcF37eUQVk5
	oYKDs8vtB8qBcfL6Yti05CE4CTizojkWIYNNIsG5BV8ArDnqXO2p63RIQ6LEAuD1Cjcv7Uc
	bvedWzwtLodcxAS2Bt0e46pTZxWfYvZL8T0EicIKP4MTimCUGjJkGZ3ELZU/yFLl1nGvptE
	3lT8t2qAZGkWrFM2nGh6eeSgESZfx6CGveKJSggD5nuBBW/6RBWH/OSW6w78D2zSZsgoay4
	WC0JiAujUnGV/LksKQ+Ce7aQM9225H4KBE8Po+vrnXPOKNjHKbexFM6qKe+ONblLTgqhVqZ
	atZ0vUCljpERjslYGBHHAwfCbKTFWKzkGHHRQ83wOtzDB4Hj3E3MqXX/QLdn1vn4YylYQKP
	8FGHIK+CwnKgO5abEm68MdxIafphY2UGxGLv1B4TuHSM0of+7I3tMKJGVeMZK6VW2abGq/D
	teQc+xKj+ED3h2RyZ1P2DigPuqNZbXAa2COUuBg7v7UyzS98ZD
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

On 2/5/2026 11:47 AM, Zong Li wrote:
> On Thu, Feb 5, 2026 at 11:35 AM Lv Zheng <lv.zheng@linux.spacemit.com> wrote:
>>
>> On 2/5/2026 2:39 AM, Andrew Jones wrote:
>>> How does this relate to
>>>
>>> https://lore.kernel.org/all/20250115030306.29735-1-zong.li@sifive.com/
>>>
>>>   From a quick skim it looks like there's plenty of overlap.
>>
>> We developed the driver in 2024 and demonstrated it in China summit. We
>> didn't notice that a patch is on-going now in the community.
>>
>> Now it looks our approach solved more issues, and we'll check and update
>> if there are any community concerns still not addressed in this patchset.
>>
>> We can add Reviewed-by/Tested-by and Signed-off-by of Zong Li to this
>> patch if he wishes.
>>
>> Thanks,
>> Lv
>>
> 
> Perhaps I can first post my next revision to the mailing list (hope it
> won't waste the community resource), so that you could have a chance
> to review it and see whether that version is architecturally closer to
> what the community is looking for, while also addressing your issue.
> If you also feel that my next revision meets your needs, perhaps you
> could append your additional implementations on top of it.
>

It seems we all composed the RISC-V iommu HPM support by referencing 
drivers/perf/arm_smmuv3_pmu.

Robin's comments should all be addressed IMHO.

> Of course, if the community would prefer to go your version, I’m
> perfectly fine with that as well.

OK. If we send a next version, we will add your SOB and please help to 
review and test.

Thanks in advance,
Lv

> 
>>>
>>> Thanks,
>>> drew
>>>
>>>
>>> On Wed, Feb 04, 2026 at 05:09:01PM +0800, Lv Zheng wrote:
>>>> From: Jingyu Li <joey.li@spacemit.com>
>>>>
>>>> Introduces perf-based HPM driver for RISC-V IOMMU, enabling performance
>>>> monitoring capabilities.
>>>>
>>>> Note that the RISC-V IOMMU HPM module uses COUNTER_MAX-1 as a static
>>>> counter index of HPMCYCLES, and 0~COUNTER_MAX-2 as the dynamic counter
>>>> indexes of other HPMEVENTS in order to correctly index into IOHPMEVT and
>>>> IOHPMCTR registers that have already been defined in the iommu-bits.h.
>>>> However the users treat 0 as the index of HPMCYCLES and 1~COUNTER_MAX-1 as
>>>> the indexes of other HPMEVENTS, thus care should be taken in dealing with
>>>> counter indexes between userspace and kernel space.
>>>>
>>>> Signed-off-by: Jingyu Li <joey.li@spacemit.com>
>>>> Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
>>>> Link: https://github.com/riscv-non-isa/riscv-iommu
>>>> ---
>>>>    drivers/iommu/riscv/Kconfig          |   9 +
>>>>    drivers/iommu/riscv/Makefile         |   1 +
>>>>    drivers/iommu/riscv/iommu-bits.h     |   6 +
>>>>    drivers/iommu/riscv/iommu-hpm.c      | 843 +++++++++++++++++++++++++++
>>>>    drivers/iommu/riscv/iommu-pci.c      |  13 +-
>>>>    drivers/iommu/riscv/iommu-platform.c |   8 +-
>>>>    drivers/iommu/riscv/iommu.h          |  42 ++
>>>>    7 files changed, 919 insertions(+), 3 deletions(-)
>>>>    create mode 100644 drivers/iommu/riscv/iommu-hpm.c
>>>>
>>>
>>
> 


