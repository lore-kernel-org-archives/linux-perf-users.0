Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AB2C2B9F4
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Jun 2021 10:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 487C86145C
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Jun 2021 10:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbhFYLAT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Jun 2021 07:00:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31162 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229445AbhFYLAT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Jun 2021 07:00:19 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15PAXgU1124462;
        Fri, 25 Jun 2021 06:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=fituOgpMfhMdKlNZ6XZgbolG7Jntuhw9bqHtmoe6fKI=;
 b=Kgs+XSi0fOPWLmVLRBDxwD5AcCGjfCMArYZFyChiSH3VjfITI/zF1SMBH/4zX9biEcM1
 XAY3VxLegIatyATo81sXB/NRHke6f/fv/1KbXqn5t+U1mDjYekCLLNuxXjkpGSbkIdWF
 pjkcGmlNmq8DPhFcNfzGAzq2Ootj43jHnYsCgawyKohEoaeBpOzHTIRT1npS4iUmDJxw
 fQ8DEabgOUVYsJQI8wJTbD58pdOGGuirjrTlOWU13BXFI0o5ZV0HkHC5u1YgOLNvmlMS
 ByAKYBkG/WZ4go8SV/u+PDPJcqxbiaZPmWXNS4suq48oD5Juqte/CoPgi0gtT5oXnszd 1Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39dcd6b9db-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Jun 2021 06:57:57 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15PAXhTp124570;
        Fri, 25 Jun 2021 06:57:56 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39dcd6b9ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Jun 2021 06:57:56 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15PAvsbo005442;
        Fri, 25 Jun 2021 10:57:54 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 399878b07y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Jun 2021 10:57:54 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15PAvpl429163842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 10:57:51 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 920434C040;
        Fri, 25 Jun 2021 10:57:51 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5397B4C046;
        Fri, 25 Jun 2021 10:57:51 +0000 (GMT)
