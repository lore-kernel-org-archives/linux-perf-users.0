Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DF41519A0;
	Wed,  5 Feb 2025 12:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738757773; cv=none; b=YR3Ils3jZ6X44Jq/LIn8/ZycKKjUG3pLEm2oLB9uDSodKI8r49QFw58ht7lyBucjYc08Yxzey933ro5zmiRf2RhtIFV0xRpR14OgvAa6gDyrWdF9x5RJBJNs33V0ab3cT99Gd2LWslm6IcGSA2LWWCVFyYFJvr+ugqvW4L8VD28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738757773; c=relaxed/simple;
	bh=PnrX7LRqf6LxC+SrcAB+LzJ5Es2hiwGk8s6CGixBO4c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JGzRuQHMNgsFsgyKro2ovFfz6/BJHkYvDgCHV39JkZoOUBlnfzhb6GHXc76+1ngRogZSC2KqveJgFzLhOLiVf/K9om1OlyFv6Z8MZU+rr3mZzJPZsKFNmJWB2EUHW7SEQGPY/Tzu2RCbqaMIyD7x97GR9Dgb5sRbbi/i4SGxh9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 160DE1007;
	Wed,  5 Feb 2025 04:16:34 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0C1163F63F;
	Wed,  5 Feb 2025 04:16:07 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Graham Woodward <graham.woodward@arm.com>
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 00/11] perf script: Refactor branch flags for Arm SPE
Date: Wed,  5 Feb 2025 12:15:44 +0000
Message-Id: <20250205121555.180606-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series refactors branch flags for support Arm SPE.  The patch
set is divided into two parts, the first part is for refactoring common
code and the second part is for enabling Arm SPE.

For refactoring branch flags, the sample flaghs are classified as branch
types and events.  A program branch type can be conditional branch,
function call, return or expection taken.  A branch event happens when
taking a branch.  This series combines branch types and the associated
events to present a sample flag.

The second part is to enable Arm SPE's sample flags for expressing
branch types and events, and support branch stack.

Patches 01 - 03 are to refactor branch types and branch events.
Patches 04, 05 extend to support not-taken event.

Patches 06 - 09 enables branch flags in Arm SPE.  This allows to print
out sample flags for samples.

Patch 10 supports branch stack for Arm SPE.  Patch 11 is an enhancement
for PBT feature.

