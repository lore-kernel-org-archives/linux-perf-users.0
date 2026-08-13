Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE35935AC07
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786642279; cv=none; b=c4znVQA9FD3g6gvC7gYZ4P80YvXuTqr1Lgf38TJb7htwQCvU2ZLDJzjRTgz1kgVMUMDHohF78OhiEzYV+C89Sg08OjYJJV5PHgwOzlaoHlwQJF5xnv7icwj4wUg/zHD6ZvJuwsCwvj7w3zE9ogNW/wOXIAzEKzQeXL1JFOtWGVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786642279; c=relaxed/simple;
	bh=UNibe3dsugq/b764iVqlTYzaBRKDAAaO3vu/vmOJEw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cOkoa9O9n/Wm0IQZhFlMIbzPjt3J0yEghxvwdbm1Vjff8iBFBImuK2ZCA71wCcgXPvz2eDiTBq1McnRsOM/cENWKe+uXtL/EvWx4+1YtdssN3FR2KSjFnpc78PX8ukUJBm9rL+KvUjoVJcLzbZyzXdsq8eAnftfBCTtCzx/z8V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZEGOv2rb; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZEGOv2rb"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-383cb94f742so91238a91.3
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 10:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786642277; x=1787247077;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6LzPtIIW390IfDZsFUle5+Dt63UP/YsqHxRNSLptijc=;
        b=hpdq0p2oHTORn6SincUy36ISk9TEbw+POUK0KENAo5AVFzqLQ3h+7U1zrxehOw/NaX
         Q+gOG/qrPnXLMjPPjLYR2Pzfm28JLw+Gy+6VMvkh79nQLdcBRPMo4cs/QhMYh3wJe4+Y
         aSn2QDq5VY1jf5nTdIckQeXo0y6rdajJn5vrivv02QlFsdv9OxoZRCjDJLV/tfyvXP3U
         r4sRtQYBAJp4ZzGgVHiq6h4QgSbxPfCgjH80Dbi3haRQC+kK/VGjr/13BxKlUCFeQUzE
         8SqqCQzhlfCzedHVeaLxZmHQLfalR+Oql9dTRJ2Cleo/Os5ukLAHIigDRp8yjIR7sm/D
         pmIA==
X-Forwarded-Encrypted: i=1; AHgh+Rryatn0WA29Q2iGi4ioP2NGAz8AzJTi1Rm40zmvKZNFslhNSlcRVcz9ilupjAAcU6wgdYjcWT90Y1F63NDX9cFh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw00Sy8Dp1YG/KNCBOWTbZYvrJ7hKE28Q5EXvXSEq5qY35skyVv
	FOfBsUH4sm6jaO8bSj968Gf8XoM8c6q+JckBzxS57qcCnr6e3y0ue5N3eklp1LpvoOru9UfUxQK
	kvAztiLsl8WuMu2AizZkSUH5icYXF2eFQyoBVqFtBk3x6qvTOz/ayw77SEo0m25/WH9028sWt+w
	GVijMgEGFJphYc7BqB2vJSyM21A97OIhlEg1xYBRAy0O+kaf/C9uA6zXPyCQXhenPf753fl5+v4
	mHCz2lkqWzv3Q/7GysY2s8SJrH5ug==
X-Gm-Gg: AR+sD10yZYJ44qddqWZw1KeUbKrivW3VRdL5ONLjS5QlYjRccei5TqTBb66UYPggiUs
	DomTYFo2srUo6ZQ1V4O2hw8NFJwK0URylHzxGyuaabaZ/ZfNdWfJHJZVgP5KGeb5E/HakIzU5v0
	5sLib5DYUfpyufAaeJg8OzMd09bWIWdz6TuCzA9xWybkqP3H03G1cCWG0DRK/Pqv6ar6izP8B/i
	C4ssQ9ATrIQvfBadwVJFDDKwdAQR5DWJy1gclP2TCQWqii+oeiEsmSBPtJyq2WVexXkKEUz7BHo
	K4NCVYQwtq8ayh0/gSeeT0cmKGa/7cRo6dZQNMhCneQVPGk+McWlVV1P/a8JnE2/UgNzGvXyveR
	dxNJafEtGMVvej5Orguv3IJu4D8opGz1DWlEOS3hbXl6OgjUvbQ2DWnFRKuC1fmxECpvrmpufO7
	cJ5rxibT157s2eNY0HP0vP5ZlCcCfpCImbmjVK13oo
