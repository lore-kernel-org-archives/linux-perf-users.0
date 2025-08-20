Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC45341667;
	Wed, 20 Aug 2025 17:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755710633; cv=none; b=Jr7TQ2cUoXgHX95jw0maOOLLk1J6ejb2vC8pZfNnYJKlsrZ5rlLlj15b6ikf/+M3niHgUwOb8wD/vgbEZ5Q6cbqT82MMPfFxZYihrvk8OsfaqrEzvI8cuEK6v+WPB89HPP+9/tVJXkd676CjeTKcegRsD+Flu4ytctRPNC6d/hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755710633; c=relaxed/simple;
	bh=/03dgkBvv5oPv0wNVSIarGhRbX5wiLgST2mS5jll5Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SsTCkIrHGds3RNjSleIxi/x4N7OEur/lL0nbmrOGI6Pnn/gcdzkwd0DSimT+g0TPG8U9R/pJHG+1z+qjJoPOsqBnARbsSQghDt5Bkc7OJO1Gc1A0eMYDAxsECFBuf3H+u7eNGFQJmWogGQ0a8W+hLqkN8rvT44y8ArfnN6zZJdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQm5gESB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQm5gESB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B05C4CEE7;
	Wed, 20 Aug 2025 17:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755710633;
	bh=/03dgkBvv5oPv0wNVSIarGhRbX5wiLgST2mS5jll5Mw=;
	h=Date:From:To:Cc:Subject:From;
	b=VQm5gESBG5RVfr+2AxatPxDnIWWh4PwGIa/IZPIHlwh3+TK6QYPji5GVe+MIwHLNU
	 R06WiHBGXZu1eyKRCIQ20FeBRAiqa0lphjNf6l5LQs32OpubSGqk1VHWWtl1DupEwy
	 wVaTFUNK6VhaY3plBUnm97/yFXl30HyKWPcq1spbf8DsEa+/oRpSAEuHfnAEzK6KWd
	 kegTUjW+LeeDqERnZk1zNvH2PT+CZrZ68+PO/W5JcPEbRgdChY4Dwv/9a0imk8sfDn
	 ldhQwSlOVrAIfuPoPmVUyj27sMLV24TWWxnkNoLIHP1TcePWAHDwBkX5MrKW1RyUVV
	 +qZKIJWY+SIkg==
Date: Wed, 20 Aug 2025 14:23:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>, Dmitry Vyukov <dvyukov@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] Revert "perf hist: Fix bogus profiles when filters are
 enabled"
Message-ID: <aKYEpf7xp3NnkBWm@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This reverts commit 8b4799e4f0f40a4ec737bf870aa38d06288bf0fb.

Not combining entries in 'perf top', so we're getting multiple lines for
the same symbol, with the same address.

To test it, simply run 'perf top', then do /acpi to see just symbols
starting with acpi_ and notice that there are various lines with the
same symbol, press V to see the address and its the same.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 64ff427040c34112..f3f64aff9b882303 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1391,16 +1391,7 @@ hist_entry__cmp_impl(struct perf_hpp_list *hpp_list, struct hist_entry *left,
 	struct hists *hists = left->hists;
 	struct perf_hpp_fmt *fmt;
 	perf_hpp_fmt_cmp_t *fn;
-	int64_t cmp;
-
-	/*
-	 * Never collapse filtered and non-filtered entries.
-	 * Note this is not the same as having an extra (invisible) fmt
-	 * that corresponds to the filtered status.
-	 */
-	cmp = (int64_t)!!left->filtered - (int64_t)!!right->filtered;
-	if (cmp)
-		return cmp;
+	int64_t cmp = 0;
 
 	perf_hpp_list__for_each_sort_list(hpp_list, fmt) {
 		if (ignore_dynamic && perf_hpp__is_dynamic_entry(fmt) &&
-- 
2.50.1

