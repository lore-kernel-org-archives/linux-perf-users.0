Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A3620D511;
	Fri, 25 Oct 2024 14:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866664; cv=none; b=QlrAWnuSnyJm5fHuSY0srKGmewvO7rCJjc1gryECA5cGJFCJbkff6gKvdu2E85MgZzsUkxZuuYykgXSC8btBMEL+pWChrpmL3Z+OF+7GNk++1fr7Lfb3xj1Y+/FeNeHhvMk1gUkdepHTwMprDbal5HExCy2bE+AKm0CfcvNpf44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866664; c=relaxed/simple;
	bh=q52djQFHEjhXTc/3jcOqaJm0M9hd9oTCAEtVhMChPaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D8HUrI9nYtw4+99fGQYkspiUZ26fJ5ydtbzadqvoNTIposDfY8TvmH57C75aAP7o+p0p0ceqQgylaIrX/ZilG/jZ38bi401vp938chlie/bHyTXXTjLsorgdmN4OkuL9mqbSxb/oRPEONjN3FMeaLC8Gi3OW1EPXEW7PiULfdN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21C22339;
	Fri, 25 Oct 2024 07:31:31 -0700 (PDT)
Received: from VDW30FN91H.arm.com (unknown [10.57.79.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 249AB3F73B;
	Fri, 25 Oct 2024 07:30:58 -0700 (PDT)
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
Subject: [PATCH v1 4/4] perf arm-spe: Update --itrace help text
Date: Fri, 25 Oct 2024 15:30:09 +0100
Message-Id: <20241025143009.25419-5-graham.woodward@arm.com>
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

The --itrace help now needs updating to reflect that
the --itrace=b argument sythesises branches as well
as branch misses.

Signed-off-by: Graham Woodward <graham.woodward@arm.com>
---
 tools/perf/Documentation/itrace.txt       | 2 +-
 tools/perf/Documentation/perf-arm-spe.txt | 2 +-
 tools/perf/util/auxtrace.h                | 3 +--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index 19cc179be9a7..40476b227f8d 100644
--- a/tools/perf/Documentation/itrace.txt
+++ b/tools/perf/Documentation/itrace.txt
@@ -1,6 +1,6 @@
 		i	synthesize instructions events
 		y	synthesize cycles events
-		b	synthesize branches events (branch misses for Arm SPE)
+		b	synthesize branches events
 		c	synthesize branches events (calls only)
 		r	synthesize branches events (returns only)
 		x	synthesize transactions events
diff --git a/tools/perf/Documentation/perf-arm-spe.txt b/tools/perf/Documentation/perf-arm-spe.txt
index 0a3eda482307..de2b0b479249 100644
--- a/tools/perf/Documentation/perf-arm-spe.txt
+++ b/tools/perf/Documentation/perf-arm-spe.txt
@@ -187,7 +187,7 @@ groups:
   7 llc-access
   2 tlb-miss
   1K tlb-access
-  36 branch-miss
+  36 branch
   0 remote-access
   900 memory
 
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index a1895a4f530b..dddaf4f3ffed 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -75,7 +75,6 @@ enum itrace_period_type {
  *          (not fully accurate, since CYC packets are only emitted
  *          together with other events, such as branches)
  * @branches: whether to synthesize 'branches' events
- *            (branch misses only for Arm SPE)
  * @transactions: whether to synthesize events for transactions
  * @ptwrites: whether to synthesize events for ptwrites
  * @pwr_events: whether to synthesize power events
@@ -650,7 +649,7 @@ bool auxtrace__evsel_is_auxtrace(struct perf_session *session,
 #define ITRACE_HELP \
 "				i[period]:    		synthesize instructions events\n" \
 "				y[period]:    		synthesize cycles events (same period as i)\n" \
-"				b:	    		synthesize branches events (branch misses for Arm SPE)\n" \
+"				b:	    		synthesize branches events\n" \
 "				c:	    		synthesize branches events (calls only)\n"	\
 "				r:	    		synthesize branches events (returns only)\n" \
 "				x:	    		synthesize transactions events\n"		\
-- 
2.40.1

