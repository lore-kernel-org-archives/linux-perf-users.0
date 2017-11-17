From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: Running perf in namespaces and questions on its isolation
Date: Fri, 17 Nov 2017 16:32:24 +0100
Message-ID: <20171117153224.GE4347@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50960 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965139AbdKQPcb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 10:32:31 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAHFTOxH126869
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Nov 2017 10:32:30 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2e9y9p1df1-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Nov 2017 10:32:30 -0500
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <brueckner@linux.vnet.ibm.com>;
        Fri, 17 Nov 2017 15:32:28 -0000
Content-Disposition: inline
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users@vger.kernel.org
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

Hi Arnaldo, et al.,

I have just played around with running perf within a namespace. Beside an
issue with namespace copying for which I have already posted a patch, I
have a more general issue:

I created a (PID) namespace has been created by using:
"unshare --fork --pid --mount-proc /bin/bash".

Within the created PID namespace, a "perf record -a -e cpu-clock" session is
started.  While it runs, perform some commands outside of this namespace,
for example, df, find, cat.

Then, perf record is stopped and its report reads:

perf report --stdio --sort comm,pid
# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 158K of event 'cpu-clock'
# Event count (approx.): 39529250000
#
# Overhead  Command      Pid:Command
# ........  .......  ...............
# 
    32.93%  df             0:df
    29.45%  find           0:find
    25.09%  swapper        0:swapper
    12.48%  cat            0:cat
     0.05%  perf          67:perf


According to this output, perf record receives PERF_RECORD_COMM events
of processes from outside its namespace.  The is also indicated by the
PID 0. (Processes that do not exist in a PID namespace (where perf record
ran) are translated to zero.  See also perf_event_pid() in
kernel/events/core.c).

I wonder whether this is the intended behavior or should better be fixed to
provide isolation among different namespace.  Further, with user stack
sampling, an namespace could also access stack information from processes
running in a different namespace.  That might result in an security issue.

So it would be great to know and understand what the correct behavior of
running perf within a namespace would be.

Thanks.

Kind regards,
  Hendrik
