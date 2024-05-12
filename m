Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E75D4B5AE;
	Sun, 12 May 2024 16:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715530291; cv=none; b=tjgimkT0UfDzkBrRu+IPGjEtaXj1/jB9pqv6H9DtRBcRzFyRarpc8HYZGwR2J+BWQ2qiiU+PoGoiUORwMFdFS48TBijq8jI+Betw3ocUrpxLkyTpFOry7td4BPqwLj3J5eKeYEowgeg3Hn9qE8FkNlluM9doOzsBR0coQc/urvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715530291; c=relaxed/simple;
	bh=z6P+mS/l0S7hWWQ+krwdaqTCWeyYjiFrKAW/ITNlUzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Tg/SlWBzqTxhPYucaXUe/QC0x9KvZFYDLfWxDNMu/ujcMDQdqvWWOcn34xw/93U2M4TZjQYqQnKpcpxqMrpIdM1+/w0jad0ddVOm0JjWmAwlggpjOqPjMTnyTJVmvMkL/ZdrAK7FdpHwCHHewC9q/72Oc4ArIUxF+lvItq7MnNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S3dgf7wN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S3dgf7wN"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44CFjsfZ008978;
	Sun, 12 May 2024 16:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=la6rV0NKorvKyL6sLrf655P9A2HtwgNO+jzNz69HBkw=;
 b=S3dgf7wN+jkfn9S2avR3FgvMyX65oWC5zSyhzByxrH8dAjvSOQw+7kqD/07b07vb6P+/
 S7a2mZm8EpadHwPBr1raITx2raHmiOY8PHtmBF/FMTqWOg2uOPeIGn4L/xbItm9t4qkn
 lbGqHX/yCSCKUPOyMxTIkawFD+BlUyhI4qAlU8GA/rfsof5MpocFyViUqsHYIzOIvmbZ
 8dSMkBrPncLNQrTxqR1j2PG8fLFicO9p/waFvDB0v2ts/eSab0kGndYezoHiM4OdqPXF
 WVn7xi8lUtMSgDEDbX7/XOsXa9bRX46Tt6zmY6zcVWhvlIncgOgtEUkxinzvzj1SZb/e Jw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y2uk98h1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 May 2024 16:11:08 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44CGB7J1014668;
	Sun, 12 May 2024 16:11:07 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y2uk98h1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 May 2024 16:11:07 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44CCeChr018810;
	Sun, 12 May 2024 16:11:07 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y2k0t3a3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 May 2024 16:11:06 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44CGB4NB40567304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 May 2024 16:11:06 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF34258055;
	Sun, 12 May 2024 16:11:03 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A234758043;
	Sun, 12 May 2024 16:10:55 +0000 (GMT)
Received: from [9.43.63.99] (unknown [9.43.63.99])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 12 May 2024 16:10:55 +0000 (GMT)
Message-ID: <50a50ac9-3797-4e7a-be21-ea3b01d64ec4@linux.ibm.com>
Date: Sun, 12 May 2024 21:40:52 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf sched map: Add command-name option to filter the
 output map
To: acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
        acme@redhat.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240417152521.80340-1-vineethr@linux.ibm.com>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20240417152521.80340-1-vineethr@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JaTpy5YKEc53aHaz9ElckGf3AslPyRnV
X-Proofpoint-GUID: hoEzRcayGguIDjf17gxV2yGdrMRrAN3L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-12_11,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 clxscore=1011 bulkscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405120120

