Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC02C5519F
	for <linux-perf-users@archiver.kernel.org>; Wed, 18 Nov 2020 16:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BAF624835
	for <linux-perf-users@archiver.kernel.org>; Wed, 18 Nov 2020 16:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ffe8wuBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbgKRQhn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 18 Nov 2020 11:37:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59014 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725874AbgKRQhn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 18 Nov 2020 11:37:43 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AIGbeXI169112;
        Wed, 18 Nov 2020 11:37:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=to : cc : from : subject
 : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=g8MoWEQrUkbg6Xow9L7VByJNZkMRo/gP21k5U7kUm4E=;
 b=Ffe8wuBYlD5ErC1bwUUSYR+awBdL71XHApQU8AOVzt8tI2khPB1SfTw8A+p8rS3CKiLp
 eQoRcntgLDQO+8fWAVw3ns1/BtPzTyPxvOo3/SE+78z81JyYTOj8YF5rfXPpBkuXQPfH
 IkAC1TFDvglEegbUioMKt98UPGeihvaXJKWPWtOHuzIImYXGVzfm9BygI5ZKqTaBLomc
 Oq3yYwvGBflZs+t+Ym/RyxBypCb0IyRPNs1byKn6V5bFRHcRBAxoJZH+nSVv+ASEuAbK
 uRM1+wFi8HqserV5dmDFBiZxB1ykugYxB3R3G/dJlotL+ODshvO6qAMatAIKVSzLwA/f Nw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34w4xae1x3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Nov 2020 11:37:40 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AIGaxnR016705;
        Wed, 18 Nov 2020 16:37:31 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 34t6v8cb5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Nov 2020 16:37:31 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AIGbTcs29688088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Nov 2020 16:37:29 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17F4E42041;
        Wed, 18 Nov 2020 16:37:29 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8C1F4204D;
        Wed, 18 Nov 2020 16:37:25 +0000 (GMT)
Received: from oc3784624756.ibm.com (unknown [9.81.222.209])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 18 Nov 2020 16:37:25 +0000 (GMT)
To:     "linux-perf-use." <linux-perf-users@vger.kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
From:   Thomas Richter <tmricht@linux.ibm.com>
Subject: Fedora 33 and perf probe failures
Organization: IBM
Message-ID: <63cdd43f-c970-6c7e-b322-a41f6d418cf7@linux.ibm.com>
Date:   Wed, 18 Nov 2020 17:37:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-18_04:2020-11-17,2020-11-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 clxscore=1011
 malwarescore=0 phishscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011180113
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

I debugged the failure of some perf test cases on Fedora 33. The following
test cases fail on s390 and x86_64 using

[root@f33 yum.repos.d]# uname -a
Linux f33 5.9.8-200.fc33.x86_64 #1 SMP Tue Nov 10 21:58:19 UTC 2020
                                x86_64 x86_64 x86_64 GNU/Linux
[root@f33 yum.repos.d]#

[root@f33 yum.repos.d]# perf test -F 74 77 78
74: Use vfs_getname probe to get syscall args filenames
                :Failed to write event: Invalid argument
Error: Failed to add events.
FAILED!
77: Check open filename arg using perf trace + vfs_getname
                :Failed to write event: Invalid argument
Error: Failed to add events.
FAILED!
78: Add vfs_getname probe to get syscall args filenames
                :Failed to write event: Invalid argument
Error: Failed to add events.
FAILED!
[root@f33 yum.repos.d]#

The root cause is the output of perf probe -L which returns:
[root@f33 yum.repos.d]# perf probe -L getname_flags
Specified source line is not found.
Error: Failed to show lines.
[root@f33 yum.repos.d]#

whereas on my Fedora 32 installation this command shows
[root@t35lp46 perf]# cat /etc/redhat-release
Fedora release 32 (Thirty Two)
[root@t35lp46 perf]#

[root@t35lp46 perf]# ./perf probe -L getname_flags | tail -10
     68                         return ERR_PTR(-ENOENT);
                        }
                }

     72         result->uptr = filename;
     73         result->aname = NULL;
     74         audit_getname(result);
                return result;
}

[root@t35lp46 perf]#

Any ideas how to fix this? Is this failure related to a missing debuginfod
setup, even when I have installed the debuginfo packages for the kernel:

[root@f33 ~]# perf probe -L getname_flags
Specified source line is not found.
  Error: Failed to show lines.
[root@f33 ~]# uname -a
Linux f33 5.9.8-200.fc33.x86_64 #1 SMP Tue Nov 10 21:58:19 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
[root@f33 ~]# rpm -qa | fgrep kernel | fgrep debuginfo
kernel-debuginfo-common-x86_64-5.9.8-200.fc33.x86_64
kernel-debuginfo-5.9.8-200.fc33.x86_64
kernel-tools-debuginfo-5.9.7-200.fc33.x86_64
[root@f33 ~]#
~                          

Thanks a lot
-- 
Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
