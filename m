Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8F712DDAE;
	Tue,  9 Jul 2024 12:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720526747; cv=none; b=pvbPGX27Q2aN/O58kBu8vgLQvZwJkn8TtSOsiprWnM+IU1egxxO3f0wafWsg91xLFXu9vyMq5SfBYjlswI1zyurSjmzgfODTbFUfnTdI0hLPlTpXL+KB6NyUjBeSg64xLTRZA4FUGxSIp6F9Xhwciq4f/phiJAQHb6mHImqJCsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720526747; c=relaxed/simple;
	bh=ASrMse71KGxR4W6YXPjOC0NqqUxqgYmeIkU14MvNDtc=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=gic+eAvNizFSBqR9cC+7YbsEy48RhCYnXDCUCcPep4Mu+N0H/JT+SOpOUc7HPVeEPfvkIBvc3n3wFDA+Q1c9cux6RX8lGU8t+Ku5tbKyTIi9cQPHXlL/0OIsPwAyNP7+BMx1P08ignUdvGrrQSZyI/F/jxnTxVqs+TW6TyaStG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxbPCVJ41mi2sCAA--.7156S3;
	Tue, 09 Jul 2024 20:05:41 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxJMWUJ41m8QJBAA--.7892S3;
	Tue, 09 Jul 2024 20:05:41 +0800 (CST)
Subject: Re: [PATCH v3 1/3] perf: Add perf_event_attr::bp_priv
To: Will Deacon <will@kernel.org>
References: <20240709095506.9691-1-yangtiezhu@loongson.cn>
 <20240709095506.9691-2-yangtiezhu@loongson.cn>
 <20240709100304.GA12978@willie-the-truck>
Cc: Mark Rutland <mark.rutland@arm.com>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>,
 Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <6d18e6fc-1d3f-f866-e887-bf5e01fb9368@loongson.cn>
Date: Tue, 9 Jul 2024 20:05:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240709100304.GA12978@willie-the-truck>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:AQAAf8CxJMWUJ41m8QJBAA--.7892S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw17Gw4rtrykAr1fuFyxCrX_yoW8uF1xpr
	ZxCFn5K3yktry093ZrWwsrZryUXws29rWqg3W3Kw4Ykryav3s3G3ykWr909Fn5Zr1xAa4r
	twnFgFn8ta4UXagCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07joc_-UUU
	UU=

On 07/09/2024 06:03 PM, Will Deacon wrote:
> On Tue, Jul 09, 2024 at 05:55:04PM +0800, Tiezhu Yang wrote:
>> When developing hardware watchpoint on LoongArch, we want to set the
>> same privilege passed by the ptrace user data, but there is no bridge
>> to save this value like bp_addr, bp_type and bp_len. This is a common
>> issue for the archs which have privilege level of breakpoint.
>>
>> Add a member "bp_priv" which lives in a union on config3 at the end
>> of the uapi struct perf_event_attr to make a bridge between ptrace
>> and hardware breakpoint.
>>
>> This is preparation for later patch on some archs such as ARM, ARM64
>> and LoongArch which have privilege level of breakpoint.
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>  include/uapi/linux/perf_event.h | 5 ++++-
>>  kernel/events/hw_breakpoint.c   | 1 +
>>  2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
>> index 3a64499b0f5d..abe8da7a1f60 100644
>> --- a/include/uapi/linux/perf_event.h
>> +++ b/include/uapi/linux/perf_event.h
>> @@ -521,7 +521,10 @@ struct perf_event_attr {
>>  	 */
>>  	__u64	sig_data;
>>
>> -	__u64	config3; /* extension of config2 */
>> +	union {
>> +		__u8	bp_priv; /* privilege level of breakpoint */
>> +		__u64	config3; /* extension of config2 */
>> +	};
>>  };
>>
>>  /*
>> diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
>> index 6c2cb4e4f48d..3ad16b226e4f 100644
>> --- a/kernel/events/hw_breakpoint.c
>> +++ b/kernel/events/hw_breakpoint.c
>> @@ -754,6 +754,7 @@ static void hw_breakpoint_copy_attr(struct perf_event_attr *to,
>>  	to->bp_addr = from->bp_addr;
>>  	to->bp_type = from->bp_type;
>>  	to->bp_len  = from->bp_len;
>> +	to->bp_priv = from->bp_priv;
>>  	to->disabled = from->disabled;
>>  }
>
> Sorry, but I still don't see why we should change uapi for this. As I
> have said multiple times, this is unnecessary.

Thanks for your review, I see your point but let us wait
for more comments from perf people.

Thanks,
Tiezhu

