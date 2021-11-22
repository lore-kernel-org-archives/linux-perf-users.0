Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3161CC433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 Nov 2021 16:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbhKVQH6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 Nov 2021 11:07:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55414 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233158AbhKVQH4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 Nov 2021 11:07:56 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AMEba4h022124;
        Mon, 22 Nov 2021 16:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : cc : from : subject : content-type :
 content-transfer-encoding; s=pp1;
 bh=QrOtHv2NVw9GkaQcDN/R/RCs9RLE5GZ0m3O0mYgHZF4=;
 b=nZxAK7nyQai3rPxrap5kuTVrfioN4qwOjlkBWzwmE9l5G7mqezxgFu3Qj2drIoq6qg/a
 SaoXXCWceIR194YxT/qnIlwKkz4TclHs3L23UWxVbxumr6TtZxx4FYWc46erFStfELsM
 JveQqAAPGuPPwdNfMiFPKiT9Y19Rel2ZKcxIYqlPtaHxlCNf9tcsWZONu0YHS164r//R
 S4P9oNtBVES0bmohLtesTQh8z842e6FDXdoKIhhtU+WDupSKVEVd162/HH5NfINWrzs3
 AYv0s1wPgOKsYtWR0hdx5BONSc+IuMPsB6LLwtf3VNrILAI34cafY38A4IxIuIKjVypP HA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cgbebvrrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 16:04:49 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AMFghUk012090;
        Mon, 22 Nov 2021 16:04:48 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cgbebvrqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 16:04:48 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AMFqRbJ021489;
        Mon, 22 Nov 2021 16:04:46 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3cern97bas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 16:04:46 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AMG4gL318481434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 16:04:42 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0401AE056;
        Mon, 22 Nov 2021 16:04:42 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CE12AE055;
        Mon, 22 Nov 2021 16:04:42 +0000 (GMT)
Received: from [9.145.34.198] (unknown [9.145.34.198])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 22 Nov 2021 16:04:42 +0000 (GMT)
Message-ID: <56480f10-4b9f-e88f-7c67-9158868a8e44@linux.ibm.com>
Date:   Mon, 22 Nov 2021 17:04:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     irogers@google.com, Arnaldo Carvalho de Melo <acme@kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
From:   Thomas Richter <tmricht@linux.ibm.com>
Subject: Perf test 7 fails on s390 (perf expr: Add metric literals for
 topology)
Organization: IBM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RMeSkxiJBvlhWPXW-KjmAiTHLSZkcwGc
X-Proofpoint-ORIG-GUID: P4iPLKLfTcam65QGpZgE3kBUce8LzF8v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-22_08,2021-11-22_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 spamscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111220082
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Commit fdf1e29b6118 ("perf expr: Add metric literals for topology.")
fails on s390:
 
 # ./perf test -Fv 7
   ...
 # FAILED tests/expr.c:173 #num_dies >= #num_packages
   ---- end ----
   Simple expression parser: FAILED!
 #                    
Investigating this issue leads to function:
   static bool has_die_topology(void)
   {                                
        char filename[MAXPATHLEN];
        struct utsname uts;
                                                
        if (uname(&uts) < 0)    
                return false;

        if (strncmp(uts.machine, "x86_64", 6)) 
                return false;  
                                                             
        ....
   }
which always return false on s390.
When I get this right, there is no build up of CPU topology with
dies on s390. The the #num_dies value in above test is always zero
and lower than the #num_packages field.

I am also suprised by the architecture specific code in a common
code function. Wouldn't it be better to define a weak function with
archticture specfic overrides?

Is this intended?
What is the recommended approach for other architectures?
Should I skip this test on s390?
Should s390 invent die for CPUs mapping?

Thanks a lot for your help and advice.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
