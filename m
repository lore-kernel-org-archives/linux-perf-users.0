Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E432C22B8C5;
	Sun,  1 Mar 2026 03:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772336299; cv=none; b=S5mpUTW6ukxYNfxi9JGJvRxCQgYqoOkLgTC4ZFWJTi3lvkL5qkgCBl9arFyZthn4HB24F0r1UaN+/dS4cH4mgfv4GX1yQY594uvEPIOR8TqxhGTDZnLvIJFelzYoAO67BMNqPmoxoTv7ZebTsmx6vQofLR5c2+wBKo+ifgbJxeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772336299; c=relaxed/simple;
	bh=SHy29JPkh6Jk/RKo5Xwvo+I9TaUc55+18u7qsHa6RxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fRvkoWT6PyvRGKrgT48aZPkHV9hLf0IuZeqj8dmKENbLbImbzS5yol5Gm6ibE6MPISiUW0bp6heIqrqyBWsTxxndioOSInQyqJWBwo06Tdt8TffFtjWPQpOqDe6uRbOad/wrJgWOWDK+HwFrZSjoamZmBPKvNC/yjvd1OtNtIXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=HlTO+ZT0; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="HlTO+ZT0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1772336216;
	bh=93bEyT0SgKuHSUBfoO+JuFAq21jz6A4cY+cr3kV1B6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=HlTO+ZT0vK7CSzF9WBoSjNO/6b+n4A+R8FQPYNYxkR7W49Gz4H0Io3MQEPlh3LbaL
	 Zh1lwAE8OGrCZX36x9SVA1ckZxiz/Yps5CKMbCuLhflzwFbaO/EPgDLgTI0pAWeXA5
	 9eAMshikM3R7ZmsR+1W5lJMX6jOU8PqMiQgyAQVk=
X-QQ-mid: zesmtpip3t1772336214tf6eab40c
X-QQ-Originating-IP: k0JdBZhJPRmuZKjGjPZ37KlU9JtX6/5v8zLy7iBTKUY=
Received: from [IPV6:2409:8a1e:2ff0:1c00:c54c: ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 01 Mar 2026 11:36:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13472000946799448169
Message-ID: <F8F0DAEEC7ACEE93+7312b53a-61b9-44f1-8a4f-958064939da2@linux.spacemit.com>
Date: Sun, 1 Mar 2026 11:36:46 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] iommu/riscv: Add HPM support for RISC-V IOMMU
To: Zong Li <zong.li@sifive.com>
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Yixun Lan <dlan@kernel.org>,
 Jingyu Li <joey.li@spacemit.com>, Yaxing Guo <guoyaxing@bosc.ac.cn>,
 Zhijian Chen <zhijian@spacemit.com>, iommu@lists.linux.dev,
 linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Samuel Holland <samuel.holland@sifive.com>
References: <0CA1C3965143B3A7+cover.1772289741.git.lv.zheng@linux.spacemit.com>
 <CANXhq0o6JELxZETcfdsr2i6Xp6SCbwAxnMdfjXkyGRi2EeWsNA@mail.gmail.com>
Content-Language: en-US
From: Lv Zheng <lv.zheng@linux.spacemit.com>
In-Reply-To: <CANXhq0o6JELxZETcfdsr2i6Xp6SCbwAxnMdfjXkyGRi2EeWsNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NU6kbiH0KIWhY0ZJh0k9ET7YyZlTF6mwiWoDBGGkbWLnPEnLKDdk948q
	+5TLdX657EGaY6Erz8ZgZixypdZob97eUdChiYFhVTxqykZ33eBZ8nnsaJsUqFaqum2WQFY
	uiFZeGPfm5wKVdlZnSA+QE/fY5KlbCwQzODyxC3YA/INpR/+5+n5epFGEjINU54GuE0Pk4o
	PJyFzC7kRK/HXQ3bJwA+fbTgM8VIRVRq3ml+PIG2xKXTMO/8qhzCdqZyzmWNYlSPQu7BF34
	Z8BytXHy5OpFx65x2XCFvOT/bQ7xIMbduiR205Z8j0kJO5KIaaMg3vbId/0iJN+g027ANOQ
	guK+V3UukGdj9GA5qSxXZytd9nTNhMWQekXloZwOooLuUIk/XQOV+UW9Fm+IrF8eXQKBR16
	oh9dGxZMrM6+6rSdtaq/3Q902FFucVHwFaAgIvk/qnWktW4oG7sor69erx5cKODwbTbeJ20
	2Wuwx+sCNZMUle5HE8Bx+v0QGSLlWMNFp3BpHt3unDR4f2864QxnJf3s9lmzldxbRojoaCT
	T////0B8K15VfejBlB2hS/NHpRH/y12T8tWqwTuXwWD/rLG0hcYJybHVmtTLN/1+xy/lleo
	p4QQL2m8CJM5uCocqMnck2EtrjglPlILM1XjRvGE6DMkE2Qf6ulD6nfEJepdRRO7rltTuBC
	Jy13PmzmjhIiVJoUXVQUg42PfhL95657ASlW4qXo4GEAoGPdfJrmY0S2VI3Ti0JpaJ/mP0c
	dGBjNEDLc5BdDeVc18Af5rI7PROaNsoBorbVr9FRyCRiHPSQDL2VDKqFybfinZDl/PrFLIX
	rNupaHZcJOxQSoYnUneISA9QquT3SlY1ICIh6d+PKYZvHidWLs8h4Uu6Ob74y+XYtJhL684
	JBhMR4ynV8l8dsTQIeIY9NQAWjK1ckhKpeeUip7tGHdvdM6MIOFeeenJwZ7IUpA2or1vTJc
	6vdH+XKnty/l4N/NJ+T0HOt/9GUTNTVfQpjanzvE18PRcGljbNvTQD9v6eWl+CusMyuFu7j
	qw0y6z1BFhbxIvOrX+d4KCio6mcKvOxj9vGz/mQrcF2N/Fjsua6RKO5yf644rByLdwYjtcd
	h6+pI7m1Pk6
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