Received: from li-e35baacc-2106-11b2-a85c-8f97eb669a6e.ibm.com (unknown [9.145.148.227])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 25 Jun 2021 10:57:51 +0000 (GMT)
Subject: Re: perf test case probe libc fails with latest Fedora34 glibc update
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stefan Liebler <stli@linux.ibm.com>
References: <YNWxJqxE5nOXBu3I@krava>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
Message-ID: <4fd7cb4c-8872-7650-9b9e-c1b3bb7680c5@linux.ibm.com>
Date:   Fri, 25 Jun 2021 12:57:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YNWxJqxE5nOXBu3I@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EBpAhQHmN_pIZxPMNFkAsshabfytEZ7W
X-Proofpoint-ORIG-GUID: 3gk8iLO2BBNrOnW8UPHU6hLRJEP_Abv5
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-25_03:2021-06-25,2021-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 impostorscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106250060
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 6/25/21 12:34 PM, Jiri Olsa wrote:
> On Wed, Jun 23, 2021 at 04:21:17PM +0200, Thomas Richter wrote:
>> I just updated Fedora34 to the latest level and discovered that perf test 78 fails:
>> [root@m46lp22 perf]# ./perf test 78
>> 78: probe libc's inet_pton & backtrace it with ping                 : FAILED!
>> [root@m46lp22 perf]#
>>
>> It boils down to this command and happens after glibc is update to level 2.33-18.
>>
>> [root@f34 ~]# perf probe -f -x /usr/lib64/libc-2.33.so -a inet_pton
>> Probe point 'inet_pton' not found.
>>   Error: Failed to add events.
>> [root@f34 ~]# rpm -qa | fgrep glibc
>> glibc-all-langpacks-2.33-18.fc34.x86_64
>> glibc-common-2.33-18.fc34.x86_64
>> glibc-langpack-en-2.33-18.fc34.x86_64
>> glibc-2.33-18.fc34.x86_64
>> glibc-doc-2.33-18.fc34.noarch
>> glibc-headers-x86-2.33-18.fc34.noarch
>> glibc-devel-2.33-18.fc34.x86_64
>> glibc-debugsource-2.33-18.fc34.x86_64
>> glibc-debuginfo-2.33-18.fc34.x86_64
>> [root@f34 ~]# 
>>
>> The symbol inet_pton is now in the .dynsym section of glibc:
>> [root@f34 ~]# readelf -sW /usr/lib64/libc-2.33.so | egrep '(dynsym|symtab|inet_pton)'
>> Symbol table '.dynsym' contains 2419 entries:
>>    628: 000000000011ea00   108 FUNC    WEAK   DEFAULT   15 inet_pton@@GLIBC_2.2.5
>>   2251: 000000000011e9b0    76 FUNC    GLOBAL DEFAULT   15 __inet_pton_length@@GLIBC_PRIVATE
>> Symbol table '.symtab' contains 104 entries:
>> [root@f34 ~]#
>>
>> The .symtab section does not contain symbol inet_pton. It contains very few symbols
>> compared to previous versions.
>>
>> Now perf does not find it. In the older version of the library the
>> symbol inet_pton was listed in the .symtab section. Here is the output from version 2.32-4:
>>
>>
>> [root@m35lp76 ~]# rpm -qa | fgrep glibc
>> glibc-common-2.32-4.fc33.s390x
>> glibc-langpack-en-2.32-4.fc33.s390x
>> glibc-2.32-4.fc33.s390x
>> glibc-headers-s390-2.32-4.fc33.noarch
>> glibc-devel-2.32-4.fc33.s390x
>> glibc-debuginfo-common-2.32-4.fc33.s390x
>> glibc-debuginfo-2.32-4.fc33.s390x
>> [root@m35lp76 ~]# 
>>
>>
>> readelf -sW /usr/lib64/libc-2.32.so | egrep '(dynsym|symtab|inet_pton)'
>> Symbol table '.dynsym' contains 2604 entries:
>>    668: 00000000001444b0   788 FUNC    WEAK   DEFAULT   13 inet_pton@@GLIBC_2.2
>>   2418: 00000000001441b0   764 FUNC    GLOBAL DEFAULT   13 __inet_pton_length@@GLIBC_PRIVATE
>> Symbol table '.symtab' contains 28858 entries:
>>  20655: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS inet_pton.c
>>  20656: 00000000001440b0     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c
>>  20657: 00000000001447c4     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c_end
>>  20658: 000000000002ba70     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c.hot
>>  20659: 000000000002ba70     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c_end.hot
>>  20660: 000000000002b938     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c.unlikely
>>  20661: 000000000002b938     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c_end.unlikely
>>  20662: 000000000002ba70     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c.startup
>>  20663: 000000000002ba70     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c_end.startup
>>  20664: 000000000002b968     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c.exit
>>  20665: 000000000002b968     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c_end.exit
>>  20666: 00000000001440b0     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton4.start
>>  20667: 00000000001441aa     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton4.end
>>  20668: 00000000001440b0   250 FUNC    LOCAL  DEFAULT   13 inet_pton4
>>  20669: 00000000001441aa     0 NOTYPE  LOCAL  HIDDEN    13 .annobin___GI___inet_pton_length.start
>>  20670: 00000000001444ac     0 NOTYPE  LOCAL  HIDDEN    13 .annobin___GI___inet_pton_length.end
>>  20671: 00000000001444ac     0 NOTYPE  LOCAL  HIDDEN    13 .annobin___GI___inet_pton.start
>>  20672: 00000000001447c4     0 NOTYPE  LOCAL  HIDDEN    13 .annobin___GI___inet_pton.end
>>  23591: 00000000001441b0   764 FUNC    LOCAL  DEFAULT   13 __GI___inet_pton_length
>>  23871: 00000000001444b0   788 FUNC    LOCAL  DEFAULT   13 __inet_pton
>>  24506: 00000000001444b0   788 FUNC    LOCAL  DEFAULT   13 __GI___inet_pton
>>  25831: 00000000001444b0   788 FUNC    LOCAL  DEFAULT   13 __GI_inet_pton
>>  26410: 00000000001441b0   764 FUNC    GLOBAL DEFAULT   13 __inet_pton_length
>>  27288: 00000000001444b0   788 FUNC    WEAK   DEFAULT   13 inet_pton
>> [root@m35lp76 ~]#
>>
>> And perf could find the symbol, extract its address and install a probe
>> on that address.
>> So is this a bug related to the perf tool because it can not handle .dynsym section?
>> Or is it releated to glibc's rework?
> 
> hi,
> there's already glibc bug for that:
>   https://bugzilla.redhat.com/show_bug.cgi?id=1975895
> 
> looks like they might restore the old behaviour
> 
> on the other hand, we could consider to read multiple
> symbol tables and merge them together
> 
> I'm not sure there's some hidden issue in such approach,
> otherwise we might be doing that already ;-)
> 
> jirka
> 

Right, Stefan Liebler investigated a similar issue on valgrind (Bug 1965374). He pointed me to the
bug owner...

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
