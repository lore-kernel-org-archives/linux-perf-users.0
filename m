Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9537366;
	Mon, 25 Aug 2025 03:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756092877; cv=none; b=dyR48WrbA2m5uickU6Df6frndH40hQSPpgIzFzVhaeEX44ScNvLzTcxox/CFqWKzTxb1Dybd4kIoRI8UmVNiwIPuzfFG0112EAcs45Er+gl/RxBqjn+bOrX56ZDDA1KjPqJdchOdU2Mn8egE4CZALJnvIeY783IgIc2oO/9Srrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756092877; c=relaxed/simple;
	bh=yii1kTvGDSGlOj2Pcq2/YqY4dJDltKctkLMJ9t6QnyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dqzr3V5WkEXaWQOXYTHcVhxQLR0eV2CeRAZDnVAZn3oP0bFhenbkasBOnUKJ62+GejEtyf/SfRt8TNd295WDxsRUtgrUZ/LRqqWXQpadfZ6ccmg4ZtED/L38BV8uvpY78E74B0vJYSTltRQUrMhmepXwOuEH5esbe6K7u7sv5/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1E4915A1;
	Sun, 24 Aug 2025 20:34:19 -0700 (PDT)
Received: from u200865.usa.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C52223F63F;
	Sun, 24 Aug 2025 20:34:26 -0700 (PDT)
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org,
	mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	mingo@redhat.com,
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
Subject: [PATCH v7 0/7] arm64: Enable UPROBES with GCS
Date: Sun, 24 Aug 2025 22:34:14 -0500
Message-ID: <20250825033421.463669-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.50.1
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
shadow stack. It then utilizes those functions in the uprobe paths as
needed to synchronize GCS with the changes in control flow at probe
locations.

The KCONFIG restriction is then dropped.

v6->v7: Minor comment changes per review
	Add additional review-by's

v5->v6: Add additional review-by's
	Post the version with the complete function rename that
	     builds with/without GCS (patch 3)
	Drank my coffee before posting this time.

v4->v5: Fix ret xn handing
	Renames, comment tweaks, formatting, per review comments
	rebase 6.17, drop first patch
	Add reviewed-by's

v3->v4: Much delayed v4 rebased to 6.16
	Move existing gcs accessors to gcs.h and then add the new
	     ones. This fixes some of the forward reference issues,
	     the build break and keeps them all together.

v2->v3: Cleanup RET logic to alwaays use LR, and not update IP on aborts
	Correct generic uprobe_warn bug even though we aren't using it

v1->v2:
	Drop uprobe_warn() patch
	Fix copy_thread_gcs() bug created by fixing task_gcs_el0_enabled()
	Comments, now describe issues with reading userspace GCS pages
	Rebased to 6.15

Jeremy Linton (7):
  arm64: probes: Break ret out from bl/blr
  arm64: uaccess: Move existing GCS accessors definitions to gcs.h
  arm64: uaccess: Add additional userspace GCS accessors
  arm64: probes: Add GCS support to bl/blr/ret
  arm64: uprobes: Add GCS support to uretprobes
  arm64: Kconfig: Remove GCS restrictions on UPROBES
  uprobes: uprobe_warn should use passed task

 arch/arm64/Kconfig                       |  1 -
 arch/arm64/include/asm/gcs.h             | 91 +++++++++++++++++++++++-
 arch/arm64/include/asm/uaccess.h         | 40 -----------
 arch/arm64/kernel/probes/decode-insn.c   |  7 +-
 arch/arm64/kernel/probes/simulate-insn.c | 50 ++++++++++---
 arch/arm64/kernel/probes/simulate-insn.h |  3 +-
 arch/arm64/kernel/probes/uprobes.c       | 33 +++++++++
 kernel/events/uprobes.c                  |  2 +-
 8 files changed, 172 insertions(+), 55 deletions(-)

-- 
2.50.1

