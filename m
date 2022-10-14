Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818F3C433FE
	for <linux-perf-users@archiver.kernel.org>; Fri, 14 Oct 2022 17:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJNRJa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 14 Oct 2022 13:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiJNRJ3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 14 Oct 2022 13:09:29 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17E5CC834;
        Fri, 14 Oct 2022 10:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665767368; x=1697303368;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EowE/WYIM33IXc3RRSzpTiUcTLJHWnpccOlWK9V+Ju0=;
  b=YLQFLgjOHTvuJNqZa4iMHCUS1kwHRBf5x54faQLl4Vxve/Y6x4Dh/dWe
   9sYRIRgv/ETZXAxrf8EynEBzCeAau/dMG6QQIGdfON6tjDKusz7s2/6iN
   VjCfzafvQsGh+VkKQqOJRKoNFPCEo9qNHIEQPeKnufQ9VKlZMZdYzii2G
   axcu9BDUpLwPp+nGqavm/odtKxzYXLeN0cqDR5SwAxkuqi4fNPtv3BqRJ
   0gDCujba4TwRFFHLvOQWq/IRwLIoPjJETx8uHjqj2cSMI2+9pzuTIh/Ub
   fjR6+t7Yrai7pU2kJLXGFZhV88wIy/4Az0FJlj98kb6NkUgEmJxiwZ3Qs
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="303041961"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="303041961"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 10:09:28 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="696376895"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="696376895"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.43.79])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 10:09:26 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 0/7] perf intel-pt: jitdump fix and test
Date:   Fri, 14 Oct 2022 20:08:58 +0300
Message-Id: <20221014170905.64069-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi

Here is a fix for perf inject --jit (patch 6) and an Intel PT test
(patch 5) that fails unless the fix is applied.

There is also another small fix, some tidy-ups and other new tests for the
shell test test_intel_pt.sh.


Adrian Hunter (6):
      perf test: test_intel_pt.sh: Fix return checking again
      perf test: test_intel_pt.sh: Tidy some perf record options
      perf test: test_intel_pt.sh: Print a message when skipping kernel tracing
      perf test: test_intel_pt.sh: Tidy some alignment
      perf test: test_intel_pt.sh: Add jitdump test
      perf inject: Fix GEN_ELF_TEXT_OFFSET for jit

Ammy Yi (1):
      perf test: test_intel_pt.sh: Add 9 tests

 tools/perf/tests/shell/test_intel_pt.sh | 385 +++++++++++++++++++++++++++++++-
 tools/perf/util/genelf.h                |   4 +-
 2 files changed, 380 insertions(+), 9 deletions(-)


Regards
Adrian
