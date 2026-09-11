Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D98F37F30B
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2026 01:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789090889; cv=none; b=eJrg3HwKb3aImhg+YNI5K/GE8PDAAsRa6MnBZko0009zyVZVHybnesg/Nma5fKN0MsEPYkFDOjTaDphBZp3lEG6QKAtkhdIRoemPJ942OLgaEx2j/cbHGQrXyefk7RU+m0gBcWmJXSgSWSXlwNTK5NwG7DmLcY+RcY/aCX4LdNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789090889; c=relaxed/simple;
	bh=3J/d6P85kTIhEeifbnE/N524lRDfjIyBwMPaPH08xA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i0iIc1u7gWeLMZHFv8QjumhszsAb2Egt2HWu9GQx9Z2cVENndEtQxLXBwD1Ai6kALLTSCSdLI492chzeTJlOaXXCEvpFCTqtS4upS3Qgb/tqT7EcdS0V65FuNEaCOZE5k3fpg9I9ZHqxR7dU64K2/ftAFssJv7v8zhGkWec9hLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hgy1k0j5XzKHMN5
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2026 09:41:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 85E844058D
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2026 09:41:19 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgDXOpg+XKNqxK8jBg--.35142S2;
	Fri, 11 Sep 2026 09:41:19 +0800 (CST)
Message-ID: <42b259e3-7e58-4164-bd2d-83bf7e9699dd@huaweicloud.com>
Date: Fri, 11 Sep 2026 09:41:18 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 21/26] perf annotate-arm64: Support stack variable
 tracking
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <ddc32af9368f031ed716cf86b50a8bce79e87796.1788872630.git.wutengda@huaweicloud.com>
 <20260908133633.666091F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260908133633.666091F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDXOpg+XKNqxK8jBg--.35142S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurykZF1UCrykWF4UJw15CFg_yoW5Xr48pr
	srGay3GF4rGr4rtws3XrW8Xr9Ygwn7GF4Y9wn8JF1Fyr1S9FnakFZxtFy3Kay7Xr93uw40
	vw1q9rnrXws7ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/9/8 21:36, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Invalid register comparison causes unparsed operands to be falsely treated as stack variables.
> --
> 
> commit 7ef0e34126bb69c05756eba7378c5775c6ea2fd3
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf annotate-arm64: Support stack variable tracking
> 
> This commit extends update_insn_state_arm64 to track data types stored on the
> stack. It handles stack loads and stores, introducing
> propagate_store_reg_state to follow data types between registers and memory.
> 
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index 9d43e2c2041cd..d520975c59363 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
>> @@ -542,12 +544,57 @@ static int propagate_load_reg_state(struct type_state *state,
> 
> [ ... ]
> 
>> +	if (dloc->fb_cfa) {
>> +		u64 ip = dloc->ms->sym->start + dl->al.offset;
>> +		u64 pc = map__rip_2objdump(dloc->ms->map, ip);
>> +
>> +		if (die_get_cfa(dloc->di->dbg, pc, &fbreg, &fboff) < 0)
>> +			fbreg = -1;
>> +	}
>> +
>>  retry:
>>  	if (arch_get_reg_offset(dloc->arch, src, sreg, state, false, &reg_offset))
>>  		return -1;
>>  
>>  	reg_offset += mem_offset;
>>  
>> +	/* Check stack variables with offset */
>> +	if (sreg == fbreg || sreg == state->stack_reg) {
> 
> [Severity: Medium]
> When an unparsed or unsupported base register leaves sreg as -1, and fbreg is
> also -1, does this condition evaluate to true? Could this cause unparsed
> source operands to be incorrectly treated as stack loads?
> 

Agreed.

> [ ... ]
> 
>> +static void propagate_store_reg_state(struct type_state *state,
>> +				      struct data_loc_info *dloc,
>> +				      struct disasm_line *dl, int sreg,
>> +				      struct annotated_op_loc *dst,
>> +				      int mem_offset)
>> +{
> 
> [ ... ]
> 
>> +	if (dloc->fb_cfa) {
>> +		u64 ip = dloc->ms->sym->start + dl->al.offset;
>> +		u64 pc = map__rip_2objdump(dloc->ms->map, ip);
>> +
>> +		if (die_get_cfa(dloc->di->dbg, pc, &fbreg, &fboff) < 0)
>> +			fbreg = -1;
>> +	}
>> +
>> +	/* Check stack variables with offset */
>> +	if (dreg == fbreg || dreg == state->stack_reg) {
> 
> [Severity: Medium]
> Similarly to the load case, if the base register extraction leaves dreg as -1
> and fbreg is also -1, does this check evaluate to true? Will this erroneously
> treat unparsed target operands as stack stores, potentially corrupting the
> stack type state tracking?
> 

Agreed. It would be best to add a guard for when dreg is not -1.

Tengda

