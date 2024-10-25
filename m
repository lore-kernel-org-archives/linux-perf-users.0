Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3BC20BB4D;
	Fri, 25 Oct 2024 14:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866658; cv=none; b=RfvGjwHTqlBRz2ZoXLiC9cP5Cr8TFRSlRqh6HVCsN43cDWin/LIMt0ektDQiCzPy+1ReJaNlSDH+6C3fiUVu6N/xv+pBBA8JETwNvWe5Mp/OpBGNRGBQ4s3kR9EMd7yHIJSVx4m3den26I3gk9m2a7f5R2rR8uQFhRow/lCjUhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866658; c=relaxed/simple;
	bh=+m1Fd6DkkUo2YpyeBWMJx86vmQUvxg9ZMGY1A/hh8zo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fhdVkvMMT2XeOf5MpeyL3bB+8M1bMMikPDhZSluLEfA5uD7b2eALAZX95br09bjirRh9tUpg4fKvZxRZTTdaXBSkwowrHa0Rb1aZYC9hP839SpeDFtfR2kbx1RvfIKCR5aIrjpE5xcms6WkaECOj+RS3qrJVBFs9Dnysz6Udjgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E74A7339;
	Fri, 25 Oct 2024 07:31:25 -0700 (PDT)
Received: from VDW30FN91H.arm.com (unknown [10.57.79.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F3AB53F73B;
	Fri, 25 Oct 2024 07:30:53 -0700 (PDT)
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
Subject: [PATCH v1 2/4] perf arm-spe: Use ARM_SPE_OP_BRANCH_ERET when synthesizing branches
Date: Fri, 25 Oct 2024 15:30:07 +0100
Message-Id: <20241025143009.25419-3-graham.woodward@arm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241025143009.25419-1-graham.woodward@arm.com>
References: <20241025143009.25419-1-graham.woodward@arm.com>
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
index 49b763807360..e60e21d24735 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -68,7 +68,7 @@ struct arm_spe {
 	u64				llc_access_id;
 	u64				tlb_miss_id;
 	u64				tlb_access_id;
-	u64				branch_miss_id;
+	u64				branch_id;
 	u64				remote_access_id;
 	u64				memory_id;
 	u64				instructions_id;
@@ -672,8 +672,8 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 		}
 	}
 
-	if (spe->sample_branch && (record->type & ARM_SPE_BRANCH_MISS)) {
-		err = arm_spe__synth_branch_sample(speq, spe->branch_miss_id);
+	if (spe->sample_branch && (record->op & ARM_SPE_OP_BRANCH_ERET)) {
+		err = arm_spe__synth_branch_sample(speq, spe->branch_id);
 		if (err)
 			return err;
 	}
@@ -1385,12 +1385,12 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
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

