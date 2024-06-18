Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE721C6B4;
	Tue, 18 Jun 2024 01:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718675787; cv=none; b=OMkP3HjlgrHla9nr+lFMtfOkcttExb7sA7MR1garaqNdC8/HtIADtx/8QCct+pSQfsPTFBaBHmrGmqzHQgtYwYqG4gC7isK951qBZ3f5DBypNvIqPZiO4SpcRNdYa1BzqRc5sCMFfn45IRr+G93c3SPAZAv9moO92b8T7I9T7V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718675787; c=relaxed/simple;
	bh=I/54TK8Eh32J4IC6wgODBKMZiR0HxmWHWcUWSz/7NgU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jc8/XQO/p96gXsOvnPjfUFYCWue8PrVmTHCNFpGRubdmFxx34XTB24luhM1Vl2YbIgLXx0izVnPKRq7JRr79p/LsMNeXkc/W2kDrGBtaaRIb1zxAG89DENs0MD6EOUyOER9wkrjV+FT8uWlKaM0OkKQZE5cU/xnElaBFQOd4ZDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W38qd2YWRznVqH;
	Tue, 18 Jun 2024 09:51:25 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id AD966180087;
	Tue, 18 Jun 2024 09:56:17 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 18 Jun 2024 09:56:16 +0800
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
	<llvm@lists.linux.dev>, Changbin Du <changbin.du@huawei.com>
Subject: [PATCH v3 2/4] perf: disasm: use build_id_path if fallback failed
Date: Tue, 18 Jun 2024 09:55:28 +0800
Message-ID: <20240618015530.3699434-3-changbin.du@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618015530.3699434-1-changbin.du@huawei.com>
References: <20240618015530.3699434-1-changbin.du@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100011.china.huawei.com (7.221.188.204)

If we can not fallback for special dso (vmlinx and vdso), use the
build_id_path found previously.

To make change easy, this change first refactors the code by extracting
two functions read_buildid_linkname() and fallback_filename().

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/util/disasm.c | 121 ++++++++++++++++++++++++---------------
 1 file changed, 75 insertions(+), 46 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 442e9802a772..3075daa61916 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1092,14 +1092,72 @@ int symbol__strerror_disassemble(struct map_symbol *ms, int errnum, char *buf, s
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
 
+	build_id_path = strdup(filename);
+	if (!build_id_path)
+		return ENOMEM;
+
+	/*
+	 * old style build-id cache has name of XX/XXXXXXX.. while
+	 * new style has XX/XXXXXXX../{elf,kallsyms,vdso}.
+	 * extract the build-id part of dirname in the new style only.
+	 */
+	pos = strrchr(build_id_path, '/');
+	if (pos && strlen(pos) < SBUILD_ID_SIZE - 2)
+		dirname(build_id_path);
+
+	len = readlink(build_id_path, linkname, linkname_size);
+	if (len < 0) {
+		free(build_id_path);
+		return -1;
+	}
+
+	linkname[len] = '\0';
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
+		}
+	}
+	mutex_unlock(dso__lock(dso));
+
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
 	if (dso__symtab_type(dso) == DSO_BINARY_TYPE__KALLSYMS &&
 	    !dso__is_kcore(dso))
 		return SYMBOL_ANNOTATE_ERRNO__NO_VMLINUX;
@@ -1111,57 +1169,28 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 	} else {
 		if (dso__has_build_id(dso))
 			return ENOMEM;
-		goto fallback;
+		return fallback_filename(dso, filename, filename_size);
 	}
 
-	build_id_path = strdup(filename);
-	if (!build_id_path)
-		return ENOMEM;
-
-	/*
-	 * old style build-id cache has name of XX/XXXXXXX.. while
-	 * new style has XX/XXXXXXX../{elf,kallsyms,vdso}.
-	 * extract the build-id part of dirname in the new style only.
-	 */
-	pos = strrchr(build_id_path, '/');
-	if (pos && strlen(pos) < SBUILD_ID_SIZE - 2)
-		dirname(build_id_path);
+	if (access(filename, R_OK))
+		return fallback_filename(dso, filename, filename_size);
 
-	if (dso__is_kcore(dso))
+	if (dso__is_kcore(dso) || dso__is_vdso(dso))
 		goto fallback;
 
-	len = readlink(build_id_path, linkname, sizeof(linkname) - 1);
-	if (len < 0)
-		goto fallback;
+	if (!read_buildid_linkname(filename, linkname, sizeof(linkname) - 1) &&
+	    (!strstr(linkname, DSO__NAME_KALLSYMS) && !strstr(linkname, DSO__NAME_VDSO))) {
+		/* not kallsysms or vdso, use build_id path found above */
+		goto out;
+	}
 
-	linkname[len] = '\0';
-	if (strstr(linkname, DSO__NAME_KALLSYMS) || strstr(linkname, DSO__NAME_VDSO) ||
-		access(filename, R_OK)) {
 fallback:
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
-		}
-		mutex_unlock(dso__lock(dso));
-	} else if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND) {
-		dso__set_binary_type(dso, DSO_BINARY_TYPE__BUILD_ID_CACHE);
+	if (fallback_filename(dso, filename, filename_size)) {
+		/* if fallback failed, use build_id path found above */
+out:
+		if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND)
+			dso__set_binary_type(dso, DSO_BINARY_TYPE__BUILD_ID_CACHE);
 	}
-
-	free(build_id_path);
 	return 0;
 }
 
-- 
2.34.1

