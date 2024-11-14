Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DB81917C4;
	Thu, 14 Nov 2024 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598560; cv=none; b=DSb66T7F4hL/fSZr5anG/0uEaDLgeatkh4d3BiO//p7I4PM56+VuO2WhGKTLIhsVHMuKFWeiImJIejS9dr3LHdEsGR4Pc6DcebCcxhFpnIEbzrLGy9JHd5cxnQYuxho8sQZsEqlxIJ0PdTEX5AdQLDgjnq9bmLIDy8BUOJWrlPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598560; c=relaxed/simple;
	bh=Xj/KHcG8gYRHoFDXwCtn2Qr7x9QzlGJfnFMEXKtUlkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f5GXQINF5WxuFmnThF8VqWDSbTmdvHnImVOhIqw5Qa2v8m9SG71Bj930O3Or7TTMtKbuxgbtDvI/iUN7Ll+1wvNBNJ1NNVAAE/l1fDeNBWWl/XeU4PYoAMmPWP/Q8Q4c3j1NHniZBQZKqTdRxcTJQIzqIRcDEy4ZF7nd57hDmho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Yo21kTQN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Yo21kTQN"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEDe26O003948;
	Thu, 14 Nov 2024 15:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4b2WT6
	hUGU3GnqpVa+GvRu7VNTam6UXNHykx/b5eadw=; b=Yo21kTQN4ho/8SwuoJKheu
	T64X4EFy6N6yBR2dlXHyqeOcroHKQf+wtZr7axDu6XZhnRZt3zSSgCbeO3wHlubE
	CnD/V6RqbVbkpE3yqjVQ2/QUBTeBFxpIlgDWz4JHCHdYqLOo2DbM0ErPVHfqa5jy
	IHJ0D4I6ChNS7iAurG8EqHK1KR/JAGZGZTMcAR//OoFOdcpAhUUJRBxCidhFgLtv
	9dQLjRzlsEOS0KrR8F+jLaK91HMAAvcKTCwHbq0mMXalLJdWl+FOgahnB3hriY/n
	dhd17cP3r37d4xaZxpVmxSZgXQ1YSkr6XqPp5Q1VTVNVT/yR7BNEx4BtidhxNrrA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wj9p0hb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 15:35:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AECKQsP002765;
	Thu, 14 Nov 2024 15:34:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42tms18dqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 15:34:10 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AEFY6eT49283368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 15:34:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBD9F20043;
	Thu, 14 Nov 2024 15:34:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C39F20040;
	Thu, 14 Nov 2024 15:34:06 +0000 (GMT)
Received: from [9.152.212.137] (unknown [9.152.212.137])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 Nov 2024 15:34:06 +0000 (GMT)
Message-ID: <ae0f7492-412b-4506-9127-514577b33e7e@linux.ibm.com>
Date: Thu, 14 Nov 2024 16:34:06 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PING PATCH] perf/test: fix perf ftrace test on s390
To: James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        svens@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
References: <20241114090149.1489811-1-tmricht@linux.ibm.com>
 <b107d9a6-48b7-468d-b36e-da9c587b7953@linaro.org>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <b107d9a6-48b7-468d-b36e-da9c587b7953@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NpImJIsF-LnnozRiebymcqmlqhvwmb-i
X-Proofpoint-GUID: NpImJIsF-LnnozRiebymcqmlqhvwmb-i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411140122

On 11/14/24 12:09, James Clark wrote:
> 
> 
> On 14/11/2024 9:01 am, Thomas Richter wrote:
>> On s390 the perf test case ftrace sometimes fails as follows:
>>
>>    # ./perf test ftrace
>>    79: perf ftrace tests    : FAILED!
>>    #
>>
>> The failure depends on the kernel .config file. Some configurarions
>> always work fine, some do not.  The ftrace profile test mostly fails,
>> because the ring buffer was not large enough, and some lines
>> (especially the interesting ones with nanosleep in it) where dropped.
>>
>> To achieve success for all our tested kernel configurations, enlarge
>> the buffer to store the traces complete without wrapping.
>> The default buffer size is too small  for all kernel configurations.
>> Set the buffer size of /sys/kernel/tracing/buffer_size_kb to 16 MB
>>
>>
>> Output after:
>>    # ./perf test ftrace
>>    79: perf ftrace tests     : Ok
>>    #
>>
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>> Suggested-by: Sven Schnelle <svens@linux.ibm.com>
>> ---
>>   tools/perf/tests/shell/ftrace.sh | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/tools/perf/tests/shell/ftrace.sh b/tools/perf/tests/shell/ftrace.sh
>> index a6ee740f0d7e..742d6b8f34d3 100755
>> --- a/tools/perf/tests/shell/ftrace.sh
>> +++ b/tools/perf/tests/shell/ftrace.sh
>> @@ -80,10 +80,21 @@ test_ftrace_profile() {
>>       echo "perf ftrace profile test  [Success]"
>>   }
>>   +if [ "$(uname -m)" = "s390x" ]
>> +then
>> +    ftrace_size=$(cat /sys/kernel/tracing/buffer_size_kb)
>> +    echo 16384 > /sys/kernel/tracing/buffer_size_kb
>> +fi
>> +
> 
> It probably wouldn't be terrible to do this for all platforms to reduce fragmentation. It doesn't do any harm and it only added a few seconds to the test time even on a small Arm box, maybe it will prevent flakes everywhere else in the future. But I don't feel too strongly about this one.
> 
>>   test_ftrace_list
>>   test_ftrace_trace
>>   test_ftrace_latency
>>   test_ftrace_profile
>>   +if [ "$(uname -m)" = "s390x" ]
>> +then
>> +    echo $ftrace_size > /sys/kernel/tracing/buffer_size_kb
>> +fi
>> +
> 
> Restoring the value should be in cleanup() so it works on interrupt too.
> 
> With that:
> 
> Reviewed-by: James Clark <james.clark@linaro.org>
> 

Thanks for your feedback. Will do it and post v2

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
