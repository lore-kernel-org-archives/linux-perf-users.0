Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B604B1C68C;
	Thu, 25 Jul 2024 02:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721873785; cv=none; b=gY1hCnAUpeBbGru2QtJcJ80rSv02W8fEUDvWg+krfq+Mz3SX0bvRjlf5J6IBK72CCU9INmH3uskktBdFGc6wNcKpQjovsxXiOWmRJdfcmd9Oncxqu/lDO6Maw/zS58guNsJcIjbo5M/xQ2C9BZUiZEKv+CgUdEdARDsRPp5HytI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721873785; c=relaxed/simple;
	bh=sisKOpu/Vo7sGSxHa6dVdjlQnbQ+gt2LsAJ8FkZo7YY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IgH3jWcuyeKGVJpw76SdWTSpVZwqJ+PYxK7Ey7yOEcMxaBDXC6Np8aC8gj0Gb1xsRhGd8AHzRtOiVvRDkwEXpoAlQ79ndrrwND2iyCyklhDQH5+jBB7zaNCtQIHIgyL5iwKuSvCPWIoK7EP9qIojVlVME+NnN12U+5ygd9jE/FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WTvbG1PTwzMr5Q;
	Thu, 25 Jul 2024 10:14:34 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A9EC1402CB;
	Thu, 25 Jul 2024 10:16:21 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 25 Jul 2024 10:16:20 +0800
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
Date: Thu, 25 Jul 2024 10:15:46 +0800
Message-ID: <20240725021549.880167-6-changbin.du@huawei.com>
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

