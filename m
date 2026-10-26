Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.94.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792976462;
	b=kesVPR+OR4eMoLN8CFuC7LzPZVrZnd/6LgTxoBLYroh29dtUnpQTc0qrpoKHppJ67X+t
	 gfLokgGpo8fZMlyeB/Watm4toTVJB8SHBeK4Vaua2Qh+dS9E7zWsYOsjHGruI4LEodN6U
	 muQ8HltLlMoob2EwXF7V53O6Wpgw+URznXU1eCW+XpyIVP9t4gjRO/VGWniFzBrIa1w+1
	 V2Cq8LjfEKDc5r68donvOtr7akfEGdUNhbPNc19iu8RQ+r5188SuxmC8AJtS2lmESQgIR
	 jWp5ba2iv4qWY+cU8FJ/An5HPqOnps3PdPI7+E/Dxf9whE4av/b7XXzEdXgWDNlDdUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792976462;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=NG1AOAUUdBKLzUrMNajfQAQzLxhfZ9+5Z7BZccO0EP8=;
	b=rhjKQWB1Xvdns6+nDbePoqtHvVNo7OE1WYkwjYGzxRq3PxUnQgG/POfZyquLt0s2cZmf
	 QAasCakDpsuTq0+3RKw/z/O5bfoPPSWw5oBnq55K6MXYPPYzh0LaPDd0oN7DdYhBLbc7Z
	 nN9OmHUZiu/rP7XnxUNRUiNRtCRbhKfWoHdyYGnOF3945T2zEHlKBJYZtiff7N3vd0CLw
	 ojf3R/+1fl3N2C82NRC0cVgQOknGQgXpWxhFVD6jAx793X1o4nYK+pMT0mMIJK63/Y340
	 N3E0YDxuNBfUuiLeXkQATek2+cp6yc7YoTgqnBmGtKIX14ILJSYasOnWwFfzXgiu9BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.94.104
Received: from dggmsgout13.his.huawei.com (dggmsgout13.his.huawei.com [124.71.94.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76035606A31A;
	Mon, 26 Oct 2026 01:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76035606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggmsgout13.his.huawei.com (SkyGuard) with ESMTP id 4jCb090c86z1rrSW;
	Mon, 26 Oct 2026 09:00:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 1A5BB40576;
	Mon, 26 Oct 2026 09:00:51 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgDHletBpt5qDS1SBw--.17922S2;
	Mon, 26 Oct 2026 09:00:50 +0800 (CST)
Message-ID: <18c1e63e-bdfd-4e74-bda6-61b68c915c0c@huaweicloud.com>
Date: Mon, 26 Oct 2026 09:00:49 +0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/15] perf annotate arm64: Support instruction
 tracking for data type profiling
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, james.clark@linaro.org,
 xueshuai@linux.alibaba.com, Peter Zijlstra <peterz@infradead.org>,
 leo.yan@linux.dev, Li Huafei <lihuafei1@huawei.com>,
 Ian Rogers <irogers@google.com>, Kim Phillips <kim.phillips@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Bill Wendling <morbo@google.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Zecheng Li <zli94@ncsu.edu>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <cover.1792411435.git.wutengda@huaweicloud.com>
 <18de9e8f-3709-4bc9-b11b-3813e1ba98b7@huaweicloud.com>
 <atvNXkeWyJCGMrbF@phoenix2>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <atvNXkeWyJCGMrbF@phoenix2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDHletBpt5qDS1SBw--.17922S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFy3Xw4UAr4UJF4fWFyfJFb_yoW5AFykpr
	Z5Ca1rtFWDJr40yFsFqw47Xr4aga1rWr47Wrn5t34SkFn0vFn3tFs3K3W5WFZ3Cr15Cr17
	Xw4jvF93Zw4jvFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02
	F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4I
	kC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUIa0PDUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/10/24 5:10, Arnaldo Carvalho de Melo wrote:
> On Wed, Oct 21, 2026 at 10:25:40AM +0800, Tengda Wu wrote:
>> Hi,
>>
>> On 2026/10/20 21:44, Tengda Wu wrote:
>>> This series adds arm64 support to perf's data type profiling by
>>> implementing instruction tracking for the arm64 architecture.
>>>
>>> The main changes since v7 include:
>>> v7: https://lore.kernel.org/all/cover.1791629326.git.wutengda@huaweicloud.com/
>>>
>>>   * Patch 02: Minor optimizations to update_insn_state_arm64 to facilitate
>>>     future extension, including:
>>>     - Encapsulating call instruction handling into update_call_insn_state()
>>>     - Encapsulating invalidate dst regs handling into invalidate_unhandled_insn_regs()
>>>     - Renaming is_readonly_branch_or_cmp() to is_readonly_insn()
>>>     No functional changes.
>>>
>>>   * Fix issues raised by Sashiko:
>>>     - Patch 06: Complete the status register invalidation logic for
>>>       exclusive stores.
>>>     - Patch 13 & 15: Complete the lifetime invalidation logic for adrp
>>>       and mrs instructions.
>>>     Regarding the status register invalidation issue for instructions
>>>     such as cas/swp as well, we plan to support this incrementally
>>>     after the relevant instructions are refined; this patch temporarily
>>>     ignores and does not handle it (a TODO marker has already been
>>>     reserved in patch 02)
>>>
>>> Patch organization
>>> ==================
>>>
>>>   Patches 1-3:   Shared infrastructure. Extract invalidate_reg_state() as
>>>                  a common helper, add the arch_get_reg_offset() helper for
>>>                  computing operand base offsets, and wire up the arm64
>>>                  entry points (arch_supports_insn_tracking(),
>>>                  init_type_state(), and update_insn_state_arm64()).
>>>
>>>   Patches 4-6:   Core instruction tracking for arm64: function return
>>>                  types after calls, load instructions (ldr/ldp and their
>>>                  addressing modes), and store instructions (str/stp).
>>>
>>>   Patches 7-9:   Shared data structure improvements and an x86 fix.
>>>                  Expand type_state_reg.imm_value to u64 so 64-bit
>>>                  addresses can be tracked, preserve imm_value for stack
>>>                  variables, and delete stale stack state on store of an
>>>                  untracked register on x86.
>>>
>>>   Patches 10-15: Remaining arm64 patterns: stack variable tracking,
>>>                  'mov' (register and immediate forms), 'add' member
>>>                  address calculation, 'adrp' global variable tracking,
>>>                  per-cpu variable access, and 'mrs sp_el0' to resolve the
>>>                  'current' pointer.
>>>
>>
>> Just a quick note that this version of the patch series has addressed or
>> clarified all the Sashiko review comments. I would appreciate it if you
>> could take a look when you get a chance.
> 
> Merged now, test built and pushed to perf-tools-next/perf-tools-next for
> further build testing with linux-next, early next week I intend to push
> it out to Linus for 7.4.
> 
> - Arnaldo

Thanks a lot for the merge and for running the build tests. Much appreciated!

Best regards,
Tengda

