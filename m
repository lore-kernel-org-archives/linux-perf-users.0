Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C99F4229B1;
	Thu, 16 Jul 2026 13:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784207429; cv=none; b=b4AWfRpjCjuCUkrRQeTK7/loK5jcP4VY34Pd4pwmNZUdhw71wQ72cNg4RP6mqR8O3k4kLn99hwDaWfV07z1Wn1/WbuiY0eVFXOIekybIdgkyzx6RpIZk9J0WJ33A9CpvxbyCiWr6b6pekMH8kBZPZbe0xgxLmVtI6xfiBNo1lO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784207429; c=relaxed/simple;
	bh=MHmOynP4ziXmZ7uo2lyVX6ZLwEAOgiVezkX9yP9G8zI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JoNU+VByffOvKetKAaqRryo8jjO4QlfclsY48xuoovZesl5u0XVEldO6t6nRUL72GRTnTcAzPypiDPVHi67FOGWzXXffX/Xh40fNKBGo3sbHnXU2Mm2Zo6hh9nnuarwzBEP2Uxw3BJVdvaPAUGiEYN9KHt3dbwEJMtWVzRIIJfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T25Ec9pf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T25Ec9pf"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GABoBZ2826102;
	Thu, 16 Jul 2026 13:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FeT40E
	DjmDp0sSk8HtVCLiseLc14P1noDHjd6VJ9yyI=; b=T25Ec9pf8nWanWyvMzFtex
	CSE+ZJmfcRIbIFkrxR2Hw0+iy3AGle4UhGPNGsDFiOSeJ4Q0cDB8AAd5UB+sjdbS
	0nUHhZPqkH204nbLCzf6NhiK7CYlFXnhCM0o0ugAjA3zNOK3i87Q/ki9rZP++Ecw
	BfOlMNe86H25+57Ms7qEQ4e8geWJvlKNI5YinFKHMxcswfLhuA8gRztI9bf8fIrl
	yQcFR4eZjwvzs4u8ux4i/AqvfpS3pm0NVKW+J/y1GOqdsZi+5gOyWmG2NhX6nI3m
	qn81biW2MdN7hzuHVGUq2z5fRMN+7v54+r6exIOtxng+F2RDDV8gcSk9WGrZvfqw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexx05uc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 13:10:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GD4kVE002456;
	Thu, 16 Jul 2026 13:10:16 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hwd7f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 13:10:16 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66GDAF2Y19923564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2026 13:10:15 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFBE25805D;
	Thu, 16 Jul 2026 13:10:14 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AC245805F;
	Thu, 16 Jul 2026 13:10:11 +0000 (GMT)
Received: from [9.124.218.90] (unknown [9.124.218.90])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jul 2026 13:10:10 +0000 (GMT)
Message-ID: <783a7d08-d983-415f-a9a2-cb56c8755bf3@linux.ibm.com>
Date: Thu, 16 Jul 2026 18:40:09 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/4] perf data: Add --to-trace-dat option for
 converting perf.data tracepoint events into trace.dat format
To: sashiko-reviews@lists.linux.dev,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
        Madhavan Srinivasan
 <maddy@linux.ibm.com>, atrajeev@linux.ibm.com,
        hbathini@linux.ibm.com, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-perf-users@vger.kernel.org
References: <20260608125951.90425-6-tshah@linux.ibm.com>
 <20260608131243.C06BF1F00893@smtp.kernel.org>
Content-Language: en-US
From: Tanushree Shah <tshah@linux.ibm.com>
In-Reply-To: <20260608131243.C06BF1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 1N237mZurA9IyVWec7WfJgJ5CPJIyBB0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEzMSBTYWx0ZWRfX+gRWKLjJqPId
 UtOhnAl/YujFbNSV5e0sSqdqtb0ptLUFSTTzvgTs+leG3Zka/hunv+Lyz/COVUuw8Gi7N6mjVRa
 KNVnFlvr1UOVrkpHDyXE9ojVyONR8//SEFlNzyXPMy8PxgFXTFOcvdBmiKKsZn7KlSqNN6nQAGp
 /k8dr/gt54ffwe/Dz6XtiGyQE54eL4SBwHdS6BipykkPSbLnyY+g1i6kT0LHVnfJpz1tNCuDCrE
 Swi8klcZIQE4XzndbIn6C9oYfGJlvxkusGKhJW63ESYvmXlYSoKirXhQe07nlp3gjJrCEehWmND
 AM2rLZVMxZmKpgm2md4cQXJcsfD+bTHSoWDNypypMZyFCXy23R2FWUXFKLSJennI9HJa06N8UxL
 XtoL332EPEeZyJz4vvG3ihy8izOOa6Kv86QT5f7X8c6mtHcHu2ptCMcP/yvGFRliVYgDsC9AxNN
 ig/OS+2QNg2px/5l5FQ==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a58d839 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=OecNZQAgBSG-EfNzvW0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: IJfdXU0Ml8zU_0sMv87rEQlj99a8JGY0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEzMSBTYWx0ZWRfXyM1bOhnvaFou
 yHDyoWtixyH8e0M6MaDLzMvhWazOnSe1hRgllq52SeCNNfHe4fvh/JiDr3nVXVupWXMRfBEPRZ3
 +vt7jsOp4Yvz6ESCcpNUVKoMXp3jDAQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160131


Hi,

