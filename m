Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2D2C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 Nov 2021 13:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F81C61AE2
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 Nov 2021 13:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhKRNRs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 18 Nov 2021 08:17:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:56466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229461AbhKRNRs (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 18 Nov 2021 08:17:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26486615A4;
        Thu, 18 Nov 2021 13:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637241288;
        bh=pTcJU8CLw9tYli7PCfSZBvemce1fIuhhD1AKOiyQnYU=;
        h=Date:From:To:Cc:Subject:From;
        b=GfsO53Kd9ftllE+E0+wyqwuy9sEnNxb/gIhlMkei/ppnbagjcc7aLhE4aQJE4oNbC
         TtrWNXcc32q7XeufM7VRGvPsjoAL3Sj1YBvbHL2qekundYwNUXw04HVw1Km4Bgqgy1
         MuFaUh59WIVrl2FD72DYsBfeGgAN4rEQEHYiZRmsX2XIGFkN3XwG+/jmMWEOrD0H2Y
         8WjIWu3KrwPPaG4EKFZyPuGN03cQ1qWNXtGvDf1pIUU+F4htfuuj03VmdWL1ynxPrT
         Jrp2fwrDlccKU83TO96H7aEDJGCHQHWn7DaqwtHrDEBVFwHfGOfqD+LqlWtsmnc1bz
         J7Q8wx2f6MMJQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2931C4088E; Thu, 18 Nov 2021 10:14:46 -0300 (-03)
Date:   Thu, 18 Nov 2021 10:14:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Wang Haojun <jiangliuer01@gmail.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [FYI][PATCH 1/1] tools headers UAPI: Sync MIPS syscall table file
 changed by new futex_waitv syscall
Message-ID: <YZZRxuIyvSGLZhM4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

To pick the changes in these csets:

  b3ff2881ba18b852 ("MIPS: syscalls: Wire up futex_waitv syscall")

That add support for this new syscall in tools such as 'perf trace'.

For instance, this is now possible (adapted from the x86_64 test output):

  # perf trace -e futex_waitv
  ^C#
  # perf trace -v -e futex_waitv
  event qualifier tracepoint filter: (common_pid != 807333 && common_pid != 3564) && (id == 449)
  ^C#
  # perf trace -v -e futex* --max-events 10
  event qualifier tracepoint filter: (common_pid != 812168 && common_pid != 3564) && (id == 202 || id == 449)
  mmap size 528384B
           ? (         ): Timer/219310  ... [continued]: futex())                                            = -1 ETIMEDOUT (Connection timed out)
       0.012 ( 0.002 ms): Timer/219310 futex(uaddr: 0x7fd0b152d3c8, op: WAKE|PRIVATE_FLAG, val: 1)           = 0
       0.024 ( 0.060 ms): Timer/219310 futex(uaddr: 0x7fd0b152d420, op: WAIT_BITSET|PRIVATE_FLAG, utime: 0x7fd0b1657840, val3: MATCH_ANY) = 0
       0.086 ( 0.001 ms): Timer/219310 futex(uaddr: 0x7fd0b152d3c8, op: WAKE|PRIVATE_FLAG, val: 1)           = 0
       0.088 (         ): Timer/219310 futex(uaddr: 0x7fd0b152d424, op: WAIT_BITSET|PRIVATE_FLAG, utime: 0x7fd0b1657840, val3: MATCH_ANY) ...
       0.075 ( 0.005 ms): Web Content/219299 futex(uaddr: 0x7fd0b152d420, op: WAKE|PRIVATE_FLAG, val: 1)     = 1
       0.169 ( 0.004 ms): Web Content/219299 futex(uaddr: 0x7fd0b152d424, op: WAKE|PRIVATE_FLAG, val: 1)     = 1
       0.088 ( 0.089 ms): Timer/219310  ... [continued]: futex())                                            = 0
       0.179 ( 0.001 ms): Timer/219310 futex(uaddr: 0x7fd0b152d3c8, op: WAKE|PRIVATE_FLAG, val: 1)           = 0
       0.181 (         ): Timer/219310 futex(uaddr: 0x7fd0b152d420, op: WAIT_BITSET|PRIVATE_FLAG, utime: 0x7fd0b1657840, val3: MATCH_ANY) ...
  #

That is the filter expression attached to the raw_syscalls:sys_{enter,exit}
tracepoints.

  $ grep futex_waitv tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
  449	n64	futex_waitv			sys_futex_waitv
  $

This addresses these perf build warnings:

  Warning: Kernel ABI header at 'tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl' differs from latest version at 'arch/mips/kernel/syscalls/syscall_n64.tbl'
  diff -u tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl arch/mips/kernel/syscalls/syscall_n64.tbl

Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Wang Haojun <jiangliuer01@gmail.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
index 1ca7bc337932bcae..e2c481fcede6bd11 100644
--- a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
+++ b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
@@ -363,3 +363,4 @@
 446	n64	landlock_restrict_self		sys_landlock_restrict_self
 # 447 reserved for memfd_secret
 448	n64	process_mrelease		sys_process_mrelease
+449	n64	futex_waitv			sys_futex_waitv
-- 
2.31.1

