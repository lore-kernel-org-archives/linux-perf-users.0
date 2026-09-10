Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9757C48382C
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 12:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789042437; cv=none; b=GZau6eZPJPz8pGjK4LddEu93Pu4PUK03NoBsS6SmyonHzbqymHgd4yvNaORQ5F5eEjDV8l2SXN14BkUoc34qddaYzTAYSMoGZeBpZXVBrltvk/iIifxMz/3gPmwQVX+3uhrMPrVbRRXaILts+ixMRzOjgUM+JyrgHVwwLO9TbsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789042437; c=relaxed/simple;
	bh=S+RMQ2P/WFYm+Ioqqnx5D19p+rKsjBJ+FaK5hrvZpMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZaG4DHPETfvnEY/UnURgzs0WtxRt/4mMEcR/jqKlWaVepKDnZrZcbvBGLMvwlsxhVdYeCXeVBuppzUt2bk9sMj5hhsQB1RxRTMO4QjH9YNMhOPda+Jx4RrVdI5LajTPECbDFHgCUzm21AHc1+4Ruqk3IRFTXrbzn68iwnjlfng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hgc522vK9zYQwYM
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 20:12:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 4E54940574
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 20:13:49 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgBnJLL8nqJqH_PKBQ--.11031S2;
	Thu, 10 Sep 2026 20:13:49 +0800 (CST)
Message-ID: <b1686928-84e7-4b67-89ce-4166acd77491@huaweicloud.com>
Date: Thu, 10 Sep 2026 20:13:48 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/26] perf annotate-data: Add arch_get_reg_offset
 helper
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <e2d2dc36b2d8f600b339cf66880b10e611dbf9ab.1788872630.git.wutengda@huaweicloud.com>
 <20260908132222.90D9F1F00A3F@smtp.kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260908132222.90D9F1F00A3F@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgBnJLL8nqJqH_PKBQ--.11031S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDKw47Xw4DJryxCw45Wrg_yoW5trykpr
	Wku3W3JFyfXrsaqws2qa1DXFy8Ww4kGF4rGrZ5Ka47AryavFn3Ja1vyryYg3Z7Xr9rZw17
	JFn8trsrX3ZrCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgqb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVj
	vjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/9/8 21:22, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] The newly computed effective `offset` from `arch_get_reg_offset` is not propagated to `dloc->type_offset` before querying stack variables, breaking stack type tracking for indexed addressing modes on ARM64.
> - [Low] The debug logging variable `offset_sign` is not reset across loop iterations, causing positive offsets to be printed as negative.
> --
> 
> commit 090fc5d342fd0b37d2080a84b8472453f678a2e5
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf annotate-data: Add arch_get_reg_offset helper
> 
> Adds a helper to compute the effective offset from a base register
> for instruction operands. Currently handles arm64 addressing modes
> and falls back to the instruction's raw offset for other architectures.
> 
>> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
>> index c51b20a7af9b6..754c0efe2077e 100644
>> --- a/tools/perf/util/annotate-data.c
>> +++ b/tools/perf/util/annotate-data.c
> [ ... ]
>> @@ -1132,18 +1200,26 @@ static enum type_match_result check_matching_type(struct type_state *state,
>>  	Dwarf_Word size;
>>  	u32 insn_offset = dl->al.offset;
>>  	int reg = dloc->op->reg1;
>> -	int offset = dloc->op->offset;
>> +	int offset;
>>  	const char *offset_sign = "";
>>  	bool retry = true;
>>  
>> -	if (offset < 0) {
>> -		offset = -offset;
>> -		offset_sign = "-";
>> +again:
>> +	if (arch_get_reg_offset(dloc->arch, dloc->op, reg, state, false, &offset)) {
>> +		/*
>> +		 * Fall back to the instruction's offset. This prevents the
>> +		 * register type of the instruction from being completely lost.
>> +		 * Compared to dropping this type inference entirely, providing
>> +		 * a rough type hint is likely more useful.
>> +		 */
>> +		offset = dloc->op->offset;
>>  	}
>>  
>> -again:
>> +	if (offset < 0)
>> +		offset_sign = "-";
> 
> [Severity: Low]
> Does this code leave offset_sign set to "-" across loop iterations?
> 
> If check_matching_type() triggers a retry (goto again) after processing a
> negative offset, and the new offset for the retry is positive, offset_sign
> will still point to "-" instead of being cleared.
> 

Yes, it should be changed to:

  offset_sign = offset < 0 ? "-" : "";

> [Severity: Medium]
> Since this code now dynamically computes offset using arch_get_reg_offset(),
> is it necessary to update dloc->type_offset with this newly computed value?
> 
> Later in this function, during stack variable lookups, the code relies on
> dloc->type_offset:
> 
> tools/perf/util/annotate-data.c:check_matching_type() {
>     ...
>     check_non_register:
>         if (reg == dloc->fbreg || reg == state->stack_reg) {
>             ...
>             stack = find_stack_state(state, dloc->type_offset);
>     ...
> }
> 
> And similarly for CFA stack lookups:
> 
> tools/perf/util/annotate-data.c:check_matching_type() {
>     ...
>         stack = find_stack_state(state, dloc->type_offset - fboff);
>     ...
> }
> 
> If dloc->type_offset isn't updated to reflect the true effective offset
> calculated by arch_get_reg_offset(), will find_stack_state() end up
> using a stale or incorrect offset (e.g. 0 instead of the index offset) for
> stack-based array accesses on ARM64?
> 

Yes, dloc->type_offset should be replaced with the currently computed
offset when calling find_stack_state.

Thanks,
Tengda


