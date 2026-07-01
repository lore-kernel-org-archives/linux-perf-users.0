Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5463AF676
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 06:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782888262; cv=none; b=h6uP5b6Qe2xtKf4v+69Yb/P/AW5NwAqWvYKqvvmEy9eBSmyuuojg3iQ2WDyi2TcFkVSBP2YZFm4wo7M8AOJj7EyTMRbVHH2V4qjquC2RSnYw1dS1DF3wfsCr2mitoN0x/5iaHr3CvaZQa1Zjv6iboPbWAxLXNDaYAX1UZW8R7vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782888262; c=relaxed/simple;
	bh=mnYe3YF/szMzCEPzBBxKzftwDOy0RSOkaHQyfDf5sLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IN+Aen/dwgbLJfvW8aZHiND8V+EGINZhgeEp7a9svBkjfzqgZkIgmdRYzWOWoo+H+mJmnR9ucBC9LoKdPuI63FyoDY6k2vQehbx6VPnfegM7VR+/rM2/ieOo6CFi/0EDdjppd7bAdbrjs+N+wiDtTXjmGaverk0qN15u0dnkJNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gqr7X5614zYQthL
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 14:43:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id C0E314057D
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 14:44:14 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgA3pfI9t0RqRo3PAQ--.22156S2;
	Wed, 01 Jul 2026 14:44:14 +0800 (CST)
Message-ID: <70364d4d-e891-45e5-84ed-addf7dcd97d7@huaweicloud.com>
Date: Wed, 1 Jul 2026 14:44:13 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/21] perf capstone: Fix arm64 jump/adrp disassembly
 mismatch with objdump
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-3-wutengda@huaweicloud.com>
 <20260701040748.64F631F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260701040748.64F631F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgA3pfI9t0RqRo3PAQ--.22156S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtF17ZrW8Gr1UWF43Gw1rJFb_yoW7Gw1UpF
	ykAay5GrW8JF1xJ34kZwn7Xrnagws5GF15u3s5KrZYkFn8CF1SkrWSyayYkas7Jws5Jw40
	vF4qyw15Cwn8tFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/7/1 12:07, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [High] Symbol resolution fails for relocated kernels (KASLR) and user-space shared libraries due to mismatched address spaces.
> - [Low] Build failure due to undeclared `machine` variable and undefined `machine__normalized_is()` function in `capstone_init()`.
> - [Low] Missing `<stdlib.h>` inclusion causes musl libc build failure.
> - [Low] Usage of `ARM64_GRP_BRANCH_RELATIVE` causes build failures with Capstone versions prior to 5.0.
> --
> 
> commit 1f9744f04e456b1209677658edb7f30a5b26e56d
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf capstone: Fix arm64 jump/adrp disassembly mismatch with objdump
> 
> The patch implements extended formatting for arm64 jump and adrp instructions
> during symbol__disassemble_capstone() to match objdump's expected output style.
> It adds instruction detail resolution in capstone_init() and formats the
> output with correct symbol and offset mappings.
> 
>> diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
>> index 9bba78ee0c5a2..a9c0a1d2eb036 100644
>> --- a/tools/perf/util/capstone.c
>> +++ b/tools/perf/util/capstone.c
> 
> [ ... ]
> 
>> @@ -218,6 +218,12 @@ static int capstone_init(uint16_t e_machine, csh *cs_handle, bool is64, bool is_
>>  		 * on x86 by investigating instruction details.
>>  		 */
>>  		perf_cs_option(*cs_handle, CS_OPT_DETAIL, CS_OPT_ON);
>> +	} else if (machine__normalized_is(machine, "arm64")) {
> 
> [Severity: Low]
> Does this code cause a build failure? The variable machine is not declared
> in capstone_init(), and the function machine__normalized_is() does not appear
> to be defined in the codebase.
> 

Agreed. This is due to commit 12c4737f55f2 ("perf capstone: Determine architecture from
e_machine"), which changed the capstone interface. I haven't rebased this part yet.
The base-commit already fails to build with capstone, so I didn't notice this one.

>> +		/*
>> +		 * Same as x86: arm64 needs instruction details to resolve
>> +		 * symbolic addresses
>> +		 */
>> +		perf_cs_option(*cs_handle, CS_OPT_DETAIL, CS_OPT_ON);
>>  	}
>>  
>>  	return 0;
> 
> [ ... ]
> 
>> +static bool is_pc_relative_insn(struct cs_insn *insn)
>> +{
>> +	int i;
>> +
>> +	if (insn->id == ARM64_INS_ADR || insn->id == ARM64_INS_ADRP)
>> +		return true;
>> +
>> +	if (insn->detail == NULL)
>> +		return false;
>> +
>> +	for (i = 0; i < insn->detail->groups_count; i++) {
>> +		if (insn->detail->groups[i] == ARM64_GRP_JUMP ||
>> +		    insn->detail->groups[i] == ARM64_GRP_CALL ||
>> +		    insn->detail->groups[i] == ARM64_GRP_BRANCH_RELATIVE)
> 
> [Severity: Low]
> Will this break compilation against Capstone versions prior to 5.0?
> ARM64_GRP_BRANCH_RELATIVE was introduced in Capstone 5.0. Since the perf
> tool's build feature detection doesn't mandate a specific Capstone version,
> relying on this enum might cause build failures on older setups.
> 

This enum was added in Capstone 5.0 over two years ago. I think we can
safely assume most systems are on a newer version now. I'll leave it as-is.

>> +			return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +static void format_capstone_insn_arm64(struct cs_insn *insn, char *buf,
>> +				       size_t len, struct annotate_args *args,
>> +				       u64 addr)
>> +{
> 
> [ ... ]
> 
>> +	if (is_pc_relative_insn(insn)) {
>> +		/* Extract last immediate value as address */
>> +		last_imm = strrchr(buf, '#');
>> +		if (!last_imm)
>> +			return;
>> +
>> +		orig_addr = strtoull(last_imm + 1, &endptr, 16);
> 
> [Severity: Low]
> Can this cause a build failure on musl libc? The POSIX standard function
> strtoull() is used here, but stdlib.h is not explicitly included in the
> file. Relying on implicit inclusions often works on glibc but breaks on
> musl libc.
> 

I'd say we can ignore this. strtoull() is used all over the perf codebase
and gets included indirectly. I don't think this is a real issue.

>> +		if (endptr == last_imm + 1)
>> +			return;
>> +
>> +		/* Relocate map that contains the address */
>> +		if (dso__kernel(map__dso(map))) {
>> +			found_map = maps__find(map__kmaps(map), orig_addr);
>> +			if (found_map == NULL)
>> +				return;
>> +			map = found_map;
>> +		}
>> +
>> +		/* Convert it to map-relative address for search */
>> +		addr = map__map_ip(map, orig_addr);
> 
> [Severity: High]
> Does this code fail to resolve symbols for relocated kernels (KASLR) or
> user-space shared libraries (PIE)?
> 
> The extracted orig_addr is in the objdump address space. However,
> maps__find() and map__map_ip() expect absolute memory addresses. By omitting
> the translation step via map__objdump_2mem(map, orig_addr) (which the x86
> implementation handles correctly), KASLR relocated kernels will fail in
> maps__find(), and user-space shared libraries will underflow in
> map__map_ip().
> 

Agreed. I missed map__objdump_2mem() here.

>> +
>> +		sym = map__find_symbol(map, addr);
>> +		if (sym == NULL) {
>> +			map__put(found_map);
>> +			return;
>> +		}
> 

