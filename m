Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E092E35B137;
	Mon,  5 Oct 2026 06:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791182061; cv=none; b=GqRqaglQHHKVKfM7fqsm8ETLeqSYuNdlKnxgefZwTTsJDlHFOJLXYu1kWZsFLsJAl1IyEGTA5z/uNifn6p9kSpDV431k1CKRCZ7guPTL6SdkHMy4TeiTbDkvdOQdqCWDwDXzKw4xrTpjzqVBYx8OIC7k4QH5fCgxE5aN6PDSr4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791182061; c=relaxed/simple;
	bh=IPiuA7mvAh8Cc9ghjIeunwGi6lNsBeZ9idyJsCuy02A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NbHEz0Jn+RSon+7M4BjekfmV10LQi3hN1sr93ioEUbD0GsSbT0l85rXOctK/EWT/jcgyLXcQfJ5l76+hXTtCIWl8OEV+R4gxozpm7kxAmtjqaBT0+nyQILuT3enVBNdS/VQepK1hfzkrE1nwKw/jRm1dskNMUdCnFvrkwgLHiXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fixTUtc1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fixTUtc1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725A71F0089B;
	Mon,  5 Oct 2026 06:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791182059;
	bh=EAMczUtP2gPR0t49GLGwF+EnBCs37VmOUafNFQVOLjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fixTUtc1J0Nn8rHyFyXEUrZlMnLmYV2m6n3MaQ8LmlaHXo/BnNebaj2kgwi1zFtju
	 InuWZ934JFrvYA41W7XG23rWeqSjafa/adRMcXrOrcg0A+N2E6Kc1x++udZE0p6/sG
	 fgIzlKo2BIl5583Hl49k9qplhaeBb+apT2mShLme8S3iRHpeXT8nP+SXzpMF9moyCA
	 SotcYPTJb25qnN8Js8T2XXfUNd8QEk6xcoyOJx0AGKeLHqHhS/cQbzJy2N1n59uowr
	 VPIM+yHXNEFqUPi5jsdXtmjw3sZO7aqlFytFcH6nLI/8d8WK7wFuwI2Xj2xPX2Y3T4
	 Tc9qQiiju9NSA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v1 5/7] perf symbol: Set dso symtab type for libbfd
Date: Sun,  4 Oct 2026 23:34:09 -0700
Message-ID: <20261005063411.114244-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005063411.114244-1-namhyung@kernel.org>
References: <20261005063411.114244-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It missed to set the dso symtab type when the symbols are loaded by
libbfd.  When it happens both syms_ss and runtime_ss may not be set
and won't call dso__load_sym().

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index fc6e4dff282bc2dc..02b096ccbc60ac2a 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1933,6 +1933,7 @@ int dso__load(struct dso *dso, struct map *map)
 			nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
 
 		if (bfdrc == 0) {
+			dso__set_symtab_type(dso, symtab_type);
 			ret = 0;
 			break;
 		}
-- 
2.55.0

