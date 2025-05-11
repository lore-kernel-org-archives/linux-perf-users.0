Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7143D81
	for <linux-perf-users@vger.kernel.org>; Sun, 11 May 2025 05:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746942948; cv=none; b=cqzxSV8roueM6OkLMRDH6w1aI7JmrVVlcSp3zW52kYo9fepRPA18XjSDbELEfJrVUa7HudQaoKX1XBbela9/ymEgYBlxuZaRGMOr4ctvBabnmrHj3vn3IeQWyDAzGVdOINFSCyutkNo9KqeUZ43KlYY8DCCR3VOAMohXK/rzk5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746942948; c=relaxed/simple;
	bh=a26yTv+hz9hhrWmz3vE5Hc9fnLKbuninPB4VdxAqDCI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=G/2S4QGm13b4ClPr6V5C9OBBNHeMlBKHe9RmDAc0S9bvJaybP8Txajb0ZrVxtLxqRHf+WIAbEhuZgyV4/4PrIoc9MP9Ik5jcai04kTKOrl8p2pIiACy2lJvOoTXkJ4wkjWiK1yyvQqAMczNarl2MOcQvJwIvb5Utj8WE0tusvDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wg8mjCGh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wg8mjCGh"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54B2fBK7021541;
	Sun, 11 May 2025 05:55:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iIK0dO
	zyU0tOceKcboEB/er26o/bbDtTUUxQYzwR1bk=; b=Wg8mjCGhqXlhGGVMRVzBTK
	SlGeoWdesWXHfD3OypOrsee3vrLLUeODoPYu12+2usWCl2M7Zc9liPOiepMjEjtG
	doMkUIWi6mYIlRZoWEDd9ZE56J7HwxV5nP+XWof5IcSxHvoRn7mA7ccy9pgAPjjK
	mnS65c3h86gpUTlff8HxFKzS3JNbmKfLvreh6Wlmg1nqwTjDHrT/nXg2peQDn10E
	GbfADmePIAGRI1nlUoEPjX4tHHwYBkwRliVU5+4cRN6wM2R2mDpYhJkmhbM+Dsr0
	uNetXQJrJSrqIUVg0fgwCHtugyYq7+kK1cec45jeCeIFN95Qjy49erS5u7Sltz7g
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46jce8h41k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 May 2025 05:55:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54B0bPMk016928;
	Sun, 11 May 2025 05:55:44 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46jhgyrt1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 May 2025 05:55:44 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54B5tcuh44630410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 11 May 2025 05:55:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E45F2005A;
	Sun, 11 May 2025 05:34:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB84520067;
	Sun, 11 May 2025 05:33:59 +0000 (GMT)
Received: from [9.43.60.96] (unknown [9.43.60.96])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 11 May 2025 05:33:59 +0000 (GMT)
Message-ID: <68cb4551-7992-4d91-bf00-a3b46e41fea2@linux.ibm.com>
Date: Sun, 11 May 2025 11:03:59 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf script: perf script tests fails with segfault
From: Aditya Bodkhe <adityab1@linux.ibm.com>
To: linux-perf-users@vger.kernel.org
Cc: Aditya Bodkhe <aditya.b1@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20250429065132.36839-1-adityab1@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250429065132.36839-1-adityab1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LQs_gqPBxYEF23V3zIU_yaotvj2GVc2Z
X-Proofpoint-GUID: LQs_gqPBxYEF23V3zIU_yaotvj2GVc2Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTExMDA1MyBTYWx0ZWRfXzeU4i2c5KGW2 SzOhoZJtxNaI/SCf2Zwnw0nz2xAnr5fYgR/2WVxMIO4E2aJ+C6bpt3FHv0GTYXW4+RLDMiJKihv 1quzI7Y3yyyXCgpGxYUJZXttnKAUaHdLRtmdcClLDIMNFh3wVkgeUwql6BAJGd2kbp/ts65Camx
 pa+8H0ZFfQAMypQRlCw9UeAnkdvbjC8e7VPEgHXi2CK4fDugWPzy/MSk00h5UjX57FtDxQwVIH+ rHvO9YzSdVVl9uhU+A8cj5TBbKwHouvAPQ4HR5Ylfr056dmWZdH1C/mTn54vxBIRxZgHswWsh4T WgB9XAz3ClIPl0fAS5qY13D1MU8GTZHllPIulLbh8HSDHaR0OvFZ0uZmV/KTj/bV/D465sh5KRq
 mv1tNbA20VpatrngYm7Hk+StE85HTDdFSM/h/asJm7P6+o0HtVmpFtBbrtly7S7qqOMdmJdN
X-Authority-Analysis: v=2.4 cv=fvrcZE4f c=1 sm=1 tr=0 ts=68203be1 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8 a=nRiDTj3yiyNuxznsutwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-11_02,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505110053

I will handle helper as a separate patch . Can this patch be pulled in.


Thanks

Aditya Bodkhe

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
