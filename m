Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5E1C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 25 Nov 2021 20:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbhKYUx4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 25 Nov 2021 15:53:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:49726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237292AbhKYUvz (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 25 Nov 2021 15:51:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 013B061028;
        Thu, 25 Nov 2021 20:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637873324;
        bh=vg0Ilz43irK/weKshTjaueM5HrsdjLADePSdElSthOc=;
        h=Date:From:To:Cc:Subject:From;
        b=n5wSFXuo2rLbg8dKWZf/ZcLZDu7mwUzw4OQ6plDmNJdVMZe95u5qyqHfOTfROobS3
         HfjQIluOwVwkQoxccB9fDRDuELiuj6IFtlWJB8whwqNne3kfV4PPZRV8SEzQmtj4jZ
         e0p6IQERXJ9E+jWGFcry+Xqr0I/Lxkdpiw4O3LIYEnyt2wp8g25nLflRIqzOgtRzcT
         x8KESc0XlQ36InmUEULc68vYTC11h7RH4IC1HrXcw6OWmcKOaVSneqxQOa8/X1oEQy
         3kbzj8L73fCqs7oJ6eVkPx0MNJ4z7hOc03s/4h+nTqNjbhyQjm+udBUtmsZEmKMBIc
         j/JuBPJU9uCfA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 61E3040002; Thu, 25 Nov 2021 17:48:41 -0300 (-03)
Date:   Thu, 25 Nov 2021 17:48:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [FYI][PATCH 1/1] tools headers UAPI: Sync s390 syscall table file
 changed by new futex_waitv syscall Reply-To:
Message-ID: <YZ/2qRW/TScYTP1U@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

To pick the changes in this cset:

  6c122360cf2f4c5a ("s390: wire up sys_futex_waitv system call")

That add support for this new syscall in tools such as 'perf trace'.

For instance, this is now possible (adapted from the x86_64 test output):

  # perf trace -e futex_waitv
  ^C#
  # perf trace -v -e futex_waitv
  event qualifier tracepoint filter: (common_pid != 807333 && common_pid != 3564) && (id == 449)
  ^C#
  # perf trace -v -e futex* --max-events 10
  event qualifier tracepoint filter: (common_pid != 812168 && common_pid != 3564) && (id == 238 || id == 449)
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

  $ grep futex tools/perf/arch/s390/entry/syscalls/syscall.tbl
  238  common	futex			sys_futex			sys_futex_time32
  422	32	futex_time64		-				sys_futex
  449  common	futex_waitv		sys_futex_waitv			sys_futex_waitv
  $

This addresses this perf build warnings:

  Warning: Kernel ABI header at 'tools/perf/arch/s390/entry/syscalls/syscall.tbl' differs from latest version at 'arch/s390/kernel/syscalls/syscall.tbl'
  diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390/kernel/syscalls/syscall.tbl

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/entry/syscalls/syscall.tbl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
index df5261e5cfe1f28d..ed9c5c2eafad700c 100644
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -451,3 +451,4 @@
 446  common	landlock_restrict_self	sys_landlock_restrict_self	sys_landlock_restrict_self
 # 447 reserved for memfd_secret
 448  common	process_mrelease	sys_process_mrelease		sys_process_mrelease
+449  common	futex_waitv		sys_futex_waitv			sys_futex_waitv
-- 
2.31.1

