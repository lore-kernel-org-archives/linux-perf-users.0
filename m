Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F7F2594;
	Thu, 20 Jun 2024 09:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718877060; cv=none; b=J3Pi2uK0AHr7i1tIQG2wwsK9wuTJYLJINo+h0wzWtAIKRYt6posoIsQgUKYrYVwKuCj8yOvUe3fvPAeiJti5nxODYv4AAb4Y+BLc/+hUP3lygZz0dqv0m/LAbk4BaVaYpd7AScCJDW2gnBirp1Ov1P04AihHnPnyG+caFfNVui4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718877060; c=relaxed/simple;
	bh=jKSfdpPQdinKiIJebXCsGp0FDLQBlV93GwBkzgs51pg=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=AZOuqgnEVanV27WP3iDsd/NovfDg9mbiKMOrF8j2m3oSg8xjH5PxtiYFMojFKJjVwGnuUxpzrplj/vs2Giqx7y0OHFcMeKMLvPgSWwqW1lwY3327LL1a0topFfU5x5B+RZW0JssoBwmK/GpuXx7a5VXiIO1Dt63WRHJqgdKhRKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxyOl3+3NmKHwIAA--.21218S3;
	Thu, 20 Jun 2024 17:50:47 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxmsZ1+3NmBTEqAA--.36373S3;
	Thu, 20 Jun 2024 17:50:46 +0800 (CST)
Subject: Re: [PATCH] arm64: hw_breakpoint: Save privilege of access control
 via ptrace
To: Oleg Nesterov <oleg@redhat.com>
References: <20240618071010.11214-1-yangtiezhu@loongson.cn>
 <20240619151524.GB24240@redhat.com>
 <9cc6d314-2431-c1b5-3d46-63c0ac80ed4d@loongson.cn>
 <20240620090807.GC30070@redhat.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <93d96e55-c180-444a-9b3f-f96db5f9e37d@loongson.cn>
Date: Thu, 20 Jun 2024 17:50:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240620090807.GC30070@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:AQAAf8BxmsZ1+3NmBTEqAA--.36373S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Jw43ZFyrAr4xKw4fWw47KFX_yoWkJrb_Kw
	4xAr97Gw1jkF13t3Z5tF1avFyqqr1DWw4rA3sFyrnrJ3savas5ur1rAryfWw1kJw12vrWq
	kr4vqF97Zr13ZosvyTuYvTs0mTUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbqkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j7BMNUUU
	UU=

On 06/20/2024 05:08 PM, Oleg Nesterov wrote:
> On 06/20, Tiezhu Yang wrote:
>>
>> On 06/19/2024 11:15 PM, Oleg Nesterov wrote:
>>>> --- a/include/uapi/linux/perf_event.h
>>>> +++ b/include/uapi/linux/perf_event.h
>>>> @@ -467,6 +467,7 @@ struct perf_event_attr {
>>>> 		__u32		wakeup_watermark; /* bytes before wakeup   */
>>>> 	};
>>>>
>>>> +	__u8			bp_priv;
>>>> 	__u32			bp_type;
>>>
>>> Is it safe to add the new member in the middle of uapi struct?
>>> This will break userspace...
>>
>> Let me put the new member "bp_priv" at the end of uapi struct
>> perf_event_attr in the next version if you are OK with it.
>
> And add PERF_ATTR_SIZE_VER9 ?

Yes, thank you.

> Well, you can safely ignore me, you should ask the maintainers ;)
>
> But to me the very idea of arm64-specific and "kernel only" member in
> perf_event_attr looks a bit strange.

I noticed that there is a similar arm64-specific change in
commit 09519ec3b19e ("perf: Add perf_event_attr::config3")
according to the commit message, and it will be used for
LoongArch later if this change is accepted.

Thanks,
Tiezhu