X-Received: by 2002:a17:90b:3e4b:b0:385:393e:7124 with SMTP id 98e67ed59e1d1-3931e29b439mr8649751a91.14.1786642276868;
        Thu, 13 Aug 2026 10:31:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3931ca6c44esm1502686a91.0.2026.08.13.10.31.16
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2026 10:31:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-930dda91cbdso25727085a.3
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 10:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786642275; x=1787247075; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6LzPtIIW390IfDZsFUle5+Dt63UP/YsqHxRNSLptijc=;
        b=ZEGOv2rbjSRtX3ESWIaUxvGJi59jyR4TpAIaGpIw4RB0rlYTMrLOrmseUU7a95e1Vy
         CHrwvh0Q4+dVEZEQAK3HP2vGpgNdFwn6Jxk1SOFDc7crOydT8VKTlujhK3x+ygG2+Mpq
         +3eoDZgJ0mz37+gKYOgZmN6ht+VAB6eI//wxQ=
X-Forwarded-Encrypted: i=1; AHgh+RpJbb/S5K6IDriCyWyIpsx+foAQh05q94D7tkL2Sy1zJ98fZeV1yDHcvJ4UwQ+HCJ+lZadzoP3jf6RAnAW7ZoQy@vger.kernel.org
X-Received: by 2002:a05:620a:3903:b0:92e:4470:f6a7 with SMTP id af79cd13be357-936bf8c6615mr787253885a.10.1786642275091;
        Thu, 13 Aug 2026 10:31:15 -0700 (PDT)
X-Received: by 2002:a05:620a:3903:b0:92e:4470:f6a7 with SMTP id af79cd13be357-936bf8c6615mr787243585a.10.1786642274455;
        Thu, 13 Aug 2026 10:31:14 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936ce1e694fsm30634585a.28.2026.08.13.10.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 10:31:13 -0700 (PDT)
Message-ID: <700339f2-765f-4b2d-a80d-bd0a6822f91b@broadcom.com>
Date: Thu, 13 Aug 2026 10:31:11 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: perf: Add Raspberry Pi BCM2835 AXI PMU driver
To: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 mark.rutland@arm.com, u.kleine-koenig@baylibre.com, will@kernel.org
References: <20260813064228.2799872-1-irogers@google.com>
 <cover.1691900000.git.irogers@google.com>
 <20260813073050.2823657-1-irogers@google.com>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20260813073050.2823657-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 8/13/26 00:30, Ian Rogers wrote:
> This commit adds a new performance monitoring driver for the Raspberry Pi
> AXI bus (BCM2835/2711), exposing system-level and VideoCore PMU hardware to
> the Linux perf subsystem.
> 
> Note on out-of-tree macro compatibility:
> The inclusion of #if LINUX_VERSION_CODE < KERNEL_VERSION(6, 13, 0)
> surrounding hrtimer_setup is intentionally maintained alongside
> this patch to guarantee seamless out-of-tree compilation fallback
> compatibility for Raspberry Pi Long Term Support (LTS) kernel variants.

Upstream does not care about that, I appreciate the thought and mention, 
but that's a backporting job to ensure it works.

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   drivers/perf/rpi_axi_pmu.c | 2456 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 2456 insertions(+)
>   create mode 100644 drivers/perf/rpi_axi_pmu.c
> 
> diff --git a/drivers/perf/rpi_axi_pmu.c b/drivers/perf/rpi_axi_pmu.c
> new file mode 100644
> index 000000000000..d8efc8bb205f
> --- /dev/null
> +++ b/drivers/perf/rpi_axi_pmu.c
> @@ -0,0 +1,2456 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/**
> + * DOC: Raspberry Pi AXI Bus Performance Monitoring Unit (PMU) Driver
> + *
> + * This driver exposes the performance monitoring hardware on Raspberry Pi
> + * System-on-Chips to the Linux perf subsystem:
> + * - Raspberry Pi 1, 2, 3, 4, Compute Modules 1-4, Zero, Zero W (SoCs BCM2835/2836/2837/2711).
> + *
> + * Architecture Overview:
> + * ----------------------
> + * The Broadcom AXI performance hardware provides up to two independent monitors:
> + * 1. System Monitor (MON__SYSTEM = 0):
> + *    Monitors system-level AXI traffic (ARM CPU L2/UC, DMA, V3D, ISP, HVS, PCIe/RP1).
> + *    Directly memory-mapped via ARM physical IO memory space (MMIO).
> + *    Read latency: ~10-20 nanoseconds (fast, atomic-safe, non-blocking).
> + *
> + * 2. VPU Monitor (MON__VPU = 1):
> + *    Monitors VideoCore VPU buses (VPU0/1 Data/Instruction L2/UC, SDRAM, etc.).
> + *    Accessible through VideoCore firmware mailbox IPC (RPI_FIRMWARE_SET/GET_PERIPH_REG).
> + *    Read latency: ~10-100 microseconds (IPC over VPU mailbox).
> + *
> + * Synchronization & Concurrency Model:
> + * ------------------------------------
> + * - Spinlock (pmu->lock):
> + *   Protects active event array (events[]), event generation sequence counters (event_gen[]),
> + *   bus watcher allocation/refcounting, active_vpu_events counter, and MMIO register updates
> + *   (MON__SYSTEM) against SMP race conditions and ABA pointer recycling races.
> + *
> + * - Mutex (pmu->vpu_mutex):
> + *   Serializes VideoCore Mailbox IPC transactions (MON__VPU) in process context,
> + *   preventing concurrent mailbox buffer corruption across multiple CPUs.
> + *
> + * - Cached Async VPU Reads & Multiplexing (MON__VPU):
> + *   Polled periodically in process context by vpu_work when active_vpu_events > 0.
> + *   Uses PERF_HES_UPTODATE state flag to safely establish counter baselines during
> + *   event rotation / multiplexing. User read() syscalls return cached cumulative event counter
> + *   instantly without blocking.
> + */

