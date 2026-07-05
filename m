Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0BD35DA65;
	Sun,  5 Jul 2026 14:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783261050; cv=none; b=sbkr7PWs8YPAo4ddkRDTPan1bLywuxwCHgDp+sHiRvR0QPf4x+Pf+IMOhdJHKz8LSWHQheSFa3I/BE+u5H506dKShAjMlp6os1buGsd9CI5rIgTw1Xxv6/jpEqTb4jcasRHg1LuDUdwJ2u1cIEfzjqSrxwom7MPD9LQe3/a121Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783261050; c=relaxed/simple;
	bh=sbNbn8MGFZ1W3PdAsyzm0HQkGvU5uAs7SIzxFhPCpC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YV2WtZ6Y3uj2OwIhVU4tMtSApHZK0vTQrACXtWVW6xa/eZE02GK3E+HXNtlTTK9E9CS+TG+mXdf7pIhBHH53dD6oviYPzt+RFoXldY9TqEo+KDifIoyI7hF4cH54522PfzbKmiqUUnSMeH1OW3vPptK4uT8lM1LyN4hHEEZqy6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=paFOeJwM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="paFOeJwM"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665D0J4X2445986;
	Sun, 5 Jul 2026 14:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mTMSgA
	ml02NeSoCAdJUajjcgXP3MzGsxw6mV8Xvg93s=; b=paFOeJwMhjVOyv4anpQhSO
	jfw9oMsroUTWnEHlVOJ6ARJWblWf4bWXrkrkoVbRslUBi8vwZ8S+v3rzJAY0dFG4
	MNTUrCRmR54yYjTNQrwnjvWV8bY0S52c6qvimdyAENuUlyHZAKTz4CmUV+0p92JK
	XgHu1yMMKJoTx9RDjNzvXuh8geAflsNmV5MrxdVYN3LFjQ5VMbBEsDNSTTsmTGgw
	OfO0MjzP6AVlCQ2A3Bq1TuzDLJs0V3/jm8/GNopgaFI7V0um1c0+HTGaNXfHJ8sQ
	AUH+a0FVRGlUUYiIEUHw4pnOI8+UUmM5/sQbMcS43ggMAkxtfx/xj1JlR0XgYhXg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkddsy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 05 Jul 2026 14:17:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 665E57oV013494;
	Sun, 5 Jul 2026 14:17:23 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0h1vd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 05 Jul 2026 14:17:23 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 665EHLFO25362968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 5 Jul 2026 14:17:22 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6BAB58055;
	Sun,  5 Jul 2026 14:17:21 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E7BA5804B;
	Sun,  5 Jul 2026 14:17:18 +0000 (GMT)
Received: from [9.39.25.45] (unknown [9.39.25.45])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  5 Jul 2026 14:17:17 +0000 (GMT)
Message-ID: <bd815226-c9e3-4387-a91f-8be059c38b94@linux.ibm.com>
Date: Sun, 5 Jul 2026 19:47:16 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/4] perf data-convert: Add perf.data to trace.dat
 conversion backend
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alessandro Arzilli <alessandro.arzilli@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>, atrajeev@linux.ibm.com,
        Shivani.Nittor@ibm.com
References: <20260608125951.90425-5-tshah@linux.ibm.com>
 <20260608131449.9DBDA1F00893@smtp.kernel.org>
Content-Language: en-US
From: Tanushree Shah <tshah@linux.ibm.com>
In-Reply-To: <20260608131449.9DBDA1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4a6774 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Y4S4eSUGLXBVb1daLVsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDE0NiBTYWx0ZWRfX71gL/bZPe2y/
 hNdUw0C3Y0aNgiiQL7uJD9YgX4mA+RFnqJK2RS9JdytUf6oKE4jUhNIfrYIkrKp6BWXd+EV+1ol
 gCqAE+LTSls2uln8epbL6y1f6KGCisowAke/2TsW5mrHp72GwZB7RkonMeJpToozv1+gyZtR/9Q
 6n1zfY7q/c4xDKSFQxc+CiVgn7RiQ0px2p8bh6fdQ4aCVvzBj47aI+KKno+Q6hJjOZ9c4+n+nYb
 yjReQhoUjE1b0GBeJigYbMO7qnTxB5DnZD+4jgmrJAJi9b6uycl3HGoHNVHFpezVGhDf/DcVLIC
 wZ7Gzbs89x2txZrAe+XSOQxem6hpfg7kxeSaKjpQM3yLh5u6bxqk+CB5FHBTxmO89FpEnFXLRci
 buFdH155sKtI3okgzhdxr5W8LO9WFZY77dXU7suJiWn7eLALTlT0XT4sWNrdsBHi3XrzVa2c3RG
 8U9KVDjZF1qSyVOs2Zg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDE0NiBTYWx0ZWRfXxrJvOtyv9HRD
 h+dqSSOAxHAeetuK9v1AHYc0q1Z4QOr8b9Mqto/cd0JlD13muACbFzvMqVpwhdHTYaEPchkfWx4
 jDRbWbHU5UO48F0Vjl8H1jjW10Ro2to=
