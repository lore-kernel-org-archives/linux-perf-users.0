Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF68C3AC01
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 07:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723535499; cv=none; b=lfLL+i68UkobEjgsQOoLxOm+1WnVwEiw9NBzODaEIcT+3asNt/wc5fadgtAGTcdlc0os8Sk7Kq3ReNqeilAwPoR6bmciCBQnzA8V76XwmgApX2MhoRIua565WUOR70Dd96Kw5EQ5Kg8CqdPOZLtOn36qD539f9Elx/BEc2d9rvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723535499; c=relaxed/simple;
	bh=uy7EbA4adCpmBV+XAxZRnyemUj+sq3qJroIknwk7CY8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hNMxvQntzvWg/ea8Lx9zLay2hh+todU/Uatr1+yJ+3zwtd576Ju+MWob3l8meT9tsRo/Vr2+3bWrmtsDIXA7xJlCy3oSEd9l38PowjXaoMNeKd0KO6uE7HWaK5+PdxrGy0IurAboy03/KUyBWFjcISYiP6IRuGpv4A4QYJNde6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=klvrMJ+C; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="klvrMJ+C"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D4nRCL003513;
	Tue, 13 Aug 2024 07:51:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	4lOSm3QcNI38xr730OjvcbzCPOYpBB+fW8uXv6QK19Y=; b=klvrMJ+C/8MkNU2k
	FbBCMbvwlzg/NFfHSfTHDoE6RuWbwQNCpp9l8Z4KOzteHWQM7BnpTZ4KHJ1jkf55
	B/F1vOzXyizAIfdsmlEu6SwumiE8GcoYmELNhupRa/4TxzjRsW4osHME2o2mrKO0
	J7PLrm5AbpnGWsa4dpxf9bxPZfEvGUS5XufExPlDnEtRTvCYrNucj+cb0A+zMzHx
	9VpuyNp+F64szlnXusnYRX16m4ovuMbBGkRm77mOGF68t3zNOZzc5/P+dXra47ej
	dQAuVgluaiQOF38BajouINCpckhy9eKygAPBp9zd5sPIrGL9Bu2q/r6aOgbjZfdy
	BXI9Ng==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wwmpq24a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 07:51:23 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47D7pMtv015653;
	Tue, 13 Aug 2024 07:51:22 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wwmpq244-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 07:51:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47D58FTm029691;
	Tue, 13 Aug 2024 07:51:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40xmrma8q7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 07:51:21 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47D7pIPQ54001996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 07:51:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2777D2004D;
	Tue, 13 Aug 2024 07:51:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A530C2004B;
	Tue, 13 Aug 2024 07:51:15 +0000 (GMT)
Received: from [9.171.86.190] (unknown [9.171.86.190])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Aug 2024 07:51:15 +0000 (GMT)
Message-ID: <e1435347-404e-4ff4-a4b1-c9338a60c8d3@linux.ibm.com>
Date: Tue, 13 Aug 2024 13:21:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf test stat_all_pmu.sh: Parse return value of perf
 stat
To: Arnaldo Carvalho de Melo <acme@kernel.org>, vmolnaro@redhat.com
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com, mpetlan@redhat.com,
        Ian Rogers <irogers@google.com>, Disha Goel <disgoel@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>
References: <Zh6ZEGOfgcEfwha4@x1> <20240429110439.17362-1-vmolnaro@redhat.com>
 <ZjVIQa3JouJde7I1@x1> <ZroKjgWHYwPpvbau@x1>
Content-Language: en-US
From: kajoljain <kjain@linux.ibm.com>
In-Reply-To: <ZroKjgWHYwPpvbau@x1>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WMf9r7kV6ZWy0VWy1cLkniiF6ariiBgZ
X-Proofpoint-GUID: u-KO2xItUGfnfdzox_h8O1_8GR73SZPJ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_12,2024-08-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 mlxscore=0 clxscore=1011 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408130053



