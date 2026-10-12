Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47951335BBB;
	Mon, 12 Oct 2026 05:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791782769; cv=none; b=GzYznJH2yJxA4oxEx7MA5ybiFPBXCwWGHiL7u0BmxzfoVxEiyBEzVgFPPGATblZhDQmvytrKPAKIdiwZ2GbRsxMnx5esEYG+8hjtowbZcSjas/0C9EGbV87MT5mrB58qrrBowNambkoH0Eo8zDC6+9LJyrEN2f8k8tIDFiacmro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791782769; c=relaxed/simple;
	bh=IvNv7EDsuliZphPg0gFALInCOdTIFYFO9q2lEK08u8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CcxFZiZteEwNxXogebW+sgRQx7sAYb890vpKFqx4LwBFme7C992H3m3RYP6YoOPf2d8O+sO8Mh7iWMbzbydN6L2G+ShYCWjyEdkXaLzjacXpptiTEJGmNH+FiRBbWq6/9YHN1hgc5WiNah+2FBkZ325T9J62/Y6dNbsHahRJS/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORA98BlS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORA98BlS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3731F0089D;
	Mon, 12 Oct 2026 05:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791782768;
	bh=1XK8Il04WuhyBoezMZOl0+dLT+nbaBsIQwPYNoopg2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ORA98BlSFAiil15pFAkS+mEQiVoAEQ8tEkuwhrC35i5wpXW9EPlfMrO4QaP3Z6nmt
	 jRdzyJ1EofIdYf/k4jXEvYw8crp/f355lJTwMeXNCybPbOpKDEr2G34LP6dmiyt/+u
	 7QuhywqoN7wd0nvCV2Fxu3xPkAUO5rQb898SpH9Gedls7yFIsOYG0hWX6eaeCRAUEl
	 BE1FQWzMAv1WIHmrcrCEwLkId1l0vmyVnKAn+rb33gyyFKWW6L202kfJKrhkOKtDoa
	 GpOkxLpio+GxYzNAZVQSVefIVq4Tclzl+X4fW+1m+E6IjHl5C8Z+bC3Oc03oz/Wz6v
	 bNf4F6S0aYXmQ==
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
Subject: [PATCH v3 01/10] perf tools: Remove redundant dso data init
Date: Sun, 11 Oct 2026 22:25:52 -0700
Message-ID: <20261012052601.13920-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012052601.13920-1-namhyung@kernel.org>
References: <20261012052601.13920-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fd and status are initialized later with cache.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dso.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index d3017c82ffb5f4b1..df03f84c9723560e 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1722,8 +1722,6 @@ struct dso *dso__new_id(const char *name, const struct dso_id *id)
 		dso->srclines = RB_ROOT_CACHED;
 		dso->data_types = RB_ROOT;
 		dso->global_vars = RB_ROOT;
-		dso->data.fd = -1;
-		dso->data.status = DSO_DATA_STATUS_UNKNOWN;
 		dso->symtab_type = DSO_BINARY_TYPE__NOT_FOUND;
 		dso->binary_type = DSO_BINARY_TYPE__NOT_FOUND;
 		dso->dbginfo_type = DSO_BINARY_TYPE__NOT_FOUND;
-- 
2.55.0

