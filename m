Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B735A1A2844;
	Thu, 12 Sep 2024 11:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726139812; cv=none; b=jQezZSDhb08eJdaFG+duk0FPyrNq52GmRWcnKmfwJhJPJZ7Bb5L4MfGKDV8ddKRoGRtva2bcOS4V3fSlr6YUs5uQo28TwwoxwoRyXOLPLJX4KzE6z5WcZew62FpAtnVrjKCEeIvyS/a4SxC5qS/gDbmsk1R9Ak9QsKnv0sp6F6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726139812; c=relaxed/simple;
	bh=vw9yiwxx9WwFswjBvcRlbnaUkK6twTO7OIHipUuj1xU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cPU48VcyMEqwi0Ui+R3J2DuCEJBtOY7S94IFeadrIVXBrPetQiHkDv+aT6RzGONF7KwzPghtoM5j3ds9b6YEIXEoQ0dXeQtAmHEDGxp/9WlJmlWd5FMOrP++y7iR56KrvyYVJAl6YMuSjmhxuWwdQ53AeuWaQk76EgzGv1NgtMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X4FHN1fMLzyRjp;
	Thu, 12 Sep 2024 19:16:00 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id 12F1718010B;
	Thu, 12 Sep 2024 19:16:47 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 12 Sep 2024 19:16:45 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Liang,
 Kan" <kan.liang@linux.intel.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Changbin Du <changbin.du@huawei.com>
Subject: [PATCH] perf buildid-cache: recognize vdso when adding files
Date: Thu, 12 Sep 2024 19:16:23 +0800
Message-ID: <20240912111623.2213105-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.34.1
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

Identify vdso by file name matching. The vdso objects have name
as vdso[32,64].so[.dbg].

$ perf buildid-cache -a /work/linux/arch/x86/entry/vdso/vdso64.so.dbg

Without this change, added vdso using above command actually will never
be used.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Changbin Du <changbin.du@huawei.com>

---
This patch is separated from the series "perf: Support searching local
debugging vdso or specify vdso path in cmdline".
---
 tools/perf/builtin-buildid-cache.c | 32 +++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index b0511d16aeb6..08de05e2aaae 100644
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
-- 
2.34.1

