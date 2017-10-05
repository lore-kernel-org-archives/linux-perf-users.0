From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: perf tool and mount name space questions
Date: Thu, 5 Oct 2017 14:55:51 +0200
Message-ID: <3803b12b-171e-0a49-e6d0-224e4d7275c9@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54924 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751820AbdJEMz7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 5 Oct 2017 08:55:59 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v95CtagW103602
        for <linux-perf-users@vger.kernel.org>; Thu, 5 Oct 2017 08:55:59 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ddkp2d522-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Oct 2017 08:55:59 -0400
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Thu, 5 Oct 2017 13:55:55 +0100
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Krister Johansen <kjlx@templeofstupid.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Brendan Gregg <brendan.d.gregg@gmail.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

Hi all,

I investigate perf mount name space support added recently and have
some questions on how to use it. I use 4.14.0-rc1

I start a small self made container with its own mount and pid
name space and root file system.
The container has a few executables such as ps, bash,
hostname, ls, find, stty, ip and all required libraries. The container
is started from my bash using:

unshare -f -n -u -p -m chroot /tmp/tryfs /con-init.sh

con-init.sh is my simple init process which mounts /proc
and /tmp and then spawns a bash shell and waits for its termination.
Container is started and runs as expected. I can type some commands
and see the correct output.

Now my questions regarding perf:
Question 1:

I run command 'perf record -a' to gather perf data until
I hit ctrl-C. I then invoke 'perf report' for display.
How to handle a process in the container which exited before the
command 'perf report' runs?

The call chain is thread__new() --> nsinfo__new() --> nsinfo__init()
and when the process already exited nsinfo__init() sets need_setns to
false because /proc/<PID>/ns/mnt is gone.
How to display correct information for a process inside the container
which has exited before the perf report command runs?

The same issue pops up when I invoke
- perf record -p XXX --inherit
  where XXX is the PID of my container init process. And I see only
  the children of the init process, not the complete process tree.
  Is there a better way to see the container process tree?

- perf record unshare -f -n -u -p -m chroot /tmp/tryfs /con-init.sh
  has the same issue. Command 'perf report' later on has no mount
  name space access to the processes executed inside of the container.


Question 2:

In function dso__load() --> dso__find_perf_map() tests for a dso name
starting with "/tmp/perf-". If true, it assumes a file with the name
/tmp/perf-<container-pid>.map exists.
But in function map__new() such dso names are created only for 
certain types such anonymous memory or heaps, etc. See:
   if ((anon || no_dso) && nsi && type == MAP__FUNCTION) {

I think those /tmp/perf-*.map files or dso names do not exist 
for normal containers. Is this correct?

Question 3:
I investigate the PERF_RECORDS_xxx shown with command 'perf report -D':
I see for example the init process of my container, PID 28093:
  PERF_RECORD_FORK(28093:28093):(28090:28090)
  PERF_RECORD_NAMESPACES 28093/28093 - nr_namespaces: 7
  PERF_RECORD_COMM: /myinit:28093/28093
  PERF_RECORD_MMAP2 28093/28093: .... /tmp/tryfs/myinit
  PERF_RECORD_MMAP2 28093/28093: .... /tmp/tryfs/lib64/libc.so.6
  ...
This init process now forks off a bash (PID 28100):
  PERF_RECORD_FORK(28100:28100):(28093:28093)
  PERF_RECORD_NAMESPACES 28100/28100 - nr_namespaces: 7
  PERF_RECORD_COMM: bash:28100/28100
  PERF_RECORD_MMAP2 28100/28100: .... /tmp/tryfs/usr/bin/bash
  PERF_RECORD_MMAP2 28100/28100: .... /tmp/tryfs/lib64/libc.so.6
  ...
Both processes are in the new mount name space setup by the unshare process.
The fully qualified path name ensures one can read the correct file for 
symbol resolvement in the newly setup root file system of the container.

However when I type 'ls' in my container's bash, I see this in the
perf.data file as:
   PERF_RECORD_FORK(28103:28103):(28100:28100)
   PERF_RECORD_NAMESPACES 28103/28103 - nr_namespaces: 7
   PERF_RECORD_COMM exec: ls:28103/28103
   PERF_RECORD_MMAP2 28103/28103: .... /usr/bin/ls
   PERF_RECORD_MMAP2 28103/28103: .... /lib64/libc.so.6

Now command 'perf report' will look up ls and libc.so.6 in its root file system,
not in the container's root file system. This is ok as long as both files are
identical. How to handle this in case they differ?


Question 4:
Maybe I took the wrong approach, so what is the best way for the perf tool
to be applied on a container, for example one created with docker?

Thanks a lot for your help.

-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
