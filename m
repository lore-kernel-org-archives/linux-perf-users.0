Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FAD158219;
	Fri, 28 Jun 2024 17:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719596808; cv=none; b=gzs9ZsTzOp70XoaiAOL0r780hYwKM101qyR9zoIuNLlhYEJdS+sI7dcr1xaPZT/6+Ro50nLwEvN8BviCMN691HouRSNcKOiar5rlMazz0waQLPlP8HyoABFGGqjoJFUQsE7cqhQS0xpwwpd515d7WOuA61nJVRP3EIXEeQrWCfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719596808; c=relaxed/simple;
	bh=nE1laE1r0oTP32KAdyXF+H8t0tKQ3Zjrg8yW/mvZQ0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pCU7C1tGxT483uTd7XLDLFWkeDmcoQwUIqGceLmxXM+9M3qluRlLWTCvyxmon4em7LH5hiB84aEaG+hippPhjWzDLB+TC6QqW4fCaSxpIlTILQNKnV1dJ1zwoOVX6U7UFAIIqMplpibVcUhENo9plAEqQhPlWL50+HNYZ6Aqwis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=e4dhdpEp; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="e4dhdpEp"
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 45SHjjqM3118844
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 28 Jun 2024 10:45:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 45SHjjqM3118844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1719596751;
	bh=HvQfDLFw796OnEOGySdnHV+nxv/wyItcNcp+7+/wPBE=;
	h=From:To:Cc:Subject:Date:From;
	b=e4dhdpEpCH3xDLVjfLCWrqPLBWHimRp4qgnPteTL1579QWaI6idfDXbnp2+Z60hQi
	 0WkmlLHtAy0u5kNj49QgvsDhlApUGlWqbkn8fFniNxrEpxesmpEX6vchSQMJBM5YEv
	 aeOpNMKxdbExNGSsm3sMlOB6v+bnE2wF2oo/NecfzmmKZWTd1AO/TqIyqzplPkyWqq
	 a4/xKAbnG2kYvdm2baCKkSHnTaZ62eN33BFg1mNgb0AE4RA76jgXZ7BVHW/PvkK0Ls
	 4haHrYUlVulJZxtu0FHzFQHszNZ89rcl7qxR9aiS2M30CrMzEexd9q65gJ4aXogbbA
	 ZfXW6pABVjI3g==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        acme@kernel.org, namhyung@kernel.org, brgerst@gmail.com,
        andrew.cooper3@citrix.com, nik.borisov@suse.com
Subject: [PATCH v4 0/4] x86/cpufeatures: Automatically generate required and disabled feature masks
Date: Fri, 28 Jun 2024 10:45:40 -0700
Message-ID: <20240628174544.3118826-1-xin@zytor.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The x86 build process first generates required and disabled feature
masks based on current build config, and then uses these generated
masks to compile the source code. When a CPU feature is not enabled
in a build config, e.g., when CONFIG_X86_FRED=n, its feature disable
flag, i.e., DISABLE_FRED, needs to be properly defined and added to
a specific disabled CPU features mask in <asm/disabled-features.h>,
as the following patch does:
https://lore.kernel.org/all/20231205105030.8698-8-xin3.li@intel.com/.
As a result, the FRED feature bit is surely cleared in the generated
kernel binary when CONFIG_X86_FRED=n.

Recently there is another case to repeat the same exercise for the
AMD SEV-SNP CPU feature:
https://lore.kernel.org/all/20240126041126.1927228-2-michael.roth@amd.com/.
https://lore.kernel.org/all/20240126041126.1927228-23-michael.roth@amd.com/.

It was one thing when there were four of CPU feature masks, but with
over 20 it is going to cause mistakes, e.g.,
https://lore.kernel.org/lkml/aaed79d5-d683-d1bc-7ba1-b33c8d6db618@suse.com/.

We want to eliminate the stupidly repeated exercise to manually assign
features to CPU feature words through introducing an AWK script to
automatically generate a header with required and disabled CPU feature
masks based on current build config, and this patch set does that.

