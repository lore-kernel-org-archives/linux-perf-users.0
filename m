Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C914E6E2AE;
	Mon, 30 Sep 2024 12:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699450; cv=none; b=nE2WA8O6+a4OzN7X8GlPazRpVmqTUdk/imt4BhU+muqwlIhvv3vW84haiMkUHCyCU4YQHJvxfdEDZVKnlnJTI334x+tCSJcALZybpKd2wzqsNO1UwYKzs5HS2+uikIfn5qR6sDmaQ01/+t4k5XLbmxXdeaqETHECuRIl/FX/WOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699450; c=relaxed/simple;
	bh=lrwzHDxyr0IEWnziBhIgR6eOugPrQ9ZiwGcAgzChxLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UUnrAX6OQjZQ1hnWuZ4yCgKyJGT8FqiVxU1ShfBXf1VAvb2E9RXWSNtWKn7dYLPsPRZhCmWVWSCQsCW7WoladpI0Up/q/xGie7ZjHGdaT9iWHu9QJ/uVhVRScExWVcLdkR02rL9wbVSMOpbAbTan9HDI2dQPhRZ7Mdu7lfPmFn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mf/ya+3M; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mf/ya+3M"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UB5XqC032105;
	Mon, 30 Sep 2024 12:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=j
	PxGfsnpZeiFOfgHcppvK306lmyAbucIpGLnwRY0JMY=; b=Mf/ya+3MZBPD9XHkr
	HcTMY4On+q4fZw8f4SVVTfhue83GZrJHlVaNuMsFo2TD9qp1+7ORwJ3tU9r6N2yv
	kEypfRJ9UvisD5K5KtPiy+wc6um153TlsxSoIonCm9rm2M3/gAIWLGkmOuyoKBGu
	anWdD7rth5s15JqerkDw6+1kmv6yNkoSvlYoOO0dtdwHPKdz8coTP1KWz8/wb/Kh
	Z2GZw7+VLoEK52OvwNHt/g2UpkiUO07f1INz5bLk22/lpMILHiwGn26tpGo994Hn
	lTyMHmKg0uI3/ik/iTEvs33DS8Zf7zDexg97ooacW1HUI74kgHeGXJaZsg488k8G
	GccjQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9f81at6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 12:30:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UAEPsu020407;
	Mon, 30 Sep 2024 12:30:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xv4rxp8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 12:30:43 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48UCUdT836962576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 12:30:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD9B42004B;
	Mon, 30 Sep 2024 12:30:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7498120040;
	Mon, 30 Sep 2024 12:30:39 +0000 (GMT)
Received: from [9.171.21.158] (unknown [9.171.21.158])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Sep 2024 12:30:39 +0000 (GMT)
Message-ID: <3b65e3cc-2a9f-4427-a327-7e920ec4d969@linux.ibm.com>
Date: Mon, 30 Sep 2024 14:30:39 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/test: perf test 86 fails on s390 repo linux-next
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, hca@linux.ibm.com
References: <20240916125718.3024270-1-tmricht@linux.ibm.com>
 <ZvXjYOWoEIhakz-f@google.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <ZvXjYOWoEIhakz-f@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pS9wgU-MXH07a_UIc1O1TpP99g-Va-NT
X-Proofpoint-ORIG-GUID: pS9wgU-MXH07a_UIc1O1TpP99g-Va-NT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_10,2024-09-27_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 adultscore=0 mlxscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300087

On 9/27/24 00:42, Namhyung Kim wrote:
> Hello,
> 
> On Mon, Sep 16, 2024 at 02:57:18PM +0200, Thomas Richter wrote:
>> Command perf test 86 fails on s390 using linux-next repository:
>>  # perf test -F 86
>>  ping 868299 [007] 28248.013596: probe_libc:inet_pton_1: (3ff95948020)
>>  3ff95948020 inet_pton+0x0 (inlined)
>>  3ff9595e6e7 text_to_binary_address+0x1007 (inlined)
>>  3ff9595e6e7 gaih_inet+0x1007 (inlined)
>>  FAIL: expected backtrace entry \
>> 	 "main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
>> 	 got "3ff9595e6e7 gaih_inet+0x1007 (inlined)"
>>  86: probe libc's inet_pton & backtrace it with ping  : FAILED!
>>  #
>>
>> The root cause is a new stack layout, some functions have been added
>> as seen below. Add text_to_binary_address and friends to the
>> list of expected functions.
>>
>>  # perf script | tac | grep -m1 '^ping' -B9 | tac
>>  ping  866856 [007] 25979.494921: probe_libc:inet_pton: (3ff8ec48020)
>> 	     3ff8ec48020 inet_pton+0x0 (inlined)
>> 	     3ff8ec5e6e7 text_to_binary_address+0x1007 (inlined)
>> 	     3ff8ec5e6e7 gaih_inet+0x1007 (inlined)
>> 	     3ff8ec5e6e7 getaddrinfo+0x1007 (/usr/lib64/libc.so.6)
>> 	     2aa3fe04bf5 main+0xff5 (/usr/bin/ping)
>> 	     3ff8eb34a5b __libc_start_call_main+0x8b (/usr/lib64/libc.so.6)
>> 	     3ff8eb34b5d __libc_start_main@GLIBC_2.2+0xad (inlined)
>> 	     2aa3fe06a1f [unknown] (/usr/bin/ping)
> 
> Is it because of a kernel change?  What about old kernels then?
> 
>>
>>  #
>>
>> Output after:
>>  # perf test -F 86
>>  86: probe libc's inet_pton & backtrace it with ping  : Ok
>>  #
>>
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>> ---
>>  tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
>> index f38c8ead0b03..bc6e2fe1d999 100755
>> --- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
>> +++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
>> @@ -40,6 +40,8 @@ trace_libc_inet_pton_backtrace() {
>>  	case "$(uname -m)" in
>>  	s390x)
>>  		eventattr='call-graph=dwarf,max-stack=4'
>> +		echo "text_to_binary_address\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
>> +		echo "gaih_inet\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
> 
> Is it possible to make it this part conditional and only have it for the
> new kernels?
> 
> Thanks,
> Namhyung
> 
> 
>>

I think this is more related to glibc and has nothing to do with the kernel version.
It happened after I did a dnf update.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

