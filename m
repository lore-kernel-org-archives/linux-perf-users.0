From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Ping for perf patches
Date: Thu, 28 Sep 2017 08:48:16 +0200
Message-ID: <25eec9de-ec47-9651-9fde-3f73e27814f2@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38040 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750794AbdI1GsW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Sep 2017 02:48:22 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8S6hcHB124686
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Sep 2017 02:48:22 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2d8kkfy853-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Sep 2017 02:48:22 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Thu, 28 Sep 2017 07:48:19 +0100
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>

Hi all,

I recently posted a few patches, which probably got lost in the meantime:

These 2 are for the perf test attr (now test 16):

- [PATCH 1/2] perf test attr: fix python error on empty result
- [PATCH 2/2] perf test attr: fix ignored test case result
Both have been ack'ed by Jiri.

The next 2 are s390x specific changes I submitted back in July/August but
need to be reverted and I submitted the reverting patches some week ago:

- [PATCH 1/2] perf test: fix vmlinux failure on s390x
- [PATCH 2/2] perf test: fix vmlinux failure on s390x part 2

I am not sure if they are still in the review process or if they
got lost? Should I resubmit them?

Apologies for the trouble.

Thanks.
-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
