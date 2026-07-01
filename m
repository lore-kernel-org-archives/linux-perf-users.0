Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4777A3B47FB
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 07:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782890084; cv=none; b=Kxmb1F5hGx0rVcydySi9iRSG1tmdQ39N+1hoJoyRXs0wE8HPfX8jmDLN/DMceAbEN3e8u3G0ihYE/++soro5cTLNdRlH7CatefJFBp36lkQPVH74uZ1MF7cpocQ94dordIP4ZB5mUdCsGiYXPlewWqO5fbK0NRJxe39swVU+G+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782890084; c=relaxed/simple;
	bh=ntw86OCJJ8VS1nZ/ZmnJHtCmwScX3OhjQHQohyo7YC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=saWV2eqv3LQF2aO7xcBWEE5Znck5cSXfkn/DpXMA4TQpe614Yv5WUSbwenQ8oizw1Uq26U9n7Sn44SuMTo1RU6eHPp4cWszTz6WYGRtzcAcl4UlsDXjC531x5ryuPj7jO+dTUISqtyxEcS0ZXnHgBMa7A8FIa8R4/zKgjCmyqoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gqrpX4gcGzYQtL7
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 15:13:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BDF1B4056E
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 15:14:34 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgD3y4hZvkRq80zQAQ--.12803S2;
	Wed, 01 Jul 2026 15:14:34 +0800 (CST)
Message-ID: <4cf0c354-5546-45e6-9c1b-343a008f637f@huaweicloud.com>
Date: Wed, 1 Jul 2026 15:14:33 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/21] perf dwarf-regs: Adapt get_dwarf_regnum() for
 arm64
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-7-wutengda@huaweicloud.com>
 <20260701040723.B7C4F1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260701040723.B7C4F1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgD3y4hZvkRq80zQAQ--.12803S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurWUWw4xXryDWw15tF15twb_yoW5Cr1Dpa
	17CwnrJ3yqgr1jqw43AF4fWFyUW393Zr45ZryDJ3s7Crs09Fyxtw17tF45CFW8A34DAw10
	v3yjgr18uws5AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUglb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07UWHqcUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/7/1 12:07, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Medium] The zero registers ('wzr' and 'xzr') are incorrectly mapped to DWARF register 31.
> - [Medium] The link register ('lr') alias is no longer recognized and will unexpectedly return -ENOENT.
> - [Low] The functions strcmp and strtol are used without explicitly including <string.h> and <stdlib.h>.
> --
> 
> commit cf10eca9678152514cc1354dc6997be3eec9f436
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf dwarf-regs: Adapt get_dwarf_regnum() for arm64
> 
> This commit replaces the static string table lookup for arm64 DWARF registers
> with a programmatic implementation in __get_dwarf_regnum_arm64(). This allows
> resolving register names directly into their corresponding DWARF numbers
> during annotation.
> 
>> diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c b/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c
>> index 593ca7d4fccca..be55fc2a4f385 100644
>> --- a/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c
>> +++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c
>> @@ -1,5 +1,6 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>  #include <errno.h>
>> +#include <ctype.h>
> 
> [Severity: Low]
> Does omitting the explicit includes for <string.h> and <stdlib.h> break the
> build on musl libc? 
> 
> This file now uses strcmp() and strtol() below, and musl strictly separates
> declarations without relying on implicit inclusions.
> 

Agreed. Will add them.

>>  #include <dwarf-regs.h>
>>  #include "../../../arch/arm64/include/uapi/asm/perf_regs.h"
> 
> [ ... ]
> 
>> +int __get_dwarf_regnum_arm64(const char *name)
>> +{
>> +	int reg;
>> +
>> +	if (!strcmp(name, "sp") || !strcmp(name, "wzr") || !strcmp(name, "xzr"))
>> +		return 31;
> 
> [Severity: Medium]
> Does this incorrectly map the zero registers (wzr and xzr) to DWARF
> register 31?
> 
> The AArch64 DWARF ABI assigns register 31 strictly to the stack pointer (sp),
> and zero registers have no valid DWARF mapping.
> 
> Mapping wzr and xzr to 31 might cause perf annotate to conflate operations on
> the zero register with stack pointer operations, leading to incorrect stack
> variable tracking and type profiling statistics.
> 

The current data type profiling implementation doesn't actually use these
register mappings. I'll simply remove them in the next revision to avoid
any confusion.

>> +
>> +	if (*name != 'x' && *name != 'w')
>> +		return -ENOENT;
> 
> [Severity: Medium]
> Will this strict prefix check reject the link register alias lr?
> 
> The previous static table lookup correctly mapped lr to register 30.
> Because lr does not start with x or w, it appears this will now return
> -ENOENT, which might break data type tracking for instructions that operate
> on the link register.
> 

I haven't observed `lr` in objdump disassembly so far. I'll leave it
as-is for now and revisit if we encounter real cases.

