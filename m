Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E13843A7F5;
	Thu,  3 Sep 2026 08:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423726; cv=none; b=NwKBDCf8zGcYgkugH+N2M1TWNurWwA8S720Hk02nawFwpQ/2q8DdwKT7k08/bOb5JIx6iMO5gWTZDvq7P1RUoFUjDIZPe/65qnlNPamCSNsJ360LR9KnsCpn9cj4daKABY1l5kp5v9zBFxej6fYIp6FlZFKp5ulHt43zGYflBc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423726; c=relaxed/simple;
	bh=7wrng4S28gBvZ1YgAw4l5oVuorKzxm1yQJl7QN8AOyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LQdWHCuxccDODK05dripP+hmbA1AUO58QjN2unGqqcByOjJVy01QcJQjjSrFflXIxO9F0YTVbRWCDmYRx71TGF+L1SmCfUqLIP80OkV8J5rNOVOM8LEDHa4BWxnrqTwTmEtqFFhkL77Zt3dXYI5ethPh6NrbSZxzcx8d9CMm6bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b=QAOz2e1O; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b="QAOz2e1O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=QAOz2e1OhzSo1VaSB2kKIVqgtiMZHdsqhHtp6UxnZac+7vPgfXIYv5toto0KJn6VyQl2ya/U7o2Xf
	 erREItT3+CF94QBTefnqb61o8QmQwJl9fcT9J5DhkJvS+lXxKt4kP0Ak0UDHqyhrs5D4HKtJcp68sA
	 ui62LLDCk9cywH+s=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56a992e28111-a9c9e;
	Thu, 03 Sep 2026 16:22:00 +0800 (CST)
X-RM-TRANSID:2ee56a992e28111-a9c9e
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6a992e0abfe-1a04e;
	Thu, 03 Sep 2026 16:22:00 +0800 (CST)
X-RM-TRANSID:2eea6a992e0abfe-1a04e
From: liujing <liujing@cmss.chinamobile.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Jing <liujing@cmss.chinamobile.com>
Subject: [PATCH] perf arm: Fix memory leak in find_all_arm_spe_pmus()
Date: Thu,  3 Sep 2026 16:21:28 +0800
Message-Id: <20260903082128.4972-4-liujing@cmss.chinamobile.com>
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

In find_all_arm_spe_pmus(), if sprintf() fails, the function returns NULL
without freeing the previously allocated arm_spe_pmus array, causing a
memory leak.

Fix it by adding free(arm_spe_pmus) before the return NULL statement.

Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
---
--- a/tools/perf/arch/arm/util/auxtrace.c
+++ b/tools/perf/arch/arm/util/auxtrace.c
@@ -39,6 +39,7 @@
 		if (ret < 0) {
 			pr_err("sprintf failed\n");
 			*err = -ENOMEM;
+			free(arm_spe_pmus);
 			return NULL;
 		}
 




