From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Question perf annotate: how to free allocated memory of
 arch->instructions
Date: Thu, 18 Jan 2018 15:56:00 +0100
Message-ID: <aa217ab5-6920-cfa6-13e2-38feae4463b5@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43372 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756342AbeARO4J (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 18 Jan 2018 09:56:09 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0IEj1jt134416
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Jan 2018 09:56:09 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2fjujqfa6r-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Jan 2018 09:56:08 -0500
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Thu, 18 Jan 2018 14:56:04 -0000
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

I have a question regarding the struct arch and its initialization/un_initialization.

Function symbol__disassemble() invokes arch->init() once it has identified the archticture
its running on. 
When I execute command ./perf annotate --stdio I discovered that functions
arch__associate_ins_ops()
--> arch__grow_instructions()

are called to create/enlarge the array of machine instructions which require special
annotations like branches, jumps, etc to display arrows etc in the GUI. (At least on s390).

On ARM/ARM64 the arch->priv field also points to malloc'ed space needed for ARM specific
processing.

However there is no uninit() like function to remove any allocated memory and to clean up
before perf terminates.

Is this done on intention to rely on the exit of perf to release any allocated memory?
Are there plans to change this, that is invent an uninit() like function for proper memory free?
Where would be the best place to call this uninit() like function?

Thanks
-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
