Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505D51D2207;
	Thu, 21 Nov 2024 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732187715; cv=none; b=CasB0wWHvpEF34Xu/g4qrqjgOQr+edaW0rw2f3Hx/g0q2zSNvxM6X8HiBn7rTiLEXYbXW9dhYMk8ZVcg+obAJwSxkyvGZdF9uZXWqZeZJ4U/yGEa0KWCA08uM69UE9aHa3XKHd6KkGatMlXMkrSGYddN/kTuhIIjd82+Ig/W5MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732187715; c=relaxed/simple;
	bh=RnWVzHR5TCfOE5svzQfEVVgpKgNQOAMf36h8UEyZ8yM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X8NPssSW2njmsDa8101+NgCyLX1vzj/4F6W4Y6+UXZ97ozJeUgEURhWlMMktOEZGk0q5jRyEvBJ98YYOVGmNjEzJSTkVuWT0orVzSkMzlM2qU8/0ksWoi7/6wHiSieysp4FfiI1yEiaBrvCdMTrvLw19MxF9FYaplzNO9w8RBVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee1673f163ad5a-2f671;
	Thu, 21 Nov 2024 19:15:06 +0800 (CST)
X-RM-TRANSID:2ee1673f163ad5a-2f671
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee7673f161c652-dd941;
	Thu, 21 Nov 2024 19:15:06 +0800 (CST)
X-RM-TRANSID:2ee7673f161c652-dd941
From: guanjing <guanjing@cmss.chinamobile.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	algonell@gmail.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	guanjing <guanjing@cmss.chinamobile.com>
Subject: [PATCH v2] perf intel-pt: cleanup unneeded return variable in intel_pt_text_poke()
Date: Thu, 21 Nov 2024 19:14:14 +0800
Message-Id: <20241121111414.33760-1-guanjing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removed Unneeded variable: "ret".

Since the function intel_pt_text_poke() always returns zero,
drop the return value and change the function to the void type.

Signed-off-by: guanjing <guanjing@cmss.chinamobile.com>
---
 tools/perf/util/intel-pt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 30be6dfe09eb..a13add0e0be4 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -3391,7 +3391,7 @@ static int intel_pt_find_map(struct thread *thread, u8 cpumode, u64 addr,
 }
 
 /* Invalidate all instruction cache entries that overlap the text poke */
-static int intel_pt_text_poke(struct intel_pt *pt, union perf_event *event)
+static void intel_pt_text_poke(struct intel_pt *pt, union perf_event *event)
 {
 	u8 cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
 	u64 addr = event->text_poke.addr + event->text_poke.new_len - 1;
@@ -3402,7 +3402,6 @@ static int intel_pt_text_poke(struct intel_pt *pt, union perf_event *event)
 	struct machine *machine = pt->machine;
 	struct intel_pt_cache_entry *e;
 	u64 offset;
-	int ret = 0;
 
 	addr_location__init(&al);
 	if (!event->text_poke.new_len)
@@ -3443,7 +3442,6 @@ static int intel_pt_text_poke(struct intel_pt *pt, union perf_event *event)
 	}
 out:
 	addr_location__exit(&al);
-	return ret;
 }
 
 static int intel_pt_process_event(struct perf_session *session,
@@ -3522,7 +3520,7 @@ static int intel_pt_process_event(struct perf_session *session,
 		err = intel_pt_context_switch(pt, event, sample);
 
 	if (!err && event->header.type == PERF_RECORD_TEXT_POKE)
-		err = intel_pt_text_poke(pt, event);
+		intel_pt_text_poke(pt, event);
 
 	if (intel_pt_enable_logging && intel_pt_log_events(pt, sample->time)) {
 		intel_pt_log("event %u: cpu %d time %"PRIu64" tsc %#"PRIx64" ",
-- 
2.33.0



