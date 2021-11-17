Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FBFC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Nov 2021 14:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA1A661BFA
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Nov 2021 14:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbhKQOSl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 17 Nov 2021 09:18:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5608 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234203AbhKQOSl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 Nov 2021 09:18:41 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AHECVgH007486;
        Wed, 17 Nov 2021 14:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=nIYKlYLmw0amoUIV0cfQfKojKi2kF75pIsR8SKG6z/E=;
 b=gdUEPtpOe5H5RlwkQXL8fAHytB+pQY6Oi23sc7hSUOgB5dDdrw32PnChq+Mu6Oe8ftxn
 N7UdyEj5DEs21XrRyIex4kDHL7lSwYzxnoRKVLu0WR/3V9PCTMVjmzUrDGkgjEoBQhGq
 Lx/l0c7IaANS0JxciA89diiudXhd5KqkgufUdGANg3WuuR5WlZL92aAD967P/GTTYrLt
 LCGPr/1/Q+lZbA/vsuWMZHCZkxqPIafJhjuKiym31ci7awRpcGFPYizxcoa6xOGiJMtF
 Wy+y0NzS/XR1WKNwf38/GP2/25INJ7LINTHBIohr6MPWzZHAM2ijbe0QC7Eogu4mL6Ty 8w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cd39s825r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 14:15:27 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AHECTkc007442;
        Wed, 17 Nov 2021 14:15:26 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cd39s824n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 14:15:26 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AHE2rLD009712;
        Wed, 17 Nov 2021 14:15:24 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 3ca50chd9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 14:15:23 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AHEFKP620840804
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Nov 2021 14:15:20 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 545FA42047;
        Wed, 17 Nov 2021 14:15:20 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B0964204D;
        Wed, 17 Nov 2021 14:15:15 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com (unknown [9.43.2.55])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 17 Nov 2021 14:15:15 +0000 (GMT)
Subject: Re: [PATCH 1/2] perf evlist: Allow setting arbitrary leader
To:     Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com
References: <20211113071548.372572-1-irogers@google.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <6e1252c4-2637-921c-659f-f322eb84623a@linux.ibm.com>
Date:   Wed, 17 Nov 2021 19:45:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211113071548.372572-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lDT2A1GaTw36DJOcwVPKqCzW7NeQQllv
X-Proofpoint-GUID: 81QU8aK80wJOvOrqOGiKCFDEXWQG6DuC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_05,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111170072
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Patch looks good to me.

Reviewed-by: Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain

On 11/13/21 12:45 PM, Ian Rogers wrote:
> The leader of a group is the first, but allow it to be an arbitrary
> list member so that for Intel topdown events slots may always be the
> group leader.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/perf/evlist.c                  | 15 +++++++++------
>  tools/lib/perf/include/internal/evlist.h |  2 +-
>  tools/perf/util/parse-events.c           |  2 +-
>  3 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index e37dfad31383..974da341b8b0 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -643,14 +643,14 @@ perf_evlist__next_mmap(struct perf_evlist *evlist, struct perf_mmap *map,
>  	return overwrite ? evlist->mmap_ovw_first : evlist->mmap_first;
>  }
>  
> -void __perf_evlist__set_leader(struct list_head *list)
> +void __perf_evlist__set_leader(struct list_head *list, struct perf_evsel *leader)
>  {
> -	struct perf_evsel *evsel, *leader;
> +	struct perf_evsel *first, *last, *evsel;
>  
> -	leader = list_entry(list->next, struct perf_evsel, node);
> -	evsel = list_entry(list->prev, struct perf_evsel, node);
> +	first = list_entry(list->next, struct perf_evsel, node);
> +	last = list_entry(list->prev, struct perf_evsel, node);
>  
> -	leader->nr_members = evsel->idx - leader->idx + 1;
> +	leader->nr_members = last->idx - first->idx + 1;
>  
>  	__perf_evlist__for_each_entry(list, evsel)
>  		evsel->leader = leader;
> @@ -659,7 +659,10 @@ void __perf_evlist__set_leader(struct list_head *list)
>  void perf_evlist__set_leader(struct perf_evlist *evlist)
>  {
>  	if (evlist->nr_entries) {
> +		struct perf_evsel *first = list_entry(evlist->entries.next,
> +						struct perf_evsel, node);
> +
>  		evlist->nr_groups = evlist->nr_entries > 1 ? 1 : 0;
> -		__perf_evlist__set_leader(&evlist->entries);
> +		__perf_evlist__set_leader(&evlist->entries, first);
>  	}
>  }
> diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
> index f366dbad6a88..6f74269a3ad4 100644
> --- a/tools/lib/perf/include/internal/evlist.h
> +++ b/tools/lib/perf/include/internal/evlist.h
> @@ -127,5 +127,5 @@ int perf_evlist__id_add_fd(struct perf_evlist *evlist,
>  
>  void perf_evlist__reset_id_hash(struct perf_evlist *evlist);
>  
> -void __perf_evlist__set_leader(struct list_head *list);
> +void __perf_evlist__set_leader(struct list_head *list, struct perf_evsel *leader);
>  #endif /* __LIBPERF_INTERNAL_EVLIST_H */
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 5bfb6f892489..6308ba739d19 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1834,8 +1834,8 @@ void parse_events__set_leader(char *name, struct list_head *list,
>  	if (parse_events__set_leader_for_uncore_aliase(name, list, parse_state))
>  		return;
>  
> -	__perf_evlist__set_leader(list);
>  	leader = list_entry(list->next, struct evsel, core.node);
> +	__perf_evlist__set_leader(list, &leader->core);
>  	leader->group_name = name ? strdup(name) : NULL;
>  }
>  
> 
