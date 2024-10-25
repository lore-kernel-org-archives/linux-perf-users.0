Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD59F1FDF90;
	Fri, 25 Oct 2024 10:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729853551; cv=none; b=MyhZLkRLE0bcpKXHQdN2CVaHw87aZ2SA0gkGkM/VpVsjmPy09JId8WJA03QYGxI78QJxQxHgPLlGwfcCaMP8N6k8xL1peA6nwPOlUnLzGLcVhVam60GgkuyVRRFG2PMA4dPnjd67BMI+ukEZEzPTwIa9evXvYdYOyQT2kYQhMGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729853551; c=relaxed/simple;
	bh=+NkIU9KKnVmh+ullACqFN+6wnC1MVnt9Mw8eOxibrOE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VU4PD2q2mMhOtMG64jMWpgDkEyoeVdnZNTDyeC+btCLb1q6MBgYpxdyf2bEWz4fPX4OWD+btmp8HxGFBxv7gHNpBeFyMBtbzWCmdjBgyRyLLAmtkpuYlAyjumdQXzYClLMzOO7zS6TBT0vkqrz6Vu1pmKu1KnyiDh5Nah06Aids=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E7FE12FC;
	Fri, 25 Oct 2024 03:52:58 -0700 (PDT)
Received: from VDW30FN91H.arm.com (unknown [10.57.79.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A71913F73B;
	Fri, 25 Oct 2024 03:52:26 -0700 (PDT)
From: Graham Woodward <graham.woodward@arm.com>
To: acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	jolsa@kernel.org,
	irogers@google.com,
	james.clark@linaro.org,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: nd@arm.com,
	Graham Woodward <graham.woodward@arm.com>
Subject: [PATCH v10 2/4] perf arm-spe: Use ARM_SPE_OP_BRANCH_ERET when synthesizing branches
Date: Fri, 25 Oct 2024 11:52:10 +0100
Message-Id: <20241025105212.51779-3-graham.woodward@arm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241025105212.51779-1-graham.woodward@arm.com>
References: <20241025105212.51779-1-graham.woodward@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of checking the type for just branch misses, we can instead
check for the OP_BRANCH_ERET and synthesise branches as well as
branch misses.

Signed-off-by: Graham Woodward <graham.woodward@arm.com>
---
 tools/perf/util/arm-spe.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 76d41c91f..d27500c53 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -69,7 +69,7 @@ struct arm_spe {
 	u64				llc_access_id;
 	u64				tlb_miss_id;
 	u64				tlb_access_id;
-	u64				branch_miss_id;
+	u64				branch_id;
 	u64				remote_access_id;
 	u64				memory_id;
 	u64				instructions_id;
@@ -601,8 +601,8 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 		}
 	}
 
-	if (spe->sample_branch && (record->type & ARM_SPE_BRANCH_MISS)) {
-		err = arm_spe__synth_branch_sample(speq, spe->branch_miss_id);
+	if (spe->sample_branch && (record->op & ARM_SPE_OP_BRANCH_ERET)) {
+		err = arm_spe__synth_branch_sample(speq, spe->branch_id);
 		if (err)
 			return err;
 	}
@@ -1202,12 +1202,12 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 	if (spe->synth_opts.branches) {
 		spe->sample_branch = true;
 
-		/* Branch miss */
+		/* Branch */
 		err = perf_session__deliver_synth_attr_event(session, &attr, id);
 		if (err)
 			return err;
-		spe->branch_miss_id = id;
-		arm_spe_set_event_name(evlist, id, "branch-miss");
+		spe->branch_id = id;
+		arm_spe_set_event_name(evlist, id, "branch");
 		id += 1;
 	}
 
-- 
2.40.1

