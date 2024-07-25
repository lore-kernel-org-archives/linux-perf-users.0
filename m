Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EDF6AB9;
	Thu, 25 Jul 2024 02:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721873782; cv=none; b=ejjuZR4udzY0t0/GPXa0ntGiYJhdhx7+TIxpKH874ai/fNghdd9xMUk8ZOs8DtPsKvVj3N0PqKh4Zt7g0ItWwMInaYj4kw8RbPLY4plXpIXZ9TJ3XpSDmibzZ35DVxfZC8wcspRNJ8/ZfmaF/mQhtaybMD8VJUuxWsiBCmuplNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721873782; c=relaxed/simple;
	bh=MKgoX7MBPsWSbi0jaZmoLefjothuAgU9N/qVCkTkg94=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D7y4SAosQ6qsqIbPN/BzwciZL2uYoP3wnlBtB8xgInOffs2m4od9m0IJeJCblOmkwRR76SVJKmZyMhFNAXl4RCUojjIhort9xTo/daVdfiDcHpBHlTDEywh5OgME4ICptWSBjqx6NUlUEzlFPd85Zjm3gcMfyEFeqndBkknUqag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WTvdB0M5gzxTRJ;
	Thu, 25 Jul 2024 10:16:14 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id 4058B1402CB;
	Thu, 25 Jul 2024 10:16:17 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 25 Jul 2024 10:16:15 +0800
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
Subject: [PATCH v6 2/8] perf: disasm: refactor function dso__disassemble_filename
Date: Thu, 25 Jul 2024 10:15:43 +0800
Message-ID: <20240725021549.880167-3-changbin.du@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240725021549.880167-1-changbin.du@huawei.com>
References: <20240725021549.880167-1-changbin.du@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
index 7e26d5215640..0ece6e06da6f 100644
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

