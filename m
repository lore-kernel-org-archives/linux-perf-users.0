Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E019DC4743C
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Jun 2021 14:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6BC16112D
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Jun 2021 14:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhFWOXn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Jun 2021 10:23:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9089 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231318AbhFWOXm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Jun 2021 10:23:42 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15NE3eXe024502;
        Wed, 23 Jun 2021 10:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=to : cc : from : subject
 : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=rRtJqAwGl7ngRa6U9YNbeiVnCpZHBx4ug6KaIdc2shU=;
 b=qj9/plU5sDt+YQCNur5+8RMpkLb8DQXkAOsBs90vMf32I9Lfxj8u/aAbBwcovdULvchD
 PsU0qphbR6B+hhrFE6HrgEt48V7CqkETnESoHPj34sMrIaMvDZQM98JJCFP4gglynSNm
 hxwidls1A948zbJryDQccqVBKBiIDq70/8cSd+ktDPm0y/bF+HtBdJzu/m3nl7EuA0m4
 QZxZbpDEi8tB8gEy+qvSNGyCE/uDwsX+4GqEJYdXogtaUvrnzPBKtj2fo/BY5FCSTMSU
 LFoY8AXXdaRC/I7G/BNxSB+uOGhY1cWh4hLDYju9dAeApZ6g888C+8ZDupHAFAsnP4EO lg== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39c5g2ax0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Jun 2021 10:21:23 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15NEDDnn005017;
        Wed, 23 Jun 2021 14:21:21 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 39987894k2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Jun 2021 14:21:21 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15NEJtpj22806824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jun 2021 14:19:55 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5181AA4060;
        Wed, 23 Jun 2021 14:21:18 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20C97A405C;
        Wed, 23 Jun 2021 14:21:18 +0000 (GMT)
Received: from li-e35baacc-2106-11b2-a85c-8f97eb669a6e.ibm.com (unknown [9.145.74.209])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 23 Jun 2021 14:21:18 +0000 (GMT)
To:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
From:   Thomas Richter <tmricht@linux.ibm.com>
Subject: perf test case probe libc fails with latest Fedora34 glibc update
Organization: IBM
Message-ID: <cae863a4-bf83-f87b-6e71-b6a544678cae@linux.ibm.com>
Date:   Wed, 23 Jun 2021 16:21:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8QH4d75QFj8u5glHIgAQk9vzEkgEf4cv
X-Proofpoint-ORIG-GUID: 8QH4d75QFj8u5glHIgAQk9vzEkgEf4cv
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-23_09:2021-06-23,2021-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106230082
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

I just updated Fedora34 to the latest level and discovered that perf test 78 fails:
[root@m46lp22 perf]# ./perf test 78
78: probe libc's inet_pton & backtrace it with ping                 : FAILED!
[root@m46lp22 perf]#

It boils down to this command and happens after glibc is update to level 2.33-18.

[root@f34 ~]# perf probe -f -x /usr/lib64/libc-2.33.so -a inet_pton
Probe point 'inet_pton' not found.
  Error: Failed to add events.
[root@f34 ~]# rpm -qa | fgrep glibc
glibc-all-langpacks-2.33-18.fc34.x86_64
glibc-common-2.33-18.fc34.x86_64
glibc-langpack-en-2.33-18.fc34.x86_64
glibc-2.33-18.fc34.x86_64
glibc-doc-2.33-18.fc34.noarch
glibc-headers-x86-2.33-18.fc34.noarch
glibc-devel-2.33-18.fc34.x86_64
glibc-debugsource-2.33-18.fc34.x86_64
glibc-debuginfo-2.33-18.fc34.x86_64
[root@f34 ~]# 

The symbol inet_pton is now in the .dynsym section of glibc:
[root@f34 ~]# readelf -sW /usr/lib64/libc-2.33.so | egrep '(dynsym|symtab|inet_pton)'
Symbol table '.dynsym' contains 2419 entries:
   628: 000000000011ea00   108 FUNC    WEAK   DEFAULT   15 inet_pton@@GLIBC_2.2.5
  2251: 000000000011e9b0    76 FUNC    GLOBAL DEFAULT   15 __inet_pton_length@@GLIBC_PRIVATE
Symbol table '.symtab' contains 104 entries:
[root@f34 ~]#

The .symtab section does not contain symbol inet_pton. It contains very few symbols
compared to previous versions.

Now perf does not find it. In the older version of the library the
symbol inet_pton was listed in the .symtab section. Here is the output from version 2.32-4:


[root@m35lp76 ~]# rpm -qa | fgrep glibc
glibc-common-2.32-4.fc33.s390x
glibc-langpack-en-2.32-4.fc33.s390x
glibc-2.32-4.fc33.s390x
glibc-headers-s390-2.32-4.fc33.noarch
glibc-devel-2.32-4.fc33.s390x
glibc-debuginfo-common-2.32-4.fc33.s390x
glibc-debuginfo-2.32-4.fc33.s390x
[root@m35lp76 ~]# 


readelf -sW /usr/lib64/libc-2.32.so | egrep '(dynsym|symtab|inet_pton)'
Symbol table '.dynsym' contains 2604 entries:
   668: 00000000001444b0   788 FUNC    WEAK   DEFAULT   13 inet_pton@@GLIBC_2.2
  2418: 00000000001441b0   764 FUNC    GLOBAL DEFAULT   13 __inet_pton_length@@GLIBC_PRIVATE
Symbol table '.symtab' contains 28858 entries:
 20655: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS inet_pton.c
 20656: 00000000001440b0     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c
 20657: 00000000001447c4     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c_end
 20658: 000000000002ba70     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c.hot
 20659: 000000000002ba70     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c_end.hot
 20660: 000000000002b938     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c.unlikely
 20661: 000000000002b938     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c_end.unlikely
 20662: 000000000002ba70     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c.startup
 20663: 000000000002ba70     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c_end.startup
 20664: 000000000002b968     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c.exit
 20665: 000000000002b968     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c_end.exit
 20666: 00000000001440b0     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton4.start
 20667: 00000000001441aa     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton4.end
 20668: 00000000001440b0   250 FUNC    LOCAL  DEFAULT   13 inet_pton4
 20669: 00000000001441aa     0 NOTYPE  LOCAL  HIDDEN    13 .annobin___GI___inet_pton_length.start
 20670: 00000000001444ac     0 NOTYPE  LOCAL  HIDDEN    13 .annobin___GI___inet_pton_length.end
 20671: 00000000001444ac     0 NOTYPE  LOCAL  HIDDEN    13 .annobin___GI___inet_pton.start
 20672: 00000000001447c4     0 NOTYPE  LOCAL  HIDDEN    13 .annobin___GI___inet_pton.end
 23591: 00000000001441b0   764 FUNC    LOCAL  DEFAULT   13 __GI___inet_pton_length
 23871: 00000000001444b0   788 FUNC    LOCAL  DEFAULT   13 __inet_pton
 24506: 00000000001444b0   788 FUNC    LOCAL  DEFAULT   13 __GI___inet_pton
 25831: 00000000001444b0   788 FUNC    LOCAL  DEFAULT   13 __GI_inet_pton
 26410: 00000000001441b0   764 FUNC    GLOBAL DEFAULT   13 __inet_pton_length
 27288: 00000000001444b0   788 FUNC    WEAK   DEFAULT   13 inet_pton
[root@m35lp76 ~]#

And perf could find the symbol, extract its address and install a probe
on that address.
So is this a bug related to the perf tool because it can not handle .dynsym section?
Or is it releated to glibc's rework?

Thanks for your help.
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
