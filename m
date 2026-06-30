Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A0F3DC4B6;
	Tue, 30 Jun 2026 18:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782843194; cv=none; b=CEHWtyP/VkyLB0xvFkWsKNIbgCVOwJcyLxwbt/MwJY7OE+SyBpDmL1rI0NnBhf6nr+Zv790ooow1EgHOELJV0lxKFFgvx0unwnEgiknSh1NyHLEhYEmd6NKaMhrgAOvSQ2MKodWdx6wPQT0/B5LCymQRBjT5LpMb1c6ZsL8IbsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782843194; c=relaxed/simple;
	bh=7OA9qQCD9Fb/NIRvV7AfcgUKf4UMXY/C/7up7kPyIZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G50pFWkYkaLJU/Mh4abcAyEEOk1dzw6iGwF1Ly/ZX/A2wdxF3tzD99zM+eK9OH0RH0VVvJCAVhY+4BiVvgDzzgTuSn8Qjet1HEiH1RW0S5PssaR3ktn3Jd9ZtBmMrP8Y4e6TcJXnX0JwAQFQsI+uSsT+oaIktUCEtMEQYFTQD88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lPcVUTls; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lPcVUTls"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEIhq12171275;
	Tue, 30 Jun 2026 18:13:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tB3r6v
	2e8RQJRl6khIbvkVRys1TAeMlqzh2UUBd/o0M=; b=lPcVUTlskNw0iix3B/8dwn
	vXJlh+1hkZSUJ2Pnz0ybJcpAT9jMUoDkeptALSNHH09+3V/IOE1ccNjqMPpTWlnG
	djZfVdhC7739EkHlOwEeh9o4lgSEitafH1qhuN8HHmnl9rmx6YCM4YeNqOdDM3fE
	rWDdqU1Y2lmTUky/Q64i4YImKSEzvHe5EOs7NLWxTw0mQQkQtQOXmUXvTKcCyFp/
	Qm1c8LccErOJ6DXXkQxJaa92LScuH2wfsK0PPADx1KFcuVTmQakYMZvzTU/74IFM
	D4zM0zI9SDrnXkIZkS9fFsjs4V2xlMDoeyWP/LSE7vaCq3mvrr9EyDD6aG/3LpFQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rf049s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 18:13:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UI4eio025946;
	Tue, 30 Jun 2026 18:13:06 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7w3qw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 18:13:06 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UID6iW32309838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 18:13:06 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C3475805B;
	Tue, 30 Jun 2026 18:13:06 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7042958058;
	Tue, 30 Jun 2026 18:13:03 +0000 (GMT)
Received: from [9.124.210.124] (unknown [9.124.210.124])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 18:13:03 +0000 (GMT)
Message-ID: <845b78ec-2385-4bb4-9ce1-900c266d2941@linux.ibm.com>
Date: Tue, 30 Jun 2026 23:42:51 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] perf/trace-event: Write trace.dat metadata
 sections during parsing
To: sashiko-reviews@lists.linux.dev, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-perf-users@vger.kernel.org
References: <20260608125951.90425-4-tshah@linux.ibm.com>
 <20260608131224.B448A1F00898@smtp.kernel.org>
Content-Language: en-US
From: Tanushree Shah <tshah@linux.ibm.com>
In-Reply-To: <20260608131224.B448A1F00898@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a440733 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=NuLJOUEpmZb_zQThiekA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: TvoFxI_l1-yB514Tj3KMeMmu5qmFRam8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE3MCBTYWx0ZWRfX0bX/IQFz6Dy8
 PVC5ZzvvbSQijpfDTTHX/8gaA3UfFhl/3T/fOzIqyOHEVmTmO7raR9dVvkCTy3HCJIZmy/8jpfK
 1HBK0wOT46spXc91Z9wfBasQ+4yQRVaqYG6Q64ql7mEdWClx7wy4kkyyL7OuwnPTmArbHssDH2a
 OHN5Dbyk/5gVZo+OScs00vAZs4i9ZUg+0z3V9/P2HH1bVwOQxuIMqz6c6r9YOr+zNsbkOt4cAyo
 7gNAhXGY4Rl+WUfKVYIJTu7dmBA8RCmbUo5FSXveYZWEDUFOy7Xoc9z2UGQkZY7eUCZ6jJoQAG3
 EuyvNDYxiEWP/I5OLLAVdYbzILG+w6QxggH1hpBaUG62GKCcAm3Zery62Cbr5WVqQ1gAJSFtv7r
 1BwJPvvKjQPM2IyYpKAV3QvFEIghNboGfqgoFqPa4F3ib3/A3zcrgVZWJ5Qxx9U2AAukonnsLtb
 0I+1I82EjE2PiOmvqnA==
