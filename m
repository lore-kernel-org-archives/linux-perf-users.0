Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDE2225419;
	Sat, 19 Jul 2025 04:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752899887; cv=none; b=SQlBTPE24OhghfiFApCMDsOekW/aC4WPiB3hPapaiccDfoV28h3UohuA+t8hC0aydEhLSXgTpuwVi9/SyYQfDPgvg5qoliMlJSIiGU6d4/j7O3WhCx7Fg03z4HxTR/c2bmhOrmJ8lRtsbmFUM/qo7MGsQZhxcwGcpfV8Ndp6twg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752899887; c=relaxed/simple;
	bh=s+4CXnyWKnGe+lq9lzRVTLvQSangoa8NJGuxh9g3sTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/H5ApGXwrhRbMHeuuDCG4qEH1NwHZjWDrXeFJP/ZK7azpsG6aiCh1TiNY0FhQrbvgpdE7HyXlDuPxS5j5FUgGm8+h5jouXv3hCOHsnn8q9H9ckxHL6YJA/Bc1FvH9Wonr9ED7TTHCD6JwNTFrXYMu290rVqeIVzLgrMIk19ZlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 425742E96;
	Fri, 18 Jul 2025 21:37:58 -0700 (PDT)
Received: from u200865.usa.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 298483F66E;
	Fri, 18 Jul 2025 21:38:04 -0700 (PDT)
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
Subject: [PATCH v4 8/8] uprobes: uprobe_warn should use passed task
Date: Fri, 18 Jul 2025 23:37:40 -0500
Message-ID: <20250719043740.4548-9-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250719043740.4548-1-jeremy.linton@arm.com>
References: <20250719043740.4548-1-jeremy.linton@arm.com>
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
index 4c965ba77f9f..2dc4fed837a2 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -121,7 +121,7 @@ struct xol_area {
 
 static void uprobe_warn(struct task_struct *t, const char *msg)
 {
-	pr_warn("uprobe: %s:%d failed to %s\n", current->comm, current->pid, msg);
+	pr_warn("uprobe: %s:%d failed to %s\n", t->comm, t->pid, msg);
 }
 
 /*
-- 
2.50.1

