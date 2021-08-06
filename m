Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA7EC4338F
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 13:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A117161104
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 13:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbhHFNle (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 6 Aug 2021 09:41:34 -0400
Received: from foss.arm.com ([217.140.110.172]:32956 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232817AbhHFNld (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Aug 2021 09:41:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D08F31B;
        Fri,  6 Aug 2021 06:41:17 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.40.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BA7E23F40C;
        Fri,  6 Aug 2021 06:41:14 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     mathieu.poirier@linaro.org, leo.yan@linaro.org,
        coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
        mike.leach@linaro.org
Cc:     acme@kernel.org, suzuki.poulose@arm.com,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/9] Support ETE decoding
Date:   Fri,  6 Aug 2021 14:41:00 +0100
Message-Id: <20210806134109.1182235-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Changes since v1:
 * Re-implement with a new magic number instead of piggybacking on ETMv4
 * Improve comments and function name around cs_etm_decoder__get_etmv4_arch_ver()
 * Add a warning for unrecognised magic numbers
 * Split typo fix into new commit
 * Add Leo's reviewed-by tags
 * Create a new struct for ETE config (cs_ete_trace_params) instead of re-using ETMv4 config

Applies to perf/core f3c33cbd922
Also available at https://gitlab.arm.com/linux-arm/linux-jc/-/tree/james-ete-v2

James Clark (9):
  perf cs-etm: Refactor initialisation of decoder params.
  perf cs-etm: Initialise architecture based on TRCIDR1
  perf cs-etm: Refactor out ETMv4 header saving
  perf cs-etm: Save TRCDEVARCH register
  perf cs-etm: Fix typo
  perf cs-etm: Update OpenCSD decoder for ETE
  perf cs-etm: Create ETE decoder
  perf cs-etm: Print the decoder name
  perf cs-etm: Show a warning for an unknown magic number

 tools/build/feature/test-libopencsd.c         |   4 +-
 tools/perf/arch/arm/util/cs-etm.c             |  97 ++++++++----
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 148 ++++++++----------
 .../perf/util/cs-etm-decoder/cs-etm-decoder.h |  13 ++
 tools/perf/util/cs-etm.c                      |  43 ++++-
 tools/perf/util/cs-etm.h                      |  10 ++
 6 files changed, 200 insertions(+), 115 deletions(-)

-- 
2.28.0

