Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3A0223323
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Apr 2025 08:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744877117; cv=none; b=RJr/Ifu+nhLFaHkN09KCYeN8AhJO41D7W44JsSI+KIBJ/KTHuet4fV+xehhoBLO2IjmN8YEhac4PxKpbWLveyGMYmK4HMXbiAMYRFWpW3WQnmoD3sJMgaAIhGV9OQL4zgvZeQgllHnylbNuU1YysDBeMoIc+elSKpdtLcBVaXms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744877117; c=relaxed/simple;
	bh=kbEnyBI+AdM6mI3CmKGsJHe+s8DY43obTQrK9g3leiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=khC5q4AVYtGq+IlxDMviUrC6fUJTXaT6tHtyq+djmmFQEUeVeRXL7RpW43Jg8JKc1v24h+J5J/HTga/dZUemUtBrIu42/bvkB4x9KJN2NyIZZmqu/vtV64E69zK0mLeILZGlK22w7nR1cEBvkPxSwbkSX2YdQGGVCe4czQSt0m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UPnruC2V; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UPnruC2V"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GLhVbR017611;
	Thu, 17 Apr 2025 08:05:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0VL9B+
	veoJpsKYaIZ+nlqmUSvc/GpsofdYwppwCFiG8=; b=UPnruC2VswTJo68JPEvGgq
	vAD/f4IXH9BfNdKagB9z7dX6337+X9SX5Z5mANAEzMxY6yLCQhjeRLLrAINYlAk7
	8qljjTv5T7tzJCPOa0kXMU2zGuA2A9BaN4YD3iJoqEQJ/koZvsQ1XfQ6K8uMKNke
	7GiU4s5AzaOutWczWWUoZdE3Nvvp8TjlC8MW6DsMqQVTWKZb2m2ZlNEWHLtnQscJ
	4Un9501wCYeIR46gxe9DNR3es92rsq2f01bMHrfbtGbQv0ig5kvccQ17qsJ6Q/M0
	Aeq5Y1GKWpcIMgX4N2VFu4us+cavcuEvvsSIszE8lMIpWehL/qWUIOrIJed/FsIg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462mpv262k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 08:05:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53H6Utj7017204;
	Thu, 17 Apr 2025 08:05:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46040m4jyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 08:05:03 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53H852w919923292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 08:05:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E65A020043;
	Thu, 17 Apr 2025 08:05:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE4F82004B;
	Thu, 17 Apr 2025 08:05:00 +0000 (GMT)
Received: from [9.109.199.221] (unknown [9.109.199.221])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Apr 2025 08:05:00 +0000 (GMT)
Message-ID: <b0f58602-f08c-4efe-9019-17d2424fdc54@linux.ibm.com>
Date: Thu, 17 Apr 2025 13:35:00 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf script: perf script tests fails with segfault
To: Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, Disha Goel <Disha.Goel@ibm.com>,
        Aditya Bodkhe <aditya.b1@linux.ibm.com>
References: <20250320091551.17846-1-adityab1@linux.ibm.com>
 <Z90BhWbDJjR15_6q@google.com>
 <0258d25c-a2dc-438b-ae91-65ae70126387@intel.com>
Content-Language: en-US
From: Aditya Bodkhe <adityab1@linux.ibm.com>
In-Reply-To: <0258d25c-a2dc-438b-ae91-65ae70126387@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KJVaDEFo c=1 sm=1 tr=0 ts=6800b630 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=w6wZo_Wm-W_L7VW3DmEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: teVMpL_JrZhxzc18ODmgzbwSieIV-2dv
X-Proofpoint-ORIG-GUID: teVMpL_JrZhxzc18ODmgzbwSieIV-2dv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=982
 phishscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504170062

Hi Adrian,

The approach you suggested works well in general, but we encountered a 
case where al->thread was NULL, which led to a segmentation fault. To 
prevent this, we need to ensure that al->thread is properly set before 
it's used in this line:

