Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C1EC432BE
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Aug 2021 08:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BA6C610A6
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Aug 2021 08:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbhHZIDT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 26 Aug 2021 04:03:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55514 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232223AbhHZIDR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 Aug 2021 04:03:17 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17Q801I6007564;
        Thu, 26 Aug 2021 04:02:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=mK1A+5LyByOOSUnEPIB7WaXfY3C+FkmHhy98NdHPdP0=;
 b=Z+qi1zFjVCoG45z3DOnFYu4Nd1x13w6EN3QNHOt0/ffazUjF6MkPc3bChx8YBHi+yNqm
 ArpB9Oe4JfomLBJRlovG9zX+y0/sKLkJuJKM7FdoZzaHwRJpicJ/fM14/QbpK+fuGpFV
 sGbH8I7bLKi0v8vo+riTB6uGJ3gTnpMV8JPeUdd3KeH6l8PJam5JWr982vWQ30zmMSwv
 nD/F6YQSggfnQ6wOkNMVlsUOa7V6/u3GcL3hWvi4Kpcnr3eJbLq6g4EHlezKpsUFjEia
 JWEqFTZo8A2PQrl8LEAMOH98dBrWfGWpRLjQ2i9S3NIWV4AS/lLdhVpmw6XEVOh4UUE1 wQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ap6mn0sdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Aug 2021 04:02:20 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17Q7nPil154346;
        Thu, 26 Aug 2021 04:02:20 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ap6mn0scj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Aug 2021 04:02:20 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17Q7ugMS002987;
        Thu, 26 Aug 2021 08:02:19 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04wdc.us.ibm.com with ESMTP id 3ajs4e5p9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Aug 2021 08:02:19 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17Q82IBD23462372
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Aug 2021 08:02:18 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76DCD2807D;
        Thu, 26 Aug 2021 08:02:18 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D31222805C;
        Thu, 26 Aug 2021 08:02:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.48.53])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 26 Aug 2021 08:02:14 +0000 (GMT)
Subject: Re: [PATCH] perf bpf: Fix memory leak during synthesis.
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com
References: <20210826001635.285752-1-irogers@google.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <ad17ba1f-34d8-fa5e-72fc-e05107fe2822@linux.ibm.com>
Date:   Thu, 26 Aug 2021 13:32:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210826001635.285752-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RYv9w9DWE9rJpYhgNO7pnwkL8gQBvQLP
X-Proofpoint-GUID: hvpMsI4_tEOvcdo4kTylG4BElxXTqzlC
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-25_09:2021-08-25,2021-08-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 spamscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108260044
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 8/26/21 5:46 AM, Ian Rogers wrote:
> BTF needs to be freed with btf_free.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/bpf-event.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index cdecda1ddd36..d193104db7f7 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -296,7 +296,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
>  
>  out:
>  	free(info_linear);
> -	free(btf);
> +	btf__free(btf);

Hi Ian,
   Patch looks good to me. I can see in one more place we are using free(btf) in the
same file. Can you correct that as well.

Thanks,
Kajol Jain
   
>  	return err ? -1 : 0;
>  }
>  
> 
