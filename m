Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C1442589D;
	Thu,  3 Sep 2026 08:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423887; cv=none; b=GKXQH7sgYe9OIgaCs6Yt/qBWcvy9xfk21YAGK0So7uhKh96BpXSlzJ/23fFvbr0MZB5DNaTR2KHV0sg6r/UINRgNfox2ulhM5sX1GcVBkIU5ze9kCmXIHzO2oIfuguwx1UH9M1556swPpkPtdkkLyldEY1sZ+Fj6XiTxonEVfno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423887; c=relaxed/simple;
	bh=B1P6oaGpukfTHygtQQ6l5xgWGVGaa//TPEzsoP/W7mc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dr2Zdn93cfM5EXZKTpmikA18MC58P0rb2y0XW2rBDcg3iriKACfjeDkzDlG3G1Cd/+/FiLRISLUEgM3m0ZxqMS9usO6+cM5t/ej55zGLgxVHHEXRtBCGfJ6xsA3WFqz5XF09oLtzGbWgPAejWFmqAowbKRvHknS6WtaEwvPR9j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b=uptuTMmU; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b="uptuTMmU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=uptuTMmUiIuCcWUjTIQp+1djgABx2jBqebmRqNiLEdrgYHkmYYfJRbwICP0Xl73kkS7Qrd0a6Ks9f
	 9DaTzftLHsFQyQ7Skfzd4sfcRbgWlGDctMm91IqxyrB/MHiQcaVkzqTLyChomf79ErLKQ/0kgbcDSt
	 51qvRmTLIr1aROHQ=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36a992e0e45f-76cbc;
	Thu, 03 Sep 2026 16:21:34 +0800 (CST)
X-RM-TRANSID:2ee36a992e0e45f-76cbc
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6a992e0abfe-1a00f;
	Thu, 03 Sep 2026 16:21:34 +0800 (CST)
X-RM-TRANSID:2eea6a992e0abfe-1a00f
From: liujing <liujing@cmss.chinamobile.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Jing <liujing@cmss.chinamobile.com>
Subject: [PATCH] perf sched: Fix resource leak in enable_sched_schedstats()
Date: Thu,  3 Sep 2026 16:21:25 +0800
Message-Id: <20260903082128.4972-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liu Jing <liujing@cmss.chinamobile.com>

In enable_sched_schedstats(), the FILE pointer fp is only closed when
ch == '0'. If ch is not '0' (i.e., sched_schedstats is already enabled),
the function returns 0 without calling fclose(fp), causing a resource
leak.

Fix it by adding fclose(fp) before the return statement.

Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
---
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -4114,8 +4114,8 @@
 		*reset = 1;
 		rewind(fp);
 		putc('1', fp);
-		fclose(fp);
-	}
+	}
+	fclose(fp);
 	return 0;
 }
 




