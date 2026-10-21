Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.249.212.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792549548;
	b=2IdZBfJh5ILAV40AEsar/Qz2wRmwwDN+dwC7r0Q9vkvTMTbmtoIhXKof5pUOAA8Ly5Pm
	 QJJpL3YngDmrif4Yyy8rzBB7ysGL3bgq/qU8oAtyQZ4t0LsYnZervsadd2xg8Lc1MCejB
	 1PlyQLbegEgoYg0oEgwUY8RUzFwxUy/iX1HPZnSGNQ+sXm9LIkfJkA54xARVbB4TCakOK
	 cpVC9VpLqIxqc3jG3aXmOxhlsZYv2kAHCrl959TS72ORO7+5nC50az0Ou4MV0uDacluxe
	 juWJn301xTOIlgXIcLvNcS06f/eHdvU2qkMyyLYLyxAn2uo/7Kg7zSWHq+SA78NOrZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792549548;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=bUpuMLN+Hzel+rwIg8x/V4c7BZp7NFus4wb/KBKZts8=;
	b=5pAtrLzP3kYQogTVFaUQMFOVd04vSg7IvxrNbdWslKtZDIFF0u80sg4HSELoJj4d994N
	 Yb/ERSF88rr61Ynmxyu/p7vLSrT5oPyiLdNOX0/4JxFb6azT1pd8XGugMTHJb2a9t6p6w
	 tOjkmV03nKMbNM9gsTjRC6lFtVV1Bc9mll35TVk1n6Ml1f6eFHmwRA/DapKqCKJvsWRl2
	 Fxk3JDYgpM+kDH9CJiwg8mc027x+rPo33qQytbTtvkkMhE07rBm7HaD+7JRhNyYaQK7fQ
	 PdGUmHWBxDvDGA97y4CrerixdHbUYyIJKi/NgS53aF6Jm8AHPsYedw68QIBdkuuhFOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=45.249.212.51
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7C0606A31C;
	Wed, 21 Oct 2026 02:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F7C0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4j8Y6W4dywzYQtt1;
	Wed, 21 Oct 2026 10:25:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 839F1409D2;
	Wed, 21 Oct 2026 10:25:42 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgBnMeekIthqMcbiBA--.26564S2;
	Wed, 21 Oct 2026 10:25:42 +0800 (CST)
Message-ID: <18de9e8f-3709-4bc9-b11b-3813e1ba98b7@huaweicloud.com>
Date: Wed, 21 Oct 2026 10:25:40 +0800
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
To: Namhyung Kim <namhyung@kernel.org>, james.clark@linaro.org,
 xueshuai@linux.alibaba.com, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
 Li Huafei <lihuafei1@huawei.com>, Ian Rogers <irogers@google.com>,
 Kim Phillips <kim.phillips@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Ingo Molnar <mingo@redhat.com>, Bill Wendling <morbo@google.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Zecheng Li <zli94@ncsu.edu>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <cover.1792411435.git.wutengda@huaweicloud.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <cover.1792411435.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBnMeekIthqMcbiBA--.26564S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuFyDuw43AF4rWrW3AF4DXFb_yoW7KrWkpa
	93uw1fJryUtr4j9rnrJrZ7Xr43Wa1rXa4UGryrt34Syr12yF9YyF97K3WFyFWfAr98Cr17
	Jw4vyFn8Xayj9aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Hi,

On 2026/10/20 21:44, Tengda Wu wrote:
> This series adds arm64 support to perf's data type profiling by
> implementing instruction tracking for the arm64 architecture.
> 
> The main changes since v7 include:
> v7: https://lore.kernel.org/all/cover.1791629326.git.wutengda@huaweicloud.com/
> 
>   * Patch 02: Minor optimizations to update_insn_state_arm64 to facilitate
>     future extension, including:
>     - Encapsulating call instruction handling into update_call_insn_state()
>     - Encapsulating invalidate dst regs handling into invalidate_unhandled_insn_regs()
>     - Renaming is_readonly_branch_or_cmp() to is_readonly_insn()
>     No functional changes.
> 
>   * Fix issues raised by Sashiko:
>     - Patch 06: Complete the status register invalidation logic for
>       exclusive stores.
>     - Patch 13 & 15: Complete the lifetime invalidation logic for adrp
>       and mrs instructions.
>     Regarding the status register invalidation issue for instructions
>     such as cas/swp as well, we plan to support this incrementally
>     after the relevant instructions are refined; this patch temporarily
>     ignores and does not handle it (a TODO marker has already been
>     reserved in patch 02)
> 
> Patch organization
> ==================
> 
>   Patches 1-3:   Shared infrastructure. Extract invalidate_reg_state() as
>                  a common helper, add the arch_get_reg_offset() helper for
>                  computing operand base offsets, and wire up the arm64
>                  entry points (arch_supports_insn_tracking(),
>                  init_type_state(), and update_insn_state_arm64()).
> 
>   Patches 4-6:   Core instruction tracking for arm64: function return
>                  types after calls, load instructions (ldr/ldp and their
>                  addressing modes), and store instructions (str/stp).
> 
>   Patches 7-9:   Shared data structure improvements and an x86 fix.
>                  Expand type_state_reg.imm_value to u64 so 64-bit
>                  addresses can be tracked, preserve imm_value for stack
>                  variables, and delete stale stack state on store of an
>                  untracked register on x86.
> 
>   Patches 10-15: Remaining arm64 patterns: stack variable tracking,
>                  'mov' (register and immediate forms), 'add' member
>                  address calculation, 'adrp' global variable tracking,
>                  per-cpu variable access, and 'mrs sp_el0' to resolve the
>                  'current' pointer.
> 

