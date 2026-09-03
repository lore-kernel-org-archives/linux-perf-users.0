Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7E143F8DB;
	Thu,  3 Sep 2026 08:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423240; cv=none; b=UMsi+MexUz5DT3zzX7+oXg0cOoaQvl9ANHzK93owBgxXGvm7Qh60IDeecFGgKBYbcBpC0Q9FysqGnUResKWRilQWBVbURToDB4zWx2pOOryv30u5fj3ZpDH4YyYsPGBr19bLTBFCvJWwt+xfhAV2YjGU3qmJiTkSOCCSo8QbIjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423240; c=relaxed/simple;
	bh=NICJ31aSM7j+n3iI6qdcmSuhPBo0RJZ+0ZHN7diOnCE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YE5oIDiyJskphG7m2hMyPyA0UwBz9ezwSkilCYpwxFYR/dLo0do3tW2PnDClYMXjz6wJjeMnfYsqaKGal7eNa9juMDudsoeG+QRgwjZ301pleHesmokQsBiSZMzMixNFAHfnNk9nwCNd9nA58h43xg6f3Dw8GqccvI7JFCu5TBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b=l0kLe5tk; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b="l0kLe5tk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=l0kLe5tkbdOOtkOf+AukR9/RTD7tgMT2JH4jLGLqTkW8hXJ15A5xvxLUr3c0pPcd/xgPKSLATtTVo
	 zEpfkHVLzUY0DX12zTq4xd0Q5bTJoMP1kEszt65fqr0deCzSEkWJOXFIvj2WhACQlBh4Yy+tWeNJlP
	 LG11nn1EBqLfYp2k=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26a992c402d4-e62b5;
	Thu, 03 Sep 2026 16:13:53 +0800 (CST)
X-RM-TRANSID:2ee26a992c402d4-e62b5
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26a992c40dc8-1a1e1;
	Thu, 03 Sep 2026 16:13:53 +0800 (CST)
X-RM-TRANSID:2ee26a992c40dc8-1a1e1
From: liujing <liujing@cmss.chinamobile.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Jing <liujing@cmss.chinamobile.com>
Subject: [PATCH] perf python: Fix redundant self-assignment in get_argument_count()
Date: Thu,  3 Sep 2026 16:13:50 +0800
Message-Id: <20260903081350.4676-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liu Jing <liujing@cmss.chinamobile.com>

In get_argument_count(), the variable code_obj is assigned to itself
before being assigned the result of PyObject_GetAttrString(). This is
a redundant self-assignment that appears to be a typo.

Fix it by removing the redundant self-assignment.

Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
---
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -165,7 +165,7 @@
 {
 	int arg_count = 0;
 
-	PyObject *code_obj = code_obj = PyObject_GetAttrString(handler, "__code__");
+	PyObject *code_obj = PyObject_GetAttrString(handler, "__code__");
 	PyErr_Clear();
 	if (code_obj) {
 		PyObject *arg_count_obj = PyObject_GetAttrString(code_obj,




