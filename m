From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: perf build failure on Fedora 27 and linux kernel 4.15.0-rc2
Date: Thu, 7 Dec 2017 14:27:42 +0100
Message-ID: <a15a874d-429f-7d8b-1376-54fa0d01e2b8@linux.vnet.ibm.com>
References: <5cb4b853-4114-6106-b795-b520c0745fbc@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41650 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755435AbdLGN1s (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Dec 2017 08:27:48 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vB7DPZVa070965
        for <linux-perf-users@vger.kernel.org>; Thu, 7 Dec 2017 08:27:47 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2eq4jgx6q7-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Dec 2017 08:27:47 -0500
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Thu, 7 Dec 2017 13:27:45 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id vB7DRhU932899168
        for <linux-perf-users@vger.kernel.org>; Thu, 7 Dec 2017 13:27:43 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF897AE04D
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Dec 2017 13:20:38 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B27CDAE045
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Dec 2017 13:20:38 +0000 (GMT)
Received: from oc3784624756.ibm.com (unknown [9.152.212.64])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Dec 2017 13:20:38 +0000 (GMT)
In-Reply-To: <5cb4b853-4114-6106-b795-b520c0745fbc@linux.vnet.ibm.com>
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>

On 12/07/2017 02:03 PM, Thomas-Mich Richter wrote:
>  Maybe its me doing something wrong.
> I just installed a KVM virtual machine on my x86 notebook (lenovo P50) with Fedora 27 workstation.
> I then downloaded latest 4.15.0rc2 linux kernel and compiled and installed it.
> This went fine, then I decided to build the perf tool and got this error:
> 
> 
>  GEN      python/perf.so
> /usr/bin/ld: perf-in.o: relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a shared object; recompile with -fPIC
> /usr/bin/ld: libperf.a(libperf-in.o): relocation R_X86_64_32S against `.text' can not be used when making a shared object; recompile with -fPIC
> /usr/bin/ld: final link failed: Nonrepresentable section on output
> collect2: error: ld returned 1 exit status
> make[2]: *** [Makefile.perf:507: perf] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [Makefile.perf:210: sub-make] Error 2
> make: *** [Makefile:70: all] Error 2
> [root@localhost-live perf]# 
> 
> 
> Any ideas? Is this just on a KVM guest? Thanks for any help.
> 

To remedy above build issue, here is the fix:

root@localhost-live perf]# git diff
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index ed65e82f034e..263611caaf7b 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -41,6 +41,7 @@ ifeq ($(SRCARCH),x86)
     LIBUNWIND_LIBS = -lunwind-x86 -llzma -lunwind
   endif
   NO_PERF_REGS := 0
+  CFLAGS += -fPIC
 endif
 
 ifeq ($(SRCARCH),arm)
[root@localhost-live perf]# 


-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
