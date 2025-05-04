Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D05024BBFA;
	Sun,  4 May 2025 23:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746401544; cv=none; b=PM6qEsYZHfCZoRUWpOBzz9vDId71SNBnj/C5RiM8gF/SL1SMfkGJKF4tAP652sKBwIWkh5wYQO3IuGZkVW/cEy+2ZC0amjUylO62vWN7itxgIqPKs/1AtieEwzvnxl9kah74mqVkZd17VkAw+t1sdVdP+E7pINEKNNKhfmWD2Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746401544; c=relaxed/simple;
	bh=iHxExqdpCUO0hZu9dF77QQEQ3XQrFK96IJ2ClCtqM3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZGIe2AYCyd40OKA3na/G1UKtB+DzuRMgOnBwmkEfbtUPiXoMV8czJ98tJhBYQtvoOa2ybH27yiLy/rS1zrH9nG/Zvs+2QHTsTVgWj2MAKfn0QwHqBY2MWjAshU3D0SQU+rOgwxFdME5LGnoCvZGEh8OJDV7XrI1dop/dUlKM/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD9B31EA6;
	Sun,  4 May 2025 16:32:13 -0700 (PDT)
Received: from u200865.usa.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80C013F58B;
	Sun,  4 May 2025 16:32:22 -0700 (PDT)
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
Subject: [PATCH v3 7/7] uprobes: uprobe_warn should use passed task
Date: Sun,  4 May 2025 18:32:03 -0500
Message-ID: <20250504233203.616587-8-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250504233203.616587-1-jeremy.linton@arm.com>
References: <20250504233203.616587-1-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uprobe_warn() is passed a task structure, yet its using current. For
the most part this shouldn't matter, but since a task structure is
provided, lets use it.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 8d783b5882b6..6552d9815292 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -120,7 +120,7 @@ struct xol_area {
 
 static void uprobe_warn(struct task_struct *t, const char *msg)
 {
-	pr_warn("uprobe: %s:%d failed to %s\n", current->comm, current->pid, msg);
+	pr_warn("uprobe: %s:%d failed to %s\n", t->comm, t->pid, msg);
 }
 
 /*
-- 
2.49.0

