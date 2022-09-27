Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222D8C54EE9
	for <linux-perf-users@archiver.kernel.org>; Tue, 27 Sep 2022 15:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbiI0PpZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 27 Sep 2022 11:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbiI0PpA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 27 Sep 2022 11:45:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3502F1577E6;
        Tue, 27 Sep 2022 08:41:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45CEB1063;
        Tue, 27 Sep 2022 08:41:23 -0700 (PDT)
Received: from e121896.Emea.Arm.com (e121896.Emea.Arm.com [10.32.36.24])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BB2823F73B;
        Tue, 27 Sep 2022 08:41:13 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        will@kernel.org, James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org
Subject: [RFC PATCH 0/4] Add VG register attr test with kernel version and feature detection
Date:   Tue, 27 Sep 2022 16:41:00 +0100
Message-Id: <20220927154104.869029-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This is the kind of test that I would like to add for VG, with the
necessary additions to the attr test framework for kernel version
detection so that it always passes even when run on old kernels.

This approach isn't very scalable, for example the change to fix the
tests for PERF_FORMAT_LOST [1] affects many tests so they would all have
to be duplicated. Of course there is still the option to weaken those
tests and make them accept any value.

It also doesn't apply to any of the shell script tests which would need
to re-implement something similar to this.

I'm interested to see if people think this is useful, at least it is for
this one test.

[1]: https://lore.kernel.org/linux-perf-users/20220926144948.223641-1-james.clark@arm.com/T/#t

James Clark (4):
  perf test: Add ability to test exit code for attr tests
  perf test: Add mechanism for skipping attr tests on auxiliary vector
    values
  perf test: Add mechanism for skipping attr tests on kernel versions
  perf test arm64: Add attr tests for new VG register

 tools/perf/tests/attr.py                      | 71 +++++++++++++++++--
 .../attr/test-record-user-regs-no-sve-aarch64 |  9 +++
 .../test-record-user-regs-old-sve-aarch64     | 10 +++
 .../attr/test-record-user-regs-sve-aarch64    | 14 ++++
 4 files changed, 99 insertions(+), 5 deletions(-)
 create mode 100644 tools/perf/tests/attr/test-record-user-regs-no-sve-aarch64
 create mode 100644 tools/perf/tests/attr/test-record-user-regs-old-sve-aarch64
 create mode 100644 tools/perf/tests/attr/test-record-user-regs-sve-aarch64

-- 
2.28.0

