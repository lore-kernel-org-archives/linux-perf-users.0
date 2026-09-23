Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8BA57C72E;
	Wed, 23 Sep 2026 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176939; cv=none; b=BaUg/FcR/R0wPr81o1fIwtFNhomrArhG0jyIgZ1nZYtOYLUMqG3ln3uDHXkYQumzutf7QYQEiLtF4FWRTbKB5heebL2ry1Xo9yjoCS6MqH276Xk3Eg4O6XpkZ+pf+qg/4nl38KHtnvuUC0lpaPXXikMkHIbYRYZasluWrmhjjUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176939; c=relaxed/simple;
	bh=7P52Iamvzkdn9OJUTBT7htFwBgcAKkrJTYDZdLDrnHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZVWeXw8lBc6QzVdt/9cy9NA3hshLJErFLySrBhfVtsBXeaH0ejbHimvC1KTZiiz+xF4usONQcrrTdWHK0OOuFLNIwbHzie3CBURuZ6jESTWdJSsSRoZaCk6Wjo0UXOKmJhtow0B7si2PyY3GMqHFK3ZD7n/myGPnlcM0+ENEl5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=d6PMTZjQ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="d6PMTZjQ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6E341D14;
	Wed, 23 Sep 2026 08:22:12 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0574B3F86F;
	Wed, 23 Sep 2026 08:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790176936; bh=7P52Iamvzkdn9OJUTBT7htFwBgcAKkrJTYDZdLDrnHU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=d6PMTZjQ7ZSxzrqFK/e2yI5C8+JzcOrD2Qt5cClF8mvJrqAShnmRPOj6My2rjA2cd
	 1ci29qzO5V6gHwW5lWsIxJerW/YKdpdLVD1+jzzUrFVbzJ4W/g241y0u1aby3faEWw
	 dIqgUzTgMb+vIaeGNQqCSsiLOY9tI7MxfcoAjvj8=
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 23 Sep 2026 16:21:48 +0100
Subject: [PATCH v2 08/14] perf cs-etm: Centralize branch sample synthesis
 checks
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-perf_cs_etm_fix_non_taken-v2-8-6ab8c07a5455@arm.com>
References: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
In-Reply-To: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Suyash Mahar <smahar@meta.com>, 
 Amir Ayupov <aaupov@fb.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790176913; l=2314;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=7P52Iamvzkdn9OJUTBT7htFwBgcAKkrJTYDZdLDrnHU=;
 b=erlS3IJaBTyVBA7wVoMmrsa9kP3LBQ1uP7H7zeLDxlwD+GmLediFjMaSkpeyuHFLm+Sq3Q2Ot
 H6pTVJGzJV/Bf7j802YxLvf3vPZBvTZxpInkUwA1nbnhdfCI9jL8XBI
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Move the branch-synthesis option and packet checks from cs_etm__sample()
into cs_etm__synth_branch_sample(), alongside the existing branch filter.
Call the helper directly from cs_etm__sample() and cs_etm__flush().

Accept trace-start and trace-end flags, this preserves boundary samples
without a taken branch.

Assisted-by: Codex:gpt-6
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 5b5ee52c0277f5ff8f03c2908e4af1d7801845ff..c8a92b5dba6001329d68766d540b9b7ead90e9e6 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1726,6 +1726,14 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
 	} dummy_bs;
 	u64 ip;
 
+	if (!etm->synth_opts.branches)
+		return 0;
+
+	if (!cs_etm__packet_has_taken_branch(tidq->prev_packet) &&
+	    !(tidq->prev_packet->flags & (PERF_IP_FLAG_TRACE_BEGIN |
+					  PERF_IP_FLAG_TRACE_END)))
+		return 0;
+
 	if (etm->branches_filter &&
 		!(etm->branches_filter & tidq->prev_packet->flags))
 		return 0;
@@ -1965,23 +1973,9 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 		}
 	}
 
-	if (etm->synth_opts.branches) {
-		bool generate_sample = false;
-
-		/* Generate sample for tracing on packet */
-		if (tidq->prev_packet->sample_type == CS_ETM_DISCONTINUITY)
-			generate_sample = true;
-
-		/* Generate sample for branch taken packet */
-		if (cs_etm__packet_has_taken_branch(tidq->prev_packet))
-			generate_sample = true;
-
-		if (generate_sample) {
-			ret = cs_etm__synth_branch_sample(etmq, tidq);
-			if (ret)
-				return ret;
-		}
-	}
+	ret = cs_etm__synth_branch_sample(etmq, tidq);
+	if (ret)
+		return ret;
 
 	cs_etm__packet_swap(etm, tidq);
 
@@ -2049,12 +2043,9 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
 	if (err)
 		return err;
 
-	if (etm->synth_opts.branches &&
-	    tidq->prev_packet->sample_type == CS_ETM_RANGE) {
-		err = cs_etm__synth_branch_sample(etmq, tidq);
-		if (err)
-			return err;
-	}
+	err = cs_etm__synth_branch_sample(etmq, tidq);
+	if (err)
+		return err;
 
 swap_packet:
 	cs_etm__packet_swap(etm, tidq);

-- 
2.34.1

