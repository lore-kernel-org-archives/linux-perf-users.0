Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4F97EEE7;
	Tue,  2 Jul 2024 04:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719893949; cv=none; b=TF1QjNSpwEv3wY5gOc7ODqNImMIm9swRa6GB7eGKOJFejiSecwmdy7iUjHO/B89ki/711Kxt+A+xLTWnWLOz+yuud353gm8JwS/7fXo0nyv8mdVrxcR7MoSMmMaxCBrhI0P7egpmjzObAuxSDDiHpp/quuqle23SRqWzpijr2fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719893949; c=relaxed/simple;
	bh=6KnXP5/kVbBhp4xtOY0o8D1oZBIYLXMx71oUKcb6ZK4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DqFiCazQe27z+rw7ed68Vh7nU8gvwozv+fyIhJvkudf6+ncpYysGO6IviDoT81zFMxRxj1Jp7/FJbYPu4zIg9w+iOakhmoY4gP21LGtoCAMvsFWkOL7q9D6kB5BspSJ7w9j4JrGmpnAqztsdS5Ki38wZL2omN41vkfe4FnVyWUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WCqPb61qLzdfvf;
	Tue,  2 Jul 2024 12:17:23 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id 646271403D2;
	Tue,  2 Jul 2024 12:19:00 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 2 Jul 2024 12:18:58 +0800
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
Subject: [PATCH v5 4/8] perf: build-id: name debugging vdso as "debug"
Date: Tue, 2 Jul 2024 12:18:33 +0800
Message-ID: <20240702041837.5306-5-changbin.du@huawei.com>
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

As normal objects, we will add debugging vdso elf to build-id cache later.
Here we name the debugging one as "debug".

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/util/build-id.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 83a1581e8cf1..15530af2bad9 100644
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
-- 
2.34.1

