Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403DB310762;
	Wed, 11 Mar 2026 03:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773199512; cv=none; b=ek7DBpc/sWKPdDPpTHnlROIFfQ3IWkJvW5Y+mm811a2WrGsAS13fA8duLetGK5teqCrTTqwlNOF4yXOUBQxPRogvb0rz4XkLnUPMJotwd5iRs/cxFj9b+zkmRhjRB16buDWh5PdI2DFn49IghBFWv14zTpqgcojyswQnrjBk3nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773199512; c=relaxed/simple;
	bh=l92UFFL3132/U4z+IRGClEeMEBFXatn7a5IGJyNJHT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xijf1P3/Q7lUp4BJSrTmY1uKgVb0rXVzxR04P+n4wzdN2KPIyq9S2Zcgh443zv2ET36HZzwz5C/9rBtNfT4RYTDLPpfMaotpqqc21yI4Ux2824nfaG1EkuYD+q55jwI0HJ6e8cgRQTqVQ2Fi8y81akhfhiUZOsJwVlrRAmXnfvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kA69dqMW; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kA69dqMW"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773199504; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=cUS2q8BCeNjoSUbHg8j9ryi3lHTPQy+l2aV9CzSGmq4=;
	b=kA69dqMWbFc1yiEzy/c8PH1q+di7MKKdNaQdFCYtxWekXaGyvwc4x2tFkTRHTF6CtfYRmRuQ/wpakeTT9oEI8C6c0NAbt2tSVa4liUM9Ieb/TTGI5AVUCs4ssyAyq9W9zWxnS5AbG9WbRmAM2TpiGCzgwPFU1icy9tJdZwfNCXc=
Received: from 30.74.145.199(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0X-iHa6Q_1773199501 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Mar 2026 11:25:02 +0800
Message-ID: <d4e4e2b1-c182-42f9-9d60-b12f0fd7f977@linux.alibaba.com>
Date: Wed, 11 Mar 2026 11:25:00 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/16] Support Armv8 RAS Extensions for Kernel-first
 error handling
To: Umang Chheda <umang.chheda@oss.qualcomm.com>, catalin.marinas@arm.com,
 will@kernel.org, lpieralisi@kernel.org, guohanjun@huawei.com,
 sudeep.holla@arm.com, rafael@kernel.org, robin.murphy@arm.com,
 mark.rutland@arm.com, tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de,
 peterz@infradead.org
Cc: lenb@kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-edac@vger.kernel.org,
 mchehab@kernel.org, xueshuai@linux.alibaba.com, zhuo.song@linux.alibaba.com,
 oliver.yang@linux.alibaba.com
References: <20260122094656.73399-1-tianruidong@linux.alibaba.com>
 <edf7e7eb-8f02-4672-bc31-16e0a8fb9715@oss.qualcomm.com>
From: Ruidong Tian <tianruidong@linux.alibaba.com>
In-Reply-To: <edf7e7eb-8f02-4672-bc31-16e0a8fb9715@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/3/9 21:28, Umang Chheda 写道:
> Hello Ruidong Tain,
> 
> On 1/22/2026 3:16 PM, Ruidong Tian wrote:
>> Motivation: Reliability in Modern Data Centers
>> =================================================
>> In modern data centers, proactive maintenance is essential for achieving high
>> service availability. The practice of using Corrected Errors (CE) to predict
>> impending Uncorrected Errors (UE) is already widely deployed at scale across
>> the industry, like Alibaba[2], Tencent[4], Intel[1], AMD[2]. By analyzing CE
>> telemetry, operators can identify failing hardware and perform migrations
>> before catastrophic failures occur.
>>
>> Problem: Inefficient CE Collection on ARM
>> ==========================================
>> Currently, ARM-based systems primarily rely on "Firmware-First" error
>> handling (e.g., via GHES). This path is inherently heavy-weight. To avoid
>> significant performance overhead, firmware is often configured with high
>> thresholds—reporting to the OS only after thousands of CEs have occurred.
>> If the threshold is set lower, the high frequency of errors leads to
>> excessive and costly context switching between the OS and firmware.
>> Consequently, ARM platforms currently lack an efficient mechanism to collect
>> the granular CE data required for high-fidelity error prediction.
>>
>> Solution: Kernel-First Handling via AEST
>> ===========================================
>> Other architectures have long utilized "Kernel-First" approaches for
>> efficient CE collection: Intel provides CMCI (Corrected Machine Check
>> Interrupt), and AMD has recently introduced similar CE interrupt support[5].
>>
>> On the ARM architecture, hardware already provides the necessary RAS
>> Extensions[6], and the ACPI AEST specification[0] defines a standardized way for
>> the OS to discover these error source registers. This series implements
>> AEST support, enabling the kernel to:
>>
>>   - Discover error sources directly via ACPI tables.
>>   - Handle CE notifications via direct interrupts.
>>   - Bypass firmware overhead to collect every CE or use low-latency thresholds.
>>
>> This implementation provides the missing link for efficient RAS telemetry
>> on ARM, bringing it to parity with other enterprise architectures.
> 
> Thanks for posting this series enabling kernel-first handling for the Armv8 RAS extensions.
> 
> We noticed the current implementation targets ACPI-based server platforms. For embedded/SoC systems, Device Tree is often the primary firmware description.
> Do you have any plans to add DT-based support for the same flow? If not, do you see any blockers to extending this series to support DT
> (e.g., DT bindings + discovery/registration path analogous to the ACPI plumbing) ?
> If DT support is in-scope, We would be happy to align on the expected approach and help with review/development/testing for DT-based platforms.

