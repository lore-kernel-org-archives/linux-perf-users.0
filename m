Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47B1199252;
	Tue,  5 Aug 2025 11:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754393566; cv=none; b=dxq8LpjGs51EnA+szJO0D2kHvF+SHwG823qnnMtXa3xfp+XrcLH+tGLcIosricNZ/R43FsOqR1MSuM8oM+Rs6PzXKspPMDBKXhKA4u4czuDu+dbf33op9Ut93igr3X+FpBTOBRmeSt/uLMsK649TBRxnfXWfBM/jEiJ974dRMWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754393566; c=relaxed/simple;
	bh=PJAncplnK9eMmsLxJuz0+P03C8UGROQbWeqqN3UzMQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ToV5TKSko6VZ2qgRwQVFd8PLyAiKqsB6CpW8Sql+Nv8wxvFFCJxPC1u+EyzTYEu7t9RsHYOOHjFDWg4+ITN0VpjVubVmvu9pc3mu/m9gKebEFZ8J4N61PCQsNMp+unLT9xo7rhVtVW+2nTQC4TSPifRdvzrgK3NklEOA6L0mJyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m4XVRVXX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m4XVRVXX"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5754tRbX032517;
	Tue, 5 Aug 2025 11:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eQ1jzw
	Pf/KiUVma3uRohwgBm7hzPFhtSjMYpKnrNqSQ=; b=m4XVRVXXoYxjJZ1ZAx7meF
	gEheP2aKImm0AfSmnk9BBVovmmRuv6Q+1UPNfWj2ehZzBVDZ+bnf6HrKJfMpsVPr
	IvkbNwCLwKxfh6u/F5W8FewNb014fDsRxVrJskNiutWFNGEBz3+71RKwxsc6bUpu
	YRJQfR5W0aQYDHmy6ecnLdfrlOyFXy4bXEjZGN4X0nowlTlPLZiVwQuD8YGHOBMG
	ByIqyXOjv9Ngri68l0iiATr1N8t91Zfy8k1xGM/Q7Nr37Elj6jgJxykAjxaFwAsQ
	oAtesNBiNcEgId9iqPBwvNg54311rlL2EfBvQX2aGV5Lb8Cv2bA9Pjp91fxw+Aug
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bbbq1kwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 11:32:28 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 575BRt9k029079;
	Tue, 5 Aug 2025 11:32:28 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bbbq1kwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 11:32:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5759oUI1001928;
	Tue, 5 Aug 2025 11:32:27 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 489y7kt012-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 11:32:27 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 575BWPUT52691390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Aug 2025 11:32:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CD2D2004B;
	Tue,  5 Aug 2025 11:32:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68A0A20043;
	Tue,  5 Aug 2025 11:32:23 +0000 (GMT)
Received: from [9.109.199.41] (unknown [9.109.199.41])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Aug 2025 11:32:23 +0000 (GMT)
Message-ID: <5b4882dc-c90d-409b-8355-45d8b96df93f@linux.ibm.com>
Date: Tue, 5 Aug 2025 17:02:22 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] perf tools kvm: Use "cycles" to sample guest for "kvm
 top" on Intel
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250805004633.135904-1-dapeng1.mi@linux.intel.com>
 <20250805004633.135904-6-dapeng1.mi@linux.intel.com>
 <c1076dbd-de63-4a9e-a097-de0f64c74a95@linux.intel.com>
