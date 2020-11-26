Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351FBC64E75
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Nov 2020 14:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E23D52053B
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Nov 2020 14:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390404AbgKZONn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 26 Nov 2020 09:13:43 -0500
Received: from foss.arm.com ([217.140.110.172]:34138 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389834AbgKZONn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 Nov 2020 09:13:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A053831B;
        Thu, 26 Nov 2020 06:13:42 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.53.242])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C15823F71F;
        Thu, 26 Nov 2020 06:13:40 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     james.clark@arm.com, john.garry@huawei.com
Subject: [PATCH v6 00/12] perf tools: fix perf stat with large socket IDs
Date:   Thu, 26 Nov 2020 16:13:16 +0200
Message-Id: <20201126141328.6509-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Changes since v5:
  * Fix test for cpu_map__get_die() by shifting id before testing.
  * Fix test for cpu_map__get_socket() by not using cpu_map__id_to_socket()
    which is only valid in CPU aggregation mode.

James Clark (12):
  perf tools: Improve topology test
  perf tools: Use allocator for perf_cpu_map
  perf tools: Add new struct for cpu aggregation
  perf tools: Replace aggregation ID with a struct
  perf tools: add new map type for aggregation
  perf tools: drop in cpu_aggr_map struct
  perf tools: Start using cpu_aggr_id in map
  perf tools: Add separate node member
  perf tools: Add separate socket member
  perf tools: Add separate die member
  perf tools: Add separate core member
  perf tools: Add separate thread member

 tools/perf/builtin-stat.c      | 128 ++++++++++++------------
 tools/perf/tests/topology.c    |  64 ++++++++++--
 tools/perf/util/cpumap.c       | 171 ++++++++++++++++++++++-----------
 tools/perf/util/cpumap.h       |  55 ++++++-----
 tools/perf/util/stat-display.c | 102 ++++++++++++--------
 tools/perf/util/stat.c         |   2 +-
 tools/perf/util/stat.h         |   9 +-
 7 files changed, 337 insertions(+), 194 deletions(-)

-- 
2.28.0

