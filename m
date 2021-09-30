Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F7DC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 30 Sep 2021 10:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BB8261507
	for <linux-perf-users@archiver.kernel.org>; Thu, 30 Sep 2021 10:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349638AbhI3KFe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 30 Sep 2021 06:05:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49238 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238316AbhI3KFd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Sep 2021 06:05:33 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18U7gToN012991;
        Thu, 30 Sep 2021 06:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=C3vwBi2ML7bWOSUbjxYHzYi6MwvjumVR36KCY9qBVxs=;
 b=ciOek/WSj6I26BzsyjnGSlo25AE6ptpzbOUM1K1r68hmBeu/dfuWZ2HvTLbu4RXbKkTD
 ecJoKtbnu6wlvSlqkKwel4LH1KV+5gVwKnSFX625sZg6/yDitvfJtvqJfNYlzdakn4In
 /U/Y6yR5eShHq97ELpePsZaDPRNvNjXKqhgb4tcDcvySju4ysHHJmpLrI/2eQ8AWG5/p
 YFe3xh4vw+HXMctQQ/ddJ1ASw/LN3HNM0BgZrEYV8rL4/7F1X8k0/Qd55O4pvCGOIBAb
 1NbfrQGOSccT3PuaW9ZOjg7wNvrg5rQqKBXX+OmGbyWFnsdtkN17xhL/U53Tactr9z0z Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bd751673e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 06:03:46 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18U8xBBv008565;
        Thu, 30 Sep 2021 06:03:45 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bd751672d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 06:03:45 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18UA3GeX029071;
        Thu, 30 Sep 2021 10:03:43 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3b9udaa4ct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 10:03:42 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18U9wWM556230224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 09:58:32 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F26084C040;
        Thu, 30 Sep 2021 10:03:39 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 108D34C04E;
        Thu, 30 Sep 2021 10:03:36 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com (unknown [9.43.93.90])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Sep 2021 10:03:35 +0000 (GMT)
Subject: Re: [PATCH] perf tools: Fix compilation on powerpc
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Wielaard <mjw@redhat.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
References: <20210928195253.1267023-1-jolsa@kernel.org>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <a9963f8b-6913-5f4d-214f-95fac5b80925@linux.ibm.com>
Date:   Thu, 30 Sep 2021 15:33:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20210928195253.1267023-1-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EgNjcpTq59xFINJqRArtctGcSrCJCWk9
X-Proofpoint-ORIG-GUID: NkszpNdc3k2cz87n7M9PVTQ_3O_HqHyx
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-30_03,2021-09-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 spamscore=0 suspectscore=0 malwarescore=0 clxscore=1011 bulkscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109300063
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 9/29/21 1:22 AM, Jiri Olsa wrote:
> Got following build fail on powerpc:
> 
>     CC      arch/powerpc/util/skip-callchain-idx.o
>   In function ‘check_return_reg’,
>       inlined from ‘check_return_addr’ at arch/powerpc/util/skip-callchain-idx.c:213:7,
>       inlined from ‘arch_skip_callchain_idx’ at arch/powerpc/util/skip-callchain-idx.c:265:7:
>   arch/powerpc/util/skip-callchain-idx.c:54:18: error: ‘dwarf_frame_register’ accessing 96 bytes \
>   in a region of size 64 [-Werror=stringop-overflow=]
>      54 |         result = dwarf_frame_register(frame, ra_regno, ops_mem, &ops, &nops);
>         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   arch/powerpc/util/skip-callchain-idx.c: In function ‘arch_skip_callchain_idx’:
>   arch/powerpc/util/skip-callchain-idx.c:54:18: note: referencing argument 3 of type ‘Dwarf_Op *’
>   In file included from /usr/include/elfutils/libdwfl.h:32,
>                    from arch/powerpc/util/skip-callchain-idx.c:10:
>   /usr/include/elfutils/libdw.h:1069:12: note: in a call to function ‘dwarf_frame_register’
>    1069 | extern int dwarf_frame_register (Dwarf_Frame *frame, int regno,
>         |            ^~~~~~~~~~~~~~~~~~~~
>   cc1: all warnings being treated as errors
> 
> The dwarf_frame_register args changed with [1],
> Updating ops_mem accordingly.
> 
> [1] https://sourceware.org/git/?p=elfutils.git;a=commit;h=5621fe5443da23112170235dd5cac161e5c75e65

Hi Jiri,
	Thanks for the patch. I was able to reproduce this issue with gcc11 and
verified that with your change we no longer seeing this error.

Reviewed-by: Kajol Jain<kjain@linux.ibm.com>
Tested-by: Kajol Jain<kjain@linuxibm.com>

Thanks,
Kajol Jain

> 
> Cc: Mark Wielaard <mjw@redhat.com>
> Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Signed-off-by: Jiri Olsa <jolsa@redhat.com>
> ---
>  tools/perf/arch/powerpc/util/skip-callchain-idx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
> index 3018a054526a..20cd6244863b 100644
> --- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
> +++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
> @@ -45,7 +45,7 @@ static const Dwfl_Callbacks offline_callbacks = {
>   */
>  static int check_return_reg(int ra_regno, Dwarf_Frame *frame)
>  {
> -	Dwarf_Op ops_mem[2];
> +	Dwarf_Op ops_mem[3];
>  	Dwarf_Op dummy;
>  	Dwarf_Op *ops = &dummy;
>  	size_t nops;
> 
