Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5124B3E024B;
	Thu,  4 Jun 2026 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780589436; cv=none; b=l0RQynu2WLBhpYd15HIriEXPjC/4ytTOm4WcM9Z7QgHWpF38Na3D0OcGpE6MJN48eX3fKenBJI5Ju84PfHcyzvQfXzMSknaZkZHUQRzHWIVbsnAyJryDPX+j6XqFBQJiELN0jsU27nuEN9qwiq4Gz5/eIFOGPEDmUTymxro3A64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780589436; c=relaxed/simple;
	bh=TUqRFn5UPGPEfnUHQUX3oPGvQnVixdaGssAULGSCR70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P7QGVnYjY7/sr//y6hhpN4Z94vJMoyPjJePjC9WRGJpPNPXRKFG8l+ipDfnDPwfTJg0U+Z1AZpsxm6JMMOxD5lhH6jIsKbycHYx0bSIqnUzJ/s/q+v4n2m9L8/2tDE/Wy7vlO808aaG8qev1Hm/tPV39rqTt9anL0JJiRXMXiCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aqZ98haz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aqZ98haz"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6548EWlU2497718;
	Thu, 4 Jun 2026 16:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zkN0Kn
	b7oNZUOF+D+DaNSoI5kwYaOUixImOB7tzfPeg=; b=aqZ98haz5gGg9A45SkJOiU
	+QjGFIiWZrJuJMJGq09ymAC9zZ2xOCQdt6m3k+mLhCzks5JWTyYEiMg+JGw2aoSF
	ce4EgdUU4k9rVUKeeuOg0HmYaaOlCJZYSh7tqlcWfQlyPe4Dlv7hsSTf0eISenSF
	SPxpkBtSLZNfRWS+agzxNsTMG5Bcdp8f4W4HDdCCaZAqMaBnBgcS0EcncuJmKRUU
	RJ9tSOeD0tVvSMHFGvPmHCauvuxoUg69YUkfa3xHmJMpWzMYHHAu6q1lDhmwNWJa
	LfpcguCDKRzUs3SWRfwcpdl2RHvZkumozAQMTDrWGf6fYCZpu8/BJyrnEnS7xHvg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqm58m61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 16:10:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 654Fs5qh013227;
	Thu, 4 Jun 2026 16:10:33 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakw5wc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 16:10:33 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 654GAWnE23593478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jun 2026 16:10:32 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0A2F58055;
	Thu,  4 Jun 2026 16:10:32 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A071F5804B;
	Thu,  4 Jun 2026 16:10:31 +0000 (GMT)
Received: from [9.124.208.23] (unknown [9.124.208.23])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Jun 2026 16:10:31 +0000 (GMT)
Message-ID: <69f07855-6e7d-4c8e-9557-13bc4d845878@linux.ibm.com>
Date: Thu, 4 Jun 2026 21:40:29 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf data convert json: Fix trace_seq memory leak in
 process_sample_event()
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260604065519.112101-1-tshah@linux.ibm.com>
 <20260604070617.0050E1F00893@smtp.kernel.org>
Content-Language: en-US
From: Tanushree Shah <tshah@linux.ibm.com>
In-Reply-To: <20260604070617.0050E1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6QH0fgRSNxdFek7-QJHUKCBLCtlmA3_J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE1NyBTYWx0ZWRfX3BZxBZPaA3k1
 OG0jZFFPtwfPj2fYQBQ42cH7HqeHVs1xO2SCTOV792bdDxcvznai2apXcH7Yvsyllm37QVyYr53
 rxvrdXDcBT3/RytKlJi7PZIv+sL3+QLhxn84u2xT4nF7Tr4YmQkPSIiV80MOB0ggbKmiw0Rq2y2
 JeX7i50dbXuOKJSkgls/4qGowdKe4dsKT34A3mM6luNg3LmeozrLPkzQDhVDlR0ZU45OlfNlxAH
 EqB8LI0kexPOamT/+raEoOpRhv89njSukxJfeoVz+pDeAK/fjobap4SjmCAtwpDECmKsk/vsupa
 Qc60yPhouzsfBslnd/guC/6eTviAq4p6CAR32xTbpJeWmkR/2g7sURWOzVUKzJ8vKXedN/tGmFO
 jVVK9/hpTiaMJvL4TEczrirDoxBf7ioUneNIHlRv39LeURRlsH72SwQdHCU6xSTTw4cjbtcrpOf
 QJ7h9M0xqndbOwjqZAg==
