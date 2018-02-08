From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH 0/3] perf s390: Use syscall.tbl to create the perf syscall table
Date: Thu,  8 Feb 2018 12:47:47 +0100
Message-ID: <1518090470-2899-1-git-send-email-brueckner@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39364 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751066AbeBHLr7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 8 Feb 2018 06:47:59 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w18BiGd7104288
        for <linux-perf-users@vger.kernel.org>; Thu, 8 Feb 2018 06:47:59 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2g0nvrg9fa-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Feb 2018 06:47:59 -0500
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <brueckner@linux.vnet.ibm.com>;
        Thu, 8 Feb 2018 11:47:57 -0000
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org

With commit 857f46b "s390/syscalls: add system call table", I have
introduced a syscall.tbl file to generate the system call table for
s390, as well as, respective unistd.h header files for 64-bit and compat
system calls.

Because the unistd.h is now generated, update perf with a copy of the
syscall.tbl file and adapt the script that generates the system call
table for perf trace to support wildcard syscall matches.

The patch set is based on the perf/core branch.

Hendrik Brueckner (3):
  Revert "tools include s390: Grab a copy of
    arch/s390/include/uapi/asm/unistd.h"
  perf s390: Grab a copy of arch/s390/kernel/syscall/syscall.tbl
  perf s390: Rework system call table creation by using syscall.tbl

 tools/arch/s390/include/uapi/asm/unistd.h        | 412 -----------------------
 tools/perf/arch/s390/Makefile                    |  10 +-
 tools/perf/arch/s390/entry/syscalls/mksyscalltbl |  18 +-
 tools/perf/arch/s390/entry/syscalls/syscall.tbl  | 390 +++++++++++++++++++++
 tools/perf/check-headers.sh                      |   1 -
 5 files changed, 404 insertions(+), 427 deletions(-)
 delete mode 100644 tools/arch/s390/include/uapi/asm/unistd.h
 create mode 100644 tools/perf/arch/s390/entry/syscalls/syscall.tbl

-- 
1.8.3.1
