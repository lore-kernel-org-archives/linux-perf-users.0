Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC291878;
	Fri, 28 Jun 2024 02:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719541853; cv=none; b=kErsQUiGtiTXY7GCqAKPpdnjPdIHuFgxcXOWv7fZgArXg6iL8LH1ypj21dfECrf+tPJZVOVbIwnWdHwOyrJ7uQTueb2c4jtdqP+ThFgHz2vSpQmD0/gBDh8ei38Wn4L/1SfZgIUBsa/l++iKe7CTtFXz29FfFynKNyDmxJW95Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719541853; c=relaxed/simple;
	bh=qJqzHfnDTbkab/2mC4P6xW3Hg/uiddUw0kX29SQyF+k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bT+ZKDn1hVZfKnU0A80Nl3CoodZoQlUQw8mLKmX75qluPdUFRVFl1TCtxWT2469X7K1Rcn2Zzh89IJJdIJ7EnCLTfvUQBGvuuNmAIOTQgfq8MI89fXDfIgrgaXG6fHpmBMjQeyPREnDiiEk+X+3cuZb+kSxQcDqg4K7ArTDFwfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Kbtw00os; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kbtw00os"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45S1ukDU025867;
	Fri, 28 Jun 2024 02:30:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	Kaqsoet0pk30QYL9NjeuE5u3841dcKtrvRe/n63UiHk=; b=Kbtw00os1g9BTQ8b
	JEziBI+lDyWBqW+PawgyLM//KGR86E4Od0iXgOmPGqa1XonfQ+/CkWcJvrhPJxFF
	t811y9VKmUSa0NGR314BvbVE6vPuyZIAgDp4f9e+QKACH8I2OpYc85s0g78t5jei
	MDOrcTGJuHnnVBWTmSMFXe64MCTIXRTWHE8mkHhBEfHaHTf7EM8DgeMrQdWc1yJ3
	kSF03EnQjPBYMPhwKq3b2FkeJl1xZXyEr17ZZuCUMgkRFejO0Q6Rzi4ABD2bW+J1
	ZXSADbtI4mx2F6z8pXx4jGzwrWj6M5N/kITn28SmGrY7zAx5Y9aNsfUZ/iETYdZQ
	5nCpqg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 401dtygtw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 02:30:33 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45S2UWnQ009443;
	Fri, 28 Jun 2024 02:30:32 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 401dtygtw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 02:30:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45S17Wn9008183;
	Fri, 28 Jun 2024 02:30:31 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yx9b168r3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 02:30:31 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45S2USbg10551922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Jun 2024 02:30:30 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B20F258052;
	Fri, 28 Jun 2024 02:30:28 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDBB958056;
	Fri, 28 Jun 2024 02:30:17 +0000 (GMT)
Received: from [9.43.17.81] (unknown [9.43.17.81])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Jun 2024 02:30:17 +0000 (GMT)
Message-ID: <51e9fd2f-7d86-40cb-b307-0b0b396ca32a@linux.ibm.com>
Date: Fri, 28 Jun 2024 08:00:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf sched replay: Fix -r/--repeat command line option
 for infinity
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, acme@redhat.com,
        Chen Yu <yu.c.chen@intel.com>, Fernand Sieber <sieberf@amazon.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, James Clark <james.clark@arm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ian Rogers
 <irogers@google.com>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20240621171909.24119-1-vineethr@linux.ibm.com>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20240621171909.24119-1-vineethr@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uiOrwWg4E1XLTor9lEyk-XPAiHsxW91b
X-Proofpoint-ORIG-GUID: cyoPar6oz1_ykbtpi-iSvj8yGFqVbdqW
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_16,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 phishscore=0 malwarescore=0 clxscore=1011 suspectscore=0 adultscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406280013

On 21/06/24 22:49, Madadi Vineeth Reddy wrote:
> Currently, the -r/--repeat option accepts values from 0 and complains
> for -1. The help section specifies:
> -r, --repeat <n>      repeat the workload replay N times (-1: infinite)
> 
> The -r -1 option raises an error because replay_repeat is defined as
> an unsigned int.
> 
> In the current implementation, the workload is repeated n times when
> -r <n> is used, except when n is 0.
> 
> When -r is set to 0, the workload is also repeated once. This happens
> because when -r=0, the run_one_test function is not called. (Note that
> mutex unlocking, which is essential for child threads spawned to emulate
> the workload, happens in run_one_test.) However, mutex unlocking is
> still performed in the destroy_tasks function. Thus, -r=0 results in the
> workload running once coincidentally.
> 
> To clarify and maintain the existing logic for -r >= 1 (which runs the
> workload the specified number of times) and to fix the issue with infinite
> runs, make -r=0 perform an infinite run.
> 
> Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> Reviewed-by: James Clark <james.clark@arm.com>
> 

Hi all,
Any suggestions/comments on this patch?

Thanks and Regards
Madadi Vineeth Reddy

> ---
> Changes in v2:
> - Kept the existing 'for' loop and added a condition for infinite
>   looping. (James Clark)
> - This change also ensures that integer overflow doesn't occur when
>   'replay_repeat' is zero.
> - Add Reviewed-by tag from James Clark.
> - Rebase against perf-tools-next commit 788c5160526a ("perf vendor
>   events: Add westmereex counter information")
> - Link to v1: https://lore.kernel.org/all/20240618112907.15131-1-vineethr@linux.ibm.com/
> 
>  tools/perf/Documentation/perf-sched.txt |  7 +++++++
>  tools/perf/builtin-sched.c              | 11 ++++++++---
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
> index a216d2991b19..f1be8f0b249e 100644
> --- a/tools/perf/Documentation/perf-sched.txt
> +++ b/tools/perf/Documentation/perf-sched.txt
> @@ -202,6 +202,13 @@ OPTIONS for 'perf sched timehist'
>  --state::
>  	Show task state when it switched out.
>  
> +OPTIONS for 'perf sched replay'
> +------------------------------
> +
> +-r::
> +--repeat <n>::
> +	repeat the workload n times (0: infinite). Default is 10.
> +
>  SEE ALSO
>  --------
>  linkperf:perf-record[1]
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 8cdf18139a7e..51b3dea404bc 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -3383,8 +3383,13 @@ static int perf_sched__replay(struct perf_sched *sched)
>  	sched->thread_funcs_exit = false;
>  	create_tasks(sched);
>  	printf("------------------------------------------------------------\n");
> -	for (i = 0; i < sched->replay_repeat; i++)
> -		run_one_test(sched);
> +	if (sched->replay_repeat == 0) {
> +		while (1)
> +			run_one_test(sched);
> +	} else {
> +		for (i = 0; i < sched->replay_repeat; i++)
> +			run_one_test(sched);
> +	}
>  
>  	sched->thread_funcs_exit = true;
>  	destroy_tasks(sched);
> @@ -3548,7 +3553,7 @@ int cmd_sched(int argc, const char **argv)
>  	};
>  	const struct option replay_options[] = {
>  	OPT_UINTEGER('r', "repeat", &sched.replay_repeat,
> -		     "repeat the workload replay N times (-1: infinite)"),
> +		     "repeat the workload replay N times (0: infinite)"),
>  	OPT_PARENT(sched_options)
>  	};
>  	const struct option map_options[] = {