Content-Language: en-US
From: Aditya Bodkhe <adityab1@linux.ibm.com>
In-Reply-To: <c1076dbd-de63-4a9e-a097-de0f64c74a95@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _MoJ4aat4Ot-0PMLi56g6LVz9OWvPCiU
X-Authority-Analysis: v=2.4 cv=M65NKzws c=1 sm=1 tr=0 ts=6891ebcc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=QyXUC8HyAAAA:8 a=0KsXSfogyGz7DvoAdY4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: SOgYzRraTSqNvNM9V-41DDQT8FbD2o3J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA3OSBTYWx0ZWRfX+NRX8lMAO15B
 Y6QOIKEvHIK+syNKP6win/TRADFeQd6hOgJIjL+mg8fcLnR8DxkupedgFxi/ZJXmfmSrx5hTH99
 /NjlAtPgLtHbY8BvDGhtwgkjp3UD5dBbnMa27xfDqupv3sLUd6jhQA92wl1u1ai2DjqreLJs7Ie
 ap68BHaAkhVSlZaztyazbI2q/eris/qmX8HfgRoZWDf+KN1xPqd/S9p8iC41OALOg39bEnC1UyL
 r1igRqfc3ptKA2kwqhh1oJAsHIwkdAqBBkQMMflYqBuf+UBYPytLVefz6YPwBJsxUP7VmXPQJ5B
 P6VJlGYRnW5nDJcFATxtD1PSGQn3GmOxtR+OF6J0j6GIBEjit+Oa6S6TLVbZNsJMpqMWpIZLJXB
 pG0hq6DMNG/ZusRoSUGFn8+Zzk7B6gi6tdMEP3KFy8s8REcAOaJZFp6TLlqzMpVHxNePA16g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1011 mlxscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050079


On 05/08/25 6:27 am, Mi, Dapeng wrote:
> On 8/5/2025 8:46 AM, Dapeng Mi wrote:
>> As same reason with previous patch, use "cyles" instead of "cycles:P"
>> event by default to sample guest for "perf kvm top" command on Intel
>> platforms.
>>
>> Reported-by: Kevin Tian <kevin.tian@intel.com>
>> Fixes: 634d36f82517 ("perf record: Just use "cycles:P" as the default event")
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>   tools/perf/builtin-kvm.c | 30 +++++++++++++++++++++++++++++-
>>   1 file changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
>> index 7e48d2437710..d72b40f3df12 100644
>> --- a/tools/perf/builtin-kvm.c
>> +++ b/tools/perf/builtin-kvm.c
>> @@ -2075,6 +2075,34 @@ __cmd_buildid_list(const char *file_name, int argc, const char **argv)
>>   	return ret;
>>   }
>>   
>> +static int __cmd_top(int argc, const char **argv)
>> +{
>> +	int i = 0, ret;
>> +	const char **rec_argv;
>> +
>> +	/*
>> +	 * kvm_add_default_arch_event() may add 2 extra options, so
>> +	 * allocate 2 more pointers in adavance.
>> +	 */
>> +	rec_argv = calloc(argc + 2 + 1, sizeof(char *));
>> +	if (!rec_argv)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < argc; i++)
>> +		rec_argv[i] = argv[i];
>> +
>> +	BUG_ON(i != argc);
>> +
>> +	ret = kvm_add_default_arch_event(&i, rec_argv);
>> +	if (ret)
>> +		return -EINVAL;
>> +
>> +	ret = cmd_top(i, rec_argv);
>> +	free(rec_argv);
>> +
>> +	return ret;
>> +}
>> +
>>   int cmd_kvm(int argc, const char **argv)
>>   {
>>   	const char *file_name = NULL;
>> @@ -2135,7 +2163,7 @@ int cmd_kvm(int argc, const char **argv)
>>   	else if (strlen(argv[0]) > 2 && strstarts("diff", argv[0]))
>>   		return cmd_diff(argc, argv);
>>   	else if (!strcmp(argv[0], "top"))
>> -		return cmd_top(argc, argv);
>> +		return __cmd_top(argc, argv);
>>   	else if (strlen(argv[0]) > 2 && strstarts("buildid-list", argv[0]))
>>   		return __cmd_buildid_list(file_name, argc, argv);
>>   #if defined(HAVE_KVM_STAT_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
> This patch would impact powerpc platform as well. Base on the comments
> before kvm_add_default_arch_event() in
> tools/perf/arch/powerpc/util/kvm-stat.c, I suppose powerpc also needs this
> change, otherwise "perf kvm top" command can't sample guest records. But I
> have no any powerpc on my hand, so it's not tested on powerpc platform. Any
> test on powerpc is appreciated. Thanks.
I have powerpc systems . I will test can share the results .
>
>
