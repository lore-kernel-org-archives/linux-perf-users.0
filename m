Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F7CC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 Nov 2021 07:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC72E61264
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 Nov 2021 07:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244145AbhKRIBf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 18 Nov 2021 03:01:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44798 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S244066AbhKRIBf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 18 Nov 2021 03:01:35 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AI7g4Zi023504;
        Thu, 18 Nov 2021 07:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=UoLBrerhNR7ZSLMwpGlxYzr+0iTbvlmqx2zVA4EYnzg=;
 b=UTvEmYcSH7uOO7XITNZxAqijtsEkl6c66/Fg1NXdOj5EvtKm0JZKeOUNZj+8P68HT2yH
 +i2stEm1v6YYvxass1I3KSFcEbvC2F+Qc5pZxJy87sIQ273sKwMHFoVWKV0nvYcOiwxn
 fAQHn3bwMbV+qmtKinscg7rwaTcBOuygGoQXHPIyLF4RlEJL+mgnTC1VCWOjt25+YsOZ
 E1SnMl8JuXaXYn1Q5EbDtX0mDNNYuePX0Lmz3sHI6BMOYtthEstBk6k937WO7ITMZQyS
 6haab0vClA0/QocnbvZh5FI7RSOrNNT7RzbRjgfzXfqkjFyAgi1nVwfdOWwdRun2amfP JQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cdjnxra45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 07:58:21 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AI7hkHP030725;
        Thu, 18 Nov 2021 07:58:20 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cdjnxra32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 07:58:20 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AI7mM4d012654;
        Thu, 18 Nov 2021 07:58:19 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 3ca50a8tmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 07:58:18 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AI7pJdU63439162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 07:51:19 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8884DA4065;
        Thu, 18 Nov 2021 07:58:16 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35D5EA4054;
        Thu, 18 Nov 2021 07:58:13 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com (unknown [9.43.63.210])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 18 Nov 2021 07:58:12 +0000 (GMT)
Subject: Re: [PATCH] perf hist: Fix memory leak of a perf_hpp_fmt
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
References: <20211118071247.2140392-1-irogers@google.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <b4ad6246-b402-ebe7-d35a-2f485dccbaf4@linux.ibm.com>
Date:   Thu, 18 Nov 2021 13:28:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211118071247.2140392-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: X0rHiTddIQu0CcvCmpJyv1Vk-zntiOe9
X-Proofpoint-ORIG-GUID: HQ6w97rPIi3mB5xt0TgO7o_DtXjZvfII
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_02,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111180043
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 11/18/21 12:42 PM, Ian Rogers wrote:
> perf_hpp__column_unregister removes an entry from a list but doesn't
> free the memory causing a memory leak spotted by leak sanitizer. Add the
> free while at the same time reducing the scope of the function to
> static.

Patch looks good to me.

Reviewed-by: Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol jain

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/ui/hist.c   | 28 ++++++++++++++--------------
>  tools/perf/util/hist.h |  1 -
>  2 files changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
> index c1f24d004852..5075ecead5f3 100644
> --- a/tools/perf/ui/hist.c
> +++ b/tools/perf/ui/hist.c
> @@ -535,6 +535,18 @@ struct perf_hpp_list perf_hpp_list = {
>  #undef __HPP_SORT_ACC_FN
>  #undef __HPP_SORT_RAW_FN
>  
> +static void fmt_free(struct perf_hpp_fmt *fmt)
> +{
> +	/*
> +	 * At this point fmt should be completely
> +	 * unhooked, if not it's a bug.
> +	 */
> +	BUG_ON(!list_empty(&fmt->list));
> +	BUG_ON(!list_empty(&fmt->sort_list));
> +
> +	if (fmt->free)
> +		fmt->free(fmt);
> +}
>  
>  void perf_hpp__init(void)
>  {
> @@ -598,9 +610,10 @@ void perf_hpp_list__prepend_sort_field(struct perf_hpp_list *list,
>  	list_add(&format->sort_list, &list->sorts);
>  }
>  
> -void perf_hpp__column_unregister(struct perf_hpp_fmt *format)
> +static void perf_hpp__column_unregister(struct perf_hpp_fmt *format)
>  {
>  	list_del_init(&format->list);
> +	fmt_free(format);
>  }
>  
>  void perf_hpp__cancel_cumulate(void)
> @@ -672,19 +685,6 @@ void perf_hpp__append_sort_keys(struct perf_hpp_list *list)
>  }
>  
>  
> -static void fmt_free(struct perf_hpp_fmt *fmt)
> -{
> -	/*
> -	 * At this point fmt should be completely
> -	 * unhooked, if not it's a bug.
> -	 */
> -	BUG_ON(!list_empty(&fmt->list));
> -	BUG_ON(!list_empty(&fmt->sort_list));
> -
> -	if (fmt->free)
> -		fmt->free(fmt);
> -}
> -
>  void perf_hpp__reset_output_field(struct perf_hpp_list *list)
>  {
>  	struct perf_hpp_fmt *fmt, *tmp;
> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index 5343b62476e6..621f35ae1efa 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
> @@ -369,7 +369,6 @@ enum {
>  };
>  
>  void perf_hpp__init(void);
> -void perf_hpp__column_unregister(struct perf_hpp_fmt *format);
>  void perf_hpp__cancel_cumulate(void);
>  void perf_hpp__setup_output_field(struct perf_hpp_list *list);
>  void perf_hpp__reset_output_field(struct perf_hpp_list *list);
> 
