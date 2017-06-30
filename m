From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: perf and containers
Date: Fri, 30 Jun 2017 09:00:22 +0200
Message-ID: <01937385-b6d9-d7d4-0d41-3869b1b7bb48@linux.vnet.ibm.com>
References: <CAE40pdcP42zaBP_nZa1rdG7D6gDA-X2+Y6FbMfkzfkgFTnz3qA@mail.gmail.com>
 <20170630021654.GE12064@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50645 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751532AbdF3HA3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Jun 2017 03:00:29 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v5U6xMpk036346
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2017 03:00:28 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bdf26pd4f-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2017 03:00:28 -0400
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Fri, 30 Jun 2017 08:00:26 +0100
In-Reply-To: <20170630021654.GE12064@kernel.org>
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

On 06/30/2017 04:16 AM, Arnaldo Carvalho de Melo wrote:

[...SNIP..]

I ran into a very similar issue when I tried the latest kernel 4.12 perf name space support.
I was able to find the new PERF_RECORD_NAMESPACE entries in the perf.data file 
but do not know how to interpret the ino-numbers shown in those entries.
Right now the wrong symbols will be displayed...

How to interpret the inode numbers the perf NAMESPACE event emits?

I am interested on to resolve this.

In my experiment there are 3 files involved: setup.sh, setup-app.sh and hello

setup.sh: prints its pid and invokes setup-app.sh via command unshare to get a new mount namespace.
setup-app.sh: prints its pid and replaces /bin/bash with hello via bind-mount and executes /bin/bash. (which in fact executes hello)
hello: prints out the inode number of its mount namespace.

The issue which shows up is detailed below. 
Finally program hello is executed using the name bash and the perf report tools has no way of knowing that
bash actually refers to hello in that mount name space and incorrect symbol names are displayed.

[root@s8360046 perf]# cat setup.sh
echo $0 pid $$
exec unshare -m  ./setup-app.sh

[root@s8360046 perf]# cat setup-app.sh
echo $0 pid $$ 
mount -B ./hello /bin/bash
exec /bin/bash

[root@s8360046 perf]# cat hello.c 
#include	<stdio.h>
#include	<unistd.h>
#include	<stdlib.h>
#include	<string.h>
#include	<sys/types.h>
#include	<sys/stat.h>

int main(int argc, char **argv)
{
	struct stat st;

	printf("%s hallo world pid:%d\n", *argv, getpid());
	if (stat("/proc/self/ns/mnt", &st) == 0) {
                printf("dev_id:%d ino:%ld\n", st.st_dev, st.st_ino);
        }
}


Now when you run the command 

[root@s8360046 perf]# ~/linux/tools/perf/perf record --namespace -- ./setup.sh
./setup.sh pid 26180
./setup-app.sh pid 26180
/bin/bash hallo world pid:26180
dev_id:3 ino:4026532057
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.017 MB perf.data (114 samples) ]
[root@s8360046 perf]#

Now running 
[root@s8360046 perf]# ~/linux/tools/perf/perf report -D 
highlights the following events:

180378841576860 0x3348 [0x98]: PERF_RECORD_NAMESPACES 26180/26180 - nr_namespaces: 7
                [0/net: 3/0xf000002b, 1/uts: 3/0xf00000da, 2/ipc: 3/0xefffffff, 3/pid: 3/0xeffffffc, 
                 4/user: 3/0xeffffffd, 5/mnt: 3/0xf00000d9, 6/cgroup: 3/0xeffffffb]

---> new mount namespace created 0xf00000d9 is 4026532057 in decimal as printed by program hello. This namespace was created with command unshare -m

180378879643837 0x2c78 [0x28]: PERF_RECORD_COMM exec: bash:26180/26180
--> new executable bash is started (which is actually hello)

180378879685931 0x2ca0 [0x68]: PERF_RECORD_MMAP2 26180/26180: [0x1000000(0x1000) @ 0 5e:01 813431 692173762]: r-xp /usr/bin/bash
--> new map command for hello, but it refers to bash (due to the mount bind).

I wonder on how to find out that the MMAP2 command for /usr/bin/bash actually refers to a totally different file, namely hello in the local directory.
How can the perf report tool find out which namespace to use for the MMAP2 event for /usr/bin/bash?

Thanks a lot.
-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
