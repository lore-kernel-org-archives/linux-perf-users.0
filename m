Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899D7137C22;
	Thu, 13 Jun 2024 06:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718260538; cv=none; b=j5b2PZ18e4NuFT0M/fpPqDttPsbIt4sjfGYvWabLVnjmS8ijyHzLBtTA0c8XGXPVpWs5cn/mI6p9SMjv/rhJgQg/9OWkohOHJEWufTptro1Lh23jRnVYEo9V5cuzY+4FCzMqzB4Q6OqnfK4qgo0plToVHrn+A0oyujJQjU2xuaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718260538; c=relaxed/simple;
	bh=4+Y8Ka0zxULm0QTjXx+tuV1E6oFe1plf032g3zmI5sI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tdBM1n6NyEem7Cg347LcFbPwbqDZN52baXR+gschJSqTZsYnnLTI9esvnuIZLqp9E6XYo4mx7kmF7NkHUY0q7CUchdkXIFRgAOK3JJpAZDvZ90pb5vP91gofe9vDUCsBWS30ZsB0uTuda9H2N0jJC08xHn76+OCGb+XgiaVF83A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4W0CHl0hnhz1ytGk;
	Thu, 13 Jun 2024 14:32:03 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id 9BDFB140133;
	Thu, 13 Jun 2024 14:35:28 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 13 Jun 2024 14:35:27 +0800
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
Subject: [PATCH 2/2] perf: disasm: prefer symsrc_filename for filename
Date: Thu, 13 Jun 2024 14:35:10 +0800
Message-ID: <20240613063510.348692-3-changbin.du@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613063510.348692-1-changbin.du@huawei.com>
References: <20240613063510.348692-1-changbin.du@huawei.com>
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

If we already found a debugging version when loading symbols for that dso,
then use the same file for disasm instead of looking up in buildid-cache.

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/util/disasm.c |  5 +++++
 tools/perf/util/symbol.c | 12 ++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 72aec8f61b94..75cfc6fbd11d 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1103,6 +1103,11 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 	    !dso__is_kcore(dso))
 		return SYMBOL_ANNOTATE_ERRNO__NO_VMLINUX;
 
+	if (dso__symsrc_filename(dso)) {
+		strlcpy(filename, dso__symsrc_filename(dso), filename_size);
+		return 0;
+	}
+
 	build_id_filename = dso__build_id_filename(dso, NULL, 0, false);
 	if (build_id_filename) {
 		__symbol__join_symfs(filename, filename_size, build_id_filename);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 8d040039a7ce..a90c647d37e1 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2025,12 +2025,14 @@ int dso__load_vmlinux(struct dso *dso, struct map *map,
 		dso__set_binary_type(dso, DSO_BINARY_TYPE__VMLINUX);
 
 	err = dso__load_sym(dso, map, &ss, &ss, 0);
-	symsrc__destroy(&ss);
-
 	if (err > 0) {
 		dso__set_loaded(dso);
 		pr_debug("Using %s for symbols\n", symfs_vmlinux);
+
+		if (symsrc__has_symtab(&ss) && !dso__symsrc_filename(dso))
+			dso__set_symsrc_filename(dso, strdup(symfs_vmlinux));
 	}
+	symsrc__destroy(&ss);
 
 	return err;
 }
@@ -2395,12 +2397,14 @@ static int dso__load_vdso(struct dso *dso, struct map *map,
 	dso__set_binary_type(dso, DSO_BINARY_TYPE__SYSTEM_PATH_DSO);
 
 	err = dso__load_sym(dso, map, &ss, &ss, 0);
-	symsrc__destroy(&ss);
-
 	if (err > 0) {
 		dso__set_loaded(dso);
 		pr_debug("Using %s for %s symbols\n", symfs_vdso, dso__short_name(dso));
+
+		if (symsrc__has_symtab(&ss) && !dso__symsrc_filename(dso))
+			dso__set_symsrc_filename(dso, strdup(symfs_vdso));
 	}
+	symsrc__destroy(&ss);
 
 	return err;
 }
-- 
2.34.1

