Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8686C156960;
	Sun, 22 Dec 2024 21:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734904732; cv=none; b=n7HEWx2rxLOotA5pEQbCoLiMCTL2lyfGEjFKe41eIKhaGDbf0yHQTLyaFdTx7ldbZya1ZQKo6v0stCe9gERtizshrP7Slp9yYFvZHotyXU1Gp8pdaGJfb+VuvU6oPu93hYR/QpL/c8Srz0sXRCfsAM/0iUT8bV4AHda7duPLIHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734904732; c=relaxed/simple;
	bh=3oaUspyawN+MJCI+lJw7VBzvKzHFveDLpQzm3FOl/RE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G7wq9mZ4tLmtVxQlsa+pffvgmgxWzTpyVTiyH7O/EKGPYAh9LSLZpTBgLg5e7im1JJ3VG7vut8Ds3zcgrlVggWy0EsVaEvMXdc8tPnU1HT1V0oaBAYCpGFGPhPWUBWwBieFPt2Uzg9SIH5OmBxiPx6oo2P6oVVsL8mkF38GmbEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=OvMf8JXK; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="OvMf8JXK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=kR/rUxf6ip8ljCUjY54g8WqRUDw7MQ5ajjSnfvfK7j0=; b=OvMf8JXKcpdRuTiH
	8aImHRx8NDGp6h5XzFu8e4JolvaYuqLIL9BQyGPJZPTx+bi9pWKF9e91Ej1+gXhPDwq+ELReAlWIO
	sA973Bh50AVMpA/zjqRiUNuR/fdk+adkli2K07JFj1u9IsaU4Xu86wKop6ku/eOgPCFtZEDqalmwq
	+gUlvxRR8cj01lWvJv+dlaegZ/l/0wfO5tPJS/l6+dnOprGu+y4zlXG67U6ZyvquLGCpKdHe4WM3A
	8rSCzIqdttPmlIxx6nqrMzYbeIwkv+nDvMup9PCRXm1sGLpTeVgqxLm0dN9oiR9qtqsF3Kkn4fs4j
	c0JkpkUwLMudkJdZxw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tPTy4-006nQI-1P;
	Sun, 22 Dec 2024 21:58:32 +0000
From: linux@treblig.org
To: irogers@google.com,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] perf tools: Remove unused is_executable_file
Date: Sun, 22 Dec 2024 21:58:31 +0000
Message-ID: <20241222215831.283248-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

is_executable_file()  has been unused since 2022's
commit 7391db645938 ("perf test: Refactor shell tests allowing subdirs")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 tools/perf/util/path.c | 12 ------------
 tools/perf/util/path.h |  1 -
 2 files changed, 13 deletions(-)

diff --git a/tools/perf/util/path.c b/tools/perf/util/path.c
index 00adf872bf00..e923e2d9e8ad 100644
--- a/tools/perf/util/path.c
+++ b/tools/perf/util/path.c
@@ -67,15 +67,3 @@ bool is_directory(const char *base_path, const struct dirent *dent)
 
 	return S_ISDIR(st.st_mode);
 }
-
-bool is_executable_file(const char *base_path, const struct dirent *dent)
-{
-	char path[PATH_MAX];
-	struct stat st;
-
-	snprintf(path, sizeof(path), "%s/%s", base_path, dent->d_name);
-	if (stat(path, &st))
-		return false;
-
-	return !S_ISDIR(st.st_mode) && (st.st_mode & S_IXUSR);
-}
diff --git a/tools/perf/util/path.h b/tools/perf/util/path.h
index d94902c22222..083429b7efa3 100644
--- a/tools/perf/util/path.h
+++ b/tools/perf/util/path.h
@@ -12,6 +12,5 @@ int path__join3(char *bf, size_t size, const char *path1, const char *path2, con
 
 bool is_regular_file(const char *file);
 bool is_directory(const char *base_path, const struct dirent *dent);
-bool is_executable_file(const char *base_path, const struct dirent *dent);
 
 #endif /* _PERF_PATH_H */
-- 
2.47.1

