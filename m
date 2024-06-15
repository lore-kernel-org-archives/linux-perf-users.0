Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F5517727;
	Sat, 15 Jun 2024 20:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718482494; cv=none; b=DRsXaGXjwZ922MjVDDad3Fh1WAB0two7td8U8DdQYdpJRv/FA8Xc1LueI9l/0xyTnmsEVFraZI0ZDWFgCwegY2nNnVNgGbbvRcXmJ2WU8Bin6ZclY3cjB7G1pDX4N5tvdkQQi5bTJanMb2/VdydIuA6R8ALO9/qEUwxP//joTns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718482494; c=relaxed/simple;
	bh=4U9P84lr6t+3JEYEYRzWAkUaJXUJVHIiXOxzeqsj0FA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JOHxHr5c8Ed3G1hISlbmX8nag2lz9hSn6lj8si6xD2S9tID5Amou/T/PVeVweU3HPNrgL165RD0+mkz1kjL1YbMNFdnrBR6x/DAM5pq/WfX2/FaEZjWuWednBW06xnHb7OM2L2pVg+0qzFeuiIceFepksEsh77jhhUP08Nc8/rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lfpcHWUy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lfpcHWUy"
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45FK0PBg014533;
	Sat, 15 Jun 2024 20:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=a
	+9Fyr6TkJfj4Jmc0tD/DI3poB1anyJvVSoeuKpmq5k=; b=lfpcHWUy6y71y8g8f
	6ei1BxrfSKlwr03XpeYc2GwoiVMAoAeIl3F0NLYF4u20XInuHAC1zEI3TGhJna9y
	PpbwKQfeZqK1XXpgiGOOC+QkGjmDVDQARTlB4LHJNZ+djru5Ut0wZfHLVuYoa6hV
	eeRVAwTD7R9MQdBAkNFYO4SjLy1Q/my5qy9m9tKoLiMkDF7LX/Z5c+LOfgbZZZFm
	+b/zgVsgndHLqGjGE8yjqeWFoLHSrcQ36QIxzm0rBAFW0YfTkLhIi9+giHD6GmN6
	LmHaySyGOuJ3cxlxAHXQXxmpD1xVNlxb/EXNq/06pNWgcrrQgAFRXe9bp3vNNHzk
	No51Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yshk5r0k3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Jun 2024 20:14:41 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45FKEeYg002240;
	Sat, 15 Jun 2024 20:14:40 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yshk5r0k1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Jun 2024 20:14:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45FGhk5r028690;
	Sat, 15 Jun 2024 19:58:08 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yn1mvb70q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Jun 2024 19:58:08 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45FJw6nA29885008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Jun 2024 19:58:08 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5410A58056;
	Sat, 15 Jun 2024 19:58:06 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EB9258052;
	Sat, 15 Jun 2024 19:58:01 +0000 (GMT)
Received: from [9.43.66.127] (unknown [9.43.66.127])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 15 Jun 2024 19:58:00 +0000 (GMT)
Message-ID: <c967a861-ff65-4b35-8a45-7e39b9849be5@linux.ibm.com>
Date: Sun, 16 Jun 2024 01:27:57 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: sched map skips redundant lines with cpu filters
To: Fernand Sieber <sieberf@amazon.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20240614073517.94974-1-sieberf@amazon.com>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20240614073517.94974-1-sieberf@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZUV4iNxAwLeMgtslx8Jn_nBviL-QDhr3
X-Proofpoint-GUID: JK3W7m8-ky4YIzL3GW4M1wWFlNg_Y1CZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-15_14,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 adultscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406150152

Hi Fernand,

On 14/06/24 13:05, Fernand Sieber wrote:
> perf sched map supports cpu filter.
> However, even with cpu filters active, any context switch currently
> corresponds to a separate line.
> As result, context switches on irrelevant cpus result to redundant lines,
> which makes the output particlularly difficult to read on wide
> architectures.
> 
> Fix it by skipping printing for irrelevant CPUs.
> 
> Example snippet of output before fix:
> 
>   *B0       1.461147 secs
>    B0
>    B0
>    B0
>   *G0       1.517139 secs
> 
> After fix:
> 
>   *B0       1.461147 secs
>   *G0       1.517139 secs

Yes, this makes sense. The current implementation doesn't even print timestamp
for the redundant lines as shown in the example below.

   .  *F0   708529.114889 secs F0 => schbench:278841
   .   F0 
   .   F0 
   .  *.    708529.114919 secs 

It makes sense to remove them entirely since we can still infer the sched-out
time for the selected CPUs implicitly.

Reviewed-and-tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>

Thanks and Regards
Madadi Vineeth Reddy
> 
> Signed-off-by: Fernand Sieber <sieberf@amazon.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> ---
>  tools/perf/builtin-sched.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 7422c930abaf..aa59f763ca46 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -1594,8 +1594,6 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  
>  	sched->curr_thread[this_cpu.cpu] = thread__get(sched_in);
>  
> -	printf("  ");
> -
>  	new_shortname = 0;
>  	if (!tr->shortname[0]) {
>  		if (!strcmp(thread__comm_str(sched_in), "swapper")) {
> @@ -1622,6 +1620,11 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  		new_shortname = 1;
>  	}
>  
> +	if (sched->map.cpus && !perf_cpu_map__has(sched->map.cpus, this_cpu))
> +		goto out;
> +
> +	printf("  ");
> +
>  	for (i = 0; i < cpus_nr; i++) {
>  		struct perf_cpu cpu = {
>  			.cpu = sched->map.comp ? sched->map.comp_cpus[i].cpu : i,
> @@ -1656,9 +1659,6 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  			color_fprintf(stdout, color, "   ");
>  	}
>  
> -	if (sched->map.cpus && !perf_cpu_map__has(sched->map.cpus, this_cpu))
> -		goto out;
> -
>  	timestamp__scnprintf_usec(timestamp, stimestamp, sizeof(stimestamp));
>  	color_fprintf(stdout, color, "  %12s secs ", stimestamp);
>  	if (new_shortname || tr->comm_changed || (verbose > 0 && thread__tid(sched_in))) {
> @@ -1675,9 +1675,9 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  	if (sched->map.comp && new_cpu)
>  		color_fprintf(stdout, color, " (CPU %d)", this_cpu);
>  
> -out:
>  	color_fprintf(stdout, color, "\n");
>  
> +out:
>  	thread__put(sched_in);
>  
>  	return 0;

