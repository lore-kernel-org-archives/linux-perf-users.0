Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614EE320B;
	Thu, 20 Jun 2024 02:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718849144; cv=none; b=Q74XWmMF6nvfl0Zhppy7uRHt/ikJ8raXkKGPnnzIxjoHQ9Vi8X0n83WVWEe3PoXTkL1sUpyw/+KoT25MxVLBtMEioktUoIdUWlD+A3R4xyKvcXggWUJlirkreLAtaaL9ddsuZkfCZnTeHViBihds2+Yrb+x1KB7ekSSZwNTq7CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718849144; c=relaxed/simple;
	bh=bQTySmjxjXq3J2IRRMOogCcA3BQmFgjBbULK2WtTyYk=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Jl8SHTHOIfD1TsT3hPANNdTbAAzZNhGbVG9rFVZeB5x+hZcES1c9T8nrWmP0oMM+4Zqp/7s72yMmt2fLg7sqKLcpAAXCaGV8qnlAEA/ENp3bbq2ukaLNM2gZfcGDVAcLEGbt9xJFI5grIR+AkojkWRSYWfiIANjNN087jduf6Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxUPBxjnNm1GQIAA--.33845S3;
	Thu, 20 Jun 2024 10:05:37 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxPMdvjnNmxdgpAA--.36253S3;
	Thu, 20 Jun 2024 10:05:35 +0800 (CST)
Subject: Re: [PATCH] arm64: hw_breakpoint: Save privilege of access control
 via ptrace
To: Oleg Nesterov <oleg@redhat.com>
References: <20240618071010.11214-1-yangtiezhu@loongson.cn>
 <20240619151524.GB24240@redhat.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <9cc6d314-2431-c1b5-3d46-63c0ac80ed4d@loongson.cn>
Date: Thu, 20 Jun 2024 10:05:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240619151524.GB24240@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:AQAAf8DxPMdvjnNmxdgpAA--.36253S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tF4DuryruF4DWr1UKF17Arc_yoW8Gr18pw
	s8C3Z8tw4DJa1Uuwn0qwsxZa1Ykw1fWryDXwn8W3yakr4Yg393WFW09F4Ykrs8Ar1kCw1F
	gw4qqr9xWFWUXFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jOiSdUUUUU=

On 06/19/2024 11:15 PM, Oleg Nesterov wrote:
> I don't understand what this patch does, but...

Thanks for your reply.

ctrl->privilege in decode_ctrl_reg() is never be used later but
it can and should be used in arch_build_bp_info().

arch/arm64/include/asm/hw_breakpoint.h
static inline void decode_ctrl_reg(u32 reg,
				   struct arch_hw_breakpoint_ctrl *ctrl)
{
     ...
	ctrl->privilege	= reg & 0x3;  // it is never be used later but ...
	...
}

arch/arm64/kernel/hw_breakpoint.c
static int arch_build_bp_info(struct perf_event *bp,
			      const struct perf_event_attr *attr,
			      struct arch_hw_breakpoint *hw)
{
	...

	if (arch_check_bp_in_kernelspace(hw))
		hw->ctrl.privilege = AARCH64_BREAKPOINT_EL1;  // ... it can and should 
be used here
	else
		hw->ctrl.privilege = AARCH64_BREAKPOINT_EL0;  // and here.
     ...
}

>
> On 06/18, Tiezhu Yang wrote:
>>
>> --- a/include/uapi/linux/perf_event.h
>> +++ b/include/uapi/linux/perf_event.h
>> @@ -467,6 +467,7 @@ struct perf_event_attr {
>>  		__u32		wakeup_watermark; /* bytes before wakeup   */
>>  	};
>>
>> +	__u8			bp_priv;
>>  	__u32			bp_type;
>
> Is it safe to add the new member in the middle of uapi struct?
> This will break userspace...

Let me put the new member "bp_priv" at the end of uapi struct
perf_event_attr in the next version if you are OK with it.

Thanks,
Tiezhu

