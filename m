Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98230267F59
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637866; cv=none; b=MZjJuZpDaxmOm9sFpbadgKE9IHn98wQADq23/37gi77HgwUUbQ1SEx6WVB9MymHh4aKvyAt/s5cUTFIR050ZECuMTaKISkRrkW2Dqi++PRc2SlKQTOOn8LN6osPZC0imLXtzyXZ78doTImomK5Iu3NwqnAUPuhqvCOb6EDaPpdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637866; c=relaxed/simple;
	bh=nUazmvD6mqNMpiKJglu3sHLs2k1PHBMidIFT68RkjcE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=BhjH1YDCqGWuYQRfoAgiVJwPvxpSxxb/aVt6QRkPBV27a2OArITk55+3Ztnr8RI5F2HbkhuHbUGl56A6GCWPOegIuF2GtmgTJPmHanU4CkH1wSr2C8gYdqhNYS20DJE9TSOUqrybjE01G6IhVV6ZTvTwh6QtHHnMgE5fvSclKcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BHPUu4iz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BHPUu4iz"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58NBr9gD006772
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 14:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=9jNyllVgn69Ms3EiBsAehiaDjsLB
	cCCoHF4Y1oHLVUw=; b=BHPUu4iz4i+SPwuFFITgBhW5mwuhkbot/fFiZhNtU2cj
	hzTBS0IATNekRVzoQBec4Gqm1s21vwGNvmr+cAXc4/z7dzPNk5Fazw/LdJA+b9rI
	JrqTCjkHnW7eT/S70K81StI4QPpdcqJRNR1lEpA9O/gpD63mWJigbWsCGyk2DIjO
	Um7nJiRDt4rn+D6rMILOBKsPuf/Pb8mtbeEKQkndFr7O/lpjoWv0GQ/7Fu35IEVo
	IG9jxfS2dMAES4WDgpOQTZEsonYBlY994A6CYlzfCtB4o4gHzc75f4Biy4xz6/Tc
	c3Yo0bhSUXcs8seMDolp0Wcq0q55a7FVUsG5sAyNaA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499jpk99jv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 14:31:01 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58NEKoH8023821
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 14:31:01 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499jpk99js-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 14:31:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58NDgFoT013592;
	Tue, 23 Sep 2025 14:31:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a8tjbmd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 14:31:00 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58NEUu1L44695966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Sep 2025 14:30:57 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E11932004F;
	Tue, 23 Sep 2025 14:30:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8C0B2004D;
	Tue, 23 Sep 2025 14:30:56 +0000 (GMT)
Received: from [9.152.212.92] (unknown [9.152.212.92])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Sep 2025 14:30:56 +0000 (GMT)
Message-ID: <9744e7fc-6884-4849-adf0-6c1044bd19b5@linux.ibm.com>
Date: Tue, 23 Sep 2025 16:30:56 +0200
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
        Vasily Gorbik
 <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>
From: Thomas Richter <tmricht@linux.ibm.com>
Subject: Regression on perf stat command on s390 z/VM systems
Organization: IBM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L50dQ/T8 c=1 sm=1 tr=0 ts=68d2af25 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=Ca0GTFGugmhc6tUoCQ4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMCBTYWx0ZWRfX0L3mMtKb89cx
 b4ytMTiK05o0Zljp8p9Z/+Ln+bsHWzRqrTefUcxulkD81iKZ8A6hNbImquBSWSVkxmsoWXKUdNv
 tYgOu5q7/tWa35djbJFVeK55FPrCH2K9BCyn6vYwGjuOdUrf31oW5scKKycnFlK6IFLsMcqvDbQ
 8GOMKKmceD950e00DwsXsaeOBUR1cjqqrCxwUNwOJcp6U5JnofgmeLuOAwQKpG1Fuh7Bn2LuAX5
 IHOvXzZaaoPOrFOHNZtSXcwzD/z8h08Qsc45f4CoWNJK6BaEpMRxQf0cwruA2cvkvLk3p4tqo+s
 ayRQc2tcDkpJREpTxf7WAhJOxJ+jH+4+uxgbQQYgaL5iaHHs1e3HcbxBQHP6VVfOyotxibICNzM
 v4tXyQBc
X-Proofpoint-ORIG-GUID: 3YF_hwR7Foyo7ANAM89PDxjvozdTGHFU
X-Proofpoint-GUID: xnznJytUP_xcdyjV0xKfQoQM0lAUwo4B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200010

On linux-next since tag next-20250917 several test cases fail
on s390 z/VM machines:

 88 perf stat CSV output linter
 91 perf stat JSON output linter
 93 perf stat STD output linter

There are more, all caused by the same issue.
I bisected this down to
commit 9eac5612da1c91 ("perf stat: Don't skip failing group events")

Before this commit the command

 # perf stat -- true
 Performance counter stats for 'true':

           143,936      task-clock                       #    0.333 CPUs utilized
                 0      context-switches                 #    0.000 /sec
                 0      cpu-migrations                   #    0.000 /sec
                43      page-faults                      #  298.744 K/sec
   <not supported>      cycles

       0.000431791 seconds time elapsed

       0.000061000 seconds user
       0.000439000 seconds sys

This is correct. On z/VM a linux guest has no PMU and the event 'cycles'
does not exist. This is shown as 'not supported' and the fall back was
task-clock, a software event. Also the perf stat exit code was 0.

With commit 9eac5612da1c91
that behavior changed:

 # perf stat -- true
 Error:
 The cycles event is not supported.
 # echo exit code $?
 exit code 255
 #

There is no fall back to event task-clock and no further output to
post-process. Also the perf tool now exits with non-zero exit code.

This breaks a lot of test cases.
Was this done on intension? Can we add a fallback to use a software event
cpu-clock or task-clock when the hardware event 'cycles' is not available.

How to proceed with the issue? Any suggestions?

Thanks a lot for your help.
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

