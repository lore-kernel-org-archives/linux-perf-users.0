Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4279446D2;
	Thu, 25 Jul 2024 02:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721873796; cv=none; b=BtGvsuECGvOzVlRDU9naeKSvn8791xEIhg1y49/9rPe0E3nSg565fSMN84WZMcM/C9t9Cf9j27aG+DihU2GgweIbEoOLB+psewlzWQDmCQk+hwkBJYSLjEI53of47QGV7ZWingdpEI0ZFH0x6gwEiA2ECkcpBZZDJEy638GmqLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721873796; c=relaxed/simple;
	bh=BnKwtgbDOBy6xNe23GdjLGT6tsNsyI/9xyn0n4di9lQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a+peIUbyUeZ0kN7+5z8i8bO63s8yucdj6jRE82EI0dLSwIVMc/49U+YbRuo6xjydJG5lveBMp1rUjY4FdFOdS5qv5fdSsa4KHxRYicOMhdGw4B5xC/dizngg1+ZX3p5WDYhygtNaxpqdkJgTKW5fGf39zMsDupVOjADeL38HX50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WTvXZ3kRnz20ks5;
	Thu, 25 Jul 2024 10:12:14 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id 053AC180044;
	Thu, 25 Jul 2024 10:16:26 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 25 Jul 2024 10:16:24 +0800
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
Subject: [PATCH v6 8/8] perf buildid-cache: recognize vdso when adding files
Date: Thu, 25 Jul 2024 10:15:49 +0800
Message-ID: <20240725021549.880167-9-changbin.du@huawei.com>
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

