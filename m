Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BE91DE896;
	Thu, 20 Feb 2025 04:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740027590; cv=none; b=rgtHilNHs/Ip7SM6Okw/6zr7hMhqSdDXpajfAR/uAg9HQmcI9yEiMTGR0oroKS4hcRIyLNjPccVODtC5Qvs8o0LgO1asgwz9XhnD0DfTh31pVrkuupcnYpuUZ7Zugh0QSCqKIjCvBquQJ23zOgboAy6XkeHPkmMC8rb7wPhcN3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740027590; c=relaxed/simple;
	bh=RJQx1TQsW4oe1mAZxc9kz7BuGU4BEzzNBWjUCEpfjQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gE3xyjyegh+j5xV68/XhbShtPNKesUSgfg0NGa8HNsb5o6nDO4nMOJqy1LtCYldtd6DwdAnkEFgjpazLGZVvfddsV5Tto4Dtt3+Nr0TVxpOtS+kFD5O6h356+wH6OZo+Gbzhk1F+K7tYVbbwDHlaLqWwjuwfOyW2wdL6I4QZ2oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=At2UVBQf; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="At2UVBQf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740027589; x=1771563589;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RJQx1TQsW4oe1mAZxc9kz7BuGU4BEzzNBWjUCEpfjQY=;
  b=At2UVBQfZnf/gZ6mYN/jzTAOHEtx7m9tyqWAuuQD09nivADGXZVuvIz4
   /B3YmGsmYibGij6k3rHWu8zeUeL8pNsSN2L7X41nuvzpGgm4rNAO1bYWm
   fPg/UqezKs5ijLjh+gGqPVrkBrzDa0o5/G/AJH8JWNDG10sAn4xtoOEur
   ibgE0z+b3U94cKhupIsKZUFu8Qjdhm7tr7jKfs4W4f9srw6uRphqmgfHW
   U6t1ZJpuLDKvKxSw02QG3le/tt7O30I+tCIsxND42roHBOXS/UQOouadg
   fgPqZQNHAKqiaVYqQ3/Nmt3epanGMai5IPvongl0Ia2UodFaBBQ1t4JLo
   w==;
X-CSE-ConnectionGUID: ftV546HkT3Wx4GrvU/TRsA==
X-CSE-MsgGUID: h1+vHqAySd+xztcJncqCDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="63269533"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="63269533"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 20:59:48 -0800
X-CSE-ConnectionGUID: 9Nz78VIhR12bXtR8xs/Jjg==
X-CSE-MsgGUID: Jr50bj5rS26mmsuhF5IP0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="114657347"
Received: from tfalcon-desk.amr.corp.intel.com (HELO tfalcon-desk.intel.com) ([10.124.221.160])
  by orviesa009.jf.intel.com with ESMTP; 19 Feb 2025 20:59:46 -0800
From: Thomas Falcon <thomas.falcon@intel.com>
To: linux-perf-users@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Thomas Falcon <thomas.falcon@intel.com>
Subject: [PATCH v2] perf report: Fix sample number stats for branch entry mode
Date: Wed, 19 Feb 2025 22:59:42 -0600
Message-ID: <20250220045942.114965-1-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, stats->nr_samples is incremented per entry in the branch stack
instead of per sample taken. As a result, statistics of samples taken
during perf record in --branch-filter or --branch-any mode does not
seem correct. Instead call hists__inc_nr_samples() for each sample taken
instead of for each entry in the branch stack.

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
v2: Missed null check for iter->he in iter_finish_branch_entry().
---
 tools/perf/util/hist.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 0f30f843c566..60b584218fa7 100644
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
@@ -995,9 +993,15 @@ static int
 iter_finish_branch_entry(struct hist_entry_iter *iter,
 			 struct addr_location *al __maybe_unused)
 {
+	struct evsel *evsel = iter->evsel;
+	struct hists *hists = evsel__hists(evsel);
+
 	for (int i = 0; i < iter->total; i++)
 		branch_info__exit(&iter->bi[i]);
 
+	if (iter->he)
+		hists__inc_nr_samples(hists, iter->he->filtered);
+
 	zfree(&iter->bi);
 	iter->he = NULL;
 
-- 
2.48.1