Before:
  perf record -e arm_spe_0/load_filter=1,store_filter=1,branch_filter=1/ \
    -- ~/perf-c2c-usage-files/false_sharing.exe 1
  perf script --itrace=i1ibl -F,+flags,+addr,+brstack
   false_sharing.e  414489 [005] 775348.899294:          1                                                  branch:   jmp                   ffffc0fad9ef3d68 ffffc0fad98b2c68 search_cmp_ftr_reg+0x8 ([kernel.kallsyms])
   false_sharing.e  414489 [005] 775348.899294:          1                                            instructions:   jmp                   ffffc0fad9ef3d68 ffffc0fad98b2c68 search_cmp_ftr_reg+0x8 ([kernel.kallsyms])
   false_sharing.e  414489 [005] 775348.899294:          1                                                  branch:   jmp                   ffffc0fad98b3708 ffffc0fad98b3704 get_arm64_ftr_reg+0x30 ([kernel.kallsyms])
   false_sharing.e  414489 [005] 775348.899294:          1                                            instructions:   jmp                   ffffc0fad98b3708 ffffc0fad98b3704 get_arm64_ftr_reg+0x30 ([kernel.kallsyms])
   false_sharing.e  414489 [005] 775348.899297:          1                                                  branch:   br miss                   ffff8266da60     ffff8266dafc __sprintf_chk@plt+0xc (/usr/lib/aarch64-linux-gnu/libnuma.so.1.0.0)
   false_sharing.e  414489 [005] 775348.899297:          1                                            instructions:   br miss                   ffff8266da60     ffff8266dafc __sprintf_chk@plt+0xc (/usr/lib/aarch64-linux-gnu/libnuma.so.1.0.0)
   false_sharing.e  414489 [005] 775348.899297:          1                                                  branch:   br miss                   ffff826a44ec     ffff826a44e8 strcmp+0xa8 (/usr/lib/aarch64-linux-gnu/ld-2.31.so)
   false_sharing.e  414489 [005] 775348.899297:          1                                            instructions:   br miss                   ffff826a44ec     ffff826a44e8 strcmp+0xa8 (/usr/lib/aarch64-linux-gnu/ld-2.31.so)
   false_sharing.e  414489 [005] 775348.899298:          1                                            instructions:                                        0 ffffc0fadaad6124 mas_walk+0x274 ([kernel.kallsyms])
   false_sharing.e  414489 [005] 775348.899300:          1                                            instructions:                                        0 ffffc0fad9b3d98c next_uptodate_folio+0x2a4 ([kernel.kallsyms])
   false_sharing.e  414489 [005] 775348.899301:          1                                            instructions:                                        0 ffffc0fad98c3dcc __sync_icache_dcache+0x5c ([kernel.kallsyms])
   false_sharing.e  414489 [005] 775348.899301:          1                                                  branch:   jmp                   ffffc0fad9ba7f24 ffffc0fad9ba99c0 folio_add_file_rmap_ptes+0x48 ([kernel.kallsyms])
   false_sharing.e  414489 [005] 775348.899301:          1                                            instructions:   jmp                   ffffc0fad9ba7f24 ffffc0fad9ba99c0 folio_add_file_rmap_ptes+0x48 ([kernel.kallsyms])
   false_sharing.e  414489 [005] 775348.899306:          1                                            instructions:                                        0 ffffc0fad9b3f184 filemap_map_pages+0x178 ([kernel.kallsyms])
   false_sharing.e  414489 [005] 775348.899307:          1                                                  branch:   jmp                   ffffc0fad9b3d7b0 ffffc0fad9b3d7ac next_uptodate_folio+0xc4 ([kernel.kallsyms])
   false_sharing.e  414489 [005] 775348.899307:          1                                            instructions:   jmp                   ffffc0fad9b3d7b0 ffffc0fad9b3d7ac next_uptodate_folio+0xc4 ([kernel.kallsyms])
   false_sharing.e  414489 [005] 775348.899307:          1                                            instructions:                                        0 ffffc0fad9b3d98c next_uptodate_folio+0x2a4 ([kernel.kallsyms])
   false_sharing.e  414489 [005] 775348.899308:          1                                                  branch:   jmp                   ffffc0fad9ef3da4 ffffc0fad9ef3d70 bsearch+0x58 ([kernel.kallsyms])
   false_sharing.e  414489 [005] 775348.899308:          1                                            instructions:   jmp                   ffffc0fad9ef3da4 ffffc0fad9ef3d70 bsearch+0x58 ([kernel.kallsyms])
   false_sharing.e  414489 [005] 775348.899310:          1                                                  branch:   jmp                   ffffc0fad98a2158 ffffc0fad98a159c el0t_64_sync+0x198 ([kernel.kallsyms])
   false_sharing.e  414489 [005] 775348.899310:          1                                            instructions:   jmp                   ffffc0fad98a2158 ffffc0fad98a159c el0t_64_sync+0x198 ([kernel.kallsyms])
   ...

