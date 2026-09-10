Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE493DB324
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 09:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032020; cv=none; b=gxYabNZ/YqBUSrRSdQ3Y6/vUEzsSRYQgft4x7OHZhbMli/xI5AcfaLAqgPibczo7MeMQUFauLR7AASyPiIdIhv7kSN3FGxEoPd6KnQ5ku5tN1IqLmBM5SflOcg0QGH0OeGjmoNbnPw+w0f+K1XezsRWWi5F0FaGTI2bOEW6UDGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032020; c=relaxed/simple;
	bh=4SCZc+ws4E3aN280uV+2yBeaWm4QOP9aLcyCPUU+MxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fMPaItLtMW64NmY0g8/aWIqlRjoSp1ip25dzwQkPlO8Z+piYwpo6fFCo1lLDjTjQPLZ+/78FcpZHTaJwFo/poe1rzy6ks2FOMQ7iEcv6KJ0HSx9+0m7iAG1rp7kxfjNOQyE/SuPuna01et34lvIVsQV1CKW0ujcoM1S4cpwoIl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hgXDg4bJHzYQwm4
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 17:19:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 5309540574
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 17:20:10 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgCnGbdJdqJqtP+7BQ--.2389S2;
	Thu, 10 Sep 2026 17:20:10 +0800 (CST)
Message-ID: <75561a39-3335-48bc-baed-21b8f64308c4@huaweicloud.com>
Date: Thu, 10 Sep 2026 17:20:09 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/26] perf annotate-arm64: Enable instruction tracking
 support
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <8ff5cfde0aad3d585b34f177fd87e8ec57ba4fa1.1788872630.git.wutengda@huaweicloud.com>
 <20260908131825.2DD131F00A3D@smtp.kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260908131825.2DD131F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgCnGbdJdqJqtP+7BQ--.2389S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDtr4xAr1fCF1DZr4UCFg_yoWrXFWDpa
	y7u3y3JF1UJr4jywnxXa18XFySgr13Xay3Crs8tr1SyFs29r93tF4DKFWYqay7Ar1kCw4U
	Zw4qqFWDAws7C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgqb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVj
	vjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/9/8 21:18, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Incomplete initialization of ARM64 caller-saved registers in init_type_state() misses x30 (Link Register) and x18. According to the ARM64 AAPCS64 ABI, x30 is intrinsically caller-saved (it is clobbered by function calls to store the return address), and x18 is also a temporary/caller-saved register (unless strictly reserved by a platform ABI). Because these registers are omitted during initialization, their `caller_saved` flags remain `false`. Consequently, their data type states are not invalidated across function calls, allowing stale type info to erroneously propagate.
> --
> 
> commit 7f29650747bf4bd656328dd491ef0f827ab60d8c
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf annotate-arm64: Enable instruction tracking support
> 
> Enable basic instruction tracking for arm64 by implementing three
> essential functions in the find_data_type_block() call path. This
> allows arm64 to support basic variable type inference during
> instruction tracking.
> 
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index d8a5904359b1a..8fda4d4d68887 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> [ ... ]
>> @@ -442,6 +446,77 @@ static void extract_op_location_arm64(const struct arch *arch,
> [ ... ]
>> +	if (ins__is_call(&dl->ins)) {
>> +		struct symbol *func = dl->ops.target.sym;
>> +		const char *call_name;
>> +		u64 call_addr;
>> +
>> +		call_name = func ? func->name : dl->ops.target.name;
>> +		pr_debug_dtp("call [%x] %s\n", insn_offset, call_name ?: "<unknown>");
>> +
>> +		/* Invalidate caller-saved registers after call */
>> +		call_addr = map__rip_2objdump(dloc->ms->map,
>> +					      dloc->ms->sym->start + dl->al.offset);
>> +		for (unsigned int i = 0; i < ARRAY_SIZE(state->regs); i++) {
>> +			struct type_state_reg *reg = &state->regs[i];
>> +
>> +			if (!reg->caller_saved)
>> +				continue;
> 
> [Severity: Medium]
> Because x30 and x18 are omitted from being marked as caller-saved during type
> state initialization, their caller_saved flags will be false.
> 
> Are these registers unintentionally skipped here, preventing them from being
> invalidated across function calls?
> 
>> +			/* Keep register valid within DWARF location lifetime */
>> +			if (reg->lifetime_active && call_addr < reg->lifetime_end)
>> +				continue;
>> +			invalidate_reg_state(reg);
>> +		}
>> +		return;
>> +	}
> [ ... ]
>> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
>> index 104b80d471f1b..c51b20a7af9b6 100644
>> --- a/tools/perf/util/annotate-data.c
>> +++ b/tools/perf/util/annotate-data.c
> [ ... ]
>> @@ -178,6 +179,13 @@ static void init_type_state(struct type_state *state, const struct arch *arch)
>>  		state->regs[11].caller_saved = true;
>>  		state->ret_reg = 0;
>>  		state->stack_reg = X86_REG_SP;
>> +	} else if (arch__is_arm64(arch)) {
>> +		int i;
>> +
>> +		for (i = 0; i < 18; i++)
>> +			state->regs[i].caller_saved = true;
> 
> [Severity: Medium]
> According to the ARM64 AAPCS64 ABI, x30 (Link Register) is intrinsically
> caller-saved since it is clobbered by function calls to store the return
> address.
> 
> x18 is also typically a temporary/caller-saved register unless strictly reserved
> by a platform ABI.
> 
> This loop halts at 17, failing to set the caller_saved flag for x18 and x30.
> 
> Could this omission allow stale data type information for these registers to
> erroneously propagate across function calls?
> 

x18 does need to be set as caller-saved, but x30 is not really necessary, because
it generally serves as LR and is not used to carry data type information.
So I'm going to add only x18.

Thanks,
Tengda

