Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3FC1A01D2;
	Fri, 16 Aug 2024 10:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805923; cv=none; b=HGwBYlVnuLJXU6gKfjJS4eV1VR55j98zWhRbkJ9xS7i9/vR8eFGqeVf5LdbvDGdqUrZIENesoxWvOqS9Fz9so6/6P3Qjk+WJikbuaF8dD8oQ+TZaCnlIfQVaBwJMmRUCVHzG+ZCDAlUSt0QpTulht1/O8umspZ3cUsz6nLbCsPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805923; c=relaxed/simple;
	bh=BB3GboFitawlrEaYLgZRHevIANxaCt7nCtA+dfku0ak=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EreTbFgojyC2cma1nFArvMxWEkOPsxHKNL5MmB2dlnaVuPSK+8/l46VDEquqE+IBgTVGbHtubG6nhQ2ZBMm/gbqtmuBTH3MZR2SdbZoBO9DNAKUvkFOfBjA5iRgU8RaBv4V7PrJwFH7ADxxZFVt4BK3gbvuD713K9+oFEN7rPBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wlf9T6bJCzcdMn;
	Fri, 16 Aug 2024 18:58:21 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id 14129180100;
	Fri, 16 Aug 2024 18:58:39 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 16 Aug 2024 18:58:37 +0800
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
Subject: [PATCH v6 3/8] perf: disasm: use build_id_path if fallback failed
Date: Fri, 16 Aug 2024 18:58:06 +0800
Message-ID: <20240816105811.1812897-4-changbin.du@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816105811.1812897-1-changbin.du@huawei.com>
References: <20240816105811.1812897-1-changbin.du@huawei.com>
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

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/util/disasm.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 0ece6e06da6f..6af9fbec3a95 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1176,15 +1176,21 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 		return fallback_filename(dso, filename, filename_size);
 
 	if (dso__is_kcore(dso) || dso__is_vdso(dso))
-		return fallback_filename(dso, filename, filename_size);
+		goto fallback;
 
-	if (read_buildid_linkname(filename, linkname, sizeof(linkname) - 1) ||
-	    strstr(linkname, DSO__NAME_KALLSYMS) || strstr(linkname, DSO__NAME_VDSO)) {
-		return fallback_filename(dso, filename, filename_size);
+	if (!read_buildid_linkname(filename, linkname, sizeof(linkname) - 1) &&
+	    (!strstr(linkname, DSO__NAME_KALLSYMS) && !strstr(linkname, DSO__NAME_VDSO))) {
+		/* It's not kallsysms or vdso, use build_id path found above */
+		goto out;
 	}
 
-	if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND)
-		dso__set_binary_type(dso, DSO_BINARY_TYPE__BUILD_ID_CACHE);
+fallback:
+	if (fallback_filename(dso, filename, filename_size)) {
+		/* if fallback failed, use build_id path found above */
+out:
+		if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND)
+			dso__set_binary_type(dso, DSO_BINARY_TYPE__BUILD_ID_CACHE);
+	}
 	return 0;
 }
 
-- 
2.34.1

