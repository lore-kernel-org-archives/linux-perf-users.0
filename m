From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: perf report does not resolve symbols on s390x
Date: Wed, 5 Jul 2017 16:45:49 +0200
Message-ID: <eb00bf70-936d-e405-5867-015d4067202f@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54677 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751680AbdGEOpy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Jul 2017 10:45:54 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v65EiFEg006987
        for <linux-perf-users@vger.kernel.org>; Wed, 5 Jul 2017 10:45:53 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bgvtxxfad-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Jul 2017 10:45:53 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Wed, 5 Jul 2017 15:45:51 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v65Ejo8J41353318
        for <linux-perf-users@vger.kernel.org>; Wed, 5 Jul 2017 14:45:50 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C29D4C040
        for <linux-perf-users@vger.kernel.org>; Wed,  5 Jul 2017 15:43:40 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA9FB4C044
        for <linux-perf-users@vger.kernel.org>; Wed,  5 Jul 2017 15:43:39 +0100 (BST)
Received: from oc2666213455.ibm.com (unknown [9.152.212.64])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP
        for <linux-perf-users@vger.kernel.org>; Wed,  5 Jul 2017 15:43:39 +0100 (BST)
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>

I use linux 4.12 kernel and the perf report --stdio does not resolve all symbols:
Only very few symbols are resolved and none listed in the call back chain.

Here is an example:

    50.00%    50.00%  true     [kernel.vmlinux]  [k] __rb_insert_augmented
            |
            ---0x6a0624
               0x2d7c00
               0x2d79c8
               0x2b5a26
               0x2da542
               0x2da01a
               0x2d6c2e
               0x2d6b86

    50.00%     0.00%  true     [unknown]         [k] 0x000000000011e90a
            |
            ---0x11e90a
               0x2d39a4
               0x2d3238
               0x288140
               0x2cf404
               0x2df5d8
               0x31618c
               0x19b0ae

These addresses are all in the /proc/kallsyms and valid.

When I do a perf script it works:
[root@s8360046 perf]# perf script
true  4384  7991.047063:     250000 cpu-clock: 
                  19c0ae lock_acquire (/lib/modules/4.12.0perf+/build/vmlinux)
                  31718c lock_page_memcg (/lib/modules/4.12.0perf+/build/vmlinux)
                  2e05d8 page_add_file_rmap (/lib/modules/4.12.0perf+/build/vmlinux)
                  2d0404 alloc_set_pte (/lib/modules/4.12.0perf+/build/vmlinux)
                  289140 filemap_map_pages (/lib/modules/4.12.0perf+/build/vmlinux)
                  2d4238 __handle_mm_fault (/lib/modules/4.12.0perf+/build/vmlinux)
                  2d49a4 handle_mm_fault (/lib/modules/4.12.0perf+/build/vmlinux)
                  11f90a do_dat_exception (/lib/modules/4.12.0perf+/build/vmlinux)
                  6a1962 pgm_check_handler (/lib/modules/4.12.0perf+/build/vmlinux)


Any ideas in which area of the perf report tool to dig into to get this fixed.

When I use -vvvvv I see all kernel symbols read in and listed, so I fail to see
why they are not resolved.
Maybe someone can point me to the area of code to start digging.

Thanks a lot.

-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
