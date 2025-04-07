Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E7820E006;
	Mon,  7 Apr 2025 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744042810; cv=none; b=GFAakeD3CqrHc4KLhsQllKvCbbBv155bB5Uhwqy7nnEHekY/3JFaCea46Vx47l8NHB7KRBzMmFCvgZbJR5TNxAS6U64K+O+ZgwIR3mfiDPD3e7qdPt72/kzsF20uI6hRyGqQu4CQdGjfCbxotXOkT9YUHOCbnLT4rEuStqnQN9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744042810; c=relaxed/simple;
	bh=VUN+9d827zbuUZqIKAvgr6e+RfWmpNtJ4Iry3M4n4/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=USts9mCFL14LUP+VOMxwd1A4G9JwrJ+urosY9A+kjOWxyJXdO4renfU4GthB+wnxGUlQ+4zfkHwGpWpqQAVlbBpzq9LjxygFmfFHprsQIG/vkq4cmwFvEpsfTrRJx3MLNCl07RImAkXRrQU/Nt8N5ksJidP7pQzPsY62EkUnJMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAECE12FC;
	Mon,  7 Apr 2025 09:20:09 -0700 (PDT)
Received: from u200865.usa.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E8EC3F694;
	Mon,  7 Apr 2025 09:20:08 -0700 (PDT)
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
Subject: [PATCH v2 1/6] arm64/gcs: task_gcs_el0_enable() should use passed task
Date: Mon,  7 Apr 2025 11:19:46 -0500
Message-ID: <20250407161951.560865-2-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407161951.560865-1-jeremy.linton@arm.com>
References: <20250407161951.560865-1-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark Rutland noticed that the task parameter is ignored and
'current' is being used instead. Since this is usually
what its passed, it hasn't yet been causing problems but likely
will as the code gets more testing.

But, once this is fixed, it creates a new bug in copy_thread_gcs()
since the gcs_el_mode isn't yet set for the task before its being
checked. Move gcs_alloc_thread_stack() after the new task's
gcs_el0_mode initialization to avoid this.

Fixes: fc84bc5378a8 ("arm64/gcs: Context switch GCS state for EL0")
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/include/asm/gcs.h | 2 +-
 arch/arm64/kernel/process.c  | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/gcs.h b/arch/arm64/include/asm/gcs.h
index f50660603ecf..5bc432234d3a 100644
--- a/arch/arm64/include/asm/gcs.h
+++ b/arch/arm64/include/asm/gcs.h
@@ -58,7 +58,7 @@ static inline u64 gcsss2(void)
 
 static inline bool task_gcs_el0_enabled(struct task_struct *task)
 {
-	return current->thread.gcs_el0_mode & PR_SHADOW_STACK_ENABLE;
+	return task->thread.gcs_el0_mode & PR_SHADOW_STACK_ENABLE;
 }
 
 void gcs_set_el0_mode(struct task_struct *task);
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 42faebb7b712..68b7021cda77 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -305,13 +305,13 @@ static int copy_thread_gcs(struct task_struct *p,
 	p->thread.gcs_base = 0;
 	p->thread.gcs_size = 0;
 
+	p->thread.gcs_el0_mode = current->thread.gcs_el0_mode;
+	p->thread.gcs_el0_locked = current->thread.gcs_el0_locked;
+
 	gcs = gcs_alloc_thread_stack(p, args);
 	if (IS_ERR_VALUE(gcs))
 		return PTR_ERR((void *)gcs);
 
-	p->thread.gcs_el0_mode = current->thread.gcs_el0_mode;
-	p->thread.gcs_el0_locked = current->thread.gcs_el0_locked;
-
 	return 0;
 }
 
-- 
2.49.0

