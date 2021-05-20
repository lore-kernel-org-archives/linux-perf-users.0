Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24DAC433ED
	for <linux-perf-users@archiver.kernel.org>; Thu, 20 May 2021 06:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3D176100C
	for <linux-perf-users@archiver.kernel.org>; Thu, 20 May 2021 06:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhETGhM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 20 May 2021 02:37:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52658 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229534AbhETGhM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 20 May 2021 02:37:12 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14K6X6ba054699;
        Thu, 20 May 2021 02:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=FiVnCCIHtluDSmVInYRQoRpYWY0c3hV0h0o35KZu4r0=;
 b=XHhGL52tWHyiMoKnpz4sh/ysxYB3Bwgfm/rQnzq9ULryDhIbU7luiR/HScMJWm8PetHl
 +vOOYfFtePWpY9iDCNfN29aWhbDSJ/1A5UGdRICPs2Pz/4IW9F6S2RXEnr7ung/Juyph
 ff48p4CtEE8c+0dFEXlqvRQfmbNWrJd34VBy4uaUlN42qIOv14ZHyPoWRU/pJZ97BPpB
 JM6BK2fezfJQ9o8RZ92Kmphu2eMDK9kWnGPrVa0sW3BXWyT313yjIjYsH22Twz6fxHXK
 Hq/LFinwHU+FxDEpRbVxKx1SzGy1Ymm8T5SD9EEWuze4mDoej9d1C9ORknLavhGfdNN5 +A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38nhvg954w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 May 2021 02:35:49 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14K6Zntf068192;
        Thu, 20 May 2021 02:35:49 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38nhvg953y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 May 2021 02:35:49 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14K6SSaN014142;
        Thu, 20 May 2021 06:35:47 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 38j5jgtevf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 May 2021 06:35:47 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14K6ZiYq30409034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 May 2021 06:35:45 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D72DA42049;
        Thu, 20 May 2021 06:35:44 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AABB42041;
        Thu, 20 May 2021 06:35:44 +0000 (GMT)
Received: from li-e35baacc-2106-11b2-a85c-8f97eb669a6e.ibm.com (unknown [9.145.90.69])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 20 May 2021 06:35:44 +0000 (GMT)
Subject: Re: perf list dumps core using 5.13.0.rc2
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
References: <555b92bd-1884-58a7-76fd-7dd197978436@linux.ibm.com>
 <CAP-5=fX_+GY38s0imLNDzq9_xjn3qiGC0pFEpSV1U-TzF_UoMg@mail.gmail.com>
 <YKVIciYdoooQNfsS@kernel.org>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
Message-ID: <47c2afdd-a140-780b-aae3-4242b746a183@linux.ibm.com>
Date:   Thu, 20 May 2021 08:35:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <YKVIciYdoooQNfsS@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NPbK9dizUdQU3zQULdD373MpY-Vbm6BL
X-Proofpoint-GUID: 9NdgrEy-sl4GNiABBe7yGx1_Ns3TvoaQ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-19_10:2021-05-19,2021-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 impostorscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105200052
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 5/19/21 7:18 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, May 19, 2021 at 09:27:14AM -0700, Ian Rogers escreveu:
>> On Wed, May 19, 2021 at 7:57 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>>>
>>> Using kernel 5.13.0.rc2 command perf list dumps core on my x86
>>> virtual machine:
>>>
>>> [root@f34 perf]# ./perf list
>>> Segmentation fault (core dumped)
>>> ^C
>>> [root@f34 perf]#
>>>
>>> The root case this this change in file ../include/uapi/linux/perf_event.h:
>>> enum perf_sw_ids {
>>>         PERF_COUNT_SW_CPU_CLOCK                 = 0,
>>>         ...
>>>  --->   PERF_COUNT_SW_CGROUP_SWITCHES           = 11,
>>>
>>>         PERF_COUNT_SW_MAX,                      /* non-ABI */
>>> };
>>>
>>> This change increases PERF_COUNT_SW_MAX to 12. However this
>>> change is not reflected in file util/parse-events.c where data structure
>>>
>>> struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
>>>         ....
>>> }
>>>
>>> is defined and it misses the symbol name and alias for this new software
>>> event. So when command 'perf list' is called, the call chain sequence
>>> is
>>>   cmd_list()
>>>     print_events()
>>>       print_symbol_events(event_glob, PERF_TYPE_SOFTWARE,
>>>                           event_symbols_sw, PERF_COUNT_SW_MAX, name_only);
>>>
>>> where PERF_COUNT_SW_MAX is 12 and  structure event_symbols_sw[] contains
>>> only 11 elements. This ends up with the last element of the array being
>>> all zeroes and the line:
>>>
>>>     if (!name_only && strlen(syms->alias))
>>>
>>> dumps core because syms->alias is a NULL pointer.
>>>
>>> Is this dummy event PERF_COUNT_SW_CGROUP_SWITCHES simply missing in the
>>> event_symbols_sw[] array or is there more to it (which I am missing).
>>>
>>> Thanks.
>>>
>>> PS: I can sent a patch if needed....
>>
>> I believe Namhyung's pending change will fix this:
>> https://lore.kernel.org/lkml/20210210083327.22726-3-namhyung@kernel.org/
> 
> Ok, I'll pick that one instead of the one I did, similar one.
> 
> - Arnaldo
> 

Thanks for looking into this, Namhyung's patch fixes this issue.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