On 17/04/24 20:55, Madadi Vineeth Reddy wrote:
> By default, perf sched map prints sched-in events for all the tasks
> which may not be required all the time as it prints lot of symbols
> and rows to the terminal.
> 
> With --command-name option, one could specify the specific command
> for which the map has to be shown. This would help in analyzing the
> CPU usage patterns easier for that specific command. Since multiple
> PID's might have the same command name, using command-name filter
> would be more useful for debugging.
> 
> For other tasks, instead of printing the symbol, ** is printed and
> the same . is used to represent idle. ** is used instead of symbol
> for other tasks because it helps in clear visualization of command
> of interest and secondly the symbol itself doesn't mean anything
> because the sched-in of that symbol will not be printed(first sched-in
> contains pid and the corresponding symbol).
> 
> 6.8.0
> ======
>   *A0                   213864.670142 secs A0 => migration/0:18
>   *.                    213864.670148 secs .  => swapper:0
>    .  *B0               213864.670217 secs B0 => migration/1:21
>    .  *.                213864.670223 secs
>    .   .  *C0           213864.670247 secs C0 => migration/2:26
>    .   .  *.            213864.670252 secs
> 
> 6.8.0 + patch (--command-name = schbench)
> =============
>    **  .   ** *A0       213864.671055 secs A0 => schbench:104834
>   *B0  .   .   A0       213864.671156 secs B0 => schbench:104835
>   *C0  .   .   A0       213864.671187 secs C0 => schbench:104836
>   *D0  .   .   A0       213864.671219 secs D0 => schbench:104837
>   *E0  .   .   A0       213864.671250 secs E0 => schbench:104838
>    E0  .  *D0  A0
> 
> This helps in visualizing how a benchmark like schbench is spread over
> the available cpus while also knowing which cpus are idle(.) and which
> are not(**). This will be more useful as number of CPUs increase.
> 
> Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> ---
>  tools/perf/Documentation/perf-sched.txt |  4 ++++
>  tools/perf/builtin-sched.c              | 17 ++++++++++++++---
>  2 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
> index 5fbe42bd599b..b04a37560935 100644
> --- a/tools/perf/Documentation/perf-sched.txt
> +++ b/tools/perf/Documentation/perf-sched.txt
> @@ -94,6 +94,10 @@ OPTIONS for 'perf sched map'
>  --color-pids::
>  	Highlight the given pids.
>  
> +--command-name::
> +	Map output only for the given command name.
> +	(** indicates other tasks while . is idle).
> +
>  OPTIONS for 'perf sched timehist'
>  ---------------------------------
>  -k::
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 0fce7d8986c0..e60836da53e5 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -156,6 +156,7 @@ struct perf_sched_map {
>  	const char		*color_pids_str;
>  	struct perf_cpu_map	*color_cpus;
>  	const char		*color_cpus_str;
> +	const char		*command;
>  	struct perf_cpu_map	*cpus;
>  	const char		*cpus_str;
>  };
> @@ -1594,8 +1595,6 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  
>  	sched->curr_thread[this_cpu.cpu] = thread__get(sched_in);
>  
> -	printf("  ");
> -
>  	new_shortname = 0;
>  	if (!tr->shortname[0]) {
>  		if (!strcmp(thread__comm_str(sched_in), "swapper")) {
> @@ -1605,7 +1604,8 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  			 */
>  			tr->shortname[0] = '.';
>  			tr->shortname[1] = ' ';
> -		} else {
> +		} else if (!sched->map.command || !strcmp(thread__comm_str(sched_in),
> +								sched->map.command)) {
>  			tr->shortname[0] = sched->next_shortname1;
>  			tr->shortname[1] = sched->next_shortname2;
>  
> @@ -1618,10 +1618,18 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  				else
>  					sched->next_shortname2 = '0';
>  			}
> +		} else {
> +			tr->shortname[0] = '*';
> +			tr->shortname[1] = '*';
>  		}
>  		new_shortname = 1;
>  	}
>  
> +	if (sched->map.command && strcmp(thread__comm_str(sched_in), sched->map.command))
> +		goto skip;
> +
> +	printf("  ");
> +
>  	for (i = 0; i < cpus_nr; i++) {
>  		struct perf_cpu cpu = {
>  			.cpu = sched->map.comp ? sched->map.comp_cpus[i].cpu : i,
> @@ -1678,6 +1686,7 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  out:
>  	color_fprintf(stdout, color, "\n");
>  
> +skip:
>  	thread__put(sched_in);
>  
>  	return 0;
> @@ -3560,6 +3569,8 @@ int cmd_sched(int argc, const char **argv)
>                      "highlight given CPUs in map"),
>  	OPT_STRING(0, "cpus", &sched.map.cpus_str, "cpus",
>                      "display given CPUs in map"),
> +	OPT_STRING(0, "command-name", &sched.map.command, "command",
> +		"map output only for the given command name"),
>  	OPT_PARENT(sched_options)
>  	};
>  	const struct option timehist_options[] = {

Ping.

Hi all, any comments on this patch?

Thanks and Regards
Madadi Vineeth Reddy