Link to v3:
https://lore.kernel.org/lkml/20240622171435.3725548-1-xin@zytor.com/

Changes since v3:
* Add a few high-level comments to the AWK script (Nikolay Borisov).
* Use '1U' instead of '1' in feature mask shifting (Andrew Cooper).
* Checking NCAPINTS isn't necessary anymore.  It was needed when these
  macros had to be manually updated, but now if cpufeatures.h changes
  this header will be regenerated (Brian Gerst).
* Enforce CPU feature mask values to be unsigned.

Changes since v2:
* Remove AWK code that generates extra debugging comments (Brian Gerst).
* Move SSE_MASK to verify_cpu.S, the only place it is used (Brian Gerst).
* Add a patch to generate macros {REQUIRED|DISABLED}_MASK_BIT_SET in the
  new AWK script (Brian Gerst).

Changes since v1:
* Keep the X86_{REQUIRED,DISABLED}_FEATURE_ prefixes solely in
  arch/x86/Kconfig.cpufeatures (Borislav Petkov).
* Explain how config option names X86_{REQUIRED,DISABLED}_FEATURE_<name>
  are formed (Borislav Petkov).
* Remove code generating unused macros {REQUIRED,DISABLED}_FEATURE(x)
  to tell if a CPU feature, e.g., X86_FEATURE_FRED, is a required or
  disabled feature for this particular compile-time configuration.


H. Peter Anvin (Intel) (2):
  x86/cpufeatures: Add {required,disabled} feature configs
  x86/cpufeatures: Generate a feature mask header based on build config

Xin Li (Intel) (2):
  x86/cpufeatures: Remove {disabled,required}-features.h
  x86/cpufeatures: Use AWK to generate {REQUIRED|DISABLED}_MASK_BIT_SET

 arch/x86/Kconfig                              |   4 +-
 arch/x86/Kconfig.cpu                          |  12 +-
 arch/x86/Kconfig.cpufeatures                  | 197 ++++++++++++++++++
 arch/x86/Makefile                             |  17 +-
 arch/x86/boot/cpucheck.c                      |   3 +-
 arch/x86/boot/cpuflags.c                      |   1 -
 arch/x86/boot/mkcpustr.c                      |   3 +-
 arch/x86/include/asm/Kbuild                   |   1 +
 arch/x86/include/asm/asm-prototypes.h         |   2 +-
 arch/x86/include/asm/atomic64_32.h            |   2 +-
 arch/x86/include/asm/bitops.h                 |   4 +-
 arch/x86/include/asm/cmpxchg_32.h             |   2 +-
 arch/x86/include/asm/cpufeature.h             |  70 +------
 arch/x86/include/asm/cpufeatures.h            |   8 -
 arch/x86/include/asm/disabled-features.h      | 161 --------------
 arch/x86/include/asm/required-features.h      | 105 ----------
 arch/x86/kernel/verify_cpu.S                  |   4 +
 arch/x86/lib/Makefile                         |   2 +-
 arch/x86/lib/cmpxchg8b_emu.S                  |   2 +-
 arch/x86/tools/featuremasks.awk               |  92 ++++++++
 lib/atomic64_test.c                           |   2 +-
 tools/arch/x86/include/asm/cpufeatures.h      |   8 -
 .../arch/x86/include/asm/disabled-features.h  | 161 --------------
 .../arch/x86/include/asm/required-features.h  | 105 ----------
 tools/perf/check-headers.sh                   |   2 -
 25 files changed, 325 insertions(+), 645 deletions(-)
 create mode 100644 arch/x86/Kconfig.cpufeatures
 delete mode 100644 arch/x86/include/asm/disabled-features.h
 delete mode 100644 arch/x86/include/asm/required-features.h
 create mode 100755 arch/x86/tools/featuremasks.awk
 delete mode 100644 tools/arch/x86/include/asm/disabled-features.h
 delete mode 100644 tools/arch/x86/include/asm/required-features.h


base-commit: f6a465a2d29701aa1a5189cae63a6870b65cef48
-- 
2.45.2

