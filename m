Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88CA3AFCEE;
	Mon,  6 Jul 2026 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783360669; cv=none; b=L1HnlnaPht2cpDUu/ZkQhu8Tk2F6kU6cfKaq4kg5vLUgONHysUHOmJPJT93QedyeL2LE4KT6afECu1H8sn7UpYLsFiglRrVfC4sMNSHYvo2BZSc05qKyFBHKYhZuhaPnweA6xeyWfNvKQzTOrJaHtXEc6Bst1QVHYoGC5wQE0bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783360669; c=relaxed/simple;
	bh=ytUcn7C/9v9104eYJgf4N2jL/BuhHVWLXSPtIsk7WbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ncil0OuQBIKDBUKhvPAebULarrp2U+5Vf3lst59TzuysOmXoarzJFomG9vEy5nphBn9Z0tE4eHm96MYiNF9KfyVA/4LH7DlsIG/NWOglDOtX5nw4e93v/IF2O7NdEBHXhTqIVEcJI1WpLLq/fmjJdaWxFGmE95fO/H5r1VDt4GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=wdE81OGa; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="wdE81OGa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:
	References; bh=bVv//fo/WN5vyhT+kxelx4GNnfpfjo5yAQlsHXm2UOU=; b=wdE81OGaT374Mo
	aCXOlXtbGd6MFdk2aBrC85F8x7SaLkqf7iGbg097ixWzTriM8+8lLtGmRcqTNW+BGlNfDAOEehjHQ
	qNgAu4/NUK8ImyjUxWPjaruRCEirUsNsQQW5bMDI3YGOlrCWyD+XfP+7fvg7E22QHgWks07uMFOtO
	8bKO6c+4wdqXhpdKfVz0FjcT3UNIkxlwgXL+fswmk3cp+ferdXzRrzJbk/aqfKFk8MoZK2W0H8tKT
	CFACW0a/t16BtuseGU3stzpE3r5ryTJ/y3caRMVZVZTj+CIxVgZL5i5FB8iF5C2UWnwamih/sFY5m
	LoIz/F4fmiQGF450b2Aw==;
Received: from [167.98.27.226] (helo=nazar-ct.office.codethink.co.uk)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1wgnZT-00Gmas-A6; Mon, 06 Jul 2026 18:57:31 +0100
From: Nazar Kazakov <nazar.kazakov@codethink.co.uk>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>,
	Nazar Kazakov <nazar.kazakov@codethink.co.uk>
Subject: [PATCH] perf jevents: make events order more deterministic
Date: Mon,  6 Jul 2026 18:56:24 +0100
Message-ID: <20260706175624.692736-1-nazar.kazakov@codethink.co.uk>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: nazar.kazakov@codethink.co.uk

Some of the events have the same name, but differing descriptions. This
leads to a non-deterministic sorting order, so fix by adding the
description field to the order.

Signed-off-by: Nazar Kazakov <nazar.kazakov@codethink.co.uk>
---
 tools/perf/pmu-events/metric.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index a91ccb5977f0..b3ab78a0ecb2 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -623,7 +623,7 @@ class Metric:
 
   def __lt__(self, other):
     """Sort order."""
-    return self.name < other.name
+    return self.name < other.name or self.description < other.description
 
   def AddToMetricGroup(self, group):
     """Callback used when being added to a MetricGroup."""
-- 
2.54.0

