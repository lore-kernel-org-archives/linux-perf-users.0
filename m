Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC02846C;
	Sat, 19 Jul 2025 04:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752899873; cv=none; b=tumypD4CiVXY5JuynRT0kmMQw6gZcLmOyx7qslsCA8uWYyf5mzTw2aud4iifViSmQRUmKLz3Udc7CjMhT3xaFxo9GWXAXar+Rgk4ZQiOutjuDsBi1iMb/8YS7jQVGnBOthwSXfNaJC/UqW2Y/AXLwEmbW5EVGeZA+9ZEZ5fEW3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752899873; c=relaxed/simple;
	bh=X+TT9aybAKf1KyXat7OzN3LsxjTZSZXNkkhdWc2m45Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cHkD71ZZJpmtTRHetWDspmNG0pA8WJf34fmbb19hhaXfUD7I68M3tXHvisiAyMQpVd6yC+AUacO5UZQQYGc456ICnm34SROQd4YcShOdU5qAZ334VM3BDyE3eOW3hwD1NjsCmes5CHBIdPVyB6jWCQpeVY1ncjFgf8pOez+AymM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0B3A1596;
	Fri, 18 Jul 2025 21:37:43 -0700 (PDT)
Received: from u200865.usa.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 961423F66E;
	Fri, 18 Jul 2025 21:37:49 -0700 (PDT)
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
Subject: [PATCH v4 0/8] arm64: Enable UPROBES with GCS
Date: Fri, 18 Jul 2025 23:37:32 -0500
Message-ID: <20250719043740.4548-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.50.0
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

Jeremy Linton (8):
  arm64/gcs: task_gcs_el0_enable() should use passed task
  arm64: probes: Break ret out from bl/blr
  arm64: uaccess: Move existing GCS accessors definitions to gcs.h
  arm64: uaccess: Add additional userspace GCS accessors
  arm64: probes: Add GCS support to bl/blr/ret
  arm64: uprobes: Add GCS support to uretprobes
  arm64: Kconfig: Remove GCS restrictions on UPROBES
  uprobes: uprobe_warn should use passed task

 arch/arm64/Kconfig                       |  1 -
 arch/arm64/include/asm/gcs.h             | 89 +++++++++++++++++++++++-
 arch/arm64/include/asm/uaccess.h         | 40 -----------
 arch/arm64/kernel/probes/decode-insn.c   |  7 +-
 arch/arm64/kernel/probes/simulate-insn.c | 41 +++++++++--
 arch/arm64/kernel/probes/simulate-insn.h |  3 +-
 arch/arm64/kernel/probes/uprobes.c       | 31 +++++++++
 arch/arm64/kernel/process.c              |  6 +-
 kernel/events/uprobes.c                  |  2 +-
 9 files changed, 165 insertions(+), 55 deletions(-)

-- 
2.50.1

