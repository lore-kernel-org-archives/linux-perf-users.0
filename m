Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6553D3310
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 01:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786671457; cv=none; b=XiWoy6zL/bzvZNQqwzMmq0JC/Qb+B5o9AnYNocKLunQ8kp7nD8ySb9kUfi3DPr7/gnh8CoywAj0k14rWZ1u226O3f+4vHF70Gzo01+G4NBq1lI7ZP5+VMAIViezT4M6rPWF6VHepnlU8bzOmpqKHzVabVubOCMCqHdE4tKVZAbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786671457; c=relaxed/simple;
	bh=KjGpWs4nH6cuCZ20Sw5FmOpYKwl6G8iGv710pL/BYeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ATgR8lNr1i08Mn4jlEyKALXnmOvwJAtOKthk12zgFgER/yz/vuBpcjQjygHurA9kgu9fuD5jln0mkd6/kwJn+6h/AZxOxT1qyid1YH2Kpj6/yelfEstcgCoRBAh1mlIg/lKD3qf8UAj9kqr/tbDXC3an/n3/qWmb2gvqbO5ke0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hLlG65GsNzYQtmJ
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 09:37:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 64BCA4058F
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 09:37:26 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgBHNtJVcX5qrnfsCA--.29353S2;
	Fri, 14 Aug 2026 09:37:26 +0800 (CST)
Message-ID: <98cf9eb2-5f17-46ac-bc05-8da3b2523534@huaweicloud.com>
Date: Fri, 14 Aug 2026 09:37:25 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/23] perf annotate-arm64: Support store instruction
 tracking
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-16-wutengda@huaweicloud.com>
 <20260808131105.778F91F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260808131105.778F91F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBHNtJVcX5qrnfsCA--.29353S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurWUZw43XFWDur17ZrWfAFb_yoW5GF1Dpa
	98C34rtr4jyr4qvrsxXF4FqFZF93WfG3WYkryjyws7ArWayFn3tFsxKa1akFW5JrZxAw1U
	tws0vr4DZ3y0kaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUglb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07UWHqcUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/8/8 21:11, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] For post-index addressing modes using a register offset (e.g., `ldr x0, [x1], x2` or `str x1, [x0], x2`), the base register's type state is incorrectly preserved instead of being invalidated.
> --
> 
> --- Patch [15]: [PATCH v4 15/23] perf annotate-arm64: Support store instruction tracking ---
> commit 5069bd6d8cc957f98ba504ae076e8ee35699d61a
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf annotate-arm64: Support store instruction tracking
> 
> This commit extends the arm64 update_insn_state() function to handle
> store (STR) instructions. It ignores the transfer itself since it won't
> change the type, but calls adjust_reg_index_state() to handle addressing
> modes for the destination register.
> 
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> 
> [ ... ]
> 
>> @@ -575,6 +575,17 @@ static void update_insn_state_arm64(struct type_state *state,
>>  	/* Memory to register transfers */
>>  	if (!strncmp(dl->ins.name, "ld", 2))
>>  		update_load_insn_state(state, dl, src, dst);
>> +	/* Register to memory transfers */
>> +	else if (!strncmp(dl->ins.name, "st", 2)) {
>> +		/*
>> +		 * Ignore transfers since it'd set a value in a struct
>> +		 * and won't change the type.
>> +		 *
>> +		 * Needs to update the pre-index and post-index addressing
>> +		 * modes for the destination register.
>> +		 */
>> +		adjust_reg_index_state(state, dst, "str", insn_offset);
> 
> [Severity: Medium]
> When using post-index addressing modes with a register offset (e.g., 
> "str x1, [x0], x2"), does adjust_reg_index_state() correctly invalidate 
> the base register's state?
> 
> Looking at adjust_reg_index_state() in the same file, when op_loc->multi_regs 
> is true (indicating a dynamic register offset), op_loc->offset is 0:
> 
> tools/perf/util/annotate-arch/annotate-arm64.c:adjust_reg_index_state() {
>     ...
> 	tsr->offset = op_loc->offset + tsr->offset;
>     ...
> }
> 
> Since op_loc->offset is 0 in this case, this seems to retain the old static
> offset instead of clearing the state via invalidate_reg_state().
> 
> Can this cause incorrect struct field attribution in the perf annotate 
> --data-type output for subsequent accesses using the modified base register?
> 

Agreed.

>> +	}
>>  }
>>  #endif
> 

