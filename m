Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7F2C433FE
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 16:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F0C4610A0
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 16:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240121AbhKIQdW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 9 Nov 2021 11:33:22 -0500
Received: from foss.arm.com ([217.140.110.172]:35836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240045AbhKIQdV (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Nov 2021 11:33:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4A36ED1;
        Tue,  9 Nov 2021 08:30:35 -0800 (PST)
Received: from ip-10-252-15-108.eu-west-1.compute.internal (unknown [10.252.15.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 888503F800;
        Tue,  9 Nov 2021 08:30:33 -0800 (PST)
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
Subject: [PATCH v2 0/3] perf arm-spe: Add snapshot mode support
Date:   Tue,  9 Nov 2021 16:30:06 +0000
Message-Id: <20211109163009.92072-1-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patchset adds snapshot mode support for arm-spe.

  - [PATCH 1/3] implements the minimal callbacks to support recording in
    snapshot mode.
  - [PATCH 2/3] implements the find_snapshot callback in order to handle
    wrap-arounds in the AUX buffer.
  - [PATCH 3/3] adds a test for spe snapshot mode.

---

Changes since v1:
  - Added acme@kernel.org to the recipients list as I forgot to include
    him in the original patchset [1].
  - Removed [PATCH 1/5] and [PATCH 2/5] in order to keep patches
    semantically relevant.
  - Updated test script test_arm_spe.sh because it wasn't working on
    distributions that use dash shell v0.5.10 (ubuntu 20) [2].

[1] https://lore.kernel.org/all/20210916154635.1525-1-german.gomez@arm.com/
[2] https://lore.kernel.org/all/fd65eb63-d4ca-2105-74cb-c717ad2eb7d3@arm.com/

German Gomez (3):
  perf arm-spe: Add snapshot mode support
  perf arm-spe: Implement find_snapshot callback
  perf arm-spe: Snapshot mode test

 tools/perf/arch/arm64/util/arm-spe.c   | 275 +++++++++++++++++++++++++
 tools/perf/tests/shell/test_arm_spe.sh |  89 ++++++++
 2 files changed, 364 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_arm_spe.sh

-- 
2.25.1