The patch description needs to go into details as to why both the MMIO 
and firmware interfaces are supported. The firmware interface requires 
you to play games with sleeping/non-sleeping context, I would really 
want to avoid that and just support the MMIO path exclusively, is that 
practical? If that means ditching support for Pi 1&2, that would be 
reasonable IMHO.

> +
> +#include <linux/cpuhotplug.h>
> +#include <linux/cpumask.h>
> +#include <linux/hrtimer.h>
> +#include <linux/io.h>
> +#include <linux/version.h>
> +
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6, 13, 0)
> +static inline void rpi_hrtimer_setup(struct hrtimer *timer,
> +				     enum hrtimer_restart (*function)(struct hrtimer *),
> +				     clockid_t clock_id, enum hrtimer_mode mode)
> +{
> +	hrtimer_init(timer, clock_id, mode);
> +	timer->function = function;
> +}
> +#define hrtimer_setup rpi_hrtimer_setup
 > +#endif> +#include <linux/lockdep.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/perf_event.h>
> +#include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> +#include <linux/sysfs.h>
> +#include <linux/vmalloc.h>
> +#include <linux/workqueue.h>
> +
> +#include <soc/bcm2835/raspberrypi-firmware.h>
> +
> +/* --- PLATFORM CONSTANTS & ENUMERATIONS --------------------------- */
> +
> +/**
> + * enum rpi_axi_chip - Supported Broadcom SoC generations
> + * @CHIP_BCM2835: BCM2835 / BCM2836 / BCM2837 / BCM2711 (RPi 1-4, CM 1-4, Zero/W)
> + */
> +enum rpi_axi_chip {
> +	CHIP_BCM2835 = 0,
> +};
> +
> +enum monitor {
> +	MON__SYSTEM = 0,
> +	MON__VPU,
> +	MON__MAX
> +};
> +
> +/* Number of hardware bus watcher units per monitor */
> +#define NUM_BUS_WATCHERS_PER_MONITOR 3
> +
> +/**
> + * enum bcm2835_system_bus - AXI buses monitored by System Monitor on BCM2835-BCM2711 (RPi 1-4)
> + * @BCM2835_SB__DMA_L2: DMA engine L2 cache interconnect bus

Why the double underscore in the naming convention?

[snip]

> +
> +/* Hardware register offsets & control bitwise constants */
> +#define GEN_CTRL			0x00
> +#define GEN_CTL_ENABLE_BIT		BIT(0)
> +#define GEN_CTL_RESET_BIT		BIT(1)
> +#define GEN_CTL_WATCH_BIT		BIT(2)
> +
> +#define BW_PITCH			0x40

Rather than pitch, maybe stride?

> +#define BW0_CTRL			0x40
> +#define BW1_CTRL			0x80
> +#define BW2_CTRL			0xc0
> +
> +#define BW_ATRANS_OFFSET		0x04

That's confusing, so you are offsetting from the base of BW0_CTRL, that 
needs a comment to explain that offset choice.

