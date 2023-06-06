Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038D7C77B7A
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Jun 2023 20:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237463AbjFFUYw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Jun 2023 16:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239348AbjFFUYv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Jun 2023 16:24:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A24A1A7;
        Tue,  6 Jun 2023 13:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686083090; x=1717619090;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JTSfzp4d5BayGS+yELJc8KP9I7Woge+Z1oHfJzhTnHg=;
  b=g2o2be6hMpOvQTGgV3SxsNjpYRx0/Or/SqtC1DIXl0IG+JQgMr023lNF
   2gWhcovlPsJXwY3i6dMUdFV9aGbsYLzuxUD9Bl+WfsytiYpev7ALkohRK
   PYNmrEckO/lExuAiSnuVk2a4JGDb5bfYS7S34LSNHDGdh5p3JbD6+2P5F
   gABN9gQXxnCSuWf3pgaQrQP17sreLfSw2fhQRmpRNY1WlyXVNLUBcCW3Q
   W5hUy5gwp5cxfgBiGdRFCxXpbzsD67RVcZGzqPHSz1QnPa+pmte/IOJk/
   KwuXYcyte65bf00+eVrM2xMlxCuhRNpPj9oC8yqLq4bMc34FD/uCOD/5c
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="422631143"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="422631143"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 13:24:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="821808446"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="821808446"
Received: from a0cec87da3f2.jf.intel.com (HELO worker-node-1.jf.intel.com) ([10.165.55.163])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jun 2023 13:24:47 -0700
From:   Weilin Wang <weilin.wang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Weilin Wang <weilin.wang@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, Alt@vger.kernel.org,
        Samantha <samantha.alt@intel.com>, Taylor@vger.kernel.org,
        Perry <perry.taylor@intel.com>, Biggers@vger.kernel.org,
        Caleb <caleb.biggers@intel.com>
Subject: [PATCH v1 0/3] Add metric value validation test
Date:   Tue,  6 Jun 2023 13:24:18 -0700
Message-Id: <20230606202421.2628401-1-weilin.wang@intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This series introduces metric value validation tests.

Weilin Wang (3):
  perf test: Add metric value validation test
  perf test: Add allow list for metrics known would fail
  perf test: Rerun failed metrics with longer workload

 .../tests/shell/lib/perf_metric_validation.py | 574 ++++++++++++++++++
 .../lib/perf_metric_validation_rules.json     | 398 ++++++++++++
 tools/perf/tests/shell/stat_metrics_values.sh |  19 +
 3 files changed, 991 insertions(+)
 create mode 100644 tools/perf/tests/shell/lib/perf_metric_validation.py
 create mode 100644 tools/perf/tests/shell/lib/perf_metric_validation_rules.json
 create mode 100755 tools/perf/tests/shell/stat_metrics_values.sh


base-commit: 7cdda6998ee55140e64894e25048df7157344fc9
-- 
2.39.1