On 8/12/24 18:43, Arnaldo Carvalho de Melo wrote:
> On Fri, May 03, 2024 at 05:25:37PM -0300, Arnaldo Carvalho de Melo wrote:
>> On Mon, Apr 29, 2024 at 12:56:24PM +0200, vmolnaro@redhat.com wrote:
>>> From: Veronika Molnarova <vmolnaro@redhat.com>
>>>
>>> With the upstream MR !3916 of commit ad86d7ee43b22aa2 ('powerpc/hv-gpci:
>>> Fix the H_GET_PERF_COUNTER_INFO hcall return value checks') the perf
>>> stat for hv_gpci events without required permission set returns an
>>> error value of -1 to differentiate the output from the unsupported
>>> events. The stat_all_pmu test was designed in a way, that if any
>>> command exits with a non-zero value the test exits with an error
>>> value without any information provided due to the 'set -e' option.
>>
>> Is this v2 or v3? Kajol, can I have your tested-by?
> 
> Oops, Kajol wasn't on the CC list, nor Ian, I'm adding them, maybe Kajol
> can test it on those machines and Ian, who wrote the test can take a
> look, also adding all the perf tools reviewers, as listed in
> MAINTAINERS.
> 
> Thanks,
> 
> - Arnaldo
>  
Hi Veronika,
I checked the patch, code wise patch looks fine to me. I also tested it
on powerpc system.

Just have concern on your commit message, you added below text as part
of your commit message:

It was caught by CKI testing where it was triaged to stop
blocking further MRs, as most of the powerpc machines do not support
some of the hv_gpci events.

The hv-gpci events are supported in pseries system.
And for different power processors, we already have code to include only
supported event as part of perf list.

If you are taking about parametrized events which are skipped in this
testcase, its not that those parametrized events are not supported.
Since testing proper values of the parameters is out of scope of this
script we are skipping those events.

Can you remove that part from commit message? Rest looks fine to me.

Reviewed-by: Kajol Jain <kjain@linux.ibm.com>
Tested-by: Kajol Jain <kjain@linux.ibm.com>

Thanks,
Kajol Jain

>>> Running stat_all_pmu test on powerpc machine with unsupported hv_gpci
>>> event causes failure after the MR as the zero return value was required.
>>> The issue propagated upstream as the list of the files that affected perf
>>> did not cover the changed files and was updated after the issue was
>>> discovered. It was caught by CKI testing where it was triaged to stop
>>> blocking further MRs, as most of the powerpc machines do not support
>>> some of the hv_gpci events.
>>>
>>> Remove the 'set -e' option from the test and rework the test case to log
>>> the status of the event for better maintainability. Instead of exiting
>>> immediately after 'perf stat' ends with a non-zero value, check the
>>> return value and output of the 'perf stat' command with the appropriate action.
>>>
>>> Link to the MR !3916 of commit ad86d7ee43b22aa2:
>>> https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/merge_requests/3916
>>>
>>> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
>>> ---
>>> Fixed the issue with applying due to a fixed comment typo upstream and
>>> added Ian's suggestion for the 'device busy' issue during parallel
>>> testing.
>>>
>>>  tools/perf/tests/shell/stat_all_pmu.sh | 41 ++++++++++++++++++--------
>>>  1 file changed, 29 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/shell/stat_all_pmu.sh
>>> index c77955419173..a75beddda4db 100755
>>> --- a/tools/perf/tests/shell/stat_all_pmu.sh
>>> +++ b/tools/perf/tests/shell/stat_all_pmu.sh
>>> @@ -2,21 +2,38 @@
>>>  # perf all PMU test
>>>  # SPDX-License-Identifier: GPL-2.0
>>>  
>>> -set -e
>>>  
>>>  # Test all PMU events; however exclude parameterized ones (name contains '?')
>>>  for p in $(perf list --raw-dump pmu | sed 's/[[:graph:]]\+?[[:graph:]]\+[[:space:]]//g'); do
>>> -  echo "Testing $p"
>>> -  result=$(perf stat -e "$p" true 2>&1)
>>> -  if ! echo "$result" | grep -q "$p" && ! echo "$result" | grep -q "<not supported>" ; then
>>> -    # We failed to see the event and it is supported. Possibly the workload was
>>> -    # too small so retry with something longer.
>>> -    result=$(perf stat -e "$p" perf bench internals synthesize 2>&1)
>>> -    if ! echo "$result" | grep -q "$p" ; then
>>> -      echo "Event '$p' not printed in:"
>>> -      echo "$result"
>>> -      exit 1
>>> +  echo -n "Testing event '$p' -- "
>>> +  stat_output=$(perf stat -e "$p" true 2>&1)
>>> +  stat_result=$?
>>> +  if echo "$stat_output" | grep -q "$p"; then
>>> +    # return value 0 if counters get printed either if the event is supported or not
>>> +    if [ $stat_result -eq 0 ] && ! echo "$stat_output" | grep -q "<not supported>"; then
>>> +        echo "supported"
>>> +    elif [ $stat_result -eq 0 ]; then
>>> +        echo "not supported"
>>> +    # return value 255 when the required permission for the event is not set
>>> +    elif [ $stat_result -eq 255 ] && echo "$stat_output" | grep -q "No permission"; then
>>> +        echo "no permission to enable"
>>> +    # return value 255 in case of resource busy during parallel testing of events
>>> +    elif [ $stat_result -eq 255 ] && echo "$stat_output" | grep -q "Device or resource busy"; then
>>> +        echo "resource busy"
>>> +    # return value 129 when trying to run 'perf stat' with a non-existent event
>>> +    elif [ $stat_result -eq 129 ] && echo "$stat_output" | grep -q "Bad event name"; then
>>> +        echo "Fail: Bad event name"
>>> +        echo "$stat_output"
>>> +        exit 1
>>> +    else
>>> +        echo "Fail: Unknown return value $stat_result"
>>> +        echo "$stat_output"
>>> +        exit 1
>>>      fi
>>> +  else
>>> +      echo "Fail: Event '$p' not printed in:"
>>> +      echo "$stat_output"
>>> +      exit 1
>>>    fi
>>>  done
>>>  
>>> -- 
>>> 2.43.0
>>>
> 
