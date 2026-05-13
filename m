Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13982DCBFA;
	Wed, 13 May 2026 15:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778687424; cv=none; b=fDpPe8opZgZxka5M74lON5iIJRnQ3JHg7F7btlZdsa+KyxMyzTB4Z7YGvaCtVoJmJVnYd9isa6pvuAZVgqgBBA0Ij61vTxCy/HP/r88/YJckugFAROvaUhiynfKmdhZR2T7ClVq0i6+DeGCHCCOtbmogRgWBj/6zIHJC+pGS4Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778687424; c=relaxed/simple;
	bh=ouQcjuz2+ju9NHrDszAZiEG4WZTp4sL4gcikKvMu+lM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hHJaeAljKopuv/OvJaHFp+HVhDyd1Enb56cIStSP2FtuE9/e4wpOlh4LDtguZKpmWVzq31YT7SAV7Av6bDn0s/XUVrz2c7hGEoG2jBywIUDJ8od80ezmMDqFXwjK/ZKRh/zIZ1ivUENWu2DYNTqtFuIm+9ST6XQat6tGAZE3Z7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from Lee.localdomain (unknown [39.152.152.253])
	by APP-01 (Coremail) with SMTP id qwCowACHMm6MnQRqEXQgEA--.35827S2;
	Wed, 13 May 2026 23:50:00 +0800 (CST)
From: Li Guan <guanli.oerv@isrc.iscas.ac.cn>
To: acme@kernel.org,
	namhyung@kernel.org
Cc: irogers@google.com,
	adrian.hunter@intel.com,
	palmer@dabbelt.com,
	pjw@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Li Guan <guanli.oerv@isrc.iscas.ac.cn>
Subject: [PATCH 0/3] perf build: Fix cross-arch build failures and GCC 14 warnings
Date: Wed, 13 May 2026 23:48:48 +0800
Message-ID: <20260513154851.1085334-1-guanli.oerv@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACHMm6MnQRqEXQgEA--.35827S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ArWrZr1Duw4UZFy3WF4fuFg_yoW8Ar43pF
	s8uw45Xr1DXr4Skw13Aay8WF13uaySga1Sq34ftw13Jr13tFy7tFyIyr1Yg3W7J34kJw12
	kr1qg3s8Wry5AF7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE
	5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeV
	CFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l
	FIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUY5l8UUUU
	U
X-CM-SenderInfo: hjxd0znlorv2ny6l223fol2u1dvotugofq/

This patch series addresses a set of build and linking failures encountered
when cross-compiling the perf tool for non-x86 architectures (specifically
RISC-V and ARM64), while also ensuring compatibility with stricter GCC 14
compiler checks.

The series resolves three distinct issues:

1. GCC 14 Compatibility: Fixes a -Werror=discarded-qualifiers build failure
   in the RISC-V specific code by explicitly casting strrchr() return
   values to (char *).
2. Hardware Tracing Isolation: Decouples arch-specific auxtrace objects
   (e.g., intel-pt, arm-spe) from the generic build process, preventing
   "No such file or directory" and undefined reference linker errors on
   architectures that lack these features.
3. Instruction Decoding Stubs: Provides global __weak stubs for dump_insn()
   and arch_is_uncond_branch() in builtin-script.c, resolving undefined
   reference linker errors on architectures (like RISC-V and ARM64) that do
   not yet implement hardware-specific instruction decoding.

These changes have been successfully verified via full builds across
x86_64, s390x, aarch64, and riscv64 architectures.

Li Guan (3):
  perf build: Fix cross-arch build failures by isolating auxtrace
    objects
  perf riscv: Fix discarded const qualifier error in _get_field()
  perf script: Provide weak stubs for instruction decoding

 tools/perf/Makefile.config          | 21 +++++++++
 tools/perf/arch/riscv/util/header.c |  4 +-
 tools/perf/builtin-script.c         | 22 +++++++++
 tools/perf/util/Build               | 20 ++++-----
 tools/perf/util/auxtrace.c          | 70 +++++++++++++++++++++++++++++
 tools/perf/util/auxtrace.h          |  6 +++
 6 files changed, 131 insertions(+), 12 deletions(-)

-- 
2.54.0

