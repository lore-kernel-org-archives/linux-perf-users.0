Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9B4392C32;
	Sat, 25 Jul 2026 18:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785003236; cv=none; b=F71BrdRwFoOHvHUFZuG60UxPLQgRfsgCroAb6KGugEv3AesnH/NPkVWcNM23LRA20fUp3RRNd9Hld3BYPQc0KSHXgxbd5qKZVM4R4Vt1zPZOKqZsrYj09VRmFcFdu1e2ZsXEipwpIGfgtgAOg5FpDj/+adLY31YxHvvth4MhS/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785003236; c=relaxed/simple;
	bh=L8tXSqZ7fKXGzqVOIbwHuKAEaU0SMzL4lGodUS6JSpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SshlSvPh1NCKnny1LU6lyCqdJXaBH1Peoy9zgZSDukhvPcEGtvFnF3+q0AFUJdAf4ZNDE8fut2Oqs9DvBWUCaTbzVI4PcjTXC44KYCFy52O90VoN2/hqngGlGyV7Ww9IGWyqBRN5Gei1ipU/5gDzJ9KV6lEdL7zo1VyXNqDdKPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Vgc1uo75; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Vgc1uo75"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PHIKhg1107672;
	Sat, 25 Jul 2026 18:13:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ticQ/D
	Kb2RNy828QpZE4b2hE6OTVRmz0y3itXGIZUw8=; b=Vgc1uo75jqEm0gneFknhdB
	A0nWLzojD72JzaCbrSKJaalMu2clH0HucB9T1XOFx0R9HWDEUkQWnYc9PdSa14dv
	kgbRukTt2eJ2tQMCFxjbpPw/QpbTyUo9HSAybgz8gc9p0SyeIzHJ89fEgQiNlxoD
	TYmnqulVqOfn4BrkjaLaD0tkGo3hEtpRxZ5aQS456aF7nDbYlDy4qss+jUn7GjLW
	fwm5Z193GVCSoPFdNYmWTFCjci4Rw/MvZmYxQr3HDOu44OKgbzkVODbGITait8xy
	itEpJKExblw0nlDBmIATWSAL1oy8Vw1mjQ7V9FJWZpdEgFdv4ixNW+K2UzVNhgpg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0n8xsr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 18:13:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66PIBI7V002416;
	Sat, 25 Jul 2026 18:13:50 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fmn59t3a5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 18:13:50 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66PIDnC232572004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 18:13:49 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27C4958050;
	Sat, 25 Jul 2026 18:13:49 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DED758045;
	Sat, 25 Jul 2026 18:13:46 +0000 (GMT)
Received: from [9.39.22.45] (unknown [9.39.22.45])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 25 Jul 2026 18:13:45 +0000 (GMT)
Message-ID: <af9c6e1b-a506-479c-83ca-5f5e6276042a@linux.ibm.com>
Date: Sat, 25 Jul 2026 23:43:44 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] perf trace-event: Fix infinite loop in skip()
To: sashiko-reviews@lists.linux.dev,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, hbathini@linux.ibm.com,
        Madhavan Srinivasan <maddy@linux.ibm.com>, atrajeev@linux.ibm.com
References: <20260724141316.99507-1-tshah@linux.ibm.com>
 <20260724141316.99507-6-tshah@linux.ibm.com>
 <20260724145711.53ECA1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tanushree Shah <tshah@linux.ibm.com>
In-Reply-To: <20260724145711.53ECA1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDE2OSBTYWx0ZWRfX+ViYWWnvHTcm
 ne2NsMpJRvqS33f4xRfMo6YNqRqQ2abostTupL3XCaoXQEr6JAD/RyrstQPQFxbPdj+XWiK71eK
 0G0ngdAS4k1Cz1NOaxhWa8jJW8IrJew=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDE2OSBTYWx0ZWRfX7+nEbF9q0R2Z
 7+ridormQuAMymG0uDYiXbkJNNpqL5Spx8tyXEEsbR7WKCqu/gKwnHr9xEotn5VCkXfP0Exo6vb
 4epCXBMTHs+wnTOXsARA6A0YGbmX5SZtro3yfkq+iqUQXHf/xdIREP1gmRYsOLPMypwvojOOVGx
 c30Qq8JD+qrVyZnOE4L5DHhwc2E/CdARRtvmWnTr+HXZBD72TV7VLQWhB9vpV81wbJE6rRbwbw9
 4vIQzA3wcoQ8PDZs22Tq+vnupdHYz1EPiwEvnLKlfwAPLqHzdTSiN3HgZa0zfOo++MkjabHgtpE
 zyKDisAt41A77c9/+NwK8FbQeX0/bUa5luSm6h5JRWcFBA4+HaplthbfRuk1hSwtb2p68+8hM7W
 p7MpIngkkktkhwWKpVr5Z6FgTHndDQ5F0zG5bjMF/c1y1JBHQ4ubtYLBks5C7IV8mHoURL8hIcG
 /Y6hp53ucT/AE8+Hi+A==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a64fcdf cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=RUzkzE4iYSZnkJ7L4LEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: NK7GXfxUVGve-ZkdrfRF_7ZUmmRCrJ1X
X-Proofpoint-ORIG-GUID: uao2X-lOok8W3qQ6N6Ss-fWno_3fSOXs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250169

Thanks for the review

On 24/07/26 20:27, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but there is a heap buffer overflow in `read_saved_cmdline()` due to an integer overflow when allocating memory for a buffer based on an untrusted `size`.
> --
> 
> --- Patch [5]: [PATCH v3 5/5] perf trace-event: Fix infinite loop in skip() ---
> commit 31b13f3b8b045b8ed6e1e9aaefa3637fac096e0b
> Author: Tanushree Shah <tshah@linux.ibm.com>
> 
> perf trace-event: Fix infinite loop in skip()
> 
> This patch fixes an infinite loop in skip() where do_read()'s return value
> was ignored. By checking the return value, the loop now breaks correctly on
> failure or EOF.
> 
>> diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
>> index 147a3b95ce06b..529a56c3730fa 100644
>> --- a/tools/perf/util/trace-event-read.c
>> +++ b/tools/perf/util/trace-event-read.c
>> @@ -71,12 +71,16 @@ static ssize_t do_read(void *data, size_t size)
>>   static void skip(size_t size)
>>   {
>>   	char buf[BUFSIZ];
>> -	size_t r;
>> +	ssize_t ret;
>>   
>>   	while (size) {
>> -		r = size > BUFSIZ ? BUFSIZ : size;
>> -		do_read(buf, r);
>> -		size -= r;
>> +		size_t len = size > BUFSIZ ? BUFSIZ : size;
>> +
>> +		ret = do_read(buf, len);
>> +		if (ret <= 0)
>> +			break;
>> +
>> +		size -= ret;
>>   	}
>>   }
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but while reviewing this file I
> noticed a potential heap buffer overflow in read_saved_cmdline() due to an
> integer overflow when allocating memory:
> 
> tools/perf/util/trace-event-read.c:read_saved_cmdline() {
>      ...
> 	size = read8(pevent);
> 	if (!size)
> 		return 0;
> 
> 	buf = malloc(size + 1);
> 	if (buf == NULL) {
> 		pr_debug("memory allocation failure\n");
> 		return -1;
> 	}
> 
> 	ret = do_read(buf, size);
>      ...
> }
> 
> If size is large enough, does size + 1 overflow to 0?
> 
> Could malloc(0) succeed and return a small valid pointer, causing do_read()
> to overflow the buffer with size bytes?
> 
Confirmed, same as noted earlier in this thread ( patch 2 review ).
Will fix it in v4.

