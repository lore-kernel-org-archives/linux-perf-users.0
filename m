Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314701DB92C
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 02:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786415851; cv=none; b=BgBmXJXIo1v3OszFvujB5Dz4WeOInlBB7Dbb6i6TPytoLP+ap0yDXCYFTYTj4+Ddr6/WGIv6euAanIFP7wPreVm8B8Q4/GG1cXqdJ1m2zCbOpZ+l5ChDt0Hfg7HDC2aAIbbDEZJm7/6UVL31XWsjrPh0hxS4xrToOEothPrWXK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786415851; c=relaxed/simple;
	bh=cfLv9BWa1ACYiLkcRQkRu+Sun7RHvrPhFp596jTISs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TNBFzWj9PXcm7gCH9lyhqbM1wssTbg7Vp/YLQtFT8Os08KhIMZJAqHigRr3fimdaq6TjUNJDD5E8T1wzPr+jpFQwXr9JlOQDZOTmuUrmfQQAtYOvbb3WlrhhQXj1AXIhM26uiOXEW/RHUZsYzvxnSy4UCjr/iucqdzDW0lmQDW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hJwkn2Z05zYQtgS
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 10:37:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E73BB40858
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 10:37:23 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgA3oYjiinpq2iKNBw--.51630S2;
	Tue, 11 Aug 2026 10:37:23 +0800 (CST)
Message-ID: <cf4fac8a-925d-4cf4-b58d-1138ed27b692@huaweicloud.com>
Date: Tue, 11 Aug 2026 10:37:22 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/23] perf llvm: Fix arm64 adrp instruction
 disassembly mismatch with objdump
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-3-wutengda@huaweicloud.com>
 <20260808130329.EA6F31F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260808130329.EA6F31F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgA3oYjiinpq2iKNBw--.51630S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFW5tFWxuFy5Ar4kur13twb_yoW8tw17pF
	ZxCa93XFy8Jrn5Zw4j9w4xXFn3Cw4qqFW5Kr45Z3y8Cr13CFn3ur1fGF12kan7XrnYy39I
	yrs09FyUGFn5AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1wL05UUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/8/8 21:03, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Memory leak of the dynamically allocated string `name` on an error path if a comma is missing in the disassembled instruction, which also brittly aborts the entire disassembly process.
> --
> 
> --- Patch [2]: [PATCH v4 02/23] perf llvm: Fix arm64 adrp instruction disassembly mismatch with objdump ---
> commit d33f174b93415a7430f8bf32e53bbf77ad2fce9a
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf llvm: Fix arm64 adrp instruction disassembly mismatch with objdump
> 
> This commit addresses an inconsistency where libllvm parses arm64 adrp
> operands as raw immediates instead of the address format used by objdump.
> It extracts the target address and resolves the symbol, reformatting the
> disassembly output to match objdump's expectations.
> 
>> diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
>> index a0deb742a7331..6b53b283205ab 100644
>> --- a/tools/perf/util/llvm.c
>> +++ b/tools/perf/util/llvm.c
> 
> [ ... ]
> 
>> @@ -230,10 +242,40 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
>>  		if (storage.pcrel_load_addr != 0) {
>>  			char *name = llvm_name_for_data(dso, filename,
>>  							storage.pcrel_load_addr);
>> -			disasm_len += scnprintf(disasm_buf + disasm_len,
>> -						sizeof(disasm_buf) - disasm_len,
>> -						"  # %#"PRIx64,
>> -						storage.pcrel_load_addr);
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
> Does this leak name if a comma isn't found in the disassembled instruction?
> 
> Looking at symbol__disassemble_llvm(), name is allocated earlier in this
> block via llvm_name_for_data(). If strchr() fails and the code jumps to the
> err label, name appears to be leaked since the err cleanup path only frees
> code_buf and line_storage.
> 

Sorry, that was a careless mistake. Will fix it right away.

-- Tengda

