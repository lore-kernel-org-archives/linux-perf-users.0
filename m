Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D067C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Nov 2021 16:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EAA460EE2
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Nov 2021 16:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbhKLQXV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 12 Nov 2021 11:23:21 -0500
Received: from foss.arm.com ([217.140.110.172]:41104 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235416AbhKLQXQ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 Nov 2021 11:23:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DFB9D6E;
        Fri, 12 Nov 2021 08:20:25 -0800 (PST)
Received: from ip-10-252-15-108.eu-west-1.compute.internal (unknown [10.252.15.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ACC563F718;
        Fri, 12 Nov 2021 08:20:23 -0800 (PST)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     leo.yan@linaro.org, German Gomez <german.gomez@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 0/1] perf arm-spe: extend Arm SPE test script with regression testing
Date:   Fri, 12 Nov 2021 16:20:02 +0000
Message-Id: <20211112162005.11876-1-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch extends the test_arm_spe.sh test script in order to tests for
regressions in the decoding flow of Arm SPE samples.

At the time of writing, perf-inject is not working for Arm SPE. In order
to test/apply this patch, [1] needs to be resolved first.

[1] https://lore.kernel.org/all/20211105104130.28186-1-german.gomez@arm.com/T/#m06a8cc68f7b971b6eb10d11aa6e7385a7f6be29e

German Gomez (1):
  perf arm-spe: extend Arm SPE test script with regression testing

 tools/perf/tests/shell/test_arm_spe.sh  |  32 ++++++++++++++++++++++++
 tools/perf/tests/shell/test_arm_spe.tgz | Bin 0 -> 253541 bytes
 2 files changed, 32 insertions(+)
 create mode 100644 tools/perf/tests/shell/test_arm_spe.tgz

-- 
2.25.1

