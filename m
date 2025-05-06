Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6732C1C5D5A
	for <linux-perf-users@vger.kernel.org>; Tue,  6 May 2025 06:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746514143; cv=none; b=tH9IcspT0be4dIXafjDg8hYNPfg93ICrIN1wnlkTaeavjbGBY95NJE2sIjoGIzSAzaGauSUiyx+bwrZOrN57GGdXLNU5daIoo4wx6vY/84IVQfeTg17/asOinIp3HG/aMUJyDWEANEHwEee0b6ytz2OCwBbGo74FAQucunfEu0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746514143; c=relaxed/simple;
	bh=DQX+HSyK/A4pKdJ6Wcy13raRHbAw0cR4RxvqIvGHBxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FRdOghJwkp8J05bTpAAYiU1e7KntPf2pgSeBNiSlqDnC3wT+27kYbvkVsGI2d9qZamrI3uYuTdjnhzo1tmlrLNarHQl5QDy+ASJVAs/uoZshjqlRpBSDJlHzGKN+B+N1Tn8QGaNf7pWrYLQQNRGkc6wo6ldEYyvThApNEWdUVWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rfMbSkPg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rfMbSkPg"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5465giwX006736;
	Tue, 6 May 2025 06:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PUhovj
	zHf0+NE8mdu7J28hkOcUvHyTW6u/okdUGynxU=; b=rfMbSkPgBpLGTIQyv3wUok
	bIMH50NaRyc0NFJZ6P2ROZhqgbDxn78DO0f5xZJtU0rLJ/DgZ9LTLqqcLrDPBx/n
	ezoXnmcZrp5pbF0jdgng2C6ztoo51fKksgDfWEhJalsX/j9HKsh0a30IDXZy1MJP
	bFWgXcaQhAac8ZJwp7IKSPEsyyjE3CY9EbzUOGtZRemChq3AZ8J8HG2d573OhaDs
	OhnMlX/uGaJ20PyiqWnYfPytq8d3MAQ+LRGzi6BQLorfJUtTKS6r0Bp5NW46D8G7
	7b8Tb4lPbahFaaU6kC5ib+0axzKkapUs91tBM2/ylUcFJJUqBNYLAaQKXuxhL72g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46fcgy06xw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 06:48:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 546409RP002765;
	Tue, 6 May 2025 06:48:57 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dxfnt6aj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 06:48:57 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5466mpwa30212726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 May 2025 06:48:51 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B7562004B;
	Tue,  6 May 2025 06:48:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49FFA2004E;
	Tue,  6 May 2025 06:48:50 +0000 (GMT)
Received: from [9.109.217.253] (unknown [9.109.217.253])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 May 2025 06:48:50 +0000 (GMT)
Message-ID: <44ee5f28-41ea-4523-8fe8-9d0d52129f5c@linux.ibm.com>
Date: Tue, 6 May 2025 12:18:49 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf script: perf script tests fails with segfault
Content-Language: en-GB
To: Aditya Bodkhe <adityab1@linux.ibm.com>, linux-perf-users@vger.kernel.org
Cc: Aditya Bodkhe <aditya.b1@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20250429065132.36839-1-adityab1@linux.ibm.com>
From: Disha Goel <disgoel@linux.ibm.com>
In-Reply-To: <20250429065132.36839-1-adityab1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 58UzGs27icGbL434zeGnkyTSkjeTjw-2
X-Authority-Analysis: v=2.4 cv=Pa7/hjhd c=1 sm=1 tr=0 ts=6819b0d9 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8 a=nRiDTj3yiyNuxznsutwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 58UzGs27icGbL434zeGnkyTSkjeTjw-2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA2MSBTYWx0ZWRfX0W64SnLuadTB LBcSp0vihUiuSLm5BRU7KA1S7avvuqzBF6OlcKA7lY20Vn+gzaQ7AssqLoFjIpFgCAvFeB91qqW wrmNNPuRTOvZJnn1HwyBCGoOdVeAk4Cn3UNLcbtHMIg83pCtjiD3/Dvo2mqw03W0Ac8awLWTvRH
 Fj95ySKD8FHzVFufFbYaL16Z91WIY1RzcigO/doER0XAnRgg8U1Cmqywhj90sVoLNzWUKo/fC6V BVqOVa9JjlSDUddo+mUM2jZJCNYLpK36WvMc8LaUbN+OtJ3FcSbSz8ofvoHx36TUSm01+MQs6RT Cmni0Dl2w0CVYVThD8ffj4xzlVlNwJlyM36LFlOX0Ie68FK9jrXtWTNTD10dhavWd0aXk2IC2Oy
 QZVBwMrqn1dDclKDqsWpMzWd8Hwaau/94gFcX5LZAZHZG3T43lUt/BqcpsL7s1eJw2/zUBcH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_03,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505060061

