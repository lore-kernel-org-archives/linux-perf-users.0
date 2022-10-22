Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E82CC433FE
	for <linux-perf-users@archiver.kernel.org>; Sat, 22 Oct 2022 10:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiJVKfV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 22 Oct 2022 06:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiJVKeu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 22 Oct 2022 06:34:50 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A56777390;
        Sat, 22 Oct 2022 02:51:32 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MvbcT3qgkzJn7v;
        Sat, 22 Oct 2022 17:28:41 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 17:30:59 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 17:30:58 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <adrian.hunter@intel.com>, <ak@linux.intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH 2/3] perf daemon: Complete supported subcommand in help message
Date:   Sat, 22 Oct 2022 17:27:34 +0800
Message-ID: <20221022092735.114967-3-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20221022092735.114967-1-yangjihong1@huawei.com>
References: <20221022092735.114967-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

perf daemon supports start, signale, stop and ping subcommands, complete it

Before:
  # perf daemon -h
   Usage: perf daemon start [<options>]
      or: perf daemon [<options>]

      -v, --verbose         be more verbose
      -x, --field-separator[=<field separator>]
                            print counts with custom separator
          --base <directory>
                            base directory
          --config <config file>
                            config file path

After:
  # perf daemon -h

   Usage: perf daemon {start|signal|stop|ping} [<options>]
      or: perf daemon [<options>]

      -v, --verbose         be more verbose
      -x, --field-separator[=<field separator>]
                            print counts with custom separator
          --base <directory>
                            base directory
          --config <config file>
                            config file path

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index b82bd902602a..48698e7fd987 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -100,7 +100,7 @@ static struct daemon __daemon = {
 };
 
 static const char * const daemon_usage[] = {
-	"perf daemon start [<options>]",
+	"perf daemon {start|signal|stop|ping} [<options>]",
 	"perf daemon [<options>]",
 	NULL
 };
-- 
2.30.GIT

