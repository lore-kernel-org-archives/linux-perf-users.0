Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE57C219EA;
	Fri, 28 Jun 2024 05:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719552662; cv=none; b=qmmlu+JoJsH4WwVC86CW9TQ7DWST1VlfOgsyZc37G3tvYesrnwqRRCNYxr3p4Vu0KNmKElP/+E/VNVhKLQmzLiqAabv5GI/PnlmhfSrJgBB+7n6wd00v65yyBXEFAlTjb+Tk2oXocCx3ebbLQGw86dXAkE9q3TZaiHdsvyhLwRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719552662; c=relaxed/simple;
	bh=x3J6Id35ACBNdtacFHlNIG6XTfmXnJgexGO5FyJ6sqk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BQEjgSllLEbEGimz6y0YJOlPsLuBmLhll7yKFPX2/Omtz9dHePL4C3JqLtD1ye7T13vOhUpysQ5BBOnKg2fkQNm7X6Cr13EAIMMSIdlfT1sh2WPaeb8Xnc6OuTV0RZFw43Q4+27qUXhKvRK8OBdlUvmUKgQ/Rl09/AXIZRW3Jns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=E0Ta9VNF; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="E0Ta9VNF"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719552651; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=1fN3WKANKl6jeAXJaYcVVTxeU2dGcJfdmR9B6LXBtWs=;
	b=E0Ta9VNF9bLxlUUb1NRc7Y7YGdAeWrI4ogRnCaYt1pGsZL1NdcSTinSF+v6pB8Vra0Fb2jNVvG/qrG3QiXdFX4MAuv45Av0qvCATFMCvjYTgWs5OF7imdwfpRLZWxS4a5RvPFvogQQALUYOhl0kPEnw/Edz8hmjaxKE8kvNEIc0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W9P713Q_1719552650;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W9P713Q_1719552650)
          by smtp.aliyun-inc.com;
          Fri, 28 Jun 2024 13:30:50 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] perf: pmus: Remove unneeded semicolon
Date: Fri, 28 Jun 2024 13:30:49 +0800
Message-Id: <20240628053049.44521-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

./tools/perf/util/pmu.c:1776:49-50: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9443
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 tools/perf/util/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index c94a91645b21..884eb23445e4 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1773,7 +1773,7 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
 	size_t nr;
 
 	pmu_aliases_parse(pmu);
-	nr = pmu->sysfs_aliases + pmu->sys_json_aliases;;
+	nr = pmu->sysfs_aliases + pmu->sys_json_aliases;
 
 	if (pmu->cpu_aliases_added)
 		 nr += pmu->cpu_json_aliases;
-- 
2.20.1.7.g153144c

