Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0E5946C;
	Tue,  2 Jul 2024 04:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719893942; cv=none; b=rHLa/Z+3dQhPxY1E8OjvdQoINGX/fPOf/hzJbPL1T4J3qo7QTN8vQnvOYADn1W7MpxKSBT8VoBN0NLNdViMhRVIaa/Fo8N7JX6z+NB+BQfzsLOIEELZdiVsw5TslOdqZrRZ29AhQGQuNGcqhJQLbrz5KzThZnINei4333wMZdbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719893942; c=relaxed/simple;
	bh=aKhd4Q5pWziEBW3RHwgPV+LKXm5ZjHKMtk9LTLuQXEI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LOadtP7jfZlh/EB17Y8rC+VrbQXLGMLTHYgWxNV0+dLidrWtvE46ZTfY6i93yo9vhSvYzfR5Lj/ScI61ANYpQ2q38L74o0sgVGBWJbL/WJ2oX5aaRWPxda3j4dqzFC8PPNNUHqX2C/cONMPN1SEgln4vwFapM303TCqKnqFgb6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WCqL96T0Yz1T4Yk;
	Tue,  2 Jul 2024 12:14:25 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id 87B0B14022D;
	Tue,  2 Jul 2024 12:18:57 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 2 Jul 2024 12:18:55 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Nathan Chancellor <nathan@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Liang,
 Kan" <kan.liang@linux.intel.com>, Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>, Hui Wang <hw.huiwang@huawei.com>, Changbin Du
	<changbin.du@huawei.com>
Subject: [PATCH v5 2/8] perf: disasm: refactor function dso__disassemble_filename
Date: Tue, 2 Jul 2024 12:18:31 +0800
Message-ID: <20240702041837.5306-3-changbin.du@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702041837.5306-1-changbin.du@huawei.com>
References: <20240702041837.5306-1-changbin.du@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100011.china.huawei.com (7.221.188.204)

To make change easy, this change refactors the dso__disassemble_filename()
function by extracting two functions read_buildid_linkname() and
fallback_filename().

Signed-off-by: Changbin Du <changbin.du@huawei.com>

---
v2: split refactoring from logical change.
---
 tools/perf/util/disasm.c | 117 +++++++++++++++++++++++----------------
 1 file changed, 70 insertions(+), 47 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 8d9d78d3150c..c4ab98c0eaa1 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1092,28 +1092,12 @@ int symbol__strerror_disassemble(struct map_symbol *ms, int errnum, char *buf, s
 	return 0;
 }
 