X-Proofpoint-GUID: aRG5rKc0lxEmXcgKQOli3Yud318i1wKc
X-Proofpoint-ORIG-GUID: ZEY12H6rFz5Rk6smJPHPK3XLLmGqwahQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050146

Thank you for the review! I have verified the review comments.


On 08/06/26 18:44, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [Critical] Out-of-bounds heap write when tracepoint event data size exceeds the remaining space in a trace.dat page.
> - [Medium] The conversion tool fails to register required callbacks for pipe mode (such as `.attr`, `.feature`, and `.tracing_data`), silently dropping events.
> - [Medium] The output file is overwritten unconditionally, ignoring the `opts->force` flag.
> - [Medium] A `realloc` failure in `trace_dat__collect_cpu_event` causes a memory leak and subsequent segmentation fault.
> --
> 
> commit da74698d88efeca5fa33802144416838acb15d2a
> Author: Tanushree Shah <tshah@linux.ibm.com>
> 
> perf data-convert: Add perf.data to trace.dat conversion backend
> 
> Add data-convert-trace.c implementing trace_convert__perf2dat() to
> convert perf.data tracepoint events to trace.dat format.
> 
> process_sample_event() is invoked for each PERF_TYPE_TRACEPOINT sample
> during perf_session__process_events(), storing raw event bytes per-cpu
> via trace_dat__collect_cpu_event().
> 
> Once all samples are collected:
> - trace_dat__write_options_section1() writes the OPTIONS section with
>    CPUCOUNT, TRACECLOCK, HEADER_INFO, FTRACE_EVENTS, EVENT_FORMATS,
>    KALLSYMS, CMDLINES and DONE options.
> - trace_dat__write__options_section2() writes the OPTIONS section with
>    BUFFER option holding per-cpu data offset placeholders and the DONE
>    option.
> - trace_dat__write_flyrecord_section() builds ring buffer pages
>    per-cpu and patches BUFFER option with final offsets and sizes
> 
> Per-cpu buffers are sized to tep_get_page_size() from the session
> tep handle and released on all exit paths.
> 
>> diff --git a/tools/perf/util/data-convert-trace.c b/tools/perf/util/data-convert-trace.c
>> new file mode 100644
>> index 0000000000000..e4f8b817be36d
>> --- /dev/null
>> +++ b/tools/perf/util/data-convert-trace.c
> [ ... ]
>> +/* Store raw tracepoint event data in per-cpu buffer for trace.dat flyrecord */
>> +static int process_sample_event(const struct perf_tool *tool,
>> +				union perf_event *event __maybe_unused,
>> +				struct perf_sample *sample,
>> +				struct evsel *evsel,
>> +				struct machine *machine __maybe_unused)
>> +{
>> +	struct trace_convert *tc = container_of(tool, struct trace_convert, tool);
>> +
>> +	/* Collect raw tracepoint data per-cpu */
>> +	if (trace_dat_fp && sample->raw_size > 0 &&
>> +	    evsel->core.attr.type == PERF_TYPE_TRACEPOINT) {
>> +		if (trace_dat__collect_cpu_event(sample->cpu, sample->time,
>> +					sample->raw_data, sample->raw_size) < 0) {
> 
> [Severity: Medium]
> Is it possible for a memory allocation failure here to cause a crash
> during cleanup?
> 
> If trace_dat__collect_cpu_event() fails during a realloc(), it might return
> -ENOMEM while leaving the events array pointer as NULL but keeping the count
> intact.
> 
> When trace_dat__free_cpu_buffers() is called on the error path, it could
> dereference that NULL pointer:

Fix realloc to use temporary pointer and add proper cleanup
> 
> tools/perf/util/trace-dat.c:trace_dat__free_cpu_buffers() {
> 	...
> 	for (i = 0; i < trace_cpu_data[cpu].count; i++)
> 		free(trace_cpu_data[cpu].events[i].raw);
> 	...
> }
> 
>> +			pr_err("Failed to collect CPU event\n");
>> +			return -ENOMEM;
>> +		}
>> +		tc->events_count++;
>> +	}
>> +
>> +	return 0;
>> +}
> [ ... ]
>> +/* Convert perf.data tracepoint events to trace.dat format */
>> +int trace_convert__perf2dat(const char *input, const char *to_trace,
>> +			   struct perf_data_convert_opts *opts)
>> +{
>> +	struct perf_session *session;
>> +	struct trace_convert tc = {
>> +		.events_count = 0,
>> +	};
>> +	struct perf_data data = {
>> +		.path = input,
>> +		.mode = PERF_DATA_MODE_READ,
>> +		.force = opts->force,
>> +	};
>> +	int ret = -EINVAL;
>> +	bool cpu_buffers_initialized = false;
>> +
>> +	/* Initialize tool with all required callbacks */
>> +	perf_tool__init(&tc.tool, /*ordered_events=*/true);
>> +	tc.tool.sample = process_sample_event;
> 
> [Severity: Medium]
> Does this initialization omit the required callbacks for pipe mode?
> 
> By only overriding .sample, the .attr, .feature, and .tracing_data
> callbacks remain as default stubs from perf_tool__init().
> 
> In pipe mode, without these callbacks, the tool might silently fail to
> populate trace metadata and generate an empty trace.dat file.
> 
yes, will add process_attr, process_feature, process_tracing_data 
callbacks.

Original design of this feature allocates buffers before event 
processing, which worked for normal mode but will need adjustment for 
pipe mode where metadata arrives during processing. will implement lazy 
initialization in process_sample_event() that uses CPU count and page 
size from the pipe stream (populated by feature/tracing_data callbacks), 
ensuring the tool works correctly when converting pipe files from 
systems with different configurations.
>> +
>> +	/* Open output trace.dat file */
>> +	trace_dat_fp = fopen(to_trace, "wb");
>> +	if (!trace_dat_fp) {
> 
> [Severity: Medium]
> Can this unconditionally overwrite an existing file?
> 
> The fopen() call uses the "wb" mode which truncates the file, but it
> doesn't appear to check the opts->force flag.
> 
> This regression could lead to accidental data loss.

will add file existence check before overwrite
> 
>> +		pr_err("Failed to open output file: %s\n", to_trace);
>> +		return -EINVAL;
>> +	}
> [ ... ]
>> +	/* Write trace.dat options and flyrecord sections */
>> +	if (trace_dat__write_options_section1() < 0) {
>> +		pr_err("Failed to write options section1\n");
>> +		ret = -EIO;
>> +		goto out_delete;
>> +	}
>> +	if (trace_dat__write_options_section2() < 0) {
>> +		pr_err("Failed to write options section2\n");
>> +		ret = -EIO;
>> +		goto out_delete;
>> +	}
>> +	if (trace_dat__write_flyrecord_section() < 0) {
> 
> [Severity: Critical]
> Could an unusually large tracepoint event cause an out-of-bounds memory
> access when writing the flyrecord section?
> 
> When trace_dat__write_cpu_dat() processes records, it queues them to a new
> page without checking if the rec_size fits within trace_dat_page_size.
> 
> If an event size exceeds the page size, trace_dat__write_page() allocates a
> fixed-size buffer and copies the data into it:

Add page size validation in trace_dat__write_cpu_dat()
> 
> tools/perf/util/trace-dat.c:trace_dat__write_page() {
> 	page = calloc(1, trace_dat_page_size);
> 	...
> 	for (i = 0; i < nr_recs; i++) {
> 		memcpy(page + offset, records[i], rec_sizes[i]);
> 	...
> }
> 
> This regression could result in a heap buffer overflow.
> 
>> +		pr_err("Failed to write flyrecord section\n");
>> +		ret = -EIO;
>> +		goto out_delete;
>> +	}
> 

Thanks
Tanushree Shah