After:
  perf script --itrace=i1ibl -F,+flags,+addr,+brstack
   false_sharing.e  414489 [005] 775348.899294:          1                                                  branch:   return                ffffc0fad9ef3d68 ffffc0fad98b2c68 search_cmp_ftr_reg+0x8 ([kernel.kallsyms]) 0xffffc0fad98b2c68 ([kernel.kallsyms])/0xffffc0fad9ef3d68 ([kernel.kallsyms])/P/-/-/5/RET/- 
   false_sharing.e  414489 [005] 775348.899294:          1                                            instructions:   return                ffffc0fad9ef3d68 ffffc0fad98b2c68 search_cmp_ftr_reg+0x8 ([kernel.kallsyms]) 0xffffc0fad98b2c68 ([kernel.kallsyms])/0xffffc0fad9ef3d68 ([kernel.kallsyms])/P/-/-/5/RET/- 
   false_sharing.e  414489 [005] 775348.899294:          1                                                  branch:   jcc/not_taken/        ffffc0fad98b3708 ffffc0fad98b3704 get_arm64_ftr_reg+0x30 ([kernel.kallsyms]) 0xffffc0fad98b3704 ([kernel.kallsyms])/0xffffc0fad98b3708 ([kernel.kallsyms])/PN/-/-/6/COND/- 
   false_sharing.e  414489 [005] 775348.899294:          1                                            instructions:   jcc/not_taken/        ffffc0fad98b3708 ffffc0fad98b3704 get_arm64_ftr_reg+0x30 ([kernel.kallsyms]) 0xffffc0fad98b3704 ([kernel.kallsyms])/0xffffc0fad98b3708 ([kernel.kallsyms])/PN/-/-/6/COND/- 
   false_sharing.e  414489 [005] 775348.899297:          1                                                  branch:   return/miss/              ffff8266da60     ffff8266dafc __sprintf_chk@plt+0xc (/usr/lib/aarch64-linux-gnu/libnuma.so.1.0.0) 0xffff8266dafc (/usr/lib/aarch64-linux-gnu/libnuma.so.1.0.0)/0xffff8266da60 (/usr/lib/aarch64-linux-gnu/libnuma.so.1.0.0)/M/-/-/12/RET/- 
   false_sharing.e  414489 [005] 775348.899297:          1                                            instructions:   return/miss/              ffff8266da60     ffff8266dafc __sprintf_chk@plt+0xc (/usr/lib/aarch64-linux-gnu/libnuma.so.1.0.0) 0xffff8266dafc (/usr/lib/aarch64-linux-gnu/libnuma.so.1.0.0)/0xffff8266da60 (/usr/lib/aarch64-linux-gnu/libnuma.so.1.0.0)/M/-/-/12/RET/- 
   false_sharing.e  414489 [005] 775348.899297:          1                                                  branch:   jcc/miss,not_taken/       ffff826a44ec     ffff826a44e8 strcmp+0xa8 (/usr/lib/aarch64-linux-gnu/ld-2.31.so) 0xffff826a44e8 (/usr/lib/aarch64-linux-gnu/ld-2.31.so)/0xffff826a44ec (/usr/lib/aarch64-linux-gnu/ld-2.31.so)/MN/-/-/23/COND/- 
   false_sharing.e  414489 [005] 775348.899297:          1                                            instructions:   jcc/miss,not_taken/       ffff826a44ec     ffff826a44e8 strcmp+0xa8 (/usr/lib/aarch64-linux-gnu/ld-2.31.so) 0xffff826a44e8 (/usr/lib/aarch64-linux-gnu/ld-2.31.so)/0xffff826a44ec (/usr/lib/aarch64-linux-gnu/ld-2.31.so)/MN/-/-/23/COND/- 
   false_sharing.e  414489 [005] 775348.899298:          1                                            instructions:                                        0 ffffc0fadaad6124 mas_walk+0x274 ([kernel.kallsyms])
   false_sharing.e  414489 [005] 775348.899300:          1                                            instructions:                                        0 ffffc0fad9b3d98c next_uptodate_folio+0x2a4 ([kernel.kallsyms])
   false_sharing.e  414489 [005] 775348.899301:          1                                            instructions:                                        0 ffffc0fad98c3dcc __sync_icache_dcache+0x5c ([kernel.kallsyms])
   false_sharing.e  414489 [005] 775348.899301:          1                                                  branch:   jmp                   ffffc0fad9ba7f24 ffffc0fad9ba99c0 folio_add_file_rmap_ptes+0x48 ([kernel.kallsyms]) 0xffffc0fad9ba99c0 ([kernel.kallsyms])/0xffffc0fad9ba7f24 ([kernel.kallsyms])/P/-/-/8//- 
   false_sharing.e  414489 [005] 775348.899301:          1                                            instructions:   jmp                   ffffc0fad9ba7f24 ffffc0fad9ba99c0 folio_add_file_rmap_ptes+0x48 ([kernel.kallsyms]) 0xffffc0fad9ba99c0 ([kernel.kallsyms])/0xffffc0fad9ba7f24 ([kernel.kallsyms])/P/-/-/8//- 
   false_sharing.e  414489 [005] 775348.899306:          1                                            instructions:                                        0 ffffc0fad9b3f184 filemap_map_pages+0x178 ([kernel.kallsyms])
   false_sharing.e  414489 [005] 775348.899307:          1                                                  branch:   jcc/not_taken/        ffffc0fad9b3d7b0 ffffc0fad9b3d7ac next_uptodate_folio+0xc4 ([kernel.kallsyms]) 0xffffc0fad9b3d7ac ([kernel.kallsyms])/0xffffc0fad9b3d7b0 ([kernel.kallsyms])/PN/-/-/15/COND/- 
   false_sharing.e  414489 [005] 775348.899307:          1                                            instructions:   jcc/not_taken/        ffffc0fad9b3d7b0 ffffc0fad9b3d7ac next_uptodate_folio+0xc4 ([kernel.kallsyms]) 0xffffc0fad9b3d7ac ([kernel.kallsyms])/0xffffc0fad9b3d7b0 ([kernel.kallsyms])/PN/-/-/15/COND/- 
   false_sharing.e  414489 [005] 775348.899307:          1                                            instructions:                                        0 ffffc0fad9b3d98c next_uptodate_folio+0x2a4 ([kernel.kallsyms])
   false_sharing.e  414489 [005] 775348.899308:          1                                                  branch:   jcc                   ffffc0fad9ef3da4 ffffc0fad9ef3d70 bsearch+0x58 ([kernel.kallsyms]) 0xffffc0fad9ef3d70 ([kernel.kallsyms])/0xffffc0fad9ef3da4 ([kernel.kallsyms])/P/-/-/20/COND/- 
   false_sharing.e  414489 [005] 775348.899308:          1                                            instructions:   jcc                   ffffc0fad9ef3da4 ffffc0fad9ef3d70 bsearch+0x58 ([kernel.kallsyms]) 0xffffc0fad9ef3d70 ([kernel.kallsyms])/0xffffc0fad9ef3da4 ([kernel.kallsyms])/P/-/-/20/COND/- 
   false_sharing.e  414489 [005] 775348.899310:          1                                                  branch:   jmp                   ffffc0fad98a2158 ffffc0fad98a159c el0t_64_sync+0x198 ([kernel.kallsyms]) 0xffffc0fad98a159c ([kernel.kallsyms])/0xffffc0fad98a2158 ([kernel.kallsyms])/P/-/-/5//- 
   false_sharing.e  414489 [005] 775348.899310:          1                                            instructions:   jmp                   ffffc0fad98a2158 ffffc0fad98a159c el0t_64_sync+0x198 ([kernel.kallsyms]) 0xffffc0fad98a159c ([kernel.kallsyms])/0xffffc0fad98a2158 ([kernel.kallsyms])/P/-/-/5//- 
   ...