X-Proofpoint-ORIG-GUID: 6QH0fgRSNxdFek7-QJHUKCBLCtlmA3_J
X-Authority-Analysis: v=2.4 cv=Vf3H+lp9 c=1 sm=1 tr=0 ts=6a21a37a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=1-rSC9nhN4gWdckfc50A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040157

Hi Sashiko,

Thank you for the review and for spotting this!

Regarding the addr_location reference leak:

yes its correct. The early return path for time-filtered samples does 
leak addr_location references.

When machine__resolve() succeeds, it calls thread__find_map(), which 
acquires reference counts for thread, map, and maps objects and stores 
them in the addr_location structure. The early return bypasses 
addr_location__exit(), preventing these references from being released.

Validation with Valgrind:

I've validated the issue with Valgrind using a test case with 2,385 
total samples (150 converted, 2,235 skipped by time filter):

Without the fix:

definitely lost:  8,336 bytes in 32 blocks
indirectly lost:  1,539,361 bytes in 21,307 blocks
possibly lost:    10,325,465 bytes in 146,283 blocks
Total leaked:     ~11.9 MB

With the fix:

definitely lost:  0 bytes in 0 blocks
indirectly lost:  0 bytes in 0 blocks
possibly lost:    0 bytes in 0 blocks
Total leaked:     0 bytes


I will send a v2 patch series that addresses both memory leaks:

The trace_seq_destroy() fix (original issue)
The addr_location__exit() fix for the early return path

Thanks
Tanushree Shah

On 04/06/26 12:36, sashiko-bot@kernel.org wrote:
> perf data convert json: Fix trace_seq memory leak in process_sample_event()
> 
> This commit fixes a memory leak by ensuring trace_seq_destroy() is called
> to pair with trace_seq_init() when formatting tracepoint raw data.
> 
>> diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
>> index d526c91312ed8..6dd9349ab10f1 100644
>> --- a/tools/perf/util/data-convert-json.c
>> +++ b/tools/perf/util/data-convert-json.c
>> @@ -257,6 +257,7 @@ static int process_sample_event(const struct perf_tool *tool,
>>   				trace_seq_init(&s);
>>   				tep_print_field(&s, sample->raw_data, fields[i]);
>>   				output_json_key_string(out, true, 3, fields[i]->name, s.buffer);
>> +				trace_seq_destroy(&s);
>>   
>>   				i++;
>>   			}
> [Severity: High]
> This is a pre-existing issue, but does the early return path for skipped
> samples higher up in process_sample_event() leak the addr_location
> reference handles?
> 
> tools/perf/util/data-convert-json.c:process_sample_event() {
>          addr_location__init(&al);
>          if (machine__resolve(machine, &al, sample) < 0) {
>                  pr_err("Sample resolution failed!\n");
>                  addr_location__exit(&al);
>                  return -1;
>          }
> 
>          if (perf_time__ranges_skip_sample(c->ptime_range, c->range_num, sample->time)) {
>                  ++c->skipped;
>                  return 0;
>          }
>          ...
> }
> 
> When machine__resolve() populates the addr_location structure, it acquires
> reference handles for objects like thread and map. The early return for time
> filtering bypasses the addr_location__exit() cleanup.
> 
> Could this cause reference counts and memory to leak when dropping skipped
> samples?
> 
> -- Sashiko AI review · https://sashiko.dev/#/ 
> patchset/20260604065519.112101-1-tshah@linux.ibm.com?part=1

