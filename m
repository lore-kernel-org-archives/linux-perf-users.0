Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135EAC4338F
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 Aug 2021 13:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8159611C8
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 Aug 2021 13:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhHWNmv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 23 Aug 2021 09:42:51 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:14314 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhHWNmv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 23 Aug 2021 09:42:51 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GtYLm6chvz88Dq;
        Mon, 23 Aug 2021 21:41:52 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 23 Aug 2021 21:42:05 +0800
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 23 Aug 2021 21:42:05 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <acme@kernel.org>
CC:     <hekuang@huawei.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>,
        <zhangjinhao2@huawei.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] perf unwind: Do not overwrite FEATURE_CHECK_LDFLAGS-libunwind-{x86,aarch64}
Date:   Mon, 23 Aug 2021 21:43:40 +0800
Message-ID: <20210823134340.60955-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

When setting LIBUNWIND_DIR, we first set

 FEATURE_CHECK_LDFLAGS-libunwind-{aarch64,x86} = -L$(LIBUNWIND_DIR)/lib.

After commit 5c4d7c82c0dc ("perf unwind: Do not put libunwind-{x86,aarch64}
in FEATURE_TESTS_BASIC"), FEATURE_CHECK_LDFLAGS-libunwind-{x86,aarch64} is
overwritten. As a result, the remote libunwind libraries cannot be searched
from $(LIBUNWIND_DIR)/lib directory during feature check tests. Fix it with
variable appending.

Before this patch:

 perf$ make VF=1 LIBUNWIND_DIR=/opt/libunwind_aarch64
  BUILD:   Doing 'make -j16' parallel build
 <SNIP>
 ...
 ...                    libopencsd: [ OFF ]
 ...                 libunwind-x86: [ OFF ]
 ...              libunwind-x86_64: [ OFF ]
 ...                 libunwind-arm: [ OFF ]
 ...             libunwind-aarch64: [ OFF ]
 ...         libunwind-debug-frame: [ OFF ]
 ...     libunwind-debug-frame-arm: [ OFF ]
 ... libunwind-debug-frame-aarch64: [ OFF ]
 ...                           cxx: [ OFF ]
 <SNIP>

 perf$ cat ../build/feature/test-libunwind-aarch64.make.output
 /usr/bin/ld: cannot find -lunwind-aarch64
 /usr/bin/ld: cannot find -lunwind-aarch64
 collect2: error: ld returned 1 exit status

After this patch:

 perf$ make VF=1 LIBUNWIND_DIR=/opt/libunwind_aarch64
  BUILD:   Doing 'make -j16' parallel build
 <SNIP>
 ...                    libopencsd: [ OFF ]
 ...                 libunwind-x86: [ OFF ]
 ...              libunwind-x86_64: [ OFF ]
 ...                 libunwind-arm: [ OFF ]
 ...             libunwind-aarch64: [ on  ]
 ...         libunwind-debug-frame: [ OFF ]
 ...     libunwind-debug-frame-arm: [ OFF ]
 ... libunwind-debug-frame-aarch64: [ OFF ]
 ...                           cxx: [ OFF ]
 <SNIP>

 perf$ cat ../build/feature/test-libunwind-aarch64.make.output

 perf$ ldd ./perf
        linux-vdso.so.1 (0x00007ffdf07da000)
        libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f30953dc000)
        librt.so.1 => /lib/x86_64-linux-gnu/librt.so.1 (0x00007f30951d4000)
        libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007f3094e36000)
        libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f3094c32000)
        libelf.so.1 => /usr/lib/x86_64-linux-gnu/libelf.so.1 (0x00007f3094a18000)
        libdw.so.1 => /usr/lib/x86_64-linux-gnu/libdw.so.1 (0x00007f30947cc000)
        libunwind-x86_64.so.8 => /usr/lib/x86_64-linux-gnu/libunwind-x86_64.so.8 (0x00007f30945ad000)
        libunwind.so.8 => /usr/lib/x86_64-linux-gnu/libunwind.so.8 (0x00007f3094392000)
        liblzma.so.5 => /lib/x86_64-linux-gnu/liblzma.so.5 (0x00007f309416c000)
        libunwind-aarch64.so.8 => not found
        libslang.so.2 => /lib/x86_64-linux-gnu/libslang.so.2 (0x00007f3093c8a000)
        libpython2.7.so.1.0 => /usr/local/lib/libpython2.7.so.1.0 (0x00007f309386b000)
        libz.so.1 => /lib/x86_64-linux-gnu/libz.so.1 (0x00007f309364e000)
        libnuma.so.1 => /usr/lib/x86_64-linux-gnu/libnuma.so.1 (0x00007f3093443000)
        libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f3093052000)
        /lib64/ld-linux-x86-64.so.2 (0x00007f3096097000)
        libbz2.so.1.0 => /lib/x86_64-linux-gnu/libbz2.so.1.0 (0x00007f3092e42000)
        libutil.so.1 => /lib/x86_64-linux-gnu/libutil.so.1 (0x00007f3092c3f000)

Fixes: 5c4d7c82c0dc ("perf unwind: Do not put libunwind-{x86,aarch64} in FEATURE_TESTS_BASIC")
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 tools/perf/Makefile.config | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index eb8e487ef90b..29ffd57f5cd8 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -133,10 +133,10 @@ FEATURE_CHECK_LDFLAGS-libunwind = $(LIBUNWIND_LDFLAGS) $(LIBUNWIND_LIBS)
 FEATURE_CHECK_CFLAGS-libunwind-debug-frame = $(LIBUNWIND_CFLAGS)
 FEATURE_CHECK_LDFLAGS-libunwind-debug-frame = $(LIBUNWIND_LDFLAGS) $(LIBUNWIND_LIBS)
 
-FEATURE_CHECK_LDFLAGS-libunwind-arm = -lunwind -lunwind-arm
-FEATURE_CHECK_LDFLAGS-libunwind-aarch64 = -lunwind -lunwind-aarch64
-FEATURE_CHECK_LDFLAGS-libunwind-x86 = -lunwind -llzma -lunwind-x86
-FEATURE_CHECK_LDFLAGS-libunwind-x86_64 = -lunwind -llzma -lunwind-x86_64
+FEATURE_CHECK_LDFLAGS-libunwind-arm += -lunwind -lunwind-arm
+FEATURE_CHECK_LDFLAGS-libunwind-aarch64 += -lunwind -lunwind-aarch64
+FEATURE_CHECK_LDFLAGS-libunwind-x86 += -lunwind -llzma -lunwind-x86
+FEATURE_CHECK_LDFLAGS-libunwind-x86_64 += -lunwind -llzma -lunwind-x86_64
 
 FEATURE_CHECK_LDFLAGS-libcrypto = -lcrypto
 
-- 
2.17.1

