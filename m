Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7BC535DB
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Apr 2024 08:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713859307; cv=none; b=erX3+oFYGkrACkEqFLvIMrs8O8pzBzpymbP+nLqwteAcvswXMXdZbQBihBcRtl2v1TcU7aS1iEoUyjosDgeNBEUC9zqyC4ojEN5xtcb7GFWC4QX+5rj54nkRIwNK+06YKj0ZoqPs7y3ca64OMVCBsSQvWOdMZihuuq6ANmSR19k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713859307; c=relaxed/simple;
	bh=pwiUgoLauSeTbXv+iUQlpc67YLX/7BHdobgJvZ6WHcQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MdhrMuMjUB821ZFobMj5f0khc+nuHfh+KHZm8yj3pT6GoSkye+OPdEMZpBZ4GfshmBQktZQYrKvSYXlGWZpZD+zW4NPWDHVOJD8AwTG5Pj3BbWqxZRD6ch5SsAGVmhxarvXq9zq2S64IPUwkqMSUh0v8KM6Tm4faHWQpvap1Ayo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qRJGl+uQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qRJGl+uQ"
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43N7h9cX008235;
	Tue, 23 Apr 2024 08:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=7VYY7nHXfQpYPl0YdJBRlUJdiFR/nJys66cGw1SmE6w=;
 b=qRJGl+uQeQUWINzQaNijKHDOHrlDDvSKGUZ1A14dlr0lmzTq9eMZFQL7vGuIp7NEHlwJ
 YcfmyIJNZ0apiowziORrTHLTZ0tZ0nH0Kqbt9D140wYjHleF+GQhDmYck06DrqdaFpob
 kERc84ZrUSY/nft87yOpz+/7yA6t2ImsOHZCCdytEEvgkDEZBGh2kiGXCkUj11qojNLU
 ivRI3ewtPcOdyDMiveXZ0T8S0FrlW3wMyafh+y05R6mn52v+TcqkAy19KqpLOwA97QTd
 Tlmxmnr4ouLde35x61n9p93uJ5Gd37JMqlbA4R0SGcmsmCbTxuMbepemyWkKwRwRQx8C oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xp8ucr1ep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 08:01:34 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43N81XSh009458;
	Tue, 23 Apr 2024 08:01:34 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xp8ucr1ej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 08:01:33 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43N5JF7l028653;
	Tue, 23 Apr 2024 08:01:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmtr2byb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 08:01:33 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43N81T5l25035402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 08:01:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CE1F20040;
	Tue, 23 Apr 2024 08:01:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC66820043;
	Tue, 23 Apr 2024 08:01:27 +0000 (GMT)
Received: from [9.171.64.17] (unknown [9.171.64.17])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Apr 2024 08:01:27 +0000 (GMT)
Message-ID: <89dfc623-e583-437f-812f-d2a40dc42611@linux.ibm.com>
Date: Tue, 23 Apr 2024 13:31:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf test stat_all_pmu.sh: Parse return value of perf
 stat
Content-Language: en-US
To: vmolnaro@redhat.com, linux-perf-users@vger.kernel.org, acme@kernel.org,
        acme@redhat.com
Cc: mpetlan@redhat.com
References: <ZhgpWkUAto8nzvle@x1> <20240415094220.11639-1-vmolnaro@redhat.com>
From: kajoljain <kjain@linux.ibm.com>
In-Reply-To: <20240415094220.11639-1-vmolnaro@redhat.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: z-6ihpXbNDGmKqZORYuG9XxAf5PUz-_t
X-Proofpoint-GUID: vo-ZgaOaxBybC5sdCF1HKxR8KsQT5TNN
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_04,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404230022

Hi Veronika,
   I was trying to test this patch. But I am not able to apply this
patch cleanly on both upstream and acme's tmp.perf-tools-next branch.

error: patch failed: tools/perf/tests/shell/stat_all_pmu.sh:2
error: tools/perf/tests/shell/stat_all_pmu.sh: patch does not apply

Can you check that part, but since its simple change I added it manually
and could test the patch.

Patch looks fine to me. I tested it by disabling hv-gpci events in HMC

Without patch changes:

localhost:/dev/shm/linux/tools/perf # ./perf test 95 -vv
 95: perf all PMU test:
--- start ---
test child forked, pid 2234
---
Testing cpu/stalled-cycles-frontend/
Testing
hv_gpci/system_hypervisor_times_time_spent_managing_partitions_over_entitlement/
---- end(-1) ----
 95: perf all PMU test                                               :
FAILED!

with patch changes:

