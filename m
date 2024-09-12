Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C267719F439;
	Thu, 12 Sep 2024 12:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726142611; cv=none; b=PgnV7aeNnaYfB/TTcuvgWddBgI9qmQfz+2p1EvaT4rxefxZvfAlyBscjituCh3Fqec7AZfkkQzZyzSZsxxuKwQNg+XcVXwD9z2NTDfXHdtTJfzR3JOucfqWB+nfE3ZhoJlkr635vU5lKNk1NjrMsZtU24uBJoKYYM5jsWRKvfJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726142611; c=relaxed/simple;
	bh=PmK/9VGzrQ8nN9Lz3umqK/QSUuwJUIZunJsJ4CuYJCg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kb32lK8UOBgRrCoe5LB2RtDrcA1gWlSqEe3S8Mi1jt33KemVz7VjZ9ubnSSbHNyIiULFgDuFSaz42JfKmPkg9DzCb8dL2mF16FLpufnBbfvj64tMnpzdtIg7KH85HIuGtd3EMKDy2++F7yTIlMLIDtWTZKfYIjgZXCBJfoCi1TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X4GKC4fpfzyRTF;
	Thu, 12 Sep 2024 20:02:39 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id 82F2A140361;
	Thu, 12 Sep 2024 20:03:26 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 12 Sep 2024 20:03:25 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Liang,
 Kan" <kan.liang@linux.intel.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Changbin Du <changbin.du@huawei.com>
Subject: [PATCH v2] perf buildid-cache: recognize vdso when adding files
Date: Thu, 12 Sep 2024 20:03:03 +0800
Message-ID: <20240912120303.2294175-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.34.1
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

Identify vdso by file name matching. The vdso objects have name
as vdso[32,64].so[.dbg].

$ perf buildid-cache -a /work/linux/arch/x86/entry/vdso/vdso64.so.dbg

Without this change, added vdso using above command actually will never
be used.

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Changbin Du <changbin.du@huawei.com>

---
This patch is separated from the series "perf: Support searching local
debugging vdso or specify vdso path in cmdline".

v2: also update build_id_cache__update_file().
---
 tools/perf/builtin-buildid-cache.c | 34 ++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index b0511d16aeb6..69f43460d007 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -172,6 +172,36 @@ static int build_id_cache__add_kcore(const char *filename, bool force)
 	return 0;
 }
 
+static bool filename_is_vdso(const char *filename)
+{
+	bool is_vdso = false;
+	char *fname, *bname;
+	static const char * const vdso_names[] = {
+		"vdso.so", "vdso32.so", "vdso64.so", "vdsox32.so"
+	};
+
+	fname = strdup(filename);
+	if (!fname) {
+		pr_err("no memory\n");
+		return false;
+	}
+
+	bname = basename(fname);
+	if (!bname)
+		goto out;
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(vdso_names); i++) {
+		if (strstarts(bname, vdso_names[i])) {
+			is_vdso = true;
+			break;
+		}
+	}
+
+out:
+	free(fname);
+	return is_vdso;
+}
+
 static int build_id_cache__add_file(const char *filename, struct nsinfo *nsi)
 {
 	char sbuild_id[SBUILD_ID_SIZE];
@@ -189,7 +219,7 @@ static int build_id_cache__add_file(const char *filename, struct nsinfo *nsi)
 
 	build_id__sprintf(&bid, sbuild_id);
 	err = build_id_cache__add_s(sbuild_id, filename, nsi,
-				    false, false);
+				    false, filename_is_vdso(filename));
 	pr_debug("Adding %s %s: %s\n", sbuild_id, filename,
 		 err ? "FAIL" : "Ok");
 	return err;
@@ -323,7 +353,7 @@ static int build_id_cache__update_file(const char *filename, struct nsinfo *nsi)
 
 	if (!err)
 		err = build_id_cache__add_s(sbuild_id, filename, nsi, false,
-					    false);
+					    filename_is_vdso(filename));
 
 	pr_debug("Updating %s %s: %s\n", sbuild_id, filename,
 		 err ? "FAIL" : "Ok");
-- 
2.34.1

