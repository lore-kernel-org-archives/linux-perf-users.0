Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.249.212.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503970;
	b=S2Tmp+Q7vb0iDfRGqYQjTfkbiAE3S9nDoKG3NMI4xu+g8IxPxZmO45tjyiuKJ7au5Q61
	 3cOPo+da7nLvGUyZGDJHTCCseQ81O4a2WVGyuSmyMz1Xzkir4gbP/gGA3xfkgeDM4N8ZJ
	 ck6q+9iNZuHiYwyEp4k7rwQsgYzDwLAVJsyKG3pqzaucdo7RUvamVlJHIB0wqdlhR+WMF
	 QtP/YuWuLImZ9nNuFUb8F/Bk7IXApGnk/g1xNhB9sNMCHevahtMSUyllnMG9ZDUjhGcwg
	 kWZJnGuRSHQa6RWi3irn98JfVxllWj3QZiAtb7BdlNzT64R4DT7/UAEdqG2eD0S6z/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503970;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=o+TLeUr9laZcQUrQM3aYZWu6M9JSdUwc6vEFggZYynA=;
	b=1sb5w686VhZmLIp9cupSYPzUf76Y39DAtpf2xu6ha5UMh/YuIfrGtUcMSnDiJ9ydYgpN
	 e5Oh/yLjyLnXzsuzpZY0+KDlaWshE4/3FKBuCogSw2FJx/um6XV8/+5lI7wvo/2YgAdYH
	 mQ7Uj372q0MxjBiY4MtB9XcD5odmuMtngl8CZwtR7ZFfKsiJdQewGFPfZFSaSJKwpkZuY
	 UtJgzfLCIBSKroAS9NO6ySG9BzWhvpaT1ongTBxlZfkqyQxYzhob37wXDGV37fVkji0JZ
	 mqit9c8xY5qmaKzW8HzUMbFca9PrzNrKnSBs64yTSFhY076/qSbrvIsCXm4h8sR/MGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=45.249.212.56
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D914B606A33F;
	Tue, 20 Oct 2026 13:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D914B606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4j8DFl4cCHzKHMXT;
	Tue, 20 Oct 2026 21:45:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 8F91540571;
	Tue, 20 Oct 2026 21:45:57 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgB3QOaGcNdq8xegBA--.22174S2;
	Tue, 20 Oct 2026 21:45:57 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Namhyung Kim <namhyung@kernel.org>,
	james.clark@linaro.org,
	xueshuai@linux.alibaba.com,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH v8 00/15] perf annotate arm64: Support instruction tracking for data type profiling
Date: Tue, 20 Oct 2026 13:44:56 +0000
Message-Id: <cover.1792411435.git.wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgB3QOaGcNdq8xegBA--.22174S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuFyDuw4UXFWfury7Cw4UJwb_yoW7Zr43pa
	93Cw1fJr1Utr409rnxJrW7Jr1aga1fX3y7Gryrta4Syw42yF9YyFykKF1FyFWfAr9xury7
	Jw1vyF1DZayUuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBCb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402
	YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY1x0264kExVAvwVAq07x20x
	yl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWU
	JVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7V
	AKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42
	IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRQ2-0DUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

This series adds arm64 support to perf's data type profiling by
implementing instruction tracking for the arm64 architecture.

The main changes since v7 include:
v7: https://lore.kernel.org/all/cover.1791629326.git.wutengda@huaweicloud.com/

  * Patch 02: Minor optimizations to update_insn_state_arm64 to facilitate
    future extension, including:
    - Encapsulating call instruction handling into update_call_insn_state()
    - Encapsulating invalidate dst regs handling into invalidate_unhandled_insn_regs()
    - Renaming is_readonly_branch_or_cmp() to is_readonly_insn()
    No functional changes.

  * Fix issues raised by Sashiko:
    - Patch 06: Complete the status register invalidation logic for
      exclusive stores.
    - Patch 13 & 15: Complete the lifetime invalidation logic for adrp
      and mrs instructions.
    Regarding the status register invalidation issue for instructions
    such as cas/swp as well, we plan to support this incrementally
    after the relevant instructions are refined; this patch temporarily
    ignores and does not handle it (a TODO marker has already been
    reserved in patch 02)

