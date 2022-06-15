Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82185C43334
	for <linux-perf-users@archiver.kernel.org>; Wed, 15 Jun 2022 13:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245550AbiFONJM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 15 Jun 2022 09:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbiFONJL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 15 Jun 2022 09:09:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4AD81F625;
        Wed, 15 Jun 2022 06:09:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD837139F;
        Wed, 15 Jun 2022 06:09:09 -0700 (PDT)
Received: from e127744.arm.com (unknown [10.57.84.186])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7B9223F66F;
        Wed, 15 Jun 2022 06:09:07 -0700 (PDT)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     German Gomez <german.gomez@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 0/1] perf test: Add test for branch stack sampling
Date:   Wed, 15 Jun 2022 14:09:00 +0100
Message-Id: <20220615130901.1151397-1-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

While testing Anshuman Khandual's branch stack sampling ABI, and BRBE
driver ([1] and [2] respectively) I've been using this test to check the
consistency between arches (x86 and Arm64).

We might extend it with Arm64-specific tests once the BRBE driver has
been reviewed and merged, but for now I think this is generic enough to
cover both x86 LBR and Arm BRBE.

Thanks,
German

[1] https://lore.kernel.org/linux-arm-kernel/20220610035101.424112-1-anshuman.khandual@arm.com/
[2] https://lore.kernel.org/all/20220613100119.684673-1-anshuman.khandual@arm.com/

German Gomez (1):
  perf test: Add self test for branch stack sampling

 tools/perf/tests/shell/lib/brstack/main.h | 15 ++++
 tools/perf/tests/shell/lib/brstack/test.c | 25 +++++++
 tools/perf/tests/shell/test_brstack.sh    | 86 +++++++++++++++++++++++
 3 files changed, 126 insertions(+)
 create mode 100644 tools/perf/tests/shell/lib/brstack/main.h
 create mode 100644 tools/perf/tests/shell/lib/brstack/test.c
 create mode 100755 tools/perf/tests/shell/test_brstack.sh

-- 
2.25.1

