Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E161A314B;
	Mon, 11 Aug 2025 14:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921426; cv=none; b=ry2TIJxA+ITD8w6Z8pApPweu96OIeyAjTtaM6ZBZbSsfBJwBeNPvM5+pq2JneSrt1wZvYW2ooH/5N5jiLS+6R207pnOJFT3VZoDC5NPHrGtOcOdKi1MCIpBNPJhpN0P3VKRXQZ14Mo1+HAiVnsOUOquICBEO3mK90FcqEtTJ4og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921426; c=relaxed/simple;
	bh=PqOif4n6dhkjVJrz7stPxn20AD/68S05JuHGOWUPVtk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J43rRZMl5AjWY1RiU5EImeSqz1Q1018GCwN3FBilGgyCFv2fdTlzHD/zpV5DLOy60OxUFeuZQAEMevSmPhncJ6h4ywWYBh8yE08TuSIPrc67x6L+6TrfdUsiBXSg1gRWE5QCwvcrQtvIEGcJxSNmC2d/MED7RGLqiNeBtWCgY4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D98271A32;
	Mon, 11 Aug 2025 07:10:14 -0700 (PDT)
Received: from u200865.usa.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 669FF3F738;
	Mon, 11 Aug 2025 07:10:22 -0700 (PDT)
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
Subject: [PATCH v5 0/7] arm64: Enable UPROBES with GCS
Date: Mon, 11 Aug 2025 09:10:03 -0500
Message-ID: <20250811141010.741989-1-jeremy.linton@arm.com>
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
 arch/arm64/include/asm/gcs.h             | 89 ++++++++++++++++++++++++
 arch/arm64/include/asm/uaccess.h         | 40 -----------
 arch/arm64/kernel/probes/decode-insn.c   |  7 +-
 arch/arm64/kernel/probes/simulate-insn.c | 50 ++++++++++---
 arch/arm64/kernel/probes/simulate-insn.h |  3 +-
 arch/arm64/kernel/probes/uprobes.c       | 33 +++++++++
 kernel/events/uprobes.c                  |  2 +-
 8 files changed, 171 insertions(+), 54 deletions(-)

-- 
2.50.1

