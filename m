Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F3F80617;
	Thu,  9 May 2024 21:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715289478; cv=none; b=IYpz+bKWAFf9MtuBPm3CTaF3iZ1CeAf+0pkmGN6vzTcE0IEP2Na4wb9xr7QdqjefVKRZro84h+bH2XELj7a+UpP+IUvQ5rgQnwPG4E6bm2KnPYOV/vADLp41mCZ1rCnZbrref9JuenGtNE8VCfD7UT6gL2WrI920rXs1H4HkKkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715289478; c=relaxed/simple;
	bh=vsD/zS7+TFNOgtj4eanUGUTBn6O+1OLB13dUHr9Udzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tMAaFdlaXZXBsJZ+4AS8OyrZOntXU0hTYeUsYoMefdpPyPrNqjUe2649Xp3VRrMdGa3br9XyKIFvvS1KQUrvDjULWt2uu8+1u785EJ7MrtcsoqA1k3L5BuBamv4ot4Kmy9Zf4Lmo7VT0nxJYR4WoL4Gd8LFkWUbKiTi4eMTeaX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=bJKZuPBW; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="bJKZuPBW"
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 449KrevR275586
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 9 May 2024 13:53:45 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 449KrevR275586
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024041401; t=1715288025;
	bh=3NuCs54JWW873zlaANJk0I8LXskrd6ND/8ULrWrDZMg=;
	h=From:To:Cc:Subject:Date:From;
	b=bJKZuPBWMjo6D5z4eedNLPsqZX5F9DCry5XXycBGAGXUQ2k3bUoRS7krdyZDCQxHt
	 aSvktQc92znztwdLHbwdZYwUr1PYMvdWe+6dngGMtHZETY3GSVT25Jj9Yb8JU0vyGw
	 /BnLYVloXn5GovPOiU13q6V8JWz5HGoStfV6O4jOMfBtvNa7hdQP7Oqdi0U7BJAsuY
	 bgF/cMLB4csUcibVMluYybYEocwlfpErKcSiXfVSkB8BTo6BKVEgdrX1WLsg0wfFoL
	 Tvp8zuYij/E2B1HWFgOG5zch288fe4oCb4fflTKwzC540UOB9x6Eaza2PEVqqscHjZ
	 +kFWL5asQzWiQ==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        acme@kernel.org, namhyung@kernel.org
Subject: [RESEND v1 0/3] x86/cpufeatures: Automatically generate required and disabled feature masks
Date: Thu,  9 May 2024 13:53:37 -0700
Message-ID: <20240509205340.275568-1-xin@zytor.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a rebase and resend of: https://lore.kernel.org/lkml/20240201054629.3816748-1-xin@zytor.com/.

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


H. Peter Anvin (Intel) (2):
  x86/cpufeatures: Add {required,disabled} feature configs
  x86/cpufeatures: Generate a feature mask header based on build config

Xin Li (Intel) (1):
  x86/cpufeatures: Remove {disabled,required}-features.h

 arch/x86/Kconfig                              |   4 +-
 arch/x86/Kconfig.cpu                          |  16 +-
 arch/x86/Kconfig.cpufeatures                  | 153 +++++++++++++++++
 arch/x86/Makefile                             |  17 +-
 arch/x86/boot/cpucheck.c                      |   3 +-
 arch/x86/boot/cpuflags.c                      |   1 -
 arch/x86/boot/mkcpustr.c                      |   3 +-
 arch/x86/include/asm/Kbuild                   |   1 +
 arch/x86/include/asm/asm-prototypes.h         |   2 +-
 arch/x86/include/asm/atomic64_32.h            |   2 +-
 arch/x86/include/asm/bitops.h                 |   4 +-
 arch/x86/include/asm/cmpxchg_32.h             |   2 +-
 arch/x86/include/asm/cpufeature.h             |   1 +
 arch/x86/include/asm/cpufeatures.h            |   8 -
 arch/x86/include/asm/disabled-features.h      | 161 ------------------
 arch/x86/include/asm/required-features.h      | 105 ------------
 arch/x86/kernel/verify_cpu.S                  |   1 +
 arch/x86/lib/Makefile                         |   2 +-
 arch/x86/lib/cmpxchg8b_emu.S                  |   2 +-
 arch/x86/tools/featuremasks.awk               | 108 ++++++++++++
 lib/atomic64_test.c                           |   2 +-
 tools/arch/x86/include/asm/cpufeatures.h      |   8 -
 .../arch/x86/include/asm/disabled-features.h  | 161 ------------------
 .../arch/x86/include/asm/required-features.h  | 105 ------------
 tools/perf/check-headers.sh                   |   2 -
 25 files changed, 306 insertions(+), 568 deletions(-)
 create mode 100644 arch/x86/Kconfig.cpufeatures
 delete mode 100644 arch/x86/include/asm/disabled-features.h
 delete mode 100644 arch/x86/include/asm/required-features.h
 create mode 100755 arch/x86/tools/featuremasks.awk
 delete mode 100644 tools/arch/x86/include/asm/disabled-features.h
 delete mode 100644 tools/arch/x86/include/asm/required-features.h


base-commit: c064e5cb8336a5ee3471cc6a376cc19e19aa85de
-- 
2.45.0

