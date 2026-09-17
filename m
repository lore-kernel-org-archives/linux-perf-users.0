Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7550C38331D
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 02:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611379; cv=none; b=Q1VtwmdXdfouGlgxNF6miqG1qtzrNo/3Rt/jQpIARLifKgC+ZmWFaN9DvRz0GsZXa5eteqRo6ZGOTYnKQWkB7oaNH8sxPEUIfKubEilHPMZ0wWvBQIUOJ8yxHUaECwCKWlIhVw9frWOakQAXqn00hPSHcxylCYA6FjQsWK3aQeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611379; c=relaxed/simple;
	bh=YSIHvWajymesgH5AeWt5kyqcHHXowrvsw/ZTno130NI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d9uqudk6FtS7vXwVKFs4ArO/oUbK//EHBzk9CRLP/M2xGPQ/Ie1zOSDP2+QWCWIs5yFFA8ut5B9z792KXZd/qLmcSRpy2TPIBuHf1Yz3tzych+osd+p9YXno2YJEULCFa79+qb6qL3wrvJx8km2FuMtTMDllqaync4eyQTe1w8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hlfVr5ddHzKHMT8
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 10:15:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 204A34056B
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 10:16:04 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgCnZ2xiTatqtrFSAg--.42473S2;
	Thu, 17 Sep 2026 10:16:04 +0800 (CST)
Message-ID: <65994196-8dd9-4477-9c4b-3fa485ad3071@huaweicloud.com>
Date: Thu, 17 Sep 2026 10:16:02 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 25/26] perf annotate-arm64: Support per-cpu variable
 access tracking
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <735c23b4a55db2c67be4920792922550ff4f6409.1789521520.git.wutengda@huaweicloud.com>
 <20260916015348.2114B1F000FF@smtp.kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260916015348.2114B1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgCnZ2xiTatqtrFSAg--.42473S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFWrXF4UJF15ur17ZF45trb_yoW8tr45pa
	95C3yrG34vqr4vq3ZayF4rXa4F9w17WFWY9ryrXFW7ZFySkrn7GrZ7Kr4UKFW8Wrsakw4U
	J39YqrWDX3WkCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
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



On 2026/9/16 9:53, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] perf: retry mechanism fails for per-cpu variable loads
> --
> 
> commit 0a8000b94df79930832d6fd4535fbe42f682b339
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf annotate-arm64: Support per-cpu variable access tracking
> 
> This commit extends update_insn_state_arm64() to handle per-cpu variable
> addressing. It detects pairs resolving to the '__per_cpu_offset' symbol
> and marks the destination register as TSR_KIND_PERCPU_BASE to propagate
> type information during subsequent instructions.
> 
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index b25a3c70675c1..f4b7b0eb44f42 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> [ ... ]
>> @@ -666,6 +677,12 @@ static int propagate_load_reg_state(struct type_state *state,
>>  	}
>>  
>>  load_non_regoff:
>> +	/*
>> +	 * If src_tsr->kind is TSR_KIND_PERCPU_BASE, treat it as an array.
>> +	 * No special handling is needed here; just fall through to retry
>> +	 * and resolve the type from the second register.
>> +	 */
>> +
>>  	/* Try another register if any */
>>  	if (src->multi_regs && src->reg1 != src->reg2 && sreg != src->reg2 &&
>>  	    !(src->extend_type || src->shift_type)) {
> 
> [Severity: Medium]
> Will this retry logic actually succeed for per-cpu variable loads?
> 
> Since both registers in the per-cpu load are non-constant
> (TSR_KIND_PERCPU_BASE and TSR_KIND_GLOBAL_ADDR), arch_get_reg_offset()
> returns -1 for both the initial attempt and the retry pass because it
> requires the 'other' register in a multi-register operand to be
> TSR_KIND_CONST.
> 
> Does this break the intended fallback logic here in
> propagate_load_reg_state(), resulting in an unhandled -1 return and
> silent type propagation failure?
> 

It looks like arch_get_reg_offset needs to be extended to recognize when
reg2 is TSR_KIND_PERCPU_BASE and set the offset to 0.

Thanks,
Tengda

