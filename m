Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396FD2475D0
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 06:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782888336; cv=none; b=HVon1qcsZznzZP5ZhTlPEqIFra1sQYpsSLZHOT9uufd6LV6FKAg8ETPVyx3rJsl23/Cz/5UooPE/ZmcqwjeXnLk8lCDAj/sB9d7MleM/GjaD6EQa4UUnuYtwOzkUkDccvhP8BZ41q9opv6oSL6zwqAypyXcoiV9xUEcYOyhT+6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782888336; c=relaxed/simple;
	bh=fdmiJB7UFpv3tCmWb9VM3rH99iwsRmoRG84MmtdkYzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q/cOWaooSFhgsAwAkM7e6VpGVc4cpTrvCTaiG1ao+4eIdLq/Eiw3sF8t/tQFBIckQqwVAIsCQLcYQtErgA7iL1ZBJtZZNByHU+tGGVVLgdxHPu361Hhae9ThqYPNol5ithmJ3sG/uyGYuJk4J6EDNRwCPddj2pnUUwESfdMZB0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gqr9t0QkJzKHMNq
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 14:45:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4D3014057D
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 14:45:31 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgCXa4iLt0RqjtzNAQ--.10857S2;
	Wed, 01 Jul 2026 14:45:31 +0800 (CST)
Message-ID: <8a188481-d266-4155-915d-7aa621bebf2d@huaweicloud.com>
Date: Wed, 1 Jul 2026 14:45:30 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/21] perf llvm: Fix arm64 adrp instruction
 disassembly mismatch with objdump
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-4-wutengda@huaweicloud.com>
 <20260701040524.8D3F21F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260701040524.8D3F21F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgCXa4iLt0RqjtzNAQ--.10857S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFW5Gr4rtryUZr1kWr4Uurg_yoW8uF4Upr
	ZrCayUZ3WUCr1rWwnF9w4fZ3ZFkw4DXFy5Kr1ayw4FkryY9rn7KrWSyr1aka17Xr1jv39r
	Zwn09rWxuF1kA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1wL05UUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/7/1 12:05, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Missing explicit inclusion of <string.h> for POSIX string functions.
> --
> 
> commit c3571a268605b8e2ad28ebe5943729438021e5fe
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf llvm: Fix arm64 adrp instruction disassembly mismatch with objdump
> 
> This commit addresses an inconsistency between libllvm and objdump when
> parsing arm64 'adrp' instructions. It extracts the target address during
> callbacks and formats it as an absolute address with symbol names in
> symbol__disassemble_llvm().
> 
>> diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
>> index a0deb742a7331..533d47e8084d7 100644
>> --- a/tools/perf/util/llvm.c
>> +++ b/tools/perf/util/llvm.c
> 
> [ ... ]
> 
>> @@ -227,6 +241,42 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
>>  				free(name);
>>  			}
>>  		}
>> +		if (storage.pcrel_adrp_addr != 0) {
>> +			/*
>> +			 * ADRP (Address Page) instructions encode a 21-bit signed
>> +			 * immediate offset relative to the current PC's page.
>> +			 *
>> +			 * To maintain consistency with standard objdump output,
>> +			 * we truncate the raw encoded immediate at the comma
>> +			 * and replace it with the resolved absolute page address.
>> +			 *
>> +			 * Example conversion:
>> +			 * From: adrp x18, 8014
>> +			 * To:   adrp x18, ffff800081f5f000 <this_cpu_vector>
>> +			 */
>> +			char *name;
>> +			char *s = strchr(disasm_buf, ',');
> 
> [Severity: Low]
> Does this file need to explicitly include <string.h>?
> 
> This patch introduces a new use of strchr() here in
> symbol__disassemble_llvm(), but tools/perf/util/llvm.c lacks a direct
> inclusion of <string.h> at the top of the file.
> 
> While this might compile under glibc due to implicit header inclusion,
> missing explicit POSIX headers can cause build failures on systems
> using musl libc, which enforces strict namespace separation.
> 

Agreed.

>> +
>> +			if (s == NULL)
>> +				goto err;
>> +
>> +			s++;
>> +			*s = '\0';
>> +			disasm_len = strlen(disasm_buf);
> 
> [ ... ]
> 

