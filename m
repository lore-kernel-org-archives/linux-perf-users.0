Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD6E1A317E;
	Fri, 14 Mar 2025 08:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940448; cv=none; b=jotN6F4fID7cIJBWu7VAsB0EDZwbGBWwO+9TJIzs2fzfDebeD9k8X8qbemNXArf0FpJBbEjXr0mZgS+ErHhyLpS4x2XhjwDDu8empWvQYd1lTdgcEbT9RbkYscdabQED7kab2jyDEFiyIrhokWjNq46bX6v7yWdTvjEci6AqiDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940448; c=relaxed/simple;
	bh=L0KAlvT8zOYFQVbNDZ3m29+XPfedC8cPfoiG9dCYMNw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B7JFQlmmVK6m087BKI8nWoBz+sfSyUmWVuGn6sibjLXuL0bQtAKoMe5khAftq6pEuwKMg5C5+R5N3pysESWPPPo1dHw4V3v/OMRkhkDVu2j6tS8+0nxb6oMMqgQWyZkriwZb0Up6y51OTniUEY8jZ35KutCVUNMhslEBMt7jUYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZDcfS1V3szCs8d;
	Fri, 14 Mar 2025 16:17:04 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id D6A5E1800E4;
	Fri, 14 Mar 2025 16:20:37 +0800 (CST)
Received: from lihuafei.huawei.com (10.90.53.74) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 14 Mar 2025 16:20:36 +0800
From: Li Huafei <lihuafei1@huawei.com>
To: <namhyung@kernel.org>, <acme@kernel.org>, <leo.yan@linux.dev>,
	<james.clark@linaro.org>, <mark.rutland@arm.com>, <john.g.garry@oracle.com>,
	<will@kernel.org>, <irogers@google.com>
CC: <mike.leach@linaro.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<kjain@linux.ibm.com>, <mhiramat@kernel.org>, <atrajeev@linux.vnet.ibm.com>,
	<sesse@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <lihuafei1@huawei.com>
Subject: [PATCH 0/7] Add data type profiling support for arm64
Date: Sat, 15 Mar 2025 00:21:30 +0800
Message-ID: <20250314162137.528204-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf500004.china.huawei.com (7.202.181.242)

Hi,

This patchset supports arm64 perf data type profiling. Data type
profiling was introduced by Namhyung [1], which associates PMU sampling
(here referring to memory access-related event sampling) with the
referenced data types, providing developers with an effective tool for
analyzing the impact of memory usage and layout. For more detailed
background, please refer to [2].

Namhyung initially supported this feature only on x86, and later Athira
added support for it on powerpc [3]. Unlike the x86 implementation, the
powerpc implementation parses operands directly from raw instruction
code instead of using the results from assembler disassembly. As Athira
mentioned, this is mainly because not all memory access instructions on
powerpc have explicit memory reference assembler notations '()' in their
assembly code. On arm64, all memory access instructions have the
notation '[]', so my implementation is similar to x86, using the
disassembly results from objdump, llvm, or libcapstone, and parsing
based on strings. I believe this has the advantage of reusing the
complex instruction parsing logic of the assembler, but it may not
perform as well as raw instruction parsing in terms of efficiency.

Below is a brief description of this patchset:
 - Patch 1 first identifies load and store instructions and provides a
   parsing function.
 - Patches 2-3 are refactoring patches. They primarily move the code for
   extracting registers and offsets to specific architecture
   implementations. Additionally, a new callback function
   'extract_reg_offset' is introduced to avoid having too many
   architecture-specific implementations in the function
   'annotate_get_insn_location()'.
 - Patch 4 implements the extract_reg_offset callback for arm64.
   Currently, it does not support parsing instructions with register
   pairs or register offsets in operands. Register pairs often appear in
   stack push/pop instructions, and register offsets are common when
   accessing per-CPU variables, both of which require special handling.
 - Patch 5 adds support for instruction tracing on arm64, primarily
   addressing the issue where DWARF does not generate information for
   intermediate pointers in pointer chains.
 - Patches 6-7 further enhance instruction tracing. Patch 6 supports
   parsing accesses to global variables, while Patch 7 focuses on
   resolving accesses to the kernel's current pointer.

