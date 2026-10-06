Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8E74FB9C7;
	Tue,  6 Oct 2026 23:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791330199; cv=none; b=BQPlQEgDD1aKgHGWyMpCP7yRIrRoGGvYaN1tl7AjIALvH3clmQb0oDDmBzayizp85230P9kzE23dlxNtu6gX8jkzdW4L3xqvuYPNsfIdLwNDFjVe1pP7Aj96+HGvb4DoDCLNcYeOnJZkg/JbW62kchv8R505f0RRkoK9KCxsI1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791330199; c=relaxed/simple;
	bh=RXJpFUc2UhwcAJY7y07kzfOUFTY3tP9Gt+vyTuYoA8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PP+jXC0xTBvU+6X6grqmIBSMHXXfRFDZzLIzW/ALJ0gG4l3eqWM1FhAsGznX8IabzMiwpvO02c/1ImB0LWefG5vetdgduV9jDuSckh5X/YMbAyPm55Ti+ZdGOTmASvxLP1FPo3ZnNon94EGfEzMubIUI5KPtzf8QjLvA0/gQle4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNpTPfJt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNpTPfJt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6911F0089C;
	Tue,  6 Oct 2026 23:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791330198;
	bh=t4Snj5+W6FRi3h/D9Lyxz0KHt2RlyPyzaC7coS4O8vU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YNpTPfJt44vOO3d96K4YCLx8IvbPej+VF5uW0OIxgT9QsbUhUaGCDam8PNrLMDvPo
	 E+c5lBOygvVMRekN7KEFwQaTpQT+Gi6oeXw2BGWSRtVZxYQ1Oq+qA1CM4rBUsu+GWA
	 YXqt/oEp7MslUoO9ec+CYrJsU0c8crFOuGvxbesjr/bzYydGXaocyh9xc03xRGGnQI
	 +zAwgTRmIgk06bwlpeHvwh//73SuEGT+xM6Z1F0Ov7q3+HV9knkcOzyO3vAxCaFkN/
	 mmWP8HtlwXAFtPqq+X412ywMtZLAbxShkOOI+7s5EL01aGQpJDxZFDf20TVET0O4V9
	 nOTCWYMrpowuQ==
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
Subject: [PATCH v2 06/10] perf tools: Factor out dso__find_binary_type()
Date: Tue,  6 Oct 2026 16:43:10 -0700
Message-ID: <20261006234315.920817-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20261006234315.920817-1-namhyung@kernel.org>
References: <20261006234315.920817-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Separate out the logic to detect binary type of a DSO.  It checks if the
candidate file contains ".text" section.  It should be called under the
_dso__data_open_lock.

Introduce bintype_searched flag and it accessors to prevent repeated
(failed) search.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dso.c | 100 +++++++++++++++++++++++++++++++++++++-----
 tools/perf/util/dso.h |  13 ++++++
 2 files changed, 102 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 913877b84b2d437e..f5054c18a2e931e7 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -833,7 +833,7 @@ void dso__data_close(struct dso *dso)
 	mutex_unlock(dso__data_open_lock());
 }
 
-static void try_to_open_dso(struct dso *dso, struct machine *machine)
+static enum dso_binary_type __dso__find_binary_type(struct dso *dso)
 	EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
 {
 	enum dso_binary_type binary_type_data[] = {
@@ -842,25 +842,103 @@ static void try_to_open_dso(struct dso *dso, struct machine *machine)
 		DSO_BINARY_TYPE__NOT_FOUND,
 	};
 	int i = 0;
-	struct dso_data *dso_data = dso__data(dso);
+	char *path;
+	bool found = false;
+	bool decomp = false;
 
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
+		if (path == NULL)
+			continue;
+
+		found = filename__has_section(path, ".text");
+		dso__put_filename(dso, path, decomp);
+		if (found)
+			return dso__binary_type(dso);
 
 	} while (dso__binary_type(dso) != DSO_BINARY_TYPE__NOT_FOUND);
-out:
+
+	if (dso__symtab_type(dso) != DSO_BINARY_TYPE__BUILD_ID_CACHE &&
+	    dso__symtab_type(dso) != DSO_BINARY_TYPE__SYSTEM_PATH_DSO) {
+		path = dso__get_filename(dso, "", &decomp, dso__symtab_type(dso));
+		if (path == NULL)
+			return dso__binary_type(dso);
+
+		found = filename__has_section(path, ".text");
+		dso__put_filename(dso, path, decomp);
+		if (found)
+			dso__set_binary_type(dso, dso__symtab_type(dso));
+	}
+	return dso__binary_type(dso);
+}
+
+enum dso_binary_type dso__find_binary_type(struct dso *dso)
+{
+	enum dso_binary_type ret;
+
+	mutex_lock(dso__data_open_lock());
+	ret = __dso__find_binary_type(dso);
+	mutex_unlock(dso__data_open_lock());
+
+	return ret;
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
+	__dso__find_binary_type(dso);
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
2.56.0.rc1.315.gc6ed9934b7-goog

