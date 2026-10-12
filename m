Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8713B19B2;
	Mon, 12 Oct 2026 05:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791782772; cv=none; b=rcaE5snM0KreVl2N38Ck7ra6lzf9OrMAwNIH8y8jYKPd/3XHLbQGNUXqEliwnmltWGrbH42lbZTEi7gPxFhY3pbtM62JTjKZJifNAShNFbeVL0lxLN+q19IB6ZTgSidPDQPbe7da54MALZW5SyA25OPQKPCKu0vHS+CmLeGW5mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791782772; c=relaxed/simple;
	bh=/5vO63YXqZ6K7yF5FKfkwHRb7iGk+KKGzMJTU26s/24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDROOOypm/ZehU9t5n+aWrGCuEXYQ6i9ioIPywiQAbyfpPrFyBP9DALRKGP+9Q7ubu+BLy5hpQiO5XyG84k17hO16YfkrUv6rsGZKimKaGiS+8Q8FFY6mTfokQhd68Ynm3dzPgNc4bQcyP3bCcZErzLLiRxntSTOVwzqtHZLPF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXY5Zo1L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXY5Zo1L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5272F1F0089C;
	Mon, 12 Oct 2026 05:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791782770;
	bh=l1WQyDiTrbD7vHAGjEHtD/u0S//ZH29SpFJtRCnYmWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VXY5Zo1LV9j7ipKW9QOyUkYc3W7UsNUu75Pp5wX9RgFeL+p/RoCOQg69zvE+OwV8o
	 FYOPcO2oZgmkyRzIIFyiQ/yPpMl1YQuVEmL+JQEnWhz640IM3s6nETTV96Rg6F7SwP
	 fmbUminkgnM7SgWIx8I8XnCEnupXq4GvmMNfidk5UQ5mPkwvOMUsyBaUnoVWxXAaTq
	 JlY/1r/XwNgiEfj+Ev8DPYISV+fToLVX+io14aPyO7Z0SzXQdYmiOgPQhvnIO5QPSw
	 dzbCtO52p+XmGVYd/aKrZMtE5sWWgQCgKOXz83Krz3eo0SUHxV/GZZmmphdz4IkSdt
	 FgELRwlXUg8JQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v3 06/10] perf tools: Factor out dso__find_binary_type()
Date: Sun, 11 Oct 2026 22:25:57 -0700
Message-ID: <20261012052601.13920-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012052601.13920-1-namhyung@kernel.org>
References: <20261012052601.13920-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Separate out the logic to detect binary type of a DSO.  It checks if the
candidate file contains ".text" section.  It should be called under the
dso lock.

But it also can fail due to open file limit.  Handle the case by
returning -1 and retry with _dso__data_open_lock.

Introduce bintype_searched flag and it accessors to prevent repeated
(failed) search.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dso.c | 132 ++++++++++++++++++++++++++++++++++++++----
 tools/perf/util/dso.h |  13 +++++
 2 files changed, 133 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 913877b84b2d437e..851b39c63ec861e7 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -833,34 +833,142 @@ void dso__data_close(struct dso *dso)
 	mutex_unlock(dso__data_open_lock());
 }
 
