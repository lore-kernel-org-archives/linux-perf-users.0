Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CBD5339E;
	Tue, 25 Jun 2024 03:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719286690; cv=none; b=p+rkVtQyIieFyfmoHmadEJ99yvin43tqYOCKTJoBHKtQoUf+eDtgllAPQ/zTMaT3JzEGkDT+UkGNVVpi9hz9QRGnNVGnFOCMDtqn0/44X4NwF8Y0tbWHVjY0uWp1amjuck+TT9InKZVHe/wESVEdElPP4At8/75zoo4E7CD3JhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719286690; c=relaxed/simple;
	bh=B1wopyCB6TwD/11E6lk/IigAXVhadQ1tVMMgoE/cy0g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d0B7veN2jKE3OnT76orUVHO7AeZFeohNE9pQRNwnMXC+3rrUCZQJwJNvUIXX9Z/xoJM17DFUPYIe6L2noj/LA4vRmJ01d0hAA0eic9SQATryfmTUWKLGUxG5dyoh2oeiJNcOOgsRxsDIY+eOgfyaeJcExe8WpAObY+w9F0wFOT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4W7Vq13JRBz2FbCS;
	Tue, 25 Jun 2024 11:35:57 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C0FB1A0188;
	Tue, 25 Jun 2024 11:38:06 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 11:38:04 +0800
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
Subject: [PATCH v4 3/5] perf: disasm: use build_id_path if fallback failed
Date: Tue, 25 Jun 2024 11:37:38 +0800
Message-ID: <20240625033740.223009-4-changbin.du@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625033740.223009-1-changbin.du@huawei.com>
References: <20240625033740.223009-1-changbin.du@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100011.china.huawei.com (7.221.188.204)

If we can not fallback for special dso (vmlinx and vdso), use the
build_id_path found previously.

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/util/disasm.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index c4ab98c0eaa1..f4e94ff37e50 100644
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

