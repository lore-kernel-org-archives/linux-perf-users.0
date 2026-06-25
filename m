Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A6A25B099;
	Thu, 25 Jun 2026 18:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782410711; cv=none; b=DFSgiDVZ/sZNgnmJOqjbVpoGSoSSWqatf9M/ki9GS3Eb5csRFl7L+3V3lvfjtmIWLmt89mji2xBFBD2KAknnDmsMZjtujkykwID7ZnfwVMy6jdW7rnrH+JhRsSSTi9FdNLG/KxdYWlgUV0EVwkyVwrxW5F9JZIRVBOPxmRXzFTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782410711; c=relaxed/simple;
	bh=H3OT0G9QmaHCgy2jHeIKObVPBJUM7C32qkE0XSEgtHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o72qViXi20oT6rTEO1SLkM5EueYHjkOQo30IYZENBToE8zT/9RX9lQJRTJ7i4ZijW9ZjkU3JOIImy0J/mc3EXRb6mkMmVJH0Y5o1F6qpSjlEqsOb8YOSajpYX6K+WvQ44h9V1nkTrgw/vwY8fGaKz5GVjkdcA5mEuMRCDVIEVKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fWFh4yvd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fWFh4yvd"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65PFmNuA486681;
	Thu, 25 Jun 2026 18:05:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NTtn2o
	f1Q6ma3TxAy13nPjm3yLYMAfh7v1DXbybPSbk=; b=fWFh4yvd/u8hIaBNGLoXzX
	+C1eDPfwE93STT6yB8EewSkDYHuqIKcKaFcPNyXJMVRVF7u4Jqsiabw/UXBE6/ZH
	RLn1LPwG+8qtqNgrOGect9bly8bKRILKmpSFoylA/WgTU5GDpVl4GU2QaOvW5K6O
	hKx8ULRRKnyIk/vSktVWR9sw2MVmXva8A0FgPRwxhIYG4gPSpYn0V4LVQZ1AQMJh
	AAZNEI5iiLdcJ2A1zDeUK6g97GBVhGSRkIPunHAdZ3z3R+R91bu7FkuQra3X1CKP
	0qH3W724CP+t1YFGQ4cOcfVJ6HuPB50q8zU2+Ml8p+8qa2Ek6BN1+XARf9J7ZPmg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3ubw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 18:05:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65PI4gEd028990;
	Thu, 25 Jun 2026 18:05:04 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6phqcu0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 18:05:03 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65PI534N19268244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jun 2026 18:05:03 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E058A58066;
	Thu, 25 Jun 2026 18:05:02 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3411558059;
	Thu, 25 Jun 2026 18:04:59 +0000 (GMT)
Received: from [9.124.220.252] (unknown [9.124.220.252])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Jun 2026 18:04:58 +0000 (GMT)
Message-ID: <e7bec79c-09fc-41aa-973c-0af89362f860@linux.ibm.com>
Date: Thu, 25 Jun 2026 23:34:57 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] perf/trace-dat: Add trace.dat export
 infrastructure
To: sashiko-reviews@lists.linux.dev,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, namhyung@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc: linux-perf-users@vger.kernel.org
References: <20260608125951.90425-3-tshah@linux.ibm.com>
 <20260608131352.BA2831F00893@smtp.kernel.org>
