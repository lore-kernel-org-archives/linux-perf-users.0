Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF8233F37F
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959716; cv=none; b=TrhcU2lyI00Zzpj1CrjlSuyqxc9eUpDe7LfBrSoL9oo8CcfLN76/t9lDHowXY10wK6o3hhX4N4jZIQoNomaBVgNkaw3OLVEJ/GeuenHaQriluH3ik9z0h6yvI8ds0pcKt4fNn+zcH5xCwZJtwToBEDJJC7azS1mqp2F+WEgFa6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959716; c=relaxed/simple;
	bh=u9HR0kwCNi/c5Kd24EyCwQJL7OeXt5ilLtWPSbz9PX8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=i2wO7cIkbL2vdCEJjPWNRK4PVbHrJWJ1FtOfOoZMA3i0z2d5WvVLDHN42GEYWhb0RfmA9K/HgxWUxOJkEQ8TRemcoxTxHaecMeJ8nY9NLlK16u2nErzqDFTj0d+HLKp4wYqjo+Nk0qDKlVqp4IkBmuLzGUH2DRnaNV7+icSreGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fnPg8M2D; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fnPg8M2D"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC8FaT0031499
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 15:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=IrVQbWt2GkJ2CNwKZb3LUQHvBSMz
	rkTWCLebhOq7Css=; b=fnPg8M2DUnmBa3QfAGPJSCP+1SrRhNZxYvpQmOuxr8hZ
	xKAjbW8SsN68AHf0i3wBrmV57y0V+33CBi7q21aIicmc9CsplHPTixgCr3j1SUMo
	Bkw/uZ70a13YNU1UYoHXiSZb1IL60mz7RlvY1BI8utDEZ8VFqdet0nst9AKEbiTU
	6rAlb72QcX5nOvoPlM5pHPS9yJnrZFYWg5tmyuAFN/h9dn/np0yixuZp79Qt7Csv
	+GMH43Hx5/CyvG1+HRRqBu8LVoRKyLYOefY0gNEjCYzPEvOkbRMFGTt8zzKmYVp8
	OkA4IBRfL8u+Lr/3/vNsW7VGcu/zRwwaoxZbK9fw8Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wk8b431-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 15:01:54 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ACEj3gF012980
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 15:01:53 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wk8b42v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 15:01:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACDNjNV004779;
	Wed, 12 Nov 2025 15:01:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aagjy0wkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 15:01:52 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ACF1mpW52232588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 15:01:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 916262004B;
	Wed, 12 Nov 2025 15:01:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FF3F20040;
	Wed, 12 Nov 2025 15:01:48 +0000 (GMT)
Received: from [9.152.212.92] (unknown [9.152.212.92])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Nov 2025 15:01:48 +0000 (GMT)
Message-ID: <3e80f453-f015-4f4f-93d3-8df6bb6b3c95@linux.ibm.com>
Date: Wed, 12 Nov 2025 16:01:48 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Ian Rogers <irogers@google.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>
Cc: Jan Polensky <japo@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
From: Thomas Richter <tmricht@linux.ibm.com>
Subject: Test cases metricgroups and metrics fail on s390 zVM guest
Organization: IBM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfX/ISl8Jzozoir
 s/NsGLS2KJDLcju5AKpEJe4Bd2ly6l70mfxPHUGEX6gaapXjVUukagMhtz419Jms1MUqhJkcuQ4
 nEuJCtgCowWlZ/lDguCCcZCgZESyk8thKwRYtdhErolw+c0e/zM7Z8J8bKnyb8tqtKKOEhzcfJd
 3bCbMmZ4VNB8YxfDwA50SxiQlGxg3MFZxq4JCgLJI5j8vmGtyK9rEmQXtNpLdECSKvvPXF8bD79
 fM3x+j3BLQyiOTleDMkhvidiAtpZ2CwfeS8DomLQD+N16PhE9QU1J+5vFLRbEkJhi6454grhOyN
 fYtqI8EwWEUG2WQ9NqwMSSraSPJRhvGGzw8JcOIQLa+B7gZEh94Sue0WGqTOpvC5ZJ/kUzU6TcJ
 gzqTi6gb+nrp5MhTMuWGWSMY6vuCiA==
X-Authority-Analysis: v=2.4 cv=ZK3aWH7b c=1 sm=1 tr=0 ts=6914a162 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EIC64uHD0fn6WoJNI-UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ksJpG5fIlwBSRJ8ctseiQJNb4sNQORCi
X-Proofpoint-GUID: oTwG5ASzdtZb06-2XEd4uuJtFVnEKpfE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022

Hi Ian,

I discovered this strange issue on a z/VM system (linux guest on s390 LPAR).
I use linux-next repo.

root in 🌐 a8345032 in mirror-linux-next/tools/perf on  master [?] via C v15.1.1-gcc
❯ perf test 96
 96: perf all metricgroups test        : FAILED!

root in 🌐 a8345032 in mirror-linux-next/tools/perf on  master [?] via C v15.1.1-gcc
❯ perf test 97
 97: perf all metrics test             : FAILED!

This test works on the linux repo on a z/VM linux guest:
root in 🌐 a8345047 in ~
❯ perf test 95
 95: perf all metricgroups test        : Ok

