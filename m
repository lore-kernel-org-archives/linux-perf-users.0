Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407454A4EEF
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 08:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791967438; cv=none; b=cWnAXX3w51C8SjVTiB/PCuPhEcKneUEFSpm+6pL51r8le6gSAh+ATYtkL1m+FgKrZMTEN91ZSvay0btkpSYAOjY+A38RwvQdnrvj1cfYCwAsxfD+zuEKv4k285FnG/d3d9xpbkt0PviqEyr9op9deS9moHkuJZ8y2+XiaVSBqbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791967438; c=relaxed/simple;
	bh=sAaVW0Mv3JknQcPFPCt09Wnvobj8sQA3tanlq10VrwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wf+RMUgOCaBUZOOwlHPxbpxyOcShOn1TLruHA68Np1H7KXcdE9rOtgz1qo0cOYYxl/rvaAa8YDKhvivkHvgCWE4Xfg9clxUh2ZzAMNpSCsNBhEJrgPxbeaTLDphjJFmrtj3pOoxg6fJ/Lkm02QisD5rj+IDpXdMT9M7M85kf0B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4j4Pq12nMkzKHMbd
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 16:42:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 7119040576
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 16:43:53 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgC3PPK_QM9qJSiRAQ--.18858S2;
	Wed, 14 Oct 2026 16:43:53 +0800 (CST)
Message-ID: <c9f7d080-7e54-4ea8-90fd-4b3017a1f576@huaweicloud.com>
Date: Wed, 14 Oct 2026 16:43:43 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/15] perf annotate-arm64: Support store instruction
 tracking
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <cover.1791629326.git.wutengda@huaweicloud.com>
 <eb44bbf4b74555bc43f3659f4733faff403debbf.1791629326.git.wutengda@huaweicloud.com>
 <sashiko-outbox-169829@kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <sashiko-outbox-169829@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgC3PPK_QM9qJSiRAQ--.18858S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDAr4xCFW8CF13AF4fZrb_yoW5uw13pr
	98Cw1rKa1Utr40qFn3XF4j9r9xua1ft39rCr1Dt397ArsFkr93Krn3KayagFWUJr98uw1U
	tF4v9rn7WFWFyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/10/13 21:36, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] perf annotate-arm64: Stale type tracking on status register in exclusive stores
> --
> 
> commit e02fcbc321646663dec228cbae05f99e569cc5a5
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf annotate-arm64: Support store instruction tracking
> 
> Extend update_insn_state_arm64() to handle standard store instructions
> (str, stur, stlr, stp). Exclusive stores (e.g., stxr, stxp) are omitted
> as they exhibit different operand semantics. The patch also updates
> pre-index and post-index addressing modes for the destination register.
> 
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index fb48bf95b32ff..54d9928b536fd 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
>> @@ -661,6 +661,20 @@ static void update_load_insn_state(struct type_state *state,
>>  	adjust_reg_index_state(state, dloc, dl, src);
>>  }
>>  
>> +/*
>> + * Match standard store variants (str, stur, stlr, stp) that follow
>> + * straightforward store semantics: source registers on the left (read-only)
>> + * and memory target on the right. Excludes exclusive stores (stxr, stxp, etc.)
>> + * which have status/result register side effects.
>> + */
>> +static bool is_standard_store_insn(const char *name)
>> +{
>> +	return !strncmp(name, "str", 3)  ||  /* str, strb, strh */
>> +	       !strncmp(name, "stur", 4) ||  /* stur, sturb, sturh */
>> +	       !strncmp(name, "stlr", 4) ||  /* stlr, stlrb, stlrh */
>> +	       !strncmp(name, "stp", 3);     /* stp */
>> +}
> 
> [Severity: Medium]
> Will this result in stale type tracking for the status registers modified
> by exclusive store instructions?
> 
> Since exclusive stores like stxr are excluded here, they fall through and
> are ignored.  However, because arm64__insn_is_target_on_right("stxr")
> places the memory operand in dst (so dst->mem_ref is true), the generic
> invalidation block in update_insn_state_arm64() is also completely bypassed:
> 
> 	if (has_reg_type(state, dst->reg1) && !dst->mem_ref &&
> 	    !is_standard_load_insn(dl->ins.name)) {
> 		...
> 
> For an instruction like "stxr w0, x1, [x2]", the CPU modifies the status
> register (w0, parsed into src->reg1). Since it skips both standard store
> processing and the generic invalidation block, does the tracker leave the
> status register's type state unaltered and allow stale types to propagate?
> 

Yes, indeed. And instructions like swp and cas may have the same problem. I'll fix it.

Tengda

> [ ... ]
> 
>> @@ -742,6 +756,17 @@ static void update_insn_state_arm64(struct type_state *state,
>>  	/* Memory to register transfers */
>>  	if (is_standard_load_insn(dl->ins.name))
>>  		update_load_insn_state(state, dloc, dl, src, dst);
>> +	/* Register to memory transfers */
>> +	else if (is_standard_store_insn(dl->ins.name)) {
>> +		/*
>> +		 * Ignore transfers since it'd set a value in a struct
>> +		 * and won't change the type.
>> +		 *
>> +		 * Needs to update the pre-index and post-index addressing
>> +		 * modes for the destination register.
>> +		 */
>> +		adjust_reg_index_state(state, dloc, dl, dst);
>> +	}
>>  }
>>  #endif
>>
> 

