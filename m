Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C97B1DED55;
	Fri,  8 Nov 2024 10:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731061727; cv=none; b=HJOG/6Y3aZrolreA4GB1Q170wNcU0qa2OzQ2kwLVkAeRnP7Oz9VkIE/4mAxqsm59hR1H5p9OJlCgtrP7CIEgkmLvSj7uNh39NVHocUOy3hhlQY5iRaPaFSZWP6PbXgjw6JH2Xx5aR4O6+mjVto4ERSIjBxFjixPcYcseLM8+yS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731061727; c=relaxed/simple;
	bh=5A7Sf9whBIfDtwZj3N53gko2SBUFHYbah3jhq6lH02g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IgK9uX//Sdlu9Pvi+qdp4IZYTcTWumc9UlZGnG8fOrmOBEgPhnVSNB5fwH0Wb9wachsXO8EyGHk/KxXsEpWZuyqN14aQWuU9RwL6IbbaxF8pmyKhH9nwYLDff8pFxEPDN4Pwbj6fKt7ph7uc9BXh8EhxOsXBTeFqpwVCJbWZFXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee5672de7d35df-f25f1;
	Fri, 08 Nov 2024 18:28:37 +0800 (CST)
X-RM-TRANSID:2ee5672de7d35df-f25f1
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee3672de7d068e-98254;
	Fri, 08 Nov 2024 18:28:37 +0800 (CST)
X-RM-TRANSID:2ee3672de7d068e-98254
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
Subject: [PATCH] perf tools: Add "source" symbolic link to .gitignore
Date: Fri,  8 Nov 2024 18:13:09 +0800
Message-Id: <20241108101309.260550-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds the "source" symbolic link to the .gitignore file,
ensuring that it will not affect the source tree.

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
---
 tools/perf/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index f5b81d439..c23d54bb9 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -53,3 +53,4 @@ libtraceevent_plugins/
 fixdep
 Documentation/doc.dep
 python_ext_build/
+source
-- 
2.27.0