Leo Yan (11):
  perf script: Make printing flags reliable
  perf script: Refactor sample_flags_to_name() function
  perf script: Separate events from branch types
  perf script: Add not taken event for branches
  perf script: Add not taken event for branch stack
  perf arm-spe: Extend branch operations
  perf arm-spe: Decode transactional event
  perf arm-spe: Fill branch operations and events to record
  perf arm-spe: Set sample flags with supplement info
  perf arm-spe: Add branch stack
  perf arm-spe: Support previous branch target (PBT) address

 tools/perf/builtin-script.c                   |  30 ++--
 .../util/arm-spe-decoder/arm-spe-decoder.c    |  23 ++-
 .../util/arm-spe-decoder/arm-spe-decoder.h    |  11 +-
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     |  14 +-
 .../arm-spe-decoder/arm-spe-pkt-decoder.h     |  12 +-
 tools/perf/util/arm-spe.c                     | 135 ++++++++++++++++++
 tools/perf/util/branch.h                      |   3 +-
 tools/perf/util/event.h                       |  12 +-
 tools/perf/util/trace-event-scripting.c       | 116 +++++++++++----
 tools/perf/util/trace-event.h                 |   2 +
 10 files changed, 307 insertions(+), 51 deletions(-)

-- 
2.34.1