On 29/04/25 12:21 pm, Aditya Bodkhe wrote:
> From: Aditya Bodkhe <aditya.b1@linux.ibm.com>
> 
> perf script: pert script tests fails with segmentation fault as below:
> 
>   92: perf script tests:
>   --- start ---
> test child forked, pid 103769
> DB test
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.012 MB /tmp/perf-test-script.7rbftEpOzX/perf.data (9 samples) ]
> /usr/libexec/perf-core/tests/shell/script.sh: line 35: 103780 Segmentation fault      (core dumped) perf script -i "${perfdatafile}" -s "${db_test}"
>   --- Cleaning up ---
>   ---- end(-1) ----
> 	92: perf script tests                                               : FAILED!
> 
> Backtrace pointed to :
> 	#0  0x0000000010247dd0 in maps.machine ()
> 	#1  0x00000000101d178c in db_export.sample ()
> 	#2  0x00000000103412c8 in python_process_event ()
> 	#3  0x000000001004eb28 in process_sample_event ()
> 	#4  0x000000001024fcd0 in machines.deliver_event ()
> 	#5  0x000000001025005c in perf_session.deliver_event ()
> 	#6  0x00000000102568b0 in __ordered_events__flush.part.0 ()
> 	#7  0x0000000010251618 in perf_session.process_events ()
> 	#8  0x0000000010053620 in cmd_script ()
> 	#9  0x00000000100b5a28 in run_builtin ()
> 	#10 0x00000000100b5f94 in handle_internal_command ()
> 	#11 0x0000000010011114 in main ()
> 
> Further investigation reveals that this occurs in the `perf script tests`,
> because it uses `db_test.py` script. This script sets `perf_db_export_mode = True`.
> 
> With `perf_db_export_mode` enabled, if a sample originates from a hypervisor,
> perf doesn't set maps for "[H]" sample in the code. Consequently, `al->maps` remains NULL
> when `maps__machine(al->maps)` is called from `db_export__sample`.
> 
> As al->maps can be NULL in case of Hypervisor samples , use thread->maps
> because even for Hypervisor sample, machine should exist.
> If we don't have machine for some reason, return -1 to avoid segmentation fault.
> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Aditya Bodkhe <aditya.b1@linux.ibm.com>
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>

I have tested the patch on PowerPC, it fixes the reported issue and test 
passes.

# ./perf test -v 'perf script tests'
  95: perf script tests : Ok

Tested-by: Disha Goel <disgoel@linux.ibm.com>

> ---
> Changelog:
> v2 -> v3:
> This patch contains changes suggested by Adrian Hunter<adrian.hunter@intel.com> to add extra spaces
> before ---start--- and ---end---
> to be able to apply patch without any issues
> 
> v1 -> v2:
> The below patch contains changes suggested by Adrian Hunter<adrian.hunter@intel.com> to handle the segmentation fault ,
> as well as initialisation of al.thread
> 
>   tools/perf/util/db-export.c                           | 11 ++++++++---
>   .../perf/util/scripting-engines/trace-event-python.c  |  2 +-
>   2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
> index 50f916374d87..8f52e8cefcf3 100644
> --- a/tools/perf/util/db-export.c
> +++ b/tools/perf/util/db-export.c
> @@ -181,7 +181,7 @@ static int db_ids_from_al(struct db_export *dbe, struct addr_location *al,
>   	if (al->map) {
>   		struct dso *dso = map__dso(al->map);
> 
> -		err = db_export__dso(dbe, dso, maps__machine(al->maps));
> +		err = db_export__dso(dbe, dso, maps__machine(thread__maps(al->thread)));
>   		if (err)
>   			return err;
>   		*dso_db_id = dso__db_id(dso);
> @@ -256,6 +256,7 @@ static struct call_path *call_path_from_sample(struct db_export *dbe,
>   		al.map = map__get(node->ms.map);
>   		al.maps = maps__get(thread__maps(thread));
>   		al.addr = node->ip;
> +		al.thread = thread__get(thread);
> 
>   		if (al.map && !al.sym)
>   			al.sym = dso__find_symbol(map__dso(al.map), al.addr);
> @@ -358,14 +359,18 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
>   	};
>   	struct thread *main_thread;
>   	struct comm *comm = NULL;
> -	struct machine *machine;
> +	struct machine *machine = NULL;
>   	int err;
> 
> +	if (thread__maps(thread))
> +		machine = maps__machine(thread__maps(thread));
> +	if (!machine)
> +		return -1;
> +
>   	err = db_export__evsel(dbe, evsel);
>   	if (err)
>   		return err;
> 
> -	machine = maps__machine(al->maps);
>   	err = db_export__machine(dbe, machine);
>   	if (err)
>   		return err;
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index 520729e78965..00f2c6c5114d 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -1306,7 +1306,7 @@ static void python_export_sample_table(struct db_export *dbe,
> 
>   	tuple_set_d64(t, 0, es->db_id);
>   	tuple_set_d64(t, 1, es->evsel->db_id);
> -	tuple_set_d64(t, 2, maps__machine(es->al->maps)->db_id);
> +	tuple_set_d64(t, 2, maps__machine(thread__maps(es->al->thread))->db_id);
>   	tuple_set_d64(t, 3, thread__db_id(es->al->thread));
>   	tuple_set_d64(t, 4, es->comm_db_id);
>   	tuple_set_d64(t, 5, es->dso_db_id);
> --
> 2.43.0
> 
> 
> 

