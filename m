Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3154E186E26;
	Sun, 16 Jun 2024 08:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718528303; cv=none; b=rvmUBgqWchP6WTCB9IYuOfXVQvgTgjMq7Y3u5lS54UCDQFhZE0bpbItoPB+dBjT5yk6/puVl2nWAbTcDTNkSJwu0RcHj14QGTMb3YBMQyPmW5ABnrk3G3g1/HRlwVIZl/AT0UFxRzHQkcOzFCuIi9OZUb0x2XjhHrkw7S1YtgpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718528303; c=relaxed/simple;
	bh=ysxXEWdSdFeJRANHElWTANKfJwhXp9/aaLwfLeDh3nI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KKFpzRM1uhgeMOcP18nE4s4eLAS+FOFui+c300njQTTwJMQyUfElzj1y3ZbIpH/bOtlk01i9UL/twGUG8CbRpyHlXyw/g1OqQ2Z80frGajWkEPaVP1qtxj7KFOn8VlHneo9ODYtUTLwfe6mqmptn9o/zmD/xRzlEqi5AgadgdAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=qdCi3pKR; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="qdCi3pKR"
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 45G8viDj1100721
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 16 Jun 2024 01:57:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 45G8viDj1100721
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024051501; t=1718528269;
	bh=tORcu0KzoezwP+svxxymeaOgQSsooEptNlD6MZV7h1Q=;
	h=From:To:Cc:Subject:Date:From;
	b=qdCi3pKRGBCyGMdQv4641rh0aeln7aK5WhliHJsJRT96xGzVAtLVF6JxHsFVeYOT3
	 4j2SHk7L6GXRcjmwrwyn64pz3RyaU3cqI2GyHTKUAQ3yQsHzEOXiKHW/oHWiyaUqIm
	 qr5AYgD8SBEU+8piD8gSVZa/24cJsBFL1GbOiLU6hG6CcepnR5Xk4u5F7mpcbjIVty
	 ijE70paxJ2/9ILUjciaKBtGwzTTB/YXLDpWgrHMebYXKkx47AyQeEnLIyGFyUrQAUB
	 TkdnPmljF/txTz90cPvAEpQ3x8Uwi7Mk/euxA+H33SSi3+F8n91PAugSgtoOsBsSOw
	 RvG9Ij1oNcxpg==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        acme@kernel.org, namhyung@kernel.org
Subject: [PATCH v2 0/3] x86/cpufeatures: Automatically generate required and disabled feature masks
Date: Sun, 16 Jun 2024 01:57:40 -0700
Message-ID: <20240616085743.1100704-1-xin@zytor.com>
X-Mailer: git-send-email 2.45.1
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

Xin Li (Intel) (1):
  x86/cpufeatures: Remove {disabled,required}-features.h

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
 arch/x86/include/asm/cpufeature.h             |   1 +
 arch/x86/include/asm/cpufeatures.h            |   8 -
 arch/x86/include/asm/disabled-features.h      | 161 --------------
 arch/x86/include/asm/required-features.h      | 105 ----------
 arch/x86/kernel/verify_cpu.S                  |   1 +
 arch/x86/lib/Makefile                         |   2 +-
 arch/x86/lib/cmpxchg8b_emu.S                  |   2 +-
 arch/x86/tools/featuremasks.awk               |  90 ++++++++
 lib/atomic64_test.c                           |   2 +-
 tools/arch/x86/include/asm/cpufeatures.h      |   8 -
 .../arch/x86/include/asm/disabled-features.h  | 161 --------------
 .../arch/x86/include/asm/required-features.h  | 105 ----------
 tools/perf/check-headers.sh                   |   2 -
 25 files changed, 320 insertions(+), 576 deletions(-)
 create mode 100644 arch/x86/Kconfig.cpufeatures
 delete mode 100644 arch/x86/include/asm/disabled-features.h
 delete mode 100644 arch/x86/include/asm/required-features.h
 create mode 100755 arch/x86/tools/featuremasks.awk
 delete mode 100644 tools/arch/x86/include/asm/disabled-features.h
 delete mode 100644 tools/arch/x86/include/asm/required-features.h


base-commit: 49b33979e3bf0a5424420d14f026de12f34e8b1e
-- 
2.45.1

