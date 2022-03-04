Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F30BC433FE
	for <linux-perf-users@archiver.kernel.org>; Fri,  4 Mar 2022 09:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbiCDJKx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 4 Mar 2022 04:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236595AbiCDJKw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 4 Mar 2022 04:10:52 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7261C151C78;
        Fri,  4 Mar 2022 01:10:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC3CF1424;
        Fri,  4 Mar 2022 01:10:02 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.42.166])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4F57E3F73D;
        Fri,  4 Mar 2022 01:10:01 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        coresight@lists.linaro.org, olsajiri@gmail.com
Cc:     James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] perf: Set build-id using build-id header on new mmap records
Date:   Fri,  4 Mar 2022 09:09:55 +0000
Message-Id: <20220304090956.2048712-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Changes since v1:
 * Add read lock around dso find
 * Bracket style fix

Hi,

We are seeing an issue with doing Coresight decode off target where
initially the correct dso from ~/.debug is used, but after a new thread
in the perf.data file is passed with its mmap record, the local version
of the dso is picked up instead. This happens if the binary exists in the
same path on both devices, for example /bin/ls.

Initially when parsing the build-ids in the header, the dso for /bin/ls
will be created, and the file will correctly point to
~/.debug/bin/ls/2f15ad836be3339dec0e2e6a3c637e08e48aacbd/elf, but for any
new threads or mmaps that are also for /bin/ls, they will not have a
build-id set so they point to /bin/ls on the local machine rather than the
debug folder.

To fix this I made it possible to look up which existing dsos have
build id's set that originate from the header and then copy that build-id
onto the new dso if the name matches. Another way to do it would
be to stop comparing the mmap id so it matches on filename only, but I
think we do want to differentiate between different mmaps, even if they
have the same name, which is how it works in this version.

Applies to perf/core 56dce8681

James Clark (1):
  perf: Set build-id using build-id header on new mmap records

 tools/perf/util/dso.h    |  1 +
 tools/perf/util/header.c |  1 +
 tools/perf/util/map.c    | 20 +++++++++++++++++---
 3 files changed, 19 insertions(+), 3 deletions(-)

-- 
2.28.0

