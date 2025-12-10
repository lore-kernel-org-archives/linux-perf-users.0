Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C479226F297;
	Wed, 10 Dec 2025 02:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765334020; cv=none; b=PqpDCENvjAzkdLr4PQblIB2vHIUCxT4OJow04yBK9NjmkmEubKn/CdnMQa4YetYSpumVorwBt9MnKG2XgvN8EzzyMQAoBW+DX2yrn4TFHXKGU/y+qIPf3glgNaQU1q61Su33g8393wl5YRtjzOX3S48eqMGs8BbYgqEYIU6uPXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765334020; c=relaxed/simple;
	bh=qnB9/p0M/ybVVFnns5vMIEoYgDXhamMDqNhALztsF3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oe2gIFTkXDw88pr7EHOEbyq5odO4yhxTHVg5K9PZSH0RBGFnIwEHS6C/FLi9OGwJ4pmvEc6jD3tHz0NLhIUcjJUeRiL/utLJdjt8bM+b/lU4wZzMyta/1S3orOgTx8MIUS7CxAFn7UoJapiIqb90pmJTOevwx5kj2KMW1Zy1h8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qm8S1VIF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qm8S1VIF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220F0C19422;
	Wed, 10 Dec 2025 02:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765334020;
	bh=qnB9/p0M/ybVVFnns5vMIEoYgDXhamMDqNhALztsF3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qm8S1VIFMk+NDEVW2N/w04nv8/TOkIC7nYVB5ld3U9hOz79Q97D0AGtEntDCPWKXY
	 OGO8kt4O+GRcVU31sM41322mtUqhIBdzvEZstjCeDZWdffrACe2pDIYieiwlppTf/C
	 UP7ht56hOuAmPMcdSf8MIgCUR7FszTWSwQ2QI7Fhh0AHLO9sTDd6f/HXNeIyegQf+d
	 ohNxyztP4O6EOH7RgXKjW27+AZW7s+whLC2BvFiTM/YVnfb5jRnDIDb8Hq0qYi4ZEn
	 HaDymjVtI0b6e1E2i3JLd/7n7J7Bo5pwZR7xlt3AmjgzDgD5cEOA26CKCKNgIqBDfZ
	 uuSz2hxC5IUZg==
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
Subject: [PATCH 2/4] perf report: Enable data-type profiling with -F option too
Date: Tue,  9 Dec 2025 18:33:25 -0800
Message-ID: <20251210023327.1669863-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
In-Reply-To: <20251210023327.1669863-1-namhyung@kernel.org>
References: <20251210023327.1669863-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It checked -s/--sort options only.  As the sort keys can be setup using
the -F/--fields option as well, it should enable data-type profiling
with it too.

The following two commands should have the same output.

  $ perf report -s type

  $ perf report -F overhead,type

But there's another problem on this.  I'll handle it in the next commit.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-report.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index add6b1c2aaf04270..6c2b4f93ec78e579 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1727,7 +1727,8 @@ int cmd_report(int argc, const char **argv)
 			sort_order = NULL;
 	}
 
-	if (sort_order && strstr(sort_order, "type")) {
+	if ((sort_order && strstr(sort_order, "type")) ||
+	    (field_order && strstr(field_order, "type"))) {
 		report.data_type = true;
 		annotate_opts.annotate_src = false;
 
-- 
2.52.0.223.gf5cc29aaa4-goog

