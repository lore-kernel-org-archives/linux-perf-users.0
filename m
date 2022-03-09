Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D37EC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Mar 2022 19:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237955AbiCIToa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 9 Mar 2022 14:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237667AbiCITo3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Mar 2022 14:44:29 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C8BD121533;
        Wed,  9 Mar 2022 11:43:30 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E743C1691;
        Wed,  9 Mar 2022 11:43:29 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.41.86])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 655553FA27;
        Wed,  9 Mar 2022 11:43:28 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, linux-perf-users@vger.kernel.org
Cc:     James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] perf tools: Use Python devtools for version autodetection
Date:   Wed,  9 Mar 2022 19:43:12 +0000
Message-Id: <20220309194313.3350126-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

As mentioned here [1], I was going to try to attempt to improve Python
autodetection in the scenario where Python3 devtools are installed
alongside the Python2 runtime which is a pretty common scenario on a base
system after running "apt install python3-dev".

Thanks
James

[1]: https://lkml.org/lkml/2021/11/30/614

James Clark (1):
  perf tools: Use Python devtools for version autodetection rather than
    runtime

 tools/perf/Makefile.config | 39 ++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

-- 
2.28.0

