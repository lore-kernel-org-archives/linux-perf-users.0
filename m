Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C8034AB00;
	Wed, 17 Sep 2025 09:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758102933; cv=none; b=nEPLEqzDbWnEZC09x3PxTFoaUiKf5uIQjAQw03bTvMoHvjfnlEWXmE5hof5SysZI2CC2izR+DgxJFqr9C41aNCXhR7s+gvZayr0g5mcO15fVAv3y/Xk92oC6hhfdBXcctTqqNZuApIpPRVVt8TRDRBtkhSUQCq766C2Fq74cLp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758102933; c=relaxed/simple;
	bh=1ZcejynwqKIf3ztV1ioOpuoDxNtc/nW44Mr7lEuPChg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jC6AV3RvLnTd+kVcSp26jrhTLqjNpCfR53xCf3RmQ/iJdH2Xb3vjWaQAsDshbVsPi17oCIxhEIsD3wYa5TBcelvGvYRootf/9Va+x2VAE35IblJXpseYRkioqw3iYK5y1+LEssIGsuy1+s3Xb8SwnYBzKchxxmyFncmSdDmKrWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Fushuai Wang <wangfushuai@baidu.com>
Subject: [PATCH] perf trace: Fix IS_ERR() vs NULL check bug
Date: Wed, 17 Sep 2025 17:54:22 +0800
Message-ID: <20250917095422.60923-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc7.internal.baidu.com (172.31.3.17) To
 bjkjy-exc17.internal.baidu.com (172.31.50.13)
X-FEAS-Client-IP: 172.31.50.13
X-FE-Policy-ID: 52:10:53:SYSTEM

The alloc_syscall_stats() function always returns an error pointer
(ERR_PTR) on failure. So replace NULL check with IS_ERR() check
after calling alloc_syscall_stats() function.

Fixes: fc00897c8a3f ("perf trace: Add --summary-mode option")
Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 tools/perf/builtin-trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index fe737b3ac6e6..25c41b89f8ab 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4440,7 +4440,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 
 	if (trace->summary_mode == SUMMARY__BY_TOTAL && !trace->summary_bpf) {
 		trace->syscall_stats = alloc_syscall_stats();
-		if (trace->syscall_stats == NULL)
+		if (IS_ERR(trace->syscall_stats))
 			goto out_delete_evlist;
 	}
 
@@ -4748,7 +4748,7 @@ static int trace__replay(struct trace *trace)
 
 	if (trace->summary_mode == SUMMARY__BY_TOTAL) {
 		trace->syscall_stats = alloc_syscall_stats();
-		if (trace->syscall_stats == NULL)
+		if (IS_ERR(trace->syscall_stats))
 			goto out;
 	}
 
-- 
2.36.1

