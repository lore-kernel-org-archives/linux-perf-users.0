Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A941AD9C6;
	Fri, 16 Aug 2024 10:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805925; cv=none; b=cAvgASZIj3939Pszipq7pXmZ+sb1AbCH9jrkJS7xvJ7lyIpXmAYeQx2KGJEckXvu035lTrD2jO2NehDh8UIrPlnsWPLGiYG5P8KpOpiVJA77HgSI8e0rytLMSq7HQCs5MMtOhTJ0u//XqnYB1MqwhcXlAUPg4aXXvMC2WUkNtmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805925; c=relaxed/simple;
	bh=sisKOpu/Vo7sGSxHa6dVdjlQnbQ+gt2LsAJ8FkZo7YY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RDbdXXWWc2WDwR861n/BJUIztzSfFTsb4hJQs+abawqVJHHY12bx/U2eYXquj/I59AHqhSqCBWRrMvM7nDMA2hXRP9vdDC6/3t/QHCnX6v2oPjWLwGpgFY4suVXekIr6LguwP65xZcsF3te8o2KPy7jn3AIjJsxoR/V+MODeVL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Wlf9F3NrWz1T7Vm;
	Fri, 16 Aug 2024 18:58:09 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id D2D44140361;
	Fri, 16 Aug 2024 18:58:41 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 16 Aug 2024 18:58:40 +0800
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
Subject: [PATCH v6 5/8] perf: build-id: add support for build-id cache vdso debug
Date: Fri, 16 Aug 2024 18:58:08 +0800
Message-ID: <20240816105811.1812897-6-changbin.du@huawei.com>
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

This try to add debugging vdso elf to build-id cache the same as normal
objects. Later we will extend this to find local debugging vdso from
special paths.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/util/build-id.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 83a1581e8cf1..5bda47de5cf2 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -259,8 +259,8 @@ static bool build_id_cache__valid_id(char *sbuild_id)
 static const char *build_id_cache__basename(bool is_kallsyms, bool is_vdso,
 					    bool is_debug)
 {
-	return is_kallsyms ? "kallsyms" : (is_vdso ? "vdso" : (is_debug ?
-	    "debug" : "elf"));
+	return is_kallsyms ? "kallsyms" : (is_debug ? "debug" : (is_vdso ?
+		"vdso" : "elf"));
 }
 
 char *__dso__build_id_filename(const struct dso *dso, char *bf, size_t size,
@@ -701,13 +701,12 @@ build_id_cache__add(const char *sbuild_id, const char *name, const char *realnam
 	 * file itself may not be very useful to users of our tools without a
 	 * symtab.
 	 */
-	if (!is_kallsyms && !is_vdso &&
-	    strncmp(".ko", name + strlen(name) - 3, 3)) {
+	if (!is_kallsyms && strncmp(".ko", name + strlen(name) - 3, 3)) {
 		debugfile = build_id_cache__find_debug(sbuild_id, nsi, root_dir);
 		if (debugfile) {
 			zfree(&filename);
 			if (asprintf(&filename, "%s/%s", dir_name,
-			    build_id_cache__basename(false, false, true)) < 0) {
+			    build_id_cache__basename(false, is_vdso, true)) < 0) {
 				filename = NULL;
 				goto out_free;
 			}
-- 
2.34.1

