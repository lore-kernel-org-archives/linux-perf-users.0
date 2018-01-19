From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH v2 0/5] perf trace: Introduce arch-specific errno code/name mappings
Date: Fri, 19 Jan 2018 09:56:12 +0100
Message-ID: <1516352177-11106-1-git-send-email-brueckner@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38484 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754799AbeASI41 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 19 Jan 2018 03:56:27 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0J8sAKi025411
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Jan 2018 03:56:27 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fkch4u4wu-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Jan 2018 03:56:26 -0500
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <brueckner@linux.vnet.ibm.com>;
        Fri, 19 Jan 2018 08:56:24 -0000
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org

Introduce an interface to perf to resolve errno codes to their names.
This is used by perf trace to display the errno name, for example, ENOENT,
for an system call.  The previous implementation used the errno_to_name()
function from the audit library.

With this change, a table of errno codes and their names are created for
each architecture on which perf is supported (others can be easily added
if necessary).  The errno_to_name() function from the audit library is
replaced with an arch-specific one, arch_errno_to_name().

The benefit is that perf trace does not longer have a direct dependency
for the audit library and the perf trace output can be displayed across
architectures.  For example, collect trace output on s390 and display it
on x86.

The audit library dependency can be further reduced and completely removed
for architectures that support system call tables in perf (see last commit).

See also discussion on:
- https://www.spinics.net/lists/linux-perf-users/msg04782.html
- https://www.spinics.net/lists/linux-perf-users/msg05005.html

Please note that this patch set is bases on the perf/core branch.

Changes in v2:
As the arch_errno_to_name() mapping is used by perf trace only,
move all the scripts and generated files from tools/perf/util/
to the tools/perf/trace/beauty/{generated/} directories.
See also https://www.spinics.net/lists/linux-perf-users/msg05037.html


Hendrik Brueckner (5):
  tools include arch: Grab a copy of errno.h for arch's supported by
    perf
  tools include asm-generic: Grab errno.h and errno-base.h
  perf util: Introduce architecture specific errno/name mapping
  perf trace: Obtain errno values by using arch_syscalls__strerrno()
  perf trace: Remove audit-libs dependency if syscall tables are present

 tools/arch/alpha/include/uapi/asm/errno.h   | 128 +++++++++++++++++++++++++++
 tools/arch/mips/include/asm/errno.h         |  17 ++++
 tools/arch/mips/include/uapi/asm/errno.h    | 130 ++++++++++++++++++++++++++++
 tools/arch/parisc/include/uapi/asm/errno.h  | 128 +++++++++++++++++++++++++++
 tools/arch/powerpc/include/uapi/asm/errno.h |  10 +++
 tools/arch/sparc/include/uapi/asm/errno.h   | 118 +++++++++++++++++++++++++
 tools/arch/x86/include/uapi/asm/errno.h     |   1 +
 tools/include/uapi/asm-generic/errno-base.h |  40 +++++++++
 tools/include/uapi/asm-generic/errno.h      | 123 ++++++++++++++++++++++++++
 tools/perf/Makefile.config                  |  10 ++-
 tools/perf/Makefile.perf                    |  13 ++-
 tools/perf/builtin-help.c                   |   2 +-
 tools/perf/builtin-trace.c                  |  14 ++-
 tools/perf/check-headers.sh                 |   9 ++
 tools/perf/perf.c                           |   4 +-
 tools/perf/trace/beauty/arch_errno_names.c  |   1 +
 tools/perf/trace/beauty/arch_errno_names.sh | 100 +++++++++++++++++++++
 tools/perf/trace/beauty/beauty.h            |   2 +
 tools/perf/util/generate-cmdlist.sh         |   2 +-
 19 files changed, 841 insertions(+), 11 deletions(-)
 create mode 100644 tools/arch/alpha/include/uapi/asm/errno.h
 create mode 100644 tools/arch/mips/include/asm/errno.h
 create mode 100644 tools/arch/mips/include/uapi/asm/errno.h
 create mode 100644 tools/arch/parisc/include/uapi/asm/errno.h
 create mode 100644 tools/arch/powerpc/include/uapi/asm/errno.h
 create mode 100644 tools/arch/sparc/include/uapi/asm/errno.h
 create mode 100644 tools/arch/x86/include/uapi/asm/errno.h
 create mode 100644 tools/include/uapi/asm-generic/errno-base.h
 create mode 100644 tools/include/uapi/asm-generic/errno.h
 create mode 100644 tools/perf/trace/beauty/arch_errno_names.c
 create mode 100755 tools/perf/trace/beauty/arch_errno_names.sh

-- 
1.8.3.1
