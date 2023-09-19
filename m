Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766D1CD54A9
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Sep 2023 09:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjISJwD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Sep 2023 05:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjISJwC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Sep 2023 05:52:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CB3CEA;
        Tue, 19 Sep 2023 02:51:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 718FE1FB;
        Tue, 19 Sep 2023 02:52:34 -0700 (PDT)
Received: from e127643.broadband (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8A9193F67D;
        Tue, 19 Sep 2023 02:51:55 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Cc:     James Clark <james.clark@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Zaid Al-Bassam <zalbassam@google.com>,
        Marc Zyngier <maz@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] arm64: perf: Add support for event counting threshold
Date:   Tue, 19 Sep 2023 10:51:27 +0100
Message-Id: <20230919095137.360963-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

FEAT_PMUv3_TH (Armv8.8) is a new feature that allows conditional
counting of PMU events depending on how much the event increments on
a single cycle. Two new config fields for perf_event_open have been
added, and a PMU cap file for reading the max_threshold. See the first
commit message and the docs in the second commit for more details.

The change has been validated on the Arm FVP model:

  # Zero values, works as expected (as before).
  $ perf stat -e dtlb_walk/threshold=0,threshold_control=0/ -- true

    5962      dtlb_walk/threshold=0,threshold_control=0/

  # Threshold >= 255 causes count to be 0 because dtlb_walk doesn't
  # increase by more than 1 per cycle.
  $ perf stat -e dtlb_walk/threshold=255,threshold_control=5/ -- true

    0      dtlb_walk/threshold=255,threshold_control=5/
  
  # Keeping comparison as >= but lowering the threshold to 1 makes the
  # count return.
  $ perf stat -e dtlb_walk/threshold=1,threshold_control=5/ -- true

    6329      dtlb_walk/threshold=1,threshold_control=5/

James Clark (2):
  arm64: perf: Add support for event counting threshold
  Documentation: arm64: Document the PMU event counting threshold
    feature

 Documentation/arch/arm64/perf.rst | 58 ++++++++++++++++++++++++++++++
 drivers/perf/arm_pmuv3.c          | 59 ++++++++++++++++++++++++++++++-
 include/linux/perf/arm_pmuv3.h    |  7 +++-
 3 files changed, 122 insertions(+), 2 deletions(-)


base-commit: 21b61fe48c2fc43d98ebb67a1f3832e0478fa523
-- 
2.34.1

