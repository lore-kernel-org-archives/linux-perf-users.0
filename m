Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBE9C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 21 Oct 2021 09:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DE0F611F2
	for <linux-perf-users@archiver.kernel.org>; Thu, 21 Oct 2021 09:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhJUJYP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 21 Oct 2021 05:24:15 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4012 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhJUJYP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 21 Oct 2021 05:24:15 -0400
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HZhj929fsz67gkm;
        Thu, 21 Oct 2021 17:18:05 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 21 Oct 2021 11:21:57 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 21 Oct 2021 10:21:54 +0100
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <mingo@redhat.com>
CC:     <irogers@google.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kjain@linux.ibm.com>,
        <james.clark@arm.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v2 0/2] perf jevents: Enable build warnings
Date:   Thu, 21 Oct 2021 17:16:43 +0800
Message-ID: <1634807805-40093-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Currently jevents builds without any complier warning flags enabled. So
use newly-defined HOSTCFLAGS, which comes from EXTRA_WARNINGS.

Changes for v2:
- Add Werror, Wall, and Wextra (James Clark suggestion)

Baseline is acme perf/core + mainline commit b94729919db2 ("perf jevents:
Free the sys_event_tables list after processing entries"):

680453e63302 perf jevents: Free the sys_event_tables list after processing entries
be8ecc57f180 (origin/perf/core) perf srcline: Use long-running addr2line per DSO
2b775152bbe8 perf tests vmlinux-kallsyms: Ignore hidden symbols

John Garry (2):
  perf jevents: Fix some would-be warnings
  perf jevents: Enable warnings through HOSTCFLAGS

 tools/perf/Makefile.config      |  5 +++++
 tools/perf/Makefile.perf        |  2 +-
 tools/perf/pmu-events/Build     |  2 +-
 tools/perf/pmu-events/jevents.c | 10 ++++------
 4 files changed, 11 insertions(+), 8 deletions(-)

-- 
2.17.1

