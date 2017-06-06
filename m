From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf: fix perf test case 14 result reporting
Date: Tue, 6 Jun 2017 07:02:57 +0200
Message-ID: <d7afbf7d-9ac8-20d6-5a5a-f20df660379d@linux.vnet.ibm.com>
References: <20170601123441.24581-1-tmricht@linux.vnet.ibm.com>
 <20170601132038.GG2899@kernel.org> <20170601210451.GA5713@krava>
 <c06b8134-4636-c14f-c580-8b45e5256093@linux.vnet.ibm.com>
 <20170602140936.GO2899@kernel.org> <20170602141105.GP2899@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34799 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750736AbdFFFDF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Jun 2017 01:03:05 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v564wudc104705
        for <linux-perf-users@vger.kernel.org>; Tue, 6 Jun 2017 01:03:04 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2awb7cf4jm-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Jun 2017 01:03:04 -0400
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Tue, 6 Jun 2017 06:03:02 +0100
In-Reply-To: <20170602141105.GP2899@kernel.org>
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, linux390-list@tuxmaker.boeblingen.de.ibm.com

On 06/02/2017 04:11 PM, Arnaldo Carvalho de Melo wrote:

[....]

>>
>> If you have specific patches in Jiri's branch that you think are good to
>> go, just point me to them and I'll cherry-pick them.
>>
>> I'm looking now at the one you pointed out above (070b9644981e).
> 
> Just looked, but the cset comment should state what is the problem and
> how it is solved, right now it has just a one line summary :-\
> 
> - Arnaldo
> 

Looks like a misunderstanding. When I clone Jiri's tree and checkout
branch perf/attr_test:

url = git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git

oc2666213455 12 $ git branch
  master
* perf/attr_test
  perf/stat
oc2666213455 13 $ git show 070b9644981e
commit 070b9644981e2dd160a6aae2723d0ec2d8b4c0b5
Author: Jiri Olsa <jolsa@kernel.org>
Date:   Fri Mar 3 15:59:45 2017 +0100

    perf tests attr: Do not store failed events

diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
index 0dd7749..0f2b619 100644
--- a/tools/perf/tests/attr.c
+++ b/tools/perf/tests/attr.c
@@ -138,7 +138,7 @@ void test_attr__open(struct perf_event_attr *attr, pid_t pid, int cpu,
 {
        int errno_saved = errno;
 
-       if (store_event(attr, pid, cpu, fd, group_fd, flags))
+       if ((fd != -1) && store_event(attr, pid, cpu, fd, group_fd, flags))
                die("test attr FAILED");
 
        errno = errno_saved;
oc2666213455 14 $ 

I get this commit which is another fix for an issue I discovered last week
while working on test case 14.

-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
