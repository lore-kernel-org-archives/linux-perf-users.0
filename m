Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6644C37FF71;
	Sun,  2 Aug 2026 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785680608; cv=none; b=U2w/psyBiRbzLPwEPfJgffq1vVQIh2+QPOyvRKgzpPzQiX3NS2H5MKBgXFX+/sL8HOFWbcZUcF5A2PAAxt5NouprTS0n+I2wW3rfcG4qBn+ScW3m97gioT+Uw2hGD+Btl+O7E3jo0vJnlHvry7V0bhbHlxmTSLzmuNAvChUwDh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785680608; c=relaxed/simple;
	bh=1gAT514GSEtYiZXNluCJq82MAwWTRcXL+0J2fOWd+Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AOgq/tmLJs9abq5hVkROlSg7ZEtSk/MssUJyx64yOCxjFw41LggA/VJ+gcGHKfcbxLDf+FZLL1bfleW1eFUVM/crKuN6nzYcSeH0xy0BiPnzjJ1WdCrMwgW09xgr1nJBr6q6zkDu3dy4aPe2T8eWciLZ9xKRwTsMURahMRJSKVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6Jymj36; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6Jymj36"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28681F000E9;
	Sun,  2 Aug 2026 14:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785680607;
	bh=fDW19Tqz4qal6ir1yfqyi+RJe5vNRrZNRNdTxB0/pcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f6Jymj36+RtKkdS9WGJzpqJ09VLqJEW8Xa8Z3zXtPY01rumkwKdzO6jH6ioUSbzJv
	 WnjQzVoC/wwkx/Fzwo6nifQudiK8BcHgnITqBqSkh3x5sXKS4BEm2J0hloVzZEzUDb
	 9bYwj/OS2dhVTxSu2p1DCbYTqAQARM4Qq8z9F4lzo1sQ++Di9yT+YqUOC/fQCGWUrM
	 7fwgzrIzOPG6bS0SzXEseLE/5LlujstWIz/71GzY/c+BM1jm6qZBbO5SFbgb8xt5xd
	 HM/hYInmVuZvqHJ4TXyYOMivH6dRyFVqEar1ZlGev9uVRkBXppmLR6aRiM/uvELrTB
	 WBIB6cWyJfxHA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH 2/2] perf c2c: Clean up registered formats on c2c_hists__init() failure
Date: Sun,  2 Aug 2026 11:23:13 -0300
Message-ID: <20260802142313.154514-3-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802142313.154514-1-acme@kernel.org>
References: <20260802142313.154514-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When c2c_hists__init() calls hpp_list__parse() and it fails partway
through, format structures registered via perf_hpp_list__column_register()
and perf_hpp_list__register_sort_field() are left on the hpp_list.  The
c2c_he__alloc_hists() caller handles this with
perf_hpp__reset_output_field(),
but perf_c2c_report() does not, leaking the partially registered entries.

Fix by adding cleanup inside c2c_hists__init() itself, so all callers
are protected.

Fixes: 78b275437873 ("perf c2c report: Add sample processing")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 332d360ca533424b..84f0f0ba56131b7b 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2132,6 +2132,8 @@ static int c2c_hists__init(struct c2c_hists *hists,
 			   int nr_header_lines,
 			   struct perf_env *env)
 {
+	int ret;
+
 	__hists__init(&hists->hists, &hists->list);
 
 	/*
@@ -2144,7 +2146,13 @@ static int c2c_hists__init(struct c2c_hists *hists,
 	/* Overload number of header lines.*/
 	hists->list.nr_header_lines = nr_header_lines;
 
-	return hpp_list__parse(&hists->list, /*output=*/NULL, sort, env);
+	ret = hpp_list__parse(&hists->list, /*output=*/NULL, sort, env);
+
+	/* Unregister any formats added before the failure point */
+	if (ret)
+		perf_hpp__reset_output_field(&hists->list);
+
+	return ret;
 }
 
 static int c2c_hists__reinit(struct c2c_hists *c2c_hists,
-- 
2.55.0

