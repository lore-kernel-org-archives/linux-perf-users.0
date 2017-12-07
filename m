From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: perf build failure on Fedora 27 and linux kernel 4.15.0-rc2
Date: Thu, 7 Dec 2017 14:03:49 +0100
Message-ID: <5cb4b853-4114-6106-b795-b520c0745fbc@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55738 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754956AbdLGND4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Dec 2017 08:03:56 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vB7D11bP076195
        for <linux-perf-users@vger.kernel.org>; Thu, 7 Dec 2017 08:03:55 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2eq4b2xf91-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Dec 2017 08:03:54 -0500
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Thu, 7 Dec 2017 13:03:53 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id vB7D3oDU51773674
        for <linux-perf-users@vger.kernel.org>; Thu, 7 Dec 2017 13:03:50 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4555B5203F
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Dec 2017 11:57:02 +0000 (GMT)
Received: from oc3784624756.ibm.com (unknown [9.152.212.64])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2695052054
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Dec 2017 11:57:02 +0000 (GMT)
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>

 Maybe its me doing something wrong.
I just installed a KVM virtual machine on my x86 notebook (lenovo P50) with Fedora 27 workstation.
I then downloaded latest 4.15.0rc2 linux kernel and compiled and installed it.
This went fine, then I decided to build the perf tool and got this error:


 GEN      python/perf.so
/usr/bin/ld: perf-in.o: relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a shared object; recompile with -fPIC
/usr/bin/ld: libperf.a(libperf-in.o): relocation R_X86_64_32S against `.text' can not be used when making a shared object; recompile with -fPIC
/usr/bin/ld: final link failed: Nonrepresentable section on output
collect2: error: ld returned 1 exit status
make[2]: *** [Makefile.perf:507: perf] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile.perf:210: sub-make] Error 2
make: *** [Makefile:70: all] Error 2
[root@localhost-live perf]# 


Any ideas? Is this just on a KVM guest? Thanks for any help.
-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
