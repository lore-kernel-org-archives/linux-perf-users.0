Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41D01B0119;
	Thu,  4 Jul 2024 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720104486; cv=none; b=rFEoSM/T6Gx15Mh5YQMfq4jgl23ByoxLVmb7qCTN90KOCeKxrRdw72kG1VbBg4FBgmbfUBLlyXmpvmHkAjpUC70GM2pztkHJGN66eYSaflUOJThjyEDuiINGbrInyuRSLCPdWKW3rQWXONmSXzexmkaXZz18A9vAeQKUUu3EaGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720104486; c=relaxed/simple;
	bh=bZYIFkT1L0I1lV75J4LbB9X5PX2ui0qO0qhHQb9jdn4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jBfVuCr9dM5kr/ihk0BKFPEtNeXPUZ43Zu91xgsDxO09qrbJloG1UcoaDOZScE7EGVZvxAj4ye/XVWIozjl3cMfmJF8T1V0F9Rt8zlFCSxJxU7OfAeBSJama1uPhTN2OL9hKJ43TRXa9ki7Ks8GcjTUnupjKZX4wOhRaQ1f69Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [117.22.85.168])
	by gateway (Coremail) with SMTP id _____8DxfeshtoZmMv0AAA--.3074S3;
	Thu, 04 Jul 2024 22:48:01 +0800 (CST)
Received: from [192.168.0.109] (unknown [117.22.85.168])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxRcUetoZmmi87AA--.60231S3;
	Thu, 04 Jul 2024 22:48:00 +0800 (CST)
Message-ID: <5ab53836-5a11-a47b-042e-96c5c9e70974@loongson.cn>
Date: Thu, 4 Jul 2024 22:47:59 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 0/3] hw_breakpoint: Save privilege of access control
 via ptrace
Content-Language: en-US
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Oleg Nesterov <oleg@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240621073910.8465-1-yangtiezhu@loongson.cn>
In-Reply-To: <20240621073910.8465-1-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:AQAAf8AxRcUetoZmmi87AA--.60231S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw18JF43WF4xKw1xAFyxWFX_yoW8Xr47pr
	W3u3ZxKw4DGayUu3ZIqw4Dua4S9w1kXrWjqa4DGw4Fyrn09Fy3WFZ2q3ZI9rZrZr1Iq34f
	t3yqvrWqy3WUZ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUU
	UUU

On 6/21/24 15:39, Tiezhu Yang wrote:
> Hi all,
> 
> Thank you very much for your feedbacks in the v1 patch.
> This series is based on 6.10-rc4, cross compile tested only.
> 
> As far as I can tell, these changes are not relevant with tools/perf,
> on some archs such as ARM, ARM64 and LoongArch which have privilege
> level of breakpoint, the initial aim is to make use of the value of
> ctrl->privilege saved in decode_ctrl_reg() and then remove the check
> whether bp virtual address is in kernel space to assign value for
> hw->ctrl.privilege in arch_build_bp_info().
> 
> v2:
>    -- Put the new member "bp_priv" at the end of the uapi
>       struct perf_event_attr and add PERF_ATTR_SIZE_VER9.
>    -- Update the commit message to make the goal clear.
> 
> Tiezhu Yang (3):
>    perf: Add perf_event_attr::bp_priv
>    arm: hw_breakpoint: Save privilege of access control via ptrace
>    arm64: hw_breakpoint: Save privilege of access control via ptrace
> 
>   arch/arm/kernel/hw_breakpoint.c   |  4 +---
>   arch/arm/kernel/ptrace.c          |  2 ++
>   arch/arm64/kernel/hw_breakpoint.c | 11 ++---------
>   arch/arm64/kernel/ptrace.c        |  2 ++
>   include/uapi/linux/perf_event.h   |  3 +++
>   kernel/events/hw_breakpoint.c     |  1 +
>   6 files changed, 11 insertions(+), 12 deletions(-)

Ping, any more comments? Is it possible to merge this series
for the coming merge window?

If this patch series has no value and is not acceptable,
or what should I do to update, please let me know.

Thanks,
Tiezhu

