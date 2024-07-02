Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C5E2030B;
	Tue,  2 Jul 2024 04:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719893942; cv=none; b=UmgvQ1kK2HYOT5Kg/ynWFSZyqt3ZOAELM70lpur/fk9AyXmSfhHe8ZzOuBroLMr6dRXNbj7IKgQiqtxIW85KFo8AMNi/0sQwvfTTwBHjfziOyIPYU4zjY4Ntkrtq4TNrZo0Usu1fQKmTf+QHMEKfvOx1pgctMuu4GvSSCqFSPec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719893942; c=relaxed/simple;
	bh=B1wopyCB6TwD/11E6lk/IigAXVhadQ1tVMMgoE/cy0g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZsU0HZ+QOsG7uAdI+1jOmqiJCXKWJ+WUWPf3tVH9w0lx2g2vvAWZ1o+Um+8IsNhDuENMKHQ90CicDL0SwXjoAUt6Mbe6hqFYrbVBE8NBD0OBqn7O47sLhzH5pvcgNNf7zp/ymeT5lmzqDJXCzU8JYkFcStjZRXgq7fgn1I6I95c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WCqLC2R2Dz1T4HB;
	Tue,  2 Jul 2024 12:14:27 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id F12C114037D;
	Tue,  2 Jul 2024 12:18:58 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 2 Jul 2024 12:18:57 +0800
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
Subject: [PATCH v5 3/8] perf: disasm: use build_id_path if fallback failed
Date: Tue, 2 Jul 2024 12:18:32 +0800
Message-ID: <20240702041837.5306-4-changbin.du@huawei.com>
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

