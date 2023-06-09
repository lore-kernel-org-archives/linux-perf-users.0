Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E0CC7EE23
	for <linux-perf-users@archiver.kernel.org>; Fri,  9 Jun 2023 03:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237795AbjFIDbt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 8 Jun 2023 23:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236884AbjFIDbq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 8 Jun 2023 23:31:46 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41E23589
        for <linux-perf-users@vger.kernel.org>; Thu,  8 Jun 2023 20:31:44 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qcmlg0sBmzkXMb;
        Fri,  9 Jun 2023 11:29:19 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 9 Jun
 2023 11:31:42 +0800
Date:   Fri, 9 Jun 2023 11:31:28 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
CC:     <changbin.du@huawei.com>
Subject: [Issue] perf report gets stuck at addr2line
Message-ID: <20230609033128.ujodex56vkha2ifr@M910t>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello,
I tried perf of mainline built on Ubuntu 20.04 and it gets stuck when reporting.

$ sudo lsb_release -d
Description:    Ubuntu 20.04.6 LTS
$ sudo perf record -g ls
$ perf report --stdio
[stuck]

It seems this addr2line binary was't working as perf expected. I found below
error:
addr2line: addr2line configuration failed

Then I ran addr2line manually:

$ addr2line -v
GNU addr2line (GNU Binutils for Ubuntu) 2.34
Copyright (C) 2020 Free Software Foundation, Inc.
...
$ addr2line -e .debug/.build-id/5e/2fa721660d663f38b6e1aa98d6fa3776974b54/elf -i -f
,
__per_cpu_start
??:?

The addr2line_configure() expects a '?' but we got '_'.

I am not sure whether this is related to Ian's change but it works on v6.3.

-- 
Cheers,
Changbin Du
