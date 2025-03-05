Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78D71459F6;
	Wed,  5 Mar 2025 02:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741141920; cv=none; b=QWv3FJPzR1SNs36QjNmP1GgY/Thamurr/8o6XrBP+k6cEktYhEyD3vhT9s2P8ckTDz2CipJ6om84mQwvGFV1OtV05T25q33yZHgNyPhWaUkQM9dyOhKsywcCs0mbYquvltdDlKTJsMEtLFujwqPwHh9J4R65a9WyyZnbPj0sECE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741141920; c=relaxed/simple;
	bh=rLOczdifouOnE21lGnWehKPUyymxn3peQNqZvHdvK1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rZZiLjyhW2534LrjvP3plDINlby6kAaeOPlrqJ3oamMjyCFsDxERR14FqJ8ubAjcugXOeKeFNbtx3fGW+cJhVNN7w30J7qrvL3Tml2jf5UCKXdx3zndc2AF9i/q6gsC1WbJdI+iPxFzSOJwjTA6MT2zszG5/pITv+XNfrhtzTSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=AIj//zYg; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="AIj//zYg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=1ZNzGNcG5qMwlIr3Iama8mJIXqtu/L/N8tr6WxHkcsk=; b=AIj//zYgpbZUA0/c
	XcmAH6ecGzUCZekF47D/XE9OV1hvC/K+UfSSNLW5yuthfhrC9Zvgtytcmtx48bx/Yeqz0bH5QL3Z5
	bcJJRUZjzESWK7TbMgydTvUB+RLa/W7PcTKnOY+lilJ0G0vNgQCPreMPXAHJEy0998R2Aq774fgWG
	D86tgNp0wvf5pk3sHNKdWY5hX0DNOVpA9Mnt/RDRipzGLUos1vqCa4xojqZpveoPRFvvfbeWwtyfk
	X/rrKU35iNdFN52dtnM+8jLca4mL56bm1MBuMxl7wsNXJLdvIN8HuCf9yoZuIPxiRQKiHLry3cnU7
	qr3BN2pP2iYWhvxstw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tpeXk-002ic7-2Z;
	Wed, 05 Mar 2025 02:31:32 +0000
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
Subject: [PATCH 4/6] perf util: Remove unused perf_data__update_dir
Date: Wed,  5 Mar 2025 02:31:18 +0000
Message-ID: <20250305023120.155420-5-linux@treblig.org>
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

perf_data__update_dir() was added in 2019's
commit e8be135751f2 ("perf data: Add perf_data__update_dir() function")
but has never been used.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 tools/perf/util/data.c | 20 --------------------
 tools/perf/util/data.h |  1 -
 2 files changed, 21 deletions(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 98661ede2a73..164eb45a0b36 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -158,26 +158,6 @@ int perf_data__open_dir(struct perf_data *data)
 	return ret;
 }
 
-int perf_data__update_dir(struct perf_data *data)
-{
-	int i;
-
-	if (WARN_ON(!data->is_dir))
-		return -EINVAL;
-
-	for (i = 0; i < data->dir.nr; i++) {
-		struct perf_data_file *file = &data->dir.files[i];
-		struct stat st;
-
-		if (fstat(file->fd, &st))
-			return -1;
-
-		file->size = st.st_size;
-	}
-
-	return 0;
-}
-
 static bool check_pipe(struct perf_data *data)
 {
 	struct stat st;
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 110f3ebde30f..1438e32e0451 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -97,7 +97,6 @@ int perf_data__switch(struct perf_data *data,
 int perf_data__create_dir(struct perf_data *data, int nr);
 int perf_data__open_dir(struct perf_data *data);
 void perf_data__close_dir(struct perf_data *data);
-int perf_data__update_dir(struct perf_data *data);
 unsigned long perf_data__size(struct perf_data *data);
 int perf_data__make_kcore_dir(struct perf_data *data, char *buf, size_t buf_sz);
 bool has_kcore_dir(const char *path);
-- 
2.48.1

