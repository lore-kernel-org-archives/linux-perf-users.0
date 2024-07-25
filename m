Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4492376A;
	Thu, 25 Jul 2024 02:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721873789; cv=none; b=PkqAWpwKVOK1SOk4InxaUnlT1YUANU72JGq7/GKg5IT8sXpuAVNNA+REsbD5y+2y5mUfTns+q+dGvlcxKxiO10a/0bC/vzPjEcFYnNSEIbVDLqlbX/at9zve1D0Lz8t+qv42S+doRnlf57XVzRhH4aM3YtNMKLWbGUl8XFUwQKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721873789; c=relaxed/simple;
	bh=YaSqM+yON6vKOgHU+PFjwHs6wYzBXT+CMoR7EDyy+OI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KYBBdZh9MSRSUXmC32Q2otByj0l8q2nPCZ71gdc9HhupKcByweNYV+tdmVfHYcCcSwvf/ggdvqYfFGeTleLu0ChH7m6l1dWmOGTkORmmxOBtyaAERrpst0PX/O+ba3sH7/qEJbBgw9mh1QFpqHqHvd5m0vRgEWosZyTOdfRCliw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WTvXX4mjczQmrb;
	Thu, 25 Jul 2024 10:12:12 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id 91EF4180088;
	Thu, 25 Jul 2024 10:16:24 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 25 Jul 2024 10:16:22 +0800
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
Subject: [PATCH v6 7/8] perf: disasm: prefer debugging files in build-id cache
Date: Thu, 25 Jul 2024 10:15:48 +0800
Message-ID: <20240725021549.880167-8-changbin.du@huawei.com>
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

The build-id cache might have both debugging and non-debugging files. Here
we prefer the debugging version for annotation.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/util/disasm.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 6af9fbec3a95..5f66b3632770 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1162,18 +1162,25 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 	    !dso__is_kcore(dso))
 		return SYMBOL_ANNOTATE_ERRNO__NO_VMLINUX;
 
-	build_id_filename = dso__build_id_filename(dso, NULL, 0, false);
-	if (build_id_filename) {
-		__symbol__join_symfs(filename, filename_size, build_id_filename);
-		free(build_id_filename);
-	} else {
-		if (dso__has_build_id(dso))
-			return ENOMEM;
-		return fallback_filename(dso, filename, filename_size);
-	}
+	/* Prefer debugging file if exists, otherwise non-debugging one is used. */
+	for (int i = 0; i < 2; i++) {
+		build_id_filename = dso__build_id_filename(dso, NULL, 0, !i);
+		if (build_id_filename) {
+			__symbol__join_symfs(filename, filename_size, build_id_filename);
+			free(build_id_filename);
+		} else {
+			if (dso__has_build_id(dso))
+				return ENOMEM;
+			return fallback_filename(dso, filename, filename_size);
+		}
 
-	if (access(filename, R_OK))
-		return fallback_filename(dso, filename, filename_size);
+		if (!access(filename, R_OK))
+			break;
+		else if (i != 0) {
+			/* nor debugging or non-debugging is found */
+			return fallback_filename(dso, filename, filename_size);
+		}
+	}
 
 	if (dso__is_kcore(dso) || dso__is_vdso(dso))
 		goto fallback;
-- 
2.34.1

