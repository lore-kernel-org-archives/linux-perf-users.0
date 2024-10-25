Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA5D201018;
	Fri, 25 Oct 2024 10:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729853556; cv=none; b=NOyjArtmTPvnkNVWv3rmFM6Fsyd7hUCnMDo5YDvQzVzIr5BSJTXUy3pO0Q/h6Iutn0k3ovzqhUPY7gSa1uv2KKev+UUnISMZySJqPvr6JAIPCpnr7CV2RZ+zcvwoXbNyzrH5hPATdgAW6Jfny82yXOvKkTWiitb2wbpUyNyYbOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729853556; c=relaxed/simple;
	bh=djfXy4XGascfohifZ7bNy1cCAu0obVtC6gGP1iwhofw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=st+/rsZ1JtDho/rzdwjI/7rB9nCT/zcXHCVS/UnCg0isOB3vaEihOBElQAAUDIxxThqwd0YWhYl0Gl3yB95lJPj0VDqWqQA1IQv7lI/60XDD98wWPiMVgF2WfcMB+fm+0W139phsxo51xUQE36F56acZh6DTYqyFgfvB2pWGY4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C516A339;
	Fri, 25 Oct 2024 03:53:03 -0700 (PDT)
Received: from VDW30FN91H.arm.com (unknown [10.57.79.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CC3F53F73B;
	Fri, 25 Oct 2024 03:52:31 -0700 (PDT)
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
Subject: [PATCH v10 4/4] perf arm-spe: Update --itrace help text
Date: Fri, 25 Oct 2024 11:52:12 +0100
Message-Id: <20241025105212.51779-5-graham.woodward@arm.com>
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
index 19cc179be..40476b227 100644
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
index 0a3eda482..de2b0b479 100644
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
index a1895a4f5..dddaf4f3f 100644
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

