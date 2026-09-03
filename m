Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7D638AC92;
	Thu,  3 Sep 2026 08:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423709; cv=none; b=OEEfM4OL3CrpTWc/rQM4uFzpss6PFGNMf/5jx1iJFwaGF6GKaBqr036HXC8ETpdH47Gh8MVfsRyZ6EGJYsWeFjG7/Pl9I33S2fuUiAgWWQY2SQUK9eAm2QJEyOJp0YOMfiREGYb3ivcRajM6n/onHZFdpYgR/5VKmOKHy+QJlGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423709; c=relaxed/simple;
	bh=e0oENFL3RmVm8Mh1wwnj1nTSPK2J3d6zYfJYwhRRmEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jSFR/O08TkRoZRmJAWUqh13Eb8Ce1NiAJGjz5vHosp5zutkutnqsy8OSkrsN06zo/UiKKGWYG8+yVlrwbSuqaJAwheRVkiEFA9phjNC67nLeXzP/TogJHdlv3Lz16m7Jo6HNjJmNJcaJ7KO/NY2rewhuBdxE9rK6Q66njDWxO6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b=GE/OIQEa; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b="GE/OIQEa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=GE/OIQEaCv+mkuM/7vHpgdiVjAg98umUT6fzxfiaXOIEQXygn/qtvj0ZvkXpY8bhQ0aGVQtaoSxrk
	 KrxOw/9yfJqfluME5veKWUxycnLSxLANOCl6vlLBOrq1VrN2DkJd4mHMkZxO5NB+TAX50fzE8NrJot
	 YWDmdHQUxTvfuEfM=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56a992e110fe-a9c8b;
	Thu, 03 Sep 2026 16:21:42 +0800 (CST)
X-RM-TRANSID:2ee56a992e110fe-a9c8b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6a992e0abfe-1a024;
	Thu, 03 Sep 2026 16:21:42 +0800 (CST)
X-RM-TRANSID:2eea6a992e0abfe-1a024
From: liujing <liujing@cmss.chinamobile.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Jing <liujing@cmss.chinamobile.com>
Subject: [PATCH] perf intel-pt: Fix undefined shift in intel_pt_bip()
Date: Thu,  3 Sep 2026 16:21:26 +0800
Message-Id: <20260903082128.4972-2-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20260903082128.4972-1-liujing@cmss.chinamobile.com>
References: <20260903082128.4972-1-liujing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liu Jing <liujing@cmss.chinamobile.com>

In intel_pt_bip(), the expression `1 << id` performs a signed integer
shift where id is a uint32_t. If id >= 32, this is undefined behavior.
The bounds check `id >= INTEL_PT_BLK_ITEM_ID_CNT` occurs after the shift,
so the UB has already happened.

Fix it by moving the bounds check before the shift and using `1U << id`
to perform an unsigned shift.

Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
---
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -2060,7 +2060,6 @@
 static void intel_pt_bip(struct intel_pt_decoder *decoder)
 {
 	uint32_t id = decoder->packet.count;
-	uint32_t bit = 1 << id;
 	int pos = decoder->blk_type_pos;
 
 	if (pos < 0 || id >= INTEL_PT_BLK_ITEM_ID_CNT) {
@@ -2068,6 +2067,7 @@
 			     id, decoder->blk_type);
 		return;
 	}
+	uint32_t bit = 1U << id;
 
 	if (decoder->state.items.mask[pos] & bit) {
 		intel_pt_log("WARNING: Duplicate block item %u type %d\n",




