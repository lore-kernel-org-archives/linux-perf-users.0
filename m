Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7295B2E3F7
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Apr 2024 07:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713424016; cv=none; b=gs5rDcHyEQiOOeW8zxT3kuorDtxuEzA+hd7y/saSm3JrvwRxLYMgUQyP37R25pelzC0tSu0Xsi8eu9Jf00j/hcfkM9mZKLUoKp/nCtSfU31V8Hfs+LJY1mtjuEEwixZGJq9c03232vdA6EvIMM9VU8MB0miM/CpPD2ZlpZJZKtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713424016; c=relaxed/simple;
	bh=/1xMua14uhUSHh0fRLAmFDiiD+dWLDPXTYsDUFoNfQE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ReWQC1rCswbMguuRm4j3EpNJgNprkeeV+UJs+F8y/wNeoYE6LHFEe/Om8KgWpx+YgQMGWO2B4W14HiN1SyZbyFIxTambhLmEPX+WSgYLENcQPMTaN1s9qfnkrL2zxRa41wv+9garPTip6PPpI5kDhgiipItQmX1FhCvnbeu8kbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Juejmes/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Juejmes/"
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43I6bUjC016797;
	Thu, 18 Apr 2024 07:06:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=1v12Ne9qoJKceKBv4snVq5wOGJpsGDQVrcodfxT3XCA=;
 b=Juejmes/+KMCzev/0t9ujzNljzE5xaajuvQYdn9t9qVjeWdZOKiOouDNu5c29viRL4of
 bsIQ8UWj8LHPgoxtYPZ+KDD4cUO9Wm6dFKHbH57fhbHR81fQQW7x2zygljsBqgRwIgOq
 tof/Vfb4eZJY6vP4rzelrLPCGAqE64OI0I2/7cx/eGzDwyfj30Vjo2T7+pXNSUV6f1+e
 s94qFZtdKJs25bFx7hNZB79yeavhVF1OiFzzes6PlaUEVd7V1+Ym0/SHJdKgU+er/AGk
 pFKANbk6/Z3rcuT4NLu6xsM6WYlJEteqcuT4AVj2tKtMgEaXb9XjGfhUfBQEXoS5O0qp WA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xjxdhr29a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 07:06:47 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43I76luT017725;
	Thu, 18 Apr 2024 07:06:47 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xjxdhr297-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 07:06:47 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43I4Ene9023572;
	Thu, 18 Apr 2024 07:06:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg5cp98d7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 07:06:45 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43I76fmV33751570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2024 07:06:44 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3E4E20049;
	Thu, 18 Apr 2024 07:06:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 063E02004E;
	Thu, 18 Apr 2024 07:06:40 +0000 (GMT)
Received: from [9.171.66.178] (unknown [9.171.66.178])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Apr 2024 07:06:39 +0000 (GMT)
Message-ID: <5f64efa3-f0c3-4b3e-bd65-479fea375751@linux.ibm.com>
Date: Thu, 18 Apr 2024 12:36:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf test stat_all_pmu.sh: Parse return value of perf
 stat
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Ian Rogers <irogers@google.com>, Veronika Molnarova
 <vmolnaro@redhat.com>,
        linux-perf-users@vger.kernel.org, Michael Petlan <mpetlan@redhat.com>
References: <ZhgpWkUAto8nzvle@x1> <20240415094220.11639-1-vmolnaro@redhat.com>
 <Zh6MUJAGDEHxsAL_@x1>
Content-Language: en-US
From: kajoljain <kjain@linux.ibm.com>
In-Reply-To: <Zh6MUJAGDEHxsAL_@x1>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HokkB_YREYfJaNiYaqcA7BrYNtSQ9OEV
X-Proofpoint-ORIG-GUID: T1KnC_6YMEttbJoUF4m4bCNGDM3YrSGb
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_05,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 bulkscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404180049



