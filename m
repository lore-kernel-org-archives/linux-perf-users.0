Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C33381B1A
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 02:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789527111; cv=none; b=m9+PjbwFgdIVKNB1VGQ+NfPsFxy0Ohhlw20z6BVEGhpY4CqbwJnGjiO9YKzX2NSP/JXJP3Ae1DUmV7stwcTbzKh5LcNVAfbs9IIK2M01H/8RyTmj7RIprxbcStydosaRXkQxOFsv49nKQkcg3of1WlpGTmD7qtAX4k9YmMgHuQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789527111; c=relaxed/simple;
	bh=06gKiNVc1QrDhEqs1eL0c9nkajXFAE9ETqo3O0UxMwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oYMWMGWHUfChF5zVKGWgWLvYHOPiQf6wOOY5GVpHtr1qmdHTXRhl+G1JEsoxnBZOGkNslrgWT50zPaBiRyBe5qqbnkcdNBgIArV3iJ+1IBSzH9hI9x8rITdrotikfW1KPD8NFl1sup2fLbdqkKnuvFxyN2OL4/+4E95EFt3bd7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hl3Lh3xkczYQtlM
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 10:51:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id C259540576
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 10:51:44 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgB3OW4_BKpqCcXZAQ--.45614S2;
	Wed, 16 Sep 2026 10:51:44 +0800 (CST)
Message-ID: <205dd76b-4d9e-46d3-b302-6c8e521511e2@huaweicloud.com>
Date: Wed, 16 Sep 2026 10:51:43 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/26] perf llvm: Fix arm64 adrp instruction
 disassembly mismatch with objdump
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <63d15af66450065329b08f41794738c2e8c811ab.1789521520.git.wutengda@huaweicloud.com>
 <20260916014303.D5A931F00898@smtp.kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260916014303.D5A931F00898@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgB3OW4_BKpqCcXZAQ--.45614S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDGw4UZrW7KrW8uFWDCFg_yoW5uFy3pF
	n7CaykWFyxArsYvwnF9r4xXF13A39xKFW5Wr45CrWFkrs8Cr1xJr4fKrW29asrXrn5Z3yY
	vrWqvFyDAF1kArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUglb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVF
	xhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/9/16 9:43, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] perf: arm64 pcrel load formatting failure aborts disassembly
> --

Interesting. In the v5 version, Sashiko reviewed and approved this patch.

> 
> commit ad5ee451ad40bd108c85e2fea401d911d9304dee
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf llvm: Fix arm64 adrp instruction disassembly mismatch with objdump
> 
> This commit fixes an inconsistency in how libllvm parses arm64 adrp
> instructions by manually extracting the target address via
> symbol_lookup_callback(). The extracted address is then converted to match
> objdump's format, ensuring compatibility with existing parsers.
> 
>> diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
>> index a0deb742a7331..a78845689aa1c 100644
>> --- a/tools/perf/util/llvm.c
>> +++ b/tools/perf/util/llvm.c
> [ ... ]
>> @@ -228,12 +240,42 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
> [ ... ]
>>  		if (storage.pcrel_load_addr != 0) {
>> -			char *name = llvm_name_for_data(dso, filename,
>> +			char *name;
>> +
>> +			if (arch__is_arm64(args->arch)) {
>> +				/*
>> +				 * For arm64, replace the immediate operand with
>> +				 * the resolved address to match objdump's output.
>> +				 *
>> +				 * Example conversion:
>> +				 *   From: adrp  x18, 8014
>> +				 *   To:   adrp  x18, ffff800081f5f000
>> +				 */
>> +				char *s = strchr(disasm_buf, ',');
>> +
>> +				if (s == NULL)
>> +					goto err;
> 
> [Severity: Medium]
> Could this error path escalate a minor string formatting mismatch into a
> complete failure of the disassembly operation?
> 
> If an ARM64 instruction triggers a PC-relative load but its disassembled
> text lacks a comma (e.g., due to an unexpected mnemonic format from LLVM,
> or data incorrectly decoded as an instruction)

Is such a possibility actually possible? At least so far I haven't seen it.
If it does exist, it should probably be considered an LLVM bug?

                                                , strchr() returns NULL and
> triggers this abort.

The abort should be the expected behavior; otherwise, this problem would be
silently propagated to the arm64_mov__parse stage, making it hard to detect.

> 
> Because the error path in symbol__disassemble_llvm() fails to clean up
> partially populated lists, aborting the disassembly here discards the LLVM
> disassembly for the function. When the fallback disassembler takes over,
> this leaves interleaved, corrupted disassembly lines and causes a memory
> leak.
> 

This should be referring to here:

symbol__disassemble_llvm:
		llvm_addr2line(filename, pc, &args->fileloc,
			       (unsigned int *)&args->line_nr, false, NULL);

		dl = disasm_line__new(args);
		if (dl == NULL)
			goto err;  // args->fileloc is not freed

		annotation_line__add(&dl->al, &notes->src->source);

		free(args->fileloc);

This is a pre-existing issue. Currently it does not affect this patch, because
when this patch does goto err, llvm_addr2line has not been called yet. So I will
*keep this patch unchanged* and submit a separate patch to fix this issue.

Thanks,
Tengda

>> +
>> +				s++;
>> +				*s = '\0';
>> +				disasm_len = strlen(disasm_buf);
>> +				disasm_len += scnprintf(disasm_buf + disasm_len,
>> +							sizeof(disasm_buf) - disasm_len,
>> +							" %"PRIx64,
>>  							storage.pcrel_load_addr);
> [ ... ]
> 

