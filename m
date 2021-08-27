Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1B0C4320E
	for <linux-perf-users@archiver.kernel.org>; Fri, 27 Aug 2021 07:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2E8560F92
	for <linux-perf-users@archiver.kernel.org>; Fri, 27 Aug 2021 07:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244456AbhH0H32 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 27 Aug 2021 03:29:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55386 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231345AbhH0H3S (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 27 Aug 2021 03:29:18 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17R78fl8161870;
        Fri, 27 Aug 2021 03:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=hPt+3KiUZFcZAM29v8jxkS1WokIMp9d97TNoTAP9JGU=;
 b=I0+zdla5w6LjFp/LwJlpQlCKKst2YS13FgblV0Ryf2LMcNZX9tA4yTbs9bEyyj6UJxk5
 8a8lmMNX0ya1amq1N2rkTFJEAOs3o19I9haeq69uydWxVTHtUluNcdlRfJwVZGFkPGs4
 2kx/Ipy24AiAwXrQD6B94C1QZXlzuWPJq8Zkpcr60iT4nBbeHy36Aj5jvfGG3VEIYti8
 azgaj+vHhCeYgqqbYFfXfPLMVoguVJvseJt4LkX9MEa+Vp/6FPw23J2XVuQn+LChL+2I
 uUfR1QFN3ceZWK8S6wR1JiNg76j6jGICwSyB+90GR4P15a60ZB9q8ZuqHym0YXCbl74w EQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3apt5w240g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Aug 2021 03:28:17 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17R78oeA162582;
        Fri, 27 Aug 2021 03:28:17 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3apt5w2403-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Aug 2021 03:28:17 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17R7R2Hr002802;
        Fri, 27 Aug 2021 07:28:16 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma04wdc.us.ibm.com with ESMTP id 3ajs4fc4pf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Aug 2021 07:28:16 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17R7SFSM47186410
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 07:28:15 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F62C78067;
        Fri, 27 Aug 2021 07:28:15 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79CDE78064;
        Fri, 27 Aug 2021 07:28:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.73.252])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 27 Aug 2021 07:28:11 +0000 (GMT)
Subject: Re: [PATCH v2] perf bpf: Fix memory leaks relating to BTF.
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
References: <20210826184833.408563-1-irogers@google.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <767e90d9-fb3e-93e2-ac67-940ab7e9ae28@linux.ibm.com>
Date:   Fri, 27 Aug 2021 12:58:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210826184833.408563-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3kGFbuH_7pRe_HUCTFoSilfEqg6ruN7g
X-Proofpoint-GUID: 1PMCwQO-iej1Jqb8ll3L7n4FLnQdrmjh
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-27_02:2021-08-26,2021-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108270046
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Patch looks good me.

Reviewed-by: Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain

On 8/27/21 12:18 AM, Ian Rogers wrote:
> BTF needs to be freed with btf__free.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/annotate.c  | 2 +-
>  tools/perf/util/bpf-event.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index d43f6b5e5169..0bae061b2d6d 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1833,7 +1833,7 @@ static int symbol__disassemble_bpf(struct symbol *sym,
>  	ret = 0;
>  out:
>  	free(prog_linfo);
> -	free(btf);
> +	btf__free(btf);
>  	fclose(s);
>  	bfd_close(bfdf);
>  	return ret;
> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index cdecda1ddd36..17a9844e4fbf 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -296,7 +296,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
>  
>  out:
>  	free(info_linear);
> -	free(btf);
> +	btf__free(btf);
>  	return err ? -1 : 0;
>  }
>  
> @@ -486,7 +486,7 @@ static void perf_env__add_bpf_info(struct perf_env *env, u32 id)
>  	perf_env__fetch_btf(env, btf_id, btf);
>  
>  out:
> -	free(btf);
> +	btf__free(btf);
>  	close(fd);
>  }
>  
> 
