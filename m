Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A664BE42A;
	Tue, 15 Sep 2026 15:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487392; cv=none; b=AWGhaWSPNSvUFAOyNxopYbKdLMSfnzamqIodAEIkajJLsm/EyBtBt++wxsfJymoG/Ln2rawwp4RrXiFE66cHYF4pSwLd8ZNFNg6q8Od/2B6bfJARo6k+w6cKsQQFUEG55zWxzw2gbUvVgycqmpVqir54V270a+uoAhVer1+AEsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487392; c=relaxed/simple;
	bh=2BWIzct5AOjyfF3AD0YgFM25chejHt1dAhhGT0eurX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KUxAFxBek2ysxY1PylgFzvidM5P+paBZ9urR12vB1UdiI6z2t8V3YR3NbAsYsrPh7VJmYbe/gkD4i0tXaO6iIPEUH36zHnWI+5TV6itYxvQLzHiKgFPTgC1Z+Zs+icvgOQI8pHjGuTH6GAheM8ITTFE1YgRL+5ZkDZtwDhPGDrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gY6xFSfk; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gY6xFSfk"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23D7615A1;
	Tue, 15 Sep 2026 08:49:45 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B25D3F882;
	Tue, 15 Sep 2026 08:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789487388; bh=2BWIzct5AOjyfF3AD0YgFM25chejHt1dAhhGT0eurX0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gY6xFSfk7qsqfrCYpUN1B+yQB6GszxHx6mqZmavlCL9YNw0zzW+K3/gZE/YO1Jx2s
	 H/P5fHEBYrU1A095iYpixEoVJGoboyoeeeb4sSRDtrjCE5WUA31rFH8HPycEkDY5qH
	 xKZbtknQPMhUmccidu1RHDkkSYNjsDN6zMat4KLU=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 15 Sep 2026 16:49:03 +0100
Subject: [PATCH 17/25] perf cs-etm: Allow history collection for samples
 with zero IP
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-arm_cs_support_aux_sample-v1-17-35cf6f297d20@arm.com>
References: <20260915-arm_cs_support_aux_sample-v1-0-35cf6f297d20@arm.com>
In-Reply-To: <20260915-arm_cs_support_aux_sample-v1-0-35cf6f297d20@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789487340; l=1574;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=2BWIzct5AOjyfF3AD0YgFM25chejHt1dAhhGT0eurX0=;
 b=JEAlUVzjAxBjSEXx7rX7saEGp6gs8WRPKMkLB0A+GL/m05JjtdPTWvwRsDl9QqVTOeULXeoee
 1Z7SykBs4bPC3TUZz3yZ28S3t5cPrPCfZprrjvB+TBsNuIvtpY/192C
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Perf clears the IP of a user-only PMU sample when its interrupt skids
into the kernel. The timestamp and TID remain valid, but the zero-IP
check prevents --itrace=L from attaching decoded branch history.

Remove the IP check and keep matching samples to trace by time and
thread.

Assisted-by: Codex:gpt-6
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 00407a80933e1c0b76260aed5894dece50b9aecd..baa962085dba5226d9729a0ee8039374d5fcb1a0 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -3097,6 +3097,8 @@ static int cs_etm__br_stack_init(struct cs_etm_auxtrace *etm,
 /*
  * Add decoded branch history to an existing sample. The sample keeps its own
  * ip, callchain and event identity; only an absent branch stack is filled in.
+ * A user-only PMU sample can have a zero IP when the interrupt skids into
+ * the kernel; its thread and trace window still identify valid history.
  */
 static int cs_etm__process_sample(struct cs_etm_auxtrace *etm,
 				  struct perf_session *session,
@@ -3107,7 +3109,7 @@ static int cs_etm__process_sample(struct cs_etm_auxtrace *etm,
 	int err;
 
 	if (!etm->synth_opts.add_last_branch || sample->branch_stack ||
-	    !sample->ip || !sample->time || sample->time == (u64)-1)
+	    !sample->time || sample->time == (u64)-1)
 		return 0;
 
 	/* Adding branch history to existing samples supports the host only */

-- 
2.34.1

