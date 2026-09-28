Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E273DF019;
	Mon, 28 Sep 2026 05:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574669; cv=none; b=gM+w7qr6UG+RVj5+y4yVH3ikw6yYf/oLZoPbkMvBl/ayniYP6fPOju0BcTSvrogfVfF0bMy0zsmnHgKgquDOsWaqd2QFuoZdhx7nrf6Zuicwn97KxnHLUmK3MukIOU43HLG96eaGcsbSkc8UqASCd5B+2q7pw+vyXVf19mrJ9bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574669; c=relaxed/simple;
	bh=0CbIrOk5tG2HV7wNOj408xolUxn6Xp6AEFGQlVNercs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yc5EhP+rFPjmZr/WSnvECbxA9bM2dXS412noO0VZ9R8frM6p4AnZkfxCWnp25Rk7pFu588SUAQqpXdTn3rOOIr/cuAAVZVgAzum4E/MCcvtiwaMPT2bbkhMQxKh8NplQi70mGQYHoLDO4o2fKwTdcXKuTb2PmNQunWJfIo5AJY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHwhpDAw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHwhpDAw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114CF1F0089C;
	Mon, 28 Sep 2026 05:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790574666;
	bh=FEqEl+yu4WwM3ELYUBRZjZcprK9zGOmyVdAUyYA4X58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lHwhpDAw6e2h6Ti0BGODtDna5bYf/043p4oaKNaFfs0mAbSCnw6Har/rl+xnVFM/J
	 iRV+VsVQsE2ruwvGAx0y6Jh2YJ6sXaSqP9CnGr/aoP+G3UiLtRjZZRDq+NKrNKhErc
	 tHMzXf7D9VBniEbwz/GfsbZAPqfNDOWFEemM9HMZqCg6bb5dm4UGzxLGEOsizlF0bk
	 GIr3Pmwv+aIuC8fUTvmXiaawNT/t9FVYr2luQRZj/s1dPjlDiqcnXKS9YI4Gimy5Y8
	 +W91Lsmwgze9++SF84cHYJ3BkJ3NZXoim8Xq/FdUZL4DPnRMSzATiURIgmNARaNrD0
	 ZytlwhS1YHBdg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v1 6/8] perf tools: Avoid repeated failing search for debuginfo
Date: Sun, 27 Sep 2026 22:50:53 -0700
Message-ID: <20260928055055.95144-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928055055.95144-1-namhyung@kernel.org>
References: <20260928055055.95144-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If dso has no debuginfo, dso__find_dbginfo_type() may repeat the same
search for available types.  Let's add a new field (debuginfo_searched)
not to do it.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dso.c |  4 ++++
 tools/perf/util/dso.h | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 0c76441fba82c413..c36192e7ea557b47 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -2129,6 +2129,10 @@ void dso__find_dbginfo_type(struct dso *dso)
 	if (dso__dbginfo_type(dso) != DSO_BINARY_TYPE__NOT_FOUND)
 		return;
 
+	if (dso__debuginfo_searched(dso))
+		return;
+	dso__set_debuginfo_searched(dso);
+
 	for (type = dbginfo_types; *type != DSO_BINARY_TYPE__NOT_FOUND; type++) {
 		path = dso__get_filename(dso, "", &decomp, *type);
 		if (path == NULL)
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 45c4954d5eaf9ffa..3f08d45e7f53a508 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -349,6 +349,7 @@ DECLARE_RC_STRUCT(dso) {
 	u8		 short_name_allocated:1;
 	u8		 long_name_allocated:1;
 	u8		 is_64_bit:1;
+	u8		 debuginfo_searched:1;
 	bool		 sorted_by_name;
 	bool		 loaded;
 	u8		 rel;
@@ -1019,6 +1020,16 @@ static inline void dso__set_dbginfo_type(struct dso *dso, enum dso_binary_type b
 
 void dso__find_dbginfo_type(struct dso *dso);
 
+static inline bool dso__debuginfo_searched(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->debuginfo_searched;
+}
+
+static inline void dso__set_debuginfo_searched(struct dso *dso)
+{
+	RC_CHK_ACCESS(dso)->debuginfo_searched = 1;
+}
+
 bool dso__is_object_file(const struct dso *dso);
 
 void dso__free_a2l(struct dso *dso);
-- 
2.55.0

