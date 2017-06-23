From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: perf tool: perf mem not working on s390x
Date: Fri, 23 Jun 2017 09:28:53 +0200
Message-ID: <4ad64b13-5ed4-a8f0-9a3a-2748663bb5a2@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60093 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751230AbdFWH3A (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jun 2017 03:29:00 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v5N7Sn8j130174
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2017 03:28:59 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2b8x7t0wdw-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2017 03:28:59 -0400
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Fri, 23 Jun 2017 08:28:57 +0100
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>


When I run perf mem ... it fails with

[root@s8360046 perf]# ./perf mem record -- sleep 1
failed: memory events not supported
[root@s8360046 perf]

That is currently not working on s390.
When I look into the code, the perf mem command is looking for sysfs files in

-r--r--r-- 1 root root 4096 Jun  9 11:02 /sys/devices/cpu/events/mem-loads
-r--r--r-- 1 root root 4096 Jun  9 11:02 /sys/devices/cpu/events/mem-stores

Those 2 sysfs files do not exist on a s390. In fact there is a different
subdirectory tree.

I am not sure how this is handled on the s390 at all. I would have expected
perf mem to somehow retrieve the event numbers and then feed perf record
with these event numbers.
Any comments/ideas on how to handle this?
-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
