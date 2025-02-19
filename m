Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04D820F082
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Feb 2025 21:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740002113; cv=none; b=gTtqFJi38a1uByHMZCBGA4sXZCMpdAUUwV0A06c+AQeKVC1yMr0Sn1dYDq4j4WQfUKDBBw0BmvjWGgFedz1dWaDI+F1pzB3Hym86d3HKMbUi0WyEsGXmFlyZw6Vjd0ig/76/Owd1QfZMGO9yQXDxOVfAL4LbljbIfM+3/vmJjxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740002113; c=relaxed/simple;
	bh=qhE1DZk5+4EZUnpu7E62OwtQ+FM8uq/hSJxUyaLtFBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AC97NXUl/bSuY+Qhw4mNqXzyf4jeJpkOCXvqHul0RYa+FML19U/G5vXwvEi2ZyS/1IRwhwVK7h3XUcacmv4oB9OmrP5mYzI/eornT6OvEVX9oG2qVmL1j4QbQELJA48lkOrbD5OmKKXKvd8BhEZf042xINvxpQIdCkw9A90f8aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hSzivIOr; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hSzivIOr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740002112; x=1771538112;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qhE1DZk5+4EZUnpu7E62OwtQ+FM8uq/hSJxUyaLtFBA=;
  b=hSzivIOrBLsZx0ZnyD4pOxZu4Evgwng+eatWwh0FbZd3EbrsLo88Aykl
   o4vBv/AjUB/IilAb4S7DZ7juptoBddMKZ2COf9UPS2zDGRvSwA4gHZ2EB
   Sx02OdrzxHRlPLv5UUs1My4YoGHCrjoMd0mDmdbaED6wWMEVe8lDMhqJl
   JhquUhLfqqQ3lOu9R6gcXmvIdXzuBCEIcsQKIB73FBoQLAgP4bUGnpBLR
   BGfye7KbgKo0TIMuIvlnsnXwJkZim+q9ND+WobGLJ/e77eBfWWosht0yZ
   IX5bzguZycsxoqkL6Q1XZONLr6aZlmCPaU7nyBM7OVbZ0qfQaDl3o2NDn
   g==;
X-CSE-ConnectionGUID: epuB3uVHThO8dQHwyepqMA==
X-CSE-MsgGUID: n9BratMGQMaEbZmPKCKS4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40474823"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="40474823"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 13:55:11 -0800
X-CSE-ConnectionGUID: +8Tbhd5lQnSsTgRNxffiyQ==
X-CSE-MsgGUID: QC/5uP68T7yHCEiKJaFloQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115743642"
Received: from uaeoff-desk2.amr.corp.intel.com (HELO tfalcon-desk.intel.com) ([10.124.221.160])
  by orviesa008.jf.intel.com with ESMTP; 19 Feb 2025 13:53:20 -0800
From: Thomas Falcon <thomas.falcon@intel.com>
To: linux-perf-users@vger.kernel.org
Cc: Thomas Falcon <thomas.falcon@intel.com>
Subject: [PATCH] perf report: Fix sample number stats for branch entry mode
Date: Wed, 19 Feb 2025 15:53:17 -0600
Message-ID: <20250219215317.82905-1-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, stats->nr_samples is incremented per entry in the sample's
branch stack instead of per sample taken. As a result, statistics of
samples taken during perf record in --branch-filter mode do not seem
correct. Call hists__inc_nr_samples() only for each sample taken.

Before:

$ ./perf record -e cycles:u -b -c 10000000000 ./tchain_edit
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.005 MB perf.data (2 samples) ]
$ perf report -D | tail -n 16
Aggregated stats:
               TOTAL events:         16
                COMM events:          2  (12.5%)
                EXIT events:          1  ( 6.2%)
              SAMPLE events:          2  (12.5%)
               MMAP2 events:          2  (12.5%)
             KSYMBOL events:          1  ( 6.2%)
      FINISHED_ROUND events:          1  ( 6.2%)
            ID_INDEX events:          1  ( 6.2%)
          THREAD_MAP events:          1  ( 6.2%)
             CPU_MAP events:          1  ( 6.2%)
        EVENT_UPDATE events:          2  (12.5%)
           TIME_CONV events:          1  ( 6.2%)
       FINISHED_INIT events:          1  ( 6.2%)
cpu_core/cycles/u stats:
              SAMPLE events:         64

After:

$ ./perf report -D | tail -n 16
Aggregated stats:
               TOTAL events:         16
                COMM events:          2  (12.5%)
                EXIT events:          1  ( 6.2%)
              SAMPLE events:          2  (12.5%)
               MMAP2 events:          2  (12.5%)
             KSYMBOL events:          1  ( 6.2%)
      FINISHED_ROUND events:          1  ( 6.2%)
            ID_INDEX events:          1  ( 6.2%)
          THREAD_MAP events:          1  ( 6.2%)
             CPU_MAP events:          1  ( 6.2%)
        EVENT_UPDATE events:          2  (12.5%)
           TIME_CONV events:          1  ( 6.2%)
       FINISHED_INIT events:          1  ( 6.2%)
cpu_core/cycles/u stats:
              SAMPLE events:          2

Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/util/hist.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 0f30f843c566..4ae56a2a4d34 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -975,8 +975,6 @@ iter_add_next_branch_entry(struct hist_entry_iter *iter, struct addr_location *a
 	if (he == NULL)
 		return -ENOMEM;
 
-	hists__inc_nr_samples(hists, he->filtered);
-
 out:
 	iter->he = he;
 	iter->curr++;
@@ -995,9 +993,14 @@ static int
 iter_finish_branch_entry(struct hist_entry_iter *iter,
 			 struct addr_location *al __maybe_unused)
 {
+	struct evsel *evsel = iter->evsel;
+	struct hists *hists = evsel__hists(evsel);
+
 	for (int i = 0; i < iter->total; i++)
 		branch_info__exit(&iter->bi[i]);
 
+	hists__inc_nr_samples(hists, iter->he->filtered);
+
 	zfree(&iter->bi);
 	iter->he = NULL;
 
-- 
2.48.1

