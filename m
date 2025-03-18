Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8957F2054E1;
	Tue, 18 Mar 2025 20:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742330935; cv=none; b=UNW4bEhVRkUJR6ifx1L/GH0RYUY7O3J2ZJUNQz0lMiQDe/DM4lIt3cAVi9HPypzdBq+nyYXpOcmLVoIZR94dBxO1KlvCggc6Ti7TnZ/J8tkpyiCAfqQNL9nN5JeDM8y6vFaAKfQ4kZFWCEaJ4KkntQO2gWw1tf74p7cBAsKCiBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742330935; c=relaxed/simple;
	bh=F3ytnp5DWEyy9tJeog9eRtAnMiiP3aX2gazyR9/19Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SxH3P3s0K11fg/XNv85gWNam1Xd2p8hVR42huBvsr1K9cR0p0DIqn2JyufHgvJ8lXZosBzcD30d0oShjY6s+PLukQzFrgsxQZYCjltQ9+P+4T3dRbJOFArLArJO6Nrr5oy5uHdYR2JZhonj7FRBwNVsh81hwKwuapqG4a1lmRsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6B8B150C;
	Tue, 18 Mar 2025 13:49:00 -0700 (PDT)
Received: from u200865.usa.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E67FB3F694;
	Tue, 18 Mar 2025 13:48:51 -0700 (PDT)
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
Subject: [PATCH 1/7] arm64/gcs: task_gcs_el0_enable() should use passed task
Date: Tue, 18 Mar 2025 15:48:35 -0500
Message-ID: <20250318204841.373116-2-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318204841.373116-1-jeremy.linton@arm.com>
References: <20250318204841.373116-1-jeremy.linton@arm.com>
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

Fixes: fc84bc5378a8 ("arm64/gcs: Context switch GCS state for EL0")
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/include/asm/gcs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.48.1

