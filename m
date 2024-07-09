Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76401586C4;
	Tue,  9 Jul 2024 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720526876; cv=none; b=BwPZjEnvaS934DqADXfCIU/HLYax3Ls/A4PNzayHAEM3ooKC3C42tzbPgBXmk2u97ViWJB6V4s2bjTtV1txM88Vei1L293+1Hb8NglvIDnCs4n9da8UCpQFhzEVwJtUNMvn7BSKSt13CHEglbjXvLYl2ImcIPRojYb2s7LhTpVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720526876; c=relaxed/simple;
	bh=HiqaSbumntvKz5Emuwn+N3bSrB5MzpJVcl7+vGk/JNw=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uyj8Ss1IdGojRRh8yqLYK0QGTDeguWTBbQRNhaaRJ8tWTmBvdk59SpeVbEk+0Z4rvZU9wCBJDwwVQL8MxjK37tsawB98f5wQwJfxwmZG2gTdm+CApLrmb1ChX43LY/wUorvQXHeNnquXHYz5yJ/y7FuQwHip8yoqmqViYEQ1Kzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxL_EYKI1mrGsCAA--.7825S3;
	Tue, 09 Jul 2024 20:07:52 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxhsUWKI1mcwNBAA--.7813S3;
	Tue, 09 Jul 2024 20:07:51 +0800 (CST)
Subject: Re: [PATCH v3 3/3] arm64: hw_breakpoint: Save privilege of access
 control via ptrace
To: Will Deacon <will@kernel.org>
References: <20240709095506.9691-1-yangtiezhu@loongson.cn>
 <20240709095506.9691-4-yangtiezhu@loongson.cn>
 <20240709100515.GB12978@willie-the-truck>
Cc: Mark Rutland <mark.rutland@arm.com>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>,
 Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <d72a04f5-7894-af6c-dd4a-c6728e936f73@loongson.cn>
Date: Tue, 9 Jul 2024 20:07:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240709100515.GB12978@willie-the-truck>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:AQAAf8AxhsUWKI1mcwNBAA--.7813S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxuFy8Ww4rGry3CF4kXw48KrX_yoW5Aw4Dpr
	W3C3WkKw4DJa1jkasIqws3Zan8WwsIg34UWryvk34Skr13Zrn3CrykGry5urZxAry0q3y0
	krWqvr1rWa1UZ3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8
	Jr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8nNVD
	UUUUU==

On 07/09/2024 06:05 PM, Will Deacon wrote:
> On Tue, Jul 09, 2024 at 05:55:06PM +0800, Tiezhu Yang wrote:
>> In the current code, decode_ctrl_reg() saves the privilege of access
>> control passed by the ptrace user data, but it is not used anymore,
>> arch_build_bp_info() checks whether bp virtual address is in kernel
>> space to construct hw->ctrl.privilege, it seems not reasonable.
>>
>> The value of ctrl->privilege saved in decode_ctrl_reg() can be used
>> in arch_build_bp_info(), there is no need to check bp virtual address
>> to assign value for hw->ctrl.privilege, just make use of "bp_priv" in
>> the struct perf_event_attr to save the privilege of access control via
>> ptrace for hardware breakpoint.
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>  arch/arm64/kernel/hw_breakpoint.c | 11 ++---------
>>  arch/arm64/kernel/ptrace.c        |  2 ++
>>  2 files changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
>> index 722ac45f9f7b..06e34bcdcf92 100644
>> --- a/arch/arm64/kernel/hw_breakpoint.c
>> +++ b/arch/arm64/kernel/hw_breakpoint.c
>> @@ -486,15 +486,8 @@ static int arch_build_bp_info(struct perf_event *bp,
>>  	/* Address */
>>  	hw->address = attr->bp_addr;
>>
>> -	/*
>> -	 * Privilege
>> -	 * Note that we disallow combined EL0/EL1 breakpoints because
>> -	 * that would complicate the stepping code.
>> -	 */
>
> Just because you remove the comment doesn't mean that constraint no
> longer applies.

Yes, please see the following answer.

>
>> -	if (arch_check_bp_in_kernelspace(hw))
>> -		hw->ctrl.privilege = AARCH64_BREAKPOINT_EL1;
>> -	else
>> -		hw->ctrl.privilege = AARCH64_BREAKPOINT_EL0;
>> +	/* Privilege */
>> +	hw->ctrl.privilege = attr->bp_priv;
>>
>>  	/* Enabled? */
>>  	hw->ctrl.enabled = !attr->disabled;
>> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
>> index 0d022599eb61..3b37c4a2e0d4 100644
>> --- a/arch/arm64/kernel/ptrace.c
>> +++ b/arch/arm64/kernel/ptrace.c
>> @@ -309,6 +309,7 @@ static struct perf_event *ptrace_hbp_create(unsigned int note_type,
>>  	attr.bp_addr	= 0;
>>  	attr.bp_len	= HW_BREAKPOINT_LEN_4;
>>  	attr.bp_type	= type;
>> +	attr.bp_priv	= AARCH64_BREAKPOINT_EL0;
>>  	attr.disabled	= 1;
>>
>>  	bp = register_user_hw_breakpoint(&attr, ptrace_hbptriggered, NULL, tsk);
>> @@ -352,6 +353,7 @@ static int ptrace_hbp_fill_attr_ctrl(unsigned int note_type,
>>  	attr->bp_len	= len;
>>  	attr->bp_type	= type;
>>  	attr->bp_addr	+= offset;
>> +	attr->bp_priv	= ctrl.privilege;
>
> Wait, so ptrace can now set breakpoints with arbitrary privileges?

The ptrace user should make sure the privilege is correct.
For example, the privilege is set as el0
in aarch64_point_encode_ctrl_reg() of GDB:

   /* enabled at el0 */
   ctrl |= (2 << 1) | 1;

https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=gdb/nat/aarch64-hw-point.c#l135

Thanks,
Tiezhu