@@ -181,7 +181,7 @@ static int db_ids_from_al(struct db_export *dbe, 
struct addr_location *al,
      if (al->map) {
          struct dso *dso = map__dso(al->map);

-        err = db_export__dso(dbe, dso, maps__machine(al->maps));
+        err = db_export__dso(dbe, dso, 
maps__machine(thread__maps(al->thread)));

So, the following additional change is required to set al->thread:

--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -256,6 +256,7 @@ static struct call_path 
*call_path_from_sample(struct db_export *dbe,
                 al.map = map__get(node->ms.map);
                 al.maps = maps__get(thread__maps(thread));
                 al.addr = node->ip;
+               al.thread = thread__get(thread);

                 if (al.map && !al.sym)
                         al.sym = dso__find_symbol(map__dso(al.map), 
al.addr);

I will send a V2 with these changes
Sent again for replying to all

Thanks
Aditya

On 21/03/25 1:28 pm, Adrian Hunter wrote:
> On 21/03/25 08:04, Namhyung Kim wrote:
>> CC-ing Adrian,
> Thanks!
>
>> On Thu, Mar 20, 2025 at 02:45:51PM +0530, Aditya Bodkhe wrote:
>>> perf script: pert script tests fails with segmentation fault as below:
>>>
>>> 1. Run perf test -vvv 'perf script tests'
>>>
>>> 	 92: perf script tests:
>>> 	--- start ---
>>> 	test child forked, pid 103769
>>> 	DB test
>>> 	[ perf record: Woken up 1 times to write data ]
>>> 	[ perf record: Captured and wrote 0.012 MB /tmp/perf-test-script.7rbftEpOzX/perf.data (9 samples) ]
>>> 	/usr/libexec/perf-core/tests/shell/script.sh: line 35: 103780 Segmentation fault      (core dumped) perf script -i "${perfdatafile}" -s "${db_test}"
>>> 	--- Cleaning up ---
>>> 	---- end(-1) ----
>>>   	92: perf script tests                                               : FAILED!
>>>
>>> Backtrace pointed to :
>>> 	#0  0x0000000010247dd0 in maps.machine ()
>>> 	#1  0x00000000101d178c in db_export.sample ()
>>> 	#2  0x00000000103412c8 in python_process_event ()
>>> 	#3  0x000000001004eb28 in process_sample_event ()
>>> 	#4  0x000000001024fcd0 in machines.deliver_event ()
>>> 	#5  0x000000001025005c in perf_session.deliver_event ()
>>> 	#6  0x00000000102568b0 in __ordered_events__flush.part.0 ()
>>> 	#7  0x0000000010251618 in perf_session.process_events ()
>>> 	#8  0x0000000010053620 in cmd_script ()
>>> 	#9  0x00000000100b5a28 in run_builtin ()
>>> 	#10 0x00000000100b5f94 in handle_internal_command ()
>>> 	#11 0x0000000010011114 in main ()
>>>
>>> Further investigation reveals that this occurs in the `perf script tests`,
>>> because it uses `db_test.py` script. This script sets `perf_db_export_mode = True`.
>>>
>>> With `perf_db_export_mode` enabled, if a sample originates from a hypervisor,
>>> perf doesn't set maps for “[H]” sample in the code. Consequently, `al->maps` remains NULL
>>> when `maps__machine(al->maps)` is called from `db_export__sample`.
>>>
>>> To prevent this NULL pointer dereference, add a check for `al->maps == NULL`
>>> before calling `maps__machine()`. If `al->maps` is NULL, return `-1` to avoid
>>> the segmentation fault.
>>>
>>> Reported-by: Disha Goel <Disha.Goel@ibm.com>
>>> Signed-off-by: Aditya Bodkhe <aditya.b1@linux.ibm.com>
>>> ---
>>>   tools/perf/util/db-export.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
>>> index 50f916374d87..f355878a8c82 100644
>>> --- a/tools/perf/util/db-export.c
>>> +++ b/tools/perf/util/db-export.c
>>> @@ -365,6 +365,11 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
>>>          if (err)
>>>                  return err;
>>>
>>> +       if (!al->maps) {
>>> +          err = -1;
>>> +          goto out_put;
>>> +       }
>> Maybe better to check it before db_export__evsel().  Also it seems it
>> should not goto out_put as it doesn't get the main_thread yet.
> There has to be a machine to have found a thread.  I'd suggest
> getting the machine from the thread, like this:
>
> diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
> index 50f916374d87..7ea6fd474c4c 100644
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
> @@ -358,14 +358,18 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
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
>
>
>
>