-static void try_to_open_dso(struct dso *dso, struct machine *machine)
-	EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
+static int dso__find_binary_type_locked(struct dso *dso)
 {
 	enum dso_binary_type binary_type_data[] = {
 		DSO_BINARY_TYPE__BUILD_ID_CACHE,
 		DSO_BINARY_TYPE__SYSTEM_PATH_DSO,
+		dso__symtab_type(dso),
 		DSO_BINARY_TYPE__NOT_FOUND,
 	};
 	int i = 0;
-	struct dso_data *dso_data = dso__data(dso);
+	char *path;
+	bool found = false;
+	bool decomp = false;
+	int saved_errno;
 
-	if (dso_data->fd >= 0)
-		return;
+	if (dso__bintype_searched(dso))
+		return dso__binary_type(dso);
+	dso__set_bintype_searched(dso);
 
-	if (dso__binary_type(dso) != DSO_BINARY_TYPE__NOT_FOUND) {
-		dso_data->fd = open_dso(dso, machine);
-		goto out;
+	switch (dso__binary_type(dso)) {
+	case DSO_BINARY_TYPE__KALLSYMS:
+	case DSO_BINARY_TYPE__GUEST_KALLSYMS:
+	case DSO_BINARY_TYPE__VMLINUX:
+	case DSO_BINARY_TYPE__GUEST_VMLINUX:
+	case DSO_BINARY_TYPE__KCORE:
+	case DSO_BINARY_TYPE__GUEST_KCORE:
+		/* Nothing to do with kernel images */
+		WARN_ON(!dso__kernel(dso));
+		return dso__binary_type(dso);
+	case DSO_BINARY_TYPE__BPF_PROG_INFO:
+	case DSO_BINARY_TYPE__BPF_IMAGE:
+	case DSO_BINARY_TYPE__OOL:
+	case DSO_BINARY_TYPE__JAVA_JIT:
+		/* Same for the special DSOs */
+		return dso__binary_type(dso);
+	case DSO_BINARY_TYPE__GUEST_KMODULE:
+	case DSO_BINARY_TYPE__GUEST_KMODULE_COMP:
+	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE:
+	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP:
+	case DSO_BINARY_TYPE__SYSTEM_PATH_DSO:
+	case DSO_BINARY_TYPE__BUILD_ID_CACHE:
+		/* We don't expect these are set; fall through */
+	case DSO_BINARY_TYPE__NOT_FOUND:
+		/* Let's find it out (for user DSOs or kernel modules) */
+		break;
+	case DSO_BINARY_TYPE__FEDORA_DEBUGINFO:
+	case DSO_BINARY_TYPE__UBUNTU_DEBUGINFO:
+	case DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO:
+	case DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO:
+	case DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO:
+	case DSO_BINARY_TYPE__BUILDID_DEBUGINFO:
+	case DSO_BINARY_TYPE__GNU_DEBUGDATA:
+	case DSO_BINARY_TYPE__DEBUGLINK:
+	default:
+		/* Unexpected binary types (usually debug only) */
+		break;
 	}
 
 	do {
 		dso__set_binary_type(dso, binary_type_data[i++]);
 
-		dso_data->fd = open_dso(dso, machine);
-		if (dso_data->fd >= 0)
-			goto out;
+		path = dso__get_filename(dso, "", &decomp, dso__binary_type(dso));
+		if (path == NULL) {
+			if (errno == EMFILE)
+				goto open_err;
+			continue;
+		}
+
+		found = filename__has_section(path, ".text");
+		if (!found)
+			saved_errno = errno;
+		dso__put_filename(dso, path, decomp);
+
+		if (found)
+			return dso__binary_type(dso);
+		else if (saved_errno == EMFILE)
+			goto open_err;
 
 	} while (dso__binary_type(dso) != DSO_BINARY_TYPE__NOT_FOUND);
-out:
+
+	return dso__binary_type(dso);
+
+open_err:
+	/* Too many open files.  Allow retry after closing one. */
+	RC_CHK_ACCESS(dso)->bintype_searched = 0;
+	dso__set_binary_type(dso, DSO_BINARY_TYPE__NOT_FOUND);
+	return -1;
+}
+
+#define FIND_MAX_RETRY  3
+static int __dso__find_binary_type(struct dso *dso, bool needs_open_lock)
+{
+	int ret;
+	int retry = 0;
+
+again:
+	mutex_lock(dso__lock(dso));
+	ret = dso__find_binary_type_locked(dso);
+	mutex_unlock(dso__lock(dso));
+
+	if (ret == -1 && retry++ < FIND_MAX_RETRY) {
+		if (needs_open_lock)
+			mutex_lock(dso__data_open_lock());
+		close_first_dso();
+		goto again;
+	}
+
+	if (retry > 0 && needs_open_lock)
+		mutex_unlock(dso__data_open_lock());
+
+	if (ret == -1) {
+		mutex_lock(dso__lock(dso));
+		ret = dso__binary_type(dso);
+		dso__set_bintype_searched(dso);
+		mutex_unlock(dso__lock(dso));
+	}
+
+	return ret;
+}
+#undef FIND_MAX_RETRY
+
+enum dso_binary_type dso__find_binary_type(struct dso *dso)
+{
+	return __dso__find_binary_type(dso, /*needs_open_lock=*/true);
+}
+
+static void try_to_open_dso(struct dso *dso, struct machine *machine)
+	EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
+{
+	struct dso_data *dso_data = dso__data(dso);
+
+	if (dso_data->fd >= 0)
+		return;
+
+	__dso__find_binary_type(dso, /*needs_open_lock=*/false);
+	dso_data->fd = open_dso(dso, machine);
+
 	if (dso_data->fd >= 0)
 		dso_data->status = DSO_DATA_STATUS_OK;
 	else
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 3f08d45e7f53a508..3329f417810c25a4 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -349,6 +349,7 @@ DECLARE_RC_STRUCT(dso) {
 	u8		 short_name_allocated:1;
 	u8		 long_name_allocated:1;
 	u8		 is_64_bit:1;
+	u8		 bintype_searched:1;
 	u8		 debuginfo_searched:1;
 	bool		 sorted_by_name;
 	bool		 loaded;
@@ -957,6 +958,8 @@ void dso__reset_find_symbol_cache(struct dso *dso);
 size_t dso__fprintf_symbols_by_name(struct dso *dso, FILE *fp);
 size_t dso__fprintf(struct dso *dso, FILE *fp);
 
+enum dso_binary_type dso__find_binary_type(struct dso *dso);
+
 static inline enum dso_binary_type dso__binary_type(const struct dso *dso)
 {
 	return RC_CHK_ACCESS(dso)->binary_type;
@@ -967,6 +970,16 @@ static inline void dso__set_binary_type(struct dso *dso, enum dso_binary_type bt
 	RC_CHK_ACCESS(dso)->binary_type = bt;
 }
 
+static inline bool dso__bintype_searched(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->bintype_searched;
+}
+
+static inline void dso__set_bintype_searched(struct dso *dso)
+{
+	RC_CHK_ACCESS(dso)->bintype_searched = 1;
+}
+
 static inline bool dso__is_vmlinux(const struct dso *dso)
 {
 	enum dso_binary_type bt = dso__binary_type(dso);
-- 
2.55.0