Content-Language: en-US
From: Tanushree Shah <tshah@linux.ibm.com>
In-Reply-To: <20260608131352.BA2831F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a3d6dd1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=cYM135ekG8_zCDq0hgIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDE1MyBTYWx0ZWRfXyONu3ijbS8Gw
 6+c551tly3ThXdy0gkgy/zzyldgVQoLGD2Z7lMAhBSBBuMctgQF1hXwAn2aNkdDkODRhxIQIZUs
 ifGmpyL8CjTwjuzJ4qVXOMh0GqH0wX0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDE1MyBTYWx0ZWRfX8HN6/L8h4z4w
 0ebDoQusOtKNhSjxG69Ro0+gclWw1/QFvqE0XY/rOYripAk98Y18tQBkjaTQVz3ww04kOHES5Gl
 6bD+bmnVSRH9uadN4KAf3VkD8IXFm/GSw8vZ6GiqOyLZNV8xQHqDD5dgyJZ8EF3VNoyKjkuOIeT
 eYW8hjLV9InyFZ0SDH0qcON0RKGy7/iIXMZcsx46371doxsX24xWwF5hYLmxlz9Upj65qX7bDtI
 jJeaLfZyRvcxllyT/j5wVWoFbS2DXn0ErCJpzqG1O8WoWcfkHu9GYv4KXSNYU00cXQgIkHnkchl
 Fznnk7NwLBVPPlhMyO6w4i4VnydXGISH3Jh9Me1+40rFRkBlEfrbWGBT0/IsxeIKEb/IwX0YVkk
 aCis2C0woOG7bv4aCqtSc0Q0/sg90bOuIYepJxaMQPC1kv3zQPnhAJvmr+eQM9HIsBTQLSzx5P9
 xWscgQEyrBu4gTkWd3A==
X-Proofpoint-ORIG-GUID: bh_K2se38b90dV06dsTL4Rn1f864LkoS
X-Proofpoint-GUID: lkKRHvDqkbLd2yX-rDBAnroq7PXSeY9f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250153

Thank you for the detailed review. I have investigated all identified 
issues and confirmed them. All will be addressed in v2.