There are still areas for improvement in the current implementation:
 - Support more types of memory access instructions, such as those
   involving register pairs and register offsets.
 - Handle all data processing instructions (e.g., mov, add), as these
   instructions can change the state of registers and may affect the
   accuracy of instruction tracking.
 - Supporting parsing of special memory access scenarios like per-CPU
   variables and arrays.

The patch set is based on 6.14-rc6 (commit 80e54e84911a). After applying
this patch set, the date type profiling results on arm64 are as follows
(SPE support is required):

 # perf mem record -a -K -- sleep 1
 # perf annotate --data-type --type-stat --stdio
 Only instruction-based sampling period is currently supported by Arm SPE.
 Annotate data type stats:
 total 556, ok 357 (64.2%), bad 199 (35.8%)
 -----------------------------------------------------------
         10 : no_sym
         36 : no_insn_ops
         65 : no_var
         70 : no_typeinfo
         18 : bad_offset
         59 : insn_track
 
 Annotate type: 'struct rq' in [kernel.kallsyms] (29 samples):
 ============================================================================
  Percent     offset       size  field
   100.00          0      0xe80  struct rq        {
     0.00          0        0x4      raw_spinlock_t      __lock {
     0.00          0        0x4          arch_spinlock_t raw_lock {
     0.00          0        0x4              union        {
     0.00          0        0x4                  atomic_t        val {
     0.00          0        0x4                      int counter;
                                                 };
     0.00          0        0x2                  struct   {
     0.00          0        0x1                      u8  locked;
     0.00        0x1        0x1                      u8  pending;
                                                 };
     0.00          0        0x4                  struct   {
     0.00          0        0x2                      u16 locked_pending;
     0.00        0x2        0x2                      u16 tail;
                                                 };
                                             };
                                         };
                                     };
    13.79        0x4        0x4      unsigned int        nr_running;
    13.79        0x8        0x4      unsigned int        nr_numa_running;
     0.00        0xc        0x4      unsigned int        nr_preferred_running;
     0.00       0x10        0x4      unsigned int        numa_migrate_on;
     0.00       0x18        0x8      long unsigned int   last_blocked_load_update_tick;
     0.00       0x20        0x4      unsigned int        has_blocked_load;
     0.00       0x40       0x20      call_single_data_t  nohz_csd {
     0.00       0x40       0x10          struct __call_single_node       node {
     0.00       0x40        0x8              struct llist_node   llist {
     0.00       0x40        0x8                  struct llist_node*      next;
                                             };
     0.00       0x48        0x4              union        {
     0.00       0x48        0x4                  unsigned int    u_flags;
     0.00       0x48        0x4                  atomic_t        a_flags {
     0.00       0x48        0x4                      int counter;
                                                 };
                                             };
     ...

Thanks,
Huafei

[1] https://lore.kernel.org/lkml/20231213001323.718046-1-namhyung@kernel.org/
[2] https://lwn.net/Articles/955709/
[3] https://lore.kernel.org/all/20240718084358.72242-1-atrajeev@linux.vnet.ibm.com/#r

Li Huafei (7):
  perf annotate: Handle arm64 load and store instructions
  perf annotate: Advance the mem_ref check to mov__parse()
  perf annotate: Add 'extract_reg_offset' callback function to extract
    register number and access offset
  perf annotate: Support for the 'extract_reg_offset' callback function
    in arm64
  perf annotate-data: Support instruction tracking for arm64
  perf annotate-data: Handle arm64 global variable access
  perf annotate-data: Handle the access to the 'current' pointer on
    arm64

 tools/perf/arch/arm64/annotate/instructions.c | 302 +++++++++++++++++-
 .../perf/arch/powerpc/annotate/instructions.c |  10 +
 tools/perf/arch/x86/annotate/instructions.c   |  99 ++++++
 tools/perf/util/Build                         |   1 +
 tools/perf/util/annotate-data.c               |  23 +-
 tools/perf/util/annotate-data.h               |   4 +-
 tools/perf/util/annotate.c                    | 112 +------
 tools/perf/util/disasm.c                      |  14 +
 tools/perf/util/disasm.h                      |   4 +
 tools/perf/util/dwarf-regs-arm64.c            |  25 ++
 tools/perf/util/include/dwarf-regs.h          |   7 +
 11 files changed, 490 insertions(+), 111 deletions(-)
 create mode 100644 tools/perf/util/dwarf-regs-arm64.c

-- 
2.25.1

