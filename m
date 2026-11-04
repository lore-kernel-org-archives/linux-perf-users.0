Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793782963;
	b=IQDx4nQxEDEDyDORSYLYU6NMMNcW6VQ6in1e6jfPR9pAvmSGxgPPeUF55L/uHWJTA/ms
	 EgRhOeo8MpLXgDW4l+NewcOd9VFG4hEektpBnKjzmIiSTuFmvLsmZKDw1axpybVfmVI1c
	 DwxpvMbY3XWKidHt7RsOQN+YIh/acIS0PfqZEWSWltrlNjT56efCbLP4JaFkoNVmBwkSW
	 7m3KNqZAc8GK1e/TNHldWHdcvodggCWtpdORfbeABL5waIwo1dl+IAqoyIVcdonu1qgZR
	 +wjhouD0aaPw+Ps8wpbkhcay2oC8E8szbcOsjSh1oPUqSK4tQAvUpakiuqneipL6YCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793782963;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mWuTGM4ocexaL+m/iHzklzCu/6DFXmSRf10f0FvMRnU=;
	b=JK1TyLInYSTD7Gc+lIYwqbSD1ACExCzq8B6GM3uU0gTyrBUuZ+Y5Q3luol6zFjvL3PuV
	 Jv5s4PI/nmIjpWqT+Zm2f8LnumA+1asSeJjZFHoQxNKnynQT2RKex+eKq+0tKsiSaU/k/
	 A5sXu1ilQAAkTbmozpdYrvc5211Gj0G71nhSUWUt/KtsaocOFASZGDN4QO0hlLt4f16x0
	 4iij2lUWQniKfPFQghaORGpaILmlYbk1m7VjYoz2MO0gd7Liczjzh19ah3+t4msavmhDb
	 4VQZlQs8L8R1uvgJpw9S7oWkiOmVBMHc+Lb9fI5+nu+/WRZuRLhKrJhLaqeydjc/9XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=R39d5J93;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7220606A32D;
	Wed,  4 Nov 2026 09:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7220606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=R39d5J93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=R39d5J93BnU/6vNg4N5fpXSMlEReHvcLOPr3n3xPIbNV3D1vXs4FA3Md5m8NuoBX7RqI672XTaoEv
	 kVsYhw6ptJmD0YRxTC2FyVBGkRBsIo0jSOydWqm8JrkMgoFRfVWM5OhhStj4bFbM2OFhoUJquzKlUK
	 Z9D/oolsq/pjGqZ8=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26aeaf4ae9de-d8384;
	Wed, 04 Nov 2026 17:02:39 +0800 (CST)
X-RM-TRANSID:2ee26aeaf4ae9de-d8384
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHB-W5100250 (unknown[36.137.216.21])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6aeaf4a7d59-c7ea5;
	Wed, 04 Nov 2026 17:02:38 +0800 (CST)
X-RM-TRANSID:2eea6aeaf4a7d59-c7ea5
From: Gu Bin <gubin@cmss.chinamobile.com>
To: acme@kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf hist: Fix branch_info index for sample weight
Date: Wed,  4 Nov 2026 17:02:28 +0800
Message-ID: <20261104090229.1870-1-gubin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iter_add_next_branch_entry() is called once per branch and uses &bi[i]
for the hist entry, but reads the weight from bi->flags.cycles (i.e.
bi[0]) for every branch, so every entry is weighted with the first
branch's cycle count. This is incorrect when the branch stack contains
more than one entry with different cycle counts, as the weight of each
hist entry fails to reflect the cycles of its own branch.

Use bi[i].flags.cycles, as the surrounding code already does.

Fixes: 0e332f033a82 ("perf tools: Add support for cycles, weight branch_info field")
Signed-off-by: Gu Bin <gubin@cmss.chinamobile.com>
---
 tools/perf/util/hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index e75a4fcce975..364754e9d12a 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1055,7 +1055,7 @@ iter_add_next_branch_entry(struct hist_entry_iter *iter, struct addr_location *a
 	 * and not events sampled. Thus we use a pseudo period of 1.
 	 */
 	sample->period = 1;
-	sample->weight = bi->flags.cycles ? bi->flags.cycles : 1;
+	sample->weight = bi[i].flags.cycles ? bi[i].flags.cycles : 1;
 
 	he = hists__add_entry(hists, al, iter->parent, &bi[i], NULL, NULL,
 			      sample, true);
-- 
2.55.0.windows.3