On 08/06/26 18:43, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 10 potential issue(s) to consider:
> - [High] Sequential realloc failures cause a use-after-free, double-free, and memory leak.
> - [High] Unchecked realloc overwrite leads to array leak and a later NULL pointer dereference.
> - [High] Unchecked calloc failure leads to NULL pointer dereference in fwrite.
> - [High] Heap buffer overflow when processing abnormally large trace records.
> - [High] Unchecked get_tracing_file failure leads to NULL pointer dereference in fopen.
> - [High] Ftrace ring buffer format is incorrectly constructed for events >= 28 words, causing data corruption.
> - [High] Timestamp deltas larger than 27 bits are silently truncated
> - [Medium] Direct return on record allocation failure bypasses cleanup, leaking accumulated memory.
> - [Medium] The section_size for the flyrecord section is incorrectly calculated, violating the trace.dat format.
> - [Medium] The current event record is leaked if flushing the page or reallocating the batch array fails.
> --
> 
> commit b7f763e536c02304fb52bceb9c78dd92220fa81a
> Author: Tanushree Shah <tshah@linux.ibm.com>
> 
> perf/trace-dat: Add trace.dat export infrastructure
> 
> Add new utility files util/trace-dat.c and util/trace-dat.h
> implementing the infrastructure for exporting perf.data tracepoints
> to trace.dat format compatible with trace-cmd and KernelShark.
> 
>> diff --git a/tools/perf/util/trace-dat.c b/tools/perf/util/trace-dat.c
>> index 0000000000000..aa34a7b89b7a3
>> --- /dev/null
>> +++ b/tools/perf/util/trace-dat.c
> [ ... ]
>> +int trace_dat__collect_cpu_event(int cpu, unsigned long long ts,
>> +				 void *raw, unsigned int raw_size)
>> +{
> [ ... ]
>> +	if (cpu_events->count >= cpu_events->capacity) {
>> +		cpu_events->capacity = cpu_events->capacity ?
>> +				       cpu_events->capacity * 2 : INITIAL_EVENT_CAPACITY;
>> +		cpu_events->events   = realloc(cpu_events->events,
>> +				       cpu_events->capacity * sizeof(*cpu_events->events));
>> +		if (!cpu_events->events)
>> +			return -ENOMEM;
> 
> [Severity: High]
> If realloc fails, it returns NULL and overwrites cpu_events->events, leaking
> the original memory block. Later, trace_dat__free_cpu_buffers() iterates over
> the events and dereferences trace_cpu_data[cpu].events[i].raw. Can this cause
> a segmentation fault during cleanup since events is NULL?
Reproduced with fault injection. Direct assignment causes pointer loss 
on failure, leading to use-after-free in cleanup. Will use temporary 
pointer pattern.
> 
>> +	}
> [ ... ]
>> +static int trace_dat__write_page(FILE *fp, unsigned long long base_ts,
>> +			char **records, int *rec_sizes, int nr_recs)
>> +{
> [ ... ]
>> +	page = calloc(1, trace_dat_page_size);
>> +	if (!page)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < nr_recs; i++) {
>> +		memcpy(page + offset, records[i], rec_sizes[i]);
> 
> [Severity: High]
> When a trace event's size exceeds trace_dat_page_size - 16 bytes, the
> oversized event is queued into a new batch. Does this memcpy copy data past
> the end of the page allocation, causing a heap buffer overflow?
> 
Records larger than page payload can overflow buffer. Will reject 
oversized records before batching, matching upstream ftrace behavior.
>> +		offset += rec_sizes[i];
>> +		commit += rec_sizes[i];
>> +	}
> [ ... ]
>> +static int trace_dat__write_cpu_dat(FILE *fp, int cpu, unsigned long long *file_offset_out)
>> +{
> [ ... ]
>> +	for (i = 0; i < cpu_events->count; i++) {
>> +		struct cpu_event *event = &cpu_events->events[i];
>> +		unsigned long long time_delta = event->ts - base_ts;
>> +		unsigned int data_len = event->raw_size;
>> +		unsigned int words = (data_len + TRACE_DAT_WORD_ALIGN_MASK) / TRACE_DAT_WORD_SIZE;
>> +		unsigned int type_len = words & TRACE_DAT_RECORD_TYPE_LEN_MASK;
>> +		unsigned int hdr_word = ((time_delta & TRACE_DAT_RECORD_TIME_MASK) <<
>> +					TRACE_DAT_RECORD_TIME_SHIFT) | type_len;
> 
> [Severity: High]
> If the gap between events on a CPU exceeds 0x07FFFFFF, the ftrace
> specification requires emitting a TIME_EXTEND or TIME_STAMP record to advance
> base_ts. Does masking off the upper bits via time_delta &
> TRACE_DAT_RECORD_TIME_MASK silently truncate the timestamp and corrupt the
> chronological ordering?
Deltas >27 bits are silently masked. Will emit TIME_EXTEND records for 
large gaps, matching ftrace ring buffer semantics.
> 
> [Severity: High]
> The ftrace ring buffer specification uses the 5-bit type_len field to encode
> lengths up to 27 words. For 28 words or more, type_len must be 0, and the
> actual length must be written as a 32-bit word immediately following the
> header. Does applying words & 0x1F map large events into special types (like
> PADDING for 29) or to type_len = 0 without appending the required 32-bit
> length word?

Events ≥28 words incorrectly map to reserved types (29=PADDING, 
30=TIME_EXTEND, 31=TIME_STAMP). Will implement proper encoding with 
type_len=0 and separate length word for large events.
> 
>> +		int rec_size;
>> +		char *rec;
>> +
>> +		rec_size = TRACE_DAT_WORD_SIZE + data_len;
>> +		if (rec_size % TRACE_DAT_WORD_SIZE)
>> +			rec_size += TRACE_DAT_WORD_SIZE - (rec_size % TRACE_DAT_WORD_SIZE);
>> +
>> +		rec = calloc(1, rec_size);
>> +		if (!rec)
>> +			return -ENOMEM;
> 
> [Severity: Medium]
> If calloc fails, this directly returns -ENOMEM. Does this bypass the out_free
> cleanup label entirely, leaking the page_records and page_rec_sizes tracking
> arrays and any previously allocated record strings?
Failed calloc returns directly, leaking page_records arrays. Will use 
proper error path with goto.
> 
>> +		memcpy(rec, &hdr_word, TRACE_DAT_WORD_SIZE);
>> +		memcpy(rec + TRACE_DAT_WORD_SIZE, event->raw, data_len);
>> +
>> +		if (page_size_used + rec_size > trace_dat_page_size -
>> +		    TRACE_DAT_RECORD_HEADER_SIZE) {
>> +			ret = trace_dat__write_page(fp, base_ts,
>> +			      page_records, page_rec_sizes, nr_page_recs);
>> +			for (j = 0; j < nr_page_recs; j++)
>> +				free(page_records[j]);
>> +			nr_page_recs = 0;
>> +			page_size_used = 0;
>> +			base_ts = event->ts;
>> +			if (ret < 0)
>> +				goto out_free;
> 
> [Severity: Medium]
> If trace_dat__write_page fails and we jump to out_free, the newly allocated
> rec has not yet been appended to the page_records array. Is this memory
> permanently leaked since it is skipped by the cleanup loop?
> 
Newly allocated rec not yet in page_records when flush fails. Will check 
page fit before allocating record.
>> +		}
>> +
>> +		if (nr_page_recs >= page_cap) {
>> +			char **tmp_records;
>> +			int *tmp_sizes;
>> +
>> +			page_cap = page_cap ? page_cap * 2 : INITIAL_PAGE_RECORD_CAPACITY;
>> +			tmp_records = realloc(page_records, page_cap * sizeof(char *));
>> +			tmp_sizes = realloc(page_rec_sizes, page_cap * sizeof(int));
>> +			if (!tmp_records || !tmp_sizes) {
>> +				ret = -ENOMEM;
>> +				goto out_free;
> 
> [Severity: High]
> If realloc for tmp_sizes fails, the code jumps to out_free without updating
> page_records to point to the newly allocated block in tmp_records. Does the
> cleanup path then iterate over the potentially freed page_records pointer,
> dereference it (use-after-free), and then call free(page_records) again
> (double-free)?
Partial realloc failure can cause use-after-free and double-free. Will 
replace with malloc/memcpy/free pattern.
> 
>> +			}
> [ ... ]
>> +int trace_dat__write_options_section1(void)
>> +{
> [ ... ]
>> +	/* TRACECLOCK option */
>> +	opt_id = TRACE_DAT_OPTION_TRACECLOCK;
>> +
>> +	path = get_tracing_file("trace_clock");
>> +	clock_file = fopen(path, "r");
> 
> [Severity: High]
> The get_tracing_file function internally uses asprintf and can return NULL on
> memory allocation failure. Is it possible for fopen to receive a NULL path,
> leading to a segmentation fault?
> 
Can return NULL on asprintf failure. Passing NULL to fopen() causes 
segmentation fault. Will add NULL check before fopen().
>> +	put_tracing_file(path);
> [ ... ]
>> +int trace_dat__write_flyrecord_section(void)
>> +{
> [ ... ]
>> +	/* Align to page boundary */
>> +	after_header   = ftell(trace_dat_fp);
>> +	padding_needed = (trace_dat_page_size -
>> +			 (after_header % trace_dat_page_size)) % trace_dat_page_size;
>> +
>> +	if (padding_needed > 0) {
>> +		pad = calloc(1, padding_needed);
>> +
>> +		if (!fwrite(pad, 1, padding_needed, trace_dat_fp)) {
> 
> [Severity: High]
> Is pad passed directly to fwrite without checking if calloc succeeded? Can
> this lead to a segmentation fault if the allocation fails and fwrite receives
> a NULL buffer?
NULL pad can be passed to fwrite() causing segmentation fault. Will add 
explicit NULL check.
> 
>> +			free(pad);
>> +			ret = -EIO;
>> +			goto cleanup;
>> +		}
>> +		free(pad);
>> +	}
> [ ... ]
>> +	/* fill section size */
>> +	end_pos = ftell(trace_dat_fp);
>> +
>> +	section_size = end_pos - flyrecord_start;
> 
> [Severity: Medium]
> In the trace.dat specification, the section_size field must indicate the size
> of the payload following the 16-byte section header. By capturing
> flyrecord_start before the header is written, does the final section_size
> erroneously include the 16 bytes of the header itself, causing parsing tools
> to miscalculate the boundary?
> 
>> +	if (fseek(trace_dat_fp, section_size_pos, SEEK_SET) < 0 ||
>> +	    !fwrite(&section_size, sizeof(unsigned long long), 1, trace_dat_fp)) {
>> +		ret = -EIO;
>> +		goto cleanup;
>> +	}
> 
Verified by comparing with trace-cmd. trace-cmd excludes the header in 
the section size. Will fix by capturing position after writing header.
