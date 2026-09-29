Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753493CF1F0;
	Tue, 29 Sep 2026 01:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790644315; cv=none; b=FsxAjixNVihoY+SaR5HJFeWhJzC4EI9lMgNgwEir0qVNOEfWK71IQQZBqvqL46owAyN6CxcbanCJ3WlLeTJRFFuCgrWwCYr+ABWAFGnnDTHhFvdpbvX+W99kCAUDP0wrQolu+7MHyNQE80OkGC9wBhvq0kjKY0ylOnL/Ad6TbUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790644315; c=relaxed/simple;
	bh=+iPcQDBbXbrl+rkVsX0zYfz1NGvp79cNVmOM842KQTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hlJoyQWaqY9TqJxrsr3NUgynmf191s9CJwC9iXS5lvMOW8SZ1VO1gGkx/8ey0ZsaMAs0ibyA/lHffnogXf3Noj6d78iN/03zthiGyAQa8gwg7xvkvZD9IHpiINXKEvIxP5jyxip0IxIbzPdu9JREpEWU6C+bNd5HNxe+Dukfexk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clzq1+NP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clzq1+NP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEB91F000FF;
	Tue, 29 Sep 2026 01:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790644313;
	bh=HzHLfbUqdYzgaxswrohYK/ARmSS/TfBno4oMHbudt98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=clzq1+NPSAs21yVXs/r1yYdbmYJgfWBH7LpSmgvaSM5MOFiH7QzLalMCpgM/1rDkU
	 +NyznCI1axz+sLZN2cgG7JpMVF7CTAd/w/ts5EgmGmOoYynxIODWS9paT0EJaY6lPo
	 89dqdgzWyhfIfVWg+4AkEWY63dsRuU+EVdH8gv8XnbxzBbfyrQICGA/cGgCjrAkvip
	 +cB9CHSdiYZa7XtJ1zVVFg6prTqvGUo3k8vNjyYpe0cZdCYNNq/WS3OR3EKkIXpIqF
	 C86YJwPQgV5fR/ydsp6N9zP0SHyU1m+DiCQfhk5WBfcfkNnu6AR7zX8eZCQMR5ohIB
	 EJC9HRty8RnVA==
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
Subject: [PATCH v2 8/8] perf tools: Update debuginfo__new() to take DSO
Date: Mon, 28 Sep 2026 18:11:39 -0700
Message-ID: <20260929011139.53242-9-namhyung@kernel.org>
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

It should be the common case to get debuginfo from existing DSOs.
Now dso__debuginfo() calls it with its debuginfo type to avoid the
unnecessary loop to find the location of debug file.

Update existing function to debuginfo__from_path() for clarity.

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/debuginfo.c   | 28 ++++++++++++++++++----------
 tools/perf/util/debuginfo.h   | 13 +++++++++++--
 tools/perf/util/dso.c         | 11 ++---------
 tools/perf/util/probe-event.c |  4 ++--
 4 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
index fc2640dcd29d3aaa..db188c397d63880c 100644
--- a/tools/perf/util/debuginfo.c
+++ b/tools/perf/util/debuginfo.c
@@ -91,13 +91,27 @@ static struct debuginfo *__debuginfo__new(const char *path)
 	return dbg;
 }
 