> +#define BW_ATWAIT_OFFSET		0x08
> +#define BW_AMAX_OFFSET			0x0c
> +#define BW_WTRANS_OFFSET		0x10
> +#define BW_WTWAIT_OFFSET		0x14
> +#define BW_WMAX_OFFSET			0x18
> +#define BW_RTRANS_OFFSET		0x1c
> +#define BW_RTWAIT_OFFSET		0x20
> +#define BW_RMAX_OFFSET			0x24
> +
> +#define BW_CTRL_RESET_BIT		BIT(31)
> +#define BW_CTRL_ENABLE_BIT		BIT(30)
> +#define BW_CTRL_ENABLE_ID_FILTER_BIT	BIT(29)
> +#define BW_CTRL_LIMIT_HALT_BIT		BIT(28)
> +
> +#define BW_CTRL_BUS_WATCH_SHIFT		0
> +#define BW_CTRL_BUS_WATCH_MASK		GENMASK(5, 0)
> +#define BW_CTRL_BUS_FILTER_SHIFT	8
> +#define BW_CTRL_BUS_FILTER_MASK		GENMASK(12, 8)
> +
> +/*
> + * RPI_AXI_PMU_TIMER_INTERVAL determines the background polling frequency
> + * for VideoCore VPU Mailbox IPC counters.
> + *
> + * A balance is required:
> + * - IPC Overhead: Polling overly fast (e.g., 10ms) generates excessive CPU
> + *   wakeups and VideoCore IPC interrupts on older CPUs (Pi 1/2).
> + * - Accuracy: Polling overly slow (e.g., 2000ms) causes short time-multiplexed
> + *   profiling sessions (under the interval) to mathematically strand residual
> + *   counts since the mailbox cannot be queried synchronously inside pmu->read().
> + *
> + * 100ms (10 Hz) provides reasonably accurate profiling without heavy overhead.
> + */
> +#define RPI_AXI_PMU_TIMER_INTERVAL ms_to_ktime(100)
> +
> +static enum cpuhp_state rpi_axi_pmu_cpuhp_state;
> +
> +/* --- PMU API & CONFIG DECODING ---------------------------------- */
> +
> +#define PMU_NAME "rpi_axi_pmu"
> +
> +/**
> + * config_to_filter() - Extracts AXI filter ID from perf event config
> + * @config: 64-bit config value from struct perf_event_attr
> + *
> + * Return: Filter ID value (bits 10-14).
> + */
> +static int config_to_filter(__u64 config)
> +{
> +	return (config >> 10) & 0x1F;

Can we have a definition for the shift and mask here?

> +}
> +
> +/**
> + * config_to_monitor() - Extracts Monitor ID from perf event config
> + * @config: 64-bit config value from struct perf_event_attr
> + *
> + * Return: Monitor enum (bit 9: 0 = System, 1 = VPU).
> + */
> +static enum monitor config_to_monitor(__u64 config)
> +{
> +	return (config >> 9) & 1;

Likewise.

> +}
> +
> +/**
> + * config_to_bus() - Extracts bus index from perf event config
> + * @config: 64-bit config value from struct perf_event_attr
> + *
> + * Return: Bus index (bits 4-8).
> + */
> +static int config_to_bus(__u64 config)
> +{
> +	return (config >> 4) & 0x1F;

Likewise

> +}
> +
> +/**
> + * config_to_counter() - Extracts metric counter type from perf event config
> + * @config: 64-bit config value from struct perf_event_attr
> + *
> + * Return: Counter enum (bits 0-3).
> + */
> +static enum counter config_to_counter(__u64 config)
> +{
> +	return config & 0xF;

And here as well.

[snip]

> +	for (int i = 0; i < MON__MAX; i++) {
> +		rpi_axi_hw_events__init(&pmu->monitor[i].hw_events);
> +
> +		if (pmu->monitor[i].use_mailbox_interface) {
> +			struct resource *resource = platform_get_resource(pdev, IORESOURCE_MEM, i);
> +
> +			if (!resource) {
> +				dev_err(dev, "Error reading mailbox resource %d\n", i);
> +				ret = -EINVAL;
> +				goto err_firmware_put;
> +			}
> +			pmu->monitor[i].mailbox = (u32)resource->start;
> +		} else {
> +			struct resource *resource = platform_get_resource(pdev, IORESOURCE_MEM, i);

Well you are fetching MMIO resources here, so you need a Device Tree 
description and you need to submit the Device Tree changes that describe 
these register ranges. Is it fair to assume only the RPi firmware path 
has been tested or did you also test with MMIO?

[snip]
> +
> +MODULE_LICENSE("GPL");
Missing MODULE_AUTHOR() and MODULE_DESCRIPTION().
-- 
Florian

