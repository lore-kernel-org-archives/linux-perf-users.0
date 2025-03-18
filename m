Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437031F3FDC;
	Tue, 18 Mar 2025 20:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742330934; cv=none; b=jJfq8YhVjMA7AoHP29IEEgkD97yPKw15V65eTJ12TRFKLtrrz0EeaTOJGJB47Yn3agD/j26SIb45ryLTykpKUM8hz/qdgbFOs7skt8Ced0X8IBUFMGfoYnNPOA66Po7NP9YVNoReHjdqDVmS9jIr+8aucaugNKtpguLWPRpTX/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742330934; c=relaxed/simple;
	bh=Onx+0LsIZ2ltycXQSzL79FM6FqL0cWVeyD1K2eT+kq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ghzQEpH+4U+Zo+TDeCGlOi5feXgaBYTTo/jgV28wc79MvcIj7O7buZrYxvJJoYlZSQvIVi0bcdUV68yA4cEQII4KOftwQnB9rUKXoJp7hE/zeTPT4mCLyIqfPhXe/5bmC4whk+y1YUvQBBajHa+Hmyix6r53JE7X1e4m8wsnzoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E7DF13D5;
	Tue, 18 Mar 2025 13:48:59 -0700 (PDT)
Received: from u200865.usa.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97D0A3F694;
	Tue, 18 Mar 2025 13:48:50 -0700 (PDT)
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
Subject: [PATCH 0/7] arm64: Enable UPROBES with GCS
Date: Tue, 18 Mar 2025 15:48:34 -0500
Message-ID: <20250318204841.373116-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.48.1
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

Jeremy Linton (7):
  arm64/gcs: task_gcs_el0_enable() should use passed task
  arm64: probes: Break ret out from bl/blr
  arm64: uaccess: Add additional userspace GCS accessors
  arm64: probes: Add GCS support to bl/blr/ret
  arm64: uprobes: Add GCS support to uretprobes
  uprobes: Allow the use of uprobe_warn() in arch code
  arm64: Kconfig: Remove GCS restrictions on UPROBES

 arch/arm64/Kconfig                       |  1 -
 arch/arm64/include/asm/gcs.h             |  2 +-
 arch/arm64/include/asm/uaccess.h         | 42 ++++++++++++++++++++++++
 arch/arm64/kernel/probes/decode-insn.c   |  7 ++--
 arch/arm64/kernel/probes/simulate-insn.c | 42 +++++++++++++++++++++---
 arch/arm64/kernel/probes/simulate-insn.h |  3 +-
 arch/arm64/kernel/probes/uprobes.c       | 34 +++++++++++++++++++
 include/linux/uprobes.h                  |  1 +
 kernel/events/uprobes.c                  |  2 +-
 9 files changed, 122 insertions(+), 12 deletions(-)

-- 
2.48.1

