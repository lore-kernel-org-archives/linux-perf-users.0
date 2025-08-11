Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E855238149;
	Mon, 11 Aug 2025 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921432; cv=none; b=FNmmR3BZobB1lGWGCgDxJqSQoWrmd6qBBQRimYPcfPTZ9i8HqIpaBNOM3FEHHkjtky8OzU5gTXKMoZZtjVMgyd3HAcbn//l36KMZD4jhHUW/RrUqZR6zaEdG7zpZL0dLpAxCyBd8r0iyAvfCMzkc0nO1y5LLaCbZ2Nd/yrXVJsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921432; c=relaxed/simple;
	bh=hpRAV4ORj/lhn6HnW4gyBizooxuZyK8c21Iq9yNPYNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jydU/Q8uxtICxCHZPJI6xcGWuojqfhwXeZN0dNXVeFNKR0BBEWI6id9fJc+3NHw70G4oP4Jdx8SOVfWELYzY2OwoGkqfMYU33wpsfnxsMEzskIinNXFUnfIO77vUaHT8nSR1A2CjybLXz743VihPT6e3MKxX/QgpSL12HEhtxLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E77672682;
	Mon, 11 Aug 2025 07:10:22 -0700 (PDT)
Received: from u200865.usa.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7578D3F738;
	Mon, 11 Aug 2025 07:10:30 -0700 (PDT)
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
Subject: [PATCH v5 7/7] uprobes: uprobe_warn should use passed task
Date: Mon, 11 Aug 2025 09:10:10 -0500
Message-ID: <20250811141010.741989-8-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811141010.741989-1-jeremy.linton@arm.com>
References: <20250811141010.741989-1-jeremy.linton@arm.com>
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

Fixes: 248d3a7b2f10 ("uprobes: Change uprobe_copy_process() to dup return_instances")
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 7ca1940607bd..4b97d16f731c 100644
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

