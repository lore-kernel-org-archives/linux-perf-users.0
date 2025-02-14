Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AD5264F80;
	Fri, 14 Feb 2025 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739532015; cv=none; b=Hhr9abb58zyqJKXVn9Y5ZH7ixNor2QkKiEBNjvBTd6Bp/+bW0gNN0qms45V3cbTugnmJL9H00iM33ZOxHkLmaWcE9d7qhKcjEpHbAKR3mOc76l2H8MT1PFIonGvMXzZ7ULJToYq8ULMexYGtctvCViYfZ1jUHRakgnm9wLXpgzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739532015; c=relaxed/simple;
	bh=cZiN2zehwxY5Qa+vNWUcmBlzyBbJ1hsGLyNiA7fh+Ts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JMADJGEToJe7nGhdZYFxQJLH4XJUR/cgWudW+7qNmWNjd0wC4wFuOsLqtClehIwWpqV7BN4qUWFHVwbKmPVncvOaZGROk02FjQh3jAjoijAV14iQIlPxUK0svbmCEZQs9w+Qntl3prmcCZAu2H0uxZwsU9ID5zB0RWlts7WzBUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 928A9113E;
	Fri, 14 Feb 2025 03:20:33 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 769A43F6A8;
	Fri, 14 Feb 2025 03:20:10 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Graham Woodward <graham.woodward@arm.com>,
	Paschalis.Mpeis@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 09/11] perf arm-spe: Set sample flags with supplement info
Date: Fri, 14 Feb 2025 11:19:34 +0000
Message-Id: <20250214111936.15168-10-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250214111936.15168-1-leo.yan@arm.com>
References: <20250214111936.15168-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on the supplement information in the record, this commit sets the
sample flags for conditional branch, function call, return.  It also
sets events in flags, such as mispredict, not taken, and in transaction.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 251d214adf7f..e41905a009bd 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -482,6 +482,26 @@ static void arm_spe__sample_flags(struct arm_spe_queue *speq)
 
 		if (record->type & ARM_SPE_BRANCH_MISS)
 			speq->flags |= PERF_IP_FLAG_BRANCH_MISS;
+
+		if (record->type & ARM_SPE_BRANCH_NOT_TAKEN)
+			speq->flags |= PERF_IP_FLAG_NOT_TAKEN;
+
+		if (record->type & ARM_SPE_IN_TXN)
+			speq->flags |= PERF_IP_FLAG_IN_TX;
+
+		if (record->op & ARM_SPE_OP_BR_COND)
+			speq->flags |= PERF_IP_FLAG_CONDITIONAL;
+
+		if (record->op & ARM_SPE_OP_BR_CR_BL)
+			speq->flags |= PERF_IP_FLAG_CALL;
+		else if (record->op & ARM_SPE_OP_BR_CR_RET)
+			speq->flags |= PERF_IP_FLAG_RETURN;
+		/*
+		 * Indirect branch instruction without link (e.g. BR),
+		 * take it as a function return.
+		 */
+		else if (record->op & ARM_SPE_OP_BR_INDIRECT)
+			speq->flags |= PERF_IP_FLAG_RETURN;
 	}
 }
 
-- 
2.34.1

