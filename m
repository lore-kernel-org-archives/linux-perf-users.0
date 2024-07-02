Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A9F84DE9;
	Tue,  2 Jul 2024 04:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719893949; cv=none; b=THS49XmRmFe/wwqWYhtgfd+1eH7O5sQzKuJvR9VNuEtyOl3qY6fNiu0+KM1Inv01Dw7FigtwXl6fiep53ShwBM13DhjI+jHDxZ8C9B00IXMAfuWYqTeyGcMglWlrNiegajg7uliaIfBqqf7WUPXmBgFSYyxLCDp3jHjuFksMlRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719893949; c=relaxed/simple;
	bh=BnKwtgbDOBy6xNe23GdjLGT6tsNsyI/9xyn0n4di9lQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qgg3j7BW5Is8ljOMs9c2W1m6jsy5sn97NkY/jL1ublAoteiVtoDCNeVEPw7Om1cpuWpWz5nsVLd3JCE2WhCbwW/1jorxydyF3TzNBMGAOaQUcnAd20Yp7miSOGXchI+xhfAV8YDsKUF/WYusY9I8VqOKtnmGkqadWJxlCXcilG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WCqRH1YMkznYnM;
	Tue,  2 Jul 2024 12:18:51 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id 266FC18007E;
	Tue,  2 Jul 2024 12:19:06 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 2 Jul 2024 12:19:04 +0800
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
Subject: [PATCH v5 8/8] perf buildid-cache: recognize vdso when adding files
Date: Tue, 2 Jul 2024 12:18:37 +0800
Message-ID: <20240702041837.5306-9-changbin.du@huawei.com>
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

Identify vdso by file name matching. The vdso objects have name
as vdso[32,64].so[.dbg].

$ perf buildid-cache -a /work/linux/arch/x86/entry/vdso/vdso64.so.dbg

Without this change, adding vdso using above command actually will never
be used.

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/builtin-buildid-cache.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index b0511d16aeb6..8edea9044a65 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -172,6 +172,30 @@ static int build_id_cache__add_kcore(const char *filename, bool force)
 	return 0;
 }
 
+static bool filename_is_vdso(const char *filename)
+{
+	char *fname, *bname;
+	static const char * const vdso_names[] = {
+		"vdso.so", "vdso32.so", "vdso64.so", "vdsox32.so"
+	};
+
+	fname = strdup(filename);
+	if (!fname) {
+		pr_err("no mememory\n");
+		return false;
+	}
+
+	bname = basename(fname);
+	if (!bname)
+		return false;
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(vdso_names); i++) {
+		if (!strncmp(bname, vdso_names[i], strlen(vdso_names[i])))
+			return true;
+	}
+	return false;
+}
+
 static int build_id_cache__add_file(const char *filename, struct nsinfo *nsi)
 {
 	char sbuild_id[SBUILD_ID_SIZE];
@@ -189,7 +213,7 @@ static int build_id_cache__add_file(const char *filename, struct nsinfo *nsi)
 
 	build_id__sprintf(&bid, sbuild_id);
 	err = build_id_cache__add_s(sbuild_id, filename, nsi,
-				    false, false);
+				    false, filename_is_vdso(filename));
 	pr_debug("Adding %s %s: %s\n", sbuild_id, filename,
 		 err ? "FAIL" : "Ok");
 	return err;
-- 
2.34.1

