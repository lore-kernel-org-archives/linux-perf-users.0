Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D79EC07E95
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 15:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28E6461175
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 15:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbhGMPnY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jul 2021 11:43:24 -0400
Received: from foss.arm.com ([217.140.110.172]:45528 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236932AbhGMPnX (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jul 2021 11:43:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 614DC6D;
        Tue, 13 Jul 2021 08:40:33 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.35.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1B64F3F774;
        Tue, 13 Jul 2021 08:40:28 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, leo.yan@linaro.org
Cc:     al.grant@arm.com, branislav.rankov@arm.com, suzuki.poulose@arm.com,
        anshuman.khandual@arm.com, James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] perf cs-etm: Support TRBE (unformatted decoding)
Date:   Tue, 13 Jul 2021 16:40:02 +0100
Message-Id: <20210713154008.29656-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patchset consists of refactoring to allow the decoder to be
created in advance when the AUX records are iterated over. The
AUX record flags are used to communicate whether the data is
formatted or not which is the reason this refactoring is required.

These changes result in some simplifications, removal of early exit
conditions etc.

A change was also made to --dump-raw-trace code to allow the
formatted/unformatted status to persist and for the decoder to
not be continually deleted and recreated.

The changes apply on top of the previous patchset "[PATCH v7 0/2] perf
cs-etm: Split Coresight decode by aux records".

James Clark (6):
  perf cs-etm: Refactor initialisation of kernel start address
  perf cs-etm: Split setup and timestamp search functions
  perf cs-etm: Only setup queues when they are modified
  perf cs-etm: Suppress printing when resetting decoder
  perf cs-etm: Use existing decoder instead of resetting it
  perf cs-etm: Pass unformatted flag to decoder

 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  10 +-
 tools/perf/util/cs-etm.c                      | 174 ++++++++----------
 2 files changed, 84 insertions(+), 100 deletions(-)

-- 
2.28.0

