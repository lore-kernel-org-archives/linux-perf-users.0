Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1828B1D5CCD;
	Mon,  6 Jan 2025 07:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736147484; cv=none; b=SJkocai8gGTow4rjdpoVhDGB0mFVqSxSHMokEIgAPxm2XryPOlWMqaYeeChRKrdal1lNDD6isPL1WS+QSYt5+zUD1AFLrSG9YGiRA4bcmFjuoirGz7FwKybsoJ/G076ThwOaE3nijiRZ9l0ReUDBlSQlap/GZCCRzkjhm9LZagM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736147484; c=relaxed/simple;
	bh=/GDhJnOK0EkxOF67eXXdSHrVKFil2YfOql/F1iwFY5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iC7x7ThqS5dFmAKGiL0fBPt1tH0K/Iby4vRQ87ik7wiIHU//aan1agIOGk5yzNRzzc4DUjw0TJBTLTd+V5p/TSFvzyXAQrAkOXu3nTRVg4y0qUPh4h9Z6S/NnL6zfGDvPe3s8FFyBgTkHXqOlPa1QRijWwvDfDB9aiUbfITWgrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=gI+1W/NK; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="gI+1W/NK"
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 50677Rp93211026
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 5 Jan 2025 23:07:31 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 50677Rp93211026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024121701; t=1736147252;
	bh=JKas4NsBYT1pnURi4LNJU6Yf74fa71a42En+rq+V+BY=;
	h=From:To:Cc:Subject:Date:From;
	b=gI+1W/NKzNWNxmIoyahQR0VyhSQ+MgAJsvzoljs53qgxycQQ7gXMukaG5qhPHj9K7
	 CNoyxnTSyjxuZr0Y0QfMKMX3iTdvCxOS+/Tt1I9WYlRK+eQxXMcVGLROOqoBdl2U+d
	 hCN1H7xdguKzq5owuhTY3aN2/ZC74TVh2R4CrAFn3wc6oxLEPQhbe0uPU6RIzLwc69
	 V3I+a2KE4x2Op/JumfQtg5XqA7UEHUN3ieeuWCr451327Ry6I6+AFhiN4wPWFuICyR
	 qKLO7kHxxgIlri9oS2Vwl+6/dnH2TTQoBRNK60bgegUne8386NY2Bo3fciVRNumFiI
	 eHNmljYkhicRQ==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        will@kernel.org, peterz@infradead.org, yury.norov@gmail.com,
        akpm@linux-foundation.org, acme@kernel.org, namhyung@kernel.org,
        brgerst@gmail.com, andrew.cooper3@citrix.com, nik.borisov@suse.com
Subject: [PATCH v5 0/5] x86/cpufeatures: Automatically generate required and disabled feature masks
Date: Sun,  5 Jan 2025 23:07:22 -0800
Message-ID: <20250106070727.3211006-1-xin@zytor.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The x86 build process first generates required and disabled feature
masks based on current build config, and then uses these generated
masks to compile the source code.  When a CPU feature is not enabled
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

Recently when working on the immediate form of MSR access instructions,
I needed to add a new CPU feature word for CPUID.7.1.ECX, and I had to
replace the same check "(NCAPINTS != 22)" with (NCAPINTS != 23) in 3
different files as
https://github.com/xinli-intel/linux-fred-public/commit/aa80536927fcd293be8ae54e1d5e4d886cf83f21
Obviously these replacements could be saved if the patch to add a new
CPU feature word is reworked on top of this patch set.

So this seems a good opportunity to demonstrate the convenience out of
this patch set, and here comes v5 with just one more patch on top of v4
that adds a new CPU feature word for CPUID.7.1.ECX and uses it for the
immediate form of MSR access feature.

Link to v4:
https://lore.kernel.org/lkml/20240628174544.3118826-1-xin@zytor.com/


H. Peter Anvin (Intel) (2):
  x86/cpufeatures: Add {required,disabled} feature configs
  x86/cpufeatures: Generate a feature mask header based on build config

Xin Li (Intel) (3):
  x86/cpufeatures: Remove {disabled,required}-features.h
  x86/cpufeatures: Use AWK to generate {REQUIRED|DISABLED}_MASK_BIT_SET
  x86/cpufeatures: Add the CPU feature bit for MSR immediate form
    instructions

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
 arch/x86/include/asm/cpufeature.h             |  71 +------
 arch/x86/include/asm/cpufeatures.h            |  13 +-
 arch/x86/include/asm/disabled-features.h      | 161 --------------
 arch/x86/include/asm/required-features.h      | 105 ----------
 arch/x86/kernel/cpu/common.c                  |   1 +
 arch/x86/kernel/verify_cpu.S                  |   4 +
 arch/x86/lib/Makefile                         |   2 +-
 arch/x86/lib/cmpxchg8b_emu.S                  |   2 +-
 arch/x86/tools/featuremasks.awk               |  88 ++++++++
 lib/atomic64_test.c                           |   2 +-
 tools/arch/x86/include/asm/cpufeatures.h      |   8 -
 .../arch/x86/include/asm/disabled-features.h  | 161 --------------
 .../arch/x86/include/asm/required-features.h  | 105 ----------
 tools/perf/check-headers.sh                   |   2 -
 26 files changed, 327 insertions(+), 646 deletions(-)
 create mode 100644 arch/x86/Kconfig.cpufeatures
 delete mode 100644 arch/x86/include/asm/disabled-features.h
 delete mode 100644 arch/x86/include/asm/required-features.h
 create mode 100755 arch/x86/tools/featuremasks.awk
 delete mode 100644 tools/arch/x86/include/asm/disabled-features.h
 delete mode 100644 tools/arch/x86/include/asm/required-features.h


base-commit: af2c8596bd2e455ae350ba1585bc938ee85aa38d
-- 
2.47.1

