Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10320538D8C
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 12:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872059; cv=none; b=gynQRMZykZK9WJDWshIGAUWw2JMUrzVSXKokQEhlIKA+KiQtG75Cb1VzzByTzfOCpCM/kICSxRFPOiB5wfGFOdBmoQwZ8xQzDEN4sYqn+VW3PcruyuJBHxYxFr7JGe2Q7NOQsF2g3S7rv88zj+9OlnUxwPQq5XfMd1UDb70NmUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872059; c=relaxed/simple;
	bh=3jB6/Lrb4opuV/PlEwZYYO/Th8d/1YQ2akkQifnRBPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S9+/vnGb+UdDyxRimpEQrsjNuovpPjF/H+LNhEZbivtnQ73q60b3zjimayC8hCnF3k4m9AzxOAeHSlGqoGOnrL7Bg4JYUTOT6tTqVlbQ5wjo4vHyYUlYO4pmKgRo6xyFgI7KtmJJWDsRfPTOjfyr7AYUjysQECW6ex+iTDcJpTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hfP4X4CY4zYQvQ9
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 20:53:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 193E640573
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 20:54:08 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgBnJLJuBaBqsgvVBA--.24379S2;
	Tue, 08 Sep 2026 20:54:08 +0800 (CST)
Message-ID: <8a17cd45-388b-4bdd-9389-018e53fe4957@huaweicloud.com>
Date: Tue, 8 Sep 2026 20:54:06 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 23/23] perf annotate-arm64: Support 'mrs' instruction
 to track 'current' pointer
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-24-wutengda@huaweicloud.com>
 <20260808132051.7F4261F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260808132051.7F4261F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgBnJLJuBaBqsgvVBA--.24379S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuw4rJrWfJr15Jw48GFy8Zrb_yoW7KF45pa
	9ak34UtF15Xa1kKwnFqr48ZrySg395W3W5Kwn5tw1IyF4S9r1xtF98t3W5Cay3Arn8uw42
	vF4qqr47Aw1vvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/8/8 21:20, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [High] The global `task_struct_cache` may permanently cache a DWARF offset for an incomplete forward declaration of `struct task_struct`, breaking task tracking globally.
