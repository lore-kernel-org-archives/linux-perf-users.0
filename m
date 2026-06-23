Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902AF2C0274;
	Tue, 23 Jun 2026 13:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782219772; cv=none; b=tv6+NuU5hMgP45jRg9tin8wokiwTGu2HRPWJWtaoGf7S1FeXV9urYqbKKUemMW0fHCi5RNk+VZ5CdH87t5tTLJv86V+K1BMnzujqyms7zyQEe3IWyDfF7BKsGzdDwkPC/8imQSjFfF7TcN1t2PQHZ8UGa9wG7MQLezfQhiokSk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782219772; c=relaxed/simple;
	bh=HEztHkOFkxO16MO9XGC/+fnxWTEGgS3rnIIu4pIymG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nfCi8LwxIO00lZEQ2JNvcCZsuB4wB0M0HVD+WI17qeQac4eKEPANtIqYLg90ZYkFMcrjd0I6jgHjldMFHYrwxDVVR4a5ZZvQUj1sXyUBhMkR3bkN98xJRVpDSM4uwkNBvCHVXqBiMdDNwX7yW/eHCHijRXG8ttvs9YQepHmRMHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jNNRbVu0; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jNNRbVu0"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782219760; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=1EOBDjSp2BT4GfmyDKZGpvjuBfszC44WhhJFmULarWc=;
	b=jNNRbVu0RvFQw0asz1U97vI/YI0l6hxVVtc3Rb9zABZTf2z7csH6rkrrWhBcSZ4JQFOMTqSSGpixtfOnljszCrDkf7icnWZuvL32Le9AGD20/g2lDdLovVBiYSZv8gxXbGlEu1Rul3ZVa84AN1XqfCyMPjWFb5tKln1bMSxqrFc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X5UKIlc_1782219758;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X5UKIlc_1782219758 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Jun 2026 21:02:38 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Zecheng Li <zli94@ncsu.edu>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 1/5] perf annotate-data: Widen type_state_reg::imm_value to u64
Date: Tue, 23 Jun 2026 21:02:30 +0800
Message-Id: <20260623130234.8709-2-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260623130234.8709-1-xueshuai@linux.alibaba.com>
References: <20260623130234.8709-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The imm_value field in struct type_state_reg is used to store addresses
computed from PC-relative instructions (e.g., ARM64 ADRP). As a u32,
it silently truncates addresses above 4GB, which breaks global variable
resolution for kernel profiling and large-address userspace on ARM64.

Widen it to u64 to support the full 64-bit address space. Update the
corresponding format string in the x86 annotation code.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 tools/perf/util/annotate-arch/annotate-x86.c | 2 +-
 tools/perf/util/annotate-data.h              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
index 7e6136536393..985aa8bbd0b9 100644
--- a/tools/perf/util/annotate-arch/annotate-x86.c
+++ b/tools/perf/util/annotate-arch/annotate-x86.c
@@ -547,7 +547,7 @@ static void update_insn_state_x86(struct type_state *state,
 			tsr->offset = 0;
 			tsr->ok = true;
 
-			pr_debug_dtp("mov [%x] imm=%#x -> reg%d\n",
+			pr_debug_dtp("mov [%x] imm=%#"PRIx64" -> reg%d\n",
 				     insn_offset, tsr->imm_value, dst->reg1);
 			return;
 		}
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index c26130744260..4a9b4814479f 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -173,7 +173,7 @@ extern struct annotated_data_stat ann_data_stat;
  */
 struct type_state_reg {
 	Dwarf_Die type;
-	u32 imm_value;
+	u64 imm_value;
 	/*
 	 * The offset within the struct that the register points to.
 	 * A value of 0 means the register points to the beginning.
-- 
2.51.2.612.gdc70283dfc

