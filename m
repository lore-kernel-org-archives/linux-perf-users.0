Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D625E1CB322;
	Thu, 21 Nov 2024 10:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732183280; cv=none; b=WNMtG9+Le/vGF3qSBCIZdpPCYMc5N4aa+1IWTcRHT4m/eYla138QrZQtEAhYGoL0HCBpHbONs/S9mfnHmUqC71TS6IMUHJlJW0yXBNO1Gx5gclF4xzlXtkp8u6bTe36PX2LRZHnU+r5FSG//BzvU21E/Bdvx8JUSqWEWfyR9mdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732183280; c=relaxed/simple;
	bh=nAhxoKllNHDMXHcCilHfGwN+oddbatYrmf8oLQPLf2I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=glR7OE6v4+GXyZobOxsYK42ST5D0nEpKGFO4WAWJFAzV7JJpQ67YSq/vdCaH+srGSIyWPYPorrcWDKWL8pmSl5sZeTFJG+Oh9UfkAfGKnHU7YzpRoCcayeouTDblUob+LOiP6cC2Aqs0FpKbz8f+Qq2cI85Yz5dVVCARmz/ZQUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee3673f04e78fd-2d125;
	Thu, 21 Nov 2024 18:01:11 +0800 (CST)
X-RM-TRANSID:2ee3673f04e78fd-2d125
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea673f04d07ea-ce2e0;
	Thu, 21 Nov 2024 18:01:11 +0800 (CST)
X-RM-TRANSID:2eea673f04d07ea-ce2e0
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
	algonell@gmail.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	guanjing <guanjing@cmss.chinamobile.com>
Subject: [PATCH v1] perf intel-pt: cleanup unneeded return variable in intel_pt_text_poke()
Date: Thu, 21 Nov 2024 18:00:47 +0800
Message-Id: <20241121100047.25318-1-guanjing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removed Unneeded variable: "ret"

Fixes: 0dd5041c9a0e ("perf addr_location: Add init/exit/copy functions")
Signed-off-by: guanjing <guanjing@cmss.chinamobile.com>
---
 tools/perf/util/intel-pt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 30be6dfe09eb..6c0234acc669 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -3402,7 +3402,6 @@ static int intel_pt_text_poke(struct intel_pt *pt, union perf_event *event)
 	struct machine *machine = pt->machine;
 	struct intel_pt_cache_entry *e;
 	u64 offset;
-	int ret = 0;
 
 	addr_location__init(&al);
 	if (!event->text_poke.new_len)
@@ -3443,7 +3442,7 @@ static int intel_pt_text_poke(struct intel_pt *pt, union perf_event *event)
 	}
 out:
 	addr_location__exit(&al);
-	return ret;
+	return 0;
 }
 
 static int intel_pt_process_event(struct perf_session *session,
-- 
2.33.0



