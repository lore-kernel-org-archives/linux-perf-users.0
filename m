Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4ECA277013;
	Mon, 18 Aug 2025 21:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755552936; cv=none; b=chtJ61LlmtiZhw95pR/MRq1QqwQT0K1bm7SzqVQimi8gKzifCGVO8XQDkr/0bLwJXyQWIaMFehN2ZwyY//s2i8S4DGHfQElmY7atXnbjFIRGt/8GJhiAJoghWqUZvvNQyLJWWZbaJY//O5P/X5E3InsKcz2LTHRXIq1JU3FOWa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755552936; c=relaxed/simple;
	bh=qGKi7nFEQeTEbuUFTQQot3rZpaYZ++xqYf/CsvSj1kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QPRrMC/Uh5iAuAKn8YnwigTTkRhv1s13sN1TeaUFVog/HybGNsgk2mc+Qj/W+WI8FTLz8ccXbhDhppmAb2dsB5ve14sxxoSB2/4773FpjVzoKX8cbnOvMQf4QFFajciqrr6c3iD35eKJ5odOhN5iORuaBluGo6jJnkgTmaEUd3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E7C51BB2;
	Mon, 18 Aug 2025 14:35:26 -0700 (PDT)
Received: from u200865.usa.arm.com (U203867.austin.arm.com [10.118.30.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFA373F738;
	Mon, 18 Aug 2025 14:35:33 -0700 (PDT)
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
Subject: [PATCH v6 7/7] uprobes: uprobe_warn should use passed task
Date: Mon, 18 Aug 2025 16:34:52 -0500
Message-ID: <20250818213452.50439-8-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818213452.50439-1-jeremy.linton@arm.com>
References: <20250818213452.50439-1-jeremy.linton@arm.com>
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
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
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

