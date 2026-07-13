Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFFC34EF11;
	Mon, 13 Jul 2026 18:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965646; cv=none; b=vCqVYWAnP+wVv9GYd7pJbGSZ2EDmimsmtofTbsTnrkArjqLbhjeGE5EDPEduuaJSrFGGFJAop8wpeBe++ASpoMES/+vWiOE1f9leQ1+OwzF5Ai/RCtEE8SzRwARa0BKqTEI/Tov4jzqWBPxUBC7vaevZ7+cW4i8gGUlgUOGgObI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965646; c=relaxed/simple;
	bh=CUa2bT0eVTigehpKDFKSL6mjM9vm0Q7oszZakKLTV7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LrwMFCLRyGSHuBdPxzryz5Hsb8v602Liee1qlwiwJkb8b07dx6OYIlS/wMAOSwSCkNERBdppf9k/a6p8D2j0iGtT8bX6i2n/XIJYpUyqhGhs4fioWnmDu636bfFrB30VL7zq/yeAy/gPQ0PwhPIGjvzHGE/LUBV9D/43+1DBiy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=c5VXTsaX; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="c5VXTsaX"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 592F11655;
	Mon, 13 Jul 2026 11:00:39 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67FA23F7D8;
	Mon, 13 Jul 2026 11:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783965643; bh=CUa2bT0eVTigehpKDFKSL6mjM9vm0Q7oszZakKLTV7k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=c5VXTsaXuFy9OIMvv4QPf3V3m1OCyIhv5iZojp8nVOcbHbO4LjCdEtN1DD6nAjuq8
	 tQONb1oB5MuXlMad395EeccILRZgySeBDJ86dn/Ct6fZhlMp6zBMjw4XBiZGDdDaPZ
	 AswNx5qYMPvhpB2cY2/PxatcmIl65s4vRC/4v7Zc=
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 13 Jul 2026 19:00:28 +0100
Subject: [PATCH 2/2] perf cs-etm: Centralize branch sample checks
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-perf_cs_etm_fix_non_taken-v1-2-4561607fc69f@arm.com>
References: <20260713-perf_cs_etm_fix_non_taken-v1-0-4561607fc69f@arm.com>
In-Reply-To: <20260713-perf_cs_etm_fix_non_taken-v1-0-4561607fc69f@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783965636; l=2069;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=CUa2bT0eVTigehpKDFKSL6mjM9vm0Q7oszZakKLTV7k=;
 b=xAg5bgeFR2wRfmMeJIDvqLx43OH92ymyXh2TCTICDAbR78G0/5yuQL9QvIRa+JVkibGUhibBo
 bdwWcsyqNmWBkG9PcAJz3AYS1K23Cz0mYM5JjI+3tw4LzY0PzjK96e/
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

cs_etm__sample() validates whether the previous packet should generate
a branch sample before calling cs_etm__synth_branch_sample(), while
cs_etm__flush() generates branch samples unconditionally.

Move the eligibility check into cs_etm__synth_branch_sample() so that
both paths apply the same rule: generate branch samples only for
discontinuity packets or range packets ending in a taken branch.

Fixes: d603b4e9f9c3 ("perf cs-etm: Generate branch sample when receiving a CS_ETM_TRACE_ON packet")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 05e698f666bbe07af9caeda1a673f22d7196817a..dec50e2cc7b7857a04f631b3e0e08beb6e7e280a 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1710,6 +1710,11 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
 		!(etm->branches_filter & tidq->prev_packet->flags))
 		return 0;
 
+	/* Generate branch sample only for tracing on or taken branches */
+	if (tidq->prev_packet->sample_type != CS_ETM_DISCONTINUITY &&
+	    !cs_etm__packet_has_taken_branch(tidq->prev_packet))
+		return 0;
+
 	perf_sample__init(&sample, /*all=*/true);
 	ip = cs_etm__last_executed_instr(tidq->prev_packet);
 
@@ -1946,21 +1951,9 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 	}
 
 	if (etm->synth_opts.branches) {
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
+		ret = cs_etm__synth_branch_sample(etmq, tidq);
+		if (ret)
+			return ret;
 	}
 
 	cs_etm__packet_swap(etm, tidq);

-- 
2.34.1