-static int dso__disassemble_filename(struct dso *dso, char *filename, size_t filename_size)
+static int read_buildid_linkname(char *filename, char *linkname, size_t linkname_size)
 {
-	char linkname[PATH_MAX];
-	char *build_id_filename;
 	char *build_id_path = NULL;
 	char *pos;
 	int len;
 
-	if (dso__symtab_type(dso) == DSO_BINARY_TYPE__KALLSYMS &&
-	    !dso__is_kcore(dso))
-		return SYMBOL_ANNOTATE_ERRNO__NO_VMLINUX;
-
-	build_id_filename = dso__build_id_filename(dso, NULL, 0, false);
-	if (build_id_filename) {
-		__symbol__join_symfs(filename, filename_size, build_id_filename);
-		free(build_id_filename);
-	} else {
-		if (dso__has_build_id(dso))
-			return ENOMEM;
-		goto fallback;
-	}
-
 	build_id_path = strdup(filename);
 	if (!build_id_path)
 		return ENOMEM;
@@ -1127,41 +1111,80 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 	if (pos && strlen(pos) < SBUILD_ID_SIZE - 2)
 		dirname(build_id_path);
 
-	if (dso__is_kcore(dso) || dso__is_vdso(dso))
-		goto fallback;
-
-	len = readlink(build_id_path, linkname, sizeof(linkname) - 1);
-	if (len < 0)
-		goto fallback;
+	len = readlink(build_id_path, linkname, linkname_size);
+	if (len < 0) {
+		free(build_id_path);
+		return -1;
+	}
 
 	linkname[len] = '\0';
-	if (strstr(linkname, DSO__NAME_KALLSYMS) || strstr(linkname, DSO__NAME_VDSO) ||
-		access(filename, R_OK)) {
-fallback:
-		/*
-		 * If we don't have build-ids or the build-id file isn't in the
-		 * cache, or is just a kallsyms file, well, lets hope that this
-		 * DSO is the same as when 'perf record' ran.
-		 */
-		if ((dso__kernel(dso) || dso__is_vdso(dso)) && dso__long_name(dso)[0] == '/')
-			snprintf(filename, filename_size, "%s", dso__long_name(dso));
-		else
-			__symbol__join_symfs(filename, filename_size, dso__long_name(dso));
-
-		mutex_lock(dso__lock(dso));
-		if (access(filename, R_OK) && errno == ENOENT && dso__nsinfo(dso)) {
-			char *new_name = dso__filename_with_chroot(dso, filename);
-			if (new_name) {
-				strlcpy(filename, new_name, filename_size);
-				free(new_name);
-			}
+	free(build_id_path);
+	return 0;
+}
+
+static int fallback_filename(struct dso *dso, char *filename, size_t filename_size)
+{
+	char filepath[PATH_MAX];
+
+	/*
+	 * If we don't have build-ids or the build-id file isn't in the
+	 * cache, or is just a kallsyms file, well, lets hope that this
+	 * DSO is the same as when 'perf record' ran.
+	 */
+	if ((dso__kernel(dso) || dso__is_vdso(dso)) && dso__long_name(dso)[0] == '/')
+		snprintf(filepath, sizeof(filepath), "%s", dso__long_name(dso));
+	else
+		__symbol__join_symfs(filepath, sizeof(filepath), dso__long_name(dso));
+
+	mutex_lock(dso__lock(dso));
+	if (access(filepath, R_OK) && errno == ENOENT && dso__nsinfo(dso)) {
+		char *new_name = dso__filename_with_chroot(dso, filepath);
+		if (new_name) {
+			strlcpy(filepath, new_name, sizeof(filepath));
+			free(new_name);
 		}
-		mutex_unlock(dso__lock(dso));
-	} else if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND) {
-		dso__set_binary_type(dso, DSO_BINARY_TYPE__BUILD_ID_CACHE);
 	}
+	mutex_unlock(dso__lock(dso));
 
-	free(build_id_path);
+	if (access(filepath, R_OK) && errno == ENOENT)
+		return ENOENT;
+
+	snprintf(filename, filename_size, "%s", filepath);
+	return 0;
+}
+
+static int dso__disassemble_filename(struct dso *dso, char *filename, size_t filename_size)
+{
+	char linkname[PATH_MAX];
+	char *build_id_filename;
+
+	if (dso__symtab_type(dso) == DSO_BINARY_TYPE__KALLSYMS &&
+	    !dso__is_kcore(dso))
+		return SYMBOL_ANNOTATE_ERRNO__NO_VMLINUX;
+
+	build_id_filename = dso__build_id_filename(dso, NULL, 0, false);
+	if (build_id_filename) {
+		__symbol__join_symfs(filename, filename_size, build_id_filename);
+		free(build_id_filename);
+	} else {
+		if (dso__has_build_id(dso))
+			return ENOMEM;
+		return fallback_filename(dso, filename, filename_size);
+	}
+
+	if (access(filename, R_OK))
+		return fallback_filename(dso, filename, filename_size);
+
+	if (dso__is_kcore(dso) || dso__is_vdso(dso))
+		return fallback_filename(dso, filename, filename_size);
+
+	if (read_buildid_linkname(filename, linkname, sizeof(linkname) - 1) ||
+	    strstr(linkname, DSO__NAME_KALLSYMS) || strstr(linkname, DSO__NAME_VDSO)) {
+		return fallback_filename(dso, filename, filename_size);
+	}
+
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND)
+		dso__set_binary_type(dso, DSO_BINARY_TYPE__BUILD_ID_CACHE);
 	return 0;
 }
 
-- 
2.34.1

