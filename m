Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAE312E71;
	Sat,  6 Jul 2024 05:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720243872; cv=none; b=MpRc6Q3BjYlQ10mT9ws4d5TVaBMP/GsyYefdZrAMWZL+nPttB7HLdRKUoVKJNn4m6sVRB9ZodZKzrdO3STDQFGBSB3pZUeVdxN+WMsq2OhaDRmfH7+I2XwiIHdP/t/Ysx1ixfu+28Z/TUEVQFT91s+cMmeclYeLNsqf9gGjpJDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720243872; c=relaxed/simple;
	bh=JCaKO6KprrFJGJuHb5RqFx23OktrqlNQhBzSvQ8fYVE=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FCKHRr0Sr/ym4idYkSuSa55G0GQatCp0YsMYrdSsOlsiGueIn4s9lWh1gymFXBVdpj02P90QpO5QZIWjU/DZ+LlCv24bSTv6SxpsZBVtbyktM9MD/soxwKrsI6KT9+Ah1mr6tH3AXMoj/6v3y4xEra7ZYCdVFJFCRw/ghlV6MIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxK_Ca1ohm6IIBAA--.4671S3;
	Sat, 06 Jul 2024 13:31:06 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxTceX1ohm2RA9AA--.10907S3;
	Sat, 06 Jul 2024 13:31:04 +0800 (CST)
Subject: Re: [PATCH v2 1/3] perf: Add perf_event_attr::bp_priv
To: Will Deacon <will@kernel.org>
References: <20240621073910.8465-1-yangtiezhu@loongson.cn>
 <20240621073910.8465-2-yangtiezhu@loongson.cn>
 <20240705103413.GA8971@willie-the-truck>
Cc: Mark Rutland <mark.rutland@arm.com>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>,
 Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <7522fc14-aacc-a8e3-3258-9064d7e2936f@loongson.cn>
Date: Sat, 6 Jul 2024 13:31:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240705103413.GA8971@willie-the-truck>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:AQAAf8AxTceX1ohm2RA9AA--.10907S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCF4ftw4xGFWUtF4rGr4Utrc_yoW5GFWfpw
	s8CFn5KrWkJr43W3ZIk3W7Zr15WwsxKr4UW3y7W34jyF4ak3sYg3Wvgr1a9Fn5Crs7ZFWF
	v34qqryDCayj9FXCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
	Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48J
	MxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcveHDUUUU



On 07/05/2024 06:34 PM, Will Deacon wrote:
> On Fri, Jun 21, 2024 at 03:39:08PM +0800, Tiezhu Yang wrote:
>> Add a member "bp_priv" at the end of the uapi struct perf_event_attr
>> to make a bridge between ptrace and hardware breakpoint.
>>
>> This is preparation for later patch on some archs such as ARM, ARM64
>> and LoongArch which have privilege level of breakpoint.
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>  include/uapi/linux/perf_event.h | 3 +++
>>  kernel/events/hw_breakpoint.c   | 1 +
>>  2 files changed, 4 insertions(+)
>>
>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
>> index 3a64499b0f5d..f9f917e854e6 100644
>> --- a/include/uapi/linux/perf_event.h
>> +++ b/include/uapi/linux/perf_event.h
>> @@ -379,6 +379,7 @@ enum perf_event_read_format {
>>  #define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
>>  #define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
>>  #define PERF_ATTR_SIZE_VER8	136	/* add: config3 */
>> +#define PERF_ATTR_SIZE_VER9	144	/* add: bp_priv */
>>
>>  /*
>>   * Hardware event_id to monitor via a performance monitoring event:
>> @@ -522,6 +523,8 @@ struct perf_event_attr {
>>  	__u64	sig_data;
>>
>>  	__u64	config3; /* extension of config2 */
>> +
>> +	__u8	bp_priv; /* privilege level of breakpoint */
>>  };
>
> Why are we extending the user ABI for this? Perf events already have the
> privilege encoded (indirectly) by the exclude_{user,kernel,hv} fields in
> 'struct perf_event_attr'.

IMO, add bp_priv is to keep consistent with the other fields
bp_type, bp_addr and bp_len, the meaning of bp_priv field is
explicit and different with exclude_{user,kernel,hv} fields.
Additionally, there is only 1 bit for exclude_{user,kernel,hv},
but bp_priv field has at least 2 bit according to the explanation
of Arm Reference Manual. At last, the initial aim is to remove
the check condition to assign the value of hw->ctrl.privilege.

https://developer.arm.com/documentation/ddi0487/latest/

1. D23: AArch64 System Register Descriptions (Page 8562)
    D23.3.11 DBGWCR<n>_EL1, Debug Watchpoint Control Registers, n = 0 - 63
    PAC, bits [2:1]
    Privilege of access control. Determines the Exception level or 
levels at which a Watchpoint debug
    event for watchpoint n is generated.

2. G8: AArch32 System Register Descriptions (Page 12334)
    G8.3.26 DBGWCR<n>, Debug Watchpoint Control Registers, n = 0 - 15
    PAC, bits [2:1]
    Privilege of access control. Determines the Exception level or 
levels at which a Watchpoint debug
    event for watchpoint n is generated.

Thanks,
Tiezhu