Patch organization
==================

  Patches 1-3:   Shared infrastructure. Extract invalidate_reg_state() as
                 a common helper, add the arch_get_reg_offset() helper for
                 computing operand base offsets, and wire up the arm64
                 entry points (arch_supports_insn_tracking(),
                 init_type_state(), and update_insn_state_arm64()).

  Patches 4-6:   Core instruction tracking for arm64: function return
                 types after calls, load instructions (ldr/ldp and their
                 addressing modes), and store instructions (str/stp).

  Patches 7-9:   Shared data structure improvements and an x86 fix.
                 Expand type_state_reg.imm_value to u64 so 64-bit
                 addresses can be tracked, preserve imm_value for stack
                 variables, and delete stale stack state on store of an
                 untracked register on x86.

  Patches 10-15: Remaining arm64 patterns: stack variable tracking,
                 'mov' (register and immediate forms), 'add' member
                 address calculation, 'adrp' global variable tracking,
                 per-cpu variable access, and 'mrs sp_el0' to resolve the
                 'current' pointer.

Each patch's type profiling results are as follows:

Patch | Feature                    | no_sym | no_var | no_typeinfo | bad_offset | insn_track | ok(%)
------+----------------------------+--------+--------+-------------+------------+------------+------
base  | baseline                   | 6      | 493    | -           | -          | -          | 56.2%
0002  | enable insn tracking       | 6      | 42     | 437         | 2          | 12         | 57.2%
0005  | support 'load' insn        | 6      | 42     | 398         | 1          | 52         | 60.7%
0006  | support 'store' insn       | 6      | 42     | 398         | 1          | 52         | 60.7%
0010  | support stack variable     | 6      | 42     | 391         | 1          | 59         | 61.3%
0011  | support 'mov' insn         | 6      | 42     | 372         | 3          | 76         | 62.8%
0012  | support 'add' insn         | 6      | 42     | 318         | 7          | 126        | 67.2%
0013  | support 'adrp' insn        | 6      | 42     | 238         | 8          | 205        | 74.2%
0014  | support per-cpu variable   | 6      | 42     | 233         | 8          | 210        | 74.6%
0015  | support 'mrs' insn         | 6      | 42     | 230         | 8          | 213        | 74.9%

Testing
=======

Tested on arm64 (all passed):

  # perf test -v "perf data type profiling tests"
  81: perf data type profiling tests                                                                  : Ok

  === Test Summary ===
  Passed main tests : 1
  Passed subtests   : 0
  Skipped tests     : 0
  Failed tests      : 0

Tested on x86. The profiling results show no change before/after applying
this patch series:

  before : total 880, ok 711 (80.8%), bad 169 (19.2%)
  after  : total 880, ok 711 (80.8%), bad 169 (19.2%)

Changelog
=========
v7 -> v8:
  - v7: https://lore.kernel.org/all/cover.1791629326.git.wutengda@huaweicloud.com/
  - Encapsulate invalidate dst regs handling into invalidate_unhandled_insn_regs()
  - Encapsulate invalidate dst regs handling into invalidate_unhandled_insn_regs()
  - Rename is_readonly_branch_or_cmp() to is_readonly_insn()
  - Complete the status register invalidation logic for exclusive stores.
  - Complete the lifetime invalidation logic for adrp and mrs instructions.
v6 -> v7:
  - v6: https://lore.kernel.org/all/cover.1789521520.git.wutengda@huaweicloud.com/
  - Invalidate lifetime in propagate_load_reg_state().
  - Remove the has_reg_type() guard in update_store_insn_state().
  - Fix the issue where TSR_KIND_PERCPU_BASE fails to retry as expected.

Please let me know if you have any feedback.

Thanks,
Tengda

Tengda Wu (15):
  perf annotate-data: Extract invalidate_reg_state() as a common helper
  perf annotate-arm64: Enable instruction tracking support
  perf annotate-data: Add arch_get_reg_offset helper
  perf annotate-arm64: Track return type after call instructions
  perf annotate-arm64: Support load instruction tracking
  perf annotate-arm64: Support store instruction tracking
  perf annotate-data: Expand type_state_reg imm_value to u64
  perf annotate-data: Track imm_value for stack variables
  perf annotate-x86: Delete stale stack state on store of untracked
    register
  perf annotate-arm64: Support stack variable tracking
  perf annotate-arm64: Support 'mov' instruction tracking
  perf annotate-arm64: Support 'add' instruction tracking
  perf annotate-arm64: Support 'adrp' instruction to track global
    variables
  perf annotate-arm64: Support per-cpu variable access tracking
  perf annotate-arm64: Support 'mrs' instruction to track 'current'
    pointer

 .../perf/util/annotate-arch/annotate-arm64.c  | 774 ++++++++++++++++++
 tools/perf/util/annotate-arch/annotate-x86.c  |  38 +-
 tools/perf/util/annotate-data.c               | 209 ++++-
 tools/perf/util/annotate-data.h               |  14 +-
 4 files changed, 987 insertions(+), 48 deletions(-)


base-commit: 2efb7a11f1aa4d2dc285fe2680cca22cb9f72f64
-- 
2.34.1