On 4/16/24 20:03, Arnaldo Carvalho de Melo wrote:
> On Mon, Apr 15, 2024 at 11:42:20AM +0200, vmolnaro@redhat.com wrote:
>> From: Veronika Molnarova <vmolnaro@redhat.com>
>>
>> With the upstream MR !3916 of commit a381bd3615de6 ('powerpc/hv-gpci:
>> Fix the H_GET_PERF_COUNTER_INFO hcall return value checks') the perf
> 
> Athira/Kajol,
> 
> 	I don't have access to such machines, since you did work on this
> area, could you please take a look and maybe test it?
> 
> 	The upstream patch mentioned is in fact:
> 
>   ad86d7ee43b22aa2 ("powerpc/hv-gpci: Fix the H_GET_PERF_COUNTER_INFO hcall return value checks")
> 
> Thanks,
> 
> - Arnaldo

Hi Arnaldo,
 Sure we will review and test the patch.

Thanks,
Kajol Jain
> 
>> stat for hv_gpci events without required permission set returns an
>> error value of -1 to differentiate the output from the unsupported
>> events. The stat_all_pmu test was designed in a way, that if any
>> command exits with a non-zero value the test exits with an error
>> value without any information provided due to the 'set -e' option.
>>
>> Running stat_all_pmu test on powerpc machine with unsupported hv_gpci
>> event causes failure after the MR as the zero return value was required.
>> The issue propagated upstream as the list of the files that affected perf
>> did not cover the changed files and was updated after the issue was
>> discovered. It was caught by CKI testing where it was triaged to stop
>> blocking further MRs, as most of the powerpc machines do not support
>> some of the hv_gpci events.
>>
>> Remove the 'set -e' option from the test and rework the test case to log
>> the status of the event for better maintainability. Instead of exiting
>> immediately after 'perf stat' ends with a non-zero value, check the
>> return value and output of the 'perf stat' command with the appropriate action.
>>
>> Link to the MR !3916 of commit a381bd3615de6:
>> https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/merge_requests/3916
>>
>> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
>> ---
>>  tools/perf/tests/shell/stat_all_pmu.sh | 36 ++++++++++++++++++--------
>>  1 file changed, 25 insertions(+), 11 deletions(-)
>>
>> diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/shell/stat_all_pmu.sh
>> index c77955419173..d9f0d2100baa 100755
>> --- a/tools/perf/tests/shell/stat_all_pmu.sh
>> +++ b/tools/perf/tests/shell/stat_all_pmu.sh
>> @@ -2,21 +2,35 @@
>>  # perf all PMU test
>>  # SPDX-License-Identifier: GPL-2.0
>>  
>> -set -e
>>  
>>  # Test all PMU events; however exclude parametrized ones (name contains '?')
>>  for p in $(perf list --raw-dump pmu | sed 's/[[:graph:]]\+?[[:graph:]]\+[[:space:]]//g'); do
>> -  echo "Testing $p"
>> -  result=$(perf stat -e "$p" true 2>&1)
>> -  if ! echo "$result" | grep -q "$p" && ! echo "$result" | grep -q "<not supported>" ; then
>> -    # We failed to see the event and it is supported. Possibly the workload was
>> -    # too small so retry with something longer.
>> -    result=$(perf stat -e "$p" perf bench internals synthesize 2>&1)
>> -    if ! echo "$result" | grep -q "$p" ; then
>> -      echo "Event '$p' not printed in:"
>> -      echo "$result"
>> -      exit 1
>> +  echo -n "Testing event '$p' -- "
>> +  stat_output=$(perf stat -e "$p" true 2>&1)
>> +  stat_result=$?
>> +  if echo "$stat_output" | grep -q "$p"; then
>> +    # return value 0 if counters gets printed either if the event is supported or not
>> +    if [ $stat_result -eq 0 ] && ! echo "$stat_output" | grep -q "<not supported>"; then
>> +        echo "supported"
>> +    elif [ $stat_result -eq 0 ]; then
>> +        echo "not supported"
>> +    # return value 255 when the required pemission for the event is not set
>> +    elif [ $stat_result -eq 255 ] && echo "$stat_output" | grep -q "No permission"; then
>> +        echo "no permission to enable"
>> +    # return value 129 when trying to run 'perf stat' with a non-existent event
>> +    elif [ $stat_result -eq 129 ] && echo "$stat_output" | grep -q "Bad event name"; then
>> +        echo "Fail: Bad event name"
>> +        echo "$stat_output"
>> +        exit 1
>> +    else
>> +        echo "Fail: Unknown return value $stat_result"
>> +        echo "$stat_output"
>> +        exit 1
>>      fi
>> +  else
>> +      echo "Fail: Event '$p' not printed in:"
>> +      echo "$stat_output"
>> +      exit 1
>>    fi
>>  done
>>  
>> -- 
>> 2.43.0
>>
> 
