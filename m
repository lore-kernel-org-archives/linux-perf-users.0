Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C5EC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Nov 2021 09:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBD2A60EE2
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Nov 2021 09:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbhKLJdg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 12 Nov 2021 04:33:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6548 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234811AbhKLJdf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 Nov 2021 04:33:35 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AC9IFDX012623
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Nov 2021 09:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : from : subject : content-type :
 content-transfer-encoding; s=pp1;
 bh=vX/Rba8TeAA95s6MZkdbJd6PXtdhd0pnQZaTZNF6jVs=;
 b=k+t2pLbyEZMRZ6KCKwFOa0XAj5ULO+hIC3u7BHGTBu2wT+aW+jzBs7b/zqlhACcA1B8l
 +IQon+3YyzQ4cZWB0oLp/x0Vq2lkEjd8WWMvST1mKaSSUWgyN9UH9s1LDA31RJmQn4RQ
 HEk9UaKdVBs9LphkBdAKTTQi4Xk7amLfw8jpcFssalBmoYeAsp63XgMBBSdC8of+09Fm
 hSmsCErcG3eyf9MW9ras+60JsmWoyWWo4Uq9HZAr+M5Ct9DvzP9AIQfuqZizkJ6nSAcw
 1Z6g3naDcuYKGtloyUZo1B5+lFkP2G+RmxGwn6K9YdsCYEqpCWfNwym/dhldb4rLPu8r Aw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c9nh4r6hn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Nov 2021 09:30:45 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AC9HvFG030645
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Nov 2021 09:30:36 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 3c5gykunv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Nov 2021 09:30:36 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AC9UY3U65143208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Nov 2021 09:30:34 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 172DE4C05A
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Nov 2021 09:30:34 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0408F4C06D
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Nov 2021 09:30:34 +0000 (GMT)
Received: from [9.152.212.95] (unknown [9.152.212.95])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Nov 2021 09:30:33 +0000 (GMT)
Message-ID: <13ec9620-dbd6-a8a9-b51d-46aaec764351@linux.ibm.com>
Date:   Fri, 12 Nov 2021 10:30:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     "linux-perf-use." <linux-perf-users@vger.kernel.org>
From:   Thomas Richter <tmricht@linux.ibm.com>
Subject: Counting page fault per PID
Organization: IBM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kyIBLgIJxlIimFGfjM3OZTIqvRJ_jEDB
X-Proofpoint-ORIG-GUID: kyIBLgIJxlIimFGfjM3OZTIqvRJ_jEDB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-12_03,2021-11-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111120053
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

I have a question regarding perf tool usage. I would like to know
which process caused how many page faults?

I ran these commands:

 # perf stat -e faults -a -- sleep 4 &
 # find / -ls > /dev/null 2>&1 &
 # dd if=/dev/zero of=/dev/null bs=1M count=10K &
Performance counter stats for 'system wide':

               606      faults

       3.994941053 seconds time elapsed

This tells me 606 page faults in total, but how to find out how many
page faults did hit my two processes dd and find?

When I do this
 # perf report -e faults -a -- sleep 4 &
 # find / -ls > /dev/null 2>&1 &
 36033
 # dd if=/dev/zero of=/dev/null bs=1M count=10K &
 36034
 sleep 4

Now I have a perf.data file and can check for PERF_RECORD_SAMPLE from
pid 36033 and 36034? Is the number of sample entries for pid 36034 identical
with the page faults?

PERF_RECORD_FORK(36034:36034):(36031:36031)
PERF_RECORD_COMM: dd:36034/36034
...
PERF_RECORD_SAMPLE(IP, 0x2): 36034/36034: 0x3ffbaa12d00 period: 1 addr: 0
 ... thread: dd:36034
PERF_RECORD_SAMPLE(IP, 0x2): 36034/36034: 0x3ffba978cc4 period: 1 addr: 0
 ... thread: dd:36034
PERF_RECORD_SAMPLE(IP, 0x2): 36034/36034: 0x3ffba978d02 period: 1 addr: 0
 ... thread: dd:36034
PERF_RECORD_SAMPLE(IP, 0x2): 36034/36034: 0x3ffba9768d2 period: 2 addr: 0
 ... thread: dd:36034
PERF_RECORD_SAMPLE(IP, 0x2): 36034/36034: 0x3ffba961550 period: 9 addr: 0
 ... thread: dd:36034
PERF_RECORD_EXIT(36034:36034):(36031:36031)

Since I detect 5 sample entries from dd command, I can attribute 5 page
faults to the running dd command?

Thanks a lot.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