root in 🌐 a8345047 in ~
❯ perf test 96
 96: perf all metrics test             : Ok

root in 🌐 a8345047 in ~

On both systems I get this:
# ./perf list --raw-dump metric
cpi est_cpi finite_cpi l1mp l2p l3p l4lp l4rp memp prbstate scpl1m tlb_miss \
            tlb_percent transaction

It lists metrics. It is ok when running on an LPAR which has the
CPU Measurement counting facility:

 # ll /sys/devices/cpum_cf/events | wc -l
 106
 #

But on z/VM this facility does not exist:

 # ll  /sys/devices/cpum_cf/events | wc -l
 ls: cannot access '/sys/devices/cpum_cf/events': No such file or directory
 0
 #

Now when I look into the json files for s390, I have the metrics defined
in arch/s390/cf_z16/transaction.json:

  {
    "BriefDescription": "Cycles per Instruction",
    "MetricName": "cpi",
    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS if has_event(INSTRUCTIONS) else 0"
  },

Up to now the has_event(event-name) was sufficient to suppress the metric when
that counter did not exist. At least I thought so.

Now I get this output when I run test case on linux-next repo:
 # ./perf stat -vvvvv -M cpi -- sleep 1
 Using CPUID IBM,3931,703,A01
 metric expr (CPU_CYCLES / INSTRUCTIONS if has_event(INSTRUCTIONS) else 0) for cpi
 parsing metric: (CPU_CYCLES / INSTRUCTIONS if has_event(INSTRUCTIONS) else 0)
 hwmon_pmu: not a hwmon file 'INSTRUCTIONS'
 Attempt to add: cpu/INSTRUCTIONS/
 ..after resolving event: cpu/legacy-hardware-config=0x1/
 INSTRUCTIONS -> cpu/INSTRUCTIONS/
 found event CPU_CYCLES
 found event INSTRUCTIONS
 Parsing metric events '{CPU_CYCLES/metric-id=CPU_CYCLES/,INSTRUCTIONS/metric-id=INSTRUCTIONS/}:W'
 hwmon_pmu: not a hwmon type 'CPU' in file name 'CPU_CYCLES'
 event syntax error: '{CPU_CYCLES/metric-id=CPU_CYCLES/,INSTRUCTIONS/metric-id=INSTRUCTIONS/}:W'
                       \___ Bad event or PMU

 Unable to find PMU or event on a PMU of 'CPU_CYCLES'

Sure it can not find counter named CPU_CYCLES nor INSTRUCTIONS. They are not available.
Isn't the has_event(INSTRUCTIONS) macro sufficient to avoid the calculation at all?
This has worked before.

When I run the same command on z/VM guest with linux repo, I get this:
 # ./perf stat -vvvvv -M cpi -- true
 Using CPUID IBM,3931,703,A01
 metric expr (CPU_CYCLES / INSTRUCTIONS if has_event(INSTRUCTIONS) else 0) for cpi
 parsing metric: (CPU_CYCLES / INSTRUCTIONS if has_event(INSTRUCTIONS) else 0)
 hwmon_pmu: not a hwmon file 'INSTRUCTIONS'
 found event duration_time
 Parsing metric events 'duration_time'
 hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
 Attempt to add: tool/duration_time/
 ..after resolving event: tool/config=0x1/
 duration_time -> tool/duration_time/
 Matched metric-id duration_time to duration_time
 Control descriptor is not initialized
 Opening: duration_time
 ------------------------------------------------------------
 perf_event_attr:
  type                             4294967294 (tool)
  size                             136
  config                           0x1 (duration_time)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
 ------------------------------------------------------------
 duration_time: -1: 471615 1 1
 duration_time: 471615 1 1

 Performance counter stats for 'true':

           471,615      duration_time
 parsing metric: (CPU_CYCLES / INSTRUCTIONS if has_event(INSTRUCTIONS) else 0)
 CPU_CYCLES not found
 INSTRUCTIONS not found
 #     0.00 cpi

       0.000465696 seconds time elapsed

       0.000060000 seconds user
       0.000416000 seconds sys
 #

It has switched to event 'duration time' handled by some dummy tool PMU. I find this
somehow misleading.
Here is the same command without verbose output:
 # perf stat  -M cpi -- true

 Performance counter stats for 'true':

           346,237      duration_time                    #     0.00 cpi

       0.000340752 seconds time elapsed

       0.000056000 seconds user
       0.000303000 seconds sys

At least the CPI metric is 0 because it could not be calculated. This is ok.

And finally when executed on a s390 LPAR it works as intended
 # ./perf stat -M cpi -- true

 Performance counter stats for 'true':

           855,234      CPU_CYCLES                       #     1.42 cpi
           601,676      INSTRUCTIONS

       0.000473961 seconds time elapsed

       0.000063000 seconds user
       0.000491000 seconds sys
 #

Maybe a better place to fix the metric issue is in perf list subcommand.
When counters are not available, do not list the metrics depending on refered
counters? This has to be done at runtime as seen above.
I think the has_event() macros has worked this way some time ago?

Any other ideas or recommendations?
Thanks a lot

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

