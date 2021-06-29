Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6C8C11F66
	for <linux-perf-users@archiver.kernel.org>; Tue, 29 Jun 2021 07:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7473F61DE3
	for <linux-perf-users@archiver.kernel.org>; Tue, 29 Jun 2021 07:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbhF2HXy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 29 Jun 2021 03:23:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17324 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232161AbhF2HXx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 29 Jun 2021 03:23:53 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15T74N03073942;
        Tue, 29 Jun 2021 03:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=7eKD4PtbQIThSQfM9BytT4Rl1NvzJyvZWOVmX2t5IPU=;
 b=Rua8psbXGCT4VvjHJNHlQWA7EyWYr35DMxpykoMHV7WSfzaka8CvFzqSbmM+CtOJEi2D
 eFgxP9Gvz4YpC3hTcbDTh/6bOO50gS5X0UitwAjNMc4bDYU/EoPjYBz2amMFYtg/FBW/
 7GPJxFRo/OHodDBwVNkIuwuFIbkyWKLfWrY3kABjSUS4uLO6dDdwEVGSbhop6MEHipZU
 8tBnnSIoU4oUAO3OM2j9wHcegFvkTQnhual5NQz/iAONi9UOzKwvnEy2arc+8MNmRGI7
 VmHVPGpxzAiib5kOsRvqsWruQJuUFBxR85D3qRWx+ou5eFrV6tEAiNnJVCaQpDw9/SZr MA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39fwu71uk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 03:21:26 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15T7JG2Y001988;
        Tue, 29 Jun 2021 07:21:24 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 39dugh8kd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 07:21:24 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15T7LLSD28770762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 07:21:21 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBCD642079;
        Tue, 29 Jun 2021 07:21:19 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B465442072;
        Tue, 29 Jun 2021 07:21:19 +0000 (GMT)
Received: from li-e35baacc-2106-11b2-a85c-8f97eb669a6e.ibm.com (unknown [9.145.154.219])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 29 Jun 2021 07:21:19 +0000 (GMT)
Subject: Re: perf test case probe libc fails with latest Fedora34 glibc
 update, more info
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Stefan Liebler <stli@linux.ibm.com>
References: <cae863a4-bf83-f87b-6e71-b6a544678cae@linux.ibm.com>
 <f6752514-eaf9-371e-f81b-0d9e41ebae0c@linux.ibm.com>
 <20210629140242.c16d9bf368865025e0ead480@kernel.org>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
Message-ID: <d689e8e0-64da-e3c6-bc3b-50d4d3a4ee03@linux.ibm.com>
Date:   Tue, 29 Jun 2021 09:21:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629140242.c16d9bf368865025e0ead480@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TjyIE6gtIXLxgYK780-i8u2EhgoUWJWU
X-Proofpoint-ORIG-GUID: TjyIE6gtIXLxgYK780-i8u2EhgoUWJWU
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-29_02:2021-06-25,2021-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106290050
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 6/29/21 7:02 AM, Masami Hiramatsu wrote:
> On Fri, 25 Jun 2021 12:43:29 +0200
> Thomas Richter <tmricht@linux.ibm.com> wrote:
> 

Masami,

here is more info on this issue:

# nm /usr/lib64/libc-2.33.so 
00000000000a7f30 t __GI_memchr
00000000000a3730 t __GI_memcmp
00000000000a37e0 t __GI_memcpy
00000000000a39a0 t __GI_memmove
00000000000a37d0 t __GI_mempcpy
00000000000a8000 t __GI___rawmemchr
00000000000a6070 t __GI_stpcpy
000000000009d190 t __GI___strcasecmp_l
00000000000a67a0 t __GI_strcat
00000000000a6ec0 t __GI_strchr
00000000000a6b70 t __GI_strcmp
00000000000a5f70 t __GI_strcpy
00000000000a7c70 t __GI_strcspn
00000000000a5ad0 t __GI_strlen
000000000009d200 t __GI___strncasecmp_l
00000000000a6ce0 t __GI_strncmp
00000000000a62a0 t __GI_strncpy
00000000000a5d30 t __GI_strnlen
00000000000a73e0 t __GI_strrchr
00000000000b8e80 t __GI_wmemchr
0000000000111f60 T __memcpy_chk
0000000000111f80 T __memmove_chk
0000000000112040 T __stpcpy_chk
0000000000112100 T __strcpy_chk
# 

These are the entries in the .symtab section and can be used by perf:
# ./perf probe -vvv -f -x /usr/lib64/libc-2.33.so -a __strcpy_chk
# ./perf probe -l
  probe_libc:__strcpy_chk (on __strcpy_chk@debug/strcpy_chk.c in /usr/lib64/libc-2.33.so)
[root@t35lp46 perf]# 

Hope this helps
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