> - [High] The globally static `task_struct_cache` caches a raw `Dwarf *` pointer as a validation key, which is susceptible to an ABA problem when DWARF handles are recycled, leading to corrupt DWARF parsing.
> - [Medium] Calling `die_find_inlinefunc()` with a Compilation Unit DIE (`cu_die`) instead of a Subprogram DIE (`sp_die`) causes a severe O(N) recursive DWARF tree traversal.
> - [Medium] Caching the DWARF offset of `struct task_struct *` relies on a brittle non-deterministic order dependency, silently failing for compiler-generated code like stack canaries.
> - [Low] Missing explicit inclusion of `<strings.h>` for `strcasecmp()`, which violates subsystem guidelines and causes build failures on musl libc.
> --
> 
> --- Patch [23]: [PATCH v4 23/23] perf annotate-arm64: Support 'mrs' instruction to track 'current' pointer ---
> commit 9ea98019ec4e55f722077c51c12557f82e4d5f60
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf annotate-arm64: Support 'mrs' instruction to track 'current' pointer
> 
> This commit extends the arm64 instruction state tracker to handle mrs
> instructions reading from sp_el0. It attempts to track the current
> task pointer by locating the get_current() inline function and caching
> the struct task_struct DWARF offset for subsequent resolution.
> 
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index b01fa6cf865ff..9d1f315dcb280 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> 
> [ ... ]
> 
>> @@ -889,6 +890,96 @@ static void update_adrp_insn_state(struct type_state *state,
> 
> [ ... ]
> 
>> +	/* Handle case difference: LLVM (SP_EL0) vs objdump (sp_el0) */
>> +	if (!dso__kernel(map__dso(dloc->ms->map)) ||
>> +	    strcasecmp(dl->ops.source.raw, "sp_el0")) {
> 
> [Severity: Low]
> Is the <strings.h> header missing for strcasecmp()?
> 
> Building perf with musl libc requires explicit inclusion of POSIX headers,
> and omitting <strings.h> can cause musl build failures.
> 
>> +		invalidate_reg_state(tsr);
>> +		return;
>> +	}
> 
> [ ... ]
> 
>> +	/*
>> +	 * Invalidate cached DIE offset if the debug info handle changed
>> +	 * (e.g. switching between vmlinux and a kernel module).
>> +	 */
>> +	if (task_struct_cache.dbg != dloc->di->dbg) {
>> +		task_struct_cache.dieoff = 0;
>> +		task_struct_cache.dbg = dloc->di->dbg;
>> +	}
> 
> [Severity: High]
> Does checking the raw Dwarf pointer expose an ABA problem?
> 
> If debug info handles are freed and reallocated for different DSOs during
> analysis, the memory address could be recycled. This would bypass the cache
> invalidation and cause perf to use a stale DWARF offset from the old DSO
> on the new DSO, potentially leading to out-of-bounds reads in libdw.
> 
>> +
>> +	if (!task_struct_cache.dieoff ||
>> +	    !dwarf_offdie(dloc->di->dbg, task_struct_cache.dieoff, &type_die)) {
>> +		struct strbuf sb;
>> +		char *type_name;
>> +		/*
>> +		 * Find the inline function 'get_current()' Dwarf_Die
> 
> [Severity: Medium]
> Can this cache mechanism create a non-deterministic order dependency?
> 
> If the first mrs instruction processed is a stack canary, which does not
> belong to get_current(), the search will fail and the state is invalidated.
> 
> However, if a true get_current() is processed first, the cache is populated
> and the function check is bypassed for subsequent stack canaries, allowing
> them to succeed.
> 
>> +		 * and obtain its return value data type, which should
>> +		 * be 'struct task_struct*'.
>> +		 */
>> +		if (!die_find_inlinefunc(cu_die, pc, &func_die) ||
> 
> [Severity: Medium]
> Will passing the Compilation Unit DIE (cu_die) instead of a Subprogram
> DIE cause a severe performance regression?
> 
> Because the underlying callback returns DIE_FIND_CB_CONTINUE, passing
> the entire compilation unit forces die_find_inlinefunc() to perform a
> full, inefficient O(N) recursive DWARF AST walk across every node in the
> file when the cache is empty.
> 
>> +		    !die_compare_name(&func_die, "get_current") ||
>> +		    !dwarf_attr_integrate(&func_die, DW_AT_type, &attr) ||
>> +		    !dwarf_formref_die(&attr, &type_die)) {
>> +			invalidate_reg_state(tsr);
>> +			return;
>> +		}
>> +
>> +		strbuf_init(&sb, 32);
>> +		die_get_typename_from_type(&type_die, &sb);
>> +		type_name = strbuf_detach(&sb, NULL);
>> +
>> +		if (!type_name || strcmp(type_name, "struct task_struct*")) {
>> +			invalidate_reg_state(tsr);
>> +			free(type_name);
>> +			return;
>> +		}
>> +
>> +		/*
>> +		 * Cache the 'struct task_struct*' die offset globally.
>> +		 * This allows us to resolve stack canary accesses even
>> +		 * in CUs that lack a full task_struct definition (e.g.,
>> +		 * compiler-generated entry/exit code).
>> +		 */
>> +		task_struct_cache.dieoff = dwarf_dieoffset(&type_die);
> 
> [Severity: High]
> Could this code permanently cache incomplete forward declarations of
> struct task_struct?
> 
> The string comparison matches "struct task_struct*", but there is no check
> to verify if the DIE is a complete definition (e.g., by checking
> DW_AT_declaration or dwarf_aggregate_size()).
> 
> If the first processed CU only has a forward declaration, its incomplete
> offset will be cached globally, causing all subsequent member offset
> lookups to fail since an incomplete type has no children.
> 
>> +		free(type_name);
>> +	}
> 

The cache was originally introduced to address stack_canary data type
identification, but it still has many issues at this point, so I are removing
it and will not support it for now.

Thanks,
Tengda

