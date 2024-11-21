Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA66915ADB4;
	Thu, 21 Nov 2024 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732192601; cv=none; b=ejtY/ny2pfEDf6w/PJcIWTLXycPpFzWPQKE47B8MR6S+YPTFowx56p8VEzWTMKT0Vh5/E/W5NIVgDDVPJLmXAzs/W30+D7IAViR4L+NhgNHg9w9CPDuOeUngT3oyN6M8dYlwILBXWDlWvynYM56dmveRUNdub8v3cxmD+zySUDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732192601; c=relaxed/simple;
	bh=Fk+4Ys5HM6Xi/65FH8+mZ2tifyhK6thhfMK7TlPEBFw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z76GwuGkj0vsrCV/UsqNcrz4AODBUWc6E8oT4VRWH3N+jC8Yf8T0YgSZ7FkvaOKDCarHMw3mb+fKnSTCYM6uIEK5hGCw6/ue/FKyXwA4nnbNgEPg/GC1EZsLncbcE1MLsMTdNyLonvYYTh+ORJoimGUvY4pHPV4e7F4ossBKOhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee4673f2953da1-306ab;
	Thu, 21 Nov 2024 20:36:35 +0800 (CST)
X-RM-TRANSID:2ee4673f2953da1-306ab
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.55.1.69])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee1673f29522cb-d7016;
	Thu, 21 Nov 2024 20:36:35 +0800 (CST)
X-RM-TRANSID:2ee1673f29522cb-d7016
From: liujing <liujing@cmss.chinamobile.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] perf intel-pt: Fix variable duplicate check
Date: Thu, 21 Nov 2024 20:36:33 +0800
Message-Id: <20241121123633.5805-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Identical condition 'data->from_mtc', second condition is always false,
so duplicate checks are eliminated.

Signed-off-by: liujing <liujing@cmss.chinamobile.com>

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index e733f6b1f7ac..9fde2c49f8b5 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -883,7 +883,7 @@ static int intel_pt_calc_cyc_cb(struct intel_pt_pkt_info *pkt_info)
 			return 1;
 		timestamp = pkt_info->packet.payload |
 			    (data->timestamp & (0xffULL << 56));
-		if (data->from_mtc && timestamp < data->timestamp &&
+		if (timestamp < data->timestamp &&
 		    data->timestamp - timestamp < decoder->tsc_slip)
 			return 1;
 		if (timestamp < data->timestamp)
-- 
2.27.0