Just a quick note that this version of the patch series has addressed or
clarified all the Sashiko review comments. I would appreciate it if you
could take a look when you get a chance.

Thanks,
Tengda

> Each patch's type profiling results are as follows:
> 
> Patch | Feature                    | no_sym | no_var | no_typeinfo | bad_offset | insn_track | ok(%)
> ------+----------------------------+--------+--------+-------------+------------+------------+------
> base  | baseline                   | 6      | 493    | -           | -          | -          | 56.2%
> 0002  | enable insn tracking       | 6      | 42     | 437         | 2          | 12         | 57.2%
> 0005  | support 'load' insn        | 6      | 42     | 398         | 1          | 52         | 60.7%
> 0006  | support 'store' insn       | 6      | 42     | 398         | 1          | 52         | 60.7%
> 0010  | support stack variable     | 6      | 42     | 391         | 1          | 59         | 61.3%
> 0011  | support 'mov' insn         | 6      | 42     | 372         | 3          | 76         | 62.8%
> 0012  | support 'add' insn         | 6      | 42     | 318         | 7          | 126        | 67.2%
> 0013  | support 'adrp' insn        | 6      | 42     | 238         | 8          | 205        | 74.2%
> 0014  | support per-cpu variable   | 6      | 42     | 233         | 8          | 210        | 74.6%
> 0015  | support 'mrs' insn         | 6      | 42     | 230         | 8          | 213        | 74.9%
> 
> Testing
> =======
> 
> Tested on arm64 (all passed):
> 
>   # perf test -v "perf data type profiling tests"
>   81: perf data type profiling tests                                                                  : Ok
> 
>   === Test Summary ===
>   Passed main tests : 1
>   Passed subtests   : 0
>   Skipped tests     : 0
>   Failed tests      : 0
> 
> Tested on x86. The profiling results show no change before/after applying
> this patch series:
> 
>   before : total 880, ok 711 (80.8%), bad 169 (19.2%)
>   after  : total 880, ok 711 (80.8%), bad 169 (19.2%)
> 
> Changelog
> =========
> v7 -> v8:
>   - v7: https://lore.kernel.org/all/cover.1791629326.git.wutengda@huaweicloud.com/
>   - Encapsulate invalidate dst regs handling into invalidate_unhandled_insn_regs()
>   - Encapsulate invalidate dst regs handling into invalidate_unhandled_insn_regs()
>   - Rename is_readonly_branch_or_cmp() to is_readonly_insn()
>   - Complete the status register invalidation logic for exclusive stores.
>   - Complete the lifetime invalidation logic for adrp and mrs instructions.
> v6 -> v7:
>   - v6: https://lore.kernel.org/all/cover.1789521520.git.wutengda@huaweicloud.com/
>   - Invalidate lifetime in propagate_load_reg_state().
>   - Remove the has_reg_type() guard in update_store_insn_state().
>   - Fix the issue where TSR_KIND_PERCPU_BASE fails to retry as expected.
> 
> Please let me know if you have any feedback.
> 
> Thanks,
> Tengda
> 
> Tengda Wu (15):
>   perf annotate-data: Extract invalidate_reg_state() as a common helper
>   perf annotate-arm64: Enable instruction tracking support
>   perf annotate-data: Add arch_get_reg_offset helper
>   perf annotate-arm64: Track return type after call instructions
>   perf annotate-arm64: Support load instruction tracking
>   perf annotate-arm64: Support store instruction tracking
>   perf annotate-data: Expand type_state_reg imm_value to u64
>   perf annotate-data: Track imm_value for stack variables
>   perf annotate-x86: Delete stale stack state on store of untracked
>     register
>   perf annotate-arm64: Support stack variable tracking
>   perf annotate-arm64: Support 'mov' instruction tracking
>   perf annotate-arm64: Support 'add' instruction tracking
>   perf annotate-arm64: Support 'adrp' instruction to track global
>     variables
>   perf annotate-arm64: Support per-cpu variable access tracking
>   perf annotate-arm64: Support 'mrs' instruction to track 'current'
>     pointer
> 
>  .../perf/util/annotate-arch/annotate-arm64.c  | 774 ++++++++++++++++++
>  tools/perf/util/annotate-arch/annotate-x86.c  |  38 +-
>  tools/perf/util/annotate-data.c               | 209 ++++-
>  tools/perf/util/annotate-data.h               |  14 +-
>  4 files changed, 987 insertions(+), 48 deletions(-)
> 
> 
> base-commit: 2efb7a11f1aa4d2dc285fe2680cca22cb9f72f64

