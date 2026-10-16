Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FBE33508E;
	Fri, 16 Oct 2026 01:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792113536; cv=none; b=fifMEFebxtulhxw3NH/atXcz6g/MBpAjcc2QTjUM7WMjQGeEWcZHU9IE5cXktOu640U2j13A0vSsKXTmKtMg7FUTJFN4LLHSP5txrS9OYjzXDV+y09RPxBEt4HNRsEpwagFv5UrN8TNgfsi4XX/XIO26khHcOw07zoaNhzs5BnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792113536; c=relaxed/simple;
	bh=vJIefsg1Wdj6LPcG4jxyb9SehHRoYIBR778BIER5y6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FHGGt2SG6yFuoaEvv7juxrfnsmC6gWsijdTZH3vxpaNnvHODynitSb4JBKFGetxnybtWSy9710WpoBNAcjSv7DMaffQ/f08xhuNsE7xAM8+Dznixym6c3jKTLENY46hWtMkK1AP2IbRpfgr5d9YQUQhxsLnP7Z1nwwdUrGQdVgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4j5RsT3Q67zKHMQM;
	Fri, 16 Oct 2026 09:18:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DA953406D4;
	Fri, 16 Oct 2026 09:18:39 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgAHOulve9FqJtJqAg--.4184S2;
	Fri, 16 Oct 2026 09:18:39 +0800 (CST)
Message-ID: <8fdf2566-bbac-4854-8faf-0276af5f936e@huaweicloud.com>
Date: Fri, 16 Oct 2026 09:18:38 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/15] perf annotate arm64: Support instruction
 tracking for data type profiling
To: Namhyung Kim <namhyung@kernel.org>
Cc: james.clark@linaro.org, xueshuai@linux.alibaba.com,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
 Li Huafei <lihuafei1@huawei.com>, Ian Rogers <irogers@google.com>,
 Kim Phillips <kim.phillips@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Ingo Molnar <mingo@redhat.com>, Bill Wendling <morbo@google.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Zecheng Li <zli94@ncsu.edu>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <cover.1791629326.git.wutengda@huaweicloud.com>
 <atFdpZG-b2JPS1St@google.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <atFdpZG-b2JPS1St@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAHOulve9FqJtJqAg--.4184S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WF13tFWktFW7Gr4fCFWDXFb_yoW7Zr1Upa
	93C3WfJr45tr40ywnrJrZ7XF4rtw4fJa48G348ta4Syr12kF9YyF9rKF1FyFZ5Cr98Cw17
	tw4qyFn8Zay8uaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02
	F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4I
	kC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUxo7KDUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/10/16 7:11, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Oct 13, 2026 at 01:27:58PM +0000, Tengda Wu wrote:
