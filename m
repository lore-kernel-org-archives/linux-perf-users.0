Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7A113D891
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Jul 2025 11:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753528568; cv=none; b=AA6mSHmBTMVnHH8gBvk2zpVbaxb4Zt6ExbFQimgPL5d+lVGH3b1u+5EyGoVsvwmnsE62r0AC+qyX5t8PEtEXc9apJ2GVE8AmpVLu0PiCNorypdJKOdrb8EyIQDdQ0lcCi5FAtBGPtMsP2J7/CE63sahhyDE15amSEmNLJGtfcEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753528568; c=relaxed/simple;
	bh=s6qT2ROFuTXsdQ0OYlyenHgZ2qVECsI/Sw1hTJ72AGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kmpSK9HfysWrTy5n/6zv7JU5Of5NdPZ6fbDDSjzG0y/FKuqzv7u0gj0+bY2aeqecnTTOXtJgU9ectwGkvHobI8oIqftGtJz0Ki2tmFwgTDn7JjOVh9eGPfGH++wnk19iA4GbbhTB8MzkmdNWjdWlHrFRtHOxUqXP+m9lr4iit14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=N3IVK36e; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="N3IVK36e"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753528553; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ghpcVc26griiFXJHdSI8HyaqdFSf5XTNmNko2C5ONrg=;
	b=N3IVK36elaHKBhXVDUxpnMHB0dG0+QX6LZrJH5gk+ExqTJzaY9MI9f29S+kVYrsm+0cLan+IyMFq+YKgiMc7EpOqqI6s220enY+MFhCgI3744OVi9NO2zzb6uRLaM+4BIfWwMpVVuuXojLT9IXzsTwJuq/1TGVZb78UMf+5NUsk=
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0Wk2UOoG_1753528537 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 26 Jul 2025 19:15:52 +0800
From: cp0613@linux.alibaba.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	Chen Pei <cp0613@linux.alibaba.com>
Subject: [PATCH] perf tools: Remove libtraceevent in .gitignore
Date: Sat, 26 Jul 2025 19:15:32 +0800
Message-ID: <20250726111532.8031-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Pei <cp0613@linux.alibaba.com>

The libtraceevent has been removed from the source tree, and .gitignore
needs to be updated as well.

Fixes: 4171925aa9f3f7bf ("tools lib traceevent: Remove libtraceevent")

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 tools/perf/.gitignore | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index 5aaf73df6700..b64302a76144 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -48,8 +48,6 @@ libbpf/
 libperf/
 libsubcmd/
 libsymbol/
-libtraceevent/
-libtraceevent_plugins/
 fixdep
 Documentation/doc.dep
 python_ext_build/
-- 
2.49.0

