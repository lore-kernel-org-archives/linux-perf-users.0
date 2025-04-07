Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0A020DD67;
	Mon,  7 Apr 2025 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744042809; cv=none; b=mZm7a+Rv6GbpKom2ZUfKNvAF77XM6lovqEnTAjwEFlL3/GjAMxle2IFeRQWAd03aTB6Hf5kP43v6+WCvFQyInxJ0kq4e+kocxGXgAY6cXoyWeoAJM+JDcSrTz7bQE4LI/tT05kbgrWgdiXTF1N1XGRbzGXE135MOlCZw42TK+b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744042809; c=relaxed/simple;
	bh=JDPA6wKqzvHim0qA4SSjZ7cp9/9aIauy8o/GHqLnmcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nzT+ZVqpvr0ZrJ7kRnU9hHJ3AGpzOmkJSzfDwqqLFFsMgdxKO+KFEnPiLbinYK8r7HYa9rHPvjk6Mqlu8+rsdFHXRuE3rNaBCPE7MxIyIyjcmtndbn52OIsPP5pN5Gp44lV42gapCvJilFl2c8VJ+CJrdkO9UIjCg4xafZY75NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C208106F;
	Mon,  7 Apr 2025 09:20:08 -0700 (PDT)
Received: from u200865.usa.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF1D53F694;
	Mon,  7 Apr 2025 09:20:06 -0700 (PDT)
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org,
	mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	thiago.bauermann@linaro.org,
	broonie@kernel.org,
	yury.khrustalev@arm.com,
	kristina.martsenko@arm.com,
	liaochang1@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v2 0/6] arm64: Enable UPROBES with GCS
Date: Mon,  7 Apr 2025 11:19:45 -0500
Message-ID: <20250407161951.560865-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently uprobes and the Arm Guarded Control Stack (GCS) feature are
exclusive of each other. This restriction needs to be lifted in order
to utilize GCS for generic Linux distro images where the expectation
is that core debugging features like uprobes work.

This series adds some user accessors to read/push/pop the userspace
shadow stack. It then utilizes those functions in the uprobe paths
as needed to synchronize GCS with the changes in control flow at
probe locations. 

Along the way we fix a bug in the core gcs task handling and export
some uprobe quality of life functionality for use in arch specific code.

The KCONFIG restriction is then dropped.

v1->v2:
	Drop uprobe_warn() patch
	Fix copy_thread_gcs() bug created by fixing task_gcs_el0_enabled()
	Comments, now describe issues with reading userspace GCS pages
	Rebased to 6.15

Jeremy Linton (6):
  arm64/gcs: task_gcs_el0_enable() should use passed task
  arm64: probes: Break ret out from bl/blr
  arm64: uaccess: Add additional userspace GCS accessors
  arm64: probes: Add GCS support to bl/blr/ret
  arm64: uprobes: Add GCS support to uretprobes
  arm64: Kconfig: Remove GCS restrictions on UPROBES

 arch/arm64/Kconfig                       |  1 -
 arch/arm64/include/asm/gcs.h             |  2 +-
 arch/arm64/include/asm/uaccess.h         | 42 ++++++++++++++++++++++++
 arch/arm64/kernel/probes/decode-insn.c   |  7 ++--
 arch/arm64/kernel/probes/simulate-insn.c | 38 ++++++++++++++++++---
 arch/arm64/kernel/probes/simulate-insn.h |  3 +-
 arch/arm64/kernel/probes/uprobes.c       | 30 +++++++++++++++++
 arch/arm64/kernel/process.c              |  6 ++--
 8 files changed, 115 insertions(+), 14 deletions(-)

-- 
2.49.0

