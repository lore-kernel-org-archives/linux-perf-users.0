Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C307EEB1;
	Wed, 19 Mar 2025 16:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742402446; cv=none; b=BRObtNhlyB4csLBymSLHHbpkTi5nQG/LDdFPRIfJkUT4SDM6HZlzt2M1itAOaqohJFwN7URPgL3PZRtNrS2SCGUE7LuT+QlvNNwLSfLonqsegzbsfzUyV858PW2skFGkOINbL+U7IFRRX0FN0bdCJo2aDrj0cwYp1v2JjpOlHvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742402446; c=relaxed/simple;
	bh=JrJZuwLoh4aqSlgAozvpLCYm9cpSeXuWTWgJoWvOwd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KsRuZqGV5gf1R8AH5B+Pv3tqXLZHGJ8mqhTLl9E859dNBZJK60orVSFOCPJqh8AJtTRGNDml5svUIzmrRDCneyDJWr8i05iBspwhPS8j1mipY+vKtL4AlXxAOzcZrBLD/nkPnoi/UHcYt8oV9CvKvnyuU56xezJCeAHxqyEdnVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 317DB113E;
	Wed, 19 Mar 2025 09:40:50 -0700 (PDT)
Received: from [192.168.20.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F11163F694;
	Wed, 19 Mar 2025 09:40:36 -0700 (PDT)
Message-ID: <83cf1b26-3a30-47fd-93e9-84903193bf07@arm.com>
Date: Wed, 19 Mar 2025 11:40:35 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] uprobes: Allow the use of uprobe_warn() in arch code
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 mhiramat@kernel.org, peterz@infradead.org, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 thiago.bauermann@linaro.org, broonie@kernel.org, yury.khrustalev@arm.com,
 kristina.martsenko@arm.com, liaochang1@huawei.com, catalin.marinas@arm.com,
 will@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250318204841.373116-1-jeremy.linton@arm.com>
 <20250318204841.373116-7-jeremy.linton@arm.com>
 <20250319145057.GA10753@redhat.com>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20250319145057.GA10753@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 3/19/25 9:51 AM, Oleg Nesterov wrote:
> On 03/18, Jeremy Linton wrote:
>>
>> --- a/include/linux/uprobes.h
>> +++ b/include/linux/uprobes.h
>> @@ -185,6 +185,7 @@ struct uprobes_state {
>>   };
>>   
>>   extern void __init uprobes_init(void);
>> +extern void uprobe_warn(struct task_struct *t, const char *msg);
>>   extern int set_swbp(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
>>   extern int set_orig_insn(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
>>   extern bool is_swbp_insn(uprobe_opcode_t *insn);
>> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
>> index b4ca8898fe17..613c1c76f227 100644
>> --- a/kernel/events/uprobes.c
>> +++ b/kernel/events/uprobes.c
>> @@ -118,7 +118,7 @@ struct xol_area {
>>   	unsigned long 			vaddr;		/* Page(s) of instruction slots */
>>   };
>>   
>> -static void uprobe_warn(struct task_struct *t, const char *msg)
>> +void uprobe_warn(struct task_struct *t, const char *msg)
>>   {
>>   	pr_warn("uprobe: %s:%d failed to %s\n", current->comm, current->pid, msg);
>>   }
> 
> Oh, no, please don't.
> 
> uprobe_warn() is ugly and needs changes. If nothing else it doesn't even use
> its "t" argument.

Ha, I didn't look that closely at it. That is basically the same bug 1/7 
here is fixing for the gcs task function!

This is in its own patch to allow it to be easily dropped, which is what 
will happen as I'm aware of previous variations of this discussion.

While Mark R's perspective is valid, it remains worthwhile to again 
point out that the uprobes subsystem (and a few like it) is a bit of a 
mystery box. Some of these error conditions are very opaque for a user 
who isn't also sufficiently familiar with uprobes to be able to both 
find the code as well as understand or instrument it when it tosses an 
error. Discoverability is made more difficult by the extensive use of 
inline/static. End users try to work around this. For example Brendan 
Gregg's perf-tools uprobe wrapper will dump the last two lines of the 
kernel log when it hits unexpected errors.

