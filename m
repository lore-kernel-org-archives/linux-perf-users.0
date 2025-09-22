Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C7F27F73A;
	Mon, 22 Sep 2025 09:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758532851; cv=none; b=A+kf1I0UUgZA6qnVy5EkqN7Sy4IWafuOiOxUZAex7W7igDrLLGJu1FTO2fTsT6c7e1zZwr+V4gC+f0QnPJo+CTbriw0+rdkXFHBu9n2xoxBqMjCLoULZJOtRr3kNL/Nuc1sO6fTCUHGkxSYhvV/U2Z/updLU/rHXYgjiZG/d5FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758532851; c=relaxed/simple;
	bh=S0/nrakrevGRyR2hm7HvwMARrNMX5on+9G/g+0431lw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e8tfyDpTSN0OiQnwVV0GXloowy/9QXQwvk++Ops8Ldh7wASK+aAKjniRA2Eq4xKd4TNXm4V2PKhUq6X1w258JtTifYF7WlKQJHtV9xWB64x0La85zVF9PutTMyc67UulA7bqyd53n3+GWwCtqHy+EWv62dr+YQfi2PdDiagrZek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee568d11432e3d-2df46;
	Mon, 22 Sep 2025 17:17:39 +0800 (CST)
X-RM-TRANSID:2ee568d11432e3d-2df46
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee868d114320c6-9e9a0;
	Mon, 22 Sep 2025 17:17:39 +0800 (CST)
X-RM-TRANSID:2ee868d114320c6-9e9a0
From: liujing <liujing@cmss.chinamobile.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] perf bench messaging: Fix the formatting issue when printing.
Date: Mon, 22 Sep 2025 17:17:36 +0800
Message-Id: <20250922091736.2798-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The unsigned int type should use the %u format specifier when
printing with printf or related functions.

Signed-off-by: liujing <liujing@cmss.chinamobile.com>
---
 tools/perf/bench/sched-messaging.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
index 93dcd9dba3d0..0a447f279d68 100644
--- a/tools/perf/bench/sched-messaging.c
+++ b/tools/perf/bench/sched-messaging.c
@@ -338,9 +338,9 @@ int bench_sched_messaging(int argc, const char **argv)
 
 	switch (bench_format) {
 	case BENCH_FORMAT_DEFAULT:
-		printf("# %d sender and receiver %s per group\n",
+		printf("# %u sender and receiver %s per group\n",
 		       num_fds, thread_mode ? "threads" : "processes");
-		printf("# %d groups == %d %s run\n\n",
+		printf("# %u groups == %u %s run\n\n",
 		       num_groups, num_groups * 2 * num_fds,
 		       thread_mode ? "threads" : "processes");
 		printf(" %14s: %lu.%03lu [sec]\n", "Total time",
-- 
2.27.0