-struct debuginfo *debuginfo__new(const char *path)
+struct debuginfo *debuginfo__new(struct dso *dso)
+{
+	struct debuginfo *dinfo;
+	char *path;
+	bool decomp = false;
+
+	dso__find_dbginfo_type(dso);
+	path = dso__get_filename(dso, "", &decomp, dso__dbginfo_type(dso));
+	if (path == NULL)
+		return NULL;
+
+	dinfo = __debuginfo__new(path);
+	dso__put_filename(dso, path, decomp);
+	return dinfo;
+}
+
+struct debuginfo *debuginfo__from_path(const char *path)
 {
 	struct dso *dso;
 	struct debuginfo *dinfo;
 	struct build_id bid = { .size = 0 };
-	char *filename;
-	bool decomp = false;
 
 	/* Try to open distro debuginfo files */
 	dso = dso__new(path);
@@ -112,13 +126,7 @@ struct debuginfo *debuginfo__new(const char *path)
 	if (filename__read_build_id(path, &bid) > 0)
 		dso__set_build_id(dso, &bid);
 
-	dso__find_dbginfo_type(dso);
-	filename = dso__get_filename(dso, "", &decomp, dso__dbginfo_type(dso));
-	if (filename == NULL)
-		return NULL;
-
-	dinfo = __debuginfo__new(filename);
-	dso__put_filename(dso, filename, decomp);
+	dinfo = debuginfo__new(dso);
 	dso__put(dso);
 
 	return dinfo;
diff --git a/tools/perf/util/debuginfo.h b/tools/perf/util/debuginfo.h
index a52d69932815cd72..ade40d54ea125988 100644
--- a/tools/perf/util/debuginfo.h
+++ b/tools/perf/util/debuginfo.h
@@ -18,8 +18,12 @@ struct debuginfo {
 	const unsigned char	*build_id;
 };
 
+struct dso;
+
 /* This also tries to open distro debuginfo */
-struct debuginfo *debuginfo__new(const char *path);
+struct debuginfo *debuginfo__from_path(const char *path);
+/* Create a debuginfo using information in DSO */
+struct debuginfo *debuginfo__new(struct dso *dso);
 void debuginfo__delete(struct debuginfo *dbg);
 
 int debuginfo__get_text_offset(struct debuginfo *dbg, Dwarf_Addr *offs,
@@ -31,7 +35,12 @@ int debuginfo__get_text_offset(struct debuginfo *dbg, Dwarf_Addr *offs,
 struct debuginfo {
 };
 
-static inline struct debuginfo *debuginfo__new(const char *path __maybe_unused)
+static inline struct debuginfo *debuginfo__from_path(const char *path __maybe_unused)
+{
+	return NULL;
+}
+
+static inline struct debuginfo *debuginfo__new(struct dso *dso __maybe_unused)
 {
 	return NULL;
 }
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index e4a2a0ea38823b5f..d3017c82ffb5f4b1 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -2086,17 +2086,10 @@ const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
 
 struct debuginfo *dso__debuginfo(struct dso *dso)
 {
-	char *name;
-	bool decomp = false;
-	struct debuginfo *dinfo = NULL;
+	struct debuginfo *dinfo;
 
 	mutex_lock(dso__lock(dso));
-
-	name = dso__get_filename(dso, "", &decomp, dso__dbginfo_type(dso));
-	if (name) {
-		dinfo = debuginfo__new(name);
-		dso__put_filename(dso, name, decomp);
-	}
+	dinfo = debuginfo__new(dso);
 	mutex_unlock(dso__lock(dso));
 	return dinfo;
 }
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 11ae4a09412c9bd9..1534280c0c1d59cb 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -519,7 +519,7 @@ static struct debuginfo *open_from_debuginfod(struct dso *dso, struct nsinfo *ns
 		pr_debug("Load debuginfo from debuginfod (%s)\n", path);
 
 	nsinfo__mountns_enter(nsi, &nsc);
-	ret = debuginfo__new((const char *)path);
+	ret = debuginfo__from_path((const char *)path);
 	nsinfo__mountns_exit(&nsc);
 	return ret;
 }
@@ -567,7 +567,7 @@ static struct debuginfo *open_debuginfo(const char *module, struct nsinfo *nsi,
 		path = dso__long_name(dso);
 	}
 	nsinfo__mountns_enter(nsi, &nsc);
-	ret = debuginfo__new(path);
+	ret = debuginfo__from_path(path);
 	if (!ret && !silent) {
 		pr_warning("The %s file has no debug information.\n", path);
 		if (!module || !strtailcmp(path, ".ko"))
-- 
2.55.0

