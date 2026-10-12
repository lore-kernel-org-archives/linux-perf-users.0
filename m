Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1F63EFFC2;
	Mon, 12 Oct 2026 23:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791848822; cv=none; b=uItb0OEbw64X/kr6nCumIYTOdGzF7UGWphhDp17J8VIXZh3LO9uCvnKzqvh3S9U5UnN/I/MGkgFh4YigN9hhnpzq2qnOCFMorcZH6fKi7oASJnp6mV7cReSclS3Xo/FGOvQEZISWhwLcvzf6Fwu+w19zZZSk4gov3PHV+iZguZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791848822; c=relaxed/simple;
	bh=jlPUFk+4lw9uWBh16S3pVnb6N4xztEw9l+vMLL6lfEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANiOYTCzDEFtNj9ClzFXUtNSRT3/+umj5r9iglk5oQyrmw3FgS7rdvi7trKkbE1KzWel1HCpRI2Ds1yKk28NMCOTPQvG4u/CFjGuJrP+laWzcayNBHgKUliEMaD+CgdBvbCDD0KLifGeFlcfL/SQkzSa0gEvPuR2mkDvEXspNRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWin7mS4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWin7mS4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D327E1F0089B;
	Mon, 12 Oct 2026 23:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791848820;
	bh=1r/LAHWEVyXS+OLSebheN7nMmudgDo8wm5aFeiG3QBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TWin7mS4dgjUeJFiQvoep1jiddz98/CkKkbBGX26zzGSaob1hG7YpgtUzHPbUygZ1
	 hPG3SDJYQmgAuzbj1tPfBHddmlPx1QmQcWODhBfN7nmHerm8PGaqxIG/U0brOiahgr
	 oMF713A/5CNErwa/AU7pwAYDuW95nKGSIyItdgFpGrNMW8Rr2JOGUYVMDm/boaqD7D
	 8TnZlaJOiHEF+oR1Usx332CKzVNWzDTODIMB/3XjuGchrlfwi+1uDYbU+v+3UARFEf
	 9AGYy0D5aNaiGthMQPZRNTensYgGZQaOrnBUheG6SM0p2/MTsWTjPImO1cQMo5aL+l
	 hpwzXQmk2s0nA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v4 06/10] perf tools: Factor out dso__find_binary_type()
Date: Mon, 12 Oct 2026 16:46:50 -0700
Message-ID: <20261012234654.60666-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261012234654.60666-1-namhyung@kernel.org>
References: <20261012234654.60666-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Separate out the logic to detect binary type of a DSO.  It checks if
the candidate file contains ".text" section.  There could be data-only
DSOs but as our use cases focus on the code (perf annotate or intel
PT), we can ignore them for now.

But it also can fail due to open file limit.  Handle the case by
retrying with _dso__data_open_lock.

Introduce bintype_searched flag and it accessors to prevent repeated
(failed) search.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dso.c | 137 ++++++++++++++++++++++++++++++++++++++----
 tools/perf/util/dso.h |  13 ++++
 2 files changed, 138 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 913877b84b2d437e..c42ad0c5c66a7bcd 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -833,34 +833,147 @@ void dso__data_close(struct dso *dso)
 	mutex_unlock(dso__data_open_lock());
 }
 
-static void try_to_open_dso(struct dso *dso, struct machine *machine)
-	EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
+static int dso__find_binary_type_locked(struct dso *dso)
+	EXCLUSIVE_LOCKS_REQUIRED(dso__lock(dso))
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
+		errno = 0;
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
+		if (needs_open_lock && retry == 1)
+			mutex_lock(dso__data_open_lock());
+
+		if (dso__data_open_cnt) {
+			close_first_dso();
+			goto again;
+		}
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
2.56.0.385.gd3acb90ef8-goog

