Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55E029E113
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Sep 2025 07:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758266442; cv=none; b=VOyJnaDM2eD6PlFvxAUNHoEiEs49Q6K3xWjYqvGKvQIiRZp2pVBhb8YW7Wk5dzLwo2HGPwnyuzhEYwjp5Z3MHFCeqWNOUhqPbT/6VtwhQoLPRMfmptluZ9sZhY2gB8szllmgQBMWSbhoOvcgzer5XzGC7M7MN3RizhVyn6XSHOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758266442; c=relaxed/simple;
	bh=yiFwlzdG/4ekcGAQ3xVV8Vqc/nCrMqm4/4XTS051e3g=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Tyr882mIYU0W+nDoBLI7s91SGMpoNGIAlfY8v33GW32eU8VAfo3ZLEP2R+AW0eKqOIQS3YuQSp5PpTnncMkOoLzSSIBdIMKxNZRgsUuXdI6VKu7Jzk+4pxUK/sf5I7k0Hj3tolsb9196b0cpPIQnhA5e6O9fXxXwBm//+IvKZZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DmR5wxI3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DmR5wxI3"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58INt6oB031254
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Sep 2025 07:20:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=KG7H1/mvFCqgQzZ96gSg1BpxF7nG
	eeoBU8pIjG0E8YI=; b=DmR5wxI3CR3XC4zekE+Muq4WTBrMymTfAdh/LFXyZdwJ
	23sbr8hnIYQW+F2rgp5V72ppcM2XOlE0Y7hpY/ivt3CVVABgsGm8B/7YqdPi45Oc
	XB3M7az3uuIhvMkfsKzGfddduPs2T+I2dU+A/weDvgR8c4VSNEdlXWSEIDiue9U0
	myldPeCU3GBGTdkMekuvtu0E7NUxHpSf0g9QgTuxLyLB/rdbdw/uPkzZ+wu+hO5p
	EFdcNHGMKckmr9H2Aofl0OCg47AaOC2T5qzEJZ/ErWkAepz2SGgauzuEXxbhmCQR
	ta8T9uImYEqIF2l/PWUVhS6ArYn9j/07GJbRmkz/7A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4hy1q7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Sep 2025 07:20:39 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58J6rUAR014645
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Sep 2025 07:20:39 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4hy1q5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 07:20:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58J6XdII027341;
	Fri, 19 Sep 2025 07:20:38 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495menjmk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 07:20:38 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58J7KaR944696062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 07:20:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B08420040;
	Fri, 19 Sep 2025 07:20:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 330D020043;
	Fri, 19 Sep 2025 07:20:36 +0000 (GMT)
Received: from [9.111.59.58] (unknown [9.111.59.58])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Sep 2025 07:20:36 +0000 (GMT)
Message-ID: <1327f4b0-dbe8-4807-a024-f6f0037ebb4f@linux.ibm.com>
Date: Fri, 19 Sep 2025 09:20:35 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
From: Thomas Richter <tmricht@linux.ibm.com>
Subject: Changed Behavior of perf stat in linux-next
Organization: IBM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4R8ccVWaMaGWMcEevVlpxk1APJWsGhNz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX1NLpgmZebUxl
 MQiUDa7N+0iHSVuD3n/8KK6V9dXAL+uNfvTOQwks+7PFDqdVlULkFwoj6u5v6e42IDq7EbvHH6B
 MlNHXy+BrRmvJFboXoJgPY22jiHXmPkMzG2BQJL3/CvDvrUzj/BUxGAehSU0Wgb4JI9UAey/iH9
 nd0FmoexR1XxBD3vlKKQ7k+HUskWKNpQOuEPJSRkR/rjEzxO/Kq4zTAB9vAx1T1wf/5w0dIUQ3O
 2PR26e2G3MDoXPuyCS8ek7lo/zkJpkqgXe0HfQ3bq/5tg7aEqVKAKySvIroXIIMDZ4uBG3VcbT4
 E0xJEPO0CXLtQnS4ZgL5kOwOSdwiFaaT6CzZnrkN/7EByFUgJVcCySl6LYjYaflaZFD9WwI+pl5
 FqmjHhZM
X-Proofpoint-GUID: s0kgXmYPI84AtfFzdIh-OP8oSGrf5xD7
X-Authority-Analysis: v=2.4 cv=co2bk04i c=1 sm=1 tr=0 ts=68cd0448 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=jMbeAP_MWtstleuaIbsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160204

With latest linux-next (tag next-20250917) I noticed an change in behavior:

1. An undefined event now triggers a different exit code for perf stat
   when the event does not exist:

   Before:
   # perf -v
   perf version 6.14.0-63.fc42.s390x
   # perf stat -e pai_ext/NNPA_ADD/k -- true; echo exit code perf stat: $?

   Performance counter stats for 'true':

   <not supported>      pai_ext/NNPA_ADD/k

       0.001074996 seconds time elapsed

       0.000051000 seconds user
       0.001124000 seconds sys

    exit code perf stat: 0

    After:
    # perf -v
    perf version 6.17.0-20250918.rc6.git0.ae2d20002576.63.fc42.s390x+next
    # perf stat -e pai_ext/NNPA_ADD/k -- sleep; echo exit code perf stat: $?
    event syntax error: 'pai_ext/NNPA_ADD/k'
                         \___ Bad event or PMU

    Unable to find PMU or event on a PMU of 'pai_ext'
    Run 'perf list' for a list of valid events

     Usage: perf stat [<options>] [<command>]

       -e, --event <event>   event selector. use 'perf list' to list available events
    #

    exit code perf stat: 129

A invalid event now triggers a non-zero exit code indicating failure.
    
    
2. An event defined on a system but with unsupported modifier also shows
   different behavior:
   
   Before:
   # perf stat -e pai_ext/NNPA_ADD/k -- sleep 2; echo exit code perf stat: $?

   Performance counter stats for 'sleep 2':

   <not supported>      pai_ext/NNPA_ADD/k

       2.001368389 seconds time elapsed

       0.000140000 seconds user
       0.001187000 seconds sys


    exit code perf stat: 0

    After:
    # perf stat -e pai_ext/NNPA_ADD/k -- sleep 2; echo exit code perf stat: $?
    Error:
    Invalid event (pai_ext/NNPA_ADD/k) in per-thread mode, enable system wide with '-a'.
    exit code perf stat: 255

The good thing is that the process is not started and executed wheh the event
does not exist.

I reckon these changes are intended and will be integrated into mainline kernel?

I am asking because of our Continuious Intergration setup runs on the linux-next
and mainline linux kernel daily and has to handle both behaviors.

Thanks


-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

