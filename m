From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Question to struct map
Date: Tue, 12 Sep 2017 17:04:53 +0200
Message-ID: <1d758097-b01b-cbad-913a-855a61f8ce73@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46288 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751404AbdILPFA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Sep 2017 11:05:00 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8CEwpJd142404
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Sep 2017 11:04:59 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2cxgjfn958-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Sep 2017 11:04:59 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Tue, 12 Sep 2017 16:04:57 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v8CF4sbW10813692
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Sep 2017 15:04:54 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC8AD4C040
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Sep 2017 16:01:28 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B04FE4C058
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Sep 2017 16:01:28 +0100 (BST)
Received: from oc2666213455.ibm.com (unknown [9.152.212.92])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Sep 2017 16:01:28 +0100 (BST)
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>

Hi all,

I have a question regarding struct map. 
What is the purpose is the functions pointers in struct map named map_ip and unmap_ip?
How do they relate the to dso the struct map is refering to?

This is not clear to me. Must have been on vacation for too long :-).

Thanks a lot.
-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
