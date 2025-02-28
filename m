Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC702459FD;
	Fri, 28 Feb 2025 08:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731070; cv=none; b=jdAkdRzzcaHZYAWPqVmehBw3Qr/OyTVwmWXH9Jobt/cugCx9I9flWHS6YJ6hMD61Kc5STIHSq2K0vMZXey4quT5T95wHWqzmRwjmVjDL6kBGO+ZFnOUNa1cFmUVbkPGti63YyWimPw3DXU77J/R5NLKt9gERBwahEx6Bz63GrCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731070; c=relaxed/simple;
	bh=HXD5N5EUSKiVZel/nNTVsehaZTF0tGP8+UG+FaEScRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tp6CmC49WnS6sxbWnY+6/0O9cjrIeMzOlBaWDMLNsmUJklFUCzSW1mYd8RrHtpaJIETHazD2/YTb9fMjmfirRUlMm1rfqxbMsqihpaVjhOYh4EidcCG+2+ILISTjttmbv4lpQ0PTAN0QO84Bfp+JwXELKW4tVUKPfdjJw56/j3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=pXU1ZTv6; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="pXU1ZTv6"
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51S8NdZV073880
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 28 Feb 2025 00:23:44 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51S8NdZV073880
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1740731025;
	bh=wJH2YVKtRVpRZeg1F2uDv6eR5my1DkG7+jj9x2YNq7g=;
	h=From:To:Cc:Subject:Date:From;
	b=pXU1ZTv6uV/hcbwru91MHZBY1kks2thOa1n08j0kpmCA2l51euKCBmM1VdMKkke2J
	 J0dI1rcoRmkmEzXzrdyU5bSMNVO/K+Dqg68D28b6I9YQX3maxRc5aNJNjdN6RJSOMA
	 rL8zRThJsVUdkIKdkTa/YHE/hjNk3oThXd3DbL2FzpeEQeQd8xfQBT3VLpwqSu10Du
	 XyRKqfre5Dpz5v4QqZtczCdJ3jW4aUrhMfXfanQnc96rU46B3OKsgXSrFQ15YSA5zB
	 Dm4NNxTKi1xQIPzFIZ5IMmPrNFEoD0Dh5jt0DYzEz88XsprKWVcp3De/Miah/kDW8p
	 QyPTK+6Rns/uQ==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        will@kernel.org, peterz@infradead.org, yury.norov@gmail.com,
        akpm@linux-foundation.org, acme@kernel.org, namhyung@kernel.org,
        brgerst@gmail.com, andrew.cooper3@citrix.com, nik.borisov@suse.com
Subject: [PATCH v6 0/5] x86/cpufeatures: Automatically generate required and disabled feature masks
Date: Fri, 28 Feb 2025 00:23:33 -0800
Message-ID: <20250228082338.73859-1-xin@zytor.com>
X-Mailer: git-send-email 2.48.1
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

Link to v5:
https://lore.kernel.org/lkml/20250106070727.3211006-1-xin@zytor.com/


H. Peter Anvin (Intel) (3):
  x86/cpufeatures: Rename X86_CMPXCHG64 to X86_CX8
  x86/cpufeatures: Add {required,disabled} feature configs
  x86/cpufeatures: Generate a feature mask header based on build config

Xin Li (Intel) (2):
  x86/cpufeatures: Remove {disabled,required}-features.h
  x86/cpufeatures: Use AWK to generate {REQUIRED|DISABLED}_MASK_BIT_SET

 arch/x86/Kconfig                              |   4 +-
 arch/x86/Kconfig.cpu                          |   4 +-
 arch/x86/Kconfig.cpufeatures                  | 197 ++++++++++++++++++
 arch/x86/Makefile                             |  17 +-
 arch/x86/boot/cpucheck.c                      |   3 +-
 arch/x86/boot/cpuflags.c                      |   1 -
 arch/x86/boot/mkcpustr.c                      |   3 +-
 arch/x86/include/asm/Kbuild                   |   1 +
 arch/x86/include/asm/asm-prototypes.h         |   2 +-
 arch/x86/include/asm/atomic64_32.h            |   2 +-
 arch/x86/include/asm/cmpxchg_32.h             |   2 +-
 arch/x86/include/asm/cpufeature.h             |  70 +------
 arch/x86/include/asm/cpufeatures.h            |   8 -
 arch/x86/include/asm/disabled-features.h      | 161 --------------
 arch/x86/include/asm/required-features.h      | 105 ----------
 arch/x86/kernel/verify_cpu.S                  |   4 +
 arch/x86/lib/Makefile                         |   2 +-
 arch/x86/lib/cmpxchg8b_emu.S                  |   2 +-
 arch/x86/tools/featuremasks.awk               |  88 ++++++++
 lib/atomic64_test.c                           |   2 +-
 tools/arch/x86/include/asm/cpufeatures.h      |   8 -
 .../arch/x86/include/asm/disabled-features.h  | 161 --------------
 .../arch/x86/include/asm/required-features.h  | 105 ----------
 tools/perf/check-headers.sh                   |   2 -
 24 files changed, 320 insertions(+), 634 deletions(-)
 create mode 100644 arch/x86/Kconfig.cpufeatures
 delete mode 100644 arch/x86/include/asm/disabled-features.h
 delete mode 100644 arch/x86/include/asm/required-features.h
 create mode 100755 arch/x86/tools/featuremasks.awk
 delete mode 100644 tools/arch/x86/include/asm/disabled-features.h
 delete mode 100644 tools/arch/x86/include/asm/required-features.h


base-commit: 0b8c04b9207d5ee92ab3b341f0211aaf2c0b6976
-- 
2.48.1

