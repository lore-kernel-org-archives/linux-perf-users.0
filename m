Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777C835893;
	Wed,  5 Mar 2025 02:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741141951; cv=none; b=Syq2QHeBIbdLNIQ9wBA3nT8ABkxU3OOGRNhMAM8iq/qNw2VTUfyXnpIuRIQVBCKcU04GJpYgKOBRInnmfsVamzBGB5UYddk758rOK19pt81sP1zU07i+Sewq/Uu4vYpAVqm4Tp5556M+Ui4dT2RV2dlNKABaBxnkYK4JPvc6uqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741141951; c=relaxed/simple;
	bh=pm9Hd8/8WvBThhO6P9C3fMd6GbaDgDRpAYLM1zSCS+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q+W8ZAWPFuDi8QtVn42Ks4G5YQ5JB6yW48vFVBMClqXGZ3FFlTnlwIkv9V8E+k4PFwWed638/jGS5Yl0nhuSuLWaWtk0XknPUBuA4AT7ySa4oQNzHuELOdFhjm2GYaH9xkVvzWDERYoUJ/wOsQY1PRUIt0BPgL8Mfwwt1YTQ/EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=naXFAD64; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="naXFAD64"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=6JUxpMTZb+VPOA3fx/psHXWyFCWtLj0EBW/8vAJ1oRE=; b=naXFAD64uWqbNum3
	nHJUuPWJzKxtYzt5FQF6+2ekCyslbQVDOAfW4Dj+if2XooHUNec4BM+FpS1Fo8GlBr2Z7j2d84Oga
	61L9TagYy9p+hmVDeuAV8aGSUwM9gKhHZxoYkAHUhXi9Z1Cn8GO/Xy4dGZGb6aHoSbSIB7++gfB0i
	+armomG729M7y/OwxFOSVmG2h86k9TdAOp/I6b+d4rR3u8k+s5YZUiHadpvG+JFoHcDIR1msZ2LaQ
	sj5Q8Uf/GqFFExHdNiXCw8awP5Nnjs2LHGQPPxINvg5nf2QkJhSmgQK7LnfVgD+813N+dwQIdvAMw
	NXCuguqLZkpbWiJyuA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tpeXl-002ic7-2O;
	Wed, 05 Mar 2025 02:31:33 +0000
From: linux@treblig.org
To: irogers@google.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	namhyung@kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 6/6] perf util: Remove unused perf_config__refresh
Date: Wed,  5 Mar 2025 02:31:20 +0000
Message-ID: <20250305023120.155420-7-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305023120.155420-1-linux@treblig.org>
References: <20250305023120.155420-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

perf_config__refresh() was added in 2016 by
commit 8a0a9c7e9146 ("perf config: Introduce new init() and exit()")
but has remained unused.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 tools/perf/util/config.c | 6 ------
 tools/perf/util/config.h | 1 -
 2 files changed, 7 deletions(-)

diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 2d07c9257a1a..ae72b66b6ded 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -856,12 +856,6 @@ void perf_config__exit(void)
 	config_set = NULL;
 }
 
-void perf_config__refresh(void)
-{
-	perf_config__exit();
-	perf_config__init();
-}
-
 static void perf_config_item__delete(struct perf_config_item *item)
 {
 	zfree(&item->name);
diff --git a/tools/perf/util/config.h b/tools/perf/util/config.h
index a727c95cb119..987b47cf54c3 100644
--- a/tools/perf/util/config.h
+++ b/tools/perf/util/config.h
@@ -49,7 +49,6 @@ void perf_config_set__delete(struct perf_config_set *set);
 int perf_config_set__collect(struct perf_config_set *set, const char *file_name,
 			     const char *var, const char *value);
 void perf_config__exit(void);
-void perf_config__refresh(void);
 int perf_config__set_variable(const char *var, const char *value);
 
 /**
-- 
2.48.1

