Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD18CC07E99
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Jul 2021 12:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0995613FC
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Jul 2021 12:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhGEMN4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:13:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31278 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231183AbhGEMN4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 5 Jul 2021 08:13:56 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 165C4xRD026789;
        Mon, 5 Jul 2021 08:11:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=rT2bG0AaHOmphmgPlSiIjTBX3srVtBH+NcWrjue833M=;
 b=WFSQg5zxFgctrD2xmPljwSpg3JclkimYzmSw6mbO4cRCHoXcWsvuNDWClpVsHzpjvqxX
 oUCD3oPrmtM3wOnnn3JE4iM2AnkJuWo4nsP0y8/fWNsIaK0Hs5pysvL/Zz4m+WAj/l00
 vr8axjys5guNVwH0CG53Es5jiS/ettKvOsZt59aIb3X4zVcm3GET5afpjQh+hKLpkxMG
 CDZamsBajnsNU1iNgxp+SY6z0QcuGS7oIM0OrpZyMUhD6AXHzTX48i9tuSQGo9IjS50q
 Txggv930qpZgFkIHV0zpbwtg7J5P572PlKTpFxmeWzrlVxfKgJf4wS+EQfc2uHSV66gJ Kg== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39kwgnfpbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jul 2021 08:11:18 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 165C72S9007087;
        Mon, 5 Jul 2021 12:11:16 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 39jfh88dx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jul 2021 12:11:16 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 165CBCCD27656500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Jul 2021 12:11:13 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 669874C0EA;
        Mon,  5 Jul 2021 12:11:12 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C35E4C165;
        Mon,  5 Jul 2021 12:11:12 +0000 (GMT)
Received: from li-e35baacc-2106-11b2-a85c-8f97eb669a6e.ibm.com (unknown [9.145.18.84])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  5 Jul 2021 12:11:12 +0000 (GMT)
Subject: Re: [PATCH 3/3] perf probe: Do not show @plt function by default
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Stefan Liebler <stli@linux.ibm.com>,
        linux-kernel@vger.kernel.org
References: <162532651032.393143.4602033845482295575.stgit@devnote2>
 <162532653450.393143.12621329879630677469.stgit@devnote2>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
Message-ID: <9824bd00-3291-3a65-73f1-553410b8eb68@linux.ibm.com>
Date:   Mon, 5 Jul 2021 14:11:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <162532653450.393143.12621329879630677469.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Kyk5OQU2UiQ9wfSrGk-ql_RJ1kVHcP4D
X-Proofpoint-GUID: Kyk5OQU2UiQ9wfSrGk-ql_RJ1kVHcP4D
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-05_07:2021-07-02,2021-07-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107050065
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 7/3/21 5:35 PM, Masami Hiramatsu wrote:
> From: Masami Hiramatsu <mhriamat@kernel.org>
> 
> Fix the perf-probe --functions option do not show the PLT
> stub symbols (*@plt) by default.
> 
>   -----
>   $ ./perf probe -x /usr/lib64/libc-2.33.so -F | head
>   a64l
>   abort
>   abs
>   accept
>   accept4
>   access
>   acct
>   addmntent
>   addseverity
>   adjtime
>   -----
> 
> Reported-by: Thomas Richter <tmricht@linux.ibm.com>
> Signed-off-by: Masami Hiramatsu <mhriamat@kernel.org>
> ---
>  tools/perf/builtin-probe.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
> index 2bfd41df621c..e1dd51f2874b 100644
> --- a/tools/perf/builtin-probe.c
> +++ b/tools/perf/builtin-probe.c
> @@ -31,7 +31,7 @@
>  #include <linux/zalloc.h>
>  
>  #define DEFAULT_VAR_FILTER "!__k???tab_* & !__crc_*"
> -#define DEFAULT_FUNC_FILTER "!_*"
> +#define DEFAULT_FUNC_FILTER "!_* & !*@plt"
>  #define DEFAULT_LIST_FILTER "*"
>  
>  /* Session management structure */
> 

Thanks, works again ...

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
