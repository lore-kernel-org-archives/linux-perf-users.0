Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857623AD528;
	Mon, 12 Oct 2026 05:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791783024; cv=none; b=JynITiQmyo3mmXB1cqJIgurcYXV37ZTuhQf87Jq1Pn7+zQweZ+JR9oykpYQd6ZEBi508np3mCjypImezldwbweB07ti85ThTqvEhrIWmi7pIRtk/NDA5E63XcKsaalnR0gNcvcucCX3mrbwXZ+483BQCGy07OX+9UTeXMhqWxXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791783024; c=relaxed/simple;
	bh=BHve4lZyOqCJLNZ9KRjqYrvrOox5Nmr0PUUm6Fhqn+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h88nLmyOO8CjqLq+WjoAoDX6JVpBmVcB65M+BDK9T2ONLuQSxxYRprIJsLE5U7FUSzEXh2DoBEqeG1XAqxl6li1qlI+JJ7pWZsDyTK5Cs3n/ww1RrUEaMw4N/mTg7aznzfys51pNrKkgISLN+FeXYdIHTPfp5YfaxY7ESMN1Oz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bj29BzA2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bj29BzA2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104951F008A0;
	Mon, 12 Oct 2026 05:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791783023;
	bh=tPwIo9wngHfeUyow3gNxo0hcPsjiXaQrYgQJFGwKfB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bj29BzA2rjj5vGLLMYp3Q0kGhL0MMtsOLZubnnx2G8OxvV6wAsQ0zVcvbN8Yrnx8H
	 f7OnUxnUQ09Jo3BN1VDwP6WQJnAhBOBGJz4QOvUZhQ9vm84aUD8qqgSNMvXc/H8Imh
	 I9DUmFhL6SQd2KGD2zdd38d3vBoNDI7Qw9zD2kqX+j222HCXSw7TbhPCitK2KAeU/t
	 9OxH9bYLpVLrxo5eXLcwSBRrFgx2c2XFmDDbSCUQSXK4qQQlEVj2sgXh9dRG9AOgdT
	 cQlmvV/3UbMiYvIZ8VzkB7YFxIF8/f9b3kqwjo+UuOVrMx/1BYX7XNz5Q7CXLsUI+I
	 7rF40gc+8GlUQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2 2/4] perf symbol: Add missing symsrc__destroy() for libbfd
Date: Sun, 11 Oct 2026 22:30:11 -0700
Message-ID: <20261012053013.14378-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012053013.14378-1-namhyung@kernel.org>
References: <20261012053013.14378-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When libbfd loaded symbols and there's a pending syms_ss, it'd be lost
or overwrite existing symbols.  Let's destroy it before breaking the
loop so that it can safely return from the function.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/sashiko-outbox-162540@kernel.org
Fixes: eac9a4342e5447cad ("perf symbols: Try reading the symbol table with libbfd")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a394e742f9b18812..55a4b59195a08be5 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1932,7 +1932,7 @@ int dso__load(struct dso *dso, struct map *map)
 
 		if (bfdrc > 0) {
 			ret = 1;
-			break;
+			goto out_destroy;
 		}
 
 		if (!is_reg || sirc < 0)
@@ -1997,6 +1997,7 @@ int dso__load(struct dso *dso, struct map *map)
 			ret += nr_plt;
 	}
 
+out_destroy:
 	for (; ss_pos > 0; ss_pos--)
 		symsrc__destroy(&ss_[ss_pos - 1]);
 out_free:
-- 
2.55.0

