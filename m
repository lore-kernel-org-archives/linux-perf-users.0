Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DE63CCA13;
	Tue, 29 Sep 2026 01:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790644313; cv=none; b=on+VSZkpX0RmLirv7FEGod2pqPaUy3z1VGek0KgluNi9nR0M6n6j+5PTKwRSfOm7kqlib+DoWzKaKMJKhmTD9wTzPpJgv/SZh4H9sH77Uc9I+DtxTDsWsQPbijqwXSsG+wlUGWNrPpJCHSnUZUNCt2g7Q+Nmke9Pm/wzVOOGw+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790644313; c=relaxed/simple;
	bh=SZsJBOQGGi+xPoHok+6aQWU+9BIq7J7bXzrrjAqrOsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CatKqIjPMpYMDQavrp74KdWMQTD7jq5kV4n5W/zw+LCD4ZBWLDqm17WppDHp0kCNcv96HPBkEMSGKFlBuzdT7F1QiRf96HpsBuSzb/3pkG+7DDgzsa39NjEUwOLfmQBQ3wyuwa/ZSTRP8vZP/Y66p9COaG9pmTOH+3PX1e1gjJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIQ9gJBx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIQ9gJBx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3F71F00899;
	Tue, 29 Sep 2026 01:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790644312;
	bh=yL0J4w1nDHoGp8zjddSGrUuCV2rCq4GELY9Y9wEsQ3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IIQ9gJBxafXVAzaYzUB7bQ8vBq1kAZ+6eq5qJqr2t1KNGi3bBbzqpVtj25a7pmLsz
	 oulxIOBfV3BVWEvVaM+2dTRoC2HsDgEiR1NHhggk+irJbqcgsN6y1JzRoIAw0RycCh
	 0Uom8UFuOnTi9xwdo+9tz6p804722pEtnpqT7/YQ0yRhiauqFm/fS0tbbXh/2xafGG
	 XyauBZi31ugV3nyWLdDLVTtwGIz1JELvN4wZAGh6TPpRR1TuFDqanWEjnUOFMz10n2
	 jVHshpjEhM2xUvBaUds/ed1zAmg53+NJlnywmYp8RRXX5XcXbNzFbHm0isWdU8FMEo
	 ZrnhHlK76H4ng==
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
	Masami Hiramatsu <mhiramat@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v2 6/8] perf tools: Avoid repeated failing search for debuginfo
Date: Mon, 28 Sep 2026 18:11:37 -0700
Message-ID: <20260929011139.53242-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929011139.53242-1-namhyung@kernel.org>
References: <20260929011139.53242-1-namhyung@kernel.org>
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

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dso.c |  4 ++++
 tools/perf/util/dso.h | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index c765c9b80e957871..f7a786e0c3cf6a29 100644
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

