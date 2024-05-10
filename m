Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF60495E5;
	Fri, 10 May 2024 21:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715375094; cv=none; b=TV2SAFwe7TZ3nsO1mOrWrcClrMpYYrPSpY2unZcs3BXPRTJ5XqK3eLjc4L4b4qDpkGIG9WovKswQNVGMa3hsMmKYYvGudLgmHKFyFkL+9ZT89Zz8PQViWWYoF5aSxMOX60Km3FCAcIzOmUazLFSlEHNpiGd3akrkrI3IfKIy8Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715375094; c=relaxed/simple;
	bh=MU37FOLAkBjme+LOgIz/PRnWHSatJ/V8u55IN2abFBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+sfnbNUPawo2/+hYZAYkKGSn6pukfxdSBkXpBcyGorownixjwjscuPe8byVzrIfgsJ3rOp+9S8w3crmnu+dsI875JIa7S5GSKTqwFG2JwVYMZwWYStmHp1KDGiTXPg0cbNE5MxomZ6gKGDzYxrB38aomZgljRLn6kk+NlFTo/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkJkQJbA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkJkQJbA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FAEC113CC;
	Fri, 10 May 2024 21:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715375093;
	bh=MU37FOLAkBjme+LOgIz/PRnWHSatJ/V8u55IN2abFBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OkJkQJbA64xgLpBfeHVQG7bNEOmkTisLXSyb/geo8JsMHbjTre2upgQtyYYdm1ofS
	 bB+bOR7iqpV/Q2Z18b8/TgVOgM82zJ2neiwrGXHaIUz9X7zKGfQbtyQmmQ1V0GDK12
	 Sz1CCWsQe2nKIJXT/FW6wyxnvWjXtcRXnERjslAZFaEqkBJnkXyk4sC6UlfQT/fiAc
	 aRj/MBlQjrc89Lo5BONbQ75xmMbV+pe1+nW9Wgw25LEqC0Sk4C/vRY7slIVVe3F9EO
	 css9242TqMCoP4TvjWNGJLb1Ib8uZ9dTX6O6/s6Qp6zwFnBSx6U9Jfit/sOoCQCFX6
	 2PnNuCLOqyLKA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/2] perf annotate: Fix segfault on sample histogram
Date: Fri, 10 May 2024 14:04:51 -0700
Message-ID: <20240510210452.2449944-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
In-Reply-To: <CAM9d7ci6Y98hkiN1+=Q=YgLQLL-GN+pTxQ1JjqA+Q1EMEi52+g@mail.gmail.com>
References: <CAM9d7ci6Y98hkiN1+=Q=YgLQLL-GN+pTxQ1JjqA+Q1EMEi52+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A symbol can have no samples, then accessing annotated_source->samples
hashmap will get a segfault.

Fixes: a3f7768bcf48 ("perf annotate: Fix memory leak in annotated_source")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 541988cf6e19..1451caf25e77 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -113,10 +113,11 @@ static __maybe_unused void annotated_source__delete(struct annotated_source *src
 	if (src == NULL)
 		return;
 
-	hashmap__for_each_entry(src->samples, cur, bkt)
-		zfree(&cur->pvalue);
-
-	hashmap__free(src->samples);
+	if (src->samples) {
+		hashmap__for_each_entry(src->samples, cur, bkt)
+			zfree(&cur->pvalue);
+		hashmap__free(src->samples);
+	}
 	zfree(&src->histograms);
 	free(src);
 }
-- 
2.45.0.118.g7fe29c98d7-goog

