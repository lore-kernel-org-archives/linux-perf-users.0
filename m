Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0520C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri,  5 Nov 2021 10:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE7756120A
	for <linux-perf-users@archiver.kernel.org>; Fri,  5 Nov 2021 10:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhKEKoS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 5 Nov 2021 06:44:18 -0400
Received: from foss.arm.com ([217.140.110.172]:58108 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhKEKoR (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 5 Nov 2021 06:44:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EDEA1FB;
        Fri,  5 Nov 2021 03:41:38 -0700 (PDT)
Received: from ubuntu-18-04-aarch64-spe-2.warwick.arm.com (ubuntu-18-04-aarch64-spe-2.warwick.arm.com [10.32.33.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4E44F3F7B4;
        Fri,  5 Nov 2021 03:41:36 -0700 (PDT)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     German Gomez <german.gomez@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/1] perf arm-spe: Inject SPE samples in perf-inject
Date:   Fri,  5 Nov 2021 10:41:29 +0000
Message-Id: <20211105104130.28186-1-german.gomez@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

perf-inject is currently not working for Arm SPE. When you try to run
perf-inject and perf-report with a perf.data file that contains SPE
traces, the tool reports a "Bad address" error:

  # ./perf record -e arm_spe_0/ts_enable=1,store_filter=1,branch_filter=1,load_filter=1/ -a -- sleep 1
  # ./perf inject -i perf.data -o perf.inject.data --itrace
  # ./perf report -i perf.inject.data --stdio
  
  0x42c00 [0x8]: failed to process type: 9 [Bad address]
  Error:
  failed to process sample

As far as I know, the issue was first spotted in [1], but perf-inject
was not yet injecting the samples. This patch does something similar to
what cs_etm does for injecting the samples [2], but for SPE.

[1] https://patchwork.kernel.org/project/linux-arm-kernel/cover/20210412091006.468557-1-leo.yan@linaro.org/#24117339
[2] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/cs-etm.c?h=perf/core&id=133fe2e617e48ca0948983329f43877064ffda3e#n1196

German Gomez (1):
  perf arm-spe: Inject SPE samples in perf-inject

 tools/perf/util/arm-spe.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

-- 
2.25.1

