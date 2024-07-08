Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA35A76025;
	Mon,  8 Jul 2024 10:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720433215; cv=none; b=CMkAFm6EhGOHFhIPoldnaamFMaJS/TLkzsmA4y4POPhP0X2V/G44lGc9WOjHuSNppfipIB5qnJrFL4I0lAIi81giQj3m/pgt8GcTMXse0bdgTrTyBAHI3ZJC/ac0roo2o+X+VdSG7HNCz/e9trG+NvDEz0nvhqaxKVyDKdYVTwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720433215; c=relaxed/simple;
	bh=VEZ06fzVYpy++9icFhiWFSzQWhDVs2na3vsap9PM6ug=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=EjgW9l2am/1m7vqCWAhVRYmbxdfWye3Lljge7dH4jfRq9MqIA7crWZQvfxOJY76BH14k75uB2eXNYS12bDHrEbZu0Js9+Pk2Fc5LkTm6Olq18PS0X0cLMbWRVbr9+ZUHLDRW7GAWwJ5plqpa80AjuhQRXypkbkpWQ88L0sy7PE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cx8PE7uotmVPYBAA--.6462S3;
	Mon, 08 Jul 2024 18:06:51 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Dxvsc3uotmT30_AA--.16015S3;
	Mon, 08 Jul 2024 18:06:48 +0800 (CST)
Subject: Re: [PATCH v2 1/3] perf: Add perf_event_attr::bp_priv
To: Peter Zijlstra <peterz@infradead.org>
References: <20240621073910.8465-1-yangtiezhu@loongson.cn>
 <20240621073910.8465-2-yangtiezhu@loongson.cn>
 <20240705103413.GA8971@willie-the-truck>
 <7522fc14-aacc-a8e3-3258-9064d7e2936f@loongson.cn>
 <20240708073652.GE11386@noisy.programming.kicks-ass.net>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Oleg Nesterov <oleg@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <da0c95e7-c676-e0c0-8b90-b1ea5fc7b72f@loongson.cn>
Date: Mon, 8 Jul 2024 18:06:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240708073652.GE11386@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:AQAAf8Dxvsc3uotmT30_AA--.16015S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF4UKF17ArW7Zr4DGrWrCrX_yoWrAry7pr
	s8CFnIkrWkJryYvw13Kw12vw15twsrKr4UW343G34jyFsI93s5Wa1kKF1a9Fn5Ars7AFWF
	qw4qqF9ru34UurXCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2-VyUU
	UUU

On 07/08/2024 03:36 PM, Peter Zijlstra wrote:
> On Sat, Jul 06, 2024 at 01:31:03PM +0800, Tiezhu Yang wrote:
>>
>>
>> On 07/05/2024 06:34 PM, Will Deacon wrote:
>>> On Fri, Jun 21, 2024 at 03:39:08PM +0800, Tiezhu Yang wrote:
>>>> Add a member "bp_priv" at the end of the uapi struct perf_event_attr
>>>> to make a bridge between ptrace and hardware breakpoint.
>>>>
>>>> This is preparation for later patch on some archs such as ARM, ARM64
>>>> and LoongArch which have privilege level of breakpoint.
>>>>
>>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>>>> ---
>>>>  include/uapi/linux/perf_event.h | 3 +++
>>>>  kernel/events/hw_breakpoint.c   | 1 +
>>>>  2 files changed, 4 insertions(+)
>>>>
>>>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
>>>> index 3a64499b0f5d..f9f917e854e6 100644
>>>> --- a/include/uapi/linux/perf_event.h
>>>> +++ b/include/uapi/linux/perf_event.h
>>>> @@ -379,6 +379,7 @@ enum perf_event_read_format {
>>>>  #define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
>>>>  #define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
>>>>  #define PERF_ATTR_SIZE_VER8	136	/* add: config3 */
>>>> +#define PERF_ATTR_SIZE_VER9	144	/* add: bp_priv */
>>>>
>>>>  /*
>>>>   * Hardware event_id to monitor via a performance monitoring event:
>>>> @@ -522,6 +523,8 @@ struct perf_event_attr {
>>>>  	__u64	sig_data;
>>>>
>>>>  	__u64	config3; /* extension of config2 */
>>>> +
>>>> +	__u8	bp_priv; /* privilege level of breakpoint */
>>>>  };
>>>
>>> Why are we extending the user ABI for this? Perf events already have the
>>> privilege encoded (indirectly) by the exclude_{user,kernel,hv} fields in
>>> 'struct perf_event_attr'.
>>
>> IMO, add bp_priv is to keep consistent with the other fields
>> bp_type, bp_addr and bp_len, the meaning of bp_priv field is
>> explicit and different with exclude_{user,kernel,hv} fields.
>
> In case it wasn't obvious, this structure has __u64 granularity. You
> don't just add a __u8 to the end. Also, since you mention consistency,
> you might have noticed those other bp_ fields are in a union on
> config[12], so why can't this live in a union on config3 ?

Looks good, I will do it in v3, like this:
(no need to define PERF_ATTR_SIZE_VER9	144)

diff --git a/include/uapi/linux/perf_event.h 
b/include/uapi/linux/perf_event.h
index 3a64499b0f5d..abe8da7a1f60 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -521,7 +521,10 @@ struct perf_event_attr {
          */
         __u64   sig_data;

-       __u64   config3; /* extension of config2 */
+       union {
+               __u8    bp_priv; /* privilege level of breakpoint */
+               __u64   config3; /* extension of config2 */
+       };
  };

>> Additionally, there is only 1 bit for exclude_{user,kernel,hv},
>> but bp_priv field has at least 2 bit according to the explanation
>> of Arm Reference Manual. At last, the initial aim is to remove
>> the check condition to assign the value of hw->ctrl.privilege.
>>
>> https://developer.arm.com/documentation/ddi0487/latest/
>>
>> 1. D23: AArch64 System Register Descriptions (Page 8562)
>>    D23.3.11 DBGWCR<n>_EL1, Debug Watchpoint Control Registers, n = 0 - 63
>>    PAC, bits [2:1]
>>    Privilege of access control. Determines the Exception level or levels at
>> which a Watchpoint debug
>>    event for watchpoint n is generated.
>>
>> 2. G8: AArch32 System Register Descriptions (Page 12334)
>>    G8.3.26 DBGWCR<n>, Debug Watchpoint Control Registers, n = 0 - 15
>>    PAC, bits [2:1]
>>    Privilege of access control. Determines the Exception level or levels at
>> which a Watchpoint debug
>>    event for watchpoint n is generated.
>
> That's all clear as mud for someone that don't speak arm. Can you please
> provide a coherent reason for all this that does not rely on external
> resources?

In short, when developing hardware watchpoint on LoongArch, we want to
set the same privilege passed by the ptrace user data, but there is no
a middle bridge to save this value like bp_addr, bp_type and bp_len, I
think this is a common issue for the archs which have privilege level
of breakpoint.

Thanks,
Tiezhu

