Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F3AC433ED
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 14:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16F876124C
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 14:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354934AbhESO6d (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 May 2021 10:58:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57760 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347646AbhESO6c (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 May 2021 10:58:32 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14JEY6Ds176644;
        Wed, 19 May 2021 10:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=to : from : subject :
 message-id : date : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=9d/FwzDTAfWsbvFix+mKP+mFEkxNhrakch9ClU25Z5c=;
 b=mvnOiKZo+zQui+kxyCaRpC0aYUbmjHXF4Ke5d6zzUe6xb+7ND5QnIdjh7jdM2b2+yI3A
 Pf3qqZkv2E99uPHwUIZxvwSm/0gGvKFB7Iw/d/T6l/HYRFh91kaV22wnhrTdySUJlzQj
 BZR0apKrKoiuWLKZKEjEX0x1+B57mIoXrCj7ihdYTq1BodwXpPPmkhMEjcOO83xHxAdI
 KnYusEt52IvWHzS/5mgjgAD640m15eb6SisfruYwb00GAocylCdTtfXAbuCswiwFvw/N
 R4aHiG1F45fleHIDPsE9ltQEs7ldUHZUAIuZUagGw01dZ43YKhNlVNR8CDrKy//ViaRU bg== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38n4gkh671-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 10:57:11 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14JEmEei020955;
        Wed, 19 May 2021 14:57:09 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 38j5x896yp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 14:57:08 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14JEv6bn31064406
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 14:57:06 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09085A405F;
        Wed, 19 May 2021 14:57:06 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE702A4064;
        Wed, 19 May 2021 14:57:05 +0000 (GMT)
Received: from li-e35baacc-2106-11b2-a85c-8f97eb669a6e.ibm.com (unknown [9.145.48.208])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 May 2021 14:57:05 +0000 (GMT)
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>
From:   Thomas Richter <tmricht@linux.ibm.com>
Subject: perf list dumps core using 5.13.0.rc2
Organization: IBM
Message-ID: <555b92bd-1884-58a7-76fd-7dd197978436@linux.ibm.com>
Date:   Wed, 19 May 2021 16:57:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XgXeEo6kYVkjVQi_BRm-_onHeiTg72BP
X-Proofpoint-ORIG-GUID: XgXeEo6kYVkjVQi_BRm-_onHeiTg72BP
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-19_06:2021-05-19,2021-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105190091
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Using kernel 5.13.0.rc2 command perf list dumps core on my x86
virtual machine:

[root@f34 perf]# ./perf list
Segmentation fault (core dumped)
^C
[root@f34 perf]#

The root case this this change in file ../include/uapi/linux/perf_event.h:
enum perf_sw_ids {
        PERF_COUNT_SW_CPU_CLOCK                 = 0,
        ...
 --->   PERF_COUNT_SW_CGROUP_SWITCHES           = 11,

        PERF_COUNT_SW_MAX,                      /* non-ABI */
};

This change increases PERF_COUNT_SW_MAX to 12. However this
change is not reflected in file util/parse-events.c where data structure

struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
        ....
}

is defined and it misses the symbol name and alias for this new software
event. So when command 'perf list' is called, the call chain sequence
is
  cmd_list()
    print_events()
      print_symbol_events(event_glob, PERF_TYPE_SOFTWARE,
                          event_symbols_sw, PERF_COUNT_SW_MAX, name_only);

where PERF_COUNT_SW_MAX is 12 and  structure event_symbols_sw[] contains
only 11 elements. This ends up with the last element of the array being
all zeroes and the line:

    if (!name_only && strlen(syms->alias))

dumps core because syms->alias is a NULL pointer.

Is this dummy event PERF_COUNT_SW_CGROUP_SWITCHES simply missing in the
event_symbols_sw[] array or is there more to it (which I am missing).

Thanks. 

PS: I can sent a patch if needed....

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
