Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8009EC43334
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Jul 2022 02:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiGLCR5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 11 Jul 2022 22:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiGLCR5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 11 Jul 2022 22:17:57 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC92220FB;
        Mon, 11 Jul 2022 19:17:56 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LhkpF2lZnzVff6;
        Tue, 12 Jul 2022 10:14:13 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Jul 2022 10:17:54 +0800
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Jul 2022 10:17:53 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <linux@armlinux.org.uk>, <rmk+kernel@armlinux.org.uk>,
        <ardb@kernel.org>, <will@kernel.org>
CC:     <mark.rutland@arm.com>, <broonie@kernel.org>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <arnd@arndb.de>, <linus.walleij@linaro.org>,
        <rostedt@goodmis.org>, <nick.hawkins@hpe.com>, <john@phrozen.org>,
        <mhiramat@kernel.org>, <ast@kernel.org>, <linyujun809@huawei.com>,
        <ndesaulniers@google.com>, <lihuafei1@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
Subject: [PATCH 0/5] ARM: Convert to ARCH_STACKWALK
Date:   Tue, 12 Jul 2022 10:15:22 +0800
Message-ID: <20220712021527.109921-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This series mainly updates the ARM stack trace code to use the newer and
simpler arch_stack_walk() interface. Two issues were fixed before that
(see patch 1 and 2), as well as allowing stack_trace_save_tsk() to
trace non-current tasks (see patch 3).

Li Huafei (5):
  ARM: stacktrace: Skip frame pointer boundary check for
    call_with_stack()
  ARM: stacktrace: Avoid duplicate saving of exception PC value
  ARM: stacktrace: Allow stack trace saving for non-current tasks
  ARM: stacktrace: Make stack walk callback consistent with generic code
  ARM: stacktrace: Convert stacktrace to generic ARCH_STACKWALK

 arch/arm/Kconfig                  |   1 +
 arch/arm/include/asm/stacktrace.h |   8 +-
 arch/arm/kernel/perf_callchain.c  |   9 +-
 arch/arm/kernel/return_address.c  |   9 +-
 arch/arm/kernel/stacktrace.c      | 195 +++++++++++++-----------------
 arch/arm/lib/call_with_stack.S    |   2 +
 6 files changed, 105 insertions(+), 119 deletions(-)

-- 
2.17.1

