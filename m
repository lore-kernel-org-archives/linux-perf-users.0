Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E53AC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 16:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 454E2611C1
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 16:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241723AbhJOQzo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 15 Oct 2021 12:55:44 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3988 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241705AbhJOQzm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Oct 2021 12:55:42 -0400
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HWC1L0GBJz67sXH;
        Sat, 16 Oct 2021 00:49:58 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 15 Oct 2021 18:53:34 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 15 Oct 2021 17:53:30 +0100
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <mingo@redhat.com>
CC:     <irogers@google.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 0/2] perf jevents: Enable build warnings
Date:   Sat, 16 Oct 2021 00:48:25 +0800
Message-ID: <1634316507-227751-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Currently jevents builds without any complier warning flags enabled. So
use newly-defined HOSTCFLAGS, which comes from EXTRA_WARNINGS. I am not
100% confident that this is the best way, but sending out for review.

Baseline is be8ecc57f180 (HEAD, acme/perf/core) perf srcline: Use
long-running addr2line per DSO

Thanks!

John Garry (2):
  perf jevents: Fix some would-be warnings
  perf jevents: Enable warnings through HOSTCFLAGS

 tools/perf/Makefile.config      |  1 +
 tools/perf/Makefile.perf        |  2 +-
 tools/perf/pmu-events/Build     |  2 +-
 tools/perf/pmu-events/jevents.c | 10 ++++------
 4 files changed, 7 insertions(+), 8 deletions(-)

-- 
2.26.2

