Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFE21DD9AC;
	Wed,  5 Mar 2025 18:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200515; cv=none; b=j6Y+bBTgUxnJeXiTMvxJSVbK7yTOa81M1YBuCPQp8flScD8ZUhXnCvpyh4eW1ut/XO/VWOfuA+pm9bbwXHjfuVfZl+rkn+1th8zcRNLVhCqW7F/bTZB+45ic9B32iavYEYq3gt1qyjLBSqRS3b7TqqLSGm0apCrbTnSTCVd51jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200515; c=relaxed/simple;
	bh=IIRR0j0EA6OllIlVa1v7J4whrRpxr5hO1hZ4BQoMq6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nWRwY7wV4UTgMgvOJoCx1g7KF1MK84Q9wHHP/BHrn4KnVix+mZTggID7bpe3R/bcuROshFr24W95Q701FJz19zLbKAGIIG9xGQfbI2CbOBnyOU8hCcqO0JukG3NqFz9rbrfuaq0qjzbH074ezmUaPXaL+06sJuofN1heWhvWC8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Fc1mXLoh; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Fc1mXLoh"
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 525IlQXt3341787
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 5 Mar 2025 10:47:31 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 525IlQXt3341787
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741200452;
	bh=Kv2mG8/ef/H2lxxHE6kayNM8PX7zHm64gBQrRGDUHAg=;
	h=From:To:Cc:Subject:Date:From;
	b=Fc1mXLohNFtkW7wXQe5HLKN/knDyc2mTSzQU061jF/CVHF8z1SAj9Bce3VzPWo8Vf
	 PgDJAAetP/lrw4zp1Ub1yjTfuCDKiyDEHVyPl4/j16wnOLjr/CWmYpZaAipq4QUc4T
	 qs4cxklmepnKVd9bJLmh/4RazVKG7PvNNSeYZcmgAsSoWRndsGXsggwqRW219aDp7m
	 iTjV3MixWSQ3jg5XCU9EFpvE1wkAGnkCey9B6eN1vpGKAG1evU52UUknBQ9Ghm0xy3
	 /QaQN49vE3So8Hrq1tZkBHQsmDkVmjgj87Us6bUUv/lbYxULxWgSzDwGPQjhAma+yM
	 mRHR87J1ufp1Q==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        will@kernel.org, peterz@infradead.org, yury.norov@gmail.com,
        akpm@linux-foundation.org, acme@kernel.org, namhyung@kernel.org,
        brgerst@gmail.com, andrew.cooper3@citrix.com, nik.borisov@suse.com,
        sraithal@amd.com, philip.li@intel.com
Subject: [PATCH v7 0/4] x86/cpufeatures: Automatically generate required and disabled feature masks
Date: Wed,  5 Mar 2025 10:47:20 -0800
Message-ID: <20250305184725.3341760-1-xin@zytor.com>
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

Link to v6:
https://lore.kernel.org/lkml/20250228082338.73859-1-xin@zytor.com/

Changes in v7:
* Fix build error with "make distclean; make headers" (Aithal, Srikanth)
* Collect reviewed-bys.


H. Peter Anvin (Intel) (2):
  x86/cpufeatures: Add {required,disabled} feature configs
  x86/cpufeatures: Generate a feature mask header based on build config

Xin Li (Intel) (2):
  x86/cpufeatures: Remove {disabled,required}-features.h
  x86/cpufeatures: Use AWK to generate {REQUIRED|DISABLED}_MASK_BIT_SET

 arch/x86/Kconfig                              |   2 +
 arch/x86/Kconfig.cpufeatures                  | 197 ++++++++++++++++++
 arch/x86/Makefile                             |  15 ++
 arch/x86/boot/cpucheck.c                      |   3 +-
 arch/x86/boot/cpuflags.c                      |   1 -
 arch/x86/boot/mkcpustr.c                      |   3 +-
 arch/x86/include/asm/Kbuild                   |   1 +
 arch/x86/include/asm/cpufeature.h             |  70 +------
 arch/x86/include/asm/cpufeatures.h            |   8 -
 arch/x86/include/asm/disabled-features.h      | 161 --------------
 arch/x86/include/asm/required-features.h      | 105 ----------
 arch/x86/kernel/verify_cpu.S                  |   4 +
 arch/x86/tools/featuremasks.awk               |  88 ++++++++
 tools/arch/x86/include/asm/cpufeatures.h      |   8 -
 .../arch/x86/include/asm/disabled-features.h  | 161 --------------
 .../arch/x86/include/asm/required-features.h  | 105 ----------
 tools/perf/check-headers.sh                   |   2 -
 17 files changed, 311 insertions(+), 623 deletions(-)
 create mode 100644 arch/x86/Kconfig.cpufeatures
 delete mode 100644 arch/x86/include/asm/disabled-features.h
 delete mode 100644 arch/x86/include/asm/required-features.h
 create mode 100755 arch/x86/tools/featuremasks.awk
 delete mode 100644 tools/arch/x86/include/asm/disabled-features.h
 delete mode 100644 tools/arch/x86/include/asm/required-features.h


base-commit: 32dc26a2f55f71907af0874468298c6ab8a8f7f9
-- 
2.48.1

