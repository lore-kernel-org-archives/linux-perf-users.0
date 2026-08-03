Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5012D8385;
	Mon,  3 Aug 2026 01:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785719515; cv=none; b=iMu9/i9+1lOV2Rg/tnYgxFFdsy4N3b2l4WvsAGnHvUJlquiWdk7hosCUyDuknvZIo0JcFtoSnBbmtiiyy+PRtr1S9c0m1O+lcpFavnVFpbXSFsafpactI+lkPNCHiVUWR4OZCfI7Zc2HQBN29M1h9GmD4jkPojjq3WkYDj/iiy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785719515; c=relaxed/simple;
	bh=I3/+4upVeqL/IgnzYhvhhFAkUQNlR840yF7ej3qujNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=av/V4otSULgMJQ7drMDuDWHubMmNpTCCoBd8YZHY4+UzulZ62+RVenMiD7J6E+kZsjHiH1fiyGjbYMtJ4mq1jKikWVEJ4aXXBfM7CA01JvN6pgKEyJpNAw0nR2O0WiVDpjoEVLtyyW/bHnsrFEof/Lenv/McC04ZlVt5hsOblns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clQvI5wP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clQvI5wP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DCD1F000E9;
	Mon,  3 Aug 2026 01:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785719514;
	bh=iBTAdqnyic/plxCO+GjAFBJ8z9lhqDZNFuzWAHGOAUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=clQvI5wPqujxtE+Tv05CkKOrrFdC0wBbumDE6LUPFYtwIka5n4wiGoITO0n5lDMHn
	 dHLsHItIKEPXz9SDbh0UBli0tmkJ4TuHOUUhgb84FPANV9xLxzD7ntgXeQqfU6Ivha
	 QwLfec0y9hr00VAjr87LJX9OeLlhSQCgnBQz7Mmfq6H7qfIlxt3fI3Zyfeq+dSc7UJ
	 0+wXAudZ5TgGe70sT57QsCFk+CKugzyP1/hhwjGAe43ZGL7grlwhH/l7HqHo70ChNW
	 q3Hvxp0PLtYimoJu2ks1YNE7Tc6SYhfk8gNkzlEe4B2aW91I4/FHORKRBHWu2x/Zaa
	 k9hkmzkgOGwwA==
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
Date: Sun,  2 Aug 2026 22:11:40 -0300
Message-ID: <20260803011140.179943-3-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803011140.179943-1-acme@kernel.org>
References: <20260803011140.179943-1-acme@kernel.org>
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
index df07e97155df2584..9b59197f01aa642c 100644
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

