Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BE215625A;
	Mon, 11 Nov 2024 08:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731313656; cv=none; b=GZ3ZOCHT+LEDfgsTz7OkPlEXma9+aW+IES+1cWhmCdLzH42+ccKsMG9jzJ6hoEIs5btJfjCRGNXOP5h+kwydcdaRtAhOcg4dyUlpJJwWxCO7QLDMpNfOYpb1bAzem0POeIxB0e0PZKyMePpNZde35r5wRyGOyAowmSMvmvG16cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731313656; c=relaxed/simple;
	bh=BXBpk2AxFop0CaSxn3CIwUgeiR8slV0oNhrUI0E+fks=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GsnXsAmN+COm4bZM7gHGNFBTgbIinvqvYVWuQAMgzP5/ptwlbvW5w45TXENev425Bo1ZAs68CxVEcDptU98NtcbInQSoyILAPbdpzIGpkjMkIhlxeBiylZPPucC+7TpKQfFHunSBQoCbZCDlKnj4qS0j6oWAaDfJeuFrrG4FxZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16731bff220c-d4b21;
	Mon, 11 Nov 2024 16:27:30 +0800 (CST)
X-RM-TRANSID:2ee16731bff220c-d4b21
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36731bff1b67-20d7e;
	Mon, 11 Nov 2024 16:27:30 +0800 (CST)
X-RM-TRANSID:2ee36731bff1b67-20d7e
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
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
	Luo Yifan <luoyifan@cmss.chinamobile.com>
Subject: [PATCH] perf tools: Remove redundant variable assignment
Date: Mon, 11 Nov 2024 16:27:13 +0800
Message-Id: <20241111082713.274761-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch makes a minor change that removes the redundant assignment
to the variable ret, simplifying the code.

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
---
 tools/perf/jvmti/jvmti_agent.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/jvmti/jvmti_agent.c b/tools/perf/jvmti/jvmti_agent.c
index 526dcaf9f..751219143 100644
--- a/tools/perf/jvmti/jvmti_agent.c
+++ b/tools/perf/jvmti/jvmti_agent.c
@@ -408,9 +408,7 @@ jvmti_write_code(void *agent, char const *sym,
 
 	funlockfile(fp);
 
-	ret = 0;
-
-	return ret;
+	return 0;
 }
 
 int
-- 
2.27.0