Hi Umang,

Thanks for the reply.

Adding Device Tree support should be easy. We just need a patch similar 
to "ACPI/AEST: Parse the AEST table" to fill the DT table into struct 
acpi_aest_node (might need renaming) and struct aest_hnode. The driver 
part requires minimal changes.

However, I'm not very familiar with DT and lack DT engineering support, 
so I would need some guidance on these DT-related questions:

- Is there a specification that outlines the reporting 	requirements for 
RAS extension information that is similar to AEST?
- How should the DT be designed?
- How can I develop QEMU and modify DT files for debugging, etc.?

I would be happy to adjust the patchset to meet the needs of both 
parties if you are prepared to invest the necessary effort（DT-related）. 
In reality, I believe that just a little modification is required.

> 
>> Background and Maintenance
>> =============================
>> This series is based on Tyler Baicar's preliminary patches [7]. I attempted
>> to follow up with Tyler in 2022 [8] but received no reply. As he no longer
>> appears active on the mailing list, I have picked up this work, updated it
>> to align with the latest AEST v2.0 specification, and addressed pending
>> feedback to ensure this critical feature is integrated into the mainline.
>>
>> AEST Driver Architecture
>> ========================
>>
>> The AEST driver is structured into three primary components:
>>    - AEST device: Responsible for handling interrupts, managing the lifecycle
>>                   of AEST nodes, and processing error records.
>>    - AEST node: Corresponds directly to a RAS node in the hardware
>>    - AEST record: Represents a set of RAS registers associated with a specific
>>                   error source.
>>
>> Comparison with x86 MCA:
>>
>> RAS record ≈ MCA bank.
>> RAS node ≈ A set of MCA banks + CMCI on a core.
>>
>> The key difference lies in uncore handling: x86 typically maps uncore errors
>> (like those from a memory controller) into core-based MCA banks. In contrast,
>> ARM requires uncore components to provide their own standalone RAS nodes. When
>> a component requires multiple such nodes, they are grouped and managed as a
>> "RAS device" in AEST driver.
>>
>> These components are organized hierarchically as follows:
>>
>>   ┌──────────────────────────────────────────────────┐
>>   │             AEST Driver Device Management        │
>>   │┌─────────────┐    ┌──────────┐     ┌───────────┐ │
>>   ││ AEST Device ├─┬─►│AEST Node ├──┬─►│AEST Record│ │
>>   │└─────────────┘ │  └──────────┘  │  └───────────┘ │
>>   │                │       .        │  ┌───────────┐ │
>>   │                │       .        ├─►│AEST Record│ │
>>   │                │       .        │  └───────────┘ │
>>   │                │  ┌──────────┐  │        .       │
>>   │                ├─►│AEST Node │  │        .       │
>>   │                │  └──────────┘  │        .       │
>>   │                │                │  ┌───────────┐ │
>>   │                │  ┌──────────┐  └─►│AEST Record│ │
>>   │                └─►│AEST Node │     └───────────┘ │
>>   │                   └──────────┘                   │
>>   └──────────────────────────────────────────────────┘
>>
>> AEST Interrupt Handle
>> =====================
>>
>> Upon an AEST interrupt, the driver performs the following sequence:
>> 1. The AEST device iterates through all registered AEST nodes to identify the
>>     specific node(s) and record(s) that reported an error.
>> 2. Each node typically contains two types of records:
>>        - report record: Errors can be located efficiently through a bitmap
>>                         in the `ERRGSR` register.
>>        - poll record: The node must individually poll all records to determine
>>                       if an error has occurred.
>> 3. process record:
>>        - if error is corrected, The CE threshold is reset, and the error event
>>          is logged.
>>        - if error is defered, Relevant registers are dumped, and
>>          `memory_failure()` is invoked.
>>        - if error is uncorrected, panic, While UEs typically trigger an
>>          exception rather than an interrupt, if detected, the system will panic.
>> 4. decode record: The AEST driver notifies other relevant drivers, such as
>>     EDAC, to further decode the reported RAS register information.
>>
>> Testing
>> ===================
>> I have tested this series on THead Yitian710 SOC with customized BIOS. Someone
>> can also use QEMU[9] for preliminary driver testing.
>>
>> 1. Boot Qemu
>>
>> qemu-system-aarch64 -smp 4 -m 32G \
>>    -cpu host --enable-kvm -machine virt,gic-version=3 \
>>    -kernel Image -initrd initrd.cpio.gz \
>>    -device virtio-net-pci,netdev=t0 -netdev user,id=t0 \
>>    -bios /usr/share/edk2/aarch64/QEMU_EFI.fd  \
>>    -append "rdinit=/sbin/init earlycon verbose debug console=ttyAMA0 aest.dyndbg='+pt'" \
>>    -nographic -d guest_errors -D qemu.log
>>
>> 2. inject error
>> devmem 0x90d0808 l 0xc4800390
>>
>> 2.1 Memory error
>> [   64.959849] AEST: {1}[Hardware Error]: Hardware error from AEST memory.90d0000
>> [   64.959852] AEST: {1}[Hardware Error]:  Error from memory at SRAT proximity domain 0x0
>> [   64.959855] AEST: {1}[Hardware Error]:   ERR0FR: 0x40000080044081
>> [   64.959858] AEST: {1}[Hardware Error]:   ERR0CTRL: 0x108
>> [   64.959859] AEST: {1}[Hardware Error]:   ERR0STATUS: 0xc4800390
>> [   64.959860] AEST: {1}[Hardware Error]:   ERR0ADDR: 0x8400000043344521
>> [   64.959861] AEST: {1}[Hardware Error]:   ERR0MISC0: 0x7fff00000000
>> [   64.959861] AEST: {1}[Hardware Error]:   ERR0MISC1: 0x0
>> [   64.959862] AEST: {1}[Hardware Error]:   ERR0MISC2: 0x0
>> [   64.959863] AEST: {1}[Hardware Error]:   ERR0MISC3: 0x0
>> [   64.959873] Memory failure: 0x43344: recovery action for free buddy page: Recovered
>>
>> 2.2 CMN error
>> [  132.044283] AEST: {2}[Hardware Error]: Hardware error from AEST XP
>> [  132.044286] AEST: {2}[Hardware Error]:  Error from vendor hid ARMHC700 uid 0x0
>> [  132.044288] AEST: {2}[Hardware Error]:   ERR0FR: 0x48a5
>> [  132.044290] AEST: {2}[Hardware Error]:   ERR0CTRL: 0x108
>> [  132.044292] AEST: {2}[Hardware Error]:   ERR0STATUS: 0xc4800390
>> [  132.044293] AEST: {2}[Hardware Error]:   ERR0ADDR: 0x8400000043344521
>> [  132.044295] AEST: {2}[Hardware Error]:   ERR0MISC0: 0x0
>> [  132.044296] AEST: {2}[Hardware Error]:   ERR0MISC1: 0x0
>> [  132.044298] AEST: {2}[Hardware Error]:   ERR0MISC2: 0x0
>> [  132.044299] AEST: {2}[Hardware Error]:   ERR0MISC3: 0x0
>> [  132.044302] Memory failure: 0x43344: recovery action for already poisoned page: Failed
>>
>> [0]: https://developer.arm.com/documentation/den0085/0200/
>> [1]: Intel: Predicting Uncorrectable Memory Errors from the Correctable Error History
>> [2]: Alibaba. Predicting DRAM-Caused Risky VMs in Large-Scale Clouds. Published in HPCA2025
>> [3]: AMD: Physics-informed machinelearning for dram error modeling
>> [4]: Tencent: Predicting uncorrectablememory errors for proactive replacement: An empirical study on large-scale field data
>> [5]: https://lore.kernel.org/all/20251104-wip-mca-updates-v8-4-66c8eacf67b9@amd.com/
>> [6]: https://developer.arm.com/documentation/ihi0100/
>> [7]: https://lore.kernel.org/all/20211124170708.3874-1-baicar@os.amperecomputing.com/
>> [8]: https://lore.kernel.org/all/b365db02-b28c-1b22-2e87-c011cef848e2@linux.alibaba.com/
>> [9]: https://github.com/winterddd/qemu/tree/error_record
>>
>> Change from V5:
>> https://lore.kernel.org/all/20251230090945.43969-1-tianruidong@linux.alibaba.com/
>> 1. Based on the feedback from Borislav Petkov, I've dropped the idea of a
>>     unified address translation interface across ARM and AMD.
>>
>> Change from V4:
>> https://lore.kernel.org/all/20251222094351.38792-1-tianruidong@linux.alibaba.com/
>> 1. Fix build warning in 0010 and 0014 report by kernel test robot:
>>      https://lore.kernel.org/all/202512230122.CfXZcF76-lkp@intel.com/
>>      https://lore.kernel.org/all/202512230007.Vs6IvFVD-lkp@intel.com/
>> 2. Dropped the extra patch(0014) that was mistakenly included in v4.
>>
>> Change from V3:
>> https://lore.kernel.org/all/20250115084228.107573-1-tianruidong@linux.alibaba.com/
>> 1. Add vendor AEST node framework and support CMN700
>> 2. Borislav Petkov
>>      - Split into multiple smaller patches for easier review.
>>      - refined the English in the cover letter for better flow.
>> 3. Accept Tomohiro Misono's comment
>>
>> Change from V2:
>> https://lore.kernel.org/all/20240321025317.114621-1-tianruidong@linux.alibaba.com/
>> 1. Tomohiro Misono
>>      - dump register before panic
>> 2. Baolin Wang & Shuai Xue: accept all comment.
>> 3. Support AEST V2.
>>
>> Change from V1:
>> https://lore.kernel.org/all/20240304111517.33001-1-tianruidong@linux.alibaba.com/
>> 1. Marc Zyngier
>>    - Use readq/writeq_relaxed instead of readq/writeq for MMIO address.
>>    - Add sync for system register operation.
>>    - Use irq_is_percpu_devid() helper to identify a per-CPU interrupt.
>>    - Other fix.
>> 2. Set RAS CE threshold in AEST driver.
>> 3. Enable RAS interrupt explicitly in driver.
>> 4. UER and UEO trigger memory_failure other than panic.
>>
>> Ruidong Tian (16):
>>    ACPI/AEST: Parse the AEST table
>>    ras: AEST: Add probe/remove for AEST driver
>>    ras: AEST: support different group format
>>    ras: AEST: Unify the read/write interface for system and MMIO register
>>    ras: AEST: Probe RAS system architecture version
>>    ras: AEST: Support RAS Common Fault Injection Model Extension
>>    ras: AEST: Support CE threshold of error record
>>    ras: AEST: Enable and register IRQs
>>    ras: AEST: Add cpuhp callback
>>    ras: AEST: Introduce AEST driver sysfs interface
>>    ras: AEST: Add error count tracking and debugfs interface
>>    ras: AEST: Allow configuring CE threshold via debugfs
>>    ras: AEST: Introduce AEST inject interface to test AEST driver
>>    ras: AEST: Add framework to process AEST vendor node
>>    ras: AEST: support vendor node CMN700
>>    trace, ras: add ARM RAS extension trace event
>>
>>   Documentation/ABI/testing/debugfs-aest |   99 +++
>>   MAINTAINERS                            |   11 +
>>   arch/arm64/include/asm/arm-cmn.h       |   47 ++
>>   arch/arm64/include/asm/ras.h           |   95 +++
>>   drivers/acpi/arm64/Kconfig             |   11 +
>>   drivers/acpi/arm64/Makefile            |    1 +
>>   drivers/acpi/arm64/aest.c              |  311 +++++++
>>   drivers/perf/arm-cmn.c                 |   37 +-
>>   drivers/ras/Kconfig                    |    1 +
>>   drivers/ras/Makefile                   |    1 +
>>   drivers/ras/aest/Kconfig               |   17 +
>>   drivers/ras/aest/Makefile              |    8 +
>>   drivers/ras/aest/aest-cmn.c            |  330 ++++++++
>>   drivers/ras/aest/aest-core.c           | 1054 ++++++++++++++++++++++++
>>   drivers/ras/aest/aest-inject.c         |  131 +++
>>   drivers/ras/aest/aest-sysfs.c          |  228 +++++
>>   drivers/ras/aest/aest.h                |  410 +++++++++
>>   drivers/ras/ras.c                      |    3 +
>>   include/linux/acpi_aest.h              |   75 ++
>>   include/linux/cpuhotplug.h             |    1 +
>>   include/linux/ras.h                    |    8 +
>>   include/ras/ras_event.h                |   71 ++
>>   22 files changed, 2914 insertions(+), 36 deletions(-)
>>   create mode 100644 Documentation/ABI/testing/debugfs-aest
>>   create mode 100644 arch/arm64/include/asm/arm-cmn.h
>>   create mode 100644 arch/arm64/include/asm/ras.h
>>   create mode 100644 drivers/acpi/arm64/aest.c
>>   create mode 100644 drivers/ras/aest/Kconfig
>>   create mode 100644 drivers/ras/aest/Makefile
>>   create mode 100644 drivers/ras/aest/aest-cmn.c
>>   create mode 100644 drivers/ras/aest/aest-core.c
>>   create mode 100644 drivers/ras/aest/aest-inject.c
>>   create mode 100644 drivers/ras/aest/aest-sysfs.c
>>   create mode 100644 drivers/ras/aest/aest.h
>>   create mode 100644 include/linux/acpi_aest.h
> 
> 
> Thanks,
> Umang