On 3/1/2026 9:58 AM, Zong Li wrote:
> On Sat, Feb 28, 2026 at 10:44 PM Lv Zheng <lv.zheng@linux.spacemit.com> wrote:
>>
>> Includes HPM support for RISC-V IOMMU. The HPM hardware mechanism can be
>> found in the recent announced SpacemiT SoCs (K3, V100), where T100
>> (SpacemiT distributed IOMMU) is shipped.
>>
>> The RISC-V IOMMU specification defines optional HPM registers (IOHPMEVT,
>> IOHPMCTR, etc.) for performance monitoring of transactions through the
>> IOMMU. SpacemiT T100 implements this specification with a distributed
>> architecture: the main IOMMU (IOATS) is complemented by up to 64 IOATC
>> units that cache IOTLBs adjacent to DMA masters. Each IOATC has its own
>> HPM counters and PMIV interrupt.
>>
>> This series introduces an auxiliary bus framework to allow the HPM
>> functionality to be implemented as a separate perf driver, keeping the
>> IOMMU core focused on translation. Vendor-specific extensions (SpacemiT
>> T100) are layered on top of the generic HPM infrastructure.
>>
>> History:
>> The first revision of this series is posted without the awareness of
>> other on-going discussions. There are other postings providing same
>> functionality as [PATCH 2-3] in this thread:
>> 1. Zong Li:
>>     https://lore.kernel.org/all/20250115030306.29735-1-zong.li@sifive.com/
>>     We aligned with Zong in the community here:
>>     https://lore.kernel.org/all/CANXhq0q8N5eHx9ytabZR97Y7AULKwgS2-uEGhcaOOGp9mvbtRQ@mail.gmail.com/
>>     >> Perhaps I can first post my next revision to the mailing list (hope
>>     >> it won't waste the community resource), so that you could have a
>>     >> chance to review it and see whether that version is architecturally
>>     >> closer to what the community is looking for, while also addressing
>>     >> your issue. If you also feel that my next revision meets your needs,
>>     >> perhaps you could append your additional implementations on top of
>>     >> it.
>>     >> Of course, if the community would prefer to go your version, I'm
>>     >> perfectly fine with that as well.
>>     His newest version can be found here:
>>     https://lore.kernel.org/all/20260208063848.3547817-1-zong.li@sifive.com/
> 
> I don’t think this v5 series is appropriate. In the beginning, you
> posted a similar implementation without sufficient discussion, but it
> might be ok because as you mentioned, you did so because you were not
> aware at the time. However, in this v5 series, you have again included
> our implementation concept without prior discussion or agreement
> (i.e., separates the IOMMU PMU driver into drivers/perf/ through the
> auxiliary framework). This may not fully align with the long-standing
> open-source collaboration model in the Linux community, In addition,
> our v2 series is still waiting for feedback and responses from the
> community. I believe it may not be appropriate to directly take our
> implementation and include it in your series.
> https://lists.infradead.org/pipermail/linux-riscv/2026-February/085349.html

I just followed the following comment and got the original Will's 
suggestion:
https://lore.kernel.org/all/1e2b448f-3a2a-4b1f-872d-a34f7bd53696@bosc.ac.cn/
It looks to me like a community idea.
And we need a framework to dynamically "enumerate" devices rather than a 
simple modulized approach.

> If you would like to build on top of our implementation and add your
> own changes, I think a better approach would be to first communicate
> with us, and then at least cherry-pick our implementation as the
> initial patches (i.e., patch 1 and patch 2). After that, you could
> place your own changes starting from the third patch.

Let's just focus on the technical discussion and let the community do 
the final decission.
Did you see any problem in the Cced patches? We can change that Cc to 
any other SOB keywords if you wish to.

Best regards
Lv

> 
> 
>> 2. Yaxing Guo:
>>     https://lore.kernel.org/all/20250915020911.1313-1-guoyaxing@bosc.ac.cn/
>>     Yaxing and Zong aligned each other in the community here:
>>     https://lore.kernel.org/linux-iommu/2ce9d8be-10b3-48dd-b99e-7358347fc171@bosc.ac.cn/
>>     >> Hi Zong Li,
>>     >> Of course yes, absolutely - I wasn't aware of your earlier
>>     >> submission. Please go ahead with your version.
>> This is the newest revision of this patchset, and [PATCH 2-3] is the one
>> that is competing with other contributions.
>>
>> Revisions:
>> v1
>>   Initial release.
>> v2 (sent as v1.1)
>>   Split and cleanup DT-bindings.
>> v3
>>   1. Refactor using vendor specific compatible.
>>   2. Implement vendor events with a userspace identifier.
>> v4
>>   1. Drop ICVEC check which is not that usful as WSI device tree can use
>>      only 1 vector for IOATS CIV/FIV/PIV/PMIV.
>>   2. Solve DT binding check of "interrupts/maxItems" attribute.
>>   3. Address Robin's comments for an old revision sent by "Zong Li".
>>   4. Limit IOATC enumeration by referencing spacemit,riscv-iommu.
>> v5:
>>   1. Use correct style SoC/IP specific compatible.
>>   2. Address all on-going comments in other threads.
>>   3. Split compatible into SoC specific and IP specific.
>>   4. Switch to use auxiliary device framework.
>>
>> The tested result can be found as follows:
>>
>>   root@sdfirm:# perf stat --timeout 5000 -a -e spacemit_ioats_hpm_0/dd_walk,config1=0x20c0010000000000/ dmatest; sleep 1
>>   [  453.426404] dmatest: Started 1 threads using dma0chan0
>>   [  453.437152] dmatest: dma0chan0-copy0: summary 1 tests, 0 failures 212.04 iops 212 KB/s (0)
>>
>>    Performance counter stats for 'system wide':
>>
>>                    3      spacemit_ioats_hpm_0/dd_walk,config1=0x20c0010000000000/
>>
>>          0.190412000 seconds time elapsed
>>
>>   root@sdfirm:~# perf stat --timeout 5000 -a -e spacemit_ioatc_hpm_1/tlb_mis,config1=0x20c0010000000000/ dmatest; sleep 1
>>   [  117.599620] dmatest: Started 1 threads using dma0chan0
>>   [  117.610698] dmatest: dma0chan0-copy0: summary 1 tests, 0 failures 186.07 iops 186 KB/s (0)
>>
>>    Performance counter stats for 'system wide':
>>
>>                    7      spacemit_ioatc_hpm_1/tlb_mis,config1=0x20c0010000000000/
>>
>>          0.196982000 seconds time elapsed
>>
>> Jingyu Li (3):
>>    iommu/riscv: Enable IOMMU DMA mapping support
>>    iommu/riscv: Add auxiliary bus framework and HPM device support
>>    iommu/riscv: Add HPM support for performance monitoring
>>
>> Lv Zheng (5):
>>    dt-bindings: iommu: Add spacemit/t100 features
>>    spacemit/t100: Add global filter awareness for RISC-V IOMMU HPM
>>    iommu/riscv: Add SpacemiT T100 IOATC HPM support
>>    iommu/riscv: Add vendor event support for RISC-V IOMMU HPM
>>    perf vendor events riscv: Add SpacemiT T100 HPM event aliases
>>
>>   .../bindings/iommu/riscv,iommu.yaml           |   58 +-
>>   MAINTAINERS                                   |    5 +
>>   drivers/iommu/Kconfig                         |    2 +-
>>   drivers/iommu/riscv/Kconfig                   |    1 +
>>   drivers/iommu/riscv/iommu-bits.h              |   12 +
>>   drivers/iommu/riscv/iommu-pci.c               |    8 +-
>>   drivers/iommu/riscv/iommu-platform.c          |    7 +-
>>   drivers/iommu/riscv/iommu.c                   |  306 +++++
>>   drivers/iommu/riscv/iommu.h                   |   25 +-
>>   drivers/perf/Kconfig                          |    9 +
>>   drivers/perf/Makefile                         |    1 +
>>   drivers/perf/riscv_iommu_hpm.c                | 1012 +++++++++++++++++
>>   include/linux/riscv_iommu.h                   |   83 ++
>>   .../arch/riscv/spacemit/iommu/sys/ioatc.json  |   30 +
>>   .../arch/riscv/spacemit/iommu/sys/ioats.json  |  163 +++
>>   15 files changed, 1715 insertions(+), 7 deletions(-)
>>   create mode 100644 drivers/perf/riscv_iommu_hpm.c
>>   create mode 100644 include/linux/riscv_iommu.h
>>   create mode 100644 tools/perf/pmu-events/arch/riscv/spacemit/iommu/sys/ioatc.json
>>   create mode 100644 tools/perf/pmu-events/arch/riscv/spacemit/iommu/sys/ioats.json
>>
>> --
>> 2.43.0
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