Thank you for the Sashiko AI review feedback. I acknowledge the issues 
identified and will address them in v2..
On 08/06/26 18:42, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [High] The `trace_convert__perf2dat` tool fails to register required `.attr`, `.feature`, and `.tracing_data` callbacks, breaking pipe mode.
> - [High] Accessing unverified `perf_env` field `nr_cpus_online` leads to deterministic failure when CPU topology feature is missing.
> - [High] Failing `realloc()` in `trace_dat__collect_cpu_event()` leaks memory and causes a NULL pointer dereference in the cleanup path.
> - [Low] Missing semicolon after `return -1` in the `#else` branch inside `cmd_data_convert`.
> --
> 
> commit 789bd3d29fe2134b1ed0b9a17d6c674bc7d7db23
> Author: Tanushree Shah <tshah@linux.ibm.com>
> 
> perf data: Add --to-trace-dat option for converting perf.data tracepoint events into trace.dat format
>      
> Add new command-line option to perf data convert for generating
> trace.dat output files. Accepts output filename for trace.dat format,
> mutually exclusive with --to-ctf and --to-json, and calls
> trace_convert__perf2dat() to perform conversion.
> 
>> diff --git a/tools/perf/builtin-data.c b/tools/perf/builtin-data.c
>> index 4c08ccb8c06b7..96ccab77456a3 100644
>> --- a/tools/perf/builtin-data.c
>> +++ b/tools/perf/builtin-data.c
> 
> [ ... ]
> 
>> @@ -65,16 +72,43 @@ static int cmd_data_convert(int argc, const char **argv)
> [ ... ]
>>   #else
>> +	#ifdef HAVE_LIBTRACEEVENT
>> +	if (!to_json && !trace_dat_output) {
>> +		pr_err("You must specify --to-json or --to-trace-dat.\n");
>> +		return -1;
>> +	}
>> +	#else
>>   	if (!to_json) {
>>   		pr_err("You must specify --to-json.\n");
>> -	return -1;
>> -}
>> +		return -1
>> +		}
> 
> [Severity: Low]
> Is there a missing semicolon here? It looks like this will break compilation
> for environments lacking both HAVE_LIBBABELTRACE_SUPPORT and
> HAVE_LIBTRACEEVENT.
> 
yes, I will fix it.
>> +	#endif
>> +#endif
>> +
>> +#ifdef HAVE_LIBTRACEEVENT
>> +	if (trace_dat_output)
>> +		return trace_convert__perf2dat(input_name ? input_name : "perf.data",
>> +					       trace_dat_output, &opts);
> 
> [Severity: High]
> Does trace_convert__perf2dat() register the required callbacks for pipe mode?
> 
> Looking at the tool initialization in trace_convert__perf2dat():
> 
> 	/* Initialize tool with all required callbacks */
> 	perf_tool__init(&tc.tool, /*ordered_events=*/true);
> 	tc.tool.sample = process_sample_event;
> 
> If .attr and .feature are not overridden, won't incoming
> perf_event_header_attr and feature events from a pipe be silently dropped,
> preventing the creation of evlists/evsels and breaking event processing?
yes, As mentioned in the reply of patch 3 review, I will add these 
callbacks.
> 
> [Severity: High]
> How does this code handle missing CPU topology features?
> 
> Looking at trace_convert__perf2dat():
> 
> 		if (trace_dat__init_cpu_buffers(session->header.env.nr_cpus_online) < 0) {
> 
> If the feature callback is not registered (like in pipe mode) or the CPU
> topology feature wasn't recorded, wouldn't session->header.env.nr_cpus_online
> remain 0?

Implement lazy initialization by deferring CPU buffer setup until the 
first sample event, after process_feature() and process_tracing_data() 
have populated the session header. This will also ensure that we use the 
recorded machine's CPU count also in case of pipe perf.data , and not 
the host system's, which is critical for cross-platform analysis.
> 
> If trace_dat__init_cpu_buffers(0) succeeds with 0 elements, won't
> trace_dat__collect_cpu_event() later check cpu >= trace_dat_nr_cpus (0 >= 0)
> and return -EINVAL, causing process_sample_event to return -ENOMEM and abort
> the conversion?
> 
> [Severity: High]
> Is it possible for a reallocation failure to cause a memory leak and
> subsequent NULL pointer dereference?
> 
> Looking at trace_dat__collect_cpu_event():
> 
> 		cpu_events->events   = realloc(cpu_events->events,
> 				       cpu_events->capacity * sizeof(*cpu_events->events));
> 		if (!cpu_events->events)
> 			return -ENOMEM;
As I mentioned in reply of 1st patch review, use a temporary pointer for 
realloc() and only update cpu_events->events and cpu_events->capacity 
after successful allocation.
> 
> If realloc fails, doesn't it overwrite cpu_events->events with NULL, leaking
> the old array?
> 
> Furthermore, if this returns -ENOMEM and cascades up to trigger the cleanup
> path in trace_dat__free_cpu_buffers():
> 
> 		for (i = 0; i < trace_cpu_data[cpu].count; i++)
> 			free(trace_cpu_data[cpu].events[i].raw);
> 
> Since count was not reset, won't this loop access events[i] and dereference
> the NULL pointer?
> 

Additionally, add defensive NULL check in trace_dat__free_cpu_buffer() 
cleanup.


>> +#endif
> 