X-Proofpoint-GUID: 2x-e9VbJrg4KLyhfFZDmnMF-Fobu4pHX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE3MCBTYWx0ZWRfX5o4VU5NGc3bB
 7RpUM6px/WtzkZS+PIvKllhj95gW1lUeFNpfBLAe0wF4y/Clc1LjIm+DdZJa3p0UZt+Of3nqCp+
 CZReZR+gAUCiD0RtH9y6knptgg0iTTs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300170

Thanks for the detailed review. I have verified the issues and will be 
fixing it in v2.


On 08/06/26 18:42, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential issue(s) to consider:
> 
> New issues:
> - [High] Using `read()` directly instead of the subsystem's `do_read()` loop fails to handle short reads, causing stream desynchronization and uninitialized memory writes.
> - [High] Integer truncation in `do_read()` causes massive uninitialized heap memory dumps to the output file.
> - [Medium] Metadata fields and integers for the `trace.dat` file are written in the host's native byte order, causing cross-platform incompatibility.
> - [Medium] Error paths in `fwrite` operations return directly without cleaning up allocated resources, leading to memory and state leaks.
> - [Medium] Writing 2 bytes from a 1-byte `char` variable causes a stack out-of-bounds read and file corruption.
> 
> Pre-existing issues:
> - [High] Unbounded string accumulation in `read_string()` causes a stack buffer overflow.
> --
> 
> commit f1360b22eb92ea64822af70555a808fd9d67ae93
> Author: Tanushree Shah <tshah@linux.ibm.com>
> Date:   Mon Jun 8 12:59:50 2026 +0000
> 
>      perf/trace-event: Write trace.dat metadata sections during parsing
>      
>      Perf already captures the tracing metadata as a part of
>      data section in perf.data
>      
>      When trace_dat_fp is set, write trace.dat compatible metadata
>      sections using the perf provided raw buffers.
>      
>      Sections written:
>      - Initial format header (magic, version, endian, long_size,
>        page_size, compression, options_offset placeholder)
>      - Section 16: HEADER INFO (header_page + header_event)
>      - Section 17: FTRACE EVENT FORMATS
>      - Section 18: EVENT FORMATS (per system/event format files)
>      - Section 19: KALLSYMS
>      - Section 21: CMDLINES
>      - Section 15: STRINGS (written last after all sections)
>      
>      Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
> 
> This commit updates the trace-event parsing in perf to write trace.dat
> compatible metadata sections when trace_dat_fp is set. It outputs sections
> such as initial format headers, FTRACE EVENT FORMATS, EVENT FORMATS,
> KALLSYMS, and CMDLINES using perf's raw buffers.
> 
>> diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
>> index ecbbb93f01853..815577703c2e5 100644
>> --- a/tools/perf/util/trace-event-read.c
>> +++ b/tools/perf/util/trace-event-read.c
> 
> [ ... ]
> 
>> @@ -145,10 +146,9 @@ static char *read_string(void)
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does read_string() allow a
> stack buffer overflow when accumulating characters?
> 
> In read_string():
>      buf[size++] = c;
> 
> If the input file contains a string longer than BUFSIZ without a null
> terminator, will this increment the size index and write past the bounds
> of the fixed-size array buf?
> 
Since, its a pre-existing issue and is unrelated to this feature 
addition, will fix it in a separate patch.
>>   static int read_proc_kallsyms(struct tep_handle *pevent)
>>   {
>>   	unsigned int size;
>> +	char *buf;
>>   
>>   	size = read4(pevent);
>> -	if (!size)
>> -		return 0;
> 
> [ ... ]
> 
>> +	buf = malloc(size);
>> +	if (buf == NULL)
>> +		return -1;
>> +	if (read(input_fd, buf, size) < 0) {
>> +		free(buf);
>> +		return -1;
>> +	}
>>   	trace_data_size += size;
>> +	/* Write kallsyms section with data */
>> +	if (trace_dat_fp) {
>> +		unsigned short section_id = TRACE_DAT_SECTION_KALLSYMS;
>> +		unsigned int string_id = STRID_KALLSYMS;
>> +		unsigned long long section_size = sizeof(unsigned int) + size;
>> +		unsigned short flags = 0;
>> +
>> +		trace_dat_kallsyms_offset = ftell(trace_dat_fp);
>> +		if (!fwrite(&section_id, sizeof(unsigned short), 1, trace_dat_fp) ||
>> +		    !fwrite(&flags, sizeof(unsigned short), 1, trace_dat_fp) ||
>> +		    !fwrite(&string_id, sizeof(unsigned int), 1, trace_dat_fp) ||
>> +		    !fwrite(&section_size, sizeof(unsigned long long), 1, trace_dat_fp) ||
>> +		    !fwrite(&size, sizeof(unsigned int), 1, trace_dat_fp) ||
>> +		    !fwrite(buf, 1, size, trace_dat_fp)) {
> 
> [Severity: High]
> Could using read() instead of do_read() here cause uninitialized memory to
> be written to the output file?
> 
> Unlike do_read(), read() can return a short read. If a short read occurs, the
> return value might still be greater than 0, bypassing the error check.
> 
> Will this leave the remainder of buf uninitialized, failing to advance the
> input_fd offset by the expected amount, and then dump the partially
> uninitialized heap memory into trace_dat_fp during the fwrite() call?
yes, will replace read() with do_read().
> 
>> +			free(buf);
>> +			return -EIO;
>> +		}
>> +	}
>> +	free(buf);
>>   	return 0;
>>   }
> 
> [ ... ]
> 
>> @@ -209,6 +261,7 @@ static int read_header_files(struct tep_handle *pevent)
>>   
>>   	size = read8(pevent);
>>   
>> +	header_page_size = size;
>>   	header_page = malloc(size);
>>   	if (header_page == NULL)
>>   		return -1;
>> @@ -227,19 +280,59 @@ static int read_header_files(struct tep_handle *pevent)
>>   		 */
>>   		tep_set_long_size(pevent, tep_get_header_page_size(pevent));
>>   	}
>> -	free(header_page);
>>   
>> -	if (do_read(buf, 13) < 0)
>> +	if (do_read(buf, 13) < 0) {
>> +		free(header_page);
>>   		return -1;
>> +	}
> 
> [Severity: High]
> Can integer truncation in do_read() lead to massive uninitialized heap memory
> dumps here?
> 
> Functions like read_header_files() allocate memory using the 64-bit size read
> from the file:
> 
>      size = read8(pevent);
>      header_page = malloc(size);
> 
> They then call do_read(header_page, size). Because do_read() takes an int
> for the size argument, values over 4GB are truncated to their lower 32 bits.
> If size is 0x100000004, do_read() will only read 4 bytes.
> 
> Later in the function, fwrite() is called with the full 64-bit size:
> 
>      !fwrite(header_page, 1, header_page_size, trace_dat_fp)
> 
> Will this result in dumping 4GB of uninitialized heap memory into the
> output file?
Confirmed.  do_read() takes int, truncates 64-bit sizes. Would need to 
change parameter type from int to size_t.
> 
> [ ... ]
> 
>> @@ -298,8 +405,31 @@ static int read_ftrace_files(struct tep_handle *pevent)
>>   	int count;
>>   	int i;
>>   	int ret;
>> +	long section_size_pos = 0;
>> +	long count_pos = 0;
>> +	unsigned long long section_size = 0;
>> +	long end_pos;
>>   
>>   	count = read4(pevent);
>> +	/* Write ftrace formats section to trace.dat output file */
>> +	if (trace_dat_fp) {
>> +		unsigned short section_id = TRACE_DAT_SECTION_FTRACE;
>> +		unsigned short flags = 0;
>> +		unsigned int string_id = STRID_FTRACE_FORMATS;
>> +
>> +		trace_dat_ftrace_format_offset = ftell(trace_dat_fp);
>> +
>> +		if (!fwrite(&section_id, sizeof(unsigned short), 1, trace_dat_fp) ||
>> +		    !fwrite(&flags, sizeof(unsigned short), 1, trace_dat_fp) ||
>> +		    !fwrite(&string_id, sizeof(unsigned int), 1, trace_dat_fp))
> 
> [Severity: Medium]
> Should these multi-byte integers be byte-swapped to match the output file's
> endianness?
> 
> The trace.dat file endianness is explicitly declared to match the original
> perf.data file (endian = file_bigendian).
> 
> However, variables like section_id, flags, and string_id are written using
> fwrite(), which writes them in the host's native byte order. If a
> little-endian host is processing a big-endian capture file, won't this corrupt
> the section IDs and sizes in the resulting trace.dat file?
> 
>> +			return -EIO;
>> +		section_size_pos = ftell(trace_dat_fp);
>> +		if (!fwrite(&section_size, sizeof(unsigned long long), 1, trace_dat_fp))
>> +			return -EIO;
>> +		count_pos = ftell(trace_dat_fp);
>> +		if (!fwrite(&count, sizeof(unsigned int), 1, trace_dat_fp))
>> +			return -EIO;
>> +	}
> 
> [ ... ]
> 
>> @@ -363,6 +557,23 @@ static int read_saved_cmdline(struct tep_handle *pevent)
>>   		pr_debug("error reading saved cmdlines\n");
>>   		goto out;
>>   	}
>> +	/* Write cmdlines section with data */
>> +	if (trace_dat_fp) {
>> +		unsigned short section_id = TRACE_DAT_SECTION_CMDLINE;
>> +		unsigned short flags = 0;
>> +		unsigned int string_id = STRID_CMDLINES;
>> +		unsigned long long section_size = sizeof(unsigned long long) + size;
>> +
>> +		trace_dat_cmdline_offset = ftell(trace_dat_fp);
>> +		if (!fwrite(&section_id, sizeof(unsigned short), 1, trace_dat_fp) ||
>> +		    !fwrite(&flags, sizeof(unsigned short), 1, trace_dat_fp) ||
>> +		    !fwrite(&string_id, sizeof(unsigned int), 1, trace_dat_fp) ||
>> +		    !fwrite(&section_size, sizeof(unsigned long long), 1, trace_dat_fp) ||
>> +		    !fwrite(&size, sizeof(unsigned long long), 1, trace_dat_fp) ||
>> +		    !fwrite(buf, 1, size, trace_dat_fp))
>> +			return -EIO;
> 
> [Severity: Medium]
> Does returning directly bypass the cleanup block?
> 
> If fwrite() fails, this error path returns -EIO immediately instead of using
> the "goto out" pattern established in this function.
> 
> Will this cause the allocated memory in buf to be leaked, since free(buf)
> is skipped?

On fwrite error, close trace_dat_fp and set it to NULL to disable 
further trace.dat writes, then continue normal parsing instead of 
returning early, this ensures cleanup code runs and primary parsing 
continues further.
> 
>> +	}
>> +
>>   	buf[ret] = '\0';
>>   
>>   	parse_saved_cmdline(pevent, buf, size);
> 
> [ ... ]
> 
>> @@ -440,6 +657,28 @@ ssize_t trace_report(int fd, struct trace_event *tevent, bool __repipe)
>>   	tep_set_long_size(pevent, file_long_size);
>>   	tep_set_page_size(pevent, file_page_size);
>>   
>> +	/* Write initial file header to trace.dat */
>> +	if (trace_dat_fp) {
>> +		unsigned char endian = file_bigendian;
>> +		unsigned char long_size = file_long_size;
>> +		unsigned int page_size = file_page_size;
>> +		unsigned long long placeholder = 0;
>> +		char trace_dat_version = TRACE_DAT_VERSION;
>> +
>> +		if (!fwrite(magic_buf, 1, 10, trace_dat_fp) ||    /* magic + "tracing" */
>> +		    !fwrite(&trace_dat_version, 1, 2, trace_dat_fp) ||
> 
> [Severity: Medium]
> Can this write out-of-bounds stack memory to the output file?
> 
> The variable trace_dat_version is declared as a 1-byte char:
> 
>      char trace_dat_version = TRACE_DAT_VERSION;
> 
> However, the fwrite call asks to write 2 bytes:
> 
>      !fwrite(&trace_dat_version, 1, 2, trace_dat_fp)
> 
> Will this read 1 byte past the trace_dat_version variable on the stack,
> leaking uninitialized stack memory into the output file and potentially
> failing to write the expected null terminator for the version string?

Confirmed. Writes 2 bytes from 1-byte char. Fix: Allocate 2-byte array 
for version string with null terminator.


> 
>> +		    !fwrite(&endian, 1, 1, trace_dat_fp) ||
>> +		    !fwrite(&long_size, 1, 1, trace_dat_fp) ||
>> +		    !fwrite(&page_size, sizeof(unsigned int), 1, trace_dat_fp) ||
>> +		    !fwrite("none", 1, 4, trace_dat_fp) ||
>> +		    !fwrite("\0", 1, 1, trace_dat_fp) ||
>> +		    !fwrite("\0", 1, 1, trace_dat_fp))
>> +			return -EIO;
>> +		trace_dat_options_offset = ftell(trace_dat_fp);
>> +		if (!fwrite(&placeholder, sizeof(unsigned long long), 1, trace_dat_fp))
>> +			return -EIO;
>> +	}
>> +
>>   	err = read_header_files(pevent);
>>   	if (err)
>>   		goto out;
> 



