Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39363C433FE
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 May 2022 10:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbiEWKxC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 23 May 2022 06:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbiEWKw7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 23 May 2022 06:52:59 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DF9313BD
        for <linux-perf-users@vger.kernel.org>; Mon, 23 May 2022 03:52:16 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NAQnmB030540;
        Mon, 23 May 2022 10:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date : to :
 from : subject : content-type : content-transfer-encoding : mime-version;
 s=pp1; bh=pW1xxxENi13fRKdJiPiu7TkXoQJq+OHPieCJtuUxW84=;
 b=npb3sH73qgYNtso70nCLxknpgNgIJcjsVNP1HkfkTsaVW7w9HvbnCE8+dPquFpDgnew2
 l0cUJqXEAVRh/OPr/Rn2OrR7JrHVFQEmodTujMO00Y0EOjipGeVC5p4qHMU4axk3+3bX
 0EjG9rpKa5WA4h3Jg5k6Jl4iCbxaWXqg3YLd097O88tuK8Xp3zkWDzyA76WLLvE0hciH
 IrnG7ePskvDV7yMLvs/XXcVTlLbw2HOsgFsylErCpbYVlv9hB26JYOY7c3Ljnp79tRRs
 2vgf9OKBJmtpID19ExBIDK5gqSzDpCR6sVmK4OjqxPBg0cf0+k0Efc/xv+jkK5iO85RQ kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g88h9gk9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 10:52:12 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24NAqCYJ001528;
        Mon, 23 May 2022 10:52:12 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g88h9gk91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 10:52:12 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24NAJNnL016569;
        Mon, 23 May 2022 10:52:10 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3g6qq9anrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 10:52:10 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24NAq7WP47907288
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 10:52:07 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C7EEA4060;
        Mon, 23 May 2022 10:52:07 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7E53A4054;
        Mon, 23 May 2022 10:52:06 +0000 (GMT)
Received: from [9.152.212.236] (unknown [9.152.212.236])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 23 May 2022 10:52:06 +0000 (GMT)
Message-ID: <bac4efca-c61e-5f62-daa1-f508b64d6a7f@linux.ibm.com>
Date:   Mon, 23 May 2022 12:52:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        vasily Gorbik <gor@linux.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
From:   Thomas Richter <tmricht@linux.ibm.com>
Subject: perf test case 40 LLVM search and compile runs endless (eBPF linkage
 issue)
Organization: IBM
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2_NostXoHEXskahbvEdt7LVNCLphAvgk
X-Proofpoint-ORIG-GUID: W9OvB0moe0pxzAOkWQQwzOYlCHQF66oU
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-23_04,2022-05-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205230057
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On s390 the test case 40 'LLVM search and compile' runs for ever:

  # date; timeout 30s perf test -F 40; date
  Mon May 23 12:35:48 PM CEST 2022
   40: LLVM search and compile   :
   40.1: Basic BPF llvm compile  :
  Mon May 23 12:36:18 PM CEST 2022
  #

Investigation by Ilya Leoshkevich revealed:
On s390 we hit an endless loop where bpf_object__next_program and bpf_program__next 
infinitely call each other. We tracked this down to ld.so preferring the perf's 
bpf_object__next_program weak copy over the libbpf's strong one.

This is introduced with commit 2a4898fc264a ("perf tools: Add more weak libbpf functions")

Also see discussion in 
https://lore.kernel.org/lkml/YY%2FAR2Dcaws0BAE9@kernel.org/

How can this be fixed asap? Thanks a lot.
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