Testing event
'hv_gpci/system_hypervisor_times_time_spent_managing_partitions_over_entitlement/'
-- no permission to enable
Testing event
'hv_gpci/system_hypervisor_times_time_spent_on_system_management/' -- no
permission to enable
Testing event
'hv_gpci/system_hypervisor_times_time_spent_processing_virtual_processor_timers/'
-- no permission to enable
Testing event
'hv_gpci/system_hypervisor_times_time_spent_to_dispatch_virtual_processors/'
-- no permission to enable
Testing event
'hv_gpci/system_tlbie_count_and_time_time_spent_issuing_tlbies/' -- no
permission to enable
Testing event
'hv_gpci/system_tlbie_count_and_time_tlbie_instructions_issued/' -- no
permission to enable
Testing event 'pm_br_mpred_cmpl' -- supported

On 4/15/24 15:12, vmolnaro@redhat.com wrote:
> From: Veronika Molnarova <vmolnaro@redhat.com>
> 
> With the upstream MR !3916 of commit a381bd3615de6 ('powerpc/hv-gpci:
> Fix the H_GET_PERF_COUNTER_INFO hcall return value checks') the perf
> stat for hv_gpci events without required permission set returns an
> error value of -1 to differentiate the output from the unsupported
> events. The stat_all_pmu test was designed in a way, that if any
> command exits with a non-zero value the test exits with an error
> value without any information provided due to the 'set -e' option.
> 
> Running stat_all_pmu test on powerpc machine with unsupported hv_gpci
> event causes failure after the MR as the zero return value was required.
> The issue propagated upstream as the list of the files that affected perf
> did not cover the changed files and was updated after the issue was
> discovered. It was caught by CKI testing where it was triaged to stop
> blocking further MRs, as most of the powerpc machines do not support
> some of the hv_gpci events.
> 
> Remove the 'set -e' option from the test and rework the test case to log
> the status of the event for better maintainability. Instead of exiting
> immediately after 'perf stat' ends with a non-zero value, check the
> return value and output of the 'perf stat' command with the appropriate action.
> 
> Link to the MR !3916 of commit a381bd3615de6:
> https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/merge_requests/3916
> 
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> ---
>  tools/perf/tests/shell/stat_all_pmu.sh | 36 ++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/shell/stat_all_pmu.sh
> index c77955419173..d9f0d2100baa 100755
> --- a/tools/perf/tests/shell/stat_all_pmu.sh
> +++ b/tools/perf/tests/shell/stat_all_pmu.sh
> @@ -2,21 +2,35 @@
>  # perf all PMU test
>  # SPDX-License-Identifier: GPL-2.0
>  
> -set -e

It will create extra blank line can you remove that. Also make sure to
test the patch with checkpatch script to avoid any format issue.

Thanks,
Kajol Jain

>  
>  # Test all PMU events; however exclude parametrized ones (name contains '?')
>  for p in $(perf list --raw-dump pmu | sed 's/[[:graph:]]\+?[[:graph:]]\+[[:space:]]//g'); do
> -  echo "Testing $p"
> -  result=$(perf stat -e "$p" true 2>&1)
> -  if ! echo "$result" | grep -q "$p" && ! echo "$result" | grep -q "<not supported>" ; then
> -    # We failed to see the event and it is supported. Possibly the workload was
> -    # too small so retry with something longer.
> -    result=$(perf stat -e "$p" perf bench internals synthesize 2>&1)
> -    if ! echo "$result" | grep -q "$p" ; then
> -      echo "Event '$p' not printed in:"
> -      echo "$result"
> -      exit 1
> +  echo -n "Testing event '$p' -- "
> +  stat_output=$(perf stat -e "$p" true 2>&1)
> +  stat_result=$?
> +  if echo "$stat_output" | grep -q "$p"; then
> +    # return value 0 if counters gets printed either if the event is supported or not
> +    if [ $stat_result -eq 0 ] && ! echo "$stat_output" | grep -q "<not supported>"; then
> +        echo "supported"
> +    elif [ $stat_result -eq 0 ]; then
> +        echo "not supported"
> +    # return value 255 when the required pemission for the event is not set
> +    elif [ $stat_result -eq 255 ] && echo "$stat_output" | grep -q "No permission"; then
> +        echo "no permission to enable"
> +    # return value 129 when trying to run 'perf stat' with a non-existent event
> +    elif [ $stat_result -eq 129 ] && echo "$stat_output" | grep -q "Bad event name"; then
> +        echo "Fail: Bad event name"
> +        echo "$stat_output"
> +        exit 1
> +    else
> +        echo "Fail: Unknown return value $stat_result"
> +        echo "$stat_output"
> +        exit 1
>      fi
> +  else
> +      echo "Fail: Event '$p' not printed in:"
> +      echo "$stat_output"
> +      exit 1
>    fi
>  done
>  
