Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D82EC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 11:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8785A61139
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 11:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240829AbhJGLHy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Oct 2021 07:07:54 -0400
Received: from foss.arm.com ([217.140.110.172]:45822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240692AbhJGLHy (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Oct 2021 07:07:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D8E56D;
        Thu,  7 Oct 2021 04:06:00 -0700 (PDT)
Received: from e121896.Emea.Arm.com (e121896.Emea.Arm.com [10.32.36.22])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 727533F70D;
        Thu,  7 Oct 2021 04:05:56 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, john.garry@huawei.com, ak@linux.intel.com,
        linux-perf-users@vger.kernel.org
Cc:     Nick.Forrington@arm.com, Andrew.Kilroy@arm.com,
        James Clark <james.clark@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] perf tools: Enable strict JSON parsing
Date:   Thu,  7 Oct 2021 12:05:39 +0100
Message-Id: <20211007110543.564963-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

After a discussion on "[PATCH 1/4] perf vendor events: Syntax corrections in Neoverse N1 json",
John Garry suggested that we can just modify the parser to make it more strict. Hopefully this will
remove the need to apply any future JSON comma fixup commits.

Applies on top of "[PATCH v2 1/3] perf vendor events: Syntax corrections in Neoverse N1 json" on
perf/core.

Also available at:
  git clone --branch james-json-parse-fix git@git.gitlab.arm.com:linux-arm/linux-jc.git

James Clark (3):
  perf vendor-events: Fix all remaining invalid JSON files
  perf tools: Make the JSON parser more conformant when in strict mode
  perf tools: Enable strict JSON parsing

 .../arch/arm64/ampere/emag/bus.json           |  2 +-
 .../arch/arm64/ampere/emag/cache.json         | 20 ++++-----
 .../arch/arm64/ampere/emag/clock.json         |  2 +-
 .../arch/arm64/ampere/emag/exception.json     |  4 +-
 .../arch/arm64/ampere/emag/instruction.json   | 10 ++---
 .../arch/arm64/ampere/emag/memory.json        |  4 +-
 .../arch/arm64/hisilicon/hip08/metrics.json   |  2 +-
 .../pmu-events/arch/nds32/n13/atcpmu.json     |  2 +-
 .../pmu-events/arch/s390/cf_z10/basic.json    |  2 +-
 .../pmu-events/arch/s390/cf_z10/crypto.json   |  2 +-
 .../pmu-events/arch/s390/cf_z10/extended.json |  2 +-
 .../pmu-events/arch/s390/cf_z13/basic.json    |  2 +-
 .../pmu-events/arch/s390/cf_z13/crypto.json   |  2 +-
 .../pmu-events/arch/s390/cf_z13/extended.json |  2 +-
 .../pmu-events/arch/s390/cf_z14/basic.json    |  2 +-
 .../pmu-events/arch/s390/cf_z14/crypto.json   |  2 +-
 .../pmu-events/arch/s390/cf_z14/extended.json |  2 +-
 .../pmu-events/arch/s390/cf_z15/basic.json    |  2 +-
 .../pmu-events/arch/s390/cf_z15/crypto.json   |  2 +-
 .../pmu-events/arch/s390/cf_z15/crypto6.json  |  2 +-
 .../pmu-events/arch/s390/cf_z15/extended.json |  2 +-
 .../pmu-events/arch/s390/cf_z196/basic.json   |  2 +-
 .../pmu-events/arch/s390/cf_z196/crypto.json  |  2 +-
 .../arch/s390/cf_z196/extended.json           |  2 +-
 .../pmu-events/arch/s390/cf_zec12/basic.json  |  2 +-
 .../pmu-events/arch/s390/cf_zec12/crypto.json |  2 +-
 .../arch/s390/cf_zec12/extended.json          |  2 +-
 .../arch/test/test_soc/cpu/uncore.json        |  2 +-
 .../arch/x86/icelakex/icx-metrics.json        |  2 +-
 tools/perf/pmu-events/jsmn.c                  | 43 ++++++++++++++++++-
 30 files changed, 85 insertions(+), 46 deletions(-)

-- 
2.28.0

