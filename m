Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D62D3FF89B;
	Thu,  3 Sep 2026 08:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423719; cv=none; b=JL1Kkewh47QMpvKApSSXoCFiVhbduMMn7F5013M29pA4zXsDEXbu7Uph0JjaNKbJayqBH7Yb2IFZ1LCkfeL1taN9wNvsHslDLZajPeteUDtJrAqUWLfV+M+0MbWNub/79a53vdVtrlmUmwGO0MsD7MxXGakMVdXm1WtpA3blZ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423719; c=relaxed/simple;
	bh=DdMVno5WilvxqzTtEhhwAG4gL+tMpcAn4+BnRwJPgVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cSKPAdZY2L1CsLK7+4kGSMqx3Q9ztR7oHZo8jBdC1J39P5AJH5CrNRB6vTGJS7nrUVOg99wQAPTKrY6Vdslfxi7je2ttZdAqrUez//hwXnWsFnsxJyUyrpwXzcv47N4TZssMirhvT6pkPy8vl9QA4TlfhAHnoYzAzmQnYSsAtv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b=keDiiw3y; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b="keDiiw3y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=keDiiw3yeTwrRaWijiHh4wdL0DyhggXj7i/QHqnjnmeDswvKeUyk1vDgRNwPV7+J3K2VdCohSL1rk
	 MewA34cFlj/WHkoDuM06D9Gvv2r4lALcMIiDswIKjKLV1aw4gXr3ve5Vop9VFzNDiFBxQkBaiMHX8I
	 V2Ijoqk49kX/OnOM=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76a992e20bca-ab696;
	Thu, 03 Sep 2026 16:21:53 +0800 (CST)
X-RM-TRANSID:2ee76a992e20bca-ab696
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6a992e0abfe-1a03b;
	Thu, 03 Sep 2026 16:21:53 +0800 (CST)
X-RM-TRANSID:2eea6a992e0abfe-1a03b
From: liujing <liujing@cmss.chinamobile.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Jing <liujing@cmss.chinamobile.com>
Subject: [PATCH] perf script: Fix unsigned comparison against zero in print_bstack_flags()
Date: Thu,  3 Sep 2026 16:21:27 +0800
Message-Id: <20260903082128.4972-3-liujing@cmss.chinamobile.com>
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

In print_bstack_flags(), the variable `pos` is declared as `size_t`
(unsigned), making the check `pos < 0` always false. This means the
error return from snprintf() is never detected.

Fix it by changing the return type of bstack_event_str() to int and
the type of pos to int, so that negative return values from snprintf()
are properly checked.

Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
---
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -952,7 +952,7 @@
 	return printed;
 }
 
-static inline size_t
+static inline int
 bstack_event_str(struct branch_entry *br, char *buf, size_t sz)
 {
 	if (!(br->flags.mispred || br->flags.predicted || br->flags.not_taken))
@@ -966,7 +966,7 @@
 static int print_bstack_flags(FILE *fp, struct branch_entry *br)
 {
 	char events[16] = { 0 };
-	size_t pos;
+	int pos;
 
 	pos = bstack_event_str(br, events, sizeof(events));
 	return fprintf(fp, "/%s/%c/%c/%d/%s/%s ",