>> This series adds arm64 support to perf's data type profiling by
>> implementing instruction tracking for the arm64 architecture.
>>
>> Patches 01-11 of v6 have already been merged. This version only
>> contains the remaining instruction tracking part, renumbered from 01.
>>
>> The main changes since v6 include:
>> v6: https://lore.kernel.org/all/cover.1789521520.git.wutengda@huaweicloud.com/
>>
>>   * Rebase on the latest tree, since flex array support patches have been
>>     merged recently.
>>   * Invalidate lifetime in propagate_load_reg_state(). (Sashiko)
>>   * Remove the has_reg_type() guard in update_store_insn_state() to avoid
>>     skipping the stack state invalidation logic. (Sashiko)
>>   * Fix the issue where TSR_KIND_PERCPU_BASE fails to retry as expected. (Sashiko)
>>
>> Patch organization
>> ==================
>>
>>   Patches 1-3:   Shared infrastructure. Extract invalidate_reg_state() as
>>                  a common helper, add the arch_get_reg_offset() helper for
>>                  computing operand base offsets, and wire up the arm64
>>                  entry points (arch_supports_insn_tracking(),
>>                  init_type_state(), and update_insn_state_arm64()).
>>
>>   Patches 4-6:   Core instruction tracking for arm64: function return
>>                  types after calls, load instructions (ldr/ldp and their
>>                  addressing modes), and store instructions (str/stp).
>>
>>   Patches 7-9:   Shared data structure improvements and an x86 fix.
>>                  Expand type_state_reg.imm_value to u64 so 64-bit
>>                  addresses can be tracked, preserve imm_value for stack
>>                  variables, and delete stale stack state on store of an
>>                  untracked register on x86.
>>
>>   Patches 10-15: Remaining arm64 patterns: stack variable tracking,
>>                  'mov' (register and immediate forms), 'add' member
>>                  address calculation, 'adrp' global variable tracking,
>>                  per-cpu variable access, and 'mrs sp_el0' to resolve the
>>                  'current' pointer.
>>
>> Each patch's type profiling results are as follows:
>>
>> Patch | Feature                    | no_sym | no_var | no_typeinfo | bad_offset | insn_track | ok(%)
>> ------+----------------------------+--------+--------+-------------+------------+------------+------
>> base  | baseline                   | 6      | 493    | -           | -          | -          | 56.2%
>> 0002  | enable insn tracking       | 6      | 42     | 437         | 2          | 12         | 57.2%
>> 0005  | support 'load' insn        | 6      | 42     | 398         | 1          | 52         | 60.7%
>> 0006  | support 'store' insn       | 6      | 42     | 398         | 1          | 52         | 60.7%
>> 0010  | support stack variable     | 6      | 42     | 391         | 1          | 59         | 61.3%
>> 0011  | support 'mov' insn         | 6      | 42     | 372         | 3          | 76         | 62.8%
>> 0012  | support 'add' insn         | 6      | 42     | 318         | 7          | 126        | 67.2%
>> 0013  | support 'adrp' insn        | 6      | 42     | 238         | 8          | 205        | 74.2%
>> 0014  | support per-cpu variable   | 6      | 42     | 233         | 8          | 210        | 74.6%
>> 0015  | support 'mrs' insn         | 6      | 42     | 230         | 8          | 213        | 74.9%
>>
>> Testing
>> =======
>>
>> Tested on arm64 (all passed):
>>
>>   # perf test -v "perf data type profiling tests"
>>   81: perf data type profiling tests                                                                  : Ok
>>
>>   === Test Summary ===
>>   Passed main tests : 1
>>   Passed subtests   : 0
>>   Skipped tests     : 0
>>   Failed tests      : 0
>>
>> Tested on x86. The profiling results show no change before/after applying
>> this patch series:
>>
>>   before : total 880, ok 711 (80.8%), bad 169 (19.2%)
>>   after  : total 880, ok 711 (80.8%), bad 169 (19.2%)
>>
>> Changelog
>> =========
>> v6 -> v7:
>>   - v6: https://lore.kernel.org/all/cover.1789521520.git.wutengda@huaweicloud.com/
>>   - Invalidate lifetime in propagate_load_reg_state().
>>   - Remove the has_reg_type() guard in update_store_insn_state().
>>   - Fix the issue where TSR_KIND_PERCPU_BASE fails to retry as expected.
>>
>> Please let me know if you have any feedback.
> 
> Thanks a lot for your work!  Assuming you'll fix the issues from Sashiko
> in the next version, you can add my:
> 
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> 

Yes, I'll address the issues reported by Sashiko and send a v8.
Most of them are minor, and I'll fix them accordingly (or explain
in the v8 thread if I think any of them is a false positive).
I'll carry your Reviewed-by in the next version as agreed.

Thanks,
Tengda

> Thanks,
> Namhyung
>  
> 
>> Tengda Wu (15):
>>   perf annotate-data: Extract invalidate_reg_state() as a common helper
>>   perf annotate-arm64: Enable instruction tracking support
>>   perf annotate-data: Add arch_get_reg_offset helper
>>   perf annotate-arm64: Track return type after call instructions
>>   perf annotate-arm64: Support load instruction tracking
>>   perf annotate-arm64: Support store instruction tracking
>>   perf annotate-data: Expand type_state_reg imm_value to u64
>>   perf annotate-data: Track imm_value for stack variables
>>   perf annotate-x86: Delete stale stack state on store of untracked
>>     register
>>   perf annotate-arm64: Support stack variable tracking
>>   perf annotate-arm64: Support 'mov' instruction tracking
>>   perf annotate-arm64: Support 'add' instruction tracking
>>   perf annotate-arm64: Support 'adrp' instruction to track global
>>     variables
>>   perf annotate-arm64: Support per-cpu variable access tracking
>>   perf annotate-arm64: Support 'mrs' instruction to track 'current'
>>     pointer
>>
>>  .../perf/util/annotate-arch/annotate-arm64.c  | 750 ++++++++++++++++++
>>  tools/perf/util/annotate-arch/annotate-x86.c  |  38 +-
>>  tools/perf/util/annotate-data.c               | 209 ++++-
>>  tools/perf/util/annotate-data.h               |  14 +-
>>  4 files changed, 963 insertions(+), 48 deletions(-)
>>
>>
>> base-commit: aac26bee2287c88af5be5a5ff96d783b19a28790
>> -- 
>> 2.34.1
>>

